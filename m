Return-Path: <stable+bounces-212773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC2QIcRie2l2EQIAu9opvQ
	(envelope-from <stable+bounces-212773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 14:38:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8B5B076F
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 14:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E6F03010D9D
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201E8270ED7;
	Thu, 29 Jan 2026 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="A9VorgIz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hxeBJRKL"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49082E9EBB
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769693865; cv=none; b=Noa9/cVeAk56fiOJ6OliDeDGfMTiVc+vOMrV9rsBEUhfOiiH74Mayn6xUh0ev0lU6chPECs7T+K8HN0AhsYYgWc6T3p+Eh+IPQtRpnO2lVsnqrWn4WexvqJHnTgHOU1jrae5EznEmMJyQ1GanAj5mbCsiFe1G3WSGuEQpDYvWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769693865; c=relaxed/simple;
	bh=9UR+P2qWMMtyo3Oeo5M8SNGmf3c1wjUnume7uUmseKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFmeUNTrADxhnEmIVfZfErUfQPz/f1tfksAq7Amh6N74EdFN2jixLS+HKgiAr+Y6hUL4pbqpe5XI9CWi5UcbFBVT/Kp+1qV9LpeFSKnMTVx09YmlJGG7Y258PBmbJqeBqqIWOu4CmZz1F651KiTF89XWBTN8V3xyesRRB1YRJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=A9VorgIz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hxeBJRKL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D815140017C;
	Thu, 29 Jan 2026 08:37:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 29 Jan 2026 08:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1769693861; x=1769780261; bh=GBRVBUaUo6Jow0Q34vHHd
	nUYteMZHVBAi0ONLuP2QFw=; b=A9VorgIzhVmaO7j/b9rgzKfKeIb6lw1AbOLua
	tK/wpprsE3AMfcorO6JI5/gfwu/ZalX24JvU0j7G103jx14iL6/fFdtytAyy285s
	hu95NACm50HZ/Ge97OSxv+jtvFzLXu1m5wLcJOXcQdr0hvNZFqFQgmrMYDFR5f9a
	UPncUKTmhk1OfpSZLQpbuSRcHiZD5Yeqot4cX98g3Twxat5YMzvCJ38TqnqqU0oA
	tW7VoIedG3X4Rr39D33br/+qX2cBCNByuxu8GADMWazZDaPltn/tBcUwtvVQdyR9
	aKGO8558+hxNOa5StdM8Qyoa5qs9IHfqUQfux4M9CCVOoLt3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769693861; x=1769780261; bh=GBRVBUaUo6Jow0Q34vHHdnUYteMZHVBAi0O
	NLuP2QFw=; b=hxeBJRKL+v9PbM1YfoEznERisYwd6mjIDdbNfZcsCcy757qUSjy
	0z4/T47VxkKEVuvFe3XRnwEWJ78sM//O0PP4P6h+h3Md4k0pMkHSIwhfShBiTuFe
	OBy/OSq7CTsYiwiCqGGp6vIdjYejGF651TD0qkcALLEpTTb5za+CtCx6YVGZb1sj
	F+WxGdBMxXP6nerp042QeN2QTWldWt3s6visSDH6t3GT9gP1axqZ3D65aGp4w9wx
	GDOa75pyrH1Q1l/80yvf5yZzqBC/t5HtNmXJJcrXkZrA+WWPEDIpIl+bNJcPAiNy
	Fm1EZPwG3NqC+oZhYAiyiip5ztmXUAmOKjA==
X-ME-Sender: <xms:pWJ7aV4RBW4yg6njmFnM-lEyPEkrQLEFAXAMAmuJ8aNOEuMGXNm5JA>
    <xme:pWJ7aZy_lwdrcHBsiyLeJTctI882F0Qi3OrOkQk44PdMDBqxAqXc66nZJ4pzEZ20e
    c42FuYTaASb2cE4Cgaj6duBOwIw6u_DigXp-PyrGH1Vlr5r8GZkEqI>
X-ME-Received: <xmr:pWJ7aUxQpSCxw8mUX2dQ1kMgT-ZFi4YlCiYQ55fPvf6ii2nbx4M5rhDQQ-s4lWpihati-DgD8KhCh3So2jQEZNX8Uq-HroWzhGw3qzTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlhihsshgrucft
    ohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnheptedufeduhf
    ektddvvdejhfevueevueetkeetleeujefgveelveeljeevjedtveeunecuffhomhgrihhn
    pehgihhthhhusgdrtghomhdpmhhsghhiugdrlhhinhhkpdhgnhhurdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhs
    rgdrihhspdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehnshgtsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughupdhrtghpthhtohepshhtrggs
    lhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pWJ7aZyiOODMw9eYOzb1d5z1i8wr0T2FrYC-RGF53foKx4XcVZW3VQ>
    <xmx:pWJ7aWYhG78iE67i2MKSjTcfI8cGcv472eOVwmzBfnoUzqZNmM2B5w>
    <xmx:pWJ7aSU2kwD3DKnBrnsAUgPDBWPCiqvzCpmiQ-VrPgaVGT7Se7qwTw>
    <xmx:pWJ7aciTqNfmaE8Yue7F_kd3ahtKU5PlogyPuHMb92s_ae-FQjx5Cg>
    <xmx:pWJ7aZsuGJj-CrXkDGWovDp05YdKgiEFnc_B7qkISNr63YUfjh7TQ_BO>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 08:37:40 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 4EC5173413B1; Thu, 29 Jan 2026 14:37:38 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Nicolas Schier <nsc@kernel.org>
Subject: [PATCH 6.12.y] rust: kbuild: support `-Cjump-tables=n` for Rust 1.93.0
Date: Thu, 29 Jan 2026 14:37:14 +0100
Message-ID: <20260129133715.23095-1-hi@alyssa.is>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[alyssa.is:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[alyssa.is];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212773-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hi@alyssa.is,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,umich.edu:email,alyssa.is:email,alyssa.is:dkim,alyssa.is:mid,gnu.org:url,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[alyssa.is:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DC8B5B076F
X-Rspamd-Action: no action

From: Miguel Ojeda <ojeda@kernel.org>

Rust 1.93.0 (expected 2026-01-22) is stabilizing `-Zno-jump-tables`
[1][2] as `-Cjump-tables=n` [3].

Without this change, one would eventually see:

      RUSTC L rust/core.o
    error: unknown unstable option: `no-jump-tables`

Thus support the upcoming version.

Link: https://github.com/rust-lang/rust/issues/116592 [1]
Link: https://github.com/rust-lang/rust/pull/105812 [2]
Link: https://github.com/rust-lang/rust/pull/145974 [3]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Acked-by: Nicolas Schier <nsc@kernel.org>
Link: https://patch.msgid.link/20251101094011.1024534-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
(cherry picked from commit 789521b4717fd6bd85164ba5c131f621a79c9736)
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5b773b34768d1..7c921514c6d0f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -109,7 +109,7 @@ ifeq ($(CONFIG_X86_KERNEL_IBT),y)
 #   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104816
 #
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch -fno-jump-tables)
-KBUILD_RUSTFLAGS += -Zcf-protection=branch -Zno-jump-tables
+KBUILD_RUSTFLAGS += -Zcf-protection=branch $(if $(call rustc-min-version,109300),-Cjump-tables=n,-Zno-jump-tables)
 else
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
 endif

base-commit: abf529abd660d8ccad46dd8c8f20e93db6134f5f
-- 
2.52.0


