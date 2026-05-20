Return-Path: <stable+bounces-253065-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHzGLtIaDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-253065-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:34:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB135599CA2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58BD232F9E3D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6B3CB2F8;
	Wed, 20 May 2026 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ASZMgUBH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65CDF59;
	Wed, 20 May 2026 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302312; cv=none; b=fv7uWB8I4t/Qj7Z5Ag7fNxkzR+1NmHd3GAnuaiqfk2T3HYhuidLPcxDIwagUCHBHsF0P8QOFHwIyiCj9diHJEfQIEq3JWLgddPpeNQq+0dhTTOnLTFIdUmJMoRvYEbF2TFDeI781+0a+9lHIE8Vm6kD7Y0Vg8BIL3llDZhp7pTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302312; c=relaxed/simple;
	bh=xtHawHFTHO6Q8aMeicIF+R+RJbLSwAk9MqSG0mK/7Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJPQKVjyOruT7Z/WrFEEx4fKBlVV1NABKoasiQAvAZhQ6gX9Zwe0LwHREiNpjGba4PArag/8Rhp1doZACUPk5ltcxnBnCVoUsv8XyVbCOo+8Rw47opiSldhi1iQ3B0fynlasxmuCK6V0yEWQIDEgKxyGoVM2mHHqpMysx6Cw7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ASZMgUBH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013D41F000E9;
	Wed, 20 May 2026 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302311;
	bh=M8jhjWHgmwbGmcwrOi0FIbnWG2w+pW7lAE1dTUVa1MI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ASZMgUBH5v4DMvPa1yzBVtz4IRaoKayOgc1N5nwAYGfdP5ij0Wc4Zs4lx2rigR6hT
	 eSRJjKWv9F8oMyC9LX7Ew7YOHy7xmgooquojQecXHHoD6e+e9Cfq9W3dPgQKs4Jqvv
	 DTubRaFfZNsy61Ld/OakmKbJHUsk6hge4rFmsoXA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tom Zanussi <zanussi@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 220/508] tracing: Rebuild full_name on each hist_field_name() call
Date: Wed, 20 May 2026 18:20:43 +0200
Message-ID: <20260520162103.407637260@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253065-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,goodmis.org:email,iscas.ac.cn:email]
X-Rspamd-Queue-Id: BB135599CA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

[ Upstream commit 5ec1d1e97de134beed3a5b08235a60fc1c51af96 ]

hist_field_name() uses a static MAX_FILTER_STR_VAL buffer for fully
qualified variable-reference names, but it currently appends into that
buffer with strcat() without rebuilding it first. As a result, repeated
calls append a new "system.event.field" name onto the previous one,
which can eventually run past the end of full_name.

Build the name with snprintf() on each call and return NULL if the fully
qualified name does not fit in MAX_FILTER_STR_VAL.

Link: https://patch.msgid.link/20260401112224.85582-1-pengpeng@iscas.ac.cn
Fixes: 067fe038e70f ("tracing: Add variable reference handling to hist triggers")
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 19b3d388fbc69..597f47397c726 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1349,12 +1349,14 @@ static const char *hist_field_name(struct hist_field *field,
 		 field->flags & HIST_FIELD_FL_VAR_REF) {
 		if (field->system) {
 			static char full_name[MAX_FILTER_STR_VAL];
+			int len;
+
+			len = snprintf(full_name, sizeof(full_name), "%s.%s.%s",
+				       field->system, field->event_name,
+				       field->name);
+			if (len >= sizeof(full_name))
+				return NULL;
 
-			strcat(full_name, field->system);
-			strcat(full_name, ".");
-			strcat(full_name, field->event_name);
-			strcat(full_name, ".");
-			strcat(full_name, field->name);
 			field_name = full_name;
 		} else
 			field_name = field->name;
-- 
2.53.0




