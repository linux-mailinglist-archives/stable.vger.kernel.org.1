Return-Path: <stable+bounces-45552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A648CBB54
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 08:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F201C216A1
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 06:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9E079B84;
	Wed, 22 May 2024 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="kL9PyRbg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bs06KnfL"
X-Original-To: stable@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358277F1B;
	Wed, 22 May 2024 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359426; cv=none; b=U+iYfs6nfo1wxhwchJj7Qd3Ze2meO+qYjSMuo78CNSSeRQ9iBRhlJWDc/wMnFVZVvIXuYoRKDXj3YjIugNeik2aE+7/PTwrsTUqOKgepiys9A6+oVwUtEVvOOBx0t+1uRQSjg716YHmcttVXhRJ3xVkQSGNi135x2z2G5ZfUKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359426; c=relaxed/simple;
	bh=RQvekNk+Mw4VZKNhgWLZ47RRb5dhc61tf07pkWTicZQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cc4JKasBp/B4uAWg7VBgYC0Jx43adXmAe3MCOoPOlZDw+QteDqH3z+Tytjs0MFQfDKD274f+hHnW1ygxqDmdI2vpGBaGYp6wuQk/cboiD9pjBqIL6bQAA39KEpA1J4QQF8bicz0epMVsCdBnNYU09/3icu6f2G1YCZWZLjCDY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=kL9PyRbg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bs06KnfL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6D43C11401F3;
	Wed, 22 May 2024 02:30:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 22 May 2024 02:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1716359423; x=1716445823; bh=Po
	qbFlwlOxxeVqLPi5c26N1LmtDnXQI+TPXMUrISFyE=; b=kL9PyRbgkPm10KyF3+
	T7MqjAqfEcAeY0uIeuy6nHlVw4+4CTnPGN/sBRxUusTE1Ki/+bwSP1ppfE0MS2kO
	fUlKO24qixYNt1joUZdyo3fcu4Bs+Ribk9dnKY1TtxB14qk2LbY5hinVGardQ3Uz
	zJDTptw0AdxtnUNXnl4Kl8buF1K+P7qy0OztBR7N7BXEEE5K5V6TeS1L1oUizvht
	KtOLUb168yIFaoy5uEhVcmuqN3iYaTc2C1nqR8p+GS3f5W+0dB8qXi/jkT24St8h
	K5TOcnLk/QoXWjaZJFd53A71ncqamYl/pEaaInPiU4UjmOVDaUI5TbZ4eNkhHion
	uflQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1716359423; x=1716445823; bh=PoqbFlwlOxxeV
	qLPi5c26N1LmtDnXQI+TPXMUrISFyE=; b=bs06KnfL39womXWDJWuNWhOqtl63U
	+61/5lwrdVVTSIm7A9gmBtcAt3mW+V+b5/rGDwrBUCJvcUO7dvv8fPRbrr8xfrOw
	6yRv0t4jkZIFEyw0iRU0MQ57MGgYxLR/0zjOXG5brUVotq/4uEGDNzxnoct9BKDU
	2HTQk7zDc+HWTi6hRBe2tBw+68QuaZIJBfXkKeQ6QqBQb9TyfWMDas4wpSXNHg2R
	0qlKJXXz9gyh5OOUChd4aid2tgeS/x0uzevJ0H6LxB4QijnRh98DaVf5pecCEFdp
	rFfZ0guLO1vKDKNTG/Nlt1yFMQfu+4qn/ac9uNgDcjilFvsxfrPozOU7w==
X-ME-Sender: <xms:_pBNZu1bXwbfZ8qKnGghv3UVRt12p_m2dOy46uc1-X6lJWiMkJasgQ>
    <xme:_pBNZhEuo-8TDAuiAhb6wxU8sJy_LQytsD4Tg8cyL6Shib-StTVYSWE4Rav-xmPEg
    qbdALI2XxfEMfFYIIc>
X-ME-Received: <xmr:_pBNZm476tCmyLF30ydqRAreWLWwXERWkIPgDNXSh8onEP2CZDUf3eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
    kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:_pBNZv2Na9eV-d1zNXBSpiVpyOprSogP8tlsG7KDahVpboNotTky7A>
    <xmx:_pBNZhGH3OHYXVNGMIYNrlPk279DfFpchogjO3kKqD0iwaCHKzUo1A>
    <xmx:_pBNZo9k0Q4lPGutfqyoxbNsZCSusFJrz2Nt3H1ORgPWWDo5t_bxqA>
    <xmx:_pBNZmnc8ZdBGGeGPpHm27pXfuhsl_e4j-7R8BXGcQu8ZWdvvdLsjg>
    <xmx:_5BNZm6Wv48uTsFwRpp52B0TLjEtUABzWfk078f-0_CBthG176uvxJLM>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 02:30:21 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/4] LoongArch: Bootloader interface fixes
Date: Wed, 22 May 2024 07:30:19 +0100
Message-Id: <20240522-loongarch-booting-fixes-v2-0-727edb96e548@flygoat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPuQTWYC/4WNQQ6CMBBFr0Jm7Zi2WIiuvIdhUetQJsEOaQmRE
 O5u5QIu3/95/2+QKTFluFUbJFo4s8QC5lSBH1wMhPwqDEaZi7JG4ygSg0t+wKfIzDFgzx/KWDc
 N6Zpa76yFYk+JjqLIj67wwHmWtB5Hi/6l/zcXjQobe/VGaa/qVt37cQ3i5rOXN3T7vn8Bo2V6D
 MAAAAA=
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=RQvekNk+Mw4VZKNhgWLZ47RRb5dhc61tf07pkWTicZQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTfCf8OzdpdsT5wY6rlYdHeZxauZxbJPba1TmP6V6HLX
 rf5xLmvHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRW88Y/jsEWc3wW/7igZS2
 G8tCteynFSJivl8n/n2jFvHOaPKP+HpGhhPOdu7Hj02eUzctNbCnz8VpHZ/RgmkB7OVsUnd07s3
 N5AYA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Hi all,

This series fixed some issues on bootloader - kernel
interface.

The first two fixed booting with devicetree, the last two
enhanced kernel's tolerance on different bootloader implementation.

Please review.

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v2:
- Enhance PATCH 3-4 based on off list discussions with Huacai & co.
- Link to v1: https://lore.kernel.org/r/20240521-loongarch-booting-fixes-v1-0-659c201c0370@flygoat.com

---
Jiaxun Yang (4):
      LoongArch: Fix built-in DTB detection
      LoongArch: smp: Add all CPUs enabled by fdt to NUMA node 0
      LoongArch: Fix entry point in image header
      LoongArch: Override higher address bits in JUMP_VIRT_ADDR

 arch/loongarch/include/asm/stackframe.h  | 2 +-
 arch/loongarch/kernel/head.S             | 2 +-
 arch/loongarch/kernel/setup.c            | 6 ++++--
 arch/loongarch/kernel/smp.c              | 5 ++++-
 drivers/firmware/efi/libstub/loongarch.c | 2 +-
 5 files changed, 11 insertions(+), 6 deletions(-)
---
base-commit: 124cfbcd6d185d4f50be02d5f5afe61578916773
change-id: 20240521-loongarch-booting-fixes-366e13e7ca55

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


