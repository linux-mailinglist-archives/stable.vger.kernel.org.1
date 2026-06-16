Return-Path: <stable+bounces-264170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LZo0HAFxMWqRjQUAu9opvQ
	(envelope-from <stable+bounces-264170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:51:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A66691715
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:51:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=0bTGzFJh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264170-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264170-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CE0F30B7588
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E04E44CF2E;
	Tue, 16 Jun 2026 15:41:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F8D44E021;
	Tue, 16 Jun 2026 15:41:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624489; cv=none; b=lAIYU7AmBlPRa9rbGb+h2UXM1s7mj29CZQlXFHBQq/fRsHGDVVS0K8VlG/Vgx+APYnp8RCb5B7dHHg+yoYzvxV84sywwvndkljKn8oS/dD0EDY1JYIAC5hvw1D9n/Qgld9lNpn2Db4SkeUE9Uv07XEdUmfzMxkqu66zKBJwsAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624489; c=relaxed/simple;
	bh=AjksXOS2H0DdijgZbpkH7GoAO3wwhnv0xKk80J5nqOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoCvSozREBCD8j77iZsCddaDWIkfehLYSmc5/1ygh+Manom7a0Uo5dASlGQ3CHyE2xyaRQywUfWhyJ+uub9DSyInQFkB2Azxm6IQR9PLCruGTrQ15rilCWqaTgJFkywaw4GIYc5bivCFB8hpDgOiXl4G0EtfFvdYSa7KSd0kokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0bTGzFJh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF081F000E9;
	Tue, 16 Jun 2026 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624488;
	bh=9+d7yA6Wpo6n/h1x2ScXz8N+gnBuxlEXz8ItrPMRj+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0bTGzFJhtnCP+XZoSCtmtHeiem6OsPYahaOEMqbEnTAcaafvsiFjbaz7GQRAxLjIi
	 M3LYgzw13eq9a2qeiyUHs1bjgVcZiuwewsjcmfyCr9bNqLpo7TG0Y6Zueb3KCj2bzW
	 6kO8yZ4L6s2uHLAZwzB5cGzJ1NvUocvqSvEjWj6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7.0 347/378] drm/amdgpu: Fix incorrect VRAM GART mappings on non-4K page size systems
Date: Tue, 16 Jun 2026 20:29:38 +0530
Message-ID: <20260616145128.432529886@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264170-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,linux.ibm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:timur.kristof@gmail.com,m:christian.koenig@amd.com,m:donettom@linux.ibm.com,m:alexander.deucher@amd.com,m:timurkristof@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9A66691715

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Donet Tom <donettom@linux.ibm.com>

commit ec4c462e2d8161b32038e21e7187f4a15fe1661d upstream.

When mapping VRAM pages into the GART page table,
amdgpu_gart_map_vram_range() assumes that the system page size is the
same as the GPU page size.

On systems with non-4K page sizes, multiple GPU pages can exist within
a single CPU page. As a result, the mappings are created incorrectly
because fewer page table entries are programmed than required.

Fix this by programming the mappings correctly for non-4K page size
systems.

Fixes: 237d623ae659 ("drm/amdgpu/gart: Add helper to bind VRAM pages (v2)")
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a8f0bc22388f74e0cf4ed8b7d1846c580eaf44cc)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -394,7 +394,8 @@ void amdgpu_gart_map_vram_range(struct a
 				uint64_t start_page, uint64_t num_pages,
 				uint64_t flags, void *dst)
 {
-	u32 i, idx;
+	u32 i, j, t, idx;
+	u64 page_base;
 
 	/* The SYSTEM flag indicates the pages aren't in VRAM. */
 	WARN_ON_ONCE(flags & AMDGPU_PTE_SYSTEM);
@@ -402,9 +403,12 @@ void amdgpu_gart_map_vram_range(struct a
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return;
 
-	for (i = 0; i < num_pages; ++i) {
-		amdgpu_gmc_set_pte_pde(adev, dst,
-			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, flags);
+	page_base = pa;
+	for (i = 0, t = 0; i < num_pages; i++) {
+		for (j = 0; j < AMDGPU_GPU_PAGES_IN_CPU_PAGE; j++, t++) {
+			amdgpu_gmc_set_pte_pde(adev, dst, start_page + t, page_base, flags);
+			page_base += AMDGPU_GPU_PAGE_SIZE;
+		}
 	}
 
 	drm_dev_exit(idx);



