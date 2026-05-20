Return-Path: <stable+bounces-251484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCBsCF31DWoz5AUAu9opvQ
	(envelope-from <stable+bounces-251484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CA5594E79
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3DCF312A8EE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6EB331220;
	Wed, 20 May 2026 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OEKsMEVq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F06B346E5E;
	Wed, 20 May 2026 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298103; cv=none; b=tQyqx81UrBVovgxSY5SSMwUkLhBefaKhmcQCtw04fdQBcO10Ve4czFn4KrTebW4JMoREPP87C/H42oF+EvsHN1Mcsn7Jmnmn2/6waEejkjMnu9CtVuTNJN6ufNtEOVtBF9vRLzAvDM8rejYjYCSBDVoZx4W47vnK9CIA0HSFplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298103; c=relaxed/simple;
	bh=klrT1YGn9AM1wckBLFNMyLoYIEAfI1xTRyQc7HxNx7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WebW+vvf8ulgaqCjUotiHVfxcxL10UjVQfBzwqIonNzAXYFtpumPCZqUEf5UlEjoTL3w8lOiK0262j5GCjKhog/fYoKTxUMQbyaRfGq1vLAnWAGLo3TtTYo10lOeTyiVlMRlVT/L6Dr8Wp+ihrhEwmrigOo2dEnFfdIrQsL0rZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OEKsMEVq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFAF1F000E9;
	Wed, 20 May 2026 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298102;
	bh=/rtrVaWBu9FOdst1WD1THyoo1407R09Q3mIE6eN8Y90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OEKsMEVqVyW0U3v/wj3gMkb8eotXn73oDj4vOFHMQcaRwNcdYvptMCA/SKOoK/Cxh
	 5hdtVN0Almx8RT5aAysF9O0Yp576Z0MOtYbp2DR8V99Rn8/7ZWwsVqH1xV0zFPx6bq
	 bYY+TQakevZyR88Q/5QTP1MgxCgyTbNX7Qplcdho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 283/957] drm/msm/dpu: drop INTF_0 on MSM8953
Date: Wed, 20 May 2026 18:12:46 +0200
Message-ID: <20260520162140.677367577@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251484-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email,patchwork.freedesktop.org:url]
X-Rspamd-Queue-Id: F2CA5594E79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit 7090420420d5a7d7c88b21d16962f2a230be3ef3 ]

There is no INTF_0 on MSM8953. Currently catalog lists dummy INTF_NONE
entry for it. Drop it from the catalog.

Fixes: 7a6109ce1c2c ("drm/msm/dpu: Add support for MSM8953")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/713990/
Link: https://lore.kernel.org/r/20260325-drop-8953-intf-v1-1-d80e214a1a75@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
index b44d02b48418f..2162ff917b0f8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h
@@ -121,13 +121,6 @@ static const struct dpu_dspp_cfg msm8953_dspp[] = {
 
 static const struct dpu_intf_cfg msm8953_intf[] = {
 	{
-		.name = "intf_0", .id = INTF_0,
-		.base = 0x6a000, .len = 0x268,
-		.type = INTF_NONE,
-		.prog_fetch_lines_worst_case = 14,
-		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
-		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 25),
-	}, {
 		.name = "intf_1", .id = INTF_1,
 		.base = 0x6a800, .len = 0x268,
 		.type = INTF_DSI,
-- 
2.53.0




