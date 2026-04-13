Return-Path: <stable+bounces-236221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPRjC4AW3WmXZwkAu9opvQ
	(envelope-from <stable+bounces-236221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:14:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBAB3EE7F2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE94F306F781
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398A2F60B2;
	Mon, 13 Apr 2026 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RNtUnTPw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15227FB2E;
	Mon, 13 Apr 2026 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096354; cv=none; b=ppR70JU6xBhHqevWsaHlBBDWe2Fm9AMLBQS4Ms5sCsjhRPqJ0cM8PAfVigX2tYYdYvIC3RWy33IUauleRoWusxSzVXqAWP59cXwPyAgnmNHCIwNyyOa0q9dNA4IzCiX5I3r5isN9Av2ywPYsXQ8QZGH1C9dBOCQw23T8Bl6eVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096354; c=relaxed/simple;
	bh=CEh7NRcFVQDISZa7arCxb9o5E5k7buHJFe/9KQZROz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mo8sGeqpPMOW6ntOgqWe1fY2cptI7lHKvzX0G2T1akm8ZF1lUg1nmcBssZeHwUOUhgWrz2ntwT3pPq7jp5OeK7fPEjPiR1krzNG/TgHdZA3vBkllxcjjgt8WnHwzv9spdMGC9VMegJhf7kwRWFMtNUbqJc8nfJH/DauqdONUH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RNtUnTPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ECBC2BCAF;
	Mon, 13 Apr 2026 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096354;
	bh=CEh7NRcFVQDISZa7arCxb9o5E5k7buHJFe/9KQZROz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNtUnTPwIWMXaDEpB/77jkgqPX5Glk0w+U4SRNKr2ys1NFl+rAAulT4AN+Ng3fdG8
	 xW2hkWrUyyo9ML/ml79TaBnwx/ZLLz3P8Si+Q6S3h3I2H/FdrUBas+snX6C5XmrKzs
	 01nKVOOyjC1+4NjkvPuPCNLGU0oXVcZJ/Gsyb8FI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 6.19 33/86] arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V
Date: Mon, 13 Apr 2026 17:59:40 +0200
Message-ID: <20260413155732.808229234@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236221-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,nxp.com:email,puri.sm:email]
X-Rspamd-Queue-Id: 2CBAB3EE7F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

commit 511f76bf1dce5acf8907b65a7d1bc8f7e7c0d637 upstream.

The minimal voltage of VDD_SOC sourced from BUCK1 is 0.81V, which
is the currently set value. However, BD71837 only guarantees accuracy
of ±0.01V, and this still doesn't factor other reasons for actual
voltage to slightly drop in, resulting in the possibility of running
out of the operational range.

Bump the voltage up to 0.85V, which should give enough headroom.

Cc: stable@vger.kernel.org
Fixes: 8f0216b006e5 ("arm64: dts: Add a device tree for the Librem 5 phone")
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -846,7 +846,7 @@
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <900000>;
 				rohm,dvs-idle-voltage = <850000>;
-				rohm,dvs-suspend-voltage = <810000>;
+				rohm,dvs-suspend-voltage = <850000>;
 				regulator-always-on;
 			};
 



