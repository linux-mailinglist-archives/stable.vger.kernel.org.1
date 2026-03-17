Return-Path: <stable+bounces-226156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBqqIbKEuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:43:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB932AE46C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66AF0309E7DB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88383EBF3F;
	Tue, 17 Mar 2026 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pf4FmZHu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC82C3EB7F1;
	Tue, 17 Mar 2026 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765544; cv=none; b=djJbGSqvyuZedeToYdtSprKE/hEGNbLzK52fPDnhIEiFO0jfaTG8WPuZzXos+KsaM9o5KgTodZZj6bM/BjbNzgJNLwL5XOfwBnjggT3lPvEYBbsxZA6K5sQW+ICegOCgI6Yvg+1rKmv1NkHfXX9msVwBUpnyBf6uUSGtMxj4GGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765544; c=relaxed/simple;
	bh=KrrXn/9EkxXCzfkyPsUtAQn0/5L3nMfDkiyeUJwEMng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XraDUfeZwZDwdeuxbwIfAsbwARC/cBqCd9ILmI+BDAfhkSN4f+5i2QUuMj2zUK6S5EVRsd6a3W6/5kAA95ZBpogxhWlmnpH8yQehxrz/2SWA0+q2XlEKZVPQsUiqghjkaoNZwRQYBQCIrxPFtYRsZKt2WC6fqrOX2R6DLY3eGU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pf4FmZHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17057C4CEF7;
	Tue, 17 Mar 2026 16:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765544;
	bh=KrrXn/9EkxXCzfkyPsUtAQn0/5L3nMfDkiyeUJwEMng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pf4FmZHujs/sRpjWAFrBh9UkUINj1XOqlRc0swflmd6lUBcqemobNBW7nG94RGUKd
	 c1N8KrqXF0toqgQjqPRE0COSJMF56qV08KhvYSKJM+yqyzFRkOE3hJ1ircg55Bhgt7
	 ved6J2NT4qXlgIiGbQAArkwICkajb+71WXpsJGjg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 035/378] dt-bindings: display/msm: qcom,sm8750-mdss: Fix model typo
Date: Tue, 17 Mar 2026 17:29:52 +0100
Message-ID: <20260317163008.274542348@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226156-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchwork.freedesktop.org:url,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: EBB932AE46C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

[ Upstream commit 4355b13d46f696d687f42b982efed7570e03e532 ]

Fix obvious model typo (SM8650->SM8750) in the description.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Fixes: 6b93840116df ("dt-bindings: display/msm: qcom,sm8750-mdss: Add SM8750")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/707192/
Link: https://lore.kernel.org/r/20260225173419.125565-2-krzysztof.kozlowski@oss.qualcomm.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
index d55fda9a523e2..a38c2261ef1ac 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
-  SM8650 MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks like
+  SM8750 MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks like
   DPU display controller, DSI and DP interfaces etc.
 
 $ref: /schemas/display/msm/mdss-common.yaml#
-- 
2.51.0




