Return-Path: <stable+bounces-45602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D77D8CC8B4
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 00:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146A71F22D6C
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 22:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42BB148316;
	Wed, 22 May 2024 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="cWtGFMvU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iBB34r8X"
X-Original-To: stable@vger.kernel.org
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222181411D8;
	Wed, 22 May 2024 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415352; cv=none; b=WgKiE++3hQfhNjpTc2Uld+7OMIOtypUoASyVq53eY3tZvoHMdymh7T7uuKg8ariS6Nbvj0H3XWOHmH99rpHJgK19tpRgqnwtZzQ1erQHeXny+ahD/5D4/FEbTE8QWt3XJEO9whEKZ29SOy/DTRjsyeRwh7kfxzbZWyt+4Xge164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415352; c=relaxed/simple;
	bh=7fdJBdzIPfqGGEwtcL8/d/uM5agRxxUtdOfdCs2glQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9XHesWADTT/Ese8Le5S5dF27uO4pxY4zHBqT71yjtYOChEow73HI/eU5vRJRZwwcgJXr9gwkEXANTYUFc+H5q8XsOAtt1H0cTlf6OmoVJG1F2IHP/dH0K4UZ1Fs7DvU0EXil0tJDJmV1oSsqmTtvg4Gf+kRkMoON4xHmksrXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=cWtGFMvU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iBB34r8X; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 40575180012F;
	Wed, 22 May 2024 18:02:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 22 May 2024 18:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1716415349;
	 x=1716501749; bh=eohBkNeC9goPP1VCyGzG57xJ91PgPdvWRQbAuvbCQlw=; b=
	cWtGFMvU/1fsBfnOLQYfE1/RRhrbnG9lwDpP2nTUTSSIzlj2FzrWs8a+2ngN+mIF
	1ul5L+xMrMJUite9KxIC8Ei8SldhSzIbyK09UbFP4HGA10k9EURyr+QthvuVsGYL
	Bp6vPm9gZ6Le7p+q6KU5wA0vnv5XD6+065k40+5OIQqRuwK7YJqGfwks7IM7Lr83
	QkJAhVYtxcKTiosng9LjhVN90jtCf2EyciiCcJ7g/V6NDCMARgZY+UOs+o/rNzDT
	iCN5nyUrqLiE3QoqsCdecC685+odFUeSqRl9Rsu2nVWIFJ0dYe+5yctTdp1CJvt9
	lbqkNdNS+oO0aWhHIEnZqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716415349; x=
	1716501749; bh=eohBkNeC9goPP1VCyGzG57xJ91PgPdvWRQbAuvbCQlw=; b=i
	BB34r8XRZUoTLMyUy2w3h6zzY8B2MyyX6gaQTRKhGO8/X7x3nBaCYpAY65NtilTg
	VJH7SJiIFfFOZUwmvjFbNeWGFUvK+OicAoxoFlhEavONJTIeEeGXet5cgCNlCx/p
	XQwIUN1pV069s49kSfymbPA6zyUQTgkox/KRjVnoz/9Xf2YBC33lilPeCSxqyRNY
	aD+SoG2jakd6tUwcha1WcEGqP2KRFvKfahN3JdiIxKDX4Y4yRkjMekVZaEAJTneZ
	o6pSs8xzhCnNtpPdC0b0jr+dcBqYgJPZWt3Hz1iWrcfCTc2kJxZ6zXIpcvYXs741
	5Nl3iYmMG3OTErg0QrnCg==
X-ME-Sender: <xms:dWtOZvdnZicuVsDe8T0eLpf3old_WET7EC7jkfjkXoeNjas2DTyL8A>
    <xme:dWtOZlNKrBk92rXMBTtrulp_jmPu0SLEIJtW0dsO_R_uZGW9whhMgIuVgTBzBErZp
    JZZTzq-jR--klC5Ygk>
X-ME-Received: <xmr:dWtOZoiPBi9p4o2tcdH0PEkDX4BQE0mh8IPkV3Zwp2sruWPYSnHkr_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeihedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:dWtOZg-5AnFNO4JL5UXWFhQnyprk-pO-SKAANAacZ0UfhMLSQnSagQ>
    <xmx:dWtOZrsJhGgHWu9kyfVW-z5L6-l1o2FL2O-ze6l7o_kus_Tqbs9zHQ>
    <xmx:dWtOZvHCQMTjX0APRNO40rNHdcnNSpfyUN04ENGArONqcpz1GAm3rg>
    <xmx:dWtOZiMYgeV89GtThfawqerNGuMLUsWVB7dBcv9IEaoLOhqDn4jeYQ>
    <xmx:dWtOZvi4KTXrMfaFWvx9ebcStTjaMqo9RwznBjm0Uk5bcxvyQL5FG6zh>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 18:02:28 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 23:02:20 +0100
Subject: [PATCH v3 4/4] LoongArch: Override higher address bits in
 JUMP_VIRT_ADDR
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-booting-fixes-v3-4-25e77a8fc86e@flygoat.com>
References: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com>
In-Reply-To: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=7fdJBdzIPfqGGEwtcL8/d/uM5agRxxUtdOfdCs2glQQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjS/7JzH9+Mblh89VqzPGryVL6GvdHpx3L/l74O2WUpn8
 l5e+Kuyo5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACZylZGRobckVX7HaWZ9/R1T
 xa+/aO3u2JHWv5pNKPa+5+nbVvF1/Az/HaqOcHWFnP5vk/umifX3Hsl0oaBvzOc90uc/zrlht3U
 BLwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

In JUMP_VIRT_ADDR we are performing an or calculation on
address value directly from pcaddi.

This will only work if we are currently running from direct
1:1 mapping addresses or firmware's DMW is configured exactly
same as kernel. Still, we should not rely on such assumption.

Fix by overriding higher bits in address comes from pcaddi,
so we can get rid of or operator.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Overriding address with bstrins
---
 arch/loongarch/include/asm/stackframe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 45b507a7b06f..51dec8b17d16 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -42,7 +42,7 @@
 	.macro JUMP_VIRT_ADDR temp1 temp2
 	li.d	\temp1, CACHE_BASE
 	pcaddi	\temp2, 0
-	or	\temp1, \temp1, \temp2
+	bstrins.d	\temp1, \temp2, (DMW_PABITS - 1), 0
 	jirl	zero, \temp1, 0xc
 	.endm
 

-- 
2.43.0


