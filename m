Return-Path: <stable+bounces-257736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIrVNTkeG2qu/QgAu9opvQ
	(envelope-from <stable+bounces-257736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:28:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD0D60FBD4
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99426300AD98
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45E633F5A0;
	Sat, 30 May 2026 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bxsu0aaP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD88433E36A;
	Sat, 30 May 2026 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161999; cv=none; b=YZSE3o5ohh1Dd/xRtZOdgImWtRio/yKBcF0heVYbtX1cDudMaXNbeMnepBOeihkK0VEGJnewZ7Gr1cvvu9irctSwfpArA1SF3T6h5kzWekwVMILnKRvxgpgbfRvb9t1LZ7OCgNuHCDpCjOzmHsbCfW50OMu1CxrwQWhiTw6YYJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161999; c=relaxed/simple;
	bh=6zAfUUYNgh2bHMfMamlo+zPAoTTJiGFa1A8HQWF4sso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwGn7tqCdQqU2oKwM18TJkWHhcAd+Yb/G9A4zBo5ENEnDC2iQ1RzfdclkcY4Cb2anvRmNjJ6YRzFdZAy8z5+m6REM/a0VEIacQXYzj/lfoQRoFVjas7HTSaoeAvqo6isLU8OhV3GuvD5wZBqxULRFU5O5oIAo6tat052VQmCFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bxsu0aaP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C301F00893;
	Sat, 30 May 2026 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161998;
	bh=NUW4GcmUryAl6yg06dmw7b29xagW5IDaKwRwCDYlgq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bxsu0aaPDnCnBj2C253l4rYkCKrPr4UR2zqnMxesA1d8nhTqMNjSqENylmtoQN2Uw
	 Z6AbLf3wlhZIEYs/3skYXdy+1+TUu/X/y9oxBWAei2AS1k4qQ8Ze29iReFVWjxqGOD
	 ZybJkV/NJJrwV7N6iTmXs22gTZct/mrvnAew24bk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 790/969] net/sched: cls_flower: revert unintended changes
Date: Sat, 30 May 2026 18:05:14 +0200
Message-ID: <20260530160322.427063353@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257736-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,codeconstruct.com.au:email]
X-Rspamd-Queue-Id: EDD0D60FBD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 1e01abec856593e02cd69fd95b784c10dd46880c ]

While applying the blamed commit 4ca07b9239bd ("net: mctp i2c: check
length before marking flow active"), I unintentionally included
unrelated and unacceptable changes.

Revert them.

Fixes: 4ca07b9239bd ("net: mctp i2c: check length before marking flow active")
Reported-by: Jeremy Kerr <jk@codeconstruct.com.au>
Closes: https://lore.kernel.org/netdev/bd8704fe0bd53e278add5cde4873256656623e2e.camel@codeconstruct.com.au/
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Link: https://patch.msgid.link/043026a53ff84da88b17648c4b0d17f0331749cb.1777447863.git.pabeni@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_flower.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index fd8c2f0f3256e..a40a9e84c75f4 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -537,7 +537,6 @@ static int __fl_delete(struct tcf_proto *tp, struct cls_fl_filter *f,
 		       struct netlink_ext_ack *extack)
 {
 	struct cls_fl_head *head = fl_head_dereference(tp);
-	struct fl_flow_mask *mask;
 
 	*last = false;
 
@@ -554,12 +553,11 @@ static int __fl_delete(struct tcf_proto *tp, struct cls_fl_filter *f,
 	list_del_rcu(&f->list);
 	spin_unlock(&tp->lock);
 
-	mask = f->mask;
+	*last = fl_mask_put(head, f->mask);
 	if (!tc_skip_hw(f->flags))
 		fl_hw_destroy_filter(tp, f, rtnl_held, extack);
 	tcf_unbind_filter(tp, &f->res);
 	__fl_put(f);
-	*last = fl_mask_put(head, mask);
 
 	return 0;
 }
-- 
2.53.0




