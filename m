Return-Path: <stable+bounces-45556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41CB8CBB63
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 08:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB81282C0F
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 06:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2B37E118;
	Wed, 22 May 2024 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="fVoUJwDY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TIs24USG"
X-Original-To: stable@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27A79B9D;
	Wed, 22 May 2024 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359430; cv=none; b=tvfDmRplCvYkJExivAuPpyZT3vkxxKZ+BJ+QiAn4qYkWlLkEHrIk7kKh4kaHv5IthLyd6i9RiB3yckYhkyDNDtQzJEFTymliOT/gzHSSmThRGCJA4qnhSVZDgIfQJKvENqWD2rCaScNoV84wfSZYtvSPW+cyckIQ2FEHwNCXMhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359430; c=relaxed/simple;
	bh=7fdJBdzIPfqGGEwtcL8/d/uM5agRxxUtdOfdCs2glQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=InDttVzW5k/bIC9yHvwSLzLDBb1d7xdMoBuoyrbtfCfcB1pDpBkXXSB72gkMulUXLDPfaFFO+fQ5HMieD77A7kndKoFUP+IPS6k9I4V48JZHylekWPh3ud9o8Ows7/6DQP77An+h8J1unEifaKcoX7M3qUPNZnI+UtUm+0UhVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=fVoUJwDY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TIs24USG; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 50A011380136;
	Wed, 22 May 2024 02:30:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 22 May 2024 02:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1716359428;
	 x=1716445828; bh=eohBkNeC9goPP1VCyGzG57xJ91PgPdvWRQbAuvbCQlw=; b=
	fVoUJwDY2+YLcoVZNqYZjf7btGSTqv/aNWOouqg2i9AFQLMH4xSLFzHWmMMISEj+
	hU99knFR80sxC+y3auR5oSb+Nw+DPkdHXNfI7p/APUUbvKDx8AiUU02Td65DG3E0
	1CWUbYOCK5RM7mJPAnNT//jRgsgX/rO8bIb7i3NISDdBeGRSJWtnX3jAvW1KS1EM
	lkckQM0TWVR8VjY/1qYHiYjQmPyqL6VPJHZq1SnzGCz8Z4ncV8AF6jGnIM8DH6Ho
	ev2dZViV2iKl9ILTp4aFM8tQhrdRZMxbbxw6/KlylxuJjBd5eOR1YrDfT6CYquAA
	s3fkRnl+CSHB82XI4FMq8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716359428; x=
	1716445828; bh=eohBkNeC9goPP1VCyGzG57xJ91PgPdvWRQbAuvbCQlw=; b=T
	Is24USGqMD5yV6/GD4pfOiVEoVjSYdv0aFK07EHJ8wssa7CWTz9GdjrWeueUp68b
	8r21VKiePxdChBhCtekK9vizAC29QVu5GVqu0yG/xCcTj56hp4SI4E4+IPgayFYK
	PlsVb99kYylNotP/OtX6TE+ZZLxrCmEqE9izc4B1f3/6yqp9+PC1SZTuve0aWy4o
	OsQcQeiralXLjr9yiWVq3tHBxnkJqbfcwJpvtT0prHFmbTq9xxlNQp2Pmd+9SAPx
	mNiNTA/gJO5IKoS0cmUD7qVn1giP4KCrJfkjkFcVVoGtT59NPfvwuXaynkT5FYsU
	M5dLcjoyLm61geW047qEA==
X-ME-Sender: <xms:BJFNZliiQyolOdyLkhn73-b34Ck0kPzi5Av7Z91gUnqrx6-1BaAtMQ>
    <xme:BJFNZqBLvQNnhy3_iYFWua5VnNPVr8U6tTox5U5uEZJK2ptaehPWG8mjsWkOkQHiT
    -pHqElJZwcYM65EO50>
X-ME-Received: <xmr:BJFNZlFLaxivxEqJAg07rMP8aUOzpcUD1ApH4LbKhK77MLIuzy9-THM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:BJFNZqRD6bxjuR1ZTfwkD2tNO2VevwT_5JWvbmPm5FkPu0GDMTWsxQ>
    <xmx:BJFNZizpitEmvHvlVyYjwMVReZGdvm8tw5Wyms3fiFpBURUvOO-7TQ>
    <xmx:BJFNZg5sGaMyuq9idM3OxFzx3rfebSw21ij9QxMJsvxeqEgeIgG-SA>
    <xmx:BJFNZnwnbXyUmX7o9tsYlSBu2bzV03ODUX9qKzcZV34vTwxMNKziKA>
    <xmx:BJFNZplNvn0m6Jvhps1M694SVVyRXcKfxJx6E9SEPzLyKCxj4YSekuyR>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 02:30:27 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 07:30:23 +0100
Subject: [PATCH v2 4/4] LoongArch: Override higher address bits in
 JUMP_VIRT_ADDR
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-booting-fixes-v2-4-727edb96e548@flygoat.com>
References: <20240522-loongarch-booting-fixes-v2-0-727edb96e548@flygoat.com>
In-Reply-To: <20240522-loongarch-booting-fixes-v2-0-727edb96e548@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, 
 Binbin Zhou <zhoubinbin@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=7fdJBdzIPfqGGEwtcL8/d/uM5agRxxUtdOfdCs2glQQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTfCf82tCQskD17SqvD5e2E7Tb8NxzYQh44W7zPfsvGL
 SvSNWlPRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExESZ7hf7ma4e6t876fevqn
 siVk2nHWLUf5v7zfrHz6z/w7Bd/SuPwY/qnvYthjEhe3ZnnWux2psz7vWfT+3eFXa47zeuwObJb
 wU+ADAA==
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


