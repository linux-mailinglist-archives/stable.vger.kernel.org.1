Return-Path: <stable+bounces-245137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO7oDEKHAWpscgEAu9opvQ
	(envelope-from <stable+bounces-245137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CD9509597
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9930A30074AB
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60D538F658;
	Mon, 11 May 2026 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3ZeHKEW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F9388E5A
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485039; cv=none; b=eRF5m215HcKfjd3/FP2MS9GUN3/REpdPtgpBHR9/opKFhZfeIitDqOvZwubQ5SX/kxLA0FjFBMMpaDG5PLcndCz8TkvhOXt7SnL5G3PB3qsGWvKSmaILWalYHm7HAb4Sex8D/0SLp8MY/vv2/giTZ1WQ/zqn8EHr83MlXu/h5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485039; c=relaxed/simple;
	bh=LhiJRtzOkHcZmjhOK/MMOPZlZ7IAFi3HvAQqtzgpkiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N14txmAhjeYRTV+ZMtIrn2tCZ1JRBKVr4lr2Q+wYOqApo9F4S9HE09bALN1ip5xhjKDPWp4Z8C+WYBJyfCv9WRTcEm5LAXMElRBnZZFBtbtV963YeTZD7bWivsA/pzZzAR3Pg9cF1q+BBs9r7onbbpegXG7ajdjHZSPuZimieYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3ZeHKEW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ec9f099fc6so450476785a.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485034; x=1779089834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0Fc2nsc2zJNmZlEdODGlaABqI4wuUC6NjCqszmnvkc=;
        b=m3ZeHKEWryPIUnPOOoyAx5Aem2LnrM5tCz/QuqAnIyKotqPoELxg+uU43axHstzMGv
         OeJh7/9pFJYu2loDe8v0TKYP3splRGH+D/o7jXhsPd5loND7LmUwv+vPVrWfcrLfRH6/
         A8ZuUh+/F2rYw4S6fjyqUZl7UFQ3tSKqG80V3DHMRELWAXFl+OtB6UMTGZbI+e8mYWxq
         1d8C8ymxwVUfASLfxMm1YZOJJI8zURRVls8s4XU3Sp9D8yKLhAR9bOQ1AsEe+mUTsQCE
         I7e/7d4RKyIxXDks/aRNip/H2DccNeZVtq6KBV67sIW0jE2H2HXfuFA+97p0weCH7Ahg
         E0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485034; x=1779089834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t0Fc2nsc2zJNmZlEdODGlaABqI4wuUC6NjCqszmnvkc=;
        b=f5aicw6OrkDYwBO8Kz+sXBzE9BbUpyjCdbsbIwRixntg2uJbpKkmSQBi7dry3asJVJ
         KF9FztCJIfE5y/B1W2yv2GYEJFUpmqM0API6N1+A/yChyBGcEqW2gmgKzdDGmTFbBMQl
         Y9W/lLyesKvWw4qu+U0GvygDjI/YAttYdjzRPFDAoGB5w7eaqg66WboN4CBZigMeJRxV
         sOvN+Rp9I9IacptM6/U/9ljEuF88OKJDf+p9AzOojK1xiAFcnC8hXp/xO9EiREC5Ix1J
         nBsNK/3LEuWQmEUg6mpqWoMwrH7vmyTbQH0CyFh8H/s7M2RDDedswd2l6rmI8giQGMd8
         VDag==
X-Forwarded-Encrypted: i=1; AFNElJ/BY6FlPNvm7PqPxQrUhh026kfbzXRf00gPTUhzRnQ5xm65l6ixBpJYt0XG2WNqnG/ERUsR0bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/OkHTsuiMsOlaSpxufoaoixHGNm0Uy+bodAMGs6H19AUFb82
	qZZpqPOuRkflEnSb7xnqMh++tyceRWCsUuBKbEpSnXZwTBIPFkQLfwdUeebl1bZD
X-Gm-Gg: Acq92OF9uwazyToZFzXwGYGUvZRj6n6hcYLjo7TcgZFHbKfOij4IeUhOOCQiWFo4FGm
	ffMPKWyoZKhAH5sVCifG6rjO7PnY6dvAY5lgI1IsuXd+Odq+27bvQK068qVKskYJi756vC3/o4S
	mMPxp0w72WiHOK+X7fzqJXLaU1nJ8Xq0aJfBrASsRaVzHVTGIgq9MusMYBFj/QGk6Fv82eONJ6x
	wwmxDCAqDypLK9plrcWl0GXkNxzp4qhat2jp4ur6tT1FPjG1SV7HvdFFYQf6nI0EYyFohFZ9VnK
	7CWUq4RzX2A0tguC3EUuJomvyd6Qa6RJi0PGllTplIe7k5yKfj/eFWC/d1Zip1X4TIjiA3BiUl9
	cI7oLcxP3b+Skf9JotVIY2sl8F/NoXI87wpSbbBFxftp8k7az8mzhgADOYLnA6oJygpR3/GHqsA
	s1Tyob/jjC4IcKX/1oVr0F583n7iAIMVesghLKe8kRT8NkXs+EC+3SBZP6Pn/rLQ==
X-Received: by 2002:a05:620a:1a19:b0:8e4:ebbb:b162 with SMTP id af79cd13be357-904d3eac012mr3144783085a.9.1778485033971;
        Mon, 11 May 2026 00:37:13 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:13 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.1.y v2 15/18] perf time-utils: Constify variables storing the result of strchr() on const tables
Date: Mon, 11 May 2026 12:40:48 +0530
Message-ID: <20260511071051.537859-16-yesshedi@gmail.com>
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
X-Rspamd-Queue-Id: F0CD9509597
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245137-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 21c0bc9144834e39762dd6fddbb255ebb80cf079 upstream

As newer glibcs will propagate the const attribute of the searched table
to its return.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/util/time-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 1b91ccd4d523..d43c4577d7eb 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -325,7 +325,7 @@ static int percent_comma_split(struct perf_time_interval *ptime_buf, int num,
 }
 
 static int one_percent_convert(struct perf_time_interval *ptime_buf,
-			       const char *ostr, u64 start, u64 end, char *c)
+			       const char *ostr, u64 start, u64 end, const char *c)
 {
 	char *str;
 	int len = strlen(ostr), ret;
@@ -358,7 +358,7 @@ static int one_percent_convert(struct perf_time_interval *ptime_buf,
 int perf_time__percent_parse_str(struct perf_time_interval *ptime_buf, int num,
 				 const char *ostr, u64 start, u64 end)
 {
-	char *c;
+	const char *c;
 
 	/*
 	 * ostr example:
-- 
2.54.0


