Return-Path: <stable+bounces-232320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP4gDbn/y2koNQYAu9opvQ
	(envelope-from <stable+bounces-232320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:09:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AD136DFE6
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EBB830EF6E6
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3912D7DD7;
	Tue, 31 Mar 2026 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lqsBiN9S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100802D4B40;
	Tue, 31 Mar 2026 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976446; cv=none; b=uxkMFh1IpkftJAazsWEj/kHT9BXUKk9I+9FTv5wIloz44mjtFe9vrLSrg5fQvOaC1y5WK2suYUOgDyAmIr5FpMFFnd1hO8zSTDWmxkBDHE9/Zq7ZpdGKn/+u5y7qqZpCMedLxfFsiGB0ehoPRvhKZY3u6tQyPgJ3LVU0FOrV6Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976446; c=relaxed/simple;
	bh=FcSKMKH53Q+0YKYhMLwho1jxyO9un2stX3M043iTx1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9JPmYk1NFgY66+u7bok+vJ2TKCAR28niYKpDeiwOZjx2/r9IDUr6SozkmarW9uZ0qBM95X/ViZ7sNzFXpIIIwnMu++SGD1+4cWrkSasQeHUzSeNf2wVZD6NbE/NREIJrcrdYxz86v/N8q/fVGjCpmLNvhJRCZduUADoC2pL7OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lqsBiN9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C15CC19423;
	Tue, 31 Mar 2026 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976446;
	bh=FcSKMKH53Q+0YKYhMLwho1jxyO9un2stX3M043iTx1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqsBiN9SaI1H4q6T5FOrZHDLfLRDncLpa/E3A08yB7yf2hXPzjTWYie1w0br5eJ86
	 egaOm1REY/xFBMLt128gySY9h6GfwrknBHSZdPBYppOxl89mArdMeTO/yBydRUFgrb
	 wgQmSjOMX73u1HYOCtgAtmDfi5MJyTftcTsHWb0M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 063/309] drm/amdgpu: fix gpu idle power consumption issue for gfx v12
Date: Tue, 31 Mar 2026 18:19:26 +0200
Message-ID: <20260331161755.807679693@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232320-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6AD136DFE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Wang <kevinyang.wang@amd.com>

[ Upstream commit a6571045cf06c4aa749b4801382ae96650e2f0e1 ]

Older versions of the MES firmware may cause abnormal GPU power consumption.
When performing inference tasks on the GPU (e.g., with Ollama using ROCm),
the GPU may show abnormal power consumption in idle state and incorrect GPU load information.
This issue has been fixed in firmware version 0x8b and newer.

Closes: https://github.com/ROCm/ROCm/issues/5706
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4e22a5fe6ea6e0b057e7f246df4ac3ff8bfbc46a)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 4a424c1f9d55c..c40aed5a8fc21 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -727,6 +727,9 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	int i;
 	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES mes_set_hw_res_pkt;
+	uint32_t mes_rev = (pipe == AMDGPU_MES_SCHED_PIPE) ?
+		(mes->sched_version & AMDGPU_MES_VERSION_MASK) :
+		(mes->kiq_version & AMDGPU_MES_VERSION_MASK);
 
 	memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
 
@@ -781,7 +784,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	 * handling support, other queue will not use the oversubscribe timer.
 	 * handling  mode - 0: disabled; 1: basic version; 2: basic+ version
 	 */
-	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	mes_set_hw_res_pkt.oversubscription_timer = mes_rev < 0x8b ? 0 : 50;
 	mes_set_hw_res_pkt.unmapped_doorbell_handling = 1;
 
 	if (amdgpu_mes_log_enable) {
-- 
2.51.0




