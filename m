Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF0273E784
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjFZSP7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFZSP6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:15:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD91C4
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:15:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5F5060F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28E8C433C8;
        Mon, 26 Jun 2023 18:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803357;
        bh=14opGvk+C9k5vMdT9tKTHa0Z85aOQZiJkcVm5DoU6jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xxP1LrlG+E9p9Vpz6HpdEMu1kzxs0nEaO1oOqwACSOCJMg8rbYE7xd068bbDNE6Ui
         T7FUi84WojeMpq7wjsHICuc0w0pZYLeNV7hh+JfX+b87lnQsbMiX5fiGDvEXf1sWMX
         jFNKGwaZazhgnQrrOjEPdKIjQt8zLZhhYYBrMnqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 6.3 009/199] ksmbd: fix out-of-bound read in smb2_write
Date:   Mon, 26 Jun 2023 20:08:35 +0200
Message-ID: <20230626180806.056931954@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

commit 5fe7f7b78290638806211046a99f031ff26164e1 upstream.

ksmbd_smb2_check_message doesn't validate hdr->NextCommand. If
->NextCommand is bigger than Offset + Length of smb2 write, It will
allow oversized smb2 write length. It will cause OOB read in smb2_write.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21164
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2misc.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -351,10 +351,16 @@ int ksmbd_smb2_check_message(struct ksmb
 	int command;
 	__u32 clc_len;  /* calculated length */
 	__u32 len = get_rfc1002_len(work->request_buf);
-	__u32 req_struct_size;
+	__u32 req_struct_size, next_cmd = le32_to_cpu(hdr->NextCommand);
 
-	if (le32_to_cpu(hdr->NextCommand) > 0)
-		len = le32_to_cpu(hdr->NextCommand);
+	if ((u64)work->next_smb2_rcv_hdr_off + next_cmd > len) {
+		pr_err("next command(%u) offset exceeds smb msg size\n",
+				next_cmd);
+		return 1;
+	}
+
+	if (next_cmd > 0)
+		len = next_cmd;
 	else if (work->next_smb2_rcv_hdr_off)
 		len -= work->next_smb2_rcv_hdr_off;
 


