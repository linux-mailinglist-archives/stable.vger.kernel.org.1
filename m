Return-Path: <stable+bounces-218542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJKoI0VTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:41:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD0218F75E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1567312F091
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA76E242D9B;
	Wed, 25 Feb 2026 01:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="esShA4X4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F13B18B0A;
	Wed, 25 Feb 2026 01:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983380; cv=none; b=opS98CgWDRCxJogkBRMHvKlRdY05KlGPRWAc320Gcjq1YI8rtxQMnsrCEtny0RghbEQS92xRm0Pwd0XPHNAqK6UXXkQj4yfyd04gs0fnOD7pQBW4X6ZdkLOnoWnfBKC1BWTR/MuIHOIGbPSXN2SFR2Eo6pMLzqqOmTZa+qaEq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983380; c=relaxed/simple;
	bh=42b7k8eY0+23K/iluDarGj7GVbw4o1UloqtJXnY/49k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cp5ZQWcdGq4IgiOVbaZfrbuhH7TjoQrmipX3JVI3y1+Q8BXnrM28ABXMNyFffibgKvvcdTi/k0DOhYKGRP0LkmnUArakAxHim8v849H7YPO2Be9AzZ+kTJ7exMmxs/zImisZrsS2hBxDAAdchvPcZAV6dpo+FBW/SsvEwttM030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=esShA4X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4282AC116D0;
	Wed, 25 Feb 2026 01:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983380;
	bh=42b7k8eY0+23K/iluDarGj7GVbw4o1UloqtJXnY/49k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=esShA4X4EMmjzk+cDZzRS/jNme9m3+hufKixekqKqiyVj3pu0JVwfkp1T9lMilRqZ
	 6GWraILRrS7m2ae+91P4tAgkLIwswZsYQd8zKH+Vy/FGjfk8ZuhPy2VjUxcDZeZiuU
	 fAlLbJqjOo4PImFa7slNFT4867Hwu+yz9zIoRaY0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 504/781] tracing: Remove duplicate ENABLE_EVENT_STR and DISABLE_EVENT_STR macros
Date: Tue, 24 Feb 2026 17:20:13 -0800
Message-ID: <20260225012412.164777372@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-218542-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CD0218F75E
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 9df0e49c5b9b8d051529be9994e4f92f2d20be6f ]

The macros ENABLE_EVENT_STR and DISABLE_EVENT_STR were added to trace.h so
that more than one file can have access to them, but was never removed
from their original location. Remove the duplicates.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Link: https://patch.msgid.link/20260126130037.4ba201f9@gandalf.local.home
Fixes: d0bad49bb0a09 ("tracing: Add enable_hist/disable_hist triggers")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 137b4d9bb116d..2c6d3e33b9fb4 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3963,11 +3963,6 @@ void trace_put_event_file(struct trace_event_file *file)
 EXPORT_SYMBOL_GPL(trace_put_event_file);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-
-/* Avoid typos */
-#define ENABLE_EVENT_STR	"enable_event"
-#define DISABLE_EVENT_STR	"disable_event"
-
 struct event_probe_data {
 	struct trace_event_file	*file;
 	unsigned long			count;
-- 
2.51.0




