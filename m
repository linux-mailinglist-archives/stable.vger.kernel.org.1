Return-Path: <stable+bounces-245139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 91VkGEiHAWqwcgEAu9opvQ
	(envelope-from <stable+bounces-245139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 336925095AB
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 635163009889
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D561538E5D4;
	Mon, 11 May 2026 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPzbROWn"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18CB38D69B
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485041; cv=none; b=Rg/9qko1e7fPUJ6Ae127l03LIlqw2gCWU11tsU8OKvrGSH3I8uH811pU6/PhEp76T8kijuuMArZGXbd2bj88ahp/rw+IN/CD/IkQOwMgCWbnJpe4hK3Bw7bLSp3ow2TW5XAbeUaKQn6Cm0EXVHlim0OVgmCB1V0nFREazUqAr8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485041; c=relaxed/simple;
	bh=rFvob0lZEWWi6W7VpCeTyotZHtGOBXWNNml/fhjMy4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EA8nayUoTzxSuxQQockFPTBZdJbJ4ALnSgw+0hfNSFEjdYfRK52umqIGRyinYu6Z5r/aJrxjHN6zDoAMsXgMouwwyBKZWhepZIBsAzqIHJp/MAvTuig+NOJDpb9nNvrKxRGaglgeg+0BVZtGoGh0nK5TzFD+A8GMsX92eogSOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPzbROWn; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d7e7f48499so431570185a.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485036; x=1779089836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alwAbGeZSGCQ92iatiaKS4cED/f+zuJthBZG0ltDdc0=;
        b=WPzbROWnn4/czkvKMcOf8DKffhlzred+L4u7g4OE6bxZaSsr2S2q03vvfISPCtPAO1
         aE2rqqCLa/RnwWrf4xINY7KYbCxA3RnZJZfn82HD42XpgYVyhLGbDPfGINGYLImFGAzu
         //cTKTm8XAuBLzEcb9n/Y4jlq/1ro+R6KcOUEe0PPIZMQZMDPODYCwSXL+0LJfNYgMWS
         Mu0J7D7WrjOCeU2q9cX1gc6mS4gcD9uwxc8teYU/aLVzVXBa0SiwEgBCN6HW3ksNfHGB
         Qwhg5lD12bE1drn0Jz0iL5p9k+wEvzCGof+fqiPjZXTRIOqDoSFUjORKaSCIeOvDs+u6
         jpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485036; x=1779089836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=alwAbGeZSGCQ92iatiaKS4cED/f+zuJthBZG0ltDdc0=;
        b=P/qlyDZrd0nzbOlc3Q4vV7J7U6frJVXg/Ve2MSB9CGC0V6xDLeNvbLoSHmkoKacUTr
         63NxXkdIDPptLcXCiBDdIYKFz92o3vX8mNLQ8k1nJHHOreFv5mRAzNZv9AJsU+HX3Ss5
         8dj0GZFxT9s1Q+rP30l3nD6dMIQohHzfd1COVPc0VJV7fgiqnh8yCpAI18tpXLq4XT/5
         Jdl5tsQaf3k8Yrit9Ou1hZ4GyZFwStbs46Q+KxWr5lZ4V54HwapEV3DueR7JxIr6VLYB
         qwS7nzaONik7UaADwm1Xvfkk7mbzKEE4e9g+xzW5ZWlEjXKNxyJCWTi0s+iqG1lTlWY2
         5xxA==
X-Forwarded-Encrypted: i=1; AFNElJ9I22j6kbm6wLiN9ksqZ09ItlYs6Nnr/JmEmubVCkOcRttlvbseQGQYaB/Vwi0WHcxzV6OIykM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4NyAK4qG+gpuPjFrcY0tYhIk9ZyLkuSSvNQa2mKPuAy8+Ggz
	gTkBud4EdLTw0cMteZCskJvim9mdsikeEc+wSeFQGimQU9DuagC4Qs7K
X-Gm-Gg: Acq92OF/JyWpBKNWzfGsTBiwwL0qKC7sBRmGW1QnUYH326aS/KZCrMW+OPRzEAZBm+J
	YlCW/1/Mp1dSzftaF0Ccv0meqmLCYiHVNDTjSJBuAN4fw1ZPKJlerEsngJQMZHagJuG/5hu9bn3
	GlkXO4jBYu1vzSYjcoW5pbjFap7gl2Xql4i9U6OwEukczZWTTfe1Qi4j9WnANPqmZ5lObu/nmN0
	N4QhL9UQd3mGLGXSmDcxCwjzAMVd9hH74dy1Pr4ZyFSEjD89AX0FRgtGPS7Tv7BKpI5VTwXkByS
	ohZ9SKTqYxLWF46HjRGOUY7RDvy803da9eb82oqy1m7ki+vcHZMTveQiYvr4qeO3Cbus4L8U+T8
	FdcZMr3MyFvZpjFZduAMm3K8BUkGK/QWCK3GftcXjauzbuHmFbWpEE1M5pLOybKEMF7Y08I3h3n
	lrK8Fk32MYcAQMT0qKG91fhIJ2eHY12zKmU1JkP3SaQhpYYe5ktEQKRIKONOcQ2g==
X-Received: by 2002:a05:620a:1986:b0:8cf:d804:4569 with SMTP id af79cd13be357-904d4b5c92emr3458336685a.23.1778485036304;
        Mon, 11 May 2026 00:37:16 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:16 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y v2 17/18] perf parse-events:: Fix -Wdiscarded-qualifiers under C23
Date: Mon, 11 May 2026 12:40:50 +0530
Message-ID: <20260511071051.537859-18-yesshedi@gmail.com>
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
X-Rspamd-Queue-Id: 336925095AB
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
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-245139-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.983];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

glibc >= 2.42 defaults to -std=gnu23, which promotes
    -Wdiscarded-qualifiers to an error.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5973f46c2375..e3b7950331bc 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1647,7 +1647,7 @@ int parse_events__modifier_group(struct list_head *list,
  */
 static bool is_same_uncore_block(const char *pmu_name_a, const char *pmu_name_b)
 {
-	char *end_a, *end_b;
+	const char *end_a, *end_b;
 
 	end_a = strrchr(pmu_name_a, '_');
 	end_b = strrchr(pmu_name_b, '_');
-- 
2.54.0


