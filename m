Return-Path: <stable+bounces-245127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFA3BCWHAWpOcQEAu9opvQ
	(envelope-from <stable+bounces-245127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DB850955D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15C6C3006692
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AA638C415;
	Mon, 11 May 2026 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6fzp2qI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F938758B
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485024; cv=none; b=bKaZ2Fd/FNQXKf9uVS56LPhjlQQL2iV0u6UlEBWfdd65yLd5J5JNeVSraSyeBI7phes7jVNSjR3yIHXhyQgaGkoZsY3qWjrzKAsbsDgfoLMfZXB+okULlGrLLYVzzBbogjJ8osz1uquD5MeKhFPN64w8mVzmVFCToT4CPlC2QpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485024; c=relaxed/simple;
	bh=O+k/jUzvX+KuSrAZrBJsGaMJNGz599rfXwcVyBW/A3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Op+PPjo50v5/oYkVSi3RoOnspKuDtQBARhp6TlmFLwJeZ7+Hsma4Rjd69hMkPvFKEr3sVmzUiHlwYbYdwiKeeAumy8rZKSUd17Nh6vl589WuaxzBcVwLAMjcw1m03ycseLa91IyHf9hnofsX/qRe00Cl12bsfmxeZOS2+Gego2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6fzp2qI; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ee9ec26edaso486110685a.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485020; x=1779089820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGorfTi5TsO6iV/MQZaiqRGAtDsBzQOwC7rZPa2uQVM=;
        b=X6fzp2qIaz1m9jY/FOSnlYG8/Vji9jZDG1+tuxsRwkndg/EeWzZf+ryGJeKeSv3gQb
         Y2wbxqOuaBZvGMzcxAng+LpbgrTb15xLOM0BmSq0VAgoq7jSoR3OkuZvIsa4eHnEsMMk
         fWXRPxw/xWHSEvjow1Nv3EwQ7DktAKjKGpYNh/6/DlXoGQ/wphuj5RYEJDeGYyka5oWS
         XeLMZzc67B9NtfgvVmgcS5V3NxaQC1ODJ9pFpwwwv/Wnb7gIBpYmf9lfCBcFGYeCmFbo
         TMYlOY+XPQ8Zi2qO9rrYYMW19XVfCpuEaVsAy09urd54I1csQvB7NatNaYHEDAqAaZYC
         qUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485020; x=1779089820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGorfTi5TsO6iV/MQZaiqRGAtDsBzQOwC7rZPa2uQVM=;
        b=rxklqqhkMvQfkVHVYRWkjCIY3YKD1UklF9K0vWc1NXFBAc7h189M77aqg6W7+EPaoe
         xjJ9s769WZeZ0KgQhICMtiMNON40juf/cPNKnOI5KqvNRjXzh+xxk0rTL7+WY73EIWfz
         WrDIlkEAlJft5g7OnuFnCOg7tGwk5HrMI37lO2fezeXvtlQbR9uvREViwF4A9oxKoPrc
         APGi1flSMLnkmw5nXoqo0+lG5CVOfqgDw+Rn7lO3nfNh7G+LWOZiJK07xddZT1vVVJ6L
         mL9bF/poRX/HpMYTDs1xa6RATAdfgob30GQYo2/Kr7SW4m4R891SShmjnqaGGVhgg9a2
         mr7A==
X-Forwarded-Encrypted: i=1; AFNElJ+nlOqrghR7e7MllPKAdJnKBRMcipiG6hpMecIGLtqk97QdVLq+oWNhJamaaV11kUKEuOJg01g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxxsjyg3YbsgScbAqmWf9nEBLWWW7z6QqznDEHXJM06PCbeoXT
	3h3+QuXLXiny75ZOO1/12ZZFZi1evU/FASLRSjJxV9RcgXxdpkDn6JjC
X-Gm-Gg: Acq92OGvxnvP7UMrk+uSVO00MnOpRIgQJGMI5dTumfFbzP7DVkV3GU03O3MCT0QNcRD
	rdPiROQzS3nDl9YENvabWrm0vAKPL6N6CH+P9Ti79pajUp7LEaHOnFAam/NZGglyCg+Tfxfveeq
	sVd74UGUnFa1T+D1BgNOlBhVpnzbVbmymLERJtqbOdWialg5brSL9A7Lyo+accqin+tmhaBP9EX
	DIHnp+jh1LfiOTgfIUhH9Io74JVS7EDq6gn4s6yGwQ3L5mRxnQDq065v8oFcToqgibg65tx9goG
	45Ez4/9cLDnKPHNBz/UHC5Qam3EUDh75r0Jfhzu9RcHfnr1aDJt/ccvGZ/3DO8ZZcxWSKGQeAxT
	rsnEe7fFfDuQ8s28ACRt9g4DlqElfUHbB9l71MLI6tFF0dyXUJ317PG68XdGp2RV3mt8+eyBwdH
	kiJAo5Yg3MUVFtKWLVZtnNnXoBYU1D9djJJAkgoEwo2uNV0I/X2EpTDKQv5S+bhg==
X-Received: by 2002:a05:620a:d5b:b0:908:d26b:bc61 with SMTP id af79cd13be357-908d26bc80dmr985347485a.61.1778485020412;
        Mon, 11 May 2026 00:37:00 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:00 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>
Subject: [PATCH 6.1.y v2 05/18] perf trace: Deal with compiler const checks
Date: Mon, 11 May 2026 12:40:38 +0530
Message-ID: <20260511071051.537859-6-yesshedi@gmail.com>
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
X-Rspamd-Queue-Id: A7DB850955D
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245127-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 2c850606a46b319d5128bda59f67b1fc642d94ef upstream

The strchr() function these days return const/non-const based on the arg
it receives, and sometimes we need to use casts when we're dealing with
variables that are used in code that needs to safely change the returned
value and sometimes not (as it points to really const areas).

Tweak one such case.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 441655e659c2..313eb0929324 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4622,7 +4622,7 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	}
 
 	while (1) {
-		if ((sep = strchr(s, ',')) != NULL)
+		if ((sep = strchr((char *)s, ',')) != NULL)
 			*sep = '\0';
 
 		list = 0;
-- 
2.54.0


