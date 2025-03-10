Return-Path: <stable+bounces-121873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D62A59CE0
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382993A9EBB
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87753232395;
	Mon, 10 Mar 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hzr5uiUX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365A23236F;
	Mon, 10 Mar 2025 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626877; cv=none; b=ecCw1chcUNsLklarQrrSZA+yKsifn+Y8BHHOsCkd0XJLPbzlmN5aHAqT4OteS4Sz9b5YcrY1TYpzCvpTu0LQyPT5P+YtAibj3SubZAqpqEGSeJ7XwFZSpnDCaf1020MTrPhmLPULuLjaknuDSCJWGFboLNcL/RLHPDxNJrrksyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626877; c=relaxed/simple;
	bh=WoZYNLzKoRzto2sFjjWmUATeR/F0EvPxURSN8CiYoaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwKl4A7sBNkIETcPcSx7EodrawsxZCZxCLKaNpcyelQedYKDR72AEyJgr8mGnRTvNaqlb6y1S3lnDlpmk2mbxvYUnRyyouVqF3h7koNkRnmTM4gr/xoj1X+rUFVMH8MthYzG4PpvRXWhm0mTUVPGsIjPvx4ZYvw4ZNZeUilG4SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hzr5uiUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A56EC4CEED;
	Mon, 10 Mar 2025 17:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626876;
	bh=WoZYNLzKoRzto2sFjjWmUATeR/F0EvPxURSN8CiYoaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hzr5uiUXpYSoxFSHj7rY9pp2UAfHNCpcedNm4FVM/1zjnHgr1sJ9sKuN5BdgbHl3j
	 bXKPHKSFuEc7yuLgQHVdJcb6cWjzBjJfJ3ICw316Bkt3Vq4fiDHKt2kaQmrcUKJwrs
	 epmgV9S4puClUdCqlKGCgaC9Vc5h09jDsId3Kd8g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoine Tenart <atenart@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 111/207] net: gso: fix ownership in __udp_gso_segment
Date: Mon, 10 Mar 2025 18:05:04 +0100
Message-ID: <20250310170452.167760449@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <atenart@kernel.org>

[ Upstream commit ee01b2f2d7d0010787c2343463965bbc283a497f ]

In __udp_gso_segment the skb destructor is removed before segmenting the
skb but the socket reference is kept as-is. This is an issue if the
original skb is later orphaned as we can hit the following bug:

  kernel BUG at ./include/linux/skbuff.h:3312!  (skb_orphan)
  RIP: 0010:ip_rcv_core+0x8b2/0xca0
  Call Trace:
   ip_rcv+0xab/0x6e0
   __netif_receive_skb_one_core+0x168/0x1b0
   process_backlog+0x384/0x1100
   __napi_poll.constprop.0+0xa1/0x370
   net_rx_action+0x925/0xe50

The above can happen following a sequence of events when using
OpenVSwitch, when an OVS_ACTION_ATTR_USERSPACE action precedes an
OVS_ACTION_ATTR_OUTPUT action:

1. OVS_ACTION_ATTR_USERSPACE is handled (in do_execute_actions): the skb
   goes through queue_gso_packets and then __udp_gso_segment, where its
   destructor is removed.
2. The segments' data are copied and sent to userspace.
3. OVS_ACTION_ATTR_OUTPUT is handled (in do_execute_actions) and the
   same original skb is sent to its path.
4. If it later hits skb_orphan, we hit the bug.

Fix this by also removing the reference to the socket in
__udp_gso_segment.

Fixes: ad405857b174 ("udp: better wmem accounting on gso")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
Link: https://patch.msgid.link/20250226171352.258045-1-atenart@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp_offload.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index a5be6e4ed326f..ecfca59f31f13 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -321,13 +321,17 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
 	copy_dtor = gso_skb->destructor == sock_wfree;
-	if (copy_dtor)
+	if (copy_dtor) {
 		gso_skb->destructor = NULL;
+		gso_skb->sk = NULL;
+	}
 
 	segs = skb_segment(gso_skb, features);
 	if (IS_ERR_OR_NULL(segs)) {
-		if (copy_dtor)
+		if (copy_dtor) {
 			gso_skb->destructor = sock_wfree;
+			gso_skb->sk = sk;
+		}
 		return segs;
 	}
 
-- 
2.39.5




