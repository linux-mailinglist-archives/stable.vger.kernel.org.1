Return-Path: <stable+bounces-245130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEb3MZqJAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D250982C
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB526307BAA9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC2F38E5D6;
	Mon, 11 May 2026 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy/MIBPI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2B138757A
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485031; cv=none; b=IfqNdDU4WWW56x8k6XpFtZruNLHWKUearJL15kXEgyiVoIjCn3pQG+Gq4PZ4tehUCDehIc3FTnSA872VXDAIfNsJFbEwo8bOwYHud6F564WwZ9usnRLJpcmf0VZS+vsCu8H3Cjoj8X5Dt4Jb2BhHP6LNaQ0Y9TpQaEh07++jgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485031; c=relaxed/simple;
	bh=8Wdfg2SJ3gRskIF0owADzPtFvL3MSIE8LIK6AUNp5IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsFsWp+DTVrxgxQpN5Tr98Lgd94OXhyVy3x4yX1qaH/lURlmIEPlRAkeqt4H+qB71AG/Hf3/sPfAPDX9c3fm6how1ZOiKfH6qY5drKPgvRnOyPCZTWqCDFBB6CV/23x0uk4SE1cSkT1a410PV2h+gZSRLcdwg1sbX8HdqZfIDsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iy/MIBPI; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ee7ffd738dso558474085a.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485025; x=1779089825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaEPK4/H/C1sXiusKGjDTH5/2nNAukTV1mTuI6SInxw=;
        b=iy/MIBPIlFTyPtop8PwAv5XWxdmGb+HZT+bz/hQFLpOcyDLht5caGc8Fd0jryAFKmm
         Sg30Qv7Cl0FhGDeBBEZlrTFm50rpSy3nHXPMLR6fKqcePLksbVWd6858Yb3yD/cB8hcf
         VcYHBH0h2Ik2JiGuY2mpXRIL79cPiznfnqTKddXIjJNzti0dCUcVF2Uzi6GrdgHkYJbg
         +047qx9IDjQvcecxqvZ1/e/bvslnU+8pFG+DU4UJwhLxX4vio7Swfz3mXERQWt+rs9qe
         T75pRcbnXTF/YOK5PuEGuudpycIq4qPFB1XWi03J8DFt09tgFlQSaq87foWcrzcUr30c
         PZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485025; x=1779089825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YaEPK4/H/C1sXiusKGjDTH5/2nNAukTV1mTuI6SInxw=;
        b=Pvm22T6vQXNis8JoS8VaXVmdCzjpypeUSj67y2hNc2WBytJVmdYho2+bQSMiLlSZHK
         5ta7Ws541H3lpkWYDrRgWnOimqHtdBp1QkSMBwzm5fZr/q3c6sD45SxtPRSVOXgZHE1L
         RG7PG/inuACKIBHcj7zCoTob4ckBbeJU0TJDTuN37lqjvsaYuxn/BBU/KdMsalm1ZM/Y
         sUP/lcJo3DANcUoiU5CgJzSw0IZZ1EWuUPzCrK7SgQjJRh0DeobXpjtoKGY0qDbZFHsp
         LQKdAHfDOspcbOFoIaJMDAu1/C2LYvhj/7BAAugl2AjoC0qFohDiHxnFpkJQHII3QpG3
         RTRA==
X-Forwarded-Encrypted: i=1; AFNElJ/Kxu/Yo99YbmNWf/N2hc7Nlgmbz/asxTHZsnGCTnXinsaT+xTfWDZ33UNIHuFdZa1baUbFplQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgpjDn2rq9J22R+uKJ2gAdo9S1XyvF8uFMzvEjEH5EfgmPu/7
	aeH3NRx8ommhO7uBGg3YR94JarVQCU31SK5fSa46AzSrEYsyAH9u1K2F
X-Gm-Gg: Acq92OHplj3OrI59+0XZFm6zbPYJs3EJUXJpIBW/hbQYQFFYbK+K4eecY81os4xgwyb
	O/eAyRmW6zpqr8Gx7gaTYsR0nAQno6aU+dufM6Fjv6IRwJRU5Tdcsj9OCzLTA09lFlEXGusw+eV
	V/8dz1Kuw7uRIwxMPYrbNkpMyKVW21fGi68NkrxlzVA63wcbG5m3lt31NEG0i7YefhUgsOjmJJF
	tzlVZ3LUm5ziCaNKs5bQkaXPJgVjSMn9FWqSRkp5k0v/Xdev2JHxpUVbPZBY62cvqjkjUOZ9YGs
	q/3ehBF+WREyKaG8zXN1l2T+W0FgZTPGrPdT/FUqhAUIpdfw++WQRXEvPlcJzjBtXQ6PvmjNnPO
	+oUA5ZPRHMM45wZGkpt0W8QN8isRg0cQbKKlVganEN3hBmffyXYJT84r7+gWhlcKBbSn/Q9Vf6j
	I1PNyEIdoged/ryB0kdZ0bN8VhQE/C31rr73wKE9a/zXTGq2FlPv+uJZpCPPJrlA==
X-Received: by 2002:a05:620a:3728:b0:8f9:9fe9:bc79 with SMTP id af79cd13be357-9064c9aab9dmr2399548985a.0.1778485025401;
        Mon, 11 May 2026 00:37:05 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:04 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 6.1.y v2 08/18] perf tools: Remove unused color_fwrite_lines
Date: Mon, 11 May 2026 12:40:41 +0530
Message-ID: <20260511071051.537859-9-yesshedi@gmail.com>
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
X-Rspamd-Queue-Id: 399D250982C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,google.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245130-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,treblig.org:email]
X-Rspamd-Action: no action

From: "Dr. David Alan Gilbert" <linux@treblig.org>

commit c7c1bb78f3eec716bc35f58d74592331cc3281b2 upstream

color_fwrite_lines() was added by 2009's commit
8fc0321f1ad0 ("perf_counter tools: Add color terminal output support")

but has never been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20241009003938.254936-1-linux@treblig.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/util/color.c | 28 ----------------------------
 tools/perf/util/color.h |  1 -
 2 files changed, 29 deletions(-)

diff --git a/tools/perf/util/color.c b/tools/perf/util/color.c
index bffbdd216a6a..e51f0a676a22 100644
--- a/tools/perf/util/color.c
+++ b/tools/perf/util/color.c
@@ -93,34 +93,6 @@ int color_fprintf(FILE *fp, const char *color, const char *fmt, ...)
 	return r;
 }
 
-/*
- * This function splits the buffer by newlines and colors the lines individually.
- *
- * Returns 0 on success.
- */
-int color_fwrite_lines(FILE *fp, const char *color,
-		size_t count, const char *buf)
-{
-	if (!*color)
-		return fwrite(buf, count, 1, fp) != 1;
-
-	while (count) {
-		char *p = memchr(buf, '\n', count);
-
-		if (p != buf && (fputs(color, fp) < 0 ||
-				fwrite(buf, p ? (size_t)(p - buf) : count, 1, fp) != 1 ||
-				fputs(PERF_COLOR_RESET, fp) < 0))
-			return -1;
-		if (!p)
-			return 0;
-		if (fputc('\n', fp) < 0)
-			return -1;
-		count -= p + 1 - buf;
-		buf = p + 1;
-	}
-	return 0;
-}
-
 const char *get_percent_color(double percent)
 {
 	const char *color = PERF_COLOR_NORMAL;
diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
index 01f7bed21c9b..aecf56dae73f 100644
--- a/tools/perf/util/color.h
+++ b/tools/perf/util/color.h
@@ -39,7 +39,6 @@ int color_vsnprintf(char *bf, size_t size, const char *color,
 int color_vfprintf(FILE *fp, const char *color, const char *fmt, va_list args);
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 int color_snprintf(char *bf, size_t size, const char *color, const char *fmt, ...);
-int color_fwrite_lines(FILE *fp, const char *color, size_t count, const char *buf);
 int value_color_snprintf(char *bf, size_t size, const char *fmt, double value);
 int percent_color_snprintf(char *bf, size_t size, const char *fmt, ...);
 int percent_color_len_snprintf(char *bf, size_t size, const char *fmt, ...);
-- 
2.54.0


