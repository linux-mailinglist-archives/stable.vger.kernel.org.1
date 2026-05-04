Return-Path: <stable+bounces-243839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGi6KA2w+GkPzAIAu9opvQ
	(envelope-from <stable+bounces-243839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:41:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF34BFE1D
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CFB6301E77A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1323E1238;
	Mon,  4 May 2026 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gy/TYIKo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E51FB1;
	Mon,  4 May 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904909; cv=none; b=QO7mQS16RawDTM1OEm9V008ZfRiyyEjwEGukqO+VhMyu3ZfY+LRTddEHfnME7sYQeVwhU0rsO7TA27jPRHEonrrvvfxW2TzZts3OpjqziaJ7nC06tK49ZctFIUuBbSgaOqSPuIAiWcaA/IJ33iOERJEzvwNX2bksmu3nk5CvMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904909; c=relaxed/simple;
	bh=k8xvZoIidptCSrYPe5OMfqqKr0f2UR19oxWDoVxZ5ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MI8Opzl3mjWhYgFsogzjm8cxYihx3YeeBLtJN8jHZGVEQ/yaICkUXP4WMf6hdOClOx6w0nrp51DH3UvKi3x1ERDaxhJa6g5KoNyvVTuF74wg+YG3JXr+RUROZGcVZYeHymsp+QcgFqAqCPROL0qQz9MuF/0uYTy/FEiqyXNOizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gy/TYIKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55965C2BCB8;
	Mon,  4 May 2026 14:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904909;
	bh=k8xvZoIidptCSrYPe5OMfqqKr0f2UR19oxWDoVxZ5ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gy/TYIKoEqLn7BY/JRPtB6OoVO76sc02rlzKfxTTF0F8VWnA0xlVc6Pa0gTIsuOqL
	 s0bzm1Ea/mlFuQUzbgfTjXwbkxHrherex9fEVyOKblsbJmBvdtnanPgsfOrrlcNwY0
	 uIPLk8DfdE+Tfxl7hN9mrGF2Yttl7oResuJ4l+s4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arjan van de Ven <arjan@linux.intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12 212/215] drm/amdgpu: fix zero-size GDS range init on RDNA4
Date: Mon,  4 May 2026 15:53:51 +0200
Message-ID: <20260504135138.567903851@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 49AF34BFE1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243839-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:email,fenrus.org:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.freedesktop.org:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arjan van de Ven <arjan@linux.intel.com>

commit 095a8b0ad3c3b5cdc3850d961adb8a8f735220bb upstream.

RDNA4 (GFX 12) hardware removes the GDS, GWS, and OA on-chip memory
resources. The gfx_v12_0 initialisation code correctly leaves
adev->gds.gds_size, adev->gds.gws_size, and adev->gds.oa_size at
zero to reflect this.

amdgpu_ttm_init() unconditionally calls amdgpu_ttm_init_on_chip() for
each of these resources regardless of size. When the size is zero,
amdgpu_ttm_init_on_chip() forwards the call to ttm_range_man_init(),
which calls drm_mm_init(mm, 0, 0). drm_mm_init() immediately fires
DRM_MM_BUG_ON(start + size <= start) -- trivially true when size is
zero -- crashing the kernel during modprobe of amdgpu on an RX 9070 XT.

Guard against this by returning 0 early from
amdgpu_ttm_init_on_chip() when size_in_page is zero. This skips TTM
resource manager registration for hardware resources that are absent,
without affecting any other GPU type.

DRM_MM_BUG_ON() only asserts if CONFIG_DRM_DEBUG_MM is enabled in
the kernel config.  This is apparently rarely enabled as these chips
have been in the market for over a year and this issue was only reported
now.

Link: https://lore.kernel.org/all/bug-221376-2300@https.bugzilla.kernel.org%2F/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221376
Oops-Analysis: http://oops.fenrus.org/reports/bugzilla.korg/221376/report.html
Assisted-by: GitHub Copilot:Claude Sonnet 4.6 linux-kernel-oops-x86.
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5719ce5865279cad4fd5f01011fe037168503f2d)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -75,6 +75,9 @@ static int amdgpu_ttm_init_on_chip(struc
 				    unsigned int type,
 				    uint64_t size_in_page)
 {
+	if (!size_in_page)
+		return 0;
+
 	return ttm_range_man_init(&adev->mman.bdev, type,
 				  false, size_in_page);
 }



