Return-Path: <stable+bounces-273730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q4GZHXvnVGqBgwAAu9opvQ
	(envelope-from <stable+bounces-273730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:26:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F298F74B8C5
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:26:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=qhqQY1t4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273730-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-273730-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DC1E30AD132
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764404252BB;
	Mon, 13 Jul 2026 13:19:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B11F423A87
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:19:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948777; cv=none; b=Ecj7lX1+DIOXlRy9YMfHGlF7qX6efiCigWWv6JBdUvWHvGd//0rjxNEgl2d+KBFY8hUHd0HouM3lNmAvxCmsa7Qp/PsmST6d7FZsFk6n06hHxwgyFEw3e2FWsuHOhTL35Wp5i9eVgeKcnBPwKDYfS3bFwNftzDf8znQ3O5C+hzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948777; c=relaxed/simple;
	bh=KlybwiiUwz8nuLQF1/VHcg21EeJGJGsQkB5npa7leEQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CU1ZI6EThPT4ce6yfFMGblT9ElFIvfwDuPdbhXIJSRqvYtSesPnkIgTelkyAStJEUKn+/39QICOWf2uwZGOzX4egfoQ6rI1TWKXXpLvvaVSSsXY4T66qxRhZDeCBWloMpAnyBSPA6u0YrB35M+rjsYk/jfoGMi+jYll6EvmIX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qhqQY1t4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703121F000E9;
	Mon, 13 Jul 2026 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948775;
	bh=Ub0y/6IdXTMsFk5dSbZb8fg+7omdqt5T2wrzzSlCyH4=;
	h=Subject:To:Cc:From:Date;
	b=qhqQY1t48+vssA9KN06+wuHVKZyYpvJUuiAGonM7mNAwfEa6U54ZLy7AYPc1CD/h1
	 29I37/jSNZs9frAR7rO8tOCN/d0Mgn/8QeybvwYeLJdeNBO8vI/vAzmW9dtUBNNh1W
	 xTg14J40sfNjV5b0ILNIj+ivAyATuSKsUvqkeQTw=
Subject: FAILED: patch "[PATCH] vfio/mlx5: Fix racy bitfields and tighten struct layout" failed to apply to 6.12-stable tree
To: alex.williamson@nvidia.com,alex@shazbot.org,kevin.tian@intel.com,yishaih@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:07:42 +0200
Message-ID: <2026071342-scrooge-clay-0479@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273730-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alex.williamson@nvidia.com,m:alex@shazbot.org,m:kevin.tian@intel.com,m:yishaih@nvidia.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,intel.com:email,shazbot.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F298F74B8C5


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f2365a63b02ddea32e7db78b742c2503ec7b81f1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071342-scrooge-clay-0479@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2365a63b02ddea32e7db78b742c2503ec7b81f1 Mon Sep 17 00:00:00 2001
From: Alex Williamson <alex.williamson@nvidia.com>
Date: Mon, 15 Jun 2026 13:12:32 -0600
Subject: [PATCH] vfio/mlx5: Fix racy bitfields and tighten struct layout

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

diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index deed0f132f39..c86d8b243a52 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -158,26 +158,29 @@ struct mlx5_vhca_qp {
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
 	u8 mig_state_cap:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	u8 mdev_detach;
+	u8 log_active;
+	u8 deferred_reset;
 	struct completion tracker_comp;
 	/* protect migration state */
 	struct mutex state_mutex;


