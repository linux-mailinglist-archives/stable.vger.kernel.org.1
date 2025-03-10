Return-Path: <stable+bounces-122036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B77F5A59D98
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BF23A5A32
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E2822D799;
	Mon, 10 Mar 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DqJDbeqN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC88226D0B;
	Mon, 10 Mar 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627344; cv=none; b=rxtVG09ZsIx7u8WfVFZgKSWu9iSjKMcndhAnBx2Y6Qz2ym8YkZO8YxJJ8nzyTa0hVMZ1smvhUtx3/ikQ7JcB7PkS2oHqMS44gIGWZ9N+GQro76NoXy6GZMcOISOIUfQ3hjXVinK4j/LIcqsNckolI68u96UBzb1EhStgECMecLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627344; c=relaxed/simple;
	bh=4y3Avk8pqJQqMO4MAwjPq5p7/xSqgJfyUrGEn0WhHbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVrS2aNu7SMD1iWEJdFzh+YSO05Jzy6cQ2/1r9A+dDxwsPmYXWQ/c6F2bx1xzAYpb/h4mhx6qK1vqnxhGWISF09kpAbix6SMD8X8qNou3NcLvJfY90QkKtCUs7y/E/RlE4b80RVa58200/mh1ZHLROhUsM26stzJxJN5yuvAV54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DqJDbeqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33F9C4CEE5;
	Mon, 10 Mar 2025 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627344;
	bh=4y3Avk8pqJQqMO4MAwjPq5p7/xSqgJfyUrGEn0WhHbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqJDbeqNLh/T/CkGoKia0dNvfDZGFbwngElf0VRohMnteZEXM0o0aG6FGr27Cqpxn
	 Eigu37rKxUxxKdscfbSckBPwqDv6iv49gSSJ1rlSlXQCpNthRhEuqBCMHZ2Tj7O8qj
	 gVI+nQ4kUVZ6u9O7dJf/TWVkW3G9fdNrwYgjdc2Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kenneth Feng <kenneth.feng@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 097/269] drm/amd/pm: always allow ih interrupt from fw
Date: Mon, 10 Mar 2025 18:04:10 +0100
Message-ID: <20250310170501.578274509@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kenneth Feng <kenneth.feng@amd.com>

commit da552bda987420e877500fdd90bd0172e3bf412b upstream.

always allow ih interrupt from fw on smu v14 based on
the interface requirement

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a3199eba46c54324193607d9114a1e321292d7a1)
Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1883,16 +1883,6 @@ static int smu_v14_0_allow_ih_interrupt(
 				    NULL);
 }
 
-static int smu_v14_0_process_pending_interrupt(struct smu_context *smu)
-{
-	int ret = 0;
-
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
-		ret = smu_v14_0_allow_ih_interrupt(smu);
-
-	return ret;
-}
-
 int smu_v14_0_enable_thermal_alert(struct smu_context *smu)
 {
 	int ret = 0;
@@ -1904,7 +1894,7 @@ int smu_v14_0_enable_thermal_alert(struc
 	if (ret)
 		return ret;
 
-	return smu_v14_0_process_pending_interrupt(smu);
+	return smu_v14_0_allow_ih_interrupt(smu);
 }
 
 int smu_v14_0_disable_thermal_alert(struct smu_context *smu)



