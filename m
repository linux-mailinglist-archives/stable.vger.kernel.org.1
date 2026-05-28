Return-Path: <stable+bounces-255392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EfVJ4uiGGrClggAu9opvQ
	(envelope-from <stable+bounces-255392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA145F8372
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6201230F4327
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764432ABC0;
	Thu, 28 May 2026 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aj2wBlx4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A02F691F;
	Thu, 28 May 2026 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998781; cv=none; b=UZ8yElCiBz3xROZZ60R6NaTPolj8MSuXEBc0k1RrXSJ/isnIdxa48cnu5M6xIxwp2up6VlC3sTw9+HDjuYtl2cnqky8uoHnVxg/xAWL5WpHWhiXoDhgXkngVHjSRe4zarvaGFtxzh3YupcD8Kxk34d5XBkWSgoxwv53Ik2Ca6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998781; c=relaxed/simple;
	bh=3FwDDwme2MD56HGVV6GS7mMTtKNVZVSRcROXoTdgsFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYCD9MjPqQAnkWY+3vghSERN2Pste4F0I1VMrLIzWCQj+ecRWGbLxIuvY3dWJnnmINsr0ce2pRA2ObpVANelQaLWiYTy+4nsmXuxFxqXDbeO8d9lJhrhlBMYnLb1S1y41aHn19HasK2RUNCjjI5jik3zQnFFu9pFdpP4FkiZN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aj2wBlx4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E400E1F000E9;
	Thu, 28 May 2026 20:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998780;
	bh=I0NfTFJcKtKeWLmyRZgnM3ImFi2tYu0q+XanW37wfDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aj2wBlx4U49VYmWiY5nj6nl1NBElH9DmkDGfLeY19uTCJQeq5nhHkNbQoVdxwfBr+
	 Nx+9liZiUJwsj9tNa3emiT59DfNC1xMOiLtq8GqqFxHmGQk3LVAX+40ej8ois64uPQ
	 kji+aQVteUW7L8BwBlnsdBcl5BYYFJIa9ctZ0ZS8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mahadevan P <mahadevan.p@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 295/461] drm/msm/dpu: Fix Kaanapali CWB register configuration
Date: Thu, 28 May 2026 21:47:04 +0200
Message-ID: <20260528194655.756888537@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255392-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,patchwork.freedesktop.org:url,qualcomm.com:email]
X-Rspamd-Queue-Id: 3EA145F8372
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

[ Upstream commit d03279f0d9fdbe6f6761f191a76093c395930018 ]

The Kaanapali DPU catalog defines kaanapali_cwb[] with the correct
CWB base addresses for this platform (0x169200, 0x169600, 0x16a200,
0x16a600), but the dpu_kaanapali_cfg struct was mistakenly pointing
to sm8650_cwb instead. The SM8650 CWB blocks sit at completely
different offsets (0x66200, 0x66600, 0x7E200, 0x7E600), so using
them on Kaanapali would program CWB registers at wrong addresses,
corrupting unrelated hardware blocks and breaking writeback capture.

Fix this by pointing .cwb to the correct kaanapali_cwb array.

Fixes: 83fe2cd56b1d ("drm/msm/dpu: Add support for Kaanapali DPU")
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/721444/
Link: https://lore.kernel.org/r/20260428-kaanapali_cwb-v1-1-51fdb2c65498@oss.qualcomm.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h
index 0b20401b04cf0..e3c47b6702f18 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h
@@ -481,7 +481,7 @@ const struct dpu_mdss_cfg dpu_kaanapali_cfg = {
 	.wb_count = ARRAY_SIZE(kaanapali_wb),
 	.wb = kaanapali_wb,
 	.cwb_count = ARRAY_SIZE(kaanapali_cwb),
-	.cwb = sm8650_cwb,
+	.cwb = kaanapali_cwb,
 	.intf_count = ARRAY_SIZE(kaanapali_intf),
 	.intf = kaanapali_intf,
 	.vbif_count = ARRAY_SIZE(sm8650_vbif),
-- 
2.53.0




