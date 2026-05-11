Return-Path: <stable+bounces-245132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HVCNZ+JAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C47950983A
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E39B307EDB5
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310D938E5FF;
	Mon, 11 May 2026 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0x29dmQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E115388E5A
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485033; cv=none; b=iEQKAMMRRVbjHd0yMcqNilTiif08xv4Pp73kUYNh+lD6UhWWD3hN4GuJqz73vNh4hNEYdPvhgyVrNYZQhgzyt1RDB9GbUtE5tabZdhYx2Q7faumDJJOfQFEXWpeTkjtXcmJyHcsXYqOtmX046PUKkUbfr/WcFU7Q7INyZ8QqUKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485033; c=relaxed/simple;
	bh=qcNrEv/jfg+I4I6M1t6P7XqDAKksc+Pc1fYgtkeUV+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajhT3Y+TE/tD04bwYaIQGAOsiMLQSj0caK3e42RZQoC2qiuedoQcf+mKQdR4a5Bthaagjfst6qDULE30Ig2Omz6L0fDxVc3RHi9yOftOdDrDdrSgWrWy5wFT6d/Q6g7Ci0blAKIK0XRyW72Y9xrrtOeJOc2bgcMfkuDf14ikTq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0x29dmQ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ec37d52c0dso587036685a.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485029; x=1779089829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHSiekuCEar9z7zxxVyxGWaT4bdPpjxiJbsbUEHSK3g=;
        b=R0x29dmQe9LtRf55tTXu19dlP9Pyuy918PR4w3mK1buJzADFhl9ABGauAKb1Xzrq41
         kGC2pWyR6j4u9mJ8hDoecqxhWFpMOpsPdn8vCkrrYQgj/lJPlAOAEghi5J/giJxNAWsQ
         kBCGMA4amuEt/CYBGC5EVuiabSQK86je4B76w1iRlp9+DV0wglFR4/99PbtLIdwzP2+V
         rI4zXusQslF6WXFU9NMTQEZhZxmN3zpcQXiPkt+/Z6c2hvJZoXq/hEYLXsLVrGPp2M8P
         2Aj6S55wfQfCnqjgavFtf2hk4lfpeqju0enpTHrUSJmZHRpyAt+F7sl+wREvD33lVABn
         9cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485029; x=1779089829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHSiekuCEar9z7zxxVyxGWaT4bdPpjxiJbsbUEHSK3g=;
        b=FZGKlr13n9n2HFYZDn629OhCZTThqTd4hejxIQpMY3O0BMwN3HYHpto81Uf1/DSODI
         bknKPTCJ3tRFukAXQGGsI0xuLEB5XHQIvmbjMcnunQkLVAomiU5b5krlaFyRl+jciTSn
         x5GPX/lsUTXqOLsIRQ++8M9Ra1bVKeoYMztLnmd+gOwBeFutUXr8Qe75E4j1esEYn9Dw
         w3otnvtcOyS3Gz1DG8aMkoC8k0srGa3137afan5UH4uPmLRSMdphiVBGz6EbF9Ui6iKL
         pZD5++MEylYz3JS/rY8VRlRDMVycBeuEHoXvOFiQ3yeh4vc4Ux934jWm/26q3AEbfhQs
         6YfA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ps60eMG04Xrx2eVI72o0oAHd/icD/iMNEnjSLh//yB/mbvo2FiA2gZqHFifLlRbjkNaWMCdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8l3aM7YI3neYfUMoKma5p1lsVexkpHHri38RBrevkZ5U6cvWW
	xSlrTt4n9Q2maj7DkhFSDie1KfowuBJrTSsubtxA6LZzbxL/RWpwlOHN
X-Gm-Gg: Acq92OGbZPTDnjMfGVRIqmh9HJNQ1Q2ZlWwfKB9U8ES53HpeNly5Q2YsJlsAS31QKBL
	yvzBJ8GlD/1lqtonr6xDaQaBVJv4vSUfarey5M4xMd9tOSXNi5NS6xJgDhhoElPOGVUO9T/un62
	fnEeKOYVuSflCL++8Xzcp2xE1s5G74LwJbnWowItw1TjV3nJOjYawOIjPVRzOolqlEZIIVKPjg7
	6vHhXvsFysofYpgJcbFqiDH8Om11wniKd48aCtkIFU7aGAMxbgSCUPeQ42LG7yB1eelExevBddy
	nJP2qs4+fHK4UDUwp552URnzoqlJk1XhKD0TeycTcNnjirSIlZMbS3DX5PjJZmHs0uReTdjh1Ca
	x1JPTrgxVrrAo2D6e1KcpGgJMdi4TvmZzcueHeoEL+9hxBiUCy6bTrvtZFUdajNJuERZY7XcsPL
	0DlDsykk/hByzS/Scmm79KJL4NFweplJgWTWI6tDUg+4cfsOxufEd77AyK0yPmkg==
X-Received: by 2002:a05:620a:3195:b0:8cf:ffee:c616 with SMTP id af79cd13be357-904d43911fcmr3474565185a.7.1778485029172;
        Mon, 11 May 2026 00:37:09 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:08 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.1.y v2 11/18] perf session: Don't write to memory pointed to a const pointer
Date: Mon, 11 May 2026 12:40:44 +0530
Message-ID: <20260511071051.537859-12-yesshedi@gmail.com>
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
X-Rspamd-Queue-Id: 7C47950983A
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245132-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit f1321cce848c558fde4c0c6bcd5e53f3cefd3af2 upstream

Since it is freshly allocated just attribute it to a non-const pointer
and then change it via that pointer.

That way we avoid const-correctness warnings in recent glibc versions.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/util/session.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1c4d124b1053..9d11cf2aab0c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2641,7 +2641,7 @@ bool perf_session__has_traces(struct perf_session *session, const char *msg)
 
 int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name, u64 addr)
 {
-	char *bracket;
+	char *bracket, *name;
 	struct ref_reloc_sym *ref;
 	struct kmap *kmap;
 
@@ -2649,13 +2649,13 @@ int map__set_kallsyms_ref_reloc_sym(struct map *map, const char *symbol_name, u6
 	if (ref == NULL)
 		return -ENOMEM;
 
-	ref->name = strdup(symbol_name);
+	ref->name = name = strdup(symbol_name);
 	if (ref->name == NULL) {
 		free(ref);
 		return -ENOMEM;
 	}
 
-	bracket = strchr(ref->name, ']');
+	bracket = strchr(name, ']');
 	if (bracket)
 		*bracket = '\0';
 
-- 
2.54.0


