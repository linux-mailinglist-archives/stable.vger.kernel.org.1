Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FC272C13A
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbjFLK5g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbjFLK5X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA3A55B5
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD10C62431
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9914C433EF;
        Mon, 12 Jun 2023 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566703;
        bh=9hFV++v1iCjt+Jv9I1R5kZETuaDn4uvl7jZZhVrqWQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rbCcY8wGKjMC7LxDkssB/e3yVztvOuhW1234Z62a9BaJHWbTzNpRJIQ0HeKHsnUKV
         8P5MWXXBp1RMWq0MJc1toGUDkYq+vhJp3Xp1OSC5ltgIzdJDr0G/aVj/lDUf3FdB67
         tpcUz3X/5bCWujdwvQR7XvnU+rg8wI2fVkq8yjR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chih-Yen Chang <cc85nod@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 125/132] ksmbd: fix out-of-bound read in deassemble_neg_contexts()
Date:   Mon, 12 Jun 2023 12:27:39 +0200
Message-ID: <20230612101715.899815548@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

commit f1a411873c85b642f13b01f21b534c2bab81fc1b upstream.

The check in the beginning is
`clen + sizeof(struct smb2_neg_context) <= len_of_ctxts`,
but in the end of loop, `len_of_ctxts` will subtract
`((clen + 7) & ~0x7) + sizeof(struct smb2_neg_context)`, which causes
integer underflow when clen does the 8 alignment. We should use
`(clen + 7) & ~0x7` in the check to avoid underflow from happening.

Then there are some variables that need to be declared unsigned
instead of signed.

[   11.671070] BUG: KASAN: slab-out-of-bounds in smb2_handle_negotiate+0x799/0x1610
[   11.671533] Read of size 2 at addr ffff888005e86cf2 by task kworker/0:0/7
...
[   11.673383] Call Trace:
[   11.673541]  <TASK>
[   11.673679]  dump_stack_lvl+0x33/0x50
[   11.673913]  print_report+0xcc/0x620
[   11.674671]  kasan_report+0xae/0xe0
[   11.675171]  kasan_check_range+0x35/0x1b0
[   11.675412]  smb2_handle_negotiate+0x799/0x1610
[   11.676217]  ksmbd_smb_negotiate_common+0x526/0x770
[   11.676795]  handle_ksmbd_work+0x274/0x810
...

Cc: stable@vger.kernel.org
Signed-off-by: Chih-Yen Chang <cc85nod@gmail.com>
Tested-by: Chih-Yen Chang <cc85nod@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -979,13 +979,13 @@ static void decode_sign_cap_ctxt(struct
 
 static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 				      struct smb2_negotiate_req *req,
-				      int len_of_smb)
+				      unsigned int len_of_smb)
 {
 	/* +4 is to account for the RFC1001 len field */
 	struct smb2_neg_context *pctx = (struct smb2_neg_context *)req;
 	int i = 0, len_of_ctxts;
-	int offset = le32_to_cpu(req->NegotiateContextOffset);
-	int neg_ctxt_cnt = le16_to_cpu(req->NegotiateContextCount);
+	unsigned int offset = le32_to_cpu(req->NegotiateContextOffset);
+	unsigned int neg_ctxt_cnt = le16_to_cpu(req->NegotiateContextCount);
 	__le32 status = STATUS_INVALID_PARAMETER;
 
 	ksmbd_debug(SMB, "decoding %d negotiate contexts\n", neg_ctxt_cnt);
@@ -999,7 +999,7 @@ static __le32 deassemble_neg_contexts(st
 	while (i++ < neg_ctxt_cnt) {
 		int clen, ctxt_len;
 
-		if (len_of_ctxts < sizeof(struct smb2_neg_context))
+		if (len_of_ctxts < (int)sizeof(struct smb2_neg_context))
 			break;
 
 		pctx = (struct smb2_neg_context *)((char *)pctx + offset);
@@ -1054,9 +1054,8 @@ static __le32 deassemble_neg_contexts(st
 		}
 
 		/* offsets must be 8 byte aligned */
-		clen = (clen + 7) & ~0x7;
-		offset = clen + sizeof(struct smb2_neg_context);
-		len_of_ctxts -= clen + sizeof(struct smb2_neg_context);
+		offset = (ctxt_len + 7) & ~0x7;
+		len_of_ctxts -= offset;
 	}
 	return status;
 }


