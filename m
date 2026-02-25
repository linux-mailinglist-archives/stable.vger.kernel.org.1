Return-Path: <stable+bounces-218193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AnSEjxRnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:32:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A0618EF4C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9CAA3029675
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BF325332E;
	Wed, 25 Feb 2026 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PmLZkq9E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FD324A06D;
	Wed, 25 Feb 2026 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982983; cv=none; b=SEwyW/KS9Bda5AcONOxwHG12G18U6sblc1d7TvhvJjjw1L5CJBwan0NpvOmStcBkoCRLR/3ivqbHYUb+Cb2RH+Sb4I3GgGFsv/6OI2izp42wgwfPQowq9+dVY1zAMdp1O2GGc6qu+EI+EDH25PpNAyLVOdBRTE6gs4VMmYAVeF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982983; c=relaxed/simple;
	bh=2iPUfU4+NcgkRkG848MzbsF0MTQSZpAIPq3cqxTXAW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMohHMKUeQZEkC55e0YOsNRRJTpcISFveBhySN2e3zDr2/EN1eZJ2SIu5HiMNc9cjolySauN3KkVi6Z6nSiCHjCu5EE+/Dl08D16Dh/O8bI4NtYhi5fKWe2NtpW9boWzl6KRuJCtvZ8+z+FAS9TyX+SoaBAPENjdCVT7AUMHA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PmLZkq9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1F5C116D0;
	Wed, 25 Feb 2026 01:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982983;
	bh=2iPUfU4+NcgkRkG848MzbsF0MTQSZpAIPq3cqxTXAW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmLZkq9EMUfVaY8pQWxIyBBTa9Pr7vJDWZCekpVIxECAcpXxzWsNCtIoO/maRND86
	 /UIGmNc0qd2EOxu0xO7kAGkjIuc+bXoBu57aa1oeP59/AcMmWAUkWY1V473q7Ct+oJ
	 BbKF33fGAPoBJlXOBFxyb4m1RSVOZbFUw0TyDnis=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jingzhou Zhu <newwheatzjz@zohomail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 153/781] arm64: dts: qcom: sdm850-huawei-matebook-e-2019: Remove duplicate reserved-memroy nodes
Date: Tue, 24 Feb 2026 17:14:22 -0800
Message-ID: <20260225012403.412381388@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218193-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 74A0618EF4C
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jingzhou Zhu <newwheatzjz@zohomail.com>

[ Upstream commit a499c40ccd8e748ef363e2d13fb7a5c0ed6a788a ]

The adsp_mem and slpi_mem defined in sdm845.dtsi work well. Remove these
nodes here to avoid redefinition.

Signed-off-by: Jingzhou Zhu <newwheatzjz@zohomail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251208031511.3284-2-newwheatzjz@zohomail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: bc11f6f1d247 ("arm64: dts: qcom: sdm850-huawei-matebook-e-2019: Correct ipa_fw_mem for the driver to load successfully")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts   | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts b/arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts
index 0ef9ea38a424a..a5f025ae7dbe6 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts
@@ -30,9 +30,7 @@
 /delete-node/ &ipa_fw_mem;
 /delete-node/ &ipa_gsi_mem;
 /delete-node/ &gpu_mem;
-/delete-node/ &adsp_mem;
 /delete-node/ &wlan_msa_mem;
-/delete-node/ &slpi_mem;
 
 / {
 	model = "Huawei MateBook E 2019";
@@ -145,20 +143,11 @@ wlan_msa_mem: wlan-msa@8c400000 {
 			no-map;
 		};
 
-		adsp_mem: adsp@8c500000 {
-			reg = <0 0x8c500000 0 0x1a00000>;
-			no-map;
-		};
-
 		ipa_fw_mem: ipa-fw@8df00000 {
 			reg = <0 0x8df00000 0 0x100000>;
 			no-map;
 		};
 
-		slpi_mem: slpi@96700000 {
-			reg = <0 0x96700000 0 0x1200000>;
-		};
-
 		gpu_mem: gpu@97900000 {
 			reg = <0 0x97900000 0 0x5000>;
 			no-map;
-- 
2.51.0




