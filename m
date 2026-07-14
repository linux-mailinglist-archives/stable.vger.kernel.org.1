Return-Path: <stable+bounces-274108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PoWGDPmtVWqXrgAAu9opvQ
	(envelope-from <stable+bounces-274108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 05:33:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9EB750A8B
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 05:33:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YdgclE+r;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274108-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274108-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B4023016AD3
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3CB3446DE;
	Tue, 14 Jul 2026 03:33:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3FD28469A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:33:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999985; cv=none; b=IwPbmg06IwBZTiO83rC59uxNIV32bSHp3e4L9Zt4VtwWSQ+esfGxUUZo2vecTglX7YoghIAQ0yI9zY2MPP5wnABX4MPMop+qWQEQYRak4fBkTik8Hsr19N0BTJiXYl3EKfq9t6N6o0ZMJTX2w5xZDj+4VcMUkTMScdLKuy5jHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999985; c=relaxed/simple;
	bh=hYK7Frwl7zlRAxbYyGWl4ssieIlAU7zBekiRAiHGKXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ds/lVKSXhfqWHboQMJRuZ15+ib7NymJRaVIw877LNUmIgO4QYRSnIDWKwOD6CT/S48UVOPhiqMtgzKqKEM9WdiWJgBS1oV8O0OKsVHXg2jyeAYIe5fF89CQBSDGV21cAzjbHoS1thpqXwIXycvrKsNGHys2kxXX/4hCfIYJzWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdgclE+r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F213E1F000E9;
	Tue, 14 Jul 2026 03:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783999983;
	bh=BesHDI/Yt/UFdGCnnTYNfhUYLBJNnRXCx9K40CJRkHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YdgclE+r40timONPRwFuFt3CyBrZ0CpkQ/780hBWInqVbWkBDpQTsEMpGGphGcwWW
	 HIZn3xe9EUNvdf6S25B0qx7BxCQGso8oSmpmmZEgj+bYszXigslhIyWGlqZuZw93Cv
	 KAwCuzi/Fw3Ad+EGekM1xK3zQYMfjHdcJyu/+kB13t7vTPpxo/SZzPeSoKvVZO31Iy
	 AtgW1qiWan8mdfywQP/aWTYHEH06VE1mDPG302BIGsxY/Fkz4eAhAZsg7HN7mUrsL/
	 Hvt37au4OAdA3KSVlukj8nTLr6423Cu7CfuXrQEd0QT7KR+TC6j9nDv6dfAmk6Dt0H
	 M3INbda2rQnjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] vfio/pci: Use bitfield for struct vfio_pci_core_device flags
Date: Mon, 13 Jul 2026 23:33:00 -0400
Message-ID: <20260714033301.2397090-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071325-recipient-lavender-88d4@gregkh>
References: <2026071325-recipient-lavender-88d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:reinette.chatre@intel.com,m:jgg@nvidia.com,m:kevin.tian@intel.com,m:tglx@linutronix.de,m:alex.williamson@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274108-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D9EB750A8B

From: Reinette Chatre <reinette.chatre@intel.com>

[ Upstream commit 9cd0f6d5cbb6fda09aa83beb8146c287a552017e ]

struct vfio_pci_core_device contains eleven boolean flags.
Boolean flags clearly indicate their usage but space usage
starts to be a concern when there are many.

An upcoming change adds another boolean flag to
struct vfio_pci_core_device, thereby increasing the concern
that the boolean flags are consuming unnecessary space.

Transition the boolean flags to use bitfields. On a system that
uses one byte per boolean this reduces the space consumed
by existing flags from 11 bytes to 2 bytes with room for
a few more flags without increasing the structure's size.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/cf34bf0499c889554a8105eeb18cc0ab673005be.1683740667.git.reinette.chatre@intel.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Stable-dep-of: 40ef3edf151e ("vfio/pci: Use a private flag to prevent power state change with VFs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/vfio_pci_core.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 367fd79226a306..1c56c1df163cca 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -69,17 +69,17 @@ struct vfio_pci_core_device {
 	u16			msix_size;
 	u32			msix_offset;
 	u32			rbar[7];
-	bool			pci_2_3;
-	bool			virq_disabled;
-	bool			reset_works;
-	bool			extended_caps;
-	bool			bardirty;
-	bool			has_vga;
-	bool			needs_reset;
-	bool			nointx;
-	bool			needs_pm_restore;
-	bool			pm_intx_masked;
-	bool			pm_runtime_engaged;
+	bool			pci_2_3:1;
+	bool			virq_disabled:1;
+	bool			reset_works:1;
+	bool			extended_caps:1;
+	bool			bardirty:1;
+	bool			has_vga:1;
+	bool			needs_reset:1;
+	bool			nointx:1;
+	bool			needs_pm_restore:1;
+	bool			pm_intx_masked:1;
+	bool			pm_runtime_engaged:1;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
-- 
2.53.0


