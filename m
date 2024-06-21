Return-Path: <stable+bounces-54823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243DB91266C
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 15:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08472B25047
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E549315444C;
	Fri, 21 Jun 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="s7m0ut1k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sK/X3XRN"
X-Original-To: stable@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DA155308
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975487; cv=none; b=LgZIub+z7/brGPOWFtAsyvLT9hL2cnRaRySX5oJMhOkOej76s8i+fTTkfFDFO1nk1dezi1eQcFo+E+5sxvwlKicLIHWNbUJfJbpO3gYWlVWD6bIAgtsHwb5fNOKmSmdzgmGSBfpniPD+lBHp76c08DRicUZ+OQ8BjcoqCS7JmDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975487; c=relaxed/simple;
	bh=g3k3nWcLqtTiZ2wMMOFp6to4dK8fiS1Lxyx+pASHj8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PwR7v8qTpN4H+Iwp+mnGmrFvUAIG8Av4drjezzzUq6YQHZKY2mlOWgA1m/pzrEgMFLUvlfJwaBdrMVec1/t1jrNQL0V8ahb3XkMqbQ/vgWKBzv2Ww4b6jNr4iG6j/muamWtSuMjyai2ucrx9+2QqCEuoFAPjvmxC/Ud5wruZ+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=s7m0ut1k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sK/X3XRN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 43A551380200;
	Fri, 21 Jun 2024 09:11:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 21 Jun 2024 09:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1718975485;
	 x=1719061885; bh=gT2jLym9c6kJFJ+5mmTK3eAZwFetlVf+TwMnw12Lex4=; b=
	s7m0ut1kbPaGtC4Ey8UiAd+3fFuFMPpttpFhWm5WPNgOj1IgKjhod8I/y9hlYhqk
	F+S8G01jgJbVlYtPwAlRWvW08sPeQpLWt+n7XAU5LticB6fIze2x+B950Mchk4G1
	Ah2SeNCGyGjPqe8B5l/NmMThHbhbUIl1dDCAKK7zsAh80ASC10cuKCXdmp98Ekck
	vSGJvUdWDsSe7k9v0mOFXQQ6nSDytCXKzB4mdYrkYdBH/4phqa/e/p0D3mSYFOIJ
	kRlYjMgCpMeo5uDz3GoXt/iymGHGYgaU4AcfE7svDxMk9TTKYtym3JYCDaMcGZL8
	4Zj0oldgh9tfbdl1mBg84A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718975485; x=
	1719061885; bh=gT2jLym9c6kJFJ+5mmTK3eAZwFetlVf+TwMnw12Lex4=; b=s
	K/X3XRNQjowLDDlDLRqLLp/dk/cFLpsUeCiLVXRdyUw/s3LH/PyjnfBxlsFb4tQ5
	t8+eUennaqFQNpGKjgbfbs1+RTTtvgOSshxrp1ATgYJ4Peqj+MRjoSS/6QAT7F/D
	uzo6xfj8DdsUUVuDghzfTdws+9aTBE+NZK21JeCVxTmn8fODlzRE/Mi164St1BcC
	vaF8HTy/zsSpEEAP55t9AwCe8kKbAN5/h+Lo8jVvPVkRHLzHik7VhH1/lY+EB8xP
	NNDinFOXvP1l89+t0vjPMVNe9fnJn7VSIr1BkF/yLedDncR+JF5UGJRq+njDF/gR
	d+chvqPwYzndEnbAca5Dw==
X-ME-Sender: <xms:_Ht1ZlhvvdTs_OUaOpbsYS5IfGUHV5uCH6I-oYQiTJfcs2KDrn8YZw>
    <xme:_Ht1ZqCUxwNs76BlKTTBnPO9NUG58AueDxKb_PQZgRjl48KM_dNLyXJOnpLFyv6Kz
    x1eCQklOm8CsziOpCQ>
X-ME-Received: <xmr:_Ht1ZlFgYqYD6q-MFKyVh1_VdZ95h9V5JwzpBmS9tBLP-TYb9GpUV0U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:_Ht1ZqQ0-4f579W61tJ4EROwxOajawT3MBEE7bnd0x6Ny2uaocchKg>
    <xmx:_Ht1ZiyGtJJoFNe4wEJ9A8ha2kJgF-q8ITEZDjz-VvOEx2wQXe0sag>
    <xmx:_Ht1Zg5F3wATzNsbAMKb4BQ64mzcaQ0XHStXSjpwTml01pXCh6IinQ>
    <xmx:_Ht1ZnyMoDYfTpCx5MuVisBh3prEGpG1_lLwsrcYHgYhby8kgAMI-Q>
    <xmx:_Xt1ZplaRZ4nNwmGjZZlht1hkZ2AeY61gC5GDCwvQQZ2L3peqIdevP1t>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jun 2024 09:11:23 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 21 Jun 2024 14:11:15 +0100
Subject: [PATCH v2 3/3] linux-user/mips64: Use MIPS64R2-generic as default
 CPU type
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-loongson3-ipi-follow-v2-3-848eafcbb67e@flygoat.com>
References: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
In-Reply-To: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=844;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=g3k3nWcLqtTiZ2wMMOFp6to4dK8fiS1Lxyx+pASHj8Y=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTS6p+MrSf+P0yUeaA1S6x+9RKlJiG/JIfIt5lzPimsS
 jkguNyto5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACbyU4zhrwjbhUeSRiUfZ3xT
 SVPx+uyuadzWnP6RNWeZvt9N9ecL7jAyfG91satd7OM7R/Zr7e+yPulJcbwaPz6W73rlkrB1sks
 ZGwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

5KEf is some what not standard compliant by having non-functional
FCSR condition fields. This is causing glibc test failure in
qemu-user.

Use MIPS64R2-generic as our default type, which have maximum CPU
features.

Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 linux-user/mips64/target_elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 5f2f2df29f7f..82bb7e8b1cbf 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -15,6 +15,6 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_MACH) == EF_MIPS_MACH_5900) {
         return "R5900";
     }
-    return "5KEf";
+    return "MIPS64R2-generic";
 }
 #endif

-- 
2.43.0


