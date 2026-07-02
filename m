Return-Path: <stable+bounces-271044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZH+KIUSXRmqwZQsAu9opvQ
	(envelope-from <stable+bounces-271044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:52:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 307FC6FAABF
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:52:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pxakNDcO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271044-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271044-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 024E8309096F
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E8E2D0602;
	Thu,  2 Jul 2026 16:42:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0D347BBD;
	Thu,  2 Jul 2026 16:42:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010523; cv=none; b=kk3fmOcDUhlo4/eIJwK1z5lhRjEb7avta9yDG98Ht7hs1Oj5+PFDto7TZhtfsna10/2G8yv8pFrPvE+M+hau/WcWEHodsIsDhAWwVm4YOQ+fJokwI6ACl+MvfxmwFLrSqgndfk33S9tPaCTJtLcwttuPouiiHfRcooeihJZazak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010523; c=relaxed/simple;
	bh=P1XWFfEy/Koi4uNDwnnx1HRtB7wN4kBowIUAbuii9wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMkOuPBDGB+kxDzgwz0xnd4RmjGR3bmtbIWCqN1IkEfk0iGQuXSRnW58DxEUJ3mqAzDEl8GvCe7vqaYBKJEoEGiLnz/EBjMkd0gCbNv5LLk5tkRwFynYrQ8XREC7PWt2YCGeP5CpRAw3imMWVDbJZLs3nj4Z1v1A5GmmYVa5SJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pxakNDcO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E10D1F000E9;
	Thu,  2 Jul 2026 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010521;
	bh=weWakl/E7JA2QfGL86vhbyi7cE0ndbbccD1tbGrOSXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pxakNDcOQeLkzzE1NR1P9COIEn1AXIz23zxFdZFInWR96OWOQe4ctxTlEnkXtfkoF
	 t1RBsHRWoZXTdQ7Pk3WXn+nF/Ev3ug3vyB2RVgohzFGpRB5QNB9JfhNVfbwmWcSDHT
	 lN6iCYZcV56V82hbirVsAQPDN+Qbi18PTMP3WBP8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Colin Ian King <colin.i.king@gmail.com>,
	Ruslan Valiyev <linuxoid@gmail.com>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH 6.12 140/204] apparmor: fix use-after-free in rawdata dedup loop
Date: Thu,  2 Jul 2026 18:19:57 +0200
Message-ID: <20260702155121.591334052@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271044-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:colin.i.king@gmail.com,m:linuxoid@gmail.com,m:john.johansen@canonical.com,m:coliniking@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,canonical.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,canonical.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 307FC6FAABF

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruslan Valiyev <linuxoid@gmail.com>

commit 6f060496d03e4dc560a40f73770bd08335cb7a27 upstream.

aa_replace_profiles() walks ns->rawdata_list to dedup the incoming
policy blob against entries already attached to existing profiles.
Per the kernel-doc on struct aa_loaddata, list membership does not
hold a reference: profiles hold pcount, and when the last pcount
drops, do_ploaddata_rmfs() is queued on a workqueue that takes
ns->lock and removes the entry. Between dropping the last pcount
and the workqueue running, an entry remains on the list with
pcount == 0.

aa_get_profile_loaddata() is an unconditional kref_get() on
pcount, so when the dedup loop hits such an entry, refcount
hardening reports

  refcount_t: addition on 0; use-after-free.

inside aa_replace_profiles(), and the poisoned counter then
trips "saturated" and "underflow" warnings on the subsequent
uses of the same loaddata.

Before commit a0b7091c4de4 ("apparmor: fix race on rawdata
dereference") the dedup path used a get_unless_zero-style helper
on a single counter, so the existing "if (tmp)" guard was
meaningful. The split-refcount refactor introduced
aa_get_profile_loaddata(), which has plain kref_get() semantics,
and the guard quietly became a no-op.

Introduce aa_get_profile_loaddata_not0(), matching the existing
_not0 convention used by aa_get_profile_not0(), and use it for
the rawdata_list dedup lookup so dying entries are skipped.

Reproduced on x86_64 with v7.1-rc5 in QEMU+KVM running Ubuntu
24.04 + stress-ng 0.17.06:

  stress-ng --apparmor 1 --klog-check --timeout 60s

Without this patch the three refcount_t warnings fire within a
few seconds. With it the same 60 s run is clean. Coverage is a
smoke-test only; a longer soak with CONFIG_KASAN, CONFIG_KCSAN
and CONFIG_PROVE_LOCKING would be welcome from anyone with the
cycles.

Fixes: a0b7091c4de4 ("apparmor: fix race on rawdata dereference")
Reported-by: Colin Ian King <colin.i.king@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221513
Cc: stable@vger.kernel.org
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/apparmor/include/policy_unpack.h |   19 +++++++++++++++++++
 security/apparmor/policy.c                |    8 ++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

--- a/security/apparmor/include/policy_unpack.h
+++ b/security/apparmor/include/policy_unpack.h
@@ -163,6 +163,25 @@ aa_get_profile_loaddata(struct aa_loadda
 	return data;
 }
 
+/**
+ * aa_get_profile_loaddata_not0 - get a profile reference count if not zero
+ * @data: reference to get a count on
+ *
+ * Like aa_get_profile_loaddata(), but safe to call on an entry that may
+ * be on a list (e.g. ns->rawdata_list) where the last pcount has already
+ * dropped and the deferred cleanup has not yet run.
+ *
+ * Returns: pointer to reference, or %NULL if @data is NULL or its
+ *          profile refcount has already reached zero.
+ */
+static inline struct aa_loaddata *
+aa_get_profile_loaddata_not0(struct aa_loaddata *data)
+{
+	if (data && kref_get_unless_zero(&data->pcount))
+		return data;
+	return NULL;
+}
+
 void __aa_loaddata_update(struct aa_loaddata *data, long revision);
 bool aa_rawdata_eq(struct aa_loaddata *l, struct aa_loaddata *r);
 void aa_loaddata_kref(struct kref *kref);
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -1175,8 +1175,12 @@ ssize_t aa_replace_profiles(struct aa_ns
 			if (aa_rawdata_eq(rawdata_ent, udata)) {
 				struct aa_loaddata *tmp;
 
-				tmp = aa_get_profile_loaddata(rawdata_ent);
-				/* check we didn't fail the race */
+				/*
+				 * Entries remain on rawdata_list with
+				 * pcount == 0 until do_ploaddata_rmfs()
+				 * runs; only take a live profile ref.
+				 */
+				tmp = aa_get_profile_loaddata_not0(rawdata_ent);
 				if (tmp) {
 					aa_put_profile_loaddata(udata);
 					udata = tmp;



