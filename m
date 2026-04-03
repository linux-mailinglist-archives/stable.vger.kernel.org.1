Return-Path: <stable+bounces-233144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAnXAoxQz2mjvAYAu9opvQ
	(envelope-from <stable+bounces-233144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 07:30:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 647BB39117A
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 07:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE2D4302883C
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 05:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BDD34D3B0;
	Fri,  3 Apr 2026 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHeyPn9J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C8345CDD
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 05:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194162; cv=none; b=S9caDBcSDG+28nfVvaonfHL1ubM0LMVHuUGqV5mfRqLOuQaAqpgO6HFYrOcXj4z119DeNEek4KsykSA6/GaJ6B6LQFA/qGS3P5YtR0X1QSjFGgzegExhd0F6LW4nGqJGTGjklPn9OEDf6RQDseWA6LWJSHwcBdCbN+2cSz1I4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194162; c=relaxed/simple;
	bh=nnz7rfBh4E/7qdvu4h6qKKfTn2Jhn2jRQqSVmtYrHV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZqboNRvjtbJON4euVIU70sEEgZW3NKJC3f5LZ9Qdxn8nKYMjoW6LEbJRR/YSBw039kVB62qrGjx+vD0WU1USMsINKrH+TzEphgeIdJzvTt8TxTiuIBRQQfpxS+OpsHuz7n1pYKEexAYW9d3lBP7pyTm5++268Fe1kRNVByj1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHeyPn9J; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82cd70febc7so1229649b3a.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775194161; x=1775798961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DhGk7ekX3JpECpQ0RXFDeILDJMOxG359GUgFUbcyx0=;
        b=HHeyPn9JtX84knO1PHKCVv3/oDK4QYXPR9c/eZx4AOtgYGEQeZXDQrGS2L8wjQOP80
         NCNqzIBAIR6T7Yeao5h3+3AY/PfoYRJRoF7t2K+9x6z4NVb7Oo7GxbKY91HicG+Bwt+b
         UcBVKWmNvkKbXWEOdZ3pEdJUOyZbpz7PKUcVr9a7WPtxSP7uVci+y2QoKhWvLp9Lm7G4
         sw+qIK1YF22Bp2y1WnvEojt81qY9xjcU2iXiSqbdY4o9GA7KWj6wFjUsKVnoO+cHRsin
         H3R+8mxNauKo8Nlmlroa3YBwXvJTqGM8dDT2b/uVSCPShGWdmPoPKk4+gAkjvOaBwXIk
         WVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775194161; x=1775798961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7DhGk7ekX3JpECpQ0RXFDeILDJMOxG359GUgFUbcyx0=;
        b=ZEeS2NevShq75Wr/EW0yeA7/tKvxk1KJ849UHNk+12JwlJwsP6Xy3vCZpo+QNdXXSu
         wCreBmFQdRuF7RuL43beky1djqUJRokBRs1aFFX9V7uozptxd7vwm9Rl0atXj7Hor1BN
         u2DRiXmOmqlmXqUPHoqBoEoNmpFHoctHeUeqAa9zuswyWcCGwTBt1vsDbSUa0doNMwcn
         NVASpop6/pM6ofV8UWq+hW+OIBXEK8Xesy/a89m1GohzBhKjrajEEcL24WMwb7PpXDoJ
         gLG7SZo+uhyjY27v9/bCsIT+l7gLV9wa09kYEqYTxqD0EIVwx7MesD4svgl8O9ags3PX
         JwqA==
X-Forwarded-Encrypted: i=1; AJvYcCVjkvQikNEWYMmTJ0a0nRSLhx0/E57cKslcDGUZCKQR4LwEW79B5RaqvRlTGZuj5GYslF71pQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQHYDih07lojvPxFSswbedDv/qI/VFQX4uCU+WGgm6Ti6/nY3
	oc6rbgCBgYD3LsR+BQDiZ7Dwit8yDPT20atvHH4+ucF0c5z9L9QsY/Zf
X-Gm-Gg: ATEYQzzmdlAPA+eqQBbc5AtQUY0hH0xlzhyIig2GLecBzjYrljR1+TcTzbYY3vSOrv+
	lHQfAPfMKElJbk9PaNs1W6K7wZql0g5ZAc7i/L5d/hcxwS+8XvEZ0KU23tQ1uCJD8MlIWbWEset
	/0rQXlBEO9koqeK2VEmHP6NAmLdnkZ5Ci7g0WNHK3+Ayc43qQBK5n3lKCKkp1MLYR2wLO3zghrf
	eWeYa8nwxqHcx5u5kA5h8kdinyJhA96nmEf6OkenT6l765NzIGyOXTNUKMENaIwn4VhAJC37+gD
	GW31KAbhJIS9yQS+MO4XwoFArK1SlS6l3XdorDtCooYZv7U+U1UOXdtdg0XGiO9+DiVKPgT5sVX
	peVJREItaYxBhyyNuH/lyEhXnYu2V4dpM4BmaqdDImmtVq4NdSxNDzAEPUC6gRTNZa8E/5lUfc8
	CbYMS32q57/KWEUvEAGGyOQ0/3uf21hkceJFghfQ==
X-Received: by 2002:a05:6a00:6ca8:b0:82c:28e8:a009 with SMTP id d2e1a72fcca58-82d0dbc7a68mr1847464b3a.51.1775194161239;
        Thu, 02 Apr 2026 22:29:21 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d11cd2ce2sm782120b3a.6.2026.04.02.22.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 22:29:20 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: yanquanmin1@huawei.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] mm/damon/reclaim: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 13:23:50 +0800
Message-ID: <20260403052837.58063-3-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403052837.58063-1-aethernet65535@gmail.com>
References: <20260403052837.58063-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[huawei.com,lists.linux.dev,kvack.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-233144-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aethernet65535@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 647BB39117A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The damon_commit_ctx() checks if 'min_region_sz' is a power-of-2.
However, if an invalid input is provided via the DAMON_RECLAIM interface,
the validation failure occurs too late, causing kdamond to terminate
unexpectedly.

To reproduce:
1. Enable DAMON_RECLAIM.
2. Set an invalid 'addr_unit' (e.g., addr_unit=3) so that
   'min_region_sz = DAMON_MIN_REGION_SZ / addr_unit' becomes
   non-power-of-2.
3. Commit parameters, and observe kdamond termination.

This patch adds an early check in damon_reclaim_apply_parameters() to
validate 'min_region_sz' and return -EINVAL immediately if it is not a
power-of-2, preventing unexpected kdamond termination.

Fixes: 7db551fcfb2a ("mm/damon/reclaim: support addr_unit for DAMON_RECLAIM")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/reclaim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..2747eef5919d 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -204,6 +204,11 @@ static int damon_reclaim_apply_parameters(void)
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
+	if (!is_power_of_2(param_ctx->min_region_sz)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
 		goto out;
-- 
2.53.0


