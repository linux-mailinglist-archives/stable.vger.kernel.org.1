Return-Path: <stable+bounces-236463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN8oAjEZ3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:26:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A431F3EEEC3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3FA03084E8E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4FF2DF12F;
	Mon, 13 Apr 2026 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HcdltqiE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED5627280A;
	Mon, 13 Apr 2026 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096970; cv=none; b=VOOQv40HfkjTxvDrhRjIGTZ6XE+Sk4r0mxkJlvKlg15UCTcyESr6muUk6VYvEPqXMYH9O0HBTXV6uHWxMZJ1fltv7t0AS/9mnHtO9TdUa5Z28nP2IvB2u8ItozjO6csWMpaWPbSl8sqt/E286BbyJZ0n3zDqKstBgHqFl2O5maM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096970; c=relaxed/simple;
	bh=I5Fg248lrxFBShSvssJnNaeUJG8yHAG3lJ9r2h4e/NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ti4DEp88KvL7xH/deieBBOIjo6SUgNYAB7q6NLKmrHB3FV/QA+xvBA9LLNdQdtUsaCGZC83XcbUjw+5sFKAwDlfcfoCtu/TMvrhR7ycVr0JCkyswPl71iWEpQaLzNyH80AZkYbf3aTqVDUJt8jgrAfBUgbYZNAzdFAViVN80vko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HcdltqiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DADC2BCAF;
	Mon, 13 Apr 2026 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096970;
	bh=I5Fg248lrxFBShSvssJnNaeUJG8yHAG3lJ9r2h4e/NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HcdltqiEihK3Fj402OBpFAkVlXWZEkgy0A2pw8mpSsgQsoWMDwkUmSrnGUEWu26Up
	 qINK/rzZj8evWNoJP0pnnIgzgJm/MHJ8df3JZJpUHwHsvst6Q7B2LBss5pwMZDEm0t
	 xgcn2ayHnPNwQ90+6+ThnGhf4bPI0fHnpkaTOLEA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qualys Security Advisory <qsa@qualys.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Cengiz Can <cengiz.can@canonical.com>,
	Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.1 12/55] apparmor: validate DFA start states are in bounds in unpack_pdb
Date: Mon, 13 Apr 2026 18:00:46 +0200
Message-ID: <20260413155725.287455051@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236463-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,canonical.com:email]
X-Rspamd-Queue-Id: A431F3EEEC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>

commit 9063d7e2615f4a7ab321de6b520e23d370e58816 upstream.

Backport for conflicts caused by
ad596ea74e74 ("apparmor: group dfa policydb unpacking") which rearrange
and consolidated the unpack.

Start states are read from untrusted data and used as indexes into the
DFA state tables. The aa_dfa_next() function call in unpack_pdb() will
access dfa->tables[YYTD_ID_BASE][start], and if the start state exceeds
the number of states in the DFA, this results in an out-of-bound read.

==================================================================
 BUG: KASAN: slab-out-of-bounds in aa_dfa_next+0x2a1/0x360
 Read of size 4 at addr ffff88811956fb90 by task su/1097
 ...

Reject policies with out-of-bounds start states during unpacking
to prevent the issue.

Fixes: ad5ff3db53c6 ("AppArmor: Add ability to load extended policy")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/policy_unpack.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -824,9 +824,18 @@ static struct aa_profile *unpack_profile
 			error = -EPROTO;
 			goto fail;
 		}
-		if (!aa_unpack_u32(e, &profile->policy.start[0], "start"))
+		if (!aa_unpack_u32(e, &profile->policy.start[0], "start")) {
 			/* default start state */
 			profile->policy.start[0] = DFA_START;
+		} else {
+			size_t state_count = profile->policy.dfa->tables[YYTD_ID_BASE]->td_lolen;
+
+			if (profile->policy.start[0] >= state_count) {
+				info = "invalid dfa start state";
+				goto fail;
+			}
+		}
+
 		/* setup class index */
 		for (i = AA_CLASS_FILE; i <= AA_CLASS_LAST; i++) {
 			profile->policy.start[i] =
@@ -847,9 +856,17 @@ static struct aa_profile *unpack_profile
 		info = "failed to unpack profile file rules";
 		goto fail;
 	} else if (profile->file.dfa) {
-		if (!aa_unpack_u32(e, &profile->file.start, "dfa_start"))
+		if (!aa_unpack_u32(e, &profile->file.start, "dfa_start")) {
 			/* default start state */
 			profile->file.start = DFA_START;
+		} else {
+			size_t state_count = profile->file.dfa->tables[YYTD_ID_BASE]->td_lolen;
+
+			if (profile->file.start >= state_count) {
+				info = "invalid dfa start state";
+				goto fail;
+			}
+		}
 	} else if (profile->policy.dfa &&
 		   profile->policy.start[AA_CLASS_FILE]) {
 		profile->file.dfa = aa_get_dfa(profile->policy.dfa);



