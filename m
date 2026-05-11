Return-Path: <stable+bounces-245124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDQCDCCHAWpOcQEAu9opvQ
	(envelope-from <stable+bounces-245124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C596050954E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BF463004DCA
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C9538C2D8;
	Mon, 11 May 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYVPpcUA"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729733859E9
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485019; cv=none; b=I7LYr8eG1naffb19wlmDixhhVRpEh0PmbAPJghkpSy5AEo2X/M7qXWWsR2F/CSPnhuvRLeFm3tcg/GBvLXQFh5iPu85OVY47fgnnmqDrJWIOxJCAHS0LpxaFDEKlguoHFnJyQJkP7yeMPC6rBZDEfN1rW4JT8BXBpMj7C3fQEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485019; c=relaxed/simple;
	bh=xy2xQtFBhBe20zXsyaDDMgkkf5Ehk5fiICI0JvFKS4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuIY4qoX5Er1JL5tTh7q61u/u+FrBDZ182iahp8jQ61nRXM80yLVnEv4bKVq+8kVMG5eb1C2Xvsn9hR/SIGuorz5sM+v5Dbwq2Rt5kD58/2Q+6cUhB+NygVYgNeMZDdV2JMDUO5sZjNF0TSDrJWMxBDKIMSaEEnmpJ9SRf8FPks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYVPpcUA; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-902deb2412fso432004085a.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485015; x=1779089815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzmsdzRWzePXCMV/JpASG0u6Okws5AuRCWceX1TYKyc=;
        b=bYVPpcUAZ/ArQJvLZpU/cyYyd1Jv1EOKM9DIkWsk0ZVcgcNhiwEGwtYe95am+yS/oP
         ES7VDrPUV3Ou8zQ9tigqg/ch0b2AxrBOWXnp9qzQY2QV6ikiGUyoiQl6DHB4MyLtafcj
         p/MiJj4TIuxyt2AqFB+Ps8Xl9F/eNQdhl6xn8QyLEmJNrF5O5fmtaExOd4mDJY0chMPb
         w2PsYshQa7hIofwZrRpss9gnC9yKf5Xo2HqEMadLfafSIlv/cud9laCY2s8nOvjZKo0G
         Vijl1vhPWORHbL6+B7VLbZPEzRLC7cF1Uu7wJZ4EemvbVe9aOkEinAO9YZpErZJNMnab
         u7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485015; x=1779089815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tzmsdzRWzePXCMV/JpASG0u6Okws5AuRCWceX1TYKyc=;
        b=YRz3gIaOOGRc8i3CixzRiagkRii1Du+/Gz7+h4pEpHJqQ7OvIe7MOm/aQdsj7JTky9
         VgUx1tp893g5UlB0GWuHXdzdKYdUkZHNk3ohpBEbUFtcKqtyXC6WGo+GH7SzBOxYJql+
         XvuzRnDLfaRoPbj5cL3bB0qq8AfWi0cSHn0p+EnHbKuyu9S96SgD7NafTygKLuM4cn4o
         1q5oAqDEZecX+3vIMjT+G3EgsjjjrGfe93DrS+oFZqcg8GCtHA+bLycAiD8UiEDDex0p
         sW68CCsZ8Qy8KzBB3KvnCmT1v4tFrIgiDXsuVzMockVu9FPtoPbbSVJBgUKK6+tO1ztt
         gt7g==
X-Forwarded-Encrypted: i=1; AFNElJ9uR9URZEotfXf73o153IL/Ha4xVS/PCenMJ8nGLAGgLOiDZETiu//AhpufDbPsQjv4uOs3jzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHf9pD63kvHsBXZ9l1cnmvVEWaQPyDQD5fn5hOMnHxn8UGpVYN
	BFIncvOKgbEGh1YupsuKI5nZQtzlImGGhmjiflYE5qUiFQdO3SK5LOKA
X-Gm-Gg: Acq92OE4UMmQASGTVc6CxNzAO3aTj9/JzcaKtVEyO8W4YP4h8lVQkWKvcgX7UmVXZl7
	INBYa25/StED47ZzrJeClsfthejA1De76iWeFYe+StdSec0nn/7QKpU+YDj9GRZPGMB65gFEBFG
	H6zVo+55FA/5x7u6xEac27AfpsvysM9OAHtV+F+vQ0GiKhPLW1tWBqn2GPOtUfUVCiwb7VYPSqg
	thGyx71KjfwKRjhLYRCuyFYELd8oFjHzL22lGefE+4bAaLv02TYzGUuq7OfTG1166MPNNYLr/kJ
	m/VVAbgWNx61plT+QMAqC3sGJcc56brFWYueHlaid1O2D9hkU08Pukd7yed9YrxEQGPtmLSJwHG
	qRL2bN3jcK7hBqsig+CiDGmxTG8GMcPyj1d7GvhuPe9M6h9Tok6zZhaf/scgjhM7R8wTTjxhSNH
	Ml1PI5S6A4n6fzwhwtU/7PM+HYbbnU974WXr+280OAOiNfWn/apICQrWJ0h38+G1a/dta3IJiU
X-Received: by 2002:a05:620a:172c:b0:8cb:3a1d:79f5 with SMTP id af79cd13be357-9090edbd837mr1230569885a.26.1778485015056;
        Mon, 11 May 2026 00:36:55 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:36:54 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.1.y v2 02/18] perf diff: Constify strchr() return variables
Date: Mon, 11 May 2026 12:40:35 +0530
Message-ID: <20260511071051.537859-3-yesshedi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511071051.537859-1-yesshedi@gmail.com>
References: <20260511071051.537859-1-yesshedi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C596050954E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,google.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245124-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.923];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Arnaldo Carvalho de Melo <acme@kernel.org>

commit f6f41aef53761517391b6192fe5b4bc30b2d717a upstream

Newer glibc versions return const char for strchr() when the 's' arg is
const, change the return variable to const to match that.

Also we don't need to turn that ',' into a '\0', as strtol() will stop
in the first invalid char. No need to touch read only memory.

First noticed with fedora 44.

Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20251211221756.96294-3-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/builtin-diff.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index ed07cc6cca56..9a05d67f541b 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -177,10 +177,9 @@ static struct header_column {
 	}
 };
 
-static int setup_compute_opt_wdiff(char *opt)
+static int setup_compute_opt_wdiff(const char *opt)
 {
-	char *w1_str = opt;
-	char *w2_str;
+	const char *w1_str = opt, *w2_str;
 
 	int ret = -EINVAL;
 
@@ -191,8 +190,7 @@ static int setup_compute_opt_wdiff(char *opt)
 	if (!w2_str)
 		goto out;
 
-	*w2_str++ = 0x0;
-	if (!*w2_str)
+	if (!*++w2_str)
 		goto out;
 
 	compute_wdiff_w1 = strtol(w1_str, NULL, 10);
@@ -213,7 +211,7 @@ static int setup_compute_opt_wdiff(char *opt)
 	return ret;
 }
 
-static int setup_compute_opt(char *opt)
+static int setup_compute_opt(const char *opt)
 {
 	if (compute == COMPUTE_WEIGHTED_DIFF)
 		return setup_compute_opt_wdiff(opt);
@@ -233,7 +231,7 @@ static int setup_compute(const struct option *opt, const char *str,
 	char *cstr = (char *) str;
 	char buf[50];
 	unsigned i;
-	char *option;
+	const char *option;
 
 	if (!str) {
 		*cp = COMPUTE_DELTA;
-- 
2.54.0


