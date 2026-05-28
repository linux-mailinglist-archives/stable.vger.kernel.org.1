Return-Path: <stable+bounces-255515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H7ENeqhGGqvlggAu9opvQ
	(envelope-from <stable+bounces-255515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:13:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F20B85F81A4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5C143048222
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DBA402B8F;
	Thu, 28 May 2026 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EN+hs9w0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C4339866;
	Thu, 28 May 2026 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999129; cv=none; b=eIqdEzHcyHf2GBsTFsL+VhI15Wa0eBDXTaUg7wJtafBWkK3vhcO6/RMw+CvvNAsqqN7XGA6NBGxI/sFP0E01xzOFwYCH+fJvh5S0gDWVjpBQT3aOrer9uPwvbMW9ztRA9UaigiHOSZRiUb5lR6XeaXBbu3jvbMHBAH/Uffp4czg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999129; c=relaxed/simple;
	bh=Mow8uktnYdVI6sBhg5sybT9x0Sw0oBoyENcxlujXf2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcCiXoxSnjq8/oIYZRrfw3oLaqQJ4YswehTO6hpJ0zPMg9BiXzs/hrIJ9BqBCggToe2IbiF8a4g1DANislI3oB1C9o0Fo7jViFXx2NV8heMWD3jiymPsdn9sm42wY1QpdFeBmz8URW6X/WHR3uDo+LQqr8nAzc5NSCCfCEooP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EN+hs9w0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9288A1F000E9;
	Thu, 28 May 2026 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999127;
	bh=ZKUkKXWF7t53Va3R97MF+ygFiUrD672QlhaOIuxZQO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EN+hs9w0VbfShHCCIELqwkvy/bU7bIVzdgUSmQdSJLabFfHn/bKEjEayZQrEiChLM
	 bhIBpO6RxjQoK53ZFyacwT3LrcwB8D/Zmi5sQ7236fiOZ6Cg5dYwprFYlPmLh6/Oiq
	 iQsy7+ZYbyRG5S8LxIyHBKHk+WUO00TzvJtn9SQM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 418/461] tracing: Avoid NULL return from hist_field_name() on truncation
Date: Thu, 28 May 2026 21:49:07 +0200
Message-ID: <20260528194659.598268342@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255515-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,goodmis.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,goodmis.org:email]
X-Rspamd-Queue-Id: F20B85F81A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 576ec047d20b368b43c4d5db98c4f2e0f3c101ec ]

hist_field_name() returns "" everywhere except the fully-qualified
VAR_REF/EXPR case, where snprintf() truncation returns NULL early
and bypasses the bottom NULL->"" guard. Callers don't expect NULL:
strcat(expr, hist_field_name(field, 0)) at trace_events_hist.c:1758
and the strcmp() in the sort-key match loop at :4804 both deref it.

system and event_name are bounded by MAX_EVENT_NAME_LEN, but the
field name on a VAR_REF is kstrdup'd from a histogram variable
name parsed out of the trigger string and has no length cap, so
a long enough var name in a fully qualified reference can reach
the truncation path.

Keep the length check but leave field_name as "" on overflow.

Link: https://patch.msgid.link/20260508195747.25492-1-devnexen@gmail.com
Fixes: 5ec1d1e97de1 ("tracing: Rebuild full_name on each hist_field_name() call")
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f9c8a4f078ea0..f8c0e66cc5871 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1366,10 +1366,8 @@ static const char *hist_field_name(struct hist_field *field,
 			len = snprintf(full_name, sizeof(full_name), "%s.%s.%s",
 				       field->system, field->event_name,
 				       field->name);
-			if (len >= sizeof(full_name))
-				return NULL;
-
-			field_name = full_name;
+			if (len < sizeof(full_name))
+				field_name = full_name;
 		} else
 			field_name = field->name;
 	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
-- 
2.53.0




