Return-Path: <stable+bounces-236505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLLfMr0Z3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:28:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0313EF085
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A33F8305A8BB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7920F3093CF;
	Mon, 13 Apr 2026 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VEg76nqe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAFF27280A;
	Mon, 13 Apr 2026 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097075; cv=none; b=jBs/wlhHOYttJIE5GmpSJ8mLuq00PwoyPlSKwV+bg7mr1I1AGa0QzaARMlTyCCrUogdMIrHNgR3SY8ne3BTpf+pG3iC4Ge1Uz8mEz+NyhdQVVZLZwrKMvUxHxvel/9XPLzAjMCxrw2IwFkKn8pzsvJK3PeVAQACgyHNRQqKYRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097075; c=relaxed/simple;
	bh=K1187ZRXxQUwfw9mBpMH4ud2RziJgPrinIpGG4pZznY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKCH7ug1LB07QiJe7fTq0ahN1QTTQy0NFAUlRFoZQ84cVEO1uhpk6ggXMJOW9p8RaSRY6ytVTUqyr6fKjrLnj0iXTS9ySr4Ne2uf7cDDN1kdtSA3hdeODZaQomMaBWM2Nn2flUGLC3oTABAF43Cgc42DpQVphFZ7ENrnXe5tV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VEg76nqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FF4C2BCAF;
	Mon, 13 Apr 2026 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097075;
	bh=K1187ZRXxQUwfw9mBpMH4ud2RziJgPrinIpGG4pZznY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VEg76nqev16eFlCFqxxNzv/+yutreqEKwniisy4NXNWlwsVGhXrnNmDauCO2MOnvu
	 f0uWVbNIzh3QvDA4hnWmlk8Hq2Kk/HKUnBa9WZMmUslcyzCNm/+HUs/MK5HoF5ye2S
	 5tpgtrgvl3aIBB5tx5B7Z5Je0zsSZ3GoCqRSLvGk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qualys Security Advisory <qsa@qualys.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.1 20/55] apparmor: fix differential encoding verification
Date: Mon, 13 Apr 2026 18:00:54 +0200
Message-ID: <20260413155725.582790269@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.820472494@linuxfoundation.org>
References: <20260413155724.820472494@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236505-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,qualys.com:email,canonical.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D0313EF085
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/include/match.h |    1 +
 security/apparmor/match.c         |   23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

--- a/security/apparmor/include/match.h
+++ b/security/apparmor/include/match.h
@@ -190,6 +190,7 @@ static inline void aa_put_dfa(struct aa_
 #define MATCH_FLAG_DIFF_ENCODE 0x80000000
 #define MARK_DIFF_ENCODE 0x40000000
 #define MATCH_FLAG_OOB_TRANSITION 0x20000000
+#define MARK_DIFF_ENCODE_VERIFIED 0x10000000
 #define MATCH_FLAGS_MASK 0xff000000
 #define MATCH_FLAGS_VALID (MATCH_FLAG_DIFF_ENCODE | MATCH_FLAG_OOB_TRANSITION)
 #define MATCH_FLAGS_INVALID (MATCH_FLAGS_MASK & ~MATCH_FLAGS_VALID)
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -246,16 +246,31 @@ static int verify_dfa(struct aa_dfa *dfa
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
 



