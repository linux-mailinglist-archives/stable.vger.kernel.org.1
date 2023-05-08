Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36EE6FA463
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjEHJ6s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjEHJ6r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:58:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D022B173
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58F3961562
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6725AC433D2;
        Mon,  8 May 2023 09:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539924;
        bh=3l+2yfPSP4q6piu741EAbFHe9i9fYO/09QCyVqVIG3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSP0mSFn97EMzRonWfwqTMe60scFTyQ1tC//QCUAZe1d4I0dNseUVrMFNMx1+VTP9
         BOyXCWaiE3UUnd0G37sSa6iCYkCEZ5d25X2n6NAfsMJcUXvkA+L2oUHyA1a4Lt46I3
         s4FoaH0zyZ1S8pv8ZeJu62LYmLqturjgbco7O0n8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 182/611] virt/coco/sev-guest: Double-buffer messages
Date:   Mon,  8 May 2023 11:40:24 +0200
Message-Id: <20230508094428.276499981@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dionna Glaze <dionnaglaze@google.com>

[ Upstream commit 965006103a14703cc42043bbf9b5e0cdf7a468ad ]

The encryption algorithms read and write directly to shared unencrypted
memory, which may leak information as well as permit the host to tamper
with the message integrity. Instead, copy whole messages in or out as
needed before doing any computation on them.

Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230214164638.1189804-3-dionnaglaze@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 27 +++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 741d12f75726c..9e172f66a8edb 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -46,7 +46,15 @@ struct snp_guest_dev {
 
 	void *certs_data;
 	struct snp_guest_crypto *crypto;
+	/* request and response are in unencrypted memory */
 	struct snp_guest_msg *request, *response;
+
+	/*
+	 * Avoid information leakage by double-buffering shared messages
+	 * in fields that are in regular encrypted memory.
+	 */
+	struct snp_guest_msg secret_request, secret_response;
+
 	struct snp_secrets_page_layout *layout;
 	struct snp_req_data input;
 	u32 *os_area_msg_seqno;
@@ -268,14 +276,17 @@ static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
 static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
 {
 	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_guest_msg *resp = snp_dev->response;
-	struct snp_guest_msg *req = snp_dev->request;
+	struct snp_guest_msg *resp = &snp_dev->secret_response;
+	struct snp_guest_msg *req = &snp_dev->secret_request;
 	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
 	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
 
 	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
 		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
 
+	/* Copy response from shared memory to encrypted memory. */
+	memcpy(resp, snp_dev->response, sizeof(*resp));
+
 	/* Verify that the sequence counter is incremented by 1 */
 	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
 		return -EBADMSG;
@@ -299,7 +310,7 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
 			void *payload, size_t sz)
 {
-	struct snp_guest_msg *req = snp_dev->request;
+	struct snp_guest_msg *req = &snp_dev->secret_request;
 	struct snp_guest_msg_hdr *hdr = &req->hdr;
 
 	memset(req, 0, sizeof(*req));
@@ -419,13 +430,21 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	if (!seqno)
 		return -EIO;
 
+	/* Clear shared memory's response for the host to populate. */
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
-	/* Encrypt the userspace provided payload */
+	/* Encrypt the userspace provided payload in snp_dev->secret_request. */
 	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
 	if (rc)
 		return rc;
 
+	/*
+	 * Write the fully encrypted request to the shared unencrypted
+	 * request page.
+	 */
+	memcpy(snp_dev->request, &snp_dev->secret_request,
+	       sizeof(snp_dev->secret_request));
+
 	rc = __handle_guest_request(snp_dev, exit_code, fw_err);
 	if (rc) {
 		if (rc == -EIO && *fw_err == SNP_GUEST_REQ_INVALID_LEN)
-- 
2.39.2



