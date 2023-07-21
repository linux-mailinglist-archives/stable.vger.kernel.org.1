Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBCB75D3CF
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjGUTOp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjGUTOo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:14:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BA930EA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB96561D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096B0C433C9;
        Fri, 21 Jul 2023 19:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966881;
        bh=8kb1Y7EZC3A2SX2lHu4hFXa2Y5W3q45OguU46MGspDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8ca9bASZ9Z/fyiTXlW0qO+K86mvs9SPci0BJJP5pnFueccq52hvLPGs7/SGoSQWl
         dnjgE6z+C15svxEcllCMTdBeohc+Ti1mvaOWgytYSk+UHlISx/ziqZATiKohtJzZ8o
         Q5aXHYDGl8y7BkAllpc8C0MRaWL+Rl4Rrwqhdcuo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thelford Williams <thelford@google.com>,
        Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 5.15 499/532] libceph: harden msgr2.1 frame segment length checks
Date:   Fri, 21 Jul 2023 18:06:43 +0200
Message-ID: <20230721160641.654530845@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

commit a282a2f10539dce2aa619e71e1817570d557fc97 upstream.

ceph_frame_desc::fd_lens is an int array.  decode_preamble() thus
effectively casts u32 -> int but the checks for segment lengths are
written as if on unsigned values.  While reading in HELLO or one of the
AUTH frames (before authentication is completed), arithmetic in
head_onwire_len() can get duped by negative ctrl_len and produce
head_len which is less than CEPH_PREAMBLE_LEN but still positive.
This would lead to a buffer overrun in prepare_read_control() as the
preamble gets copied to the newly allocated buffer of size head_len.

Cc: stable@vger.kernel.org
Fixes: cd1a677cad99 ("libceph, ceph: implement msgr2.1 protocol (crc and secure modes)")
Reported-by: Thelford Williams <thelford@google.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/messenger_v2.c |   41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -391,6 +391,8 @@ static int head_onwire_len(int ctrl_len,
 	int head_len;
 	int rem_len;
 
+	BUG_ON(ctrl_len < 0 || ctrl_len > CEPH_MSG_MAX_CONTROL_LEN);
+
 	if (secure) {
 		head_len = CEPH_PREAMBLE_SECURE_LEN;
 		if (ctrl_len > CEPH_PREAMBLE_INLINE_LEN) {
@@ -409,6 +411,10 @@ static int head_onwire_len(int ctrl_len,
 static int __tail_onwire_len(int front_len, int middle_len, int data_len,
 			     bool secure)
 {
+	BUG_ON(front_len < 0 || front_len > CEPH_MSG_MAX_FRONT_LEN ||
+	       middle_len < 0 || middle_len > CEPH_MSG_MAX_MIDDLE_LEN ||
+	       data_len < 0 || data_len > CEPH_MSG_MAX_DATA_LEN);
+
 	if (!front_len && !middle_len && !data_len)
 		return 0;
 
@@ -521,29 +527,34 @@ static int decode_preamble(void *p, stru
 		desc->fd_aligns[i] = ceph_decode_16(&p);
 	}
 
-	/*
-	 * This would fire for FRAME_TAG_WAIT (it has one empty
-	 * segment), but we should never get it as client.
-	 */
-	if (!desc->fd_lens[desc->fd_seg_cnt - 1]) {
-		pr_err("last segment empty\n");
+	if (desc->fd_lens[0] < 0 ||
+	    desc->fd_lens[0] > CEPH_MSG_MAX_CONTROL_LEN) {
+		pr_err("bad control segment length %d\n", desc->fd_lens[0]);
 		return -EINVAL;
 	}
-
-	if (desc->fd_lens[0] > CEPH_MSG_MAX_CONTROL_LEN) {
-		pr_err("control segment too big %d\n", desc->fd_lens[0]);
+	if (desc->fd_lens[1] < 0 ||
+	    desc->fd_lens[1] > CEPH_MSG_MAX_FRONT_LEN) {
+		pr_err("bad front segment length %d\n", desc->fd_lens[1]);
 		return -EINVAL;
 	}
-	if (desc->fd_lens[1] > CEPH_MSG_MAX_FRONT_LEN) {
-		pr_err("front segment too big %d\n", desc->fd_lens[1]);
+	if (desc->fd_lens[2] < 0 ||
+	    desc->fd_lens[2] > CEPH_MSG_MAX_MIDDLE_LEN) {
+		pr_err("bad middle segment length %d\n", desc->fd_lens[2]);
 		return -EINVAL;
 	}
-	if (desc->fd_lens[2] > CEPH_MSG_MAX_MIDDLE_LEN) {
-		pr_err("middle segment too big %d\n", desc->fd_lens[2]);
+	if (desc->fd_lens[3] < 0 ||
+	    desc->fd_lens[3] > CEPH_MSG_MAX_DATA_LEN) {
+		pr_err("bad data segment length %d\n", desc->fd_lens[3]);
 		return -EINVAL;
 	}
-	if (desc->fd_lens[3] > CEPH_MSG_MAX_DATA_LEN) {
-		pr_err("data segment too big %d\n", desc->fd_lens[3]);
+
+	/*
+	 * This would fire for FRAME_TAG_WAIT (it has one empty
+	 * segment), but we should never get it as client.
+	 */
+	if (!desc->fd_lens[desc->fd_seg_cnt - 1]) {
+		pr_err("last segment empty, segment count %d\n",
+		       desc->fd_seg_cnt);
 		return -EINVAL;
 	}
 


