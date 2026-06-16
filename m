Return-Path: <stable+bounces-263910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SHDrC8FqMWpMiwUAu9opvQ
	(envelope-from <stable+bounces-263910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:24:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB71E690FFF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:24:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=AvCzLFqy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263910-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263910-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7E05312E886
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0588F43DA2C;
	Tue, 16 Jun 2026 15:18:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD33E43C05C;
	Tue, 16 Jun 2026 15:18:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623120; cv=none; b=suwdsTSc5NHOXzrPhT2rXaDXwEk5WvSdNO6l8FZ+pPoWcIF37eDL7Avpyj66yFGLRNzE9p9Ftu+2SwXaBF/tNJc+duVS6KharzQyEFXvbNpwDTPfQs/+mB3/XGjBgYjq6OaiMR5qGyUv5FyIIjIcQMQaC0XhOH29FeEALQfRNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623120; c=relaxed/simple;
	bh=Aqi3UFgj1bIhPbhnYjIOzOG1uZtLp8iajTSNNl3q+Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4NarFyS51u+TdufABILzsLqVkKYSekfdLN0T4F0bQh+s3uk++LJCaDLiyroqHwhIdbEQpKrtqMMdV5Ofw7udAIccyBLtellxiMwr0KFp9rh65kVsWPWj2xsS9KDsjeZqR0B4uuIQN9gsWXP8odX6lvbV5VNtTFGgy14mNNg7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AvCzLFqy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD481F000E9;
	Tue, 16 Jun 2026 15:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623119;
	bh=+Lkh6DoC/NNzCzvzZGsdbVkbM5eq6kpknuGJ9fa76nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AvCzLFqyV6lCKxwO2V7SjQXUx+Vl/32fBTxA7FIYBZvpd9julFRRcOcAtyNvcbCGh
	 9ibYda8lxAN5U1IAnt660M3Xnx6X+nK/flIw2I2RIaCl95FwCKCDEXVORaZYN8gdCp
	 2mmSUpEjTbahLbtQDnn1ZZ6eRZ6RcfPaIRb+mLuc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 091/378] tools/rv: Fix substring match bug in monitor name search
Date: Tue, 16 Jun 2026 20:25:22 +0530
Message-ID: <20260616145115.061161460@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263910-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:namcao@linutronix.de,m:gmonaco@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB71E690FFF

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriele Monaco <gmonaco@redhat.com>

[ Upstream commit a963fbf3166f2e178ac38b6c3c186a0c98092fb9 ]

__ikm_find_monitor_name() relies on strstr() to find a monitor by name,
which fails if the target monitor is a substring of a previously listed
monitor.

Fix it by tokenizing the available_monitors file and matching full
tokens instead.

Fixes: eba321a16fc6 ("tools/rv: Add support for nested monitors")
Reviewed-by: Nam Cao <namcao@linutronix.de>
Link: https://lore.kernel.org/r/20260514152055.229162-2-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/verification/rv/src/in_kernel.c | 48 ++++++++++++++-------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index d324538249d3ab..95eac9ab148468 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -58,38 +58,40 @@ static int __ikm_read_enable(char *monitor_name)
  */
 static int __ikm_find_monitor_name(char *monitor_name, char *out_name)
 {
-	char *available_monitors, container[MAX_DA_NAME_LEN+1], *cursor, *end;
-	int retval = 1;
+	char *available_monitors, *cursor, *line;
+	int len = strlen(monitor_name);
+	int found = 0;
 
 	available_monitors = tracefs_instance_file_read(NULL, "rv/available_monitors", NULL);
 	if (!available_monitors)
 		return -1;
 
-	cursor = strstr(available_monitors, monitor_name);
-	if (!cursor) {
-		retval = 0;
-		goto out_free;
-	}
+	config_is_container = 0;
+	cursor = available_monitors;
+	while ((line = strsep(&cursor, "\n"))) {
+		char *colon = strchr(line, ':');
 
-	for (; cursor > available_monitors; cursor--)
-		if (*(cursor-1) == '\n')
-			break;
-	end = strstr(cursor, "\n");
-	memcpy(out_name, cursor, end-cursor);
-	out_name[end-cursor] = '\0';
-
-	cursor = strstr(out_name, ":");
-	if (cursor)
-		*cursor = '/';
-	else {
-		sprintf(container, "%s:", monitor_name);
-		if (strstr(available_monitors, container))
-			config_is_container = 1;
+		if (strcmp(line, monitor_name) && (!colon || strcmp(colon + 1, monitor_name)))
+			continue;
+
+		strncpy(out_name, line, 2 * MAX_DA_NAME_LEN);
+		out_name[2 * MAX_DA_NAME_LEN - 1] = '\0';
+
+		if (colon) {
+			out_name[colon - line] = '/';
+		} else {
+			/* If there are children, they are on the next line. */
+			line = strsep(&cursor, "\n");
+			if (line && !strncmp(line, monitor_name, len) && line[len] == ':')
+				config_is_container = 1;
+		}
+
+		found = 1;
+		break;
 	}
 
-out_free:
 	free(available_monitors);
-	return retval;
+	return found;
 }
 
 /*
-- 
2.53.0




