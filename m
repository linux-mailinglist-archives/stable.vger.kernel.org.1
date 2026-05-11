Return-Path: <stable+bounces-245138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBooG0GHAWpOcQEAu9opvQ
	(envelope-from <stable+bounces-245138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 577AC50958F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5F0530089A7
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC8C38E12D;
	Mon, 11 May 2026 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p74clJlz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E800A38F240
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485039; cv=none; b=QVgbfzOYUleuiOiJgtW0ACXd0UZU+PmhXZ3i4gpDuqNludBC2H0cinb+u8OadJj6xrFoa43YXR/SdIfBKGlPvXC+8IFMsVcHJYAdzJZG13u0XyJYMfI+RUkyUMq82k+dVt2LR6qel9VcsUQ659FOqY57REt4KPOGqYxJnXND3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485039; c=relaxed/simple;
	bh=mOXcEC1/lVkVHZYZn2XHTPMu1CGJw9SeFHzyaOzmbtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbzQHGrous8I7yy2sOt/CvBa8CBPuE/+H226DsNd56JLZlmGI3UVy9H0uBk0QAhXZDl5bv77taM8z0dWBjgwHUrvIM8p62bZxi3PgOcUFDLO3Jil2mkk87Yjgw422zbKYfTXBoKGanjVrv0HLPgR7Qg3hj0nYc78DuMG5h0taJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p74clJlz; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8d6d5e45c43so438246185a.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485035; x=1779089835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q729bgQHVeDW2L1+l2aARSKoamCj2E0AC8tSERmxT8=;
        b=p74clJlzaVAS9TKAZ0q8QKYC6hJd4NVFjJ/U9buXHY2P6xuqpnV7RXL8Y6dJSlAt+8
         MRQ/riRtZw0Sf8DzmqQB30Il6jLgNw6tmeSnwRmp7dnBhSHnFbuCMYMuL6Fy3wthg+jo
         kVMkwLzwDHXbyG8SDG4fF/w7EWF6JqClX/EQQxiYh9mrOyJgcyf3JGWtcqK7+FQ5ENRs
         Lhscovc29KD8s66v/5ottw3iFw0p0vja0mxGYFIKJiR1AawoOOZz5Hn6USd83mdHQuLr
         36CVnLJdFT8vDv2w3QWSVClVdvlHTXpW/IrNpWhda7y/aaFRsrtKrCG+HHKCXd4Y5NaD
         7Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485035; x=1779089835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9q729bgQHVeDW2L1+l2aARSKoamCj2E0AC8tSERmxT8=;
        b=PxTEffcxHKwlx7VUNZFND7oPh5BqAXKVYWud7UyI8PbjychCQ1CtX2JjUYLEMBByXU
         UxIQLMJB8wK//293Le9csDumy4EiABFUyueNy0m/yq139GjgHE4xgeFW5BaAgIQ8S+wi
         N+DT1/oH2AzRNKWt4XhRYzzHGv0+pVGM/TxE1esafzjVPPPj/+EB0UaUaWk+JqAo5W8s
         qZeotKJnJeYIsHdW69QdbrB+V//h/oDW29eYO6+x0ui8B8SqK/YBYhvJTEqoodrPYXtV
         VPFrFy+Hly0pMJ1JO5irnax2Z8b0rcd5X/Jpn60SAZi08U7cwgrDlQR4Jtld09VbB4Js
         ThMg==
X-Forwarded-Encrypted: i=1; AFNElJ8XPLeKocoD7Ltx2pcUWdgHSuhmd9xqW476qS/VdXDsgPei05tDHEcZHmfusm+BFwA6Nwcr3aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HgrUkDk2Kb0UVBevhuk/hncDn+9unwHttQYT6PZLelc5h/tM
	VOvAAxJ5IbyiqZXX9BRFbt/3ve9ClL/IisDoyC9QuYWc4f3w6XUuxIce
X-Gm-Gg: Acq92OHLocji0eWhR3A/pHdwI2heyrMBEJPNkIoU/MGJlXmTa5klfbo+VxDTFFmCvhJ
	9hFLZtVppDUKyNzAlEsYvzVk4pwYdtIqNCC63KCU78gDKcbiTG+nBGx6FXwhH5iv9G7e8tK9WJD
	1C1boL+P/B/h+D/W5r0N/jyQhsCQ103c6p/quo0bGFc+2aFXlUTIoznNOxqDCSDPVObqslbsPEL
	UUOh3FGyGfseFdUmxvjil+IREeZedlAKCexK9JkFG+h5Opcv5YV2tUD++2uUQgJ7+qLQs3b364K
	SFO3tcLe7oNWt3f8wkFs89x36l3kCI2bQW4BEaEzuf0M7vj/gF7eTxuMzyvj1HlhpMc9UsCBHM9
	Z4ms8bEpdxcRvJgssBSOigX1rwiIpJHEUWbcaeA5SXN4f5HKFz47H6MpzH96lzGDd3iu4ajZrdp
	NF+28mu9HScz1MXr4XXPch7TxPTR+t2GHIRjJqM+NdyDrRdc2W7gZlmkNt1brzCJtd5k5Zfv2o
X-Received: by 2002:a05:620a:1a11:b0:905:ea85:a03a with SMTP id af79cd13be357-907bb6d754cmr1844761585a.47.1778485035155;
        Mon, 11 May 2026 00:37:15 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:14 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.1.y v2 16/18] perf demangle-java: Constify variables storing the result of strchr() on const tables
Date: Mon, 11 May 2026 12:40:49 +0530
Message-ID: <20260511071051.537859-17-yesshedi@gmail.com>
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
X-Rspamd-Queue-Id: 577AC50958F
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
	TAGGED_FROM(0.00)[bounces-245138-lists,stable=lfdr.de];
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

commit 79bba3a1834e7ba6c437674582cc9f3ae6fb638c upstream

As newer glibcs will propagate the const attribute of the searched table
to its return.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/util/demangle-java.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/demangle-java.c b/tools/perf/util/demangle-java.c
index ddf33d58bcd3..c3cb327ed562 100644
--- a/tools/perf/util/demangle-java.c
+++ b/tools/perf/util/demangle-java.c
@@ -158,7 +158,7 @@ char *
 java_demangle_sym(const char *str, int flags)
 {
 	char *buf, *ptr;
-	char *p;
+	const char *p;
 	size_t len, l1 = 0;
 
 	if (!str)
-- 
2.54.0


