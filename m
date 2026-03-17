Return-Path: <stable+bounces-226130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMpzDHCEuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:42:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AC42AE405
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EB01301F5B6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F7375F99;
	Tue, 17 Mar 2026 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VBLialKj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A5315D33;
	Tue, 17 Mar 2026 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765429; cv=none; b=M+ZaEyeBl6tV4imf3fC9rv7VjKdhSRTYcU4RNGobYNV/cq8nSas6RCkhXzSQy9BxgUUKjGBhsYY2gdn3M4FJ1hVgaaaMkFB+eMLnrb1RxPHyzBTs+ptE230a63Te78AwUkRCdVovQqGbJw0nEipBDgJmWZ47TDCP3SmdnH87/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765429; c=relaxed/simple;
	bh=jD/OVGPwmMS1+ZHAEwAi2sarTbDqSSRNzdJjLBpdfEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAd9I6rTVr6an9FhDQ1OMI1RR0mm/o2Oy7v6fc+rnFWOd9G2WW50t1DxwVTD0wjFqs/l8d2EDHQnRD3eONMBByS0RfSbzgdEWWDASwd458cFbj+RDd0XV13N3PIp+6PjkfPu1i5shIMiryeUAFMWq/LhZRdedTNXGMeopsqwr+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VBLialKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA6EC4CEF7;
	Tue, 17 Mar 2026 16:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765428;
	bh=jD/OVGPwmMS1+ZHAEwAi2sarTbDqSSRNzdJjLBpdfEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VBLialKjy6kPSJ975QggTCPAMaMSvvqlXp3plYtGoVqIB00p0ok1Ub3F862zU9hFM
	 odhRyaV1oABC/DXhV/FwNIZUXNk2cPYd4uIS1VhMAQTwvqMeyCY5bHpNRt5eo4TavU
	 XABWJwhcVfmSgYpdDAl+nK2W1JtutUjyXU+JXi7E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 001/378] remoteproc: qcom_wcnss: Fix reserved region mapping failure
Date: Tue, 17 Mar 2026 17:29:18 +0100
Message-ID: <20260317163007.019320553@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226130-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61AC42AE405
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring (Arm) <robh@kernel.org>

[ Upstream commit f9b888599418951b8229bbb28851ed4da50c58e9 ]

Commit c70b9d5fdcd7 ("remoteproc: qcom: Use of_reserved_mem_region_*
functions for "memory-region"") switched from devm_ioremap_wc() to
devm_ioremap_resource_wc(). The difference is devm_ioremap_resource_wc()
also requests the resource which fails. Testing of both fixed and
dynamic reserved regions indicates that requesting the resource should
work, so I'm not sure why it doesn't work in this case. Fix the issue by
reverting back to devm_ioremap_wc().

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: André Apitzsch <git@apitzsch.eu>
Fixes: c70b9d5fdcd7 ("remoteproc: qcom: Use of_reserved_mem_region_* functions for "memory-region"")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: André Apitzsch <git@apitzsch.eu> # on BQ Aquaris M5
Link: https://lore.kernel.org/r/20260128220243.3018526-1-robh@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_wcnss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index ee18bf2e80549..4add9037dbd5a 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -537,7 +537,7 @@ static int wcnss_alloc_memory_region(struct qcom_wcnss *wcnss)
 
 	wcnss->mem_phys = wcnss->mem_reloc = res.start;
 	wcnss->mem_size = resource_size(&res);
-	wcnss->mem_region = devm_ioremap_resource_wc(wcnss->dev, &res);
+	wcnss->mem_region = devm_ioremap_wc(wcnss->dev, wcnss->mem_phys, wcnss->mem_size);
 	if (IS_ERR(wcnss->mem_region)) {
 		dev_err(wcnss->dev, "unable to map memory region: %pR\n", &res);
 		return PTR_ERR(wcnss->mem_region);
-- 
2.51.0




