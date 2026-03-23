Return-Path: <stable+bounces-228375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM65AOdOwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:32:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 746D52F4ADF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CE29306833A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EB73803EF;
	Mon, 23 Mar 2026 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gnHLWgQw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064CA3ACEFE;
	Mon, 23 Mar 2026 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274946; cv=none; b=Ewo7fi0mu487dfb2xuvXQaSMb0ZaCiPbEY9cF0j6W7XBC24VOxFWt4GQbajq2hCkCkLYQlz90hw0DeiKcTE0Rvb7/LSdXYQ1BtEOP6kQ/vuErlL918BZukPWFOiy1AsJ4zycXSBGu3eVspKx0KeiImoCU42t5badDRYATD6lWFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274946; c=relaxed/simple;
	bh=o57nxIxYw252QNsKFY+q2Gn38pHCOVQQczb/zFXziiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VA/VPUQ7vj9VN3UE5RsrkIuGsLwFQqKRZiyAqfirV3fgRMlN7hGFoFBY0ZA+USISe3exsyY6m36eYLFHuaTaD/+WyyrEvDCqyE0ifGxlHC088WIkdk61FnuEOz2cUNO01xrbRatJjccO3gw1RkLvIb3qVbVD4a0f1cHRMIWyQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gnHLWgQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB2FC4CEF7;
	Mon, 23 Mar 2026 14:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274945;
	bh=o57nxIxYw252QNsKFY+q2Gn38pHCOVQQczb/zFXziiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gnHLWgQw8WyA0yVEvhxTpHvTF2BqyHMP835RDd5ctR+SlW7nw0p/zD4lbZn+QHmVw
	 0Uc6q59U4kmCd3Qan5ocusv20p5H8iFbIcBbmCLmi7Vqy4Y1XSQ4re3PODMnkfZqyn
	 Ptr1kVIrNc7XERNHGd+s0MO73K5wQ7BrlQ+gFWK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 165/212] net: macb: fix uninitialized rx_fs_lock
Date: Mon, 23 Mar 2026 14:46:26 +0100
Message-ID: <20260323134508.948980049@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228375-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 746D52F4ADF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 34b11cc56e4369bc08b1f4c4a04222d75ed596ce ]

If hardware doesn't support RX Flow Filters, rx_fs_lock spinlock is not
initialized leading to the following assertion splat triggerable via
set_rxnfc callback.

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 949 Comm: syz.0.6 Not tainted 6.1.164+ #113
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xba lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:974 [inline]
 register_lock_class+0x141b/0x17f0 kernel/locking/lockdep.c:1287
 __lock_acquire+0x74f/0x6c40 kernel/locking/lockdep.c:4928
 lock_acquire kernel/locking/lockdep.c:5662 [inline]
 lock_acquire+0x190/0x4b0 kernel/locking/lockdep.c:5627
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x33/0x50 kernel/locking/spinlock.c:162
 gem_del_flow_filter drivers/net/ethernet/cadence/macb_main.c:3562 [inline]
 gem_set_rxnfc+0x533/0xac0 drivers/net/ethernet/cadence/macb_main.c:3667
 ethtool_set_rxnfc+0x18c/0x280 net/ethtool/ioctl.c:961
 __dev_ethtool net/ethtool/ioctl.c:2956 [inline]
 dev_ethtool+0x229c/0x6290 net/ethtool/ioctl.c:3095
 dev_ioctl+0x637/0x1070 net/core/dev_ioctl.c:510
 sock_do_ioctl+0x20d/0x2c0 net/socket.c:1215
 sock_ioctl+0x577/0x6d0 net/socket.c:1320
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18c/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:46 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:76
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

A more straightforward solution would be to always initialize rx_fs_lock,
just like rx_fs_list.  However, in this case the driver set_rxnfc callback
would return with a rather confusing error code, e.g. -EINVAL.  So deny
set_rxnfc attempts directly if the RX filtering feature is not supported
by hardware.

Fixes: ae8223de3df5 ("net: macb: Added support for RX filtering")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Link: https://patch.msgid.link/20260316103826.74506-2-pchelkin@ispras.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1db90df395fc7..4624db166a27b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4013,6 +4013,9 @@ static int gem_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	struct macb *bp = netdev_priv(netdev);
 	int ret;
 
+	if (!(netdev->hw_features & NETIF_F_NTUPLE))
+		return -EOPNOTSUPP;
+
 	switch (cmd->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
 		if ((cmd->fs.location >= bp->max_tuples)
-- 
2.51.0




