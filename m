Return-Path: <stable+bounces-253638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJMKDUpvD2oDMQYAu9opvQ
	(envelope-from <stable+bounces-253638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 22:47:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3793A5ABE3C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 22:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE7DA3010808
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC39426D0E;
	Thu, 21 May 2026 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohAJGhM2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8CB396565;
	Thu, 21 May 2026 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779396410; cv=none; b=lxYHPe6QHbMe7zPYeTnDwFHNYu/mDHfwukW94Y6/2GxU14x4zR6HoOfJYxKVf2e8sZCRox0EeW6zbcPKcTJJoMv9rLstnKWCjiyIMyA9atfjJg2BUdow9nNsv6FfY6aGS83ljq1PV7CkMMvDVY6hl3Js/Tzzqr2QCUmy1nx5BaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779396410; c=relaxed/simple;
	bh=BWAc4z9O6RQUVrcaeEWmRg1cPqtAnCbya2f3Gm0Ns2Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZJ5jQACsQGvKgcBrvC0ZQwm0w3tknNGiFqBllj7DRe/Rlnbj/phWdqZIft/VIKkJVny0JD3hKVpkpT2gt1EbysA4MWUlk8LPBjClqSq0/3KmOy1bQfFhAzirJTY1pUwjieWO6v2NdznskCZheE1a+4zYce5SvTK5tdxLd5hsa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohAJGhM2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22A81F00A3D;
	Thu, 21 May 2026 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779396408;
	bh=3HerJI1+kkKx/hU7yzolHTbS2Y2cm4QjTTNEzsoC4I0=;
	h=Date:From:To:Cc:Subject:References;
	b=ohAJGhM2jiz/AiQoWVk+VpSEVvD0ecfhpLMraMi94wMFRYvfTPGQJZiNJr0Za/CF8
	 GkRVip9QTaEwMDdzSc+Al2nhR3Yswv2zZzUvf+b7t86d9neRUHnQ26fqbSYhScldT6
	 RQHJq1cQrq9FH7vETMQjEwnZk7VW3eg8rwdFI/XPZLv//YQepdg5eaw5stxU8xXwWa
	 s/9XxUYqCM89FMwQY8clbJMlpYRbjYdpGdDQgZJ20dIU6XtkGp0CucWAKmmYtY/Liw
	 tp+5ymF377SUM1qgUn6qcp1i7ETivbqiYp0peTmTxUCL1ODcAiZ3eTOgJF6m21MQTt
	 8zDuEm34s2+sA==
Received: from rostedt by gandalf with local (Exim 4.99.2)
	(envelope-from <rostedt@kernel.org>)
	id 1wQAIQ-00000005boF-3eR0;
	Thu, 21 May 2026 16:47:10 -0400
Message-ID: <20260521204710.725769391@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 21 May 2026 16:45:29 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Tom Zanussi <tom.zanussi@linux.intel.com>,
 Rosen Penev <rosenp@gmail.com>,
 Sashiko <sashiko-bot@kernel.org>
Subject: [for-linus][PATCH 2/2] tracing: Do not call map->ops->elt_free() if elt_alloc() fails
References: <20260521204527.100913207@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,efficios.com,linux-foundation.org,vger.kernel.org,linux.intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253638-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sashiko.dev:url,goodmis.org:email,efficios.com:email]
X-Rspamd-Queue-Id: 3793A5ABE3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

In paths where tracing_map_elt_alloc() failed to allocate objects,
the map->ops->elt_alloc() call was never successful. In this case,
map->ops->elt_free() should not be called.

Link: https://sashiko.dev/#/patchset/20260520223101.34710-1-rosenp%40gmail.com

Cc: stable@vger.kernel.org
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Rosen Penev <rosenp@gmail.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 2734b629525a ("tracing: Add per-element variable support to tracing_map")
Link: https://patch.msgid.link/177933895460.108746.5396070821443932634.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/tracing_map.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index bf1a507695b6..0dd7927df22a 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -386,13 +386,11 @@ static void tracing_map_elt_init_fields(struct tracing_map_elt *elt)
 	}
 }
 
-static void tracing_map_elt_free(struct tracing_map_elt *elt)
+static void __tracing_map_elt_free(struct tracing_map_elt *elt)
 {
 	if (!elt)
 		return;
 
-	if (elt->map->ops && elt->map->ops->elt_free)
-		elt->map->ops->elt_free(elt);
 	kfree(elt->fields);
 	kfree(elt->vars);
 	kfree(elt->var_set);
@@ -400,6 +398,17 @@ static void tracing_map_elt_free(struct tracing_map_elt *elt)
 	kfree(elt);
 }
 
+static void tracing_map_elt_free(struct tracing_map_elt *elt)
+{
+	if (!elt)
+		return;
+
+	/* Only objects initialized with alloc_elt() should be passed to free_elt().*/
+	if (elt->map->ops && elt->map->ops->elt_free)
+		elt->map->ops->elt_free(elt);
+	__tracing_map_elt_free(elt);
+}
+
 static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing_map *map)
 {
 	struct tracing_map_elt *elt;
@@ -444,7 +453,7 @@ static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing_map *map)
 	}
 	return elt;
  free:
-	tracing_map_elt_free(elt);
+	__tracing_map_elt_free(elt);
 
 	return ERR_PTR(err);
 }
-- 
2.53.0



