Return-Path: <stable+bounces-213256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDQ/DeoGgmn2OAMAu9opvQ
	(envelope-from <stable+bounces-213256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:32:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C443DA9F3
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10DE53040451
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911B23A901D;
	Tue,  3 Feb 2026 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QvxMH6Qx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B3E3A4F39
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128827; cv=none; b=ZGtztYWeGnX/e3CL0CYdax6y2P/nAvcXzLXGXAqVwwWxFDHNrtAOkoPjTQ9YvOHyyW+PeSx6YEV2C270VLeSDfN+/O1du+GiRoEBrsDw7xlJgzjTEJZYx8XIZq7DnVodDoQbdlf3Mz52hY14gcae8j+IDLFRrRFGl1Q2rmFKC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128827; c=relaxed/simple;
	bh=2f8qfzDT7v0WVNjBz102OqgoktsI3JNreAShaBDy66c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YzcI9geYj+PQoDxLwKiGOX6nbXOL3F+R0GnKWzZ+o9njbiPLrPEccmJgI2OvF27GOPLLgEXiCQWSVCyZbLj7ePjT7nJknWMEdqtZUsdGsM4X1bec0Gii9J/eezUvb7j7xaOGsaTUKdbuKSV8Ubrj/X7rzAVEw81cvg75vBkWfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QvxMH6Qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AB6C116D0;
	Tue,  3 Feb 2026 14:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770128827;
	bh=2f8qfzDT7v0WVNjBz102OqgoktsI3JNreAShaBDy66c=;
	h=Subject:To:Cc:From:Date:From;
	b=QvxMH6Qx2vOSr+wJYVpmETshsJXnmELit6MC7ZQcd9/7v7GBn5jiyReH9h7PKKJQn
	 vNoQtJ+WRV4ot8QSj6SR/BlOySkfF782uT0fnW8r6gM2F8BGtfaanTpTaM7wyK5h6d
	 WnIxbFJ4JDXAaXg+WNMGI/GE/9MYKcY6rmO+AjUo=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix NULL pointer dereference in" failed to apply to 6.6-stable tree
To: jond@wiz.io,Philip.Yang@amd.com,alexander.deucher@amd.com,timur.kristof@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2026 15:26:58 +0100
Message-ID: <2026020358-resemble-wildness-53b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213256-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[wiz.io,amd.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,gitlab.freedesktop.org:url,gregkh:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C443DA9F3
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8b1ecc9377bc641533cd9e76dfa3aee3cd04a007
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020358-resemble-wildness-53b5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8b1ecc9377bc641533cd9e76dfa3aee3cd04a007 Mon Sep 17 00:00:00 2001
From: Jon Doron <jond@wiz.io>
Date: Sat, 20 Dec 2025 15:04:40 +0200
Subject: [PATCH] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_gmc_filter_faults_remove
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
ih2 interrupt ring buffers are not initialized. This is by design, as
these secondary IH rings are only available on discrete GPUs. See
vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
AMD_IS_APU is set.

However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
get the timestamp of the last interrupt entry. When retry faults are
enabled on APUs (noretry=0), this function is called from the SVM page
fault recovery path, resulting in a NULL pointer dereference when
amdgpu_ih_decode_iv_ts_helper() attempts to access ih->ring[].

The crash manifests as:

  BUG: kernel NULL pointer dereference, address: 0000000000000004
  RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
  Call Trace:
   amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
   svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
   amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
   gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
   amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
   amdgpu_ih_process+0x84/0x100 [amdgpu]

This issue was exposed by commit 1446226d32a4 ("drm/amdgpu: Remove GC HW
IP 9.3.0 from noretry=1") which changed the default for Renoir APU from
noretry=1 to noretry=0, enabling retry fault handling and thus
exercising the buggy code path.

Fix this by adding a check for ih1.ring_size before attempting to use
it. Also restore the soft_ih support from commit dd299441654f ("drm/amdgpu:
Rework retry fault removal").  This is needed if the hardware doesn't
support secondary HW IH rings.

v2: additional updates (Alex)

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3814
Fixes: dd299441654f ("drm/amdgpu: Rework retry fault removal")
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Jon Doron <jond@wiz.io>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 6ce8d536c80aa1f059e82184f0d1994436b1d526)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7e623f91f2d7..d9c7ad297293 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -498,8 +498,13 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
 
 	if (adev->irq.retry_cam_enabled)
 		return;
+	else if (adev->irq.ih1.ring_size)
+		ih = &adev->irq.ih1;
+	else if (adev->irq.ih_soft.enabled)
+		ih = &adev->irq.ih_soft;
+	else
+		return;
 
-	ih = &adev->irq.ih1;
 	/* Get the WPTR of the last entry in IH ring */
 	last_wptr = amdgpu_ih_get_wptr(adev, ih);
 	/* Order wptr with ring data. */


