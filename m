Return-Path: <stable+bounces-243239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHJnOiip+GmdxgIAu9opvQ
	(envelope-from <stable+bounces-243239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB2C4BEC08
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EEA63065CB4
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EAC347BA9;
	Mon,  4 May 2026 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qf+dEMD/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04737881B;
	Mon,  4 May 2026 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903375; cv=none; b=k4m3GH9fNzkh70NCxBiJjWk14ed5b/XrJwPTe1QkPmUz89Trw4p5aLMYHGJ7TiKznR1/+nGADKNtr7ltyTzW1P9JmuLcUiwRWw6rpdafvzhjgEyHjmiHu62SCDixpSUJO4XO0/8oeNby1H0PJ/T5AShHReaV5mV+MmejOoIIlv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903375; c=relaxed/simple;
	bh=GhqHvaayTRmz19WIrhcfAAENehDcm2DBO3k0Wr3uPYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aU0b57JG5/BWLhzGn+GYHhMcVG9R6etunqw3QoL0i9mnBI1sAcw+XpT33iOh9bId6lhHo9VmVHEIN8dBQrgpa0wCdO6ejm7XpP15g7CK6BXdleO2GqVTvc91xWxNWRPy0fz+6BGdOLNouyoyhty0FlKrx+3ucfyjAggwWPXvNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qf+dEMD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89C6C2BCB8;
	Mon,  4 May 2026 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903375;
	bh=GhqHvaayTRmz19WIrhcfAAENehDcm2DBO3k0Wr3uPYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qf+dEMD/E4TGxvxPZ9/eaMulrNRXWHGAmsTUxws0EaLIqAP7otV4At7+sysCcrgfF
	 EUEyLwmfVxFDqx6daKLREha5oBJVanLM+AETvOIv3wVxuv3bDdkcq4Cz5xzmqz3Nrg
	 LQjbdwUmkbgkMLF0tHlfmF1455/MCO3LoTzPEOhA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Holmberg <hans.holmberg@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 7.0 177/307] xfs: start gc on zonegc_low_space attribute updates
Date: Mon,  4 May 2026 15:51:02 +0200
Message-ID: <20260504135149.532448701@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6EB2C4BEC08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243239-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,wdc.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1159,6 +1159,23 @@ xfs_zone_gc_stop(
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



