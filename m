Return-Path: <stable+bounces-73997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFE7971580
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 12:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9181F230FC
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58AD1B3735;
	Mon,  9 Sep 2024 10:40:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86E1B2ED5;
	Mon,  9 Sep 2024 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878407; cv=none; b=rgCTBsiDswkiZtfT6wQBarcG+26jpsQYGbo0N/jQWur3dREuieuER3bHnSNZZ/7I2X35q8WVrtgGLMu+3U54DFnWpjFF5qFSs7x73l10pAxvmW/bvRg/1qGTPYjSgmOB6WTfPw4NxGDh1VU0jyweM3WVj3V2W3C6UThcAUbfvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878407; c=relaxed/simple;
	bh=Izr3JLPlYBReGtByqi0KocixlambMNHRNmKsigvBQpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mf1Lm9yacf0yZ5Xw0xKSk7rBcoK8Ku2HqdahN6SH5zwRAUQ9Y30iJeDTFaeaEBvsqd2jTtYCqdbWwhtEurh+/OrBJMHfa7qbQShSKsg8BcCQlYWbcAbJhiE8ZZcMGqviM8L1yJ6j8isgGy2vzY6E+4V087+urAu5/x0xX5rLnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.111] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <abelova@astralinux.ru>)
	id 1snbms-00BGaZ-9C; Mon, 09 Sep 2024 13:38:26 +0300
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.198.22.134])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4X2Nck68X3z1c0X1;
	Mon,  9 Sep 2024 13:39:34 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: Marc Zyngier <maz@kernel.org>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Matt Evans <matt.evans@arm.com>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] arm64: KVM: prevent overflow in inject_abt64
Date: Mon,  9 Sep 2024 13:38:28 +0300
Message-Id: <20240909103828.16699-3-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240909103828.16699-1-abelova@astralinux.ru>
References: <20240909103828.16699-1-abelova@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgrshhtrghsihgruceuvghlohhvrgcuoegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeevhfduuefhueektdefkedvgfekgfekffegvdetffehfefhffejhfehveevudeigfenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudelkedrvddvrddufeegnecurfgrrhgrmhephhgvlhhopehrsghtrgdqmhhskhdqlhhtqddutdeitdeivddrrghsthhrrghlihhnuhigrdhruhdpihhnvghtpedutddrudelkedrvddvrddufeegmeefheeifeekpdhmrghilhhfrhhomheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepmhgriieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdprhgtphhtthhopeholhhivhgvrhdruhhpthhonheslhhinhhugidruggvvhdprhgtphhtthhopehjrghmvghsrdhmohhrshgvsegrrhhmrdgtohhmpdhrtghpthhtohepshhuiihukhhirdhpohhulhhoshgvsegrrh
 hmrdgtohhmpdhrtghpthhtohephihuiigvnhhghhhuiheshhhurgifvghirdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhtrdgvvhgrnhhssegrrhhmrdgtohhmpdhrtghpthhtoheptghhrhhishhtohhffhgvrhdruggrlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehkvhhmrghrmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghenucffrhdrhggvsgcutehnthhishhprghmmecunecuvfgrghhsme
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1725640479#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12165305, Updated: 2024-Sep-09 08:42:30 UTC]

ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT = 0x24 << 26.
This operation's result is int with 1 in 32th bit.
While casting this value into u64 (esr is u64) 1
fills 32 highest bits.

Add explicit casting to prevent it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e4fe9e7dc382 ("kvm: arm64: Fix EC field in inject_abt64")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 arch/arm64/kvm/inject_fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index b6b2cfff6629..6cb191b799ac 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -79,7 +79,7 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
 		esr |= ((u64)ESR_ELx_EC_IABT_CUR << ESR_ELx_EC_SHIFT);
 
 	if (!is_iabt)
-		esr |= ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
+		esr |= (u64)ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
 
 	esr |= ESR_ELx_FSC_EXTABT;
 
-- 
2.30.2


