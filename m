Return-Path: <stable+bounces-80376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B38798DD27
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5A1285D14
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DAE1D0493;
	Wed,  2 Oct 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t46TfNFJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740471EA80;
	Wed,  2 Oct 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880193; cv=none; b=Y6BLw4mbZyJHkr0GhWbssmreZ1bVkbs6kr4V69HVTYBnh7Rf06uoWpWC2B9fzaClI/uPWKWoMknBbJnX5iCm7D/BTzKht/gWBQ6J8fn29AcWAoh3f03hwOKr05xVeEaameDfhhIe49njyb4MbNnPv/Jyk0ZpJFKS9SNob4TuN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880193; c=relaxed/simple;
	bh=IvqA+wyhSSIxA1h2OYx6j0ANlSYCvDNa38xEqMo7GdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVvh/F2AxefsNKKNpKx4b1yvgEQkmZsTDEKIstsBf+2X/XHysWd7zaPfH/ErcwVkFEX2VC5j8uqkQ87of0QDzhZ9ichzWSxLaIhfbmy4iAnjyklujDb4dMFD4lYEn6gA7ZB75vjkpioId7Y+WwBVj3IgB6Y8liXVffR5FzJXTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t46TfNFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FDEC4CEC2;
	Wed,  2 Oct 2024 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880193;
	bh=IvqA+wyhSSIxA1h2OYx6j0ANlSYCvDNa38xEqMo7GdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t46TfNFJxW/8n+itAnvOVwxqDXHfRlCqYc15ONkA01Jl/NmzWK5w4efMVXRptvwBG
	 0jI+jris3V47MhTD0kjCxHYzp/kBQeIk53ubuMWP0MjVUPEIPw8rVwo0dkERYEuKK8
	 P2SmUmyLnCxJa2yuRZ48kgWSpLltLzKDCshR9sck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com,
	Jiwon Kim <jiwonaid0@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 376/538] bonding: Fix unnecessary warnings and logs from bond_xdp_get_xmit_slave()
Date: Wed,  2 Oct 2024 15:00:15 +0200
Message-ID: <20241002125807.273145095@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiwon Kim <jiwonaid0@gmail.com>

[ Upstream commit 0cbfd45fbcf0cb26d85c981b91c62fe73cdee01c ]

syzbot reported a WARNING in bond_xdp_get_xmit_slave. To reproduce
this[1], one bond device (bond1) has xdpdrv, which increases
bpf_master_redirect_enabled_key. Another bond device (bond0) which is
unsupported by XDP but its slave (veth3) has xdpgeneric that returns
XDP_TX. This triggers WARN_ON_ONCE() from the xdp_master_redirect().
To reduce unnecessary warnings and improve log management, we need to
delete the WARN_ON_ONCE() and add ratelimit to the netdev_err().

[1] Steps to reproduce:
    # Needs tx_xdp with return XDP_TX;
    ip l add veth0 type veth peer veth1
    ip l add veth3 type veth peer veth4
    ip l add bond0 type bond mode 6 # BOND_MODE_ALB, unsupported by XDP
    ip l add bond1 type bond # BOND_MODE_ROUNDROBIN by default
    ip l set veth0 master bond1
    ip l set bond1 up
    # Increases bpf_master_redirect_enabled_key
    ip l set dev bond1 xdpdrv object tx_xdp.o section xdp_tx
    ip l set veth3 master bond0
    ip l set bond0 up
    ip l set veth4 up
    # Triggers WARN_ON_ONCE() from the xdp_master_redirect()
    ip l set veth3 xdpgeneric object tx_xdp.o section xdp_tx

Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c187823a52ed505b2257
Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20240918140602.18644-1-jiwonaid0@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 53a7b53618d94..14b4780b73c72 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5534,9 +5534,9 @@ bond_xdp_get_xmit_slave(struct net_device *bond_dev, struct xdp_buff *xdp)
 		break;
 
 	default:
-		/* Should never happen. Mode guarded by bond_xdp_check() */
-		netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n", BOND_MODE(bond));
-		WARN_ON_ONCE(1);
+		if (net_ratelimit())
+			netdev_err(bond_dev, "Unknown bonding mode %d for xdp xmit\n",
+				   BOND_MODE(bond));
 		return NULL;
 	}
 
-- 
2.43.0




