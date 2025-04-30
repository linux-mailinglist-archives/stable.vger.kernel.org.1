Return-Path: <stable+bounces-139108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1B9AA4514
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE881C012A8
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0426C21420B;
	Wed, 30 Apr 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cfxx4QPW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49257FBA2
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001208; cv=none; b=bq2xAd09dDZausO0hdbQu0rUsnmpPTLugn0SA4m5za6p4b8ZsyRlHCMV+ZfiR41MqBCHdfXSKLc0k1ckpPQgCxiwafaSEOTb9xiNupg/B0Te5gKWtVGQXLb9Ru1EowiyFZB086CqUOWWs+we4zCfpCvzxXQWwhV65wUqFOvNJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001208; c=relaxed/simple;
	bh=i3Gq+/SqrmCX0ZVoqDXdxYr60vxrsJ6POwB+ju4Hd2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u31UIOTVZr4JOxtgEJJCrs62/3XB97ufC5A4I7Ly3KfgRUUnG9JQna/K0lZAJ2lFNyzujiyJtBZPnSwPMjHgSCjjSYVdbaD+kXhyofA1ahvrzBOSoU0Ul6hsL7z16HY5M6ReBqq2M6Rxl2/Wki1UImuUdg6L1od81w/QQr1/EoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cfxx4QPW; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4394a823036so68182135e9.0
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746001205; x=1746606005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFGJZEl3RBxcV7Qd2Cq9CklnNe5JXSuwAD+8zJW38RY=;
        b=cfxx4QPW03RiT8B48z3jbYowHQTyVoA76g3JxAQH0uymF8qvzMo3cud2VdacTLBFxK
         ItAsZMOl1iCcpm4GCe7UsAELhOgnY51YqA0tm8W55wddZczYnnyyoTrZgaxwVxsOH5re
         fQiZE9mw2pkkDnkFadRzHv4dfiF7+uB5chRB8nojviMjLcn9SAfHMzfoYzKUkj0nKTQr
         KQHdHYaTgd1IiqmwOWHrsiH/00KIusMBaj0uZ99ejct0Pp4XAlQSOxg6KQb+abNvwA5o
         s9xwNezKugb6CLDf9QteoKPB1cTRDdXazdCtfZeFS9iHSnLJ20E/0+FoIIAem8TNuWC5
         xSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001205; x=1746606005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFGJZEl3RBxcV7Qd2Cq9CklnNe5JXSuwAD+8zJW38RY=;
        b=gSDLGMLiBo9yn9kTvF6a/Ch8buzLeuv6YqajIDfAKmCzpon9rdTWpPx15e+1J6mu2O
         1T+E66AlKi0aKYnFxIXdVIibn07m7FGdypMMIyqUtAVnBPIVUJZsU+G5Xh4HRxgubumD
         HcGmlADQMYvV7DZNgWdJ4yQLELEmCXJApnXFHcOEsJOVFoZM4U5BO7+VnopG2ORU/RYm
         Qlf6BtuvkQEWtaBhYCzAdCeTENQWdCeRkjMpUOIhz/5nyUUltGzUFQ5WJ/+lEeCTvHd/
         b8+T+RqYebhUo70puRzRuWO+M+hPlY1wjZTdDJgXGwYwYce9Exzx4RTdnxTeDc4QmLRf
         qw8g==
X-Gm-Message-State: AOJu0YyJWttWeHXKD2r2fn4XtsLkTwhuo8z9Jm58H6j7o+Rh30xKxh3N
	OU0LctCKFI1Z9TTdqlptZmEtLEodxwIey9BfTU4xmy11LLokGy7ZUOJsgKj/NTFUd/9poJIgq8M
	RGOGs9Q==
X-Gm-Gg: ASbGncvx2CrMdV2wA1MKa5QDJ9mg62dl/+HstIt8ZcNzfMLxe8iXcV4O/Smcijpt1HR
	5fEkhx8317jwIrpHeWvUWbXgIetzclIh5Pornn+hJiie00kUNZOU7vFx5U+akcNKpXDhMhqEkyn
	R6GYrAlM8yyVMc5qOuYQ/f4+UA0AfJ9/DJWvOPKlrZRxU/H0waXp+zq4As5/lh5JIO5Vk7TNxjZ
	Zsx/qDkUIhdgYcKo3g24AW7jefcToJxjUQe01JoTqGLB6cpJ1MwSeUzwbdNNYKe9QVUQM2Pudta
	miRzKwXXfPEA8jYw6Xej4bL7iEY2SoIf6BvrP6xASGANPAKTWS6Asw==
X-Google-Smtp-Source: AGHT+IGA+tiSx+Nwl/hpq0tclfEPjzt4K2Po1WMlUdqwsSggmmxARzBB5eoxvMge7n+dYGx7pVY5Zg==
X-Received: by 2002:a05:6000:178c:b0:3a0:8c5a:6af3 with SMTP id ffacd0b85a97d-3a08f7a49fbmr2130404f8f.53.1746001204599;
        Wed, 30 Apr 2025 01:20:04 -0700 (PDT)
Received: from localhost ([2401:e180:8d24:65b3:be00:91e5:d591:161f])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22db4d77ab1sm115975875ad.23.2025.04.30.01.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:20:04 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 01/10] bpf: add find_containing_subprog() utility function
Date: Wed, 30 Apr 2025 16:19:43 +0800
Message-ID: <20250430081955.49927-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430081955.49927-1-shung-hsi.yu@suse.com>
References: <20250430081955.49927-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

commit 27e88bc4df1d80888fe1aaca786a7cc6e69587e2 upstream.

Add a utility function, looking for a subprogram containing a given
instruction index, rewrite find_subprog() to use this function.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241210041100.1898468-2-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d6a4102312fa..7322ac0c69ed 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2636,16 +2636,36 @@ static int cmp_subprogs(const void *a, const void *b)
 	       ((struct bpf_subprog_info *)b)->start;
 }
 
+/* Find subprogram that contains instruction at 'off' */
+static struct bpf_subprog_info *find_containing_subprog(struct bpf_verifier_env *env, int off)
+{
+	struct bpf_subprog_info *vals = env->subprog_info;
+	int l, r, m;
+
+	if (off >= env->prog->len || off < 0 || env->subprog_cnt == 0)
+		return NULL;
+
+	l = 0;
+	r = env->subprog_cnt - 1;
+	while (l < r) {
+		m = l + (r - l + 1) / 2;
+		if (vals[m].start <= off)
+			l = m;
+		else
+			r = m - 1;
+	}
+	return &vals[l];
+}
+
+/* Find subprogram that starts exactly at 'off' */
 static int find_subprog(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *p;
 
-	p = bsearch(&off, env->subprog_info, env->subprog_cnt,
-		    sizeof(env->subprog_info[0]), cmp_subprogs);
-	if (!p)
+	p = find_containing_subprog(env, off);
+	if (!p || p->start != off)
 		return -ENOENT;
 	return p - env->subprog_info;
-
 }
 
 static int add_subprog(struct bpf_verifier_env *env, int off)
-- 
2.49.0


