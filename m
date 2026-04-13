Return-Path: <stable+bounces-236121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KA5HdIF3WkZZAkAu9opvQ
	(envelope-from <stable+bounces-236121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:03:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C978D3EDAAE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF414301FD62
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70A23B774B;
	Mon, 13 Apr 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ2GlKJy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801A3B95FA
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092287; cv=none; b=Ed1+dWnivsD5oj6i+B/P5D915Q2PoDHKXsGMYfeOXkOoNUrP0e1llyuBTSMgLAGM9HRD96nVS+u3YXSGjnkFRqkmyXIbiEFuGHqDWVl2e6MA1g7UO3v9IR7F/ZTuTvjP1UDUW8tq471XlWwvCMIl40Rw4f0SU+rWDTTs8Ya/Bqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092287; c=relaxed/simple;
	bh=etqWT5S874b6t62dwz695txK/ml1M8gvVcbz1EzkNr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cE0MgYLcjBxSe+mmwDATVVYl8pgS1fBQ0M+v36fuNevKsUTRQrdhvzMYI3prC6xJ+jd8t7DSVIgGotqNYLUvIqJ+7CQ/xIbd/Ujd/HNKHu6G0AhZkRoVhmJQALPbIkd0vP5iafF9PzUXk2hoFTG5wcL49pBUSIWv8/w04MVhKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJ2GlKJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98958C2BCB4;
	Mon, 13 Apr 2026 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776092287;
	bh=etqWT5S874b6t62dwz695txK/ml1M8gvVcbz1EzkNr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJ2GlKJy+P2OEYCKul84/XfPNkTH09TL3HMJfUFj+v+aWOd6ZVGPjq43eIsryPWQ9
	 Hx/d0xjJDMW5Jrb//nmqAsiFc5Z8F/iM7NacXPZ9DQd7Zxjns9G1kWR+LmiqAsDPyN
	 20Nt3AZWfUCjKlkR2ttQVWXiAh6w12ENHU8TdA+BmrVgvWgNK4VQgmMsX2VE5giK0U
	 XulQFixyIbXudwJTlPFDO5tXrfuWV7q2vr6CptdQiXuTUyGcTHqvXj2rp5mQFUEUfa
	 GVuZ9xW0HgGUuRHG80/5LwcthCY8BAZ41Qgz3yA3B+UCvg6X/D27rlAao+Vl94mzgi
	 2syBJ+guE46OQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
	Martin Kepplinger <martin.kepplinger@puri.sm>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/7] arm64: dts: imx8mq-librem5: Don't mark buck3 as always on
Date: Mon, 13 Apr 2026 10:57:59 -0400
Message-ID: <20260413145804.2968471-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413145804.2968471-1-sashal@kernel.org>
References: <2026041310-reluctant-amaretto-6070@gregkh>
 <20260413145804.2968471-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236121-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,puri.sm:email]
X-Rspamd-Queue-Id: C978D3EDAAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Guido Günther <agx@sigxcpu.org>

[ Upstream commit 99e71c029213d3cfcc4f39a534c73d1828ffb341 ]

With the pmic driver fixed we can now shut off the regulator in the gpc.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 511f76bf1dce ("arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 325ea100969a8..f333335363100 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -671,7 +671,6 @@ buck3_reg: BUCK3 {
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				rohm,dvs-run-voltage = <900000>;
-				regulator-always-on;
 			};
 
 			buck4_reg: BUCK4 {
-- 
2.53.0


