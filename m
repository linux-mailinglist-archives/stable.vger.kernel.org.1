Return-Path: <stable+bounces-235918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMHOOJiQ3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6563E7DED
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 641BB3016253
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D4038AC69;
	Mon, 13 Apr 2026 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="qnboTd6Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D4392C29
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062596; cv=none; b=d/8S4iUgcrSLXLrPDPO88hjhEn9AviMH0s3l6/EXVpRGl1lTS/nMGyHyWrrGfUjFoomHPDywL/lmP48vxJavObVASFXJcO3lWN9lgTepVxFZzHqa/CYvLMYxNUQhD4B2BRv7YpbBeQbai616/0XHD/aT89zLgKw+tqT4uBXIOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062596; c=relaxed/simple;
	bh=DJqsNXwizJ7aoa4uBdhA4XQ2JAchEDz1QBpSke3Vegc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZHO5u8kr6zMLZ/EuNBEQ6VajUONre54M7mcXj1Sb1Qov9JIGNx4pF5bEZlgBQ/EscWkmEvmV139ZCkO/MAhqmYqQiOo6OCtWgdl7DGe4ouApxA47/odDp16VyT3zR/abBxdBPads7YIAKqF68XU6Aodx2po7W5ofSEtdH3Ia/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=qnboTd6Q; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2E0483F1C0
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062593;
	bh=D8Sz3bvRfgX/lZ8BsWkwN0ekzjE+vqqTBAe7yqgM4jY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=qnboTd6QWBkhjg21R+stIcgLQQm5SwWeU0j09amP41jAfJ2glYM2Kv2zgx/IQB+AD
	 R59tIqxIzG3tcyTsOxLVnyxQCX1Y/gnOjL7hkGKJv0zxJ4SoQ6xiQ7uxppLXolIwW/
	 5Ixc+4b8UB+dW76arXR6njOOMwvqdcXx0NIm2IixpHosY+a8lIKBhyGBtSvEpwHWLM
	 ZPNH6YWtXuujrqq/SRVNWd00ZT7oxflKv4wjtWzkbHYb2Igm0Y58hB9UXP9LrEAYve
	 hSaxvOY9K/M82esEZHV1OBU5NdsOxSBPlMDizLYwtRmXgx8cjb3uLYCIoI0L3/HeNZ
	 WcIIYiM5tUbcjYTAe79u5rV/pBfQaFEFFspVL5lPQm9insmW/Zbr8PySqS5DXE2qyE
	 EWfpib8UVQ7SSsnbuBm5KkWOPkaJt3p9MQas8FiMZF6zRjXW6FU0JTOpr9leAQuDsI
	 2DZrGLIic3xDVsZFsdmN/jRp3tOBe8yXOLpoJxUFQDoMHZU/gB55tB7UvXzw55kLI9
	 mTZkk7Zw0cAh8g3U7IOE3VtH+Dbtl4/v1W+90zs4hLaGjZxkaVNvw/TOT8FdHC/cJ0
	 JuXOmrnDBjrPsoowhQPCqazBuN19vgFrR7W30MC6vgWIAdxH8PEfE5tU/hn22MpSoG
	 3zSpJuya3ammhgft4ABBPtUQ=
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f2478c37bso1672264b3a.3
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062592; x=1776667392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D8Sz3bvRfgX/lZ8BsWkwN0ekzjE+vqqTBAe7yqgM4jY=;
        b=Pyu42sQ/JTLkKKb0+qOrITiNv/1ZxH/t8pjPy98qJeQGMqSG1LldiwaGmlHuNCSbnK
         NDN6xkVlifxqqMk4wBbJ5wjbmA/LBQfPi6uz49cD2it9t+lGOf4bmOM/6I5oI/tWU3WQ
         SuYG7vUB8AG5vKjfnuwY5/GlkEu4G60S6nGpt4N6DsSlqznIUbdZgF7zMuWmnN2azoJp
         Qdjr6zwnaTVl6WH/5WLZnboUIg2NNvPJUowNmmowFV1y9pPLCvJ0Vckgjpb/H9+2G4Vv
         G7tk/Pwr+LYZ9Mkgm3CXfsQsXBFKxJTzrACvdpo1tXR9QLYATgcCINbgutaseS422oAc
         y40g==
X-Gm-Message-State: AOJu0YwptztZ5E6iV96YtE9VBeZnSdDBkwng2LJEOO/QN++rR8/pBZ3R
	zgz0pPWJvEFUBn3UT/Aa1aCSbec/mFytMUTyWwrw2Tbb/9/bJ9sbJft3pBjU2IIcRli/Svusqtz
	yKTy7qewBX2oZe7/aaR1nHZd8/2xm2JVvgIO8ylYYjv9s9BVYbDMY8VgWhqqNoN5T5RHpmNSOiy
	+jqRJgPQ==
X-Gm-Gg: AeBDievx9K3mueXbJ67QPpiXxvMUgmEg/8bSytcEpmhfb3jUm/16wgQ5fW6aj2UK/cO
	X8k1O9rMyZcnJNFRxqpXG4Wb3uYKH7SNGSZA6ljkZba6t2pRqOEuMov7DO58TVQ0Vj8Z0j7u2kK
	9OFJkoLIpa2S248MhavjjoFnL/L2Y3owVl2slkR9iiQVvmoc9lJ3IPL33qkhrVYQsE8x2gL561n
	KJ5Q97WeJDFsIbKnVIGUlrC1KeF0FGVoPZgYW8O+HuHzdBiSGoH+Vl5VkO5qZhRn731LeNcyGiX
	RNjl3Hgji1wTKVNd6zfM4C5Ebryb0FP06xbdtbKgUD4OVhkmI+lWmHYQu0667ssU5b0sXkDwRJi
	3ZCTK3UpKMUO1BeJZwxOiitD1wYw=
X-Received: by 2002:a05:6a00:8c13:b0:82f:5bc:59f8 with SMTP id d2e1a72fcca58-82f0c39e9a9mr14155782b3a.52.1776062591763;
        Sun, 12 Apr 2026 23:43:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:8c13:b0:82f:5bc:59f8 with SMTP id d2e1a72fcca58-82f0c39e9a9mr14155765b3a.52.1776062591423;
        Sun, 12 Apr 2026 23:43:11 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-82f3800afefsm3905972b3a.41.2026.04.12.23.43.10
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:43:10 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 09/11] apparmor: fix differential encoding verification
Date: Sun, 12 Apr 2026 23:39:18 -0700
Message-ID: <20260413064256.1578919-10-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064256.1578919-1-john.johansen@canonical.com>
References: <20260413064256.1578919-1-john.johansen@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235918-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[john.johansen@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E6563E7DED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 39440b137546a3aa383cfdabc605fb73811b6093 upstream.

Differential encoding allows loops to be created if it is abused. To
prevent this the unpack should verify that a diff-encode chain
terminates.

Unfortunately the differential encode verification had two bugs.

1. it conflated states that had gone through check and already been
   marked, with states that were currently being checked and marked.
   This means that loops in the current chain being verified are treated
   as a chain that has already been verified.

2. the order bailout on already checked states compared current chain
   check iterators j,k instead of using the outer loop iterator i.
   Meaning a step backwards in states in the current chain verification
   was being mistaken for moving to an already verified state.

Move to a double mark scheme where already verified states get a
different mark, than the current chain being kept. This enables us
to also drop the backwards verification check that was the cause of
the second error as any already verified state is already marked.

Fixes: 031dcc8f4e84 ("apparmor: dfa add support for state differential encoding")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/include/match.h |  1 +
 security/apparmor/match.c         | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/include/match.h b/security/apparmor/include/match.h
index 29306ec87fd1..611ae908469b 100644
--- a/security/apparmor/include/match.h
+++ b/security/apparmor/include/match.h
@@ -190,6 +190,7 @@ static inline void aa_put_dfa(struct aa_dfa *dfa)
 #define MATCH_FLAG_DIFF_ENCODE 0x80000000
 #define MARK_DIFF_ENCODE 0x40000000
 #define MATCH_FLAG_OOB_TRANSITION 0x20000000
+#define MARK_DIFF_ENCODE_VERIFIED 0x10000000
 #define MATCH_FLAGS_MASK 0xff000000
 #define MATCH_FLAGS_VALID (MATCH_FLAG_DIFF_ENCODE | MATCH_FLAG_OOB_TRANSITION)
 #define MATCH_FLAGS_INVALID (MATCH_FLAGS_MASK & ~MATCH_FLAGS_VALID)
diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index f70e5f769ef0..8972d1b57b7a 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -246,16 +246,31 @@ static int verify_dfa(struct aa_dfa *dfa)
 		size_t j, k;
 
 		for (j = i;
-		     (BASE_TABLE(dfa)[j] & MATCH_FLAG_DIFF_ENCODE) &&
-		     !(BASE_TABLE(dfa)[j] & MARK_DIFF_ENCODE);
+		     ((BASE_TABLE(dfa)[j] & MATCH_FLAG_DIFF_ENCODE) &&
+		      !(BASE_TABLE(dfa)[j] & MARK_DIFF_ENCODE_VERIFIED));
 		     j = k) {
+			if (BASE_TABLE(dfa)[j] & MARK_DIFF_ENCODE)
+				/* loop in current chain */
+				goto out;
 			k = DEFAULT_TABLE(dfa)[j];
 			if (j == k)
+				/* self loop */
 				goto out;
-			if (k < j)
-				break;		/* already verified */
 			BASE_TABLE(dfa)[j] |= MARK_DIFF_ENCODE;
 		}
+		/* move mark to verified */
+		for (j = i;
+		     (BASE_TABLE(dfa)[j] & MATCH_FLAG_DIFF_ENCODE);
+		     j = k) {
+			k = DEFAULT_TABLE(dfa)[j];
+			if (j < i)
+				/* jumps to state/chain that has been
+				 * verified
+				 */
+				break;
+			BASE_TABLE(dfa)[j] &= ~MARK_DIFF_ENCODE;
+			BASE_TABLE(dfa)[j] |= MARK_DIFF_ENCODE_VERIFIED;
+		}
 	}
 	error = 0;
 
-- 
2.51.0


