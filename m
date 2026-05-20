Return-Path: <stable+bounces-252448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IN69G5UlDmr26QUAu9opvQ
	(envelope-from <stable+bounces-252448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:20:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF9159AB7D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 494CB3970A69
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279753EAC82;
	Wed, 20 May 2026 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KmwQ6wdD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7296331220;
	Wed, 20 May 2026 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300699; cv=none; b=NLy6WIQmdMMhHuI48Tq3VIFngUfUoyzyKGU2epsg1Jv5Rg0+F6jVrCgc/NdN3BAUgn1uVdUljrqL9n1lWgJKWlUPmOFMAJLVtzNz3SUA+yvxkOPagpn1LfIkUcvVJeKzieBkOZGsdPavXsgfOOA1eLvZY51mnsCdVlOLkDf7Chs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300699; c=relaxed/simple;
	bh=bVaIKYiPEi2RFs2JrovZ0U1K6wNa2DbJsZWBXJ9xjwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+Ryhy4Jma5eBpXElIJq+uOvWhY7l1eYE7kYFFsIo3ywF3MyjwkWDnzRS4Aj2c3fyuy1B3CuZVdUxihyRSLa/xFAmvcmmu9OOLART5GsQUsr1zB+h/FiTnWOWRvRK65GGlaMzYi3k+TkxsNX3IQ+VvkU/4R/pcnRuntUc8b5+mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KmwQ6wdD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497711F000E9;
	Wed, 20 May 2026 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300698;
	bh=EP9fhoPLMbLdsX3MEGCWWOlQybtO2E1tCRATpTp6eGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KmwQ6wdDEE2vJRw7kHoRLx6bOWP/a8gZ1Go0oAHYCAmqm0IUsnl+PR3lgoVubGgE4
	 FksNfv1tLdaf+ixY549nkd5qZQdj9V5Wbdyd1L/nzudBzMA1ZYDUirSH5rvzha/AFi
	 ytqQZAiXO0vw/31M5SEsrafoAYzHSKxEPRBw+ct8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 274/666] arm64: dts: qcom: msm8953-xiaomi-vince: correct wled ovp value
Date: Wed, 20 May 2026 18:18:05 +0200
Message-ID: <20260520162117.152481765@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252448-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mainlining.org:email]
X-Rspamd-Queue-Id: AEF9159AB7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Barnabás Czémán <barnabas.czeman@mainlining.org>

[ Upstream commit 9e87f0eaadccc3fecdf3c3c0334e05694804b5f5 ]

PMI8950 doesn't actually support setting an OVP threshold value of
29.6 V. The closest allowed value is 29.5 V. Set that instead.

Fixes: aa17e707e04a ("arm64: dts: qcom: msm8953: Add device tree for Xiaomi Redmi 5 Plus")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
Link: https://lore.kernel.org/r/20260116-pmi8950-wled-v3-5-e6c93de84079@mainlining.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
index d46325e799176..c2a290bf493c1 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
@@ -169,7 +169,7 @@ &pm8953_resin {
 
 &pmi8950_wled {
 	qcom,current-limit-microamp = <20000>;
-	qcom,ovp-millivolt = <29600>;
+	qcom,ovp-millivolt = <29500>;
 	qcom,num-strings = <2>;
 	qcom,external-pfet;
 	qcom,cabc;
-- 
2.53.0




