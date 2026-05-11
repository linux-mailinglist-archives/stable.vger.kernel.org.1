Return-Path: <stable+bounces-245135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB59ITeHAWpOcQEAu9opvQ
	(envelope-from <stable+bounces-245135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BA750957B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CC2530071EF
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A875E38F623;
	Mon, 11 May 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFwmzqzv"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000E38C2DE
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485036; cv=none; b=db2/gB3Gigls2sLiOzBct+XwYc4EzblMqSZiZOIRiOmBkRL35HPAUQJDf0T3psNzUQsO9ZqIsJ9aQZiE5DealsmEUrkIOzO2w69DeF48KO3swVFzbXCVeMsurwPIvxbXyWl0KA6ncheOxv8PV2dbVkFhTCOfSjKEbkQB+NEyvkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485036; c=relaxed/simple;
	bh=u9xhe0koa7KhCHtvw0MUtz/kRUTd1jgNyOnU3iefErw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5X9D20j/PqqqIrsMMWVeiChmRMxSgPumSkELahv22vr6M/DLJkos2OzZ8X+Z6XzaCurNqE3gTGUfGdxnMoUtvnFp71a3jkBkLVtWTSpYddJXBVABJfZANTSXCVenwv4V/XbwxtoRdB7p8Xou7oCqyfp7tEamFthNWeNubHtCRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFwmzqzv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8dbbc6c16b2so521536985a.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485031; x=1779089831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9Hi68L7NCK8aAt9g2ldNuQwE/fJGovlNSF7XTaK7uo=;
        b=RFwmzqzvrKeqNFFbBCZCiG5tUE17KjJ8j0vFGD6vn7mmzkWJr2avPQvwYmgtzF12c9
         bBcvyc8+dayvZYtBmvSJqOrGSIVPahuc5YRK/0PDKyPT6nfqLrX3easrgwfoCNsNqX5X
         hyihQESTJrtXb/rqeWOMN9ibZ1NygkYoJkV3iP/jTTbVnHfAoMBHYmPZeJ6Nz69IAM07
         V1f1odmSE8ZRyQLEaBxzbcpwo4NSdDIr0+s0usb8vEGrOjmvi8nAHYhAMagONAV7XFop
         50YzPuI+qCDF1Tg3hICg27uS5mugk8xCQGdmXt2MwQVuYLby4qvOa83/PIYOjXzhJuAT
         lPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485031; x=1779089831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C9Hi68L7NCK8aAt9g2ldNuQwE/fJGovlNSF7XTaK7uo=;
        b=csA+npe4JQKbfiAuF4KMVwz0t9PKQLPbW+RqGF8SY4BlCn9FEjab1UekNnUHDFsh3V
         3qYo0yKlc6bd4Qw4uYrBJe+e9QiZZKGJ4mZoDuX6gj9Yh5JwpUgErVWoNLcZV1HtSzhA
         KUl0w1sz8AIhZ2e4xxrdxM+EKndp2KSTynJ6TekOUsK9wtNB9ZB5eyhQNLC/cTWHb4Hn
         Lo459buMNQ+flmLNujrbkcx59he9rb3mYrZ8zIeaV5zTCnWgT2uJej50R7EWvcwJonlo
         pNTEY3rhfeYHgZf+c3Vi4f3p7PsG1Z1lDvU/axKDPR96JI4IPNunsZxzcCi5BhdpynBP
         6HJg==
X-Forwarded-Encrypted: i=1; AFNElJ9/xto9kA9PDKqU+nNArEvz3IeytyuQjcx8Td6lKsub5Pb57s35JkoOPe7BIepPLr0DzGUUMXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzloQ6CxrF8gWaJ8g5zzGxGrHJrvkgtwJRngvmIVze6TaO0IjDA
	h+splwpRlVa6k+hKaID8dxJo6NB/s7tLq8X/jITAX7df0nEEc20g/Yb4
X-Gm-Gg: Acq92OGbSQKBQf0WbWz8KSZGT7fdeRlaoMzIASFs5s8ouNyJ2w3UWOZp2el6mCW97Z/
	v8Bf13fcd7jIN8ZA5Eqv9aAJtPCZ+S/3jevaUlTPTY7EDW1G5EnQZ2kdBZJNKP8tyHgLv0oDrNy
	0YChe7Q2H8FxKt0qVc45Q/QrRSV4YY38zX9ILN9jWletPkNKfgoCGNkJHBPgy5zpNrI4C80NlVd
	vBO4l2oLPpTxDtu7y2LTVU/4xaTDqn346QBBv9TdqRT2KSN5G78CGN9i7dm/s1KTgLF/wB14htv
	r6D9XYmXRAKKJdqc/x3fQlHqlEJwHI4tHYMx+SVj13IY6BdCcEHYiqW9MwkREnBSHYUPs5ESi/A
	EWfIQ6+01MMQIQ1NLZfBpr5Ymry9Hg7ev9Hji7oVLh2hWSqWCeVQMd3Ewnchph/qxeitkR4mg6c
	iJnJ4JyviBMre/npzx8FUygcST+4EqQH49dK63isWs9j7D4ZgUtyBoN0zNDdq0qw==
X-Received: by 2002:a05:620a:254a:b0:8f8:7765:27d7 with SMTP id af79cd13be357-90653249185mr2194771985a.21.1778485031581;
        Mon, 11 May 2026 00:37:11 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:11 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.1.y v2 13/18] perf units: Constify variables storing the result of strchr() on const tables
Date: Mon, 11 May 2026 12:40:46 +0530
Message-ID: <20260511071051.537859-14-yesshedi@gmail.com>
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
X-Rspamd-Queue-Id: 65BA750957B
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
	TAGGED_FROM(0.00)[bounces-245135-lists,stable=lfdr.de];
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

commit 0e14cb3b24f8f301cf6490a4493afc98321ed5bb upstream

As newer glibcs will propagate the const attribute of the searched table
to its return.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/util/units.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
index 4c6a86e1cb54..0bbacf5a29aa 100644
--- a/tools/perf/util/units.c
+++ b/tools/perf/util/units.c
@@ -12,7 +12,7 @@ unsigned long parse_tag_value(const char *str, struct parse_tag *tags)
 	struct parse_tag *i = tags;
 
 	while (i->tag) {
-		char *s = strchr(str, i->tag);
+		const char *s = strchr(str, i->tag);
 
 		if (s) {
 			unsigned long int value;
-- 
2.54.0


