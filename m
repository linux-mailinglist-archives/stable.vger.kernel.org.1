Return-Path: <stable+bounces-235930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK6uM4eR3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B89CC3E7E7B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC0C03005A88
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D49535DA49;
	Mon, 13 Apr 2026 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="TganNwOG"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DAA1E7660
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062853; cv=none; b=EtumEGMkJR/oyp9oJOGk7hiAfrhgT/ZdoUGtsz13+vttLYMVECfs3QhD8r7e/iMevhaAB8eRg558n4vtONqxR7C3rf0htZSvdDKqCUWuJb3M1hdz7z46IHjHyBwBELMeYhs5Obw1z6aTvLQtDfG1ZK4ifMbDpl67ZiH0iTTxDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062853; c=relaxed/simple;
	bh=DJqsNXwizJ7aoa4uBdhA4XQ2JAchEDz1QBpSke3Vegc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sA0e012aRRAB6uvtbWml89ItvNDQ4vgPqF208hUoC5rJen6lAksFdxeR/qOBsDyPCErB7vgz5+2CQ3GED1wf7/PWtvYeg5B08khxdH8+4jtUhgbS0A8EJAw1Xng9gWbg9Ei4DZ5hHLh3u1Em/4dhM7RSP5sOz7TfrFkYwSRTQoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=TganNwOG; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 769173F1E0
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062850;
	bh=D8Sz3bvRfgX/lZ8BsWkwN0ekzjE+vqqTBAe7yqgM4jY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=TganNwOGyVX+vnS6sdv+gzIf36SJKmLeH3OtvI8tvcX7Iyjg1yZ9Qjn5M64HZI/g9
	 jbMXx2vpnQDlH7wU9+rraCwyRuqJsgoQr0TatR0cCha3UTcYFNRpxTE32/lgTIiuyl
	 d8CXo65gcaMie2R8h+xt6z6MUERvVc95kseO7a1f9YAHOva0yYUSK6RlmAST6ETbnI
	 d3qZ65jnDGsVaCcX/0dy9BI+53HAfDgEnjPi9nTn1dLwJBNYSaTbDuwNJiNtwTle5C
	 xeJqbx59pX1xVRdO+aGuja29d+SPSa+GLtO1z9PiXWR5+PzSPkHu2cw++euE57sJka
	 zjjYfzUkjpDsEGFjoGjutNueeY/QMok20b4mb92jC8gzhrWFbE7fDywt0lsTj2WRze
	 RkkPLXXROiTaEMWeOk9ZgRrVMVOwA1UoyyEILh2Frjwe4H0AneUzrnIwX/ZFgHzhCO
	 eXy4QfrRisMBbPMWHuD2Vx1+rnSeIFWuXbXIhOs/aHJJMdhEeXnLnuR/eAW7PH/j2Z
	 l3MuVItQfGxIvs8wS/F1jNQkwv+zUhGWLVydcyhSJV4jJIpUeR/Po/gugSXICQm1P+
	 suzRI4XCr3zlPo7W++2/uXnZ4z7x6bbGsMoMErQvm/k/bzKfLdog7yDojkBR3RAYCQ
	 f8e5utfwWelhoFCCt7N187vc=
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c741c4cebf3so2220088a12.2
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062849; x=1776667649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D8Sz3bvRfgX/lZ8BsWkwN0ekzjE+vqqTBAe7yqgM4jY=;
        b=gvAaMom4qQde2F2PPWKEkverKne+cm8dmWqlimI7oI08GELwphATW391CYYoef2TV5
         q/gfg7pOSpHjYm/vZ7ZHVeIOJQGJkvntexJqSZHPgM+MaKGOu4WmHPnZoVFXZEtmhYHH
         0ifPP85R0wNDjUYP9dxFKjyXuueYItp/CCzJHE/kLVUrlTvX9zFG98C+IhFnCWY2txRZ
         eO0Y+cYnwjJz0aFIKL57ORVYK88G8fZHp812/PBfjZJf7HNdFM+6k9bPdUN0olythqd7
         BiQgNxat+se/bAFvfTo/fu49L9fh4EdzT8yiTsRjWS0XXEKk3u2zQekj/d8Zmmahre1z
         rBuw==
X-Gm-Message-State: AOJu0YyvXq7g07JzLu8MkM2U6KyBRFwNoivN54rhpkrHKojQ0opBm89N
	jnazXweBo7zTcCDMncy3qpzFr/JqaDkvdPE1DoM7X7Q2ofb5U9v83yViqNn/ro23EI63CsThrsJ
	PCqOm205/1hwzqS7st0yStvC/BYE7gOnw6N+7LOwM9kC4rlmp/8t/u5KX+vYDt90f3Lc3RDc5Wo
	4x1BvdTg==
X-Gm-Gg: AeBDietE5wkNKcfcFd5/tGDIaZMRnA8CCjd1TMQwhTfTvMZsb1++0AdGqF3MVO5Vzrw
	Z9ZKNfV/RD30pdODrCy9rYwr0dXrstdxq+eceMzxV7HQjuz+8SSigGOrgN3ll13Ehhl7P/zW+Dp
	By5aTzC2t1mmCbedGIIMOmi1XLimu3o9iyiykEzQix/yAJ8xQbmdOGokk4efV0n/LTKFmdqY6yo
	+h0BFP+fe8PUh2CSZesQDza52wBi3uo8H2/I7NNmQ3p/5vYnBBPvRuJKuS0qPjNZCdAXk8YGj8o
	Xmv4MGUFM4vHEbJYs5N+n4gafzUdgsaJSatHfGU+IZqjowaH9q+tMi+fZZMD4lZdWEe3nAgazo2
	K/ShhVftDeHd6zoK+VrH8UwA7zKU=
X-Received: by 2002:a05:6a20:7353:b0:39c:241:65a3 with SMTP id adf61e73a8af0-39fe3c65da4mr12930866637.1.1776062848947;
        Sun, 12 Apr 2026 23:47:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:7353:b0:39c:241:65a3 with SMTP id adf61e73a8af0-39fe3c65da4mr12930845637.1.1776062848620;
        Sun, 12 Apr 2026 23:47:28 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id 41be03b00d2f7-c7921534918sm9875394a12.0.2026.04.12.23.47.27
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:47:28 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 09/11] apparmor: fix differential encoding verification
Date: Sun, 12 Apr 2026 23:46:34 -0700
Message-ID: <20260413064712.1581137-10-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064712.1581137-1-john.johansen@canonical.com>
References: <20260413064712.1581137-1-john.johansen@canonical.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235930-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B89CC3E7E7B
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


