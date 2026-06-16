Return-Path: <stable+bounces-266204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EwOrMlqZMWp7nwUAu9opvQ
	(envelope-from <stable+bounces-266204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:43:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E09B69462B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:43:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=uk6FQm6h;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266204-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266204-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DD583011123
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24404779B0;
	Tue, 16 Jun 2026 18:39:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979F43DF007;
	Tue, 16 Jun 2026 18:39:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635199; cv=none; b=t4vq4yeBTsWMSUGZFIFoBwLf+ZFSPzGLPWpIEwBK/XT1L6rrpWCmeXbhCF8P9/WKkzk8hDrFjKLhB2JpiPLyu91+auI8LYC8GTWpVL+YrJEgSPBMmgRiXs/j8g7ZhoxAAJ2i2/BMfHPE3yFHQ0Q10BDdi4JfXUvQBSzpFhTYyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635199; c=relaxed/simple;
	bh=uF2aoiUaXqwtpHxR3oaULxkT/e1XzwhykugGliZgjMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPY4VG+IYu+zDbupdHuBA0QmH4dTQSqc3Je863N6pPAU1qWbRWCL8h9qc/mIffG/ogMimrjMx9BFMNdHgOuhQ72xX3yGN+vbWFVP78zpit1OK5lV9ta6jpZIZpxRjLz6NslbcXrotr/qIPmMjI+aaai/Rdwb1J/iGy2tGdOib/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uk6FQm6h; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BD01F000E9;
	Tue, 16 Jun 2026 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781635198;
	bh=sbxvQsSxuW+4o4+GWc3lsSmi83zkclx7QYRGl0/PxXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uk6FQm6hKZfBnHcHZ5YEIWMm8eepN7Fu8/+0HY50Pv4tETCDg8Y4CrMk3g+qpvQB3
	 S8YOLX+8ShulUI3t323M6BACd9mhxdujuuyAeueGSBPaZmOGJU79VBFpuB//K6kv7o
	 XGRGaayEMu/4tBexieoAPM/nzdwClSYMGB0KOIek=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Hutchings <benh@debian.org>
Subject: [PATCH 5.15 410/411] apparmor: validate default DFA states are in bounds
Date: Tue, 16 Jun 2026 20:30:48 +0530
Message-ID: <20260616145122.923082946@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266204-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:benh@debian.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E09B69462B

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <benh@debian.org>

Some backports of commit 9063d7e2615f ("apparmor: validate DFA start
states are in bounds in unpack_pdb") limited the bounds checks on DFA
start states to the case where the start state was explicit in the
policy.  However, the default DFA start state (DFA_START = 1) could
also be out-of-bounds.

Move these checks out of the else-branches so that they are applied
regardless of how the start state was initialised.

Fixes: 5487871b2b56 ("apparmor: validate DFA start states are in bounds in unpack_pdb")
Signed-off-by: Ben Hutchings <benh@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/policy_unpack.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -846,6 +846,8 @@ static struct aa_profile *unpack_profile
 	}
 
 	if (unpack_nameX(e, AA_STRUCT, "policydb")) {
+		size_t state_count;
+
 		/* generic policy dfa - optional and may be NULL */
 		info = "failed to unpack policydb";
 		profile->policy.dfa = unpack_dfa(e);
@@ -860,13 +862,12 @@ static struct aa_profile *unpack_profile
 		if (!unpack_u32(e, &profile->policy.start[0], "start")) {
 			/* default start state */
 			profile->policy.start[0] = DFA_START;
-		} else {
-			size_t state_count = profile->policy.dfa->tables[YYTD_ID_BASE]->td_lolen;
+		}
 
-			if (profile->policy.start[0] >= state_count) {
-				info = "invalid dfa start state";
-				goto fail;
-			}
+		state_count = profile->policy.dfa->tables[YYTD_ID_BASE]->td_lolen;
+		if (profile->policy.start[0] >= state_count) {
+			info = "invalid dfa start state";
+			goto fail;
 		}
 
 		/* setup class index */
@@ -889,16 +890,18 @@ static struct aa_profile *unpack_profile
 		info = "failed to unpack profile file rules";
 		goto fail;
 	} else if (profile->file.dfa) {
+		size_t state_count;
+
 		if (!unpack_u32(e, &profile->file.start, "dfa_start")) {
 			/* default start state */
 			profile->file.start = DFA_START;
-		} else {
-			size_t state_count = profile->file.dfa->tables[YYTD_ID_BASE]->td_lolen;
+		}
+
+		state_count = profile->file.dfa->tables[YYTD_ID_BASE]->td_lolen;
 
-			if (profile->file.start >= state_count) {
-				info = "invalid dfa start state";
-				goto fail;
-			}
+		if (profile->file.start >= state_count) {
+			info = "invalid dfa start state";
+			goto fail;
 		}
 	} else if (profile->policy.dfa &&
 		   profile->policy.start[AA_CLASS_FILE]) {



