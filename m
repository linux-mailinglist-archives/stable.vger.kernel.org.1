Return-Path: <stable+bounces-274247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yYekNKQ8VmoN2AAAu9opvQ
	(envelope-from <stable+bounces-274247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:41:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C04755471
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:41:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P6G4iKmG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274247-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274247-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 290E331941A6
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D04346AEF1;
	Tue, 14 Jul 2026 13:34:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273DE46AF05
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:34:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036087; cv=none; b=r49EeLvEi2gJ/NzIyQJZ6oT5FEmbGFMRBi1bEx9a/Rw085lYdSo5sXyUb5DO5tW+SygzAotXpl45q5UoXif1fBs6PP43CnF5MQ1YQK7IofbqqbIAhFId28QEkafChu6/cSZqiNuacXOG85DaBNFpn7SWX5IeAlcYvHGBxjwDd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036087; c=relaxed/simple;
	bh=EO1x6uwgMkF/y58nUnKP7j7wgalyEVL+YGXIziHTKZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tumFcT0ziqyi+WLRNqbBoNjWqm7/yP4XdBv4ulDRckJJrjX2Vl4Mz12qZQuycGedrqaakTXaGjqhM3KBPAkLixliRI14DMHpebBL0MSCBkQEfWPPFSqWm+KDnw34g2WZbCExvNWMTsqi7C706v0Xqqmoi/esnfDsZEbNVyr3R0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6G4iKmG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE751F000E9;
	Tue, 14 Jul 2026 13:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784036085;
	bh=/M3ZErL57N8QoINDm8mapDvZ/LLUbS3LxC6MktlP/v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P6G4iKmGTNb3e/63JPTeP9k/0E3bQhdJqRHqKAqoyQoWexhi/+uDk4oTv3r4u7RWL
	 HUrUJF+2dYSUtSocYN7o/o6LUH0wqsyW2sE80FueufH+oqi5vJ8YGK3kicf/rGRycV
	 X+o8O7elB9mE5+UNN0/cHq3Y8fG8OuICVpwuX3CN7hPnNGpXbgkm08oMxyoClgAv67
	 Cmfw/dSNHag7B5JR9XHNu9UuIacchkZ5l7hHLC4tcPt7E7dXqnwpoYG3PxzmxyGmjo
	 wvL2aBoVPDjNsMWkqdiVH4P6fuJt9CogZS33/dQT1MezFPTbmjdmMcAiZVKOFfNVIh
	 nGC+S2g1hpfhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] vfio/mlx5: Fix racy bitfields and tighten struct layout
Date: Tue, 14 Jul 2026 09:34:43 -0400
Message-ID: <20260714133443.2672245-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071342-scrooge-clay-0479@gregkh>
References: <2026071342-scrooge-clay-0479@gregkh>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274247-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:alex.williamson@nvidia.com,m:yishaih@nvidia.com,m:kevin.tian@intel.com,m:alex@shazbot.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,shazbot.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33C04755471

From: Alex Williamson <alex.williamson@nvidia.com>

[ Upstream commit f2365a63b02ddea32e7db78b742c2503ec7b81f1 ]

Bitfield operations are not atomic, they use a read-modify-write
pattern, therefore we should be careful not to pack bitfields that
can be concurrently updated into the same storage unit.

This split takes a binary approach: flags that are only modified
pre/post open/close remain bitfields, flags modified from user
action, including actions that reach across to another device (ex.
reset) use dedicated storage units.

Note mlx5_vhca_page_tracker.status is relocated to fill the alignment
hole this split exposes.

Bitfield justifications:

  migrate_cap: written only in mlx5vf_cmd_set_migratable() at probe
  chunk_mode: written only in mlx5vf_cmd_set_migratable() at probe
  mig_state_cap: written only in mlx5vf_cmd_set_migratable() at probe

Dedicated storage units:

  mdev_detach: written in the VF attach/detach event notifier
               mlx5fv_vf_event() at runtime
  log_active: written in mlx5vf_start_page_tracker()/
              mlx5vf_stop_page_tracker() during runtime dirty tracking
  deferred_reset: written in mlx5vf_state_mutex_unlock()/
                  mlx5vf_pci_aer_reset_done() during runtime reset handling
  is_err: set by tracker error handling and dirty-log polling at runtime
  object_changed: set by tracker event handling and cleared by dirty-log
                  polling at runtime

Fixes: 61a2f1460fd0 ("vfio/mlx5: Manage the VF attach/detach callback from the PF")
Fixes: 79c3cf279926 ("vfio/mlx5: Init QP based resources for dirty tracking")
Fixes: f886473071d6 ("vfio/mlx5: Add support for tracker object change event")
Cc: Yishai Hadas <yishaih@nvidia.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260615191241.688297-5-alex.williamson@nvidia.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/mlx5/cmd.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index df421dc6de0485..5e8ebb6857687c 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -157,25 +157,28 @@ struct mlx5_vhca_qp {
 struct mlx5_vhca_page_tracker {
 	u32 id;
 	u32 pdn;
-	u8 is_err:1;
-	u8 object_changed:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	u8 is_err;
+	u8 object_changed;
+	int status;
 	struct mlx5_uars_page *uar;
 	struct mlx5_vhca_cq cq;
 	struct mlx5_vhca_qp *host_qp;
 	struct mlx5_vhca_qp *fw_qp;
 	struct mlx5_nb nb;
-	int status;
 };
 
 struct mlx5vf_pci_core_device {
 	struct vfio_pci_core_device core_device;
 	int vf_id;
 	u16 vhca_id;
+	/* Flags only modified on setup/release - bitfield ok */
 	u8 migrate_cap:1;
-	u8 deferred_reset:1;
-	u8 mdev_detach:1;
-	u8 log_active:1;
 	u8 chunk_mode:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	u8 mdev_detach;
+	u8 log_active;
+	u8 deferred_reset;
 	struct completion tracker_comp;
 	/* protect migration state */
 	struct mutex state_mutex;
-- 
2.53.0


