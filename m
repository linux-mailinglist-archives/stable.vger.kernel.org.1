Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17287D3426
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjJWLhE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjJWLhD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:37:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FDE100
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:37:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C934C433C8;
        Mon, 23 Oct 2023 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061020;
        bh=5wiBpbB3xN3kP22V6ToPDL7xqqavfHBOqzwkEK0zWVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vtrx3ZG9IDPZNBgs3muepC1cHSeoh6lZum2o43gbnkZYAXYRq9eVI8sucJbwAY8A0
         Ix1i4m8A/b45wk0DE12SUtoyHoJlBUaZntwj9PdwSNAozCuyPa6gnGfyM13/d3/qLa
         LT1IrvWPeqcaeZYaifT4vLZoeg5Hub7+/br0rWdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>,
        Mat Martineau <martineau@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 018/137] tcp: check mptcp-level constraints for backlog coalescing
Date:   Mon, 23 Oct 2023 12:56:15 +0200
Message-ID: <20231023104821.561259654@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 6db8a37dfc541e059851652cfd4f0bb13b8ff6af upstream.

The MPTCP protocol can acquire the subflow-level socket lock and
cause the tcp backlog usage. When inserting new skbs into the
backlog, the stack will try to coalesce them.

Currently, we have no check in place to ensure that such coalescing
will respect the MPTCP-level DSS, and that may cause data stream
corruption, as reported by Christoph.

Address the issue by adding the relevant admission check for coalescing
in tcp_add_backlog().

Note the issue is not easy to reproduce, as the MPTCP protocol tries
hard to avoid acquiring the subflow-level socket lock.

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/420
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231018-send-net-20231018-v1-2-17ecb002e41d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_ipv4.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1863,6 +1863,7 @@ bool tcp_add_backlog(struct sock *sk, st
 #ifdef CONFIG_TLS_DEVICE
 	    tail->decrypted != skb->decrypted ||
 #endif
+	    !mptcp_skb_can_collapse(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
 		goto no_coalesce;


