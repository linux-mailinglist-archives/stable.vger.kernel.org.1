Return-Path: <stable+bounces-218194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEiMGc5RnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FFB18F0B5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DCC431664D9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FE624A06D;
	Wed, 25 Feb 2026 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ijc3Ncam"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCFD1D5ABA;
	Wed, 25 Feb 2026 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982984; cv=none; b=OOna2wRLTtAJPmxLrYWx9RX6VGgZ1uQY6VjuMmHxa566WhUZU+EZT+tjK2VzMERBviqzSC2UK6XtNB7T1wJjKzPWUbXqEcpEqHwqwngpYgp8F82mZgGy+j8hJ625oxEuJmXYhqyhk9lhx3F4Z/8eqkzmGxMOBRsaxaxDTT2iqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982984; c=relaxed/simple;
	bh=XhjNptZwd9oWtkee2WxYrbjQG/YnqtCne8zJJlaldbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFHmjt2C6sTBO9QIdfp+unN9CtUJOI7iWmZm3db3RhqC2bLpOBee3IFVJIE4ybJcHknLQGtBv4lf4YYUX1ytOyFrsIJd8U6xrG4UhjRNbr0IiT4DLh8Ym9QCvnQwjt5hh+kiSEDpUevLFxX5Arec9T9yOJUdIJXD/7FiTE2R/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ijc3Ncam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0F0C116D0;
	Wed, 25 Feb 2026 01:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982984;
	bh=XhjNptZwd9oWtkee2WxYrbjQG/YnqtCne8zJJlaldbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijc3NcamWpm9Fgcpxj/5z/RqrbKHf+az8ueFzfEuhXKN7Z41oNSIqNw/IGoRL0DS8
	 Mt2VzsmBXpsnHeU5J/34CZe713L6v9J+QpMwSECvHxaIhCtLpCvBR1BnEFLqULUSgD
	 sXRYObKqma5uWRo0zLX8PtnobYGH5MogZGPlJhoY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jingzhou Zhu <newwheatzjz@zohomail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 154/781] arm64: dts: qcom: sdm850-huawei-matebook-e-2019: Correct ipa_fw_mem for the driver to load successfully
Date: Tue, 24 Feb 2026 17:14:23 -0800
Message-ID: <20260225012403.435844863@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-218194-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[5.213.213.224:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,8c400000:email,zohomail.com:email,8df5a000:email]
X-Rspamd-Queue-Id: D0FFB18F0B5
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jingzhou Zhu <newwheatzjz@zohomail.com>

[ Upstream commit bc11f6f1d2470fa59846be077555f9d4b7c2c0d3 ]

The ipa driver refuses to load with the old ipa_fw_mem in newer kernels.
Shrinking its size to 0x5a000 fixes the problem.

Fixes: aab69794b55d ("arm64: dts: qcom: Add support for Huawei MateBook E 2019")

Signed-off-by: Jingzhou Zhu <newwheatzjz@zohomail.com>
Link: https://lore.kernel.org/r/20251208031511.3284-3-newwheatzjz@zohomail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts b/arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts
index a5f025ae7dbe6..f048653818702 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-huawei-matebook-e-2019.dts
@@ -144,12 +144,12 @@ wlan_msa_mem: wlan-msa@8c400000 {
 		};
 
 		ipa_fw_mem: ipa-fw@8df00000 {
-			reg = <0 0x8df00000 0 0x100000>;
+			reg = <0 0x8df00000 0 0x5a000>;
 			no-map;
 		};
 
-		gpu_mem: gpu@97900000 {
-			reg = <0 0x97900000 0 0x5000>;
+		gpu_mem: gpu@8df5a000 {
+			reg = <0 0x8df5a000 0 0x5000>;
 			no-map;
 		};
 
-- 
2.51.0




