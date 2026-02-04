Return-Path: <stable+bounces-214088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIcBN6Vrg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-214088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:54:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BF3E98CF
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3946231D2C17
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325DA41C30E;
	Wed,  4 Feb 2026 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X4PYkt1h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACAF41C30A;
	Wed,  4 Feb 2026 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218523; cv=none; b=GXAxxH8XVwYt/qAex4wIOW3L4io5ePX5/g/yZ2RIAeNjZ8BcO30KF3Epm9yYhR54kF2xL6Ic4viBlg2XgTDUhXi8BQKrgBmBeeRgI3UKqfjJGmQDYYRBtVD6sLfByGWrNWv7u84wT2hEaucd5lY4gZjln4rAsHLd42OTv0q6v6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218523; c=relaxed/simple;
	bh=5uFWj0fTWfZaBnCHvARBhoc0wmO6Piuw9LxrCzf+1Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCtpsXfdzErz5INCe5CIygWXLKikWvrikvqGKGw0a8aCs4PXawvmT5pPMBAClE52Q9kCDcM26M2NpbdrjOaz3w04BI7eGA6RCkOfyxXem21HA/jhtDXdiAug9o/kxSyx2WpYoq8Y0P7Mr1s9qLo+razNyXyCmr1NXhuLYY4FKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X4PYkt1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453A4C2BC9E;
	Wed,  4 Feb 2026 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218522;
	bh=5uFWj0fTWfZaBnCHvARBhoc0wmO6Piuw9LxrCzf+1Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4PYkt1hhqyUcqQx6Vki+YkTWb4viy8MaNUCnEsG2jGJ9kK2WtzNRO7+FEmzWw2pQ
	 X8o074B39axybKvUT98v1YWjz5IK/lTDde1zsADQOWjhV8nperThTLyAQEPgfZof5L
	 zifvrtfpX2hMdFgR8PomjGXLeKtHEd+2iTc5DVhE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 6.6 56/72] net/sched: act_ife: convert comma to semicolon
Date: Wed,  4 Feb 2026 15:40:59 +0100
Message-ID: <20260204143847.664463647@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143845.603454952@linuxfoundation.org>
References: <20260204143845.603454952@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214088-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 12BF3E98CF
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

commit 205305c028ad986d0649b8b100bab6032dcd1bb5 upstream.

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20251112072709.73755-1-nichen@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_ife.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -649,9 +649,9 @@ static int tcf_ife_dump(struct sk_buff *
 
 	memset(&opt, 0, sizeof(opt));
 
-	opt.index = ife->tcf_index,
-	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
-	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
+	opt.index = ife->tcf_index;
+	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref;
+	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind;
 
 	spin_lock_bh(&ife->tcf_lock);
 	opt.action = ife->tcf_action;



