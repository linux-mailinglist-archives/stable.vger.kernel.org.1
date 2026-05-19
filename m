Return-Path: <stable+bounces-249573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEf/OItWDGqUfgUAu9opvQ
	(envelope-from <stable+bounces-249573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:24:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D66357E9CD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D4B0301F372
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683914B8DD4;
	Tue, 19 May 2026 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC03JEtE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA673F4DD5;
	Tue, 19 May 2026 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193480; cv=none; b=XDF3aysqIwKCY0rAAB2c1LR8GVYobUFhggD7K7In0yIsQ2r4eJL3l0amj67fFEVLG31PQ9928joHsAd/OSEdk5cSD0jdC8cDqgnsj0e+stXuT90ev72ZxLfrnBWfRqTMsvMpUcA+3lxhmxqV+aeQxK4vBBFusW4jHcsmDDKoBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193480; c=relaxed/simple;
	bh=U6uqIHy8EE/i1NqW9z07GrDK43NwFSOtpRCXLlkTT/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pX1m8p3jlZGDrMZR4wHG2+z9hjpE5M/1bPg6TLgl0pltbAgvcP4tloSZxW8oDAEQ3t5yRRuR/FzjqBTXhTshsRB64IDqdsbuigtML8o2xmm/zqmv9LUqLTOFw68XBxoiyi56VfGK05lQbOWsTr3mY8Zgce3o4mUiDMZxr24kD0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC03JEtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F81C2BCB8;
	Tue, 19 May 2026 12:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779193479;
	bh=U6uqIHy8EE/i1NqW9z07GrDK43NwFSOtpRCXLlkTT/w=;
	h=From:To:Cc:Subject:Date:From;
	b=LC03JEtE9gEcI9GO3u+nUrkxOlo/J8fohNMiQ1gD6BxQoj9yS9jqTP1nTPMjaa0pW
	 parkjEr0wR7LZJ1m/Wdj0bzf5qavbL7ggPknymbczPk3dyD5gcpkIxxd18nhokPkcN
	 n7LVA7OuX7wJnp6Pt1X8/KlFBsDrmIsfatLHlMncuHdQ6vl4l54zgru3IqnczOob4k
	 GZVSdvX/dI62PuaES0dcOpHufMVixxZOnWG6IS7/3ecxXzBFMsG1nUu5bgyg3Oxxmy
	 +J4PbLyvFB1lgrl112aVA/RY6fvd6B90wEknQRHrRcMfYv3rIaXd7T5HtIiXagkPUK
	 Mn533+Z6ahxuA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] liveupdate: validate session type before performing operation
Date: Tue, 19 May 2026 14:24:26 +0200
Message-ID: <20260519122428.2378446-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249573-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8D66357E9CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

The sessions ioctls are not applicable to all session types. PRESERVE_FD
is only applicable to outgoing sessions. RETRIEVE_FD and FINISH are only
valid for incoming session. Calling a incoming ioctl on an outgoing
session is invalid and can cause file handlers to run into unexpected
errors.

For example, a user can create a (outgoing) session, preserve a memfd,
and then immediately do a retrieve without doing a kexec in between.
This would result in memfd's retrieve handler to run. The handlers
expects to be called from a post-kexec context, and will try to do a
kho_restore_vmalloc() or kho_restore_folio() to try and restore memory.

KHO catches this (thanks to KHO_PAGE_MAGIC) and returns an error, but
since this is considered an internal error and KHO throws out a bunch of
WARN()s.

Associate a type with each ioctl op and validate the type in
luo_session_ioctl() before dispatching the ioctl handler to make sure
the op is being called for the right session type.

Fixes: 16cec0d26521 ("liveupdate: luo_session: add ioctls for file preservation")
Cc: stable@vger.kernel.org
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---

Notes:
    I added LUO_IOCTL_ALL but there is no user in this patch. The type is
    for LIVEUPDATE_SESSION_GET_NAME which is supported for both session
    types. The support for GET_NAME is in next and this patch should go
    through fixes.
    
    Alternatively, we can remove LUO_IOCTL_ALL from this patch and add it to
    the LIVEUPDATE_SESSION_GET_NAME patch in next. But that would need us to
    rebase to an rc that contains this fix.

 kernel/liveupdate/luo_session.c | 36 +++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index a3327a28fc1f..e84218e3cacb 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -295,32 +295,58 @@ union ucmd_buffer {
 	struct liveupdate_session_retrieve_fd retrieve;
 };
 
+/* Type of sessions the ioctl applies to. */
+enum luo_ioctl_type {
+	LUO_IOCTL_INCOMING,
+	LUO_IOCTL_OUTGOING,
+	LUO_IOCTL_ALL,
+};
+
 struct luo_ioctl_op {
 	unsigned int size;
 	unsigned int min_size;
 	unsigned int ioctl_num;
+	enum luo_ioctl_type type;
 	int (*execute)(struct luo_session *session, struct luo_ucmd *ucmd);
 };
 
-#define IOCTL_OP(_ioctl, _fn, _struct, _last)                                  \
+#define IOCTL_OP(_ioctl, _fn, _struct, _last, _type)                           \
 	[_IOC_NR(_ioctl) - LIVEUPDATE_CMD_SESSION_BASE] = {                    \
 		.size = sizeof(_struct) +                                      \
 			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
 					  sizeof(_struct)),                    \
 		.min_size = offsetofend(_struct, _last),                       \
 		.ioctl_num = _ioctl,                                           \
+		.type = _type,                                                 \
 		.execute = _fn,                                                \
 	}
 
 static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
 	IOCTL_OP(LIVEUPDATE_SESSION_FINISH, luo_session_finish,
-		 struct liveupdate_session_finish, reserved),
+		 struct liveupdate_session_finish, reserved, LUO_IOCTL_INCOMING),
 	IOCTL_OP(LIVEUPDATE_SESSION_PRESERVE_FD, luo_session_preserve_fd,
-		 struct liveupdate_session_preserve_fd, token),
+		 struct liveupdate_session_preserve_fd, token, LUO_IOCTL_OUTGOING),
 	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
-		 struct liveupdate_session_retrieve_fd, token),
+		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_INCOMING),
 };
 
+static bool luo_ioctl_type_valid(struct luo_session *session,
+				 const struct luo_ioctl_op *op)
+{
+	switch (op->type) {
+	case LUO_IOCTL_INCOMING:
+		/* Retrieved is only set on incoming sessions */
+		return session->retrieved;
+	case LUO_IOCTL_OUTGOING:
+		return !session->retrieved;
+	case LUO_IOCTL_ALL:
+		return true;
+	}
+
+	/* Catch-all. */
+	return false;
+}
+
 static long luo_session_ioctl(struct file *filep, unsigned int cmd,
 			      unsigned long arg)
 {
@@ -345,6 +371,8 @@ static long luo_session_ioctl(struct file *filep, unsigned int cmd,
 	op = &luo_session_ioctl_ops[nr - LIVEUPDATE_CMD_SESSION_BASE];
 	if (op->ioctl_num != cmd)
 		return -ENOIOCTLCMD;
+	if (!luo_ioctl_type_valid(session, op))
+		return -EINVAL;
 	if (ucmd.user_size < op->min_size)
 		return -EINVAL;
 

base-commit: b1378127003b61930ce30064328640503ad3ef6d
-- 
2.54.0.563.g4f69b47b94-goog


