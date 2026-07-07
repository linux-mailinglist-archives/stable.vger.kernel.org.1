Return-Path: <stable+bounces-272371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ws49FtezTGqvoQEAu9opvQ
	(envelope-from <stable+bounces-272371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:07:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C716F718E78
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:07:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qZXYPWAG;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272371-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272371-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D33553094709
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 07:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4E139BFED;
	Tue,  7 Jul 2026 07:49:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D136A367
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 07:49:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410567; cv=none; b=cluL64z5xgqJ6PJw4lzilHkcfEBj0t3QoYPEWbcWZ80uMlKw/BhC4ZOmNaAZraPkif9CBDx+l9PxCQ8KJcC9zOF2+MS5X7HdA5w9nYwZAavyyNzP+qcGw2jucw+rJAJ2tEGIUYpkQblp1pBQZYeU4weakT7bYeEzmoGV67O5sFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410567; c=relaxed/simple;
	bh=xFiN6+TdamKPKo1XCbG5OGzCj40TPx1ysKsFcpDfGRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvZ/jYc0LKcN9k7Br5x2oB8G65W7YwDPuhJwyAPm7YZ0tKELdfXwmTJR48hVWK1ykcl3n4Hk5WxWmweWo6ZneaAvHlOQR9J+QzHWYUFLgEE6l3BSvWcNSwd7NPWYQB4aqJBsbAeCzWu9hASS+EhazxZr71CUEmyOhJjqbIhCHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZXYPWAG; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1832484a91.2
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 00:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783410565; x=1784015365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+brjFLVFjY/4CAFVXT8akEWDnOfxHjuH7xO2k8ZWc/w=;
        b=qZXYPWAGkcZOgpl0tP8cwWGy+HlLQqUwfZdhzTFmo3peCkCukAG8sTzlTF+mJx8BZ2
         NtiJMMqooK1meBkE0sFCKs8m7LN1vt4K1lI3O+YbjKRT4i3UzHzcuUdZSC93wzN3D4ED
         hD3IrrW8dQBNDn7PORt/l2QS4C+oosn20yHGRbittElpCn4Iz8a+JKo+FwmHIXmKBICb
         YP5WDLIp+anMX7SP8VPn29arlEG2BkJz/lBnwuiqmCGMVlVCo4/AVKdw5BOB4itNR6vn
         rQIw9We0vNuh0iZ8CBgaMTSHbBfpwRlfl2gNubvGk8Ek6xJwdZSUD/M4JvRPHmUa7MPB
         whaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410565; x=1784015365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+brjFLVFjY/4CAFVXT8akEWDnOfxHjuH7xO2k8ZWc/w=;
        b=DvfERtFULUNVt+4S9EaYjKkKDGqazczqoCcH/zZqISXXzBhABJwHQJ96gKk5dMMZBt
         CJ+x5+GkzuiWRmRTHrQ2bpBXX63zDXKnMB8bSw1DQ4sLc7KH3dAwyB2PmhGfSaD1gmFf
         UOGeET21NUoQYEgtF2bZHLqF6QUkq5eR49QTy85PsCMBm5u9EFIESpm0OJxI1qHsjzPr
         qg+NeE9RjwPROeGnu4zgs5P1tstH+osbCuAZ6KK9TNTEBt5sbLpBd9r5SoFEgIndPCZ4
         VKcGQir6v3cothO428nP6rFOj8ejZ5QnXK11QBDIW2nVJ2/UYovGbaVKHmrE+UVLB4KR
         1prw==
X-Forwarded-Encrypted: i=1; AHgh+Rp81RzsFPK2SidFqm01uyblS+9vB1EcLCErRlvayABJx5arG98NtO/XygVqwGL649JZL/l3Ya4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Uo8rBBPA4L7zTNBnk276Fib2NSfLT2m0UZxRpNKpjq/s7yzY
	e2lvu8/Frro745jGlymsutJ8qokL6pg13DxW28UvCCbIY7R3qxYF66v0
X-Gm-Gg: AfdE7ckRrwLd83B/bdcKB3WbG7mp0QWy7K2XwIRrC0ZBInefOye4YLlbw16wv4FCGsw
	NnpRTIqVgYSQXFb52xo0OuvFrYks2tG3bW5ZGicSGItOk3UnbkbRBO3QH9Urw4GrtdEGKFwvszq
	DOSiJTV3+WjriZB7fs/rj4iht5h8yoqdWORqnTWvXOFPiUaN+Zo/x/2yoBDBFycxH8B+4178yDG
	uBqUFiZmKVuKffd2aqEOgdINnvrq1DRqmuVCXAKaU9AZv1znKBJ/jaYz4z+tVQtnFpIMuEA9wvh
	VeErO+Z4WwJZRe9M/Hu5TGw4UpFRZEzzYkSA9UMHfm1R85G09RnlriHNVY44G/oy3srcwqGhRHI
	qkLDCxG4/QLqw2846gmuazZgxPJdRnbMIX+mTkhiso/ycnToojvalfcC9RUBdbhxIWnBIhgj/f9
	qXxVwQATr8DlDlLQ0Vdx/KI/wxmYaXbpwfIh955KuvUF44
X-Received: by 2002:a17:90b:2709:b0:380:9d0d:7af8 with SMTP id 98e67ed59e1d1-38758260ad3mr4159340a91.20.1783410565340;
        Tue, 07 Jul 2026 00:49:25 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d20a361asm626710a91.15.2026.07.07.00.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:49:25 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	stable@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Miles Chen <miles.chen@mediatek.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>
Subject: [PATCH v2 3/6] clk: mediatek: mt7622: fix memory leak on module removal
Date: Tue,  7 Jul 2026 16:48:32 +0900
Message-ID: <20260707074839.240676-4-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707074839.240676-1-akkun11.open@gmail.com>
References: <20260707074839.240676-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272371-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-clk@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:stable@vger.kernel.org,m:wenst@chromium.org,m:miles.chen@mediatek.com,m:akkun11.open@gmail.com,m:matthiasbgg@gmail.com,m:akkun11open@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[akkun11open@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,chromium.org,mediatek.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akkun11open@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C716F718E78

clk-mt7622-apmixedsys.c and clk-mt7622-infracfg.c do not call
platform_set_drvdata() during their driver probe callback,
but their remove callback calls platform_get_drvdata().
This results in platform_get_drvdata() returning NULL,
which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: c50e2ea6507b ("clk: mediatek: mt7622-apmixedsys: Add .remove() callback for module build")
Fixes: 838b86331c5e ("clk: mediatek: mt7622: Move infracfg to clk-mt7622-infracfg.c")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt7622-infracfg.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
index 8a29eaab0cfc..fae8abda14b3 100644
--- a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
@@ -109,6 +109,8 @@ static int clk_mt7622_apmixed_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_gates;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_gates:
diff --git a/drivers/clk/mediatek/clk-mt7622-infracfg.c b/drivers/clk/mediatek/clk-mt7622-infracfg.c
index cfdf3b07c3e0..cec19447d637 100644
--- a/drivers/clk/mediatek/clk-mt7622-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7622-infracfg.c
@@ -90,6 +90,8 @@ static int clk_mt7622_infracfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_cpumuxes;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_cpumuxes:
-- 
2.54.0


