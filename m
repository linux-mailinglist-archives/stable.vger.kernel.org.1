Return-Path: <stable+bounces-85418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C4E99E73D
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793CB1C26153
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EAA1E6339;
	Tue, 15 Oct 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Jym9A6C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A91D89F5;
	Tue, 15 Oct 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993049; cv=none; b=AmU2yT1xQeU7xKSs0Pv20qKsa9DQmg/g6IiucNpdHyEHIhVT/MVfh9gttNvRuLYde9UU1LCdtRo1rRePJVfVpZ4oAZ0UYXUKcOTNnRxk0futg6i0tctMzlRC/aqMcSphRkrQjM25QcvH44cLC7GsckryKSKokQGTsA9leSFkEWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993049; c=relaxed/simple;
	bh=//4jkGq5oDmtxzSt0kZYGZnebF+RwKISNg1o8mWyLDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0rLRsZXra6izElxA9zaprhaUT0WgGgTP21BNDQOTUtfQKTqLfzNlPbsTM6GpPq8YC7jVHVsa1pEc/q37FBl+HD73oBXRUAPx0WpajD73/D2t+PUhIMAmY6RXd3NP+exJpJRanIJq6QNn3OQXplWtxeMcspcXGujM9R64IIl53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Jym9A6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FCBC4CEC6;
	Tue, 15 Oct 2024 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993048;
	bh=//4jkGq5oDmtxzSt0kZYGZnebF+RwKISNg1o8mWyLDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Jym9A6CC6vbmXAaoCRpx6IB7wWMjZRKn0L578zHcKHHAZlIBxULSbcQ1KwjxIG0E
	 ix2VbdQYnKDW0/j5YlcUQKFOmBSHrm4eZYUGxKvuAsKYEZTbStElc8v+wGuWZz4ygt
	 O24FxWd8waUfzyHwKIgvSgSKD1e1jatjnT7kziNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com,
	Jiwon Kim <jiwonaid0@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 296/691] bonding: Fix unnecessary warnings and logs from bond_xdp_get_xmit_slave()
Date: Tue, 15 Oct 2024 13:24:04 +0200
Message-ID: <20241015112452.093365146@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index fd0667e1d10ab..67d153cc6a6c0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5191,9 +5191,9 @@ bond_xdp_get_xmit_slave(struct net_device *bond_dev, struct xdp_buff *xdp)
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




