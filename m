Return-Path: <stable+bounces-241230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NYgKTsI72lv4QAAu9opvQ
	(envelope-from <stable+bounces-241230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:54:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC74346DE2C
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 567233008093
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 06:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548D038F92A;
	Mon, 27 Apr 2026 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DHEBA3WS"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50C3264FA;
	Mon, 27 Apr 2026 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272848; cv=none; b=Nb91qVyP5HGK5+0fmcdDUd7h3JgfNMFPNrjq+4m70uLKNdaCtiqSIxRzgbpS42r1bTu9KZ9Y0SgbTAfDgKyQOqUC821YlGWVKbstJoNCEcMxoOchlk+svf0f4VctpmqmxHHwnfMRHYRu2PUbYdb8A7BIBC3KhV+eeUF9kWH1mJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272848; c=relaxed/simple;
	bh=5pmjoQwXXDvIIwrd/hUliaqS1NU1QHRQbjRpwSpTFp8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=daSLRcyhBazfq4nr5eKxHqrVeoCSvgt3bS7q5hXT34pY4b5H2QH3euOG+Xnr0HhEJIWLFFfT9P6dYpZKieeseeWQMzVewXj0zih1iF+mYzCjW5HA/0z1A/OkX4YwjjCJoFYn1GSjTiCL955/UtrYZIBr8VCb1OHZSroxCr/HjBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DHEBA3WS; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777272838; bh=5UBp3KqLQYq5H66V3UQ+tPp0R9jsr7Dkgf4cgEHDd64=;
	h=From:To:Cc:Subject:Date;
	b=DHEBA3WShpVKLtdy41Zi2ISQrcFh3XizwSDTNyvcq7V1sFjwWA/tz2/3TXToOBw5Z
	 eQG2n7iqajKhU406xxwZX85AVwBiCFn6kLuDXpV9QC6FvJt3ZK6DF5yj3Q1q6Q08l0
	 jRvl+1+D2d3YDlf4Hepmev0W6rnxfvB5B1gZIoBs=
Received: from NTT-kernel-dev ([60.247.85.88])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id D76A3CA9; Mon, 27 Apr 2026 14:53:54 +0800
X-QQ-mid: xmsmtpt1777272834t15e0c2qn
Message-ID: <tencent_DF9B8FD7455ECB4DA21FCE928F6DDF02F009@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XDfIWje85BK+WO/QClslP1lf9oNtgWZ7od6+yf8Jo/JSjWlG/YP
	 pgro8EMk9c60MfQsfdGinse4Af36VHWbSf5bQhi4kHcL96d/4qAh0oyiIELc/K7s9gOXVbR6Jypk
	 3mHp3s/M22ZDxaM9zcB+kt2/sbkgmSVp9BLJYusWWd5M4l3Jj7JVCFLkNracKaHTI6SpTgc3PI8a
	 Z1EJ8MgkDpJB5Q/tF5HD1M6Pcugmveg3KBntyALSMOaOim/+K4dvmLfJOhZ/MkUavKB3dx7Si3QL
	 z1oQkspOunquysggNSBtFSUEJ0cxILzsakYL4sgCpAqBRVzqCKawKWstdyVzTwBMfGVWOFeNR++J
	 va+P14HF4TnhYeYwH9TLDwvmOpH3QC09S3HugveO7cYNATsH1GDKVClGX13ZfbXcFyTJrXztafBs
	 cS0hdfMhV7qi++EPsQYuuXIMtlHg46nUOwQbnMGzm1k+Ywk2anKO9Xgs8S31NC7fN7I5gw5iYhAX
	 sWuoqTHjebZM5fo+zfOlWK0Ji1z5wm16t0p0kKVPh997sv3ub9S5Krxpkx7HntKQBGndqFKip22W
	 vNg6PMGencNBJx40sP7l10eobYUg9UABvGWd8MaZq4KWX/HvZxKi5+FEPUqcJPYgazTRzRyqt+Te
	 r/LbddOuGefHMIN2jg4yrLUEmTDyCD2ZSKW9xQvfBL2Fm5zseL/Aqo5vpSaCOWBmA2l80wLWUgyF
	 c0Jt8wnYiAsB6K9xvbXneBpMTKCEcSUwQWIQdPgW4vF8r5U/SI6x83BzWyfdck5cxavjQrP6jr6d
	 gAVWh39Pjl6+jTg8DtTDB3/ANaXlUGfFgItfpe1uX/D/6DhjotZQZwlGR9jM7gq2B2VQU/OlT9Ke
	 gAsegVwDzqLtkPoi8XY5TeSmKIbA2dc75RF7wvMKmn69WwFic0Oa+LvReurhZka1aNLL81x/HNyt
	 h2xdPcDql1SjZ8JSopp4tPvpFsxpa1FLKR5GunBFLeIPdkhBjZ4Sgrz/JUvg+/NVt5CfV3U3Cr0U
	 TzTqodQK0NLbwr/cJJILOCo0WaTRcu1s2znf5VaKqRU/8i0mJeSwW3E/UeYnzlhLUUA6vmyCntUa
	 nnEfo3
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Fang Wang <32840572@qq.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	tvrtko.ursulin@igalia.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Jesse.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 6.6.y 2/2] drm/amdgpu: Limit BO list entry count to prevent resource exhaustion
Date: Mon, 27 Apr 2026 14:53:54 +0800
X-OQ-MSGID: <20260427065354.4119862-1-32840572@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC74346DE2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241230-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[32840572@qq.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email,qq.com:email,qq.com:dkim,qq.com:mid]

From: "Jesse.Zhang" <Jesse.Zhang@amd.com>

[ Upstream commit 6270b1a5dab94665d7adce3dc78bc9066ed28bdd ]

Userspace can pass an arbitrary number of BO list entries via the
bo_number field. Although the previous multiplication overflow check
prevents out-of-bounds allocation, a large number of entries could still
cause excessive memory allocation (up to potentially gigabytes) and
unnecessarily long list processing times.

Introduce a hard limit of 128k entries per BO list, which is more than
sufficient for any realistic use case (e.g., a single list containing all
buffers in a large scene). This prevents memory exhaustion attacks and
ensures predictable performance.

Return -EINVAL if the requested entry count exceeds the limit

Reviewed-by: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 688b87d39e0aa8135105b40dc167d74b5ada5332)
Cc: stable@vger.kernel.org
Signed-off-by: Fang Wang <32840572@qq.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index db0a1c828fe1..4efdc49d1015 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -36,6 +36,7 @@
 
 #define AMDGPU_BO_LIST_MAX_PRIORITY	32u
 #define AMDGPU_BO_LIST_NUM_BUCKETS	(AMDGPU_BO_LIST_MAX_PRIORITY + 1)
+#define AMDGPU_BO_LIST_MAX_ENTRIES	(128 * 1024)
 
 static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
 {
@@ -201,6 +202,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
 
+	if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
+		return -EINVAL;
+
 	/* copy the handle array from userspace to a kernel buffer */
 	if (likely(info_size == bo_info_size)) {
 		info = vmemdup_array_user(uptr, bo_number, info_size);
-- 
2.34.1


