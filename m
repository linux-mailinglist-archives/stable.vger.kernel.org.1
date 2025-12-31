Return-Path: <stable+bounces-204339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2B4CEBF3A
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 13:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB94E301AD1A
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5947332142A;
	Wed, 31 Dec 2025 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="E+HOrg53";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o9WA2wTH"
X-Original-To: stable@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D813168F2;
	Wed, 31 Dec 2025 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183728; cv=none; b=k7E/LAFB22qih8WsCwJePwzx3YqgFR5+/37rYCCvWuZP4l9/YbLLDJKIoNKyDfanGRZgFA9whN1uL86sVf4w50LaVVYHZOL93b5G+2bfdteNa3wWzf+aEm3nMEGVpIy5gFALKmG6YNkCQOSdn2ZpknRJ4R9dHihEH4nfMCRax+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183728; c=relaxed/simple;
	bh=NfH/EVhKHGNRXy6pl4rolyAG7g4vT7LN9g0dWp0UYdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lGoPvNvpIYnR3gZlt+hqMhvTu1478eSA42ykpjZZ1zYVQ1PqiCi2aeGuxw9bt2M9xxaTE6dmp+iopbyQkJcd/lN5hoKfZUhX2DplVfn0UolZarUsQXEl4W8ERYHarFoGHwjDpX+oWYw/72Cy+BSAUx0/jwv6A+4Wu0/HLANylds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=E+HOrg53; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o9WA2wTH; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6FFAB1D000CF;
	Wed, 31 Dec 2025 07:22:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 31 Dec 2025 07:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1767183725; x=1767270125; bh=zR
	vk/nOzB0Tp+A3fJ9KZKPiPm1cPPjhvzPZ3yF5gRls=; b=E+HOrg53Xnacj8NhCo
	yh8/JIMB9hEAHPTVlPFFWgoajkbAe0E47uc0Rz91+55QqHQLeyOlETdfuZ8Zwf0o
	YarHDctummfpoi+FDCPwRktH0WyauOFexRKrjpWoZruEl+lYgDpwm3xPlYe0Zj+L
	3QmbKnNt+z6pdM2Eit1hCL5v671HBvs0u8WLkEhl/Y9JOlSpICyIY+Dlso5wgseV
	v/8NRq1bLdDJhcrjfLKunLnG96LrEIfCGeOrm4mfsbB6i/NBEUWOfrVQB2kyWYZu
	BGxTQxakrxHWKUFbXfDiIWPUsfPKbWUKXlkAqoEpxqgui8YtrgnHXH96TnEhb7F0
	6XrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1767183725; x=1767270125; bh=zRvk/nOzB0Tp+A3fJ9KZKPiPm1cP
	PjhvzPZ3yF5gRls=; b=o9WA2wTHA8+wgYgKRPho/ZIhOhyaSjLOB+Y7MgDI7J7r
	qeom/dFVWG0HK29fkl2sG4x1TvU+k5F2BAE/utYJzRuxTvUcd6vZeR4yRSPjjT/a
	8Tn3E6dWr0rEQgWaJmlAY7pC0AAr+tWV1hbL3NKoCVBda3elFCcWNkrqR+A4D1G5
	Shk2+h10us4ozi7I3WKNXh57Fo8kF08nP5QNOFcYnus3lLKwA6OKae/S4ZMJ4YG5
	a6YsUQUnkHaZZ3wHlSzLvYHpXm0xft66xkQ6J5nxor4/ejddnBGMMONUtgzenFMl
	JjnO4/hF+x2xH31xVFmcUwNUfsnt2kej/IKsQZOzGQ==
X-ME-Sender: <xms:bBVVad2v3144adM6FA6tLZFSxgatyc6A7tFftItfs1qJGz169gr1Bw>
    <xme:bBVVaVqsqFVKZDjuBqBRd85_Kc3ZQ7Ih3HTUgykOcSwF6Cq7p8_RQ1anns5bUuSa_
    I1T06BOw42HLGx3G52nR2GPHt6EE3LOtdyeV6cizj6BPhtj7CwL0EA>
X-ME-Received: <xmr:bBVVadLULDlaKUsXEvzg-BXIlfuEy5d04oeixrZfXlMDuTyQyQRYKLU_kfks6q1Qd7H1f8Tq84TKxhrQym68W8yiqOtbVF1ZY6NgjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvdeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
    uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefheeltd
    ehfeetjeefvdehteeutddtteelgeduueetjeevteeifeeuvdefffdvieenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeduuddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinh
    hugidruggvvhdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhtuh
    hrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgt
    lhhksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmh
    dqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    nhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:bBVVaRQb4hdswrJK_l5PU9gDkLJaKyZHTKtFtqn1mQ9UTqibN3EvIQ>
    <xmx:bBVVaVONomfu0ogpm2Z4jtyaMssARlLc6r9-TARacenzwh_jGTcb6w>
    <xmx:bBVVaeU8HcDEsnPtBRy594UGL2A-0Y3_lNrCfuY7t5_byQREgoZcvw>
    <xmx:bBVVaQjNNEckMFdZjqt2SfOiAlSx7ctZnFKL98MWgGSQHm6V367fIA>
    <xmx:bRVVaRnjyk9aiMLSM_RWjHRY2vxsbx3A9OnHY8UISqaimLOenESc83hh>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 07:22:04 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Wed, 31 Dec 2025 13:22:00 +0100
Subject: [PATCH] clk: clk-apple-nco: Add "apple,t8103-nco" compatible
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-clk-apple-nco-t8103-base-compat-v1-1-6459e65b6299@jannau.net>
X-B4-Tracking: v=1; b=H4sIAGcVVWkC/x3NywrCMBBG4Vcps3YgF8Tgq4iLcfqrgzUJSRGh9
 N0NLr/NORt1NEOn87RRw8e6lTzgDxPpU/IDbPMwBReOPkTPurxYal3AWQuvybvIN+lgLe8qK88
 QF09QRUo0KrXhbt//4XLd9x+PvR8UcQAAAA==
X-Change-ID: 20251231-clk-apple-nco-t8103-base-compat-dea037ecce88
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=NfH/EVhKHGNRXy6pl4rolyAG7g4vT7LN9g0dWp0UYdw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsxQ0awGtiW24TnbKu8kfsvpsFv+u/P+swPSAXs33d/zY
 EbLnSVrO0pZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAEzkdjIjw+Oj2pbTll/x5yiX
 vBfCznfz8d+46ieX95/ekXjXkfn9tHsM/4McpTgWznz0ufOZ73SnzIlpV67kPguqkLGdzPClfF3
 8cz4A
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

After discussion with the devicetree maintainers we agreed to not extend
lists with the generic compatible "apple,nco" anymore [1]. Use
"apple,t8103-nco" as base compatible as it is the SoC the driver and
bindings were written for.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Fixes: 6641057d5dba ("clk: clk-apple-nco: Add driver for Apple NCO")
Cc: stable@vger.kernel.org
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
This is split off from the v1 series adding Apple M2 Pro/Max/Ultra
device trees in [2].

Changes compared to that series:
- add "Fixes:" and "Cc: stable" for handling this as fix adding a device
  id
- add Neal's and Stephen's trailers
---
 drivers/clk/clk-apple-nco.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-apple-nco.c b/drivers/clk/clk-apple-nco.c
index d3ced4a0f029ec0440ff42d49d31e314fdf86846..434c067968bbc1afdb5c9216277486bf826666c2 100644
--- a/drivers/clk/clk-apple-nco.c
+++ b/drivers/clk/clk-apple-nco.c
@@ -320,6 +320,7 @@ static int applnco_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id applnco_ids[] = {
+	{ .compatible = "apple,t8103-nco" },
 	{ .compatible = "apple,nco" },
 	{ }
 };

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251231-clk-apple-nco-t8103-base-compat-dea037ecce88

Best regards,
-- 
Janne Grunau <j@jannau.net>


