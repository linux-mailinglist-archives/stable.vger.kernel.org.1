Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AF6726DEF
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjFGUqr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjFGUqV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:46:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A71BE2
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85E7D6469D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5E3C433EF;
        Wed,  7 Jun 2023 20:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170773;
        bh=dCmjU8a/pA3kz0P+cb32Va/IOaqV9yVU+2AyM1JKAkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DITBmcw1m9g+4aQjZSfHw9eAkeRgjT7S8aX1r8ruYD2k8JCFJ9iGJj/pd06CzHyQX
         NUrSjRTfsr8tLTJ7lZCcIZOm6OklPE6G9X4f2Jxym82kivFyAlYH4skR1rvo/sfMxb
         7SZROCiGVEfqimouMmQfgKOIS/CsdlDFxsFZP7OI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuan-Ting Chen <h3xrabbit@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 211/225] ksmbd: fix slab-out-of-bounds read in smb2_handle_negotiate
Date:   Wed,  7 Jun 2023 22:16:44 +0200
Message-ID: <20230607200921.270154809@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kuan-Ting Chen <h3xrabbit@gmail.com>

commit d738950f112c8f40f0515fe967db998e8235a175 upstream.

Check request_buf length first to avoid out-of-bounds read by
req->DialectCount.

[ 3350.990282] BUG: KASAN: slab-out-of-bounds in smb2_handle_negotiate+0x35d7/0x3e60
[ 3350.990282] Read of size 2 at addr ffff88810ad61346 by task kworker/5:0/276
[ 3351.000406] Workqueue: ksmbd-io handle_ksmbd_work
[ 3351.003499] Call Trace:
[ 3351.006473]  <TASK>
[ 3351.006473]  dump_stack_lvl+0x8d/0xe0
[ 3351.006473]  print_report+0xcc/0x620
[ 3351.006473]  kasan_report+0x92/0xc0
[ 3351.006473]  smb2_handle_negotiate+0x35d7/0x3e60
[ 3351.014760]  ksmbd_smb_negotiate_common+0x7a7/0xf00
[ 3351.014760]  handle_ksmbd_work+0x3f7/0x12d0
[ 3351.014760]  process_one_work+0xa85/0x1780

Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1069,16 +1069,16 @@ int smb2_handle_negotiate(struct ksmbd_w
 		return rc;
 	}
 
-	if (req->DialectCount == 0) {
-		pr_err("malformed packet\n");
+	smb2_buf_len = get_rfc1002_len(work->request_buf);
+	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
+	if (smb2_neg_size > smb2_buf_len) {
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		rc = -EINVAL;
 		goto err_out;
 	}
 
-	smb2_buf_len = get_rfc1002_len(work->request_buf);
-	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
-	if (smb2_neg_size > smb2_buf_len) {
+	if (req->DialectCount == 0) {
+		pr_err("malformed packet\n");
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		rc = -EINVAL;
 		goto err_out;


