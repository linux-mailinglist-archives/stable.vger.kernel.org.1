Return-Path: <stable+bounces-204332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D7ACEBBD6
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 11:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C96D4300D55C
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 10:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A859318155;
	Wed, 31 Dec 2025 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="RXuURktU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MlAtCwQ1"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C13128AD;
	Wed, 31 Dec 2025 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767175867; cv=none; b=KRWG4YJtZZkl4ax4+dw5uWBlN2lib2fnngA4REaKmxRPzaocf0tdbcwFofk+1W2yCH3Vj1ClMrpk2awzTOkKUq8SzISPc/zk2NW12Vu8BhHePCxX3oGW3HV+RdntHU6mJFiLI7NQmj4bXa3vymv3p1Fi57JoMSS07w0R25A4KN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767175867; c=relaxed/simple;
	bh=Z6UfWp3DVlHIsal4wMPx5lIHO6KQiRUKtFUsnXt0oXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=noxJvcD96+SDuzXRuD7lcQAleq99+Cvdvz/6iTngcRaByWZDGE+mb8PWJtSYUMzmiYWcjq/YM0uT9wJ5ug/c2O5mjThDwYFoqWaGAb19nup+WRWybVvUE/cfus5on0EvD8sJ3aa7+clAHNHd3USOts0Ui77olX/abYjNKSrxHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=RXuURktU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MlAtCwQ1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 462627A0130;
	Wed, 31 Dec 2025 05:11:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 31 Dec 2025 05:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1767175862; x=1767262262; bh=u9
	9kyjHIdrk8TOgcfR0ihUIFHQzHwPedb8Ibv3lFtdk=; b=RXuURktULgqHTOm5p2
	LU9l8A33grZkd73wFvFpEShwP5TFW5MUCNqotFyGLYm1aJahQvklel3VvmDEIbii
	TxeX015y3kM0JATyNQObOxt3I+1iXnicDlERKHsTBO27rkpHaF3jfSSG6a6rI+Wq
	mnLhSD5xdeaG3vxvKFn5HLoVJVNEdzA9UV9lel9Z9Q09QN2YWzedNcACdwGbrI7D
	LGtxznKRAHGZYf8pMd2PajKL6KXSxeaUFzi/JNT3Y14fRv0vtJTynuDQSKk5bsXJ
	TwpULRBbEzRkEEK04s4cbm0wzY39CUg+XT8t//SPTzoYiyow216SfG3FQZaUAv55
	bJPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1767175862; x=1767262262; bh=u99kyjHIdrk8TOgcfR0ihUIFHQzH
	wPedb8Ibv3lFtdk=; b=MlAtCwQ1rchxIyK+JrkCZo/WFvPw29NyOtNQBeAF38om
	1nzVH4wvUhiHCOEb6zD+aKnAbeOHDI/mE4ZZ7Dy7JFwyKkRRnCjkC+LDN0ltAkkG
	0wDJTuaJ6ZuSIQMAnkwSAqATpaD42Zb2iJKF74nD9OLIhcChu4HuYpdVrIZ3ikuB
	Rv3pTwA0qInE5FmeLt5UxUuElqV31Vu32Cz9jI9KXm0hivS+iiWGtdNEam05uoYt
	1uY7TpLm/I1oa8EVZJUjjpW4LZP2T9rHvEcxWoEMU1GDI3umpBUCtO5mM3d8wNt9
	7Er2pwDafw38ejTCelzlSYXFmt+ksmNZ9nbT6+mc7w==
X-ME-Sender: <xms:tfZUaRla3d4UwZBrqj2eCPNgrhMNk55uy9dGcnQb4JRJ89cbP-wzEA>
    <xme:tfZUaSAavrCTsqj_xd1zop-SopBsmAo-lhDjOwxw1tfiltNLnVrcxTMJEXInOqInq
    SgRDtBs-aaZcdx54o7Jt7un5wUE1LOhLSw2pQsNBENRbYlpQgBIMpE>
X-ME-Received: <xmr:tfZUabBnVAHQ4rhxIgAF3q0n1oHFCVEml5WgGIgamEw7aFtb3SxKSOzfysHWj_ctU1EdtpEMwRW0UEjFDIECCLU6_tTzIpjH7FFU6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvdeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
    uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefheeltd
    ehfeetjeefvdehteeutddtteelgeduueetjeevteeifeeuvdefffdvieenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopedufedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtoheprghsrghhiheslh
    hishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggv
    pdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehlihhnuhigqdgrrhhm
    qdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hsrghgihesghhrihhmsggvrhhgrdhmvg
X-ME-Proxy: <xmx:tfZUaRGFdjrAjOsB4h5j5vSEBP-seUe1rKRsD3V2ejiEqnCcbcJ7Pg>
    <xmx:tfZUaa6BK6yXd70L-pCL9crcN_5gzw6V2IZccZRC315QuATri1IlHQ>
    <xmx:tfZUaQQLURa_QhUecD5M0uCXigMZvhuHSzBLYRRmtwU8BtYIgNGWXg>
    <xmx:tfZUad7Z0jJ55pAMNZrIFkeLjKSYHvWFadQWPNtvsqlk-YFCfQOXcA>
    <xmx:tvZUaQgGPvXNkXVN7-Edapio7OXyCpoXNQN8EK-9scB1basXbBFxnNCb>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 05:11:00 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Wed, 31 Dec 2025 11:10:57 +0100
Subject: [PATCH] nvme-apple: Add "apple,t8103-nvme-ans2" as compatible
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-nvme-apple-t8103-base-compat-v1-1-dc11727dc930@jannau.net>
X-B4-Tracking: v=1; b=H4sIALD2VGkC/x3MwQqEIBAA0F+JOTegtrrRr0SH0aZ2oEw0YiH69
 5U9vsu7oXAWLjA0N2S+pMgRK3TbQPhQXBllrgajjNXKOIzXzkgpbYxnr1WHngpjOPZEJ3a296S
 sey1vB7VImRf5/vtxep4fSrzdnG4AAAA=
X-Change-ID: 20251026-nvme-apple-t8103-base-compat-358ba0564f76
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1949; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=Z6UfWp3DVlHIsal4wMPx5lIHO6KQiRUKtFUsnXt0oXg=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsyQb5tV12pHblu1a0ZetWv+Tdu9zU6Kxy1aF7iLKHupp
 134/+JHRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgImkeTMy/DhuqvHLaaL3sv0e
 z2uUrErmr1F48f18f/3xBauXR6Vo3Wf47xw29bD89zuMTlGcDQ9FFoYsqq9seX7p7WrfJ07eHhL
 3OQE=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

After discussion with the devicetree maintainers we agreed to not extend
lists with the generic compatible "apple,nvme-ans2" anymore [1]. Add
"apple,t8103-nvme-ans2" as fallback compatible as it is the SoC the
driver and bindings were written for.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Cc: stable@vger.kernel.org # v6.18+
Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
This is split off from the v1 series adding Apple M2 Pro/Max/Ultra
device trees in [2]. Handling this as fix adding a device id only for
v6.18+ for two reasons. apple_nvme_of_match gained hw_data in v6.18 and
device trees using this compatible were only added in v6.18.
    
2: https://lore.kernel.org/r/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net
    
Changes compared to the patch in that series:
- rebased onto v6.19-rc1 since commit 04d8ecf37b5e ("nvme: apple: Add
  Apple A11 support") introduced hw data for the match table
---
 drivers/nvme/host/apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 15b3d07f8ccdd023cd3be75eedd349b747c1ecad..ed61b97fde59f7e02664798d9c2612ac16307f5c 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1704,6 +1704,7 @@ static const struct apple_nvme_hw apple_nvme_t8103_hw = {
 
 static const struct of_device_id apple_nvme_of_match[] = {
 	{ .compatible = "apple,t8015-nvme-ans2", .data = &apple_nvme_t8015_hw },
+	{ .compatible = "apple,t8103-nvme-ans2", .data = &apple_nvme_t8103_hw },
 	{ .compatible = "apple,nvme-ans2", .data = &apple_nvme_t8103_hw },
 	{},
 };

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251026-nvme-apple-t8103-base-compat-358ba0564f76

Best regards,
-- 
Janne Grunau <j@jannau.net>


