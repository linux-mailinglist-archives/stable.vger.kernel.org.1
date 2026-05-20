Return-Path: <stable+bounces-250192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODUcMGPoDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:59:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE079592C05
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B55CA32025E2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D9370D43;
	Wed, 20 May 2026 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uWn/H62E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A62BE02A;
	Wed, 20 May 2026 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294786; cv=none; b=U0iCP3MUVl4W1+Ls9Vpe9Ux0Es5h37CtlPwBsBOALAGacGN/1h2/EjLQhmQp/cvRf9+fWncD1gUziI54Rmnf1LVMOUZBj2gK4qvFUjxWTIGnjqW+ihnOqRGh7lCx7ClUjKBP2Ribiop8rzxq1kE9JqWKQG+lFbOjTtqZiRy+Cbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294786; c=relaxed/simple;
	bh=X+SOnrVgkrH6izXsVbOE63MvZzaYhMGy0XmPDq1E84I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwO/HIi4j7Gce/Vxw+i+1GTuwWvvlB3nT1JiNLFBdsRkhgv4ASVZxjRIsvfSi9vKdw0nFBRgSCFWKTCY74PzlHWNJ2X9PrR2ETEUQ42OCGt2NLuPuI6CFxddVsPtVNuYp0HWh0mLlyh2I4bRLQjmhTgj0Nyq2qr9KH9Yb6J8Vq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uWn/H62E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E8E1F000E9;
	Wed, 20 May 2026 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294784;
	bh=Myzlm5m7UybRV0YKv5Pi6oUlZ2OTYyXMZ3eRZRk1WnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uWn/H62EW/bOY4XInkFrn4uth/Ws3TfYxikmlQb3ki10wQxJJ8JEFZfV0hjxP1J3d
	 bODoJ1OjJIQJbSPvNd/EOMxUiaspqEfNmJFgEjljUR9o5elzUd9U9+bAStG9N/0Pie
	 bV+RQQZH/mh2zaDJ6fk9EGoIRNWz3mTBCKeZWmWY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0131/1146] bpf: Fix refcount check in check_struct_ops_btf_id()
Date: Wed, 20 May 2026 18:06:21 +0200
Message-ID: <20260520162151.290315836@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,inria.fr,etsalapatis.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-250192-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,etsalapatis.com:email]
X-Rspamd-Queue-Id: BE079592C05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keisuke Nishimura <keisuke.nishimura@inria.fr>

[ Upstream commit 25e3e1f1096089a64901ae1faa7b7b13446653db ]

The current implementation only checks whether the first argument is
refcounted. Fix this by iterating over all arguments.

Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Fixes: 38f1e66abd184 ("bpf: Do not allow tail call in strcut_ops program with __ref argument")
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Amery Hung <ameryhung@gmail.com>
Link: https://lore.kernel.org/r/20260320130219.63711-1-keisuke.nishimura@inria.fr
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e3814152b52f8..23b35605ae377 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24897,7 +24897,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	for (i = 0; i < st_ops_desc->arg_info[member_idx].cnt; i++) {
-		if (st_ops_desc->arg_info[member_idx].info->refcounted) {
+		if (st_ops_desc->arg_info[member_idx].info[i].refcounted) {
 			has_refcounted_arg = true;
 			break;
 		}
-- 
2.53.0




