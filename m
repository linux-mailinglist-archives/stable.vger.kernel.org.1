Return-Path: <stable+bounces-227810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAj/KpNdv2ku3gMAu9opvQ
	(envelope-from <stable+bounces-227810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 04:10:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C06D2E80E3
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 04:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A052301E3DA
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 03:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAB337E306;
	Sun, 22 Mar 2026 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oce8VZSf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBAB37DEA3;
	Sun, 22 Mar 2026 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774148974; cv=none; b=C7eYSEMSvr+xM2G8IIQWOOz1ctp91PBnO8dkYRD9aos0rTtsALd5XDzrDFMY9uNGmtiKCzl3025tK2RCILhHikIi7RQpUVnOu3ovQFRDo8lmKNhM16PAeZDnKnAMhGM8qkvYjVipY9LLhm4ekAu3Jke/X8UmfSvzAyTt/y6vL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774148974; c=relaxed/simple;
	bh=iejwqkXaOG/T7GdgDguaa9GJnn2r+//3Ug9XdJlwwOM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=i534M2IJTlBxJNoA7m3J8AstwE6l1mK6YAqkuO6Sxj7c23P85brJ7NciTxIcjpKHIXhLUjGwMt38nnlIS8RaS4ypjgq0t8j6m39jC1vftp7egUyamBBkbHK0hXBUKTQfnKjVT+xKkgy1G4ARN9jLMRoRoPsx2eh/yV1ZOhxI0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oce8VZSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2165FC2BCB2;
	Sun, 22 Mar 2026 03:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774148974;
	bh=iejwqkXaOG/T7GdgDguaa9GJnn2r+//3Ug9XdJlwwOM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Oce8VZSfV+8BGJbgWQWdnWfxFUMI4xc97Rump7CVb3+tbHF7S9x6LwJsJ1xIJbRf+
	 YAPJxddmfJI3hjH/dCvdMH247UTkbX+Vi0wFzCcqfhpqlwGEby44PnSdlunRE+9p3C
	 p3x0EgHb8VbWvPZMVOzGEHTbxjqQErrwR5lMkvo93jSRAAl0azXrjAS32vDK6R0/UW
	 /mo86fm879q2YJVDNTJOqknwhF8S+F+eXTEl5EvOrfsy1gLQf439lpFsnJAvKXt4cw
	 tra1bd4hnmCUfIB8cv7AjVFMk1XpHUOeGZb2BF3jSGMyKeKpECGyMB38CGsFI1Tq48
	 5Ce+WTJqjydAg==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1w49Cc-0000000B7km-2rYj;
	Sat, 21 Mar 2026 23:10:10 -0400
Message-ID: <20260322031010.535986464@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 21 Mar 2026 23:09:58 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Ian Rogers <irogers@google.com>
Subject: [for-linus][PATCH 4/5] ring-buffer: Fix to update per-subbuf entries of persistent ring
 buffer
References: <20260322030954.198361547@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227810-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[efficios.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C06D2E80E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Since the validation loop in rb_meta_validate_events() updates the same
cpu_buffer->head_page->entries, the other subbuf entries are not updated.
Fix to use head_page to update the entries field, since it is the cursor
in this loop.

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ian Rogers <irogers@google.com>
Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
Link: https://patch.msgid.link/177391153882.193994.17158784065013676533.stgit@mhiramat.tok.corp.google.com
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 17d0ea0cc3e6..170170bd83bd 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2053,7 +2053,7 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 
 		entries += ret;
 		entry_bytes += local_read(&head_page->page->commit);
-		local_set(&cpu_buffer->head_page->entries, ret);
+		local_set(&head_page->entries, ret);
 
 		if (head_page == cpu_buffer->commit_page)
 			break;
-- 
2.51.0



