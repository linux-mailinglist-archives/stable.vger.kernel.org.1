Return-Path: <stable+bounces-136711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30467A9CB8C
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 16:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB391897EB0
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A62A2580E2;
	Fri, 25 Apr 2025 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Zc5jrruo"
X-Original-To: stable@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D73253359;
	Fri, 25 Apr 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590848; cv=none; b=IrxlBUATU453nVAuhGYwlCwgv5uqSgBRJz1WaAKTCj89IAGqow/9NBodQC6471XLbur6sNbNrrwo+XU4Kv6T4/ra0ws0Oa/MENKP5H0+R/nsOn2pubf/942z0liftlUrhb7fq1lVDKUZATJ93zpks6r/u6Db4EYTeGC23rwVUp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590848; c=relaxed/simple;
	bh=nte/7jD+id4r/HeLtmR3ukvXJuQJb5RQxxDUEdUwtnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ti/jxV/XdcBWSokQuZPACNbP9Y5tjPebO1JRUBfqRcs4b5oKP+iT9QJJzFk8SymkqBXFDyUon66CrflVqNHn8AZIdeO97+aG+1U+abtbAQlGAKyIlGQdsGBiQVdaYleRTSjNy6Zx0hyR41HIrGYeU/JaLNIRWy+Q0UOjOisnTWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Zc5jrruo; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	In-Reply-To:References; bh=kG13SlQdnT8nlh5dFxNowE8a08w9bRf6AHfcz+vZRG8=; b=Zc
	5jrruozYX1Qw5zISLlSfT5mty4Yh1IA1sn1z7hPozgi6JjSyZPy+OeH7yvUQN7LuG6ehOhBahVRJo
	jPfNhLGvmE6sDRCPOQIvf9qB20Cg7v9PWorupY+pz1Nvj7iQN/NbckfZyTs6l4yt6+NjPk243L/AG
	Y0DqikU4N0oAfoJ2ZPe+r1Q7Wr5EKww2IUvVAIrXZ0Vbiv6ZyoUs0WF7fWdMO//43q4HHpFYifpqA
	8xOHsQ0Ip8BHBi71xY6yiAUsPHSVta56rLsDRz8rAUuO3Bu8z4qPLOgRxuzXbp6g9dCdq8AcExfmS
	ZydAa8b5ZBVvJdkJj90WO86X4UBEfstQ==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1u8JO6-008Ly1-Ti; Fri, 25 Apr 2025 13:46:42 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: stable@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	1103277@bugs.debian.org,
	Hideki Yamane <henrich@debian.org>
Subject: [PATCH 6.1.y] of: module: add buffer overflow check in of_modalias()
Date: Fri, 25 Apr 2025 15:46:21 +0200
Message-ID: <20250425134622.3376068-2-ukleinek@debian.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270; i=ukleinek@debian.org; h=from:subject; bh=5WCH7uaVSNDyCD+BOpba2H25xjDI5axg4+EAguDqtK0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoC5IuI5d34hTbe9M1zzRMZRQOTpRitCVxHllII E9HZHWSuVGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaAuSLgAKCRCPgPtYfRL+ TuizB/43TCpFNC9D5bh7IivbZABGPWD65F/BsrE73teNsCsRNn5UdMchhHS92NsCISgypvPLB6n InYyan2U3cRJElAGNQL8lP7hps2lwFFto12BsGfXrEjrc2HhhaF0OlcjL1JVNgy05eLFs7ZXYEQ CIOAPaAcH11huhbP0xn3F1NZ+BUh0o1/tdwxsv3nKCBhMmDmLAYC+vemFPWlRzgl2v6EvFPmQfA 6zT0bYQ/d7l2fHT1/PbVK+2RVIlMmxqtGohCShPUYorKJOTFfFW+BXPNPqy+NJGkAXtleVWxKBC IRmR56HDt/6wlcIdReN2JCBv2symA8iQsxsV05jVrre1B8fk
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit cf7385cb26ac4f0ee6c7385960525ad534323252 ]

In of_modalias(), if the buffer happens to be too small even for the 1st
snprintf() call, the len parameter will become negative and str parameter
(if not NULL initially) will point beyond the buffer's end. Add the buffer
overflow check after the 1st snprintf() call and fix such check after the
strlen() call (accounting for the terminating NUL char).

Fixes: bc575064d688 ("of/device: use of_property_for_each_string to parse compatible strings")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/bbfc6be0-c687-62b6-d015-5141b93f313e@omp.ru
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
Hello,

commit cf7385cb26ac4f0ee6c7385960525ad534323252 was already backported to
stable/linux-6.6.y as commit 0b0d5701a8bf02f8fee037e81aacf6746558bfd6.
In 6.1 the function to fix is in a different file and differently named
since v6.1 lacks commits 5c3d15e127eb ("of: Update
of_device_get_modalias()") and bd7a7ed774af ("of: Move of_modalias() to
module.c")

This is the respective backport to 6.1. Looking into that commit was
triggered by https://bugs.debian.org/1103277 and my backport is
identical to this bug's reporter's. Thanks for considering it for the
next 6.1.y update.

Best regards
Uwe

 drivers/of/device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index ce225d2590b5..91d92bfe5735 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -264,14 +264,15 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
 	csize = snprintf(str, len, "of:N%pOFn%c%s", dev->of_node, 'T',
 			 of_node_get_device_type(dev->of_node));
 	tsize = csize;
+	if (csize >= len)
+		csize = len > 0 ? len - 1 : 0;
 	len -= csize;
-	if (str)
-		str += csize;
+	str += csize;
 
 	of_property_for_each_string(dev->of_node, "compatible", p, compat) {
 		csize = strlen(compat) + 1;
 		tsize += csize;
-		if (csize > len)
+		if (csize >= len)
 			continue;
 
 		csize = snprintf(str, len, "C%s", compat);

base-commit: 535ec20c50273d81b2cc7985fed2108dee0e65d7
-- 
2.47.2


