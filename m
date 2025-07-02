Return-Path: <stable+bounces-159176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2A9AF0725
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 02:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDE27B14B8
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 00:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191F4163;
	Wed,  2 Jul 2025 00:02:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD66211F
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414538; cv=none; b=QzWfMVQTDFhjr3SXlnGf9J27//FisuX6juZcbwUrV5aXBwgMfFgY1yF0fbmtLIZ4eYCW8L7/wPFxMn82pyrC4QAtBGXoop1xAVl2+/e1O2jqKENlJRxNx3YU4LGQC0pQYZtLILMLW/j+LhD2tABSbkSoYJEnXGIl1DPegX6c8Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414538; c=relaxed/simple;
	bh=TdFnIAcA1suC96kVYTTmsLVEjAUoIm4IaOiFk02Cllk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiTbAVViB1ZDW/UhlJ1HrxT1kXl0PlGgkmENFAYzuOS8L8UUb5x/TKgV0kmjavybsy9J8knaYCM/EmBNlwf6Imb+ELJ1oGq9/dBSIAnO/u1x8XbM/RVxlCJsh89yPKiZ+XvYfwTELh41SPLasEyhCACuEMm/2vLqZWOBC3GOkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-a3-686477016087
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/4] samples/damon: fix damon sample wsse for start failure
Date: Wed,  2 Jul 2025 09:02:02 +0900
Message-ID: <20250702000205.1921-3-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250702000205.1921-1-honggyu.kim@sk.com>
References: <20250702000205.1921-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsXC9ZZnoS5jeUqGwYYf0hZz1q9hs3jy/zer
	xb01/1ktDn99w2SxYOMjRgdWj02rOtk8Nn2axO5xYsZvFo8Xm2cyenzeJBfAGsVlk5Kak1mW
	WqRvl8CVMe18VsECjorte+4yNjDeZ+ti5OCQEDCReDM5r4uRE8ycv3UBC4jNJqAmceXlJCaQ
	EhEBK4lpO2K7GLk4mAXmMEp8e7eLGSQuLOAnMfdeOEg5i4CqxLZlnWwgNq+AmcT9PdPYIEZq
	Sjze/pMdxOYUMJf42LwaLC4EVDPv8Dt2iHpBiZMzn4CtZRaQl2jeOpsZZJeEwAw2iT1zWqAG
	SUocXHGDZQIj/ywkPbOQ9CxgZFrFKJSZV5abmJljopdRmZdZoZecn7uJERiUy2r/RO9g/HQh
	+BCjAAejEg/viSvJGUKsiWXFlbmHGCU4mJVEePlkgUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
	jb6VpwgJpCeWpGanphakFsFkmTg4pRoYHff8SM6cfieSb7WoasgULvfdT18J7PgWJmDtNyfg
	xrwJPxmYrhV0/fpVavzlscjz16Vzbvw+vTtpUfCRipUnYjqf9U49+eW79Ax9nfJ/lx69sPea
	0pd6fk6TRNPvW0ZhghNev54nkrqePfxQnlSwx6Ff0/XForbkOMsq+yl0VZrxftz480nucSWW
	4oxEQy3mouJEAF0t+BFGAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsXCNUNLT5exPCXDYMVXUYs569ewWTz5/5vV
	4vOz18wWh+eeZLW4t+Y/q8Xhr2+YLBZsfMTowO6xaVUnm8emT5PYPU7M+M3i8WLzTEaPb7c9
	PBa/+MDk8XmTXAB7FJdNSmpOZllqkb5dAlfGtPNZBQs4KrbvucvYwHifrYuRk0NCwERi/tYF
	LCA2m4CaxJWXk5i6GDk4RASsJKbtiO1i5OJgFpjDKPHt3S5mkLiwgJ/E3HvhIOUsAqoS25Z1
	go3hFTCTuL9nGtRITYnH23+yg9icAuYSH5tXg8WFgGrmHX7HDlEvKHFy5hOwtcwC8hLNW2cz
	T2DkmYUkNQtJagEj0ypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAsFtW+2fiDsYvl90PMQpw
	MCrx8B44m5whxJpYVlyZe4hRgoNZSYSXTxYoxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcrPDVB
	SCA9sSQ1OzW1ILUIJsvEwSnVwJjJZ2L7vbjhsvL8Rz/mOQf90pD0WSfvvlBO/tgKcYvHh3q8
	prg83RD1f7f0Iq7H76+4/52YVtudtChB12J9Ja/h5otaHDttpcrFHtTtuCmhVFa/L/q+elzq
	PAeOtcLr+Lcv2f123vW1NY763m37jmh06Dhavk6+vMtIg+9EvMT9jDW2kxl3ciuxFGckGmox
	FxUnAgAGfouzNwIAAA==
X-CFilter-Loop: Reflected

The damon_sample_wsse_start() can fail so we must reset the "enable"
parameter to "false" again for proper rollback.

In such cases, setting Y to "enable" then N triggers the similar crash
with wsse because damon sample start failed but the "enable" stays as Y.

Fixes: b757c6cfc696 ("samples/damon/wsse: start and stop DAMON as the user requests")
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org
---
 samples/damon/wsse.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 11be25803274..e20238a249e7 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -102,8 +102,12 @@ static int damon_sample_wsse_enable_store(
 	if (enable == enabled)
 		return 0;
 
-	if (enable)
-		return damon_sample_wsse_start();
+	if (enable) {
+		err = damon_sample_wsse_start();
+		if (err)
+			enable = false;
+		return err;
+	}
 	damon_sample_wsse_stop();
 	return 0;
 }
-- 
2.34.1


