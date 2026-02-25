Return-Path: <stable+bounces-219343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMb6HYOdnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2751D192A1C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A150301220D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEDA2FB08C;
	Wed, 25 Feb 2026 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mw6NCZXm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7030CD94;
	Wed, 25 Feb 2026 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002653; cv=none; b=cahv018Gc/+auNSZeSjn3hmTTfhwjI2X8leTjhKX0VWw32+PQOj5IIIblKlSbOlQOlv4ILLdS2T9V8UejjX7fo8bSAPWoMDgesC67b9VybohCudVShxuZEqHUjTWlhCiOVIDGOdiBIcPEOPPtchYQNlF6w3NgCKKd8ZwDsr1CoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002653; c=relaxed/simple;
	bh=zkZH3qTAiOXHBE5bbuuQdle9QBtHX3rTDNXyBCLzOis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkSW9Tnh72rT89FO7AEzrdToBzA3HVaYPVR+eJpkWRnH+RNH4pECKiEPKBsflf48t8u5TuaUUa+X0/E6/pLAjh5o0kKqxUeZaJUePEf7FuHSrrwYdR7xb2purUydV+hqNU/QeZrewL+VAitjl7XImItW6j7JNo+jnSs/B8YC1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mw6NCZXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE56C116D0;
	Wed, 25 Feb 2026 06:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002653;
	bh=zkZH3qTAiOXHBE5bbuuQdle9QBtHX3rTDNXyBCLzOis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mw6NCZXmC05tUDfLaXL/uFoMwb5+QzVaeo9lHw72chimQh0YP3T+Ojmw2DXBdxlPJ
	 Gfp07aTDShX0ZCPQz6ENIFMc1MeeObGJl6eXuLSXP3bvVQ/7ZOtH3dw0aB7FTAf8LF
	 /Iwza6OE5kaaz7jI4HjkCILv08/VH3ObE6r2+jtA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Heidelberg <david@ixit.cz>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 428/641] clk: qcom: dispcc-sm7150: Fix dispcc_mdss_pclk1_clk_src
Date: Tue, 24 Feb 2026 17:22:34 -0800
Message-ID: <20260225012358.917329655@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-219343-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2751D192A1C
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Heidelberg <david@ixit.cz>

[ Upstream commit fab13d738c9bd645965464b881335f580d38a54e ]

Set CLK_OPS_PARENT_ENABLE to ensure the parent gets prepared and enabled
when switching to it.

Fixes: e3c13e0caa8c ("clk: qcom: dispcc-sm7150: Fix dispcc_mdss_pclk0_clk_src")
Signed-off-by: David Heidelberg <david@ixit.cz>
Link: https://lore.kernel.org/r/20260117-sm7150-dispcc-fix-v1-1-2f39966bcad2@ixit.cz
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/dispcc-sm7150.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/dispcc-sm7150.c b/drivers/clk/qcom/dispcc-sm7150.c
index ddc7230b8aea7..923f0f38e804c 100644
--- a/drivers/clk/qcom/dispcc-sm7150.c
+++ b/drivers/clk/qcom/dispcc-sm7150.c
@@ -370,7 +370,7 @@ static struct clk_rcg2 dispcc_mdss_pclk1_clk_src = {
 		.name = "dispcc_mdss_pclk1_clk_src",
 		.parent_data = dispcc_parent_data_4,
 		.num_parents = ARRAY_SIZE(dispcc_parent_data_4),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_pixel_ops,
 	},
 };
-- 
2.51.0




