Return-Path: <stable+bounces-218192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEESB8hRnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4FE18F09F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA61D31627B4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD282505B2;
	Wed, 25 Feb 2026 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rbEQhjup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA331D5ABA;
	Wed, 25 Feb 2026 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982981; cv=none; b=TCjw3/AZ9gPhPtctiFayULDJ7TNIYKkSLTunMvDF7ro8lXPFLyfQn2dmSEiH4mjcEoP5al9MVC69CGNfQEZViUAbW83OuZRIuJPT8FT6TeoUbVbnWAYaATu1y3PxQO8HdwlO3BE8R8OV/mW+L1Uvhgzrl/UNTjSZv88hnAYDGKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982981; c=relaxed/simple;
	bh=K22Pfp2ZtfRIavimQH3J3xuv67QpNU+ogT9xDdTZncY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jM6aRtRj9350bJCfwjVHKBKkOvjpiNCJCuMcwgjLEDd3vfWSDQ0xYL9WHq/JumjJ14yA3aWCUL2ItB6Wk12D7BfzeNkMHwMEMrb2bwyQOSXb++I3unGK9TQSyP8/8HKxKu1t252ELkUYlN1dy6xZtdRP5OrvRALQpZkOThH/yhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rbEQhjup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84793C116D0;
	Wed, 25 Feb 2026 01:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982981;
	bh=K22Pfp2ZtfRIavimQH3J3xuv67QpNU+ogT9xDdTZncY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rbEQhjupvIHIJ8HFQEevSmQHYh55QVPmBAoRaXVoJHl7JHrhH3Ccdg1j37lG1jR69
	 /IxD4ESDpPDWSwdCPWGSERI9pkpzUVPK6KLm7BGv8mkzGFePd9+DqcOeR/0HqthaTK
	 nmxv+3kdAemN7c9cVDTcXOMswL+hQv8GW7FtJT80=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 152/781] arm64: dts: qcom: sm8250-hdk: specify ZAP firmware name
Date: Tue, 24 Feb 2026 17:14:21 -0800
Message-ID: <20260225012403.389855883@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218192-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8C4FE18F09F
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit 95c121244a5d46435559bc74dbc7b5519394db08 ]

The DT file has GPU node enabled, but doesn't specify the file name of
the ZAP firmware, which means using a default file name. Specify the
name to the ZAP shader firmware, pointing to the file in the
linux-firmware repo.

Fixes: 04a3605b184e ("arm64: dts: qcom: add sm8250 GPU nodes")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251213-zap-names-v1-2-c889af173911@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250-hdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-hdk.dts b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
index f5c193c6c5f9b..3ea9d2b1a7d58 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
@@ -373,6 +373,10 @@ &gpu {
 	status = "okay";
 };
 
+&gpu_zap_shader {
+	firmware-name = "qcom/sm8250/a650_zap.mbn";
+};
+
 &pon {
 	mode-bootloader = <0x2>;
 	mode-recovery = <0x1>;
-- 
2.51.0




