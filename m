Return-Path: <stable+bounces-75640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC5E973849
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3331C23CDE
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16E5192B61;
	Tue, 10 Sep 2024 13:08:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.astralinux.ru (mx.astralinux.ru [89.232.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A8192591;
	Tue, 10 Sep 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.232.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973694; cv=none; b=JJ43xYwIiruKcCBdTdbfkkJYDa+SbrQnbIRkL2Ih4I4kSw4GaMMHKdd3E2WgkjH98BcZMVPw8NMdnOpisNEnMylCAFQkM8vSuc/wjGOSpUYDiLN2hKaFnVePIE3oZaX2xxRN3sXyJD0onKVDlsjIJqQi+L/gcRtGAP5gz7iDwzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973694; c=relaxed/simple;
	bh=Vs8uPQD8E8pfCVKCE//Lvg56Q9HeLbsiEAOnX6MpK30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jdHYXzEp+R6ERU8x5UHEQzyqjIEuPw3Rrz3LxX89nbY+LASutyL4u4UrzxPqQCV3M1vt3QmjhQCHAI+pjxIRfF9jdDC4Sc/0UYv02An5G4T8m0fNQNaKrZcKZv+8asoMJcPJSOxLJOahyJ8vuGv6L6ge98rwK2JsJnq9oCcEzoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=89.232.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from [10.177.185.109] (helo=new-mail.astralinux.ru)
	by mx.astralinux.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <abelova@astralinux.ru>)
	id 1so0Zg-00BeTL-5I; Tue, 10 Sep 2024 16:06:28 +0300
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.58])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4X33s62D3YzkWZc;
	Tue, 10 Sep 2024 16:07:38 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: Michael Turquette <mturquette@baylibre.com>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Stephen Boyd <sboyd@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-actions@lists.infradead.org (moderated list:ARM/ACTIONS SEMI ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] clk: actions: prevent overflow in owl_pll_recalc_rate
Date: Tue, 10 Sep 2024 16:06:40 +0300
Message-Id: <20240910130640.20631-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhgrshhtrghsihgruceuvghlohhvrgcuoegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeffvddvueehvedvgfeivdeuvdduteeulefgfeehieffgfehtedutdfgveefvdeiheenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudejjedrvddtrdehkeenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdquddtiedtiedvrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrddujeejrddvtddrheekmeehudejjeeipdhmrghilhhfrhhomheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggvrhgsvghrsehsuhhsvgdruggvpdhrtghpthhtohepmhgrnhhivhgrnhhnrghnrdhsrgguhhgrshhivhgrmh
 eslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqtghlkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghtihhonhhssehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhvtgdqphhrohhjvggttheslhhinhhugihtvghsthhinhhgrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuffhrrdghvggsucetnhhtihhsphgrmhemucenucfvrghgshem
X-DrWeb-SpamVersion: Dr.Web Antispam 1.0.7.202406240#1725964328#02
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12167416, Updated: 2024-Sep-10 10:50:50 UTC]

In case of OWL S900 SoC clock driver there are cases
where bfreq = 24000000, shift = 0. If value read from
CMU_COREPLL or CMU_DDRPLL to val is big enough, an
overflow may occur.

Add explicit casting to prevent it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2792c37e94c8 ("clk: actions: Add pll clock support")
Cc: <stable@vger.kernel.org> 
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/clk/actions/owl-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/actions/owl-pll.c b/drivers/clk/actions/owl-pll.c
index 155f313986b4..fa17567665ec 100644
--- a/drivers/clk/actions/owl-pll.c
+++ b/drivers/clk/actions/owl-pll.c
@@ -104,7 +104,7 @@ static unsigned long owl_pll_recalc_rate(struct clk_hw *hw,
 	val = val >> pll_hw->shift;
 	val &= mul_mask(pll_hw);
 
-	return pll_hw->bfreq * val;
+	return (unsigned long)pll_hw->bfreq * val;
 }
 
 static int owl_pll_is_enabled(struct clk_hw *hw)
-- 
2.30.2


