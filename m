Return-Path: <stable+bounces-245131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFywAHiJAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B05097F6
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBDE4307DFDA
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5F38E126;
	Mon, 11 May 2026 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVAXltWD"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FFB38734D
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485032; cv=none; b=Qd/xcmwNqpfh3R27cxnB8uqy7IOBn2fMyAvJXWjkCG2Q8egcpRogJz+oZ+Z8kzw1SPJFvb4CSl1Tmh87HkmG22+bts23Y6+4EEJk66SUnk3hxatYyUSXkTfz0HpgEEIcDu2crgY5cKDW69kryBjpx1z34kwlXwaBi9AkV9aJ1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485032; c=relaxed/simple;
	bh=LLn5s73WHoXp4TGPafizid2iADOl9iKXGKdcoAq5KfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uV3L//iai/XfsqaBOT7vxk/joOSwdQcG4HxBQt/l1rwi6zo9r4Xzw8f1wh47I0ocUEt/d8jCD9rfEZRJCfAMw3LKybA0dlsL3EFBASPmkWnYfblshx8ebm6mOS68GNenvaO+732xL+NM7DKJAsiUIco1byB4dUNfN+GSWKI4h6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVAXltWD; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8d6d5e45c43so438233585a.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485027; x=1779089827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqBQg5bJdyOKC6RiN4S+lODerIuB3MBO5alKMDIkVUs=;
        b=JVAXltWDHiZXCCoLQNIUME23+MFFIqQWFr1FOMoNWneEeMKTNcmwCMmTgvLmyNLKso
         MlpwpnaNw01tVVCuayt4WtOFDQOAqhDCaJrJBs4p6q4W0lRHpPx+GjyFBz+B9CzXbMLa
         unO0/PCjxx1WM8aZV2ldXzHRkY1kI6bo5trbu8H5nJGmkl38YAGkwWUyOrDV83pHgWOn
         BdQLzNGeqzcNREQThfOMN0mRqXiTj86GnI5oz/vRHHuCrx5sXUuSw/Sj7nnns0JXtdbN
         FxN+pZKJWDiIxWNOPhxjEfm3MA52F0l/UL1GUYSQPhYDE+/fzSz0HuTvmG5y8Z719MjY
         Rj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485027; x=1779089827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uqBQg5bJdyOKC6RiN4S+lODerIuB3MBO5alKMDIkVUs=;
        b=TrUju480lIoYsRMVFGxpNdRoRLPmgalEYIend6nJGv3SdBfEnOkHAd9SYA7cTA+bks
         61J7jtw3xWX/8T9eKn/LPWgmYVeCySRWowv3Z2xaIOzkytODybMQZaW/CB3ZnnFcJEdP
         T9dadlz/Hm5Cp7jbI4OFPK2eU9gL7u7/76ENcmX1Sck0Q97de0Nc75YL/Ts7eDo8BSd9
         BJvmVf4E0zLZiPkSVLnUbIAk44BYm+MBWBVZDbK2stlMa3BcFWgFxOeivYkgybNBh9bz
         2Pmv3fgY6MpbfRqEnn608FD6uNnWPxTPitWDioxbU/6PjBgLPtvw5577pAWvdNwUG4b5
         MuIg==
X-Forwarded-Encrypted: i=1; AFNElJ/maee1dHc3Pw2dEuTa2x4j9DHHyp2SZJk+Y2wy9ZUGj6DBQO04apkgibbY6QoFXu/yR1INcnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqp8P3BpkFSHhGtQSjqlm8Rv9NmFzB0hPrZNa1JzXnyQF1JsQ
	1+UIy6Ji4k7B1E9JOnXuQ+RIxkJgq7G5w6C7BwHiecd/S3kPycJTVVUl
X-Gm-Gg: Acq92OHVhKK9ADrOpi1ElJXy7ojz/tDbPGDUQjHF+C0tkOTJ+O3ztrPRtErId8jEn6B
	KDGDAtq6B57hqYkbyiARb/1J9Ph11FaSRImbDCWgRF8QulLFaW1YgywGqM8WCxv39lxzG2Yyo4E
	KJpve13Dh610Q1oTqHpUW4m0VUWlugJFSCX2hacrALnBhG+MjwfXFk32qBXXOfXzzd1Lt7Gq6tw
	KYegVO+ujJIFrJJAi9qoSWhSKoeOaLFA20mqFVKhGO8CDCZO670OlDDQTtLWU26LRakU1WPUF3d
	HLcTIHWtVHTDCDW2qko2249D49OlGdyL6XwaOImsdPS+bHQQI0c7Fx8FybZY94spAekF4Xv+kxF
	RQPva1L2qatRcbhRaTwA3R7vOc5Bk4jELpflE+0PpFzByUsCTRMRblcpwrisV3WnLvwfqXW91ZT
	C2yZ8XxH7xdj/G09TGIVZEsrpfq/YAGD97Y7/mCsT2lG56MZTWsW9495m6fIGbsw==
X-Received: by 2002:a05:620a:3723:b0:8cf:d579:4aff with SMTP id af79cd13be357-907b96741fbmr2030139485a.16.1778485026624;
        Mon, 11 May 2026 00:37:06 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:06 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.1.y v2 09/18] perf strlist: Don't write to const memory
Date: Mon, 11 May 2026 12:40:42 +0530
Message-ID: <20260511071051.537859-10-yesshedi@gmail.com>
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
X-Rspamd-Queue-Id: 795B05097F6
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
	TAGGED_FROM(0.00)[bounces-245131-lists,stable=lfdr.de];
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

commit 678ed6b707e4b2db250f255d2f959322896dae65 upstream

Do a strdup to the list string and parse from it, free at the end.

This is to deal with newer glibcs const-correctness.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/util/strlist.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/strlist.c b/tools/perf/util/strlist.c
index 8a868cbeffae..98883672fcf4 100644
--- a/tools/perf/util/strlist.c
+++ b/tools/perf/util/strlist.c
@@ -139,21 +139,25 @@ static int strlist__parse_list_entry(struct strlist *slist, const char *s,
 	return err;
 }
 
-static int strlist__parse_list(struct strlist *slist, const char *s, const char *subst_dir)
+static int strlist__parse_list(struct strlist *slist, const char *list, const char *subst_dir)
 {
-	char *sep;
+	char *sep, *s = strdup(list), *sdup = s;
 	int err;
 
+	if (s == NULL)
+		return -ENOMEM;
+
 	while ((sep = strchr(s, ',')) != NULL) {
 		*sep = '\0';
 		err = strlist__parse_list_entry(slist, s, subst_dir);
-		*sep = ',';
 		if (err != 0)
 			return err;
 		s = sep + 1;
 	}
 
-	return *s ? strlist__parse_list_entry(slist, s, subst_dir) : 0;
+	err = *s ? strlist__parse_list_entry(slist, s, subst_dir) : 0;
+	free(sdup);
+	return err;
 }
 
 struct strlist *strlist__new(const char *list, const struct strlist_config *config)
-- 
2.54.0


