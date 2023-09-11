Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0987679B3A1
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbjIKVki (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbjIKOMD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:12:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACC6CD
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:11:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F328C433C7;
        Mon, 11 Sep 2023 14:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441518;
        bh=tUak1P5RtKzq/rCYTuaL109NCt0cR5WTgoWfIQShJhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W70OLLg6ZMeFUsxvi/9qJmqBOfHs8hMZJ+qjEOsTU13CCb+KrqBagLC9S+buQd9pO
         SBPf8YQDUmI2/iXSndYQQKK62Qhh7hey72W0NXxqMRLxGnosGAHow6t+uOvfJObuDG
         ex4U7giuTgjI5/NkXQ7a4h1U0jQn03YA6Cmlngx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maxim Levitsky <mlevitsk@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 442/739] SUNRPC: Fix the recent bv_offset fix
Date:   Mon, 11 Sep 2023 15:44:01 +0200
Message-ID: <20230911134703.513496812@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit f16ff1cafbf1e65cc706af912df90bcc15d39a6c ]

Jeff confirmed his original fix addressed his pynfs test failure,
but this same bug also impacted qemu: accessing qcow2 virtual disks
using direct I/O was failing. Jeff's fix missed that you have to
shorten the bio_vec element by the same amount as you increased
the page offset.

Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
Fixes: c96e2a695e00 ("sunrpc: set the bv_offset of first bvec in svc_tcp_sendmsg")
Tested-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/svcsock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 2eb8df44f894d..589020ed909dc 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1244,8 +1244,10 @@ static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
 	if (ret != head->iov_len)
 		goto out;
 
-	if (xdr_buf_pagecount(xdr))
+	if (xdr_buf_pagecount(xdr)) {
 		xdr->bvec[0].bv_offset = offset_in_page(xdr->page_base);
+		xdr->bvec[0].bv_len -= offset_in_page(xdr->page_base);
+	}
 
 	msg.msg_flags = MSG_SPLICE_PAGES;
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, xdr->bvec,
-- 
2.40.1



