Return-Path: <stable+bounces-245133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHGRIp6JAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23534509833
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EBA2303814A
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2470738E5EF;
	Mon, 11 May 2026 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG+ZbzTa"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9E387587
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485033; cv=none; b=sW1PY25VEaXq4Qaa1pbTgmyzS4N20FrwXi7HvYwzMMbCwu+v+J6KQb47bINcJnqIt20sfJXDWqS9zKUH0xnG7FIewCFD2dpTAYDodNnXVS5X02ckvxQU8lXQcvyrecnzmggH/DlBNf/qxF3bRuj0js5HBNVwy9OivERO028gi5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485033; c=relaxed/simple;
	bh=CrlbVACB03pa2/p70N+8/Ayg06dg4BXAWZ0mW/yj8OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBGlCg3c57E7sG0alWqlcCKpyG2RgACYm+HdHhceiv71y0diwbql4x8x7XqstJXA46aOXjmtBV6OqBAGAGM0YYt6mi0iKnSly0Cw2TSGtGtbDDOgpcWH5rlbpQnkhU2G8mxRW2gPoVmYpQQ6BNXbVUNCvMkkIy2ZJFMQJaKTwA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG+ZbzTa; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-900fa9f178dso434697285a.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485028; x=1779089828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZGNoAGPxGiT5iCISFIxqwNLQ4fkZ8RW2fScJ0ZjwWo=;
        b=DG+ZbzTaIxJK6yRrmBLpNQ9nwRQIyFXClvaxU8KGQEaqUd6l+zu3jE0/SfDZN97Txy
         mI8ELhi/jUPm0HJEoZgpjYRIkIc/3TSHpS88CLmgeXB2MG7Bd2KgBA67xwADyO+RyX99
         h5Feu5KGUKN1oS6orMq25bSHCFD9hZKzI/CmH0q8+JwbuF3bexEZW1wt6291fbdkUnif
         ao0xWYaJJ/FkTCIwRLoTIauKfWicXGq++eqRLwnU2qwI2LhZaYoFDtXzeHZjX4dL66ie
         H22DYPG4Kj6fp2tMyVn4fKouJ0SAFIBIHCAVZy1ySHNjT+MSOIFVpzUaliIulTAJuPYT
         tF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485028; x=1779089828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FZGNoAGPxGiT5iCISFIxqwNLQ4fkZ8RW2fScJ0ZjwWo=;
        b=W7ud4DIojAXDRPlrDyL2/4JWfZ3vqT4+t/jl4geUpJLqyZjFDG39+nYgAoB1nY2sMV
         iR9lnVGdC/33UXSBOx9cA21Ov5YfBqn5AZVYmMq3Zyf6NziCepvPTmsBNLr55FXmC/K4
         RNT8+1xXq6kQWUrq2qvogpleUaDTxasYhjb7pkTUmMZe3tBw07yt6wMpM7oCNBl0DXAe
         TkGzQapk2hJ54NZoZqtTBfh0cuYISJqaA2viO73CCBXbPVzJPcCofXljsImdYssIU0m4
         RPi8M1sdW1X0O2P7NFw3+/0c2mgsfWW0wBiXAHSRNikhUJdPd0P1PC8k8C2s4PbnQo7x
         c9Cg==
X-Forwarded-Encrypted: i=1; AFNElJ+XoxkJ9Ci2KLx/vRjVTjnL+f+Bp2QTAD+UMAumV/Pk1b5oX0oLXkg/WKEwH5bUDLf5Hl31GQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Q9kiUcThSE1UTsaKJfs3pgOkfjf9+Ls0W5HXCPvVDIWXCDs3
	VQhaN/H2pQmSNSLIFmEZnKDCUzk3II05Jy1J5BMu6NzoBKt1JzqP13l4
X-Gm-Gg: Acq92OH4P9wTJhlZgxtCN3CFUMafcRcvUduXn71wptdUr9K7BAGOdILZXTFIADcHkk/
	R2f6UXvUHeJaf63rjzYRETngDx57uO76B3oMe/prD7piZO1/o5KsFnt2P/fjECpj8UctNemvW5R
	N3nZTU4pvXaj7MMG+dGXOk9Dov1sIm8Qj7TMkO0jfsZ4602QChB0i+/FL2AQ6KvV+eVB30MUrY9
	Mj2+EFBjSrpYndu9HtvfFcPRqyq2V8YRZW3HaEnCY4XB+qYJtAslGv5lFsis1SGVWvHGt7bGrHr
	iYjd3Qkm8Zs3xK8N9z/CLU1mHBsWoMVYjMpB9K+GgZzSM8LazKGzG9zq8Unnt2clLwVL8geMeUg
	/yhew6ft6GYbIQIWLJonHLroG5Txt+Jiw4OTJRUikO2I/r2HC5ALdLoXMsBxrFLHlAzaTB6dML1
	MMad6QOeCWyO+YicQoSj+5+3Tt2IZ1F6D01In8Ohcd5No8OvZXbTN0fnPrWFOLWweCLv1kB+5X
X-Received: by 2002:a05:620a:698a:b0:8f0:5793:ea80 with SMTP id af79cd13be357-9090e9cf700mr1253374985a.16.1778485027918;
        Mon, 11 May 2026 00:37:07 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:07 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.1.y v2 10/18] perf metricgroup: Constify variables storing the result of strchr() on const tables
Date: Mon, 11 May 2026 12:40:43 +0530
Message-ID: <20260511071051.537859-11-yesshedi@gmail.com>
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
X-Rspamd-Queue-Id: 23534509833
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245133-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit b42868624c7d00206f77d19a6fbfea73a44ff6f2 upstream

As newer glibcs will propagate the const attribute of the searched table
to its return.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/util/metricgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4c98ac29ee13..664045fa0c8e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -644,11 +644,10 @@ static const char *code_characters = ",-=@";
 
 static int encode_metric_id(struct strbuf *sb, const char *x)
 {
-	char *c;
 	int ret = 0;
 
 	for (; *x; x++) {
-		c = strchr(code_characters, *x);
+		const char *c = strchr(code_characters, *x);
 		if (c) {
 			ret = strbuf_addch(sb, '!');
 			if (ret)
-- 
2.54.0


