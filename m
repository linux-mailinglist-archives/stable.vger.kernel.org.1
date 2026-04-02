Return-Path: <stable+bounces-233102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH/INJHDzmmqpwYAu9opvQ
	(envelope-from <stable+bounces-233102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 21:29:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 380EC38DAC8
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 21:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 213AD3024507
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 19:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4301E36CE02;
	Thu,  2 Apr 2026 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jKZkAH1x"
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80A34A795
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157981; cv=none; b=ZHFIJOKJ8/y0uF+4Uqy3/HezuC+2QeqVcp6AoG/dqb5wpqxSgOMdPwP6RsvRLV1ceGQ/OPC9al/EVkHdRImUssb2l+Q8g7V7nPScVeSBHw6Sc6S6NpAkWcoRBxLYMpYdKFhZRd87b9WwSMtzfTVKAnjl/MkZdNoi4/y7JR+fHMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157981; c=relaxed/simple;
	bh=ZLPFmzVxTeoO3UlZmgJPRYil3LGxf2tKed38PwRRnzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLR4nM8Pvcy62VKqkHe94eE8jjS4rz7XQWTiyNxMAeJ/1KBVS2OpdDzs2komhFuVOurZNoueHHJ3J5Lp+Qaatx2J1tMfCE/jrc8qZFZJzcpA4WtBMVT4wZoDalN37jJ3dH6wLsUKx1nXWf1UjtEG4eXDDwRrJ/HtOumDWcYeRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jKZkAH1x; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fmsKN2Q5KzJvr;
	Thu,  2 Apr 2026 21:26:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775157976;
	bh=0gLvNpHE+Gf58oSodBBF5EKIn7dLRrInQCSTksiP2hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKZkAH1xjaMPNuC/gZe5yutRyNaT6XZjqdl89DePO1liCCtLhdmcFDiaqjH2joRia
	 elm4SHvKvID5HCvqOQVAQi7WJXJ2SKzcLefd5bfW2BQJ3aHK1vcxTcUmOAaLYA8bwe
	 prhajC7NvzUlyiLSesEmnyiP60GxsQtfXT4blt08=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fmsKM6pzTzDMt;
	Thu,  2 Apr 2026 21:26:15 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/5] selftests/landlock: Fix socket file descriptor leaks in audit helpers
Date: Thu,  2 Apr 2026 21:26:03 +0200
Message-ID: <20260402192608.1458252-3-mic@digikod.net>
In-Reply-To: <20260402192608.1458252-1-mic@digikod.net>
References: <20260402192608.1458252-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.07 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.59)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[digikod.net,vger.kernel.org,gmail.com,maowtm.org];
	TAGGED_FROM(0.00)[bounces-233102-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,digikod.net:dkim,digikod.net:email,digikod.net:mid]
X-Rspamd-Queue-Id: 380EC38DAC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

audit_init() opens a netlink socket and configures it, but leaks the
file descriptor if audit_set_status() or setsockopt() fails.  Fix this
by jumping to an error path that closes the socket before returning.

Apply the same fix to audit_init_with_exe_filter(), which leaks the file
descriptor from audit_init() if audit_init_filter_exe() or
audit_filter_exe() fails, and to audit_cleanup(), which leaks it if
audit_init_filter_exe() fails in FIXTURE_TEARDOWN_PARENT().

Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
- New patch (split from the drain fix, extended to
  audit_init_with_exe_filter() and audit_cleanup()).
---
 tools/testing/selftests/landlock/audit.h | 26 +++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 1049a0582af5..6422943fc69e 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -379,19 +379,25 @@ static int audit_init(void)
 
 	err = audit_set_status(fd, AUDIT_STATUS_ENABLED, 1);
 	if (err)
-		return err;
+		goto err_close;
 
 	err = audit_set_status(fd, AUDIT_STATUS_PID, getpid());
 	if (err)
-		return err;
+		goto err_close;
 
 	/* Sets a timeout for negative tests. */
 	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
 			 sizeof(audit_tv_default));
-	if (err)
-		return -errno;
+	if (err) {
+		err = -errno;
+		goto err_close;
+	}
 
 	return fd;
+
+err_close:
+	close(fd);
+	return err;
 }
 
 static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
@@ -441,8 +447,10 @@ static int audit_cleanup(int audit_fd, struct audit_filter *filter)
 
 		filter = &new_filter;
 		err = audit_init_filter_exe(filter, NULL);
-		if (err)
+		if (err) {
+			close(audit_fd);
 			return err;
+		}
 	}
 
 	/* Filters might not be in place. */
@@ -468,11 +476,15 @@ static int audit_init_with_exe_filter(struct audit_filter *filter)
 
 	err = audit_init_filter_exe(filter, NULL);
 	if (err)
-		return err;
+		goto err_close;
 
 	err = audit_filter_exe(fd, filter, AUDIT_ADD_RULE);
 	if (err)
-		return err;
+		goto err_close;
 
 	return fd;
+
+err_close:
+	close(fd);
+	return err;
 }
-- 
2.53.0


