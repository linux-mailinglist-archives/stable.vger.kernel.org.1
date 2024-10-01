Return-Path: <stable+bounces-78564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 122E998C478
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708D41F24169
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B608D1CC15C;
	Tue,  1 Oct 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="aSjv5AJq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0371CC154
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803927; cv=none; b=M1RD8drpfI1huiziaLIZGwMH5VfpvYD1nlHjT+F/dN83aO5iFr2QQvqZYaAnHBlmH5BNCgrV5BhQbiK1pOdvNE19SNV4BW392Chagbv5DBHPKRD/ctkWU/gKB0X5tmbDWOv4xlyuxS5sc4iICNexMOlFo2bN0gJaQoRXeJJeq/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803927; c=relaxed/simple;
	bh=C7jKZlsxIl/L+1ZX9tfJ/1h2HkHrvt7A1BO4z3COFEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jrGR4FtF2YQdDFLPR+Z+LCsXemDEru9y9IG0WVTEOYHT45mHqbpIVb5G3FzLQl4YBDWP9xVgEMQ/H+PSGre+23az3V2NNyo+xpS6xmU/bBFCpfYrm6az+BBpFAjm/ZCoUcZpWzMiINY85QGRf37zDpxRU1fotAu5j7W61opfmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=aSjv5AJq; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HgP4+GZsmotecEy91zbMMccB3LvE/1cwH/ODeCigBpQ=;
	b=aSjv5AJqO5OxXsH3ErmnmVuxB4ApKwNUKK6M4xPKEuTsQ2xL2iylHR2oKZAcRbIbCl1LeM
	OasAeLNV+oyBMwQCATlf4vtFhQJNhOPG6MuM7lljJfgsNr0boQ86EcE2lfgltT6xydicjG
	0c0ji3iaG91VOCHxmYAUsEjH0S87wN4=
Received: from g7t16451g.inc.hp.com (hpi-bastion.austin1.mail.core.hp.com
 [15.73.128.137]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-KhJaXGAoMR211dV2ljZ-Nw-1; Tue, 01 Oct 2024 13:32:03 -0400
X-MC-Unique: KhJaXGAoMR211dV2ljZ-Nw-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g7t16451g.inc.hp.com (Postfix) with ESMTPS id 375FF6000E52;
	Tue,  1 Oct 2024 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 7644C18;
	Tue,  1 Oct 2024 17:31:36 +0000 (UTC)
From: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: qin.wan@hp.com,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	mika.westerberg@linux.intel.com,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH 6.6 00/14] Backport thunderbolt fix(es) from v6.9
Date: Tue,  1 Oct 2024 17:30:55 +0000
Message-Id: <20241001173109.1513-1-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

From: Alexandru Gagniuc <mr.nuke.me@gmail.com>

These patches resolve thunderbolt issues on Intel Raptor Lake systems.
With a monitor connected to a HP Thunderbolt G4 dock, the display
sometimes stops working after resume.

The kernel reports an issue with the DisplayPort MST topology, the
full backtrace being pasted below. This failure is since v6.9-rc1 by
commit b4734507ac55 ("thunderbolt: Improve DisplayPort tunnel setup
process to be more robust"). The other commits are dependencies such
that all changes apply cleanly without needing modification.

Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414673] UBSAN: shift-out-of-boun=
ds in drivers/gpu/drm/display/drm_dp_mst_topology.c:4416:36
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414674] shift exponent -1 is neg=
ative
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414675] CPU: 0 PID: 145 Comm: kw=
orker/0:2 Tainted: G U 6.6.16 #108
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414677] Hardware name: HP HP Eli=
te t660 Thin Client/8D05, BIOS W44 Ver. 00.14.00 07/19/2024
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414678] Workqueue: events output=
_poll_execute [drm_kms_helper]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414695] Call Trace:
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414697] <TASK>
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414698] dump_stack_lvl+0x48/0x70
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414703] dump_stack+0x10/0x20
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414705] __ubsan_handle_shift_out=
_of_bounds+0x156/0x310
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414708] ? krealloc+0x98/0x100
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414711] ? drm_atomic_get_private=
_obj_state+0x167/0x1a0 [drm]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414733] drm_dp_atomic_release_ti=
me_slots.cold+0x17/0x3d [drm_display_helper]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414743] intel_dp_mst_atomic_chec=
k+0x9a/0x170 [i915]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414831] drm_atomic_helper_check_=
modeset+0x4bb/0xe20 [drm_kms_helper]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414842] ? __kmem_cache_alloc_nod=
e+0x1b3/0x320
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414845] ? __ww_mutex_lock.constp=
rop.0+0x39/0xa00
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414848] intel_atomic_check+0x113=
/0x2b50 [i915]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414936] drm_atomic_check_only+0x=
692/0xb80 [drm]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414956] drm_atomic_commit+0x57/0=
xd0 [drm]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414972] ? _pfx__drm_printfn_info=
+0x10/0x10 [drm]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.414999] drm_client_modeset_commi=
t_atomic+0x1f1/0x230 [drm]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415019] drm_client_modeset_commi=
t_locked+0x5b/0x170 [drm]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415038] ? mutex_lock+0x13/0x50
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415040] drm_client_modeset_commi=
t+0x27/0x50 [drm]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415058] __drm_fb_helper_restore_=
fbdev_mode_unlocked+0xd2/0x100 [drm_kms_helper]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415068] drm_fb_helper_hotplug_ev=
ent+0x11a/0x140 [drm_kms_helper]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415077] intel_fbdev_output_poll_=
changed+0x6f/0xb0 [i915]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415156] output_poll_execute+0x23=
e/0x290 [drm_kms_helper]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415166] ? intelfb_dirty+0x41/0x8=
0 [i915]
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415236] process_one_work+0x178/0=
x360
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415238] ? __pfx_worker_thread+0x=
10/0x10
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415240] worker_thread+0x307/0x43=
0
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415241] ? __pfx_worker_thread+0x=
10/0x10
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415242] kthread+0xf4/0x130
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415245] ? __pfx_kthread+0x10/0x1=
0
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415247] ret_from_fork+0x43/0x70
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415249] ? __pfx_kthread+0x10/0x1=
0
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415250] ret_from_fork_asm+0x1b/0=
x30
Sep 6 08:10:29 HP7c5758fc4d4f kernel: [ 89.415252] </TASK>

Gil Fine (8):
  thunderbolt: Fix debug log when DisplayPort adapter not available for
    pairing
  thunderbolt: Create multiple DisplayPort tunnels if there are more DP
    IN/OUT pairs
  thunderbolt: Make is_gen4_link() available to the rest of the driver
  thunderbolt: Change bandwidth reservations to comply USB4 v2
  thunderbolt: Introduce tb_port_path_direction_downstream()
  thunderbolt: Add support for asymmetric link
  thunderbolt: Configure asymmetric link if needed and bandwidth allows
  thunderbolt: Improve DisplayPort tunnel setup process to be more
    robust

Mika Westerberg (6):
  thunderbolt: Use tb_tunnel_dbg() where possible to make logging more
    consistent
  thunderbolt: Expose tb_tunnel_xxx() log macros to the rest of the
    driver
  thunderbolt: Use constants for path weight and priority
  thunderbolt: Use weight constants in tb_usb3_consumed_bandwidth()
  thunderbolt: Introduce tb_for_each_upstream_port_on_path()
  thunderbolt: Introduce tb_switch_depth()

 drivers/thunderbolt/switch.c  | 328 +++++++++++---
 drivers/thunderbolt/tb.c      | 784 +++++++++++++++++++++++++++-------
 drivers/thunderbolt/tb.h      |  56 ++-
 drivers/thunderbolt/tb_regs.h |   9 +-
 drivers/thunderbolt/tunnel.c  | 217 ++++++----
 drivers/thunderbolt/tunnel.h  |  26 +-
 drivers/thunderbolt/usb4.c    | 106 +++++
 7 files changed, 1225 insertions(+), 301 deletions(-)

--
2.45.1


