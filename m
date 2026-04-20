Return-Path: <stable+bounces-239262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIaiMktQ5mkDuwEAu9opvQ
	(envelope-from <stable+bounces-239262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:11:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B2A42F21D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABA9E31654F3
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB17354AE3;
	Mon, 20 Apr 2026 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kyh9V+Zt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C2D34D926
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697415; cv=none; b=LTST3oEXkxfzF/xUYmQB5Km21cbWsWe2knOD2j8gXwynYL8IpDyar+lTENPCUwL8ejHxi2Aqhb/WcSc6jbPN0m5CXgfwQY+6F8mOTfrk6OXkLKWuD9N9TQYixTjaWJpx7s3yF9rmytmF5eh+Y3jD3dte92JD5fyCd1e6tKO0ItM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697415; c=relaxed/simple;
	bh=o8xwGobiomshZBsOKOLk+zHOeiIFSvXxLvv9LXikHPk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pUJjbTnb39Hzg61dKMdou2y9qTsNrsw0PC4Mcd3Kw9WH96Rie+REYHLDvr6bW2EGtJUaIICuW+KhI9GW0sU3PdZcciIujnGVx161j3up8ZAplIO91HqQack0BRxoucxJI3U70M6591lk1wJJDyWr9ESC0+kIPzRcerbJKtAnWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kyh9V+Zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EB3C2BCB4;
	Mon, 20 Apr 2026 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776697415;
	bh=o8xwGobiomshZBsOKOLk+zHOeiIFSvXxLvv9LXikHPk=;
	h=Subject:To:Cc:From:Date:From;
	b=Kyh9V+ZtkFQ4g5kAzh1RG1FzhiYj6hy8YOsdK0xVCoYQ/4YIkGUsn0W/CRSUgf0rx
	 Ecv39Q+H/Qav9aamOJjcofgQ5RINQZKCLJz8JxK5ZsYhwcVpXH3GAvAqQPCvC2ZItu
	 0MYDQIFQ58xUSxRqi4HhpQEJ6wbR7zaEjqL3tTEE=
Subject: FAILED: patch "[PATCH] wireguard: device: use exit_rtnl callback instead of manual" failed to apply to 6.1-stable tree
To: shardul.b@mpiricsoftware.com,Jason@zx2c4.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Apr 2026 17:03:31 +0200
Message-ID: <2026042031-chasing-nuclei-de8d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239262-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,appspotmail.com:email,syzkaller.appspot.com:url,zx2c4.com:email,linuxfoundation.org:dkim,gregkh:email,mpiricsoftware.com:email]
X-Rspamd-Queue-Id: 46B2A42F21D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 60a25ef8dacb3566b1a8c4de00572a498e2a3bf9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042031-chasing-nuclei-de8d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 60a25ef8dacb3566b1a8c4de00572a498e2a3bf9 Mon Sep 17 00:00:00 2001
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Tue, 14 Apr 2026 17:39:44 +0200
Subject: [PATCH] wireguard: device: use exit_rtnl callback instead of manual
 rtnl_lock in pre_exit

wg_netns_pre_exit() manually acquires rtnl_lock() inside the
pernet .pre_exit callback.  This causes a hung task when another
thread holds rtnl_mutex - the cleanup_net workqueue (or the
setup_net failure rollback path) blocks indefinitely in
wg_netns_pre_exit() waiting to acquire the lock.

Convert to .exit_rtnl, introduced in commit 7a60d91c690b ("net:
Add ->exit_rtnl() hook to struct pernet_operations."), where the
framework already holds RTNL and batches all callbacks under a
single rtnl_lock()/rtnl_unlock() pair, eliminating the contention
window.

The rcu_assign_pointer(wg->creating_net, NULL) is safe to move
from .pre_exit to .exit_rtnl (which runs after synchronize_rcu())
because all RCU readers of creating_net either use maybe_get_net()
- which returns NULL for a dying namespace with zero refcount - or
access net->user_ns which remains valid throughout the entire
ops_undo_list sequence.

Reported-by: syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=cb64c22a492202ca929e18262fdb8cb89e635c70
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
[ Jason: added __net_exit and __read_mostly annotations that were missing. ]
Fixes: 900575aa33a3 ("wireguard: device: avoid circular netns references")
Cc: stable@vger.kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Link: https://patch.msgid.link/20260414153944.2742252-5-Jason@zx2c4.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 46a71ec36af8..67b07ee2d660 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -411,12 +411,11 @@ static struct rtnl_link_ops link_ops __read_mostly = {
 	.newlink		= wg_newlink,
 };
 
-static void wg_netns_pre_exit(struct net *net)
+static void __net_exit wg_netns_exit_rtnl(struct net *net, struct list_head *dev_kill_list)
 {
 	struct wg_device *wg;
 	struct wg_peer *peer;
 
-	rtnl_lock();
 	list_for_each_entry(wg, &device_list, device_list) {
 		if (rcu_access_pointer(wg->creating_net) == net) {
 			pr_debug("%s: Creating namespace exiting\n", wg->dev->name);
@@ -429,11 +428,10 @@ static void wg_netns_pre_exit(struct net *net)
 			mutex_unlock(&wg->device_update_lock);
 		}
 	}
-	rtnl_unlock();
 }
 
-static struct pernet_operations pernet_ops = {
-	.pre_exit = wg_netns_pre_exit
+static struct pernet_operations pernet_ops __read_mostly = {
+	.exit_rtnl = wg_netns_exit_rtnl
 };
 
 int __init wg_device_init(void)


