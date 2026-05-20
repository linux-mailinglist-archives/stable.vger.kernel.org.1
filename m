Return-Path: <stable+bounces-251615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOknBpAcDmro6AUAu9opvQ
	(envelope-from <stable+bounces-251615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:41:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F355599F28
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FBB93167FDA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4796236C9D2;
	Wed, 20 May 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r+idYq3z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3B36405A;
	Wed, 20 May 2026 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298443; cv=none; b=aU+30uNaIADIboTb5ng5hctLPedstsl0o5Fm/OZ5P4FkXkrc/7MmXhTKDFj/UawAkI4gb9XYnxFojZS937FkGno/5OdgldW/d79QT1tILZaPYo8jaD9Y3eacQLpLCb7ro4pGL4f2z/81XVBK2ifBdD8UWc07KFB5LW1fI6Jto0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298443; c=relaxed/simple;
	bh=lCTAr81X3qX82k356AIvLpNxgbg41UvgwxWWJ+isorQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2Q7+zAAy89Tz5e5pJ6yPP+j7yzZWSZ2Qjcljik8cN4gZD7bP0L4L6mpKwuF4di5cJ/d2GuGKPE7wjwoknT2/vy1pHC4uUJojePcl56trjyMO9p/lFlJulemfZ2stAvYdaW7v6jLiu+f53VYPUfF9SJqAL0WE0qM61kmEbv3/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r+idYq3z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3751F000E9;
	Wed, 20 May 2026 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298441;
	bh=XvkE5Y3TkDwkrYsPvHB6q1gwlgfoFaKE3155I/kyxQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r+idYq3zVT2AZtBW4ALetl0LhcKKH7A7NlTHfnu7xLuuaMLqjqZRUPp6c3TQQ4dmQ
	 GCjQQqe0Gg8J9+ewxoFOAeD0EUhjHz0tTONgt43n/sjmT0/rNBZo8ISMrFy1StuHAQ
	 dCBjtXFhU9pQ0RSeG/ogJMPqu5eCyt8deySzmtCI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Judith Mendez <jm@ti.com>,
	Moteen Shah <m-shah@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 413/957] arm64: dts: ti: k3-am62p5-sk: Disable MMC1 internal pulls on data pins
Date: Wed, 20 May 2026 18:14:56 +0200
Message-ID: <20260520162143.480082008@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251615-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:url,ti.com:email]
X-Rspamd-Queue-Id: 7F355599F28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Judith Mendez <jm@ti.com>

[ Upstream commit 6d4441be969bea89bb9702781f5dfb3a8f2a02a4 ]

AM62P SK has external 10K pullups on MMC1 DAT1-DAT3 pins [0].
Disable internal pullups on DAT1-DAT3 so that each line has a
single pullup source:
- with both pullups enabled, the effective parallel resistance on
  DAT1-3 (~8.33K) drops below the 10K minimum pullup requirement
  for data lines (per SD Physical Layer Specification)
- removing internal pullups makes DAT1-3 match DAT0 10K
  external pullup so its consistent and within spec
- both internal and external pullups enabled equals unnecessary power
  consumption

[0] https://www.ti.com/lit/zip/SPRR487

Fixes: c00504ea42c0 ("arm64: dts: ti: k3-am62p5-sk: Updates for SK EVM")
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://patch.msgid.link/20260223233731.2690472-2-jm@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index a064a632680ec..f5054912ad910 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -271,9 +271,9 @@ main_mmc1_pins_default: main-mmc1-default-pins {
 			AM62PX_IOPAD(0x023c, PIN_INPUT, 0) /* (H20) MMC1_CMD */
 			AM62PX_IOPAD(0x0234, PIN_OUTPUT, 0) /* (J24) MMC1_CLK */
 			AM62PX_IOPAD(0x0230, PIN_INPUT, 0) /* (H21) MMC1_DAT0 */
-			AM62PX_IOPAD(0x022c, PIN_INPUT_PULLUP, 0) /* (H23) MMC1_DAT1 */
-			AM62PX_IOPAD(0x0228, PIN_INPUT_PULLUP, 0) /* (H22) MMC1_DAT2 */
-			AM62PX_IOPAD(0x0224, PIN_INPUT_PULLUP, 0) /* (H25) MMC1_DAT3 */
+			AM62PX_IOPAD(0x022c, PIN_INPUT, 0) /* (H23) MMC1_DAT1 */
+			AM62PX_IOPAD(0x0228, PIN_INPUT, 0) /* (H22) MMC1_DAT2 */
+			AM62PX_IOPAD(0x0224, PIN_INPUT, 0) /* (H25) MMC1_DAT3 */
 			AM62PX_IOPAD(0x0240, PIN_INPUT, 0) /* (D23) MMC1_SDCD */
 		>;
 		bootph-all;
-- 
2.53.0




