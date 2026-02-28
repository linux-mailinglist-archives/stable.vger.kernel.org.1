Return-Path: <stable+bounces-220369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF76G8s1o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8D11C6082
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 470E93222714
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8743A351F;
	Sat, 28 Feb 2026 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGIeG1Ml"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F73A3517;
	Sat, 28 Feb 2026 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300265; cv=none; b=fvT/T0ZZsf5HyKa08R1D91MyslcZhg272r4ItCw79gmxv6J1ZsIpWrlCla42aqMd+3kYiFbnDzVx4Ym6u9zigqVwQ8QJutllWmuT0dzxblSgVwR+OEZtFWYnscTyiDKIKTFTD2B6Z925UX6j/yNj23NloqowW175tjE/LS+m4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300265; c=relaxed/simple;
	bh=on/aqGeJbNw8FM9p0WkiZd/V+zdZqbfsc57tB34OKOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQqzsbymw67TvLMlNAs1wZ63ZcvuPn8cIE9kKnNyUu/ZIftm7jKbOyR2rbrcDxxiJCJoQl4BTctwFgg0hbuenkTHM0onC4JjhDSnSrz4lVOL4MoITScVOuWeOKjnOHTlCXrXEV87PbIPUhL4gkD+DCP2IJFSKrNmlxqpFhOD+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGIeG1Ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FA1C19423;
	Sat, 28 Feb 2026 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300265;
	bh=on/aqGeJbNw8FM9p0WkiZd/V+zdZqbfsc57tB34OKOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGIeG1MlvVGH350+a4R0LYICTBfB3GPsrzxlOCj6VdN2NqZfWMkG4ucGF8gI/t2fD
	 Z1qgWy2lalTIbxtDV8jxe/blNE2pWZpBedNaEtveGn5WZEN2Fk3l/zthkjBmniKfuX
	 x4VAiGR1siwO+F3QDJQM9WY1765bCK8etRCH9JzO6Ke465LxW8DycKXecwOSFfifI5
	 XBL5H2gLwPUWz0UzHE8I7VvZdgCdqvHZ1trGk63TTVA2ZCi/AgbDsGxc23zhVsRJaC
	 ZBVPKP8TlD+U2IgCAwNkWadd6sTv2gUkTN8+XqSU3xAz8obFiisfChkMAbQqaNVmOd
	 Q7Mb535WoNjcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuto Hamaguchi <Hamaguchi.Yuto@da.MitsubishiElectric.co.jp>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 291/844] netfilter: nf_conntrack: Add allow_clash to generic protocol handler
Date: Sat, 28 Feb 2026 12:23:24 -0500
Message-ID: <20260228173244.1509663-292-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220369-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DE8D11C6082
X-Rspamd-Action: no action

From: Yuto Hamaguchi <Hamaguchi.Yuto@da.MitsubishiElectric.co.jp>

[ Upstream commit 8a49fc8d8a3e83dc51ec05bcd4007bdea3c56eec ]

The upstream commit, 71d8c47fc653711c41bc3282e5b0e605b3727956
 ("netfilter: conntrack: introduce clash resolution on insertion race"),
sets allow_clash=true in the UDP/UDPLITE protocol handler
but does not set it in the generic protocol handler.

As a result, packets composed of connectionless protocols at each layer,
such as UDP over IP-in-IP, still drop packets due to conflicts during conntrack insertion.

To resolve this, this patch sets allow_clash in the nf_conntrack_l4proto_generic.

Signed-off-by: Yuto Hamaguchi <Hamaguchi.Yuto@da.MitsubishiElectric.co.jp>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_proto_generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_conntrack_proto_generic.c b/net/netfilter/nf_conntrack_proto_generic.c
index e831637bc8ca8..cb260eb3d012c 100644
--- a/net/netfilter/nf_conntrack_proto_generic.c
+++ b/net/netfilter/nf_conntrack_proto_generic.c
@@ -67,6 +67,7 @@ void nf_conntrack_generic_init_net(struct net *net)
 const struct nf_conntrack_l4proto nf_conntrack_l4proto_generic =
 {
 	.l4proto		= 255,
+	.allow_clash            = true,
 #ifdef CONFIG_NF_CONNTRACK_TIMEOUT
 	.ctnl_timeout		= {
 		.nlattr_to_obj	= generic_timeout_nlattr_to_obj,
-- 
2.51.0


