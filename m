Return-Path: <stable+bounces-245129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMmVNkyKAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:50:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DDE509909
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C53F300FC17
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E1A386571;
	Mon, 11 May 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk+NgDmc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41533859DC
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485027; cv=none; b=IYLnKuXQPMhEDB3isj9ScOI2+N19uamURHtxBGrxGBOSzQxdGu9faCv6iwYk0hRspSq6Z1nrykTCTMdCN99k6v0lYD3pDyek/lo1byctI3ituTjbu6RRP82dfbZo4b1lmbx8mmcdwmrLuKfrQSBPoRc0I9BsjKE4nRvh94truDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485027; c=relaxed/simple;
	bh=mbOM7J79M+DEm7SbZJiSEd3yK8qz6gfcayoeKWDBt38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hS8wIhv9nrde9shwRlTb89/VOcHl8IE8BoIzCwTFAdkuebOapD41INXecvWXY3fN/uXMACiOj2u7/qBsdZbv8q2Fxl1HInrdnM3hBR9bzdt9zVX/L9G4Imkjc34cBt5fM7eX3bxLfeqNftyPRfny8vW5uCI1W6Cq1HNTordQaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk+NgDmc; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-90b2fcf90a0so80166685a.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485023; x=1779089823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1NsoSoNGmZZahcOhmUvBczjllhC1zR2Rd4Aw2PDJ24=;
        b=Vk+NgDmcyXpo5h8OsL4B4pYurPr4EB9s7AB3/RikPR1GRGQsGafFZJVXDWVLqqR+k2
         Do7TiXIKwg570yqY6zfLORp/NAO3Beb7caDs0ZAanYxyjjaHXB4A8UN5YnR/2SF1+n0L
         PhLNOD1j86pzI7PbZUtcN+xuKhYkn9kC0BTcfrdxB0+ANRP1IjnolGd1dQzaAoY7qq8M
         6PZBgswo1HZK6Ek/84IdpS/Zer403kKAXRv6RI/Ty5KZIBgJAo9a3wf547sXIDFGwxl8
         AbhmkrHOxBOC+juKqgSVPtV6Yyh54xMh4Vw0yUOrj0+PhvdNW0RHdee5MNcGnrRpRVib
         O1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485023; x=1779089823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d1NsoSoNGmZZahcOhmUvBczjllhC1zR2Rd4Aw2PDJ24=;
        b=gLU23Okj5+Ds4IaAQXFeobOeCnj80WQ907xUzCpXYduslmJzJobAfUJTFo28v2+UDf
         5HmbZEeIHXIGJWue5TnjAI/ambgZAYd7fSn9v0MEmARXDb5oWhw3cHLflBttTE8mTnK5
         GIX2gErv+3oQZsnMNOV/RAuANq+aHk95blh5lbJmVXNwAx/aeKa/VrjNbxDviAhQyorN
         tVLdnXP6U15NNpGfRbw8H9wNZPC9U9ufObOPnJXGeEf58yOYtp++beYYwAR+Pdo0u82c
         KbT79h8Svt4eyi6tK9we/JZ33nBbqyqyqnn9PNvZTO+E7Nu6A4LuPmcHb3GiXK6RsiD/
         wBHg==
X-Forwarded-Encrypted: i=1; AFNElJ9jtZPAWXw3HkDlKx505u5UV10q4x5CRmovlbrzX2OqgByPEzzdWK3ZrGWptjX0cK0kRN//gsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+72AX1H8zNgGuEmuTtit+DG9DumdBWzP/pQs+q6C3MbnvXkY
	q10aScCvYN/OkRvCdBudZUhflr3w2era8HMdENJTN2ef25ZST8Ty6qag
X-Gm-Gg: Acq92OE3PsbJvamrXn2iodZ9fygyMd3Ktf/JnLFCku3o7sI5dkSKpJ8UwrDqaUbkhRs
	SHIH8XSqhd+8SHDxQhtB0vpY0+O10rLMk4rgBcaS3FV7BCf9RrcRwyIhNWO0fVmgo9ZcMWjm6oK
	jk7hr2KXl/aM2d9MqJqPWgWKi+5OZ50v3824RMdiwE3pw9ojRP08D5C1IzUhlfMZ14CMTo7WSJg
	NTMKVYl6MpD7m4mbffY3HL3VTREFjmjfvacdGIUfiR5FwO2MpVBiDqK1sH+macRuvmnkITEJpuI
	kq+UD6vSLkmlKJbpT5aqFH6fQE+OdHiTA8x65OH1iYHNqMhjaOGFY+Ad36xT/wKsNaqsi9qw9on
	m1PY/j6BHtk/D9cd1tv7mtt4wNSAIuQvqF+PRyU7iP8DOvMhsRvkdNCw65dQ0JyKSbiVu3lxUxY
	Zpz9RC/0JKvh/0PwUhlmEw4Vq7s5SgAoByrYIldCkwB+ISuse5MAJrbdyLMmbri9zh+lWPEzX/
X-Received: by 2002:a05:620a:4406:b0:8ed:d6df:c773 with SMTP id af79cd13be357-90650537c02mr2196236385a.11.1778485023257;
        Mon, 11 May 2026 00:37:03 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:02 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y v2 07/18] perf parse-events: Fix -Wdiscarded-qualifiers under C23
Date: Mon, 11 May 2026 12:40:40 +0530
Message-ID: <20260511071051.537859-8-yesshedi@gmail.com>
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
X-Rspamd-Queue-Id: 23DDE509909
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
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-245129-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.977];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

glibc >= 2.42 defaults to -std=gnu23, which promotes
    -Wdiscarded-qualifiers to an error.

util/print-events.c:206:21: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  206 |                 buf = strchr(nd->s, '@');

util/print-events.c:215:29: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  215 |                         ptr = strchr(nd2->s, '@');

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/util/print-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index c4d5d87fae2f..1ef1a3ed8051 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -203,7 +203,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 	strlist__delete(bidlist);
 
 	strlist__for_each_entry(nd, sdtlist) {
-		buf = strchr(nd->s, '@');
+		buf = strchr((char *)nd->s, '@');
 		if (buf)
 			*(buf++) = '\0';
 		if (name_only) {
@@ -212,7 +212,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 		}
 		nd2 = strlist__next(nd);
 		if (nd2) {
-			ptr = strchr(nd2->s, '@');
+			ptr = strchr((char *)nd2->s, '@');
 			if (ptr)
 				*ptr = '\0';
 			if (strcmp(nd->s, nd2->s) == 0)
-- 
2.54.0


