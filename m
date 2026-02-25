Return-Path: <stable+bounces-219335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKFUCHqdnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B775A1929FF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B60CF3012B44
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4033F3090D4;
	Wed, 25 Feb 2026 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WFkmutGk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027EA2D4805;
	Wed, 25 Feb 2026 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002648; cv=none; b=fy9mAr42aFjdbF19ucaInIUReWbQ4/blgEI3evd2rS3auBW6TqHZ4gm3D8vPgYOkGGpyVXnHSMXUtNAKGu6IOTUJx/QXhuUykYZYvAo1nFPMOF65dRDyaLNcUBzZqgtU/qdQd/E/8fueduHkkH+NMXBpzZ5V7UM6mYSiU2dB988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002648; c=relaxed/simple;
	bh=YzcLFkyvu6wX7/w7Fl66JrDYuexUFkYmutCx5H1JBkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onFJr+UskHwDvbTYNCamRb1luN7BqhODNXDov2TY2MOyqhUrD1CJBhKmK7lK8AYmHsrTWgTnconZxSMz7ivW41tAa81YE8P/qULQ5krbYDT2WE0rFLYPwtBemdI0blMCwZdn/5IJ18Fs8N6KmfVsRZ3quAI4TBAk93cvs51r8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WFkmutGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3FFC19422;
	Wed, 25 Feb 2026 06:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002647;
	bh=YzcLFkyvu6wX7/w7Fl66JrDYuexUFkYmutCx5H1JBkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFkmutGklTppq7LKdDf8vMhdJuulhv4FzY4wS44akZ1iV7DZZHt6Nn+p/3wqWYKyV
	 b8ZK8vU/Qtp3wcFiFSV7DIUyC5C8F2iSJMlOcDvn8Ni3JeIx026qsDZXgXlt/PfDAd
	 zhDQIBKfUvupUbn0qabevvnNfuhiN8yfo5TwWrLQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 417/641] clk: qcom: gcc-msm8953: Remove ALWAYS_ON flag from cpp_gdsc
Date: Tue, 24 Feb 2026 17:22:23 -0800
Message-ID: <20260225012358.662107083@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219335-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mainlining.org:email]
X-Rspamd-Queue-Id: B775A1929FF
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Barnabás Czémán <barnabas.czeman@mainlining.org>

[ Upstream commit 5f613e7034187179a9d088ff5fd02b1089d0cf20 ]

cpp_gdsc should not be always on, ALWAYS_ON flag was set accidentally.

Fixes: 9bb6cfc3c77e ("clk: qcom: Add Global Clock Controller driver for MSM8953")
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251117-fix-gdsc-cpp-msm8917-msm8953-v1-1-db33adcff28a@mainlining.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-msm8953.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-msm8953.c b/drivers/clk/qcom/gcc-msm8953.c
index 8f29ecc74c50b..8fe1d3e421440 100644
--- a/drivers/clk/qcom/gcc-msm8953.c
+++ b/drivers/clk/qcom/gcc-msm8953.c
@@ -3946,7 +3946,6 @@ static struct gdsc cpp_gdsc = {
 	.pd = {
 		.name = "cpp_gdsc",
 	},
-	.flags = ALWAYS_ON,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
-- 
2.51.0




