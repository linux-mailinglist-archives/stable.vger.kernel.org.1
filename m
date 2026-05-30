Return-Path: <stable+bounces-257754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME99CPgeG2qu/QgAu9opvQ
	(envelope-from <stable+bounces-257754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:31:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B083260FD81
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DBFD3025F55
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213A4344DA4;
	Sat, 30 May 2026 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rRD3B9f0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38572FDC5E;
	Sat, 30 May 2026 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162059; cv=none; b=RANIySDwwUMIL5qyKM9gxhgYfnI6XbNl/Xhxe+Cp783VSAYFLsOToBDhu/qWrMfgCtxl0wNJCoh1H1q7liC31hfYJ3VHcu+yioQzfr95yoIygUmBTEf8ErbWhpleFxEPT1IlmSUyNfT/NV1PsZe8xPMa7nK2ip3ZKMzBkLdfcK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162059; c=relaxed/simple;
	bh=DIUYJpGmoyZYpuAis+a0dT8VwrFbNctps0/ceM0xvVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2lYh8a1M2tl53LQOmccPMf4xf7dE5MA89xyyummsLrjwqqibxP1UNyDUW3Qw6Cm04XKfmSExCP1jEYE11hDgBspmryW3ujxMUyRnxRT0A6wQ/0kqYVnuDsjHUQTQ8M8COzpUKlKxDKzTetXkkd4aUqyLSjCVFsdBut+e5GDgXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rRD3B9f0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2102B1F00893;
	Sat, 30 May 2026 17:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162058;
	bh=psHJuOIYKpx1ZUqNy1GbMAWSGybiX0axJeYLjTBxgcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rRD3B9f0DQag77cyGcKjGXvmuBr1pEzqqjuRPFdhMojDzJkAoppL+D/UwoSA3f460
	 ltYPSw2phmPUCSH6igvizIgJAD+WcaeVk6teKSwgGm8Hr6X7bfFZLMX3rGXYeHYS2T
	 qpV/n58gUStk4NxZ8m+nCKSMoe414s7f6jeW+i0g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Xiasong <lixiasong1@huawei.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 6.1 809/969] netfilter: nft_ct: fix missing expect put in obj eval
Date: Sat, 30 May 2026 18:05:33 +0200
Message-ID: <20260530160322.974363204@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257754-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B083260FD81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Xiasong <lixiasong1@huawei.com>

commit 19f94b6fee75b3ef7fbc06f3745b9a771a8a19a4 upstream.

nft_ct_expect_obj_eval() allocates an expectation and may call
nf_ct_expect_related(), but never drops its local reference.

Add nf_ct_expect_put(exp) before return to balance allocation.

Fixes: 857b46027d6f ("netfilter: nft_ct: add ct expectations support")
Cc: stable@vger.kernel.org
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_ct.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1346,6 +1346,8 @@ static void nft_ct_expect_obj_eval(struc
 
 	if (nf_ct_expect_related(exp, 0) != 0)
 		regs->verdict.code = NF_DROP;
+
+	nf_ct_expect_put(exp);
 }
 
 static const struct nla_policy nft_ct_expect_policy[NFTA_CT_EXPECT_MAX + 1] = {



