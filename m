Return-Path: <stable+bounces-229106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIxSOHhZwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:17:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6322F6163
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9852E3183075
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAD8283FEF;
	Mon, 23 Mar 2026 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nywCgDyG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A89724CEEA;
	Mon, 23 Mar 2026 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278078; cv=none; b=npH6xhqdv8b3Hbxy+ZSH0MU0P25azj6WjujUUV16jHGwW3G1iJEEq3UB+x4PPkIphogdVFSrWxpKa4tCAE/4Dj65pFVcDITJfXEZptqb8VgW6dhgscfm3vyEwm8CEBk8kaw2yk5i1zeSGaFG0J/g6X2k+/qj75y4haE3nJueEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278078; c=relaxed/simple;
	bh=dLsF34VDWf57mf+1PHWCB2Dcq4Wqx/gFPqr0yuIJB+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWc0Ww0W3agFVRbEE4IOfvxWQlgHqgLughjqxHqaSQIHWVa0wS9gSztxBkC2SZD9lUJzgLh4ahX/GSI9hG1u3RJAW4BPagnaejB76wGVqaR/laWdBoWU0ZGshGy2dlIrXWPdo9fyC2Gj2Nk3w9S1gU7V36YVmwngGo10f5pxzeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nywCgDyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AE3C4CEF7;
	Mon, 23 Mar 2026 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278078;
	bh=dLsF34VDWf57mf+1PHWCB2Dcq4Wqx/gFPqr0yuIJB+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nywCgDyG+ncWgPlWCBHL0diS2lbdlkNbNKijqvhJP51PtArZY+YN+D4Uc+ypXs/QE
	 +WcjDlf4RrXztuL9m64BIEHBdnnomz6GO7SFli4I1maVe/vQGSqpYsfD+FsFkeMUli
	 FF7bfDKbqwv2dbkQHVopqLoiO9ENHjvnbbWFgKlw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qualys Security Advisory <qsa@qualys.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.6 195/567] apparmor: fix differential encoding verification
Date: Mon, 23 Mar 2026 14:41:55 +0100
Message-ID: <20260323134538.673166329@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229106-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7D6322F6163
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -181,6 +181,7 @@ static inline void aa_put_dfa(struct aa_
 #define MATCH_FLAG_DIFF_ENCODE 0x80000000
 #define MARK_DIFF_ENCODE 0x40000000
 #define MATCH_FLAG_OOB_TRANSITION 0x20000000
+#define MARK_DIFF_ENCODE_VERIFIED 0x10000000
 #define MATCH_FLAGS_MASK 0xff000000
 #define MATCH_FLAGS_VALID (MATCH_FLAG_DIFF_ENCODE | MATCH_FLAG_OOB_TRANSITION)
 #define MATCH_FLAGS_INVALID (MATCH_FLAGS_MASK & ~MATCH_FLAGS_VALID)
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -202,16 +202,31 @@ static int verify_dfa(struct aa_dfa *dfa
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
 



