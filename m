Return-Path: <stable+bounces-234325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHYXGd+e1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:30:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B26343C0D97
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B33533074A0A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A03D905D;
	Wed,  8 Apr 2026 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cmvErksW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE603D9053;
	Wed,  8 Apr 2026 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672566; cv=none; b=S6zTQZm6FmYSCAP4Z3PwSipW/DsTO2xBz4hJ3S/ATwTX6C7HCsc/fHWLCJ4s577RzzVJQtCQiSRXOKnbnjeC6PdZrRMIbxepXOoVXcqhEOBlADHjrwjbef3XC+qqPMyzV2bReH5jIIZLPSUQ496xtIENyG+ZP0cw6rl6VaJkveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672566; c=relaxed/simple;
	bh=mlddO7CZYYYWTz76MIjrkD7YA5BdrXNszloB0UNiZTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSqajwY4QQvRhjGvck4uGHSJmUcduQ5I+5FB6ATxrmCP0ewzrFWI5SIQ4vE82q5+A9/X/h22Mz6C7pDxRIVqNE1qEfo+B6rRC8jlN8RYa3mSz7HjAkTFrdrlr4F68S5x8j7/dOHel72sOEnTZGzpBJ72j3pJwg4nxNYuSZg5u78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cmvErksW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21435C19421;
	Wed,  8 Apr 2026 18:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672566;
	bh=mlddO7CZYYYWTz76MIjrkD7YA5BdrXNszloB0UNiZTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cmvErksWglwXW37h2BL5jaWCNIb+clpUSSmxfl9D8pE3XnwYi/51Gcw4nHcSa+la8
	 8RD8lKACizpKmjoPkL2L5ytMyU1dVh905qkZ0HuU8/XAAxE5D7OjlRjNpvEbpM57I4
	 s0d+AkVcbDWof3wbaoaG6uh6Q8whmQiba9xqrabo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yochai Eisenrich <echelonh@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 029/160] net: sched: cls_api: fix tc_chain_fill_node to initialize tcm_info to zero to prevent an info-leak
Date: Wed,  8 Apr 2026 20:01:56 +0200
Message-ID: <20260408175914.297422782@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,mojatatu.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-234325-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: B26343C0D97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yochai Eisenrich <echelonh@gmail.com>

[ Upstream commit e6e3eb5ee89ac4c163d46429391c889a1bb5e404 ]

When building netlink messages, tc_chain_fill_node() never initializes
the tcm_info field of struct tcmsg. Since the allocation is not zeroed,
kernel heap memory is leaked to userspace through this 4-byte field.

The fix simply zeroes tcm_info alongside the other fields that are
already initialized.

Fixes: 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
Signed-off-by: Yochai Eisenrich <echelonh@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260328211436.1010152-1-echelonh@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a90a7b01f3f36..45124fd64d6b4 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2886,6 +2886,7 @@ static int tc_chain_fill_node(const struct tcf_proto_ops *tmplt_ops,
 	tcm->tcm__pad1 = 0;
 	tcm->tcm__pad2 = 0;
 	tcm->tcm_handle = 0;
+	tcm->tcm_info = 0;
 	if (block->q) {
 		tcm->tcm_ifindex = qdisc_dev(block->q)->ifindex;
 		tcm->tcm_parent = block->q->handle;
-- 
2.53.0




