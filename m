Return-Path: <stable+bounces-219412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOsjBcWenmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:03:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C97192D5B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54F5530FB5F4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFBC30AD0C;
	Wed, 25 Feb 2026 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uBAhd1iC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64BC2D839C;
	Wed, 25 Feb 2026 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002698; cv=none; b=ZR9nrsJYLAwnXKHCwcnDoe4HG9wmh6QSEIIBVi/LqjbXLJXjBuxVdNc2yIvzH55xoax15trSLWWh/rPA6ov2ofCZcz05P7p2TUR6ED8BmKAQv3fGKCeZL28MyxgEZg3QRg6TjhzLyqEmOV8vBhtNjSRVPtuhbi1Tv4aa9jyP288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002698; c=relaxed/simple;
	bh=QdYkrIHO+FSjeUylhDdSeidgu2kZinMTSYC3xOoKsFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q12PZW6x6Dd7YAdkcLWfxruyIKrm3IXTUWzjCNS7qXSU74Z47x7W4fkgykqygIrL5eJe8ijDCNNskVlPlHLrWuysBNxsrISUKfFT8YWYrZMbA16Fhy8x3wGWKK0wmH2FQu/lYyo2zbKbULgSCJcnjw19Hdmb4o6SxBJZVmPC0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uBAhd1iC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC72C116D0;
	Wed, 25 Feb 2026 06:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002698;
	bh=QdYkrIHO+FSjeUylhDdSeidgu2kZinMTSYC3xOoKsFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBAhd1iCAHyj73KN95NPGgrfZ8ErlRrudYbfj9GgKp+sQeSu+AKV70+0QQWeY9aDc
	 cpivScLjpCL6YkfweS4Etxq83wLkZVRELOVaiIflwMjkmBT4nfKIBQuciuPRCFnecn
	 qPYVgpvVkAQ5hzhNZ1U0qMOtOSijoSmxv4bJL3hE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	"Daniel Thompson (RISCstar)" <danielt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 495/641] backlight: qcom-wled: Change PM8950 WLED configurations
Date: Tue, 24 Feb 2026 17:23:41 -0800
Message-ID: <20260225012400.516078938@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219412-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mainlining.org:email,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 94C97192D5B
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Barnabás Czémán <barnabas.czeman@mainlining.org>

[ Upstream commit 83333aa97441ba7ce32b91e8a007c72d316a1c67 ]

PMI8950 WLED needs same configurations as PMI8994 WLED.

Fixes: 10258bf4534b ("backlight: qcom-wled: Add PMI8950 compatible")
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Link: https://patch.msgid.link/20260116-pmi8950-wled-v3-4-e6c93de84079@mainlining.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/qcom-wled.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 5decbd39b7899..8054e4787725e 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1455,7 +1455,8 @@ static int wled_configure(struct wled *wled)
 		break;
 
 	case 4:
-		if (of_device_is_compatible(dev->of_node, "qcom,pmi8994-wled")) {
+		if (of_device_is_compatible(dev->of_node, "qcom,pmi8950-wled") ||
+		    of_device_is_compatible(dev->of_node, "qcom,pmi8994-wled")) {
 			u32_opts = pmi8994_wled_opts;
 			size = ARRAY_SIZE(pmi8994_wled_opts);
 		} else {
-- 
2.51.0




