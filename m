Return-Path: <stable+bounces-253307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEB1La4vDmoK7wUAu9opvQ
	(envelope-from <stable+bounces-253307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:03:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 316C159BA89
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9705739B28C8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD6C4028F0;
	Wed, 20 May 2026 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P3D3dfuo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EADC3CB2F8;
	Wed, 20 May 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302938; cv=none; b=oYyK31JrMFpxl/h62x7D5Ke2oDi93BZvF251t99w6Pme87kaOepRdemh58YroNOS8WlxULaVPeck1YQheV7xYwKSC+pmDnHiS51Jo19WBq1aB4hS88Fuy48zJjTgAnrEk7jfnii/D3w5xKY6+d88NPsCXFGHbMKIRFqBYd6981I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302938; c=relaxed/simple;
	bh=eisxQHVxLyUwkbRS3ZVdi9Pwty7RaPp8D4o9rNO6gHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDrBaYCJDUIFbkQkjNCtrIFqo8EaXdY9U6o4Jomd4PKVGjBfq40svuHQ7/InYrDuhizfsK8mf/21UH9KIHqt9dfm+2G9zKhNnLbBSMUodQYWEYyevy9VDVRzqAgbe9v8FhUraHb3+HP5JfiHNDuLliFECdGOT6JXCZsWSEmSIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P3D3dfuo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94E21F00893;
	Wed, 20 May 2026 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302935;
	bh=wj2GFe8n3V+EV2ZSydgc6lHoPUBoREVKyfALr5zHero=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P3D3dfuo3J7wUt9yBANthr7z6TZVfnYfDK/hYHYpLIqXRj2wWSouD3zxhaVfQOkOu
	 DNvbz5ZYSqX1Oy4yB9u9AkBISnU4hmEM8U4Zuv05js79pMINxxF/Lxt1O6c7NXmf7a
	 CM5H70gO35qlWDwnkvrENq6mJUTkkL3peT+Jp2Lw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Xiasong <lixiasong1@huawei.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 6.6 456/508] netfilter: nft_ct: fix missing expect put in obj eval
Date: Wed, 20 May 2026 18:24:39 +0200
Message-ID: <20260520162108.475904064@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253307-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:email]
X-Rspamd-Queue-Id: 316C159BA89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1363,6 +1363,8 @@ static void nft_ct_expect_obj_eval(struc
 
 	if (nf_ct_expect_related(exp, 0) != 0)
 		regs->verdict.code = NF_DROP;
+
+	nf_ct_expect_put(exp);
 }
 
 static const struct nla_policy nft_ct_expect_policy[NFTA_CT_EXPECT_MAX + 1] = {



