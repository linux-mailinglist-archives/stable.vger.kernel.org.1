Return-Path: <stable+bounces-231884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBbYHv78y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:57:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC64236D800
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 066F83160A9A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFA23FA5E6;
	Tue, 31 Mar 2026 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SYst9DoO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D653E3C5C;
	Tue, 31 Mar 2026 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975316; cv=none; b=mU8NfCDblqcZtFSICHNI3H4bFZfUXn+r/FWbGD0GZM5Zecr0qYZ/iXqVPzBktW7xYWivHhWedSWlp9g88XOuqu7YIAJLWu/I2P79Y3TZqnFYaSxQschllmrzduUme3vGVXxT5ev5w2/z3f4e06Qt4tma2t4FaUMdwPZ6aM7BN3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975316; c=relaxed/simple;
	bh=JTdyAqC9UaaGez1ytXWstm3gd7F5QlsJgKKthgZubGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkNBr9dJgGHW410lkH4lubet3CqLamVvphMCOI1p9X2n03Mg86fKQFdjh1IOVvoo+f9JC6HofIQLwEMMhCg5hDY5WiMssFOUDLb4pE8qTi9ox09xDddQh4J/46In9pUaT2LMt8D29fn2w7SxgWzNvJx7LTXEro2SKGQUlG5vAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SYst9DoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA3C19423;
	Tue, 31 Mar 2026 16:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975316;
	bh=JTdyAqC9UaaGez1ytXWstm3gd7F5QlsJgKKthgZubGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYst9DoOi6ITOhUETEhcT5aiLiyKpkdykn2/niO5fyvxu8jQw4E8aNRAYf3piy4EZ
	 JO6mthNrlMp637FUe6bNbkvOtDIvY49ULQ+0fFubTEXKS+8+W3Mdy9eSubH9arOETi
	 RnMREM6JkjCQP1HvqzY0B9UW2vJTAf3Bm6lVUGk8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Hao <haokexin@gmail.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.19 248/342] net: macb: Protect access to net_device::ip_ptr with RCU lock
Date: Tue, 31 Mar 2026 18:21:21 +0200
Message-ID: <20260331161808.087305630@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231884-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,bootlin.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: EC64236D800
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kevin Hao <haokexin@gmail.com>

commit baa35a698cea26930679a20a7550bbb4c8319725 upstream.

Access to net_device::ip_ptr and its associated members must be
protected by an RCU lock. Since we are modifying this piece of code,
let's also move it to execute only when WAKE_ARP is enabled.

To minimize the duration of the RCU lock, a local variable is used to
temporarily store the IP address. This change resolves the following
RCU check warning:
  WARNING: suspicious RCU usage
  7.0.0-rc3-next-20260310-yocto-standard+ #122 Not tainted
  -----------------------------
  drivers/net/ethernet/cadence/macb_main.c:5944 suspicious rcu_dereference_check() usage!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  5 locks held by rtcwake/518:
   #0: ffff000803ab1408 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0xf8/0x368
   #1: ffff0008090bf088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0xbc/0x1c8
   #2: ffff00080098d588 (kn->active#70){.+.+}-{0:0}, at: kernfs_fop_write_iter+0xcc/0x1c8
   #3: ffff800081c84888 (system_transition_mutex){+.+.}-{4:4}, at: pm_suspend+0x1ec/0x290
   #4: ffff0008009ba0f8 (&dev->mutex){....}-{4:4}, at: device_suspend+0x118/0x4f0

  stack backtrace:
  CPU: 3 UID: 0 PID: 518 Comm: rtcwake Not tainted 7.0.0-rc3-next-20260310-yocto-standard+ #122 PREEMPT
  Hardware name: ZynqMP ZCU102 Rev1.1 (DT)
  Call trace:
   show_stack+0x24/0x38 (C)
   __dump_stack+0x28/0x38
   dump_stack_lvl+0x64/0x88
   dump_stack+0x18/0x24
   lockdep_rcu_suspicious+0x134/0x1d8
   macb_suspend+0xd8/0x4c0
   device_suspend+0x218/0x4f0
   dpm_suspend+0x244/0x3a0
   dpm_suspend_start+0x50/0x78
   suspend_devices_and_enter+0xec/0x560
   pm_suspend+0x194/0x290
   state_store+0x110/0x158
   kobj_attr_store+0x1c/0x30
   sysfs_kf_write+0xa8/0xd0
   kernfs_fop_write_iter+0x11c/0x1c8
   vfs_write+0x248/0x368
   ksys_write+0x7c/0xf8
   __arm64_sys_write+0x28/0x40
   invoke_syscall+0x4c/0xe8
   el0_svc_common+0x98/0xf0
   do_el0_svc+0x28/0x40
   el0_svc+0x54/0x1e0
   el0t_64_sync_handler+0x84/0x130
   el0t_64_sync+0x198/0x1a0

Fixes: 0cb8de39a776 ("net: macb: Add ARP support to WOL")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Link: https://patch.msgid.link/20260318-macb-irq-v2-2-f1179768ab24@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cadence/macb_main.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5773,9 +5773,9 @@ static int __maybe_unused macb_suspend(s
 	struct macb_queue *queue;
 	struct in_device *idev;
 	unsigned long flags;
+	u32 tmp, ifa_local;
 	unsigned int q;
 	int err;
-	u32 tmp;
 
 	if (!device_may_wakeup(&bp->dev->dev))
 		phy_exit(bp->phy);
@@ -5784,14 +5784,21 @@ static int __maybe_unused macb_suspend(s
 		return 0;
 
 	if (bp->wol & MACB_WOL_ENABLED) {
-		/* Check for IP address in WOL ARP mode */
-		idev = __in_dev_get_rcu(bp->dev);
-		if (idev)
-			ifa = rcu_dereference(idev->ifa_list);
-		if ((bp->wolopts & WAKE_ARP) && !ifa) {
-			netdev_err(netdev, "IP address not assigned as required by WoL walk ARP\n");
-			return -EOPNOTSUPP;
+		if (bp->wolopts & WAKE_ARP) {
+			/* Check for IP address in WOL ARP mode */
+			rcu_read_lock();
+			idev = __in_dev_get_rcu(bp->dev);
+			if (idev)
+				ifa = rcu_dereference(idev->ifa_list);
+			if (!ifa) {
+				rcu_read_unlock();
+				netdev_err(netdev, "IP address not assigned as required by WoL walk ARP\n");
+				return -EOPNOTSUPP;
+			}
+			ifa_local = be32_to_cpu(ifa->ifa_local);
+			rcu_read_unlock();
 		}
+
 		spin_lock_irqsave(&bp->lock, flags);
 
 		/* Disable Tx and Rx engines before  disabling the queues,
@@ -5830,7 +5837,7 @@ static int __maybe_unused macb_suspend(s
 		if (bp->wolopts & WAKE_ARP) {
 			tmp |= MACB_BIT(ARP);
 			/* write IP address into register */
-			tmp |= MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
+			tmp |= MACB_BFEXT(IP, ifa_local);
 		}
 		spin_unlock_irqrestore(&bp->lock, flags);
 



