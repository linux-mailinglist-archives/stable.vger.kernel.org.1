Return-Path: <stable+bounces-249203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPpdHHy9CmoE7QQAu9opvQ
	(envelope-from <stable+bounces-249203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:19:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1744A5675A3
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5085F3000098
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B13C3CF96B;
	Mon, 18 May 2026 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mg7S4DdU"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB73CFF68;
	Mon, 18 May 2026 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088759; cv=none; b=caNEX2QsmfeCO5+He2pk++BWaWe46Q9KU8WfjrG+96MXNlT60EmHLtLpV88lMe73ytxlTFHFvLkIWqc7zc77tY/2M1EauEpfWgCz6dVndVHFVbOyrB01XhcMQeUkZ4V5ffHBjvJzT8Uxe/ekQ7kIjLa2GOARWsLOUhVlhre7tvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088759; c=relaxed/simple;
	bh=2FYj9vYw/zu9Qxh92/24buFODjvu58cRIDsI+yc0nUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MEYz7dHtIKgxb8YGCrRvqJUA0G6nDrHtoH0zUEa3AGg+gREOu7zzxE1TF0zndnEiNl4Kz9BmgTss4EK5eoJOuW8r4WscxpB20ayMhzDUcPbOzwUg+lLU0R4SaVeXyzo3qVxXxy7no2SSlV1CZVfwr+Whp345aajB4JqKfhQGEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mg7S4DdU; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nG
	SgpaIBk8nLNUChGbs1Wkv6iohQmuUEhuRd5jny1pg=; b=mg7S4DdUTca+aU45q1
	m5RqCAZDzZIEM2B2Kkc+fqMjAfgWBPHakO9X3HKxAZeGthCh2xnrDyFRiEu52FEY
	gR4eEwgEnlOLJ+MMEWy9e+3CbhyQc+qN+WpYwFkJ87hTvBYJS/wt7bh6Ey7apgLF
	kUavFYhnPtvryJTbHKbZl/NWc=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3f8gYvQpqmkBDCA--.6152S2;
	Mon, 18 May 2026 15:17:52 +0800 (CST)
From: w15303746062@163.com
To: zack.rusin@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH] drm/vmwgfx: Fix hrtimer interrupt storm due to 0-period vblank
Date: Mon, 18 May 2026 15:17:41 +0800
Message-Id: <20260518071741.441794-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f8gYvQpqmkBDCA--.6152S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4UKF15tF15KFyDCrW5Awb_yoW5ArWfpr
	WDKr9rtr1jyFW2ga9rAwn3uFn5Wws5GFy7tFZ7KwnrZw4qkFy7A3WrKF45KFy7Cr4DA3yI
	qF48Jrs8uF4jkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeSoXUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4wCUeGoKvSCBLwAA3c
X-Rspamd-Queue-Id: 1744A5675A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249203-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[broadcom.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,xidian.edu.cn:email]
X-Rspamd-Action: no action

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

When vmwgfx is configured to use VKMS for vblank simulation, it relies
on drm_calc_timestamping_constants() to calculate the frame duration
(vblank->framedur_ns).

However, Fuzzers (like Syzkaller) can submit extremely malicious
display modes through DRM_IOCTL_MODE_SETCRTC. If the user-space passes
a mode with a massive pixel clock (crtc_clock) and small resolution
(htotal/vtotal), the integer division in drm_calc_timestamping_constants()
truncates the result to 0.

Consequently, vmw_vkms_enable_vblank() blindly sets the hrtimer period
to 0. When the timer is started, it fires instantly and continuously.
Because hrtimer_forward_now() cannot advance time for a 0-period,
the overrun value skyrockets, locking the CPU in an infinite hard-IRQ
loop (vkms_vblank_simulate() -> HRTIMER_RESTART).

This completely starves the CPU, leading to massive RCU stalls and
blocking other essential tasks (like jbd2 and writeback workers)
indefinitely:

  [ C1] vkms_vblank_simulate: vblank timer overrun
  ...
  INFO: task kworker/u18:2:50 blocked for more than 143 seconds.
  Workqueue: writeback wb_workfn (flush-8:0)
  Call Trace:
   <TASK>
   __schedule+0x1044/0x5bb0
   wbt_wait+0x1c8/0x3b0
   blk_mq_submit_bio+0x29fa/0x31f0
   submit_bio_noacct+0xca7/0x1f90
   ext4_bio_write_folio+0x95a/0x1d10
   ...

  NMI backtrace for cpu 1
  Call Trace:
   <IRQ>
   vkms_vblank_simulate+0x8f/0x390
   __hrtimer_run_queues+0x1f5/0xb30
   hrtimer_interrupt+0x39a/0x880

Fix this DoS vulnerability by adding a defensive sanity check in
vmw_vkms_enable_vblank() to reject a 0-ns frame duration, allowing
DRM core to gracefully fallback/reject the mode without crashing.

Fixes: cd2eb57df1b8 ("drm/vmwgfx: Implement virtual kms")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 5abd7f5ad2db..b3950ae424f3 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -288,6 +288,16 @@ vmw_vkms_enable_vblank(struct drm_crtc *crtc)
 
 	drm_calc_timestamping_constants(crtc, &crtc->mode);
 
+	/*
+	 * DEFENSIVE CHECK:
+	 * drm_calc_timestamping_constants() can calculate a framedur_ns
+	 * of 0 if user-space provides a malicious mode with a huge
+	 * crtc_clock and small htotal/vtotal due to integer division
+	 * truncation. Prevent hrtimer interrupt storms by refusing such modes.
+	 */
+	if (WARN_ON_ONCE(vblank->framedur_ns == 0))
+		return -EINVAL;
+
 	hrtimer_setup(&du->vkms.timer, &vmw_vkms_vblank_simulate, CLOCK_MONOTONIC,
 		      HRTIMER_MODE_REL);
 	du->vkms.period_ns = ktime_set(0, vblank->framedur_ns);
-- 
2.34.1


