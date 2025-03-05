Return-Path: <stable+bounces-120589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4D0A5076B
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896D4174531
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34298250C1C;
	Wed,  5 Mar 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WDbHPoRQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D91C6FFE;
	Wed,  5 Mar 2025 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197399; cv=none; b=oMHY3Iz+M/Ogib218RCqE2oPKiVOTKlqxGrovpvJzLS4O1qFgVMebj/48j4CQOKqFtZMUAYLVPwXmKd14lqF+n1ci8G5OZJwSr+U08kwgQsa4Cauwi+WTAt8A1CXNj+vEpyV02u+GOhiK89jBLnq5S56j0TqtcxemqihJ9jm4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197399; c=relaxed/simple;
	bh=PRaXLp3TksWT/wyk8FoaaP3ZYyvQbvsq4abx7CDvFPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGYbAbn/mqpvrILFWJktNccDzb8AMDqoqfPRG4+s+ljKWfMWhmW0QRz2UTuxCiwj4Hu+YF83oulFIyNEMFOFZFpCSoxKacHgQU5Cgasjbxbd/D39a9tdTRTHo684C9kLudqoyPlTchfrfpSIFKYL61vOhW0kt3G/jucPPKJp5jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WDbHPoRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB8AC4CED1;
	Wed,  5 Mar 2025 17:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197398;
	bh=PRaXLp3TksWT/wyk8FoaaP3ZYyvQbvsq4abx7CDvFPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDbHPoRQXBBMee3D3CIl61h0E1sIqddMQLlHxUdkRIn0ZlFclZVPa3xCPGWP5Fooo
	 O8L/BrwwAJVHLMj/G9mPn1FVhkVJOQRc6aWUp8dPCcVfXrO5ePTDOdj9fFJ7M95ey+
	 ygmtiod2qattNNPbZK7rCxvl9NYVRfbaROTbjZtI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mohammad Heib <mheib@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 135/176] net: Clear old fragment checksum value in napi_reuse_skb
Date: Wed,  5 Mar 2025 18:48:24 +0100
Message-ID: <20250305174510.865356997@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohammad Heib <mheib@redhat.com>

[ Upstream commit 49806fe6e61b045b5be8610e08b5a3083c109aa0 ]

In certain cases, napi_get_frags() returns an skb that points to an old
received fragment, This skb may have its skb->ip_summed, csum, and other
fields set from previous fragment handling.

Some network drivers set skb->ip_summed to either CHECKSUM_COMPLETE or
CHECKSUM_UNNECESSARY when getting skb from napi_get_frags(), while
others only set skb->ip_summed when RX checksum offload is enabled on
the device, and do not set any value for skb->ip_summed when hardware
checksum offload is disabled, assuming that the skb->ip_summed
initiated to zero by napi_reuse_skb, ionic driver for example will
ignore/unset any value for the ip_summed filed if HW checksum offload is
disabled, and if we have a situation where the user disables the
checksum offload during a traffic that could lead to the following
errors shown in the kernel logs:
<IRQ>
dump_stack_lvl+0x34/0x48
 __skb_gro_checksum_complete+0x7e/0x90
tcp6_gro_receive+0xc6/0x190
ipv6_gro_receive+0x1ec/0x430
dev_gro_receive+0x188/0x360
? ionic_rx_clean+0x25a/0x460 [ionic]
napi_gro_frags+0x13c/0x300
? __pfx_ionic_rx_service+0x10/0x10 [ionic]
ionic_rx_service+0x67/0x80 [ionic]
ionic_cq_service+0x58/0x90 [ionic]
ionic_txrx_napi+0x64/0x1b0 [ionic]
 __napi_poll+0x27/0x170
net_rx_action+0x29c/0x370
handle_softirqs+0xce/0x270
__irq_exit_rcu+0xa3/0xc0
common_interrupt+0x80/0xa0
</IRQ>

This inconsistency sometimes leads to checksum validation issues in the
upper layers of the network stack.

To resolve this, this patch clears the skb->ip_summed value for each
reused skb in by napi_reuse_skb(), ensuring that the caller is responsible
for setting the correct checksum status. This eliminates potential
checksum validation issues caused by improper handling of
skb->ip_summed.

Fixes: 76620aafd66f ("gro: New frags interface to avoid copying shinfo")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250225112852.2507709-1-mheib@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/gro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 47118e97ecfdd..c4cbf398c5f78 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -679,6 +679,7 @@ static void napi_reuse_skb(struct napi_struct *napi, struct sk_buff *skb)
 	skb->pkt_type = PACKET_HOST;
 
 	skb->encapsulation = 0;
+	skb->ip_summed = CHECKSUM_NONE;
 	skb_shinfo(skb)->gso_type = 0;
 	skb_shinfo(skb)->gso_size = 0;
 	if (unlikely(skb->slow_gro)) {
-- 
2.39.5




