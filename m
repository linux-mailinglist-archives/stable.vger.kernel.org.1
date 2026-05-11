Return-Path: <stable+bounces-245134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBkpOlSKAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:50:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF2E509911
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71D38303F095
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7FE38E5D7;
	Mon, 11 May 2026 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiaZ55VB"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1103538E129
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485034; cv=none; b=pKoRDKA4i3P6DgM+Nv4WEk/kljBCJQz064vsT9s9S/WA/PVkThIXB1nZ7aWv6SNd2H5tg/JAdOxkxseiT1peCVnN9VwKfLz3E0U36LIZ1N/aqu3J+P4ebIbU+8iC3+FZeRw6UsGXlFI2bbd58xHDIz3lH3Ysff1s0dGlHolieMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485034; c=relaxed/simple;
	bh=qk1nNRF7YRkwNtfIV79J4/gBqQUFwyn2hgSqnr1n7Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUMCT4KkW8zULUr7HwnJBS31AZeLX83tPfhe4/GQZv/yiTTZg8YBe+IWw1diPv4TlSAVCcFJxfc+N5uIcesv9KMbfua6VbWfsHQDZRpyOf+BUMwSqTROyq3NyzPjYoR0hL99CksYlXD1z2bFqTzkeEE0oAaSqQcx/2BKOOpGxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiaZ55VB; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8dbbc6c16b2so521535185a.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485030; x=1779089830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/8KvM77sRYnPHW3yZuy4s0vRAkwh3OhvrBXXxoufco=;
        b=JiaZ55VB9O7mR/q3zmnEHn8rt4OQ5ugHskhBPuFUB5J1SwO18X1IOPFGXu9ELAlslL
         f1MnTHJOUObsuwQise08st7vPQ8BmiRoypRNhff5uM5VIKvfKni/jnSfA3AFzrekjm4h
         h1Ti1ifkMUXRS688kwCURwE/f7WV1s8CEXvaDFMKLwG1fQXzdWRbFiM3aXx0801IHUji
         cH3CDkEQsGAFWy4kNk+n13qMdgmU8PJkEir4e0K8I+C6gzQqW1iFmSsFpr1pFOlKI4tZ
         QBeyM4dpZ9s2CnLcS9o+vXGxHsRmBsInXk8e4ZnrcInM89nQx3q5tnFYPz/HNazoRQx0
         wSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485030; x=1779089830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d/8KvM77sRYnPHW3yZuy4s0vRAkwh3OhvrBXXxoufco=;
        b=B85hLoAziuvlvmgGfFQrMgk7qWpFK71jPJOVUdrAikT1MwAXPvl5bQYTd1jgLbOvpW
         VNjx1B90suQp+xaGNg/mGXZI4oVWkthpquYoEdvK7pnYOXFiRjjnCBkgsnwEkN/Jwln3
         UzWhNuPrszgQ0xUG8KFe8mQAiiwQsQbp6+Zowo1mkMtilAzd4guWi9A3oZL6G4fFo/Zt
         bIpasCHpIvDUAZrzjHGbgl9e+79XnjjfdlPkozAgsmuCbzFZUDgFZay0pkdmVzF0bKN5
         xH1yRpxoHSiAJDMWwcRTOf6Ww0ZRO+R285uVDkLCIgTKEdB+1tH+z/Yfaih8PlaCctuS
         7jjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Q8k+3BP36G/dPnFxWkX+IGs9n5YIsj0keW//X4APvH3U26/01zuT+uUtQsX9dsXpfGRkBTF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYJZRzHqjSAH7HWliR1wT4Wq3xVLhGA8eWgVgiXLZOiqyNfM1P
	vc3x3NOcyN/G3MV1TYq3wNnYGu61AvZfhlT2EN7+Bi/SX+dFCadGoEO6
X-Gm-Gg: Acq92OFUkW8B2YmLuVK9jI9SaURIAm60Yjdm/mCAAIWz8ylAaONWRALNzHFHDBZdR72
	oxXz+9GRwD1o9/pXak0MXMKIKR1zkQp8LVepni2R+aEvIQjv9PCQvPUBygGgVtyk/YyDI+kBsOG
	HBqmQvEBe7o+QP9e5/CqOfcOSIP9ZvguCvEqtlOwN/sHV0bfJNdYQafrbUBWJHhIlLG6kPGRSh+
	Y2o31W1snbP80GEIGbEOaT21AaAnL2u+LFvE1Qq5V6OfqhkuxRo8RyZF6XmxB9zaLoxm/3gHOAO
	Kiv27vg9PkQLR/aRnzcstDpxL9s57bt9r4JCOpeUDsiltoNZoM9TCi/vLf0FrYlEvRPBeRzvKbL
	pznIofvs/wvJcz9mrcuATgsQLwrKHhPAqeA3of047gCTNXyICNSzYhF4430A/b49XzFrKv3Kllc
	l8exlSMRmjuLdBIDBKkymEq8Z37ftEvtn4dYKrCmvhABjZfp42S57GDJrXc8QtcA==
X-Received: by 2002:a05:620a:3199:b0:8ef:2118:aec5 with SMTP id af79cd13be357-9065209af62mr2330144685a.20.1778485030372;
        Mon, 11 May 2026 00:37:10 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:10 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.1.y v2 12/18] perf trace-event: Constify variables storing the result of strchr() on const tables
Date: Mon, 11 May 2026 12:40:45 +0530
Message-ID: <20260511071051.537859-13-yesshedi@gmail.com>
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
X-Rspamd-Queue-Id: 1AF2E509911
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245134-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 97b81df7225830c4db3c17ed1235d2f3eb613d3d uptream

As newer glibcs will propagate the const attribute of the searched table
to its return.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/util/trace-event-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 892c323b4ac9..5a6dec2dc0d8 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -477,7 +477,7 @@ static struct tracepoint_path *tracepoint_id_to_path(u64 config)
 static struct tracepoint_path *tracepoint_name_to_path(const char *name)
 {
 	struct tracepoint_path *path = zalloc(sizeof(*path));
-	char *str = strchr(name, ':');
+	const char *str = strchr(name, ':');
 
 	if (path == NULL || str == NULL) {
 		free(path);
-- 
2.54.0


