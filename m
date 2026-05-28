Return-Path: <stable+bounces-255405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHi3E6SiGGqblggAu9opvQ
	(envelope-from <stable+bounces-255405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF535F83BC
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9337312BEE4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA12318EE1;
	Thu, 28 May 2026 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PNSUwxQT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2867F32ABC0;
	Thu, 28 May 2026 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998818; cv=none; b=dnc9kny1d2WHayPjTGW/3wQii+XD0F3wHCegF/xsQkeMmh97DkbtV8UbAJ7dsTaQev6y1HzYQXsI0VnoIelit+Rh8bL2cE5Gks+xDFBjHc9DfOvs3FHOwGEVjecUKV0gWDXMNvf1JPVU5oV6JUn/N81wD5QfRjy6nOlH+9QMdBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998818; c=relaxed/simple;
	bh=3hSYoKAqMr9KUlxPujgXh1fm8Ea6EkG3GKEkCv1YjTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDDCxMW2mqUPvk3DJf1bpzyrQsA/HLC55130gGkeoO822ZBzRO42z4ek2TsRVdymHpIQ11UbiQPWsHTtdF95x77WB61HYkfVHzWF/7WE7lZPxcvIq0OgypeUY/IYCAHtoV4WvF+M7Ifd7ds7BTC9gG5igBZnaEIxT4+V3OvjQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PNSUwxQT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0551F000E9;
	Thu, 28 May 2026 20:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998816;
	bh=rU6KA0cwShWjFUQs7p7wUqQM7DGaqlOhu5PN9EregaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PNSUwxQTKAogwHvFE6UJ3iK1edIF60h/SnCZJSFwTYCwePJJoPNOE2kkpGimnuzhW
	 9ELQ+UAgCQjZ5UCvHCcetlYUk4GvReXTHwM7hMcYGFLZFteiln33MZRNfGARnynmqB
	 LsV54XkSiDqJaqWZuA526bCC8GTcDxj+ANOGymho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <rob.clark@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 307/461] drm/msm/adreno: fix userspace-triggered crash on a2xx-a4xx
Date: Thu, 28 May 2026 21:47:16 +0200
Message-ID: <20260528194656.162543277@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-255405-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email,patchwork.freedesktop.org:url]
X-Rspamd-Queue-Id: DBF535F83BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit 2b4abf879360ea00a9e2b46d2d15dcdbc0687eed ]

Before a5xx Adreno driver will not try fetching UBWC params (because
those generations didn't support UBWC anyway), however it's still
possible to query UBWC-related params from the userspace, triggering
possible NULL pointer dereference. Check for UBWC config in
adreno_get_param() and return sane defaults if there is none.

Fixes: a452510aad53 ("drm/msm/adreno: Switch to the common UBWC config struct")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/717778/
Message-ID: <20260411-adreno-fix-ubwc-v3-1-4983156f3f80@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 277ef0c5c08d1..682a09a376fbf 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -424,15 +424,21 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		*value = vm->mm_range;
 		return 0;
 	case MSM_PARAM_HIGHEST_BANK_BIT:
+		if (!adreno_gpu->ubwc_config)
+			return UERR(ENOENT, drm, "no UBWC on this platform");
 		*value = adreno_gpu->ubwc_config->highest_bank_bit;
 		return 0;
 	case MSM_PARAM_RAYTRACING:
 		*value = adreno_gpu->has_ray_tracing;
 		return 0;
 	case MSM_PARAM_UBWC_SWIZZLE:
+		if (!adreno_gpu->ubwc_config)
+			return UERR(ENOENT, drm, "no UBWC on this platform");
 		*value = adreno_gpu->ubwc_config->ubwc_swizzle;
 		return 0;
 	case MSM_PARAM_MACROTILE_MODE:
+		if (!adreno_gpu->ubwc_config)
+			return UERR(ENOENT, drm, "no UBWC on this platform");
 		*value = adreno_gpu->ubwc_config->macrotile_mode;
 		return 0;
 	case MSM_PARAM_UCHE_TRAP_BASE:
-- 
2.53.0




