Return-Path: <stable+bounces-242599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGg2Gcr29WlvQwIAu9opvQ
	(envelope-from <stable+bounces-242599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 15:06:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C64304B214B
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 15:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C96A3009B3F
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8B37FF7F;
	Sat,  2 May 2026 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuNsSOzC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1F3612E7
	for <stable@vger.kernel.org>; Sat,  2 May 2026 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777727144; cv=none; b=a+vvePC097k6lYtQAl/AzQnvC01xfleaM6leR0O7SLEGPBO5ng7aAOxgUnm/QNLQLqaY27OfLV+NHqDc4L2wGZA7kczY6lHKp0y2+VP+1MAgIidRpr9gr4wGC05+ATNeUaeReCTubKpMU1yqm5CJFzoZ31DOo0kUQXaZNJxsWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777727144; c=relaxed/simple;
	bh=VMDpfJoZaVgOt1SJ9G32enbQAqO7/GXMwaYptEt+9/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ot/PXflRj4bHSRcRSYqQoynujORG6YKCnKxXW2FBZTjRjrVCwYejOSskHh9SxsP2NVs7pU1SWW4H4kdYpheHaVW158mI4B5i/WcDfjjyaxV2bNnsIjdeJRN9kGYAKoA2ZGL3ls/Hl10Chd2rLILCJKVlg8ZdFrHnaMLKMVkQP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuNsSOzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A2FC19425;
	Sat,  2 May 2026 13:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777727144;
	bh=VMDpfJoZaVgOt1SJ9G32enbQAqO7/GXMwaYptEt+9/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GuNsSOzCYiCY5Gephw/LUTgVCIuMXi0mGqYrsOKIxGqQPAoCIBrSPcrNs8xIgunQH
	 AWFiS6VUj9Kdev3Qf8oZiY2Xd1lADmq6Tq1ZTt32r53MIp1orbnPR1A+m7J2OqRzNg
	 cYKflMvhbap1URWBz9I92oLAMSog9EeBZ+khd3rEcuaM8zUYjB0ekc290C+1c/270i
	 4u81ov9YghrMhLc+6cIHiQreGLDG7P/DvOSG0Jx3Oec4X17lkW32Xnmkri16o/h6x6
	 2GQIWMSja5bTEVlhl57TEpYGJVe9QBvJMJclNCj10KlG2KRDVwZLWsZig3wJSXy5rB
	 HI39EFeqBqtZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] selftests/landlock: Fix socket file descriptor leaks in audit helpers
Date: Sat,  2 May 2026 09:05:41 -0400
Message-ID: <20260502130541.590744-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050112-second-frenzied-c947@gregkh>
References: <2026050112-second-frenzied-c947@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C64304B214B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[digikod.net,google.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-242599-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,digikod.net:email]

From: Mickaël Salaün <mic@digikod.net>

[ Upstream commit 9143d790337a0d066c2d632c802f69b981e6c23a ]

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
Reviewed-by: Günther Noack <gnoack3000@gmail.com>
Link: https://lore.kernel.org/r/20260402192608.1458252-3-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/landlock/audit.h | 26 +++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 02fd1393947a7..36a6816b47f13 100644
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


