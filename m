Return-Path: <stable+bounces-243488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Pn2GESq+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:16:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0025E4BEF4A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F94230364B7
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB583D5667;
	Mon,  4 May 2026 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mJgk4XD3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0D3AA4F8;
	Mon,  4 May 2026 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904013; cv=none; b=BSebkDZvDOhWowZXU1/bRzArIEigd4oYuNpIUV84IA1kGAouGKLTeQ96L12QO8PCM3y5GWMgM1q9g+WMZIeHoSlv/X87IfWD+TU77b0kVqW2De1LjauABFJffxa0uKUD3d3xHbDh11nw+CihIQ/sbE36vvco3773DUAl6CYWEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904013; c=relaxed/simple;
	bh=GCAkO/UdqGE1VEdVrvriiY1qR0/W9onR384xDQ8usw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7c+ZkJvV9ValKq5EjURkrxiATPHa9CpM0IH3evYYsfGAjIKJGXdpMejQ0otEgudv3TODoAyupTgFhl9BzTLiIJSrTvMRAAmLB711Q0n4JH+UwPHhpXHoLz2jNhkmWSmWqV6gyEggZisfUqk/6ix9mLxPKOXkgdOelo5JOQIWgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mJgk4XD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B53C2BCB8;
	Mon,  4 May 2026 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904013;
	bh=GCAkO/UdqGE1VEdVrvriiY1qR0/W9onR384xDQ8usw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJgk4XD3heh8Psi4onua2NNX5alJbDTQ958GjbaWtR9ko8d2+AfKQsQ7YS/qdWf+r
	 6LkbDy7fLG58zfC20w5BiZF/bz1WjwAglBmb+YTompsDNFchbQa0vg9NIosvxxnRqh
	 zLzkzpVdDyvb7jZEewC/fTlj6yzbx71kAjbc0BTM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Holmberg <hans.holmberg@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.18 149/275] xfs: start gc on zonegc_low_space attribute updates
Date: Mon,  4 May 2026 15:51:29 +0200
Message-ID: <20260504135148.465902496@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 0025E4BEF4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243488-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,lst.de:email,wdc.com:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Holmberg <hans.holmberg@wdc.com>

commit 181ea4e2de422aa0a66f355bd59bccccdd169826 upstream.

Start gc if the agressiveness of zone garbage collection is changed
by the user (if the file system is not read only).

Without this change, the new setting will not be taken into account
until the gc thread is woken up by e.g. a write.

Cc: stable@vger.kernel.org # v6.15
Fixes: 845abeb1f06a8a ("xfs: add tunable threshold parameter for triggering zone GC")
Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_sysfs.c      |    7 ++++++-
 fs/xfs/xfs_zone_alloc.h |    4 ++++
 fs/xfs/xfs_zone_gc.c    |   17 +++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

--- a/fs/xfs/xfs_sysfs.c
+++ b/fs/xfs/xfs_sysfs.c
@@ -14,6 +14,7 @@
 #include "xfs_log_priv.h"
 #include "xfs_mount.h"
 #include "xfs_zones.h"
+#include "xfs_zone_alloc.h"
 
 struct xfs_sysfs_attr {
 	struct attribute attr;
@@ -724,6 +725,7 @@ zonegc_low_space_store(
 	const char		*buf,
 	size_t			count)
 {
+	struct xfs_mount	*mp = zoned_to_mp(kobj);
 	int			ret;
 	unsigned int		val;
 
@@ -734,7 +736,10 @@ zonegc_low_space_store(
 	if (val > 100)
 		return -EINVAL;
 
-	zoned_to_mp(kobj)->m_zonegc_low_space = val;
+	if (mp->m_zonegc_low_space != val) {
+		mp->m_zonegc_low_space = val;
+		xfs_zone_gc_wakeup(mp);
+	}
 
 	return count;
 }
--- a/fs/xfs/xfs_zone_alloc.h
+++ b/fs/xfs/xfs_zone_alloc.h
@@ -51,6 +51,7 @@ int xfs_mount_zones(struct xfs_mount *mp
 void xfs_unmount_zones(struct xfs_mount *mp);
 void xfs_zone_gc_start(struct xfs_mount *mp);
 void xfs_zone_gc_stop(struct xfs_mount *mp);
+void xfs_zone_gc_wakeup(struct xfs_mount *mp);
 #else
 static inline int xfs_mount_zones(struct xfs_mount *mp)
 {
@@ -65,6 +66,9 @@ static inline void xfs_zone_gc_start(str
 static inline void xfs_zone_gc_stop(struct xfs_mount *mp)
 {
 }
+static inline void xfs_zone_gc_wakeup(struct xfs_mount *mp)
+{
+}
 #endif /* CONFIG_XFS_RT */
 
 #endif /* _XFS_ZONE_ALLOC_H */
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -1147,6 +1147,23 @@ xfs_zone_gc_stop(
 		kthread_park(mp->m_zone_info->zi_gc_thread);
 }
 
+void
+xfs_zone_gc_wakeup(
+	struct xfs_mount	*mp)
+{
+	struct super_block      *sb = mp->m_super;
+
+	/*
+	 * If we are unmounting the file system we must not try to
+	 * wake gc as m_zone_info might have been freed already.
+	 */
+	if (down_read_trylock(&sb->s_umount)) {
+		if (!xfs_is_readonly(mp))
+			wake_up_process(mp->m_zone_info->zi_gc_thread);
+		up_read(&sb->s_umount);
+	}
+}
+
 int
 xfs_zone_gc_mount(
 	struct xfs_mount	*mp)



