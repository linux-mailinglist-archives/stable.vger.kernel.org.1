Return-Path: <stable+bounces-45535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C768CB490
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 22:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A171C2179B
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 20:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63B0148FF1;
	Tue, 21 May 2024 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="4LTogLoG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="brJx1+nr"
X-Original-To: stable@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031201CD18;
	Tue, 21 May 2024 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716322340; cv=none; b=COd3Z25m84lE6Zx2VTH8/B09VvQ7EcntYYv0CL26dNIq4m54tZqXqQKj8UiYi0A27GomOsKwpV4T6LdT8LCI0TBwnWM2pEJ7Ze/uckTUjk6M07OCX0evtXL8UmYEVpf5r3Ya9SS/3FledgZpaCFeW6caRzFdoe5jENVeW5PVIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716322340; c=relaxed/simple;
	bh=/3RYxDMoRE6zF4QXwHWBpSH29hM6c2SjbD5QDOOo7E0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ljVWJy1XySBHsCjEycFZDfA3i+uVr51RNuHGo/8CEFj7dHiyWzximYGYGxdVRsKRolzVJsjfQVd1G4QdWesfJDZpBIvXnhavxT2IoS88uskomfOQ4t0wylDQi9pRTPMzW0HxjjM6axH7BhgR0gt07FaF9ubTRKLroo9HmcVoBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=4LTogLoG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=brJx1+nr; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id E1A461C000B6;
	Tue, 21 May 2024 16:12:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 21 May 2024 16:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1716322337; x=1716408737; bh=CK
	d/Bt9HXJciJ5UZehDW04kyPnJ5NZPt6aGBwwwY28Y=; b=4LTogLoG6xWs7a85Yi
	wknjS0laHoy6z3HD/fBA0XrHVpipkSUUH+vV7I1NQte/X7KnFkg4XWfFnFx1zudr
	TIR22pFi2fHOol988mk033/iqrlMqVEpy59LTpLPZOBqhnClE7qYTMRQhD4QZnbQ
	DW6uhrqdugAxEAQ2baEzwBHQr+VvlmCMiwOo99WoviSTvUoKVQJ1xEZq5Qajc7D1
	tHkXIVayDq9L2T91Bd0LWgOEzSpb1kt2ELCkJx0E8KH0ilasmeW13iJnDDe1LUVV
	l9ZXQ6RUbwhI93pephTS87loqPwevrAhh+YiVDefGzetj4Fb4tnqLXaDtXsyYZ6k
	UMbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1716322337; x=1716408737; bh=CKd/Bt9HXJciJ
	5UZehDW04kyPnJ5NZPt6aGBwwwY28Y=; b=brJx1+nr2Zjydf+8QOJyhdYZQmrGT
	NPBNDRvY7kv4bAWW1Dw9PjBrqAX3qpYjwoUfFSsQVwEkVXfVM/oPMmALtAZuXGM/
	zgoJ4WoLa0IBr6YieJ6y809TpXvycfvFiijGq2KoWbW+l8k7pJigFrlrDiE1lsRU
	I1QT5g8HYgd8Ys/w3YIl/AyODhJ+wEdvRaqrYVkS4juf7m20Cn5UhfHYEpFAka7a
	+2ZQ++F1/2m7X1KLTu4b/DPfY4u61KkGAsm77yduSwwa0N72eMMpsucj4ATEtDRB
	IKj5rCCHcjJx2F1wTJo95fEyY8Bp7vfF7r2VV/poerBjV+3CiREZcb4/Q==
X-ME-Sender: <xms:IQBNZiattS9qKDp2h6WTlibmV-kLkeJgQkCw1BVNNGfLDjhfsyDs5Q>
    <xme:IQBNZlb56GTr-ypDhH_Bl-4pkalUEF-em-LUiaqyhdy1zolZQNyWISLx75Ba9W5rk
    QHMqB7p9LIuaGvZabM>
X-ME-Received: <xmr:IQBNZs_F3a08OD_mGYBJC2qz5ualvmnffPdREDTVcNbh7dLx5ErbMyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeivddgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedufffffffhueehvefhgfelveekueegteefgeeiieejheefkeeh
    keevudevieegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:IQBNZkqf3Ghh3JHk0-4dTamksdsmEZPvpb6wXJ-18J6sAKUMzTT4QA>
    <xmx:IQBNZtoSiB2SKHdyna0v2DXa6K0zgOn-vsTKoDpfAR-kS_dgteaL-w>
    <xmx:IQBNZiR_vsEAB8oa9j_it52YEVbcNDjiOOHlBc8FiiJHQCPjobD0kQ>
    <xmx:IQBNZtoLJITOxgmtbEFkXnozVss16dfRS3nWTpGq8S44ECeEXwce8g>
    <xmx:IQBNZuenIOkWhP6je5SHfQTdwbFzubSqsiTyvoqaAV_lS1mx_EiKh8jI>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 16:12:16 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/4] LoongArch: Bootloader interface fixes
Date: Tue, 21 May 2024 21:12:11 +0100
Message-Id: <20240521-loongarch-booting-fixes-v1-0-659c201c0370@flygoat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABsATWYC/x3LQQqAIBBA0avErBtIzYKuEi3MJhsIJzQiiO6et
 Hx8/gOZElOGoXog0cWZJRaougK/uRgIeSkG3ei2sVrhLhKDS37DWeTkGHDlmzKariNlqPfOWij
 3kegPZR6n9/0AJP7hYGkAAAA=
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=975;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=/3RYxDMoRE6zF4QXwHWBpSH29hM6c2SjbD5QDOOo7E0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjRfBgWLQj0mCcl1F4UT85fMCb/xek7otu8x+7dd0f1eG
 H3IM35jRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzk83eGX8ydN54rhD2QvtV0
 46mEv2Kl/I8bLsJ3Cgo2Fc27lP74YxIjw5TWv9POVL3XmezL9fvdnwvPQuyNJdyNbpyNfbbNeuq
 Om7wA
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
Jiaxun Yang (4):
      LoongArch: Fix built-in DTB detection
      LoongArch: smp: Add all CPUs enabled by fdt to NUMA node 0
      LoongArch: Fix entry point in image header
      LoongArch: Clear higher address bits in JUMP_VIRT_ADDR

 arch/loongarch/include/asm/stackframe.h | 4 +++-
 arch/loongarch/kernel/head.S            | 2 +-
 arch/loongarch/kernel/setup.c           | 6 ++++--
 arch/loongarch/kernel/smp.c             | 5 ++++-
 4 files changed, 12 insertions(+), 5 deletions(-)
---
base-commit: 124cfbcd6d185d4f50be02d5f5afe61578916773
change-id: 20240521-loongarch-booting-fixes-366e13e7ca55

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


