Return-Path: <stable+bounces-252522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNEnNSwVDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-252522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:10:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0640F599367
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EBB23019DA6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707C13EAC82;
	Wed, 20 May 2026 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I5Bv3ZkJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30081331220;
	Wed, 20 May 2026 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300894; cv=none; b=KQCl9TYBcbdC872oFT72CBwnkha1sy4wAGU+v1p5KIuWcVW/I5QIpfnKiPdsU2aStzUUlPYARii/+0jh6FXY3hvkTNZJ9XMu9ymb2DKWktF6n67ma2Ki5wyXay/4b7BtOOByiLzoLxBn/qmWO+gFiSOYxPXqDjgB6B/rUhT/py0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300894; c=relaxed/simple;
	bh=j3eTz9o7G+cbpsDigSRSnImtF0dXnvioZUEq8hbHkbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukTqtdponP1hzNbDK+I/dQoMI5KExyaCY9j1uoiCrj7aNy47oKLiTJnXFqjE0DTbTm7YvUoggTTJFEiVo4Iytz6wIcz6I+rkjdGbxHk4hZyjbx1I9Ettfgo8iubsDcizgCaF84SQjRh1cIhIusDHWEPhQq7VK+uUelCWXeSyx50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I5Bv3ZkJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835B81F000E9;
	Wed, 20 May 2026 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300893;
	bh=ZETdfsikSd9IChhCksthAvntS5QazxfP/3PBHPotfVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I5Bv3ZkJUVmsFKO7KKaj+kHo1MK0Qgq+ewrRI75nTEJoG7gYmds6hWeCte6gvUZuG
	 EdV1wiBJ3/dAzkOTjaVRiQmVAwB9/FNp9D9nU956YlSr5a1rvj9DtMC9wkTYjBBSAw
	 GTQIOEgz+2e8WVeMJZ2txyL3xoVouUg8grfvT9dQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josua Mayer <josua@solid-run.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 297/666] arm64: dts: lx2160a: change i2c0 (iic1) pinmux mask to one bit
Date: Wed, 20 May 2026 18:18:28 +0200
Message-ID: <20260520162117.652957402@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252522-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,solid-run.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 0640F599367
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josua Mayer <josua@solid-run.com>

[ Upstream commit 7a3cc49ad1fc8d063abb7f5de8f1b981b99d2978 ]

LX2160A pinmux is done in groups by various length bitfields within
configuration registers.

The first i2c bus (called IIC1 in reference manual) is configured through
field IIC1_PMUX in register RCWSR14 bit 10 which is described in the
reference manual as a single bit, unlike the other i2c buses.

Change the bitmask for the pinmux nodes from 0x7 to 0x1 to ensure only
single bit is modified.

Further change the zero in the same line to hexadecimal format for
consistency.

Align with documentation by avoiding writes to reserved bits. No functional
change, as writing the extra two reserved bits is not known to cause
issues.

Fixes: 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery")
Signed-off-by: Josua Mayer <josua@solid-run.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 97f2ed267d698..e2c32f5b6a521 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1790,11 +1790,11 @@ i2c7_scl_gpio: i2c7-scl-gpio-pins {
 			};
 
 			i2c0_scl: i2c0-scl-pins {
-				pinctrl-single,bits = <0x8 0 (0x7 << 10)>;
+				pinctrl-single,bits = <0x8 0x0 (0x1 << 10)>;
 			};
 
 			i2c0_scl_gpio: i2c0-scl-gpio-pins {
-				pinctrl-single,bits = <0x8 (0x1 << 10) (0x7 << 10)>;
+				pinctrl-single,bits = <0x8 (0x1 << 10) (0x1 << 10)>;
 			};
 		};
 
-- 
2.53.0




