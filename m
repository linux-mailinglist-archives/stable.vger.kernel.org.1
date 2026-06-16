Return-Path: <stable+bounces-264111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o+GWNf9uMWrgjAUAu9opvQ
	(envelope-from <stable+bounces-264111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:42:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 691F369151F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:42:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=osxMTrN2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264111-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264111-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CA1C303299E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B37D44CAC9;
	Tue, 16 Jun 2026 15:36:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE9544BCBE;
	Tue, 16 Jun 2026 15:36:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624185; cv=none; b=IaVLNnFxXMvjteyf612olzLlhPHBGr/KvYCgKMYrH3hsiednopAz99GeVDNyMOnICiB3raEs+1Hj1Mu3dfp56Ssq67k9/mPLiC5UnEkCGWetKIuKc/5YPiiDTax5YnMYOuFGRyb6bTImGtEvty1OPodAxuqTyPLntPhGxiWZNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624185; c=relaxed/simple;
	bh=N5GfS5MoxKMppC+zOetQGGBm1SfrOSgTBUhpdSxuuek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjViVTy1I+x8glKSEVOwHmpFBiX5561Vm8TZB7229js1d9f84fTX7AV7g6HGDxafoBjkto3M1+gO3FPiCL/XXZTQ91nlL+3tHFBM3SMr3d/vUn0PyT40yNORvcdWnvyVsUdZpIncCF5J6Z3NlFSRM1tqDtn8k6ckPh4If3VNuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=osxMTrN2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D2B1F000E9;
	Tue, 16 Jun 2026 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624183;
	bh=n4CfhnNKpW0MamUTgTSCVHxkBXDJDubqexnqIDpV1cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=osxMTrN2gjiV+s0yQDYM7SVtwIhaqZbetKuLkiSkzpHbVY0xKIP4CBtxgzZBrUhdV
	 bpNL1g6LDTIOv/+DsZ5geeAsnIIm568vfSbNJJUswMpD7oOkVveD1Q0fzCXjNB9Bte
	 2S8choGJhrCUz+/e6eNvSVpmjWIjARu8+x6ePbiQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ZhaoJinming <zhaojinming@uniontech.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 288/378] net: airoha: Add NULL check for of_reserved_mem_lookup() in airoha_qdma_init_hfwd_queues()
Date: Tue, 16 Jun 2026 20:28:39 +0530
Message-ID: <20260616145125.239968123@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264111-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:zhaojinming@uniontech.com,m:lorenzo@kernel.org,m:kuba@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,uniontech.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 691F369151F

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ZhaoJinming <zhaojinming@uniontech.com>

commit f9f25118faa4dd2b6e3d14a03d123bbdbd59925d upstream.

of_reserved_mem_lookup() may return NULL if the reserved memory region
referenced by the "memory-region" phandle is not found in the reserved
memory table (e.g. due to a misconfigured DTS or a removed
memory-region node).  The current code dereferences the returned
pointer without checking for NULL, leading to a kernel NULL pointer
dereference at the following lines:

    dma_addr = rmem->base;                          // line 1156
    num_desc = div_u64(rmem->size, buf_size);       // line 1160

Add a NULL check after of_reserved_mem_lookup() and return -ENODEV if
the lookup fails, which is consistent with the existing error handling
for of_parse_phandle() failure in the same code block.

Fixes: 3a1ce9e3d01b ("net: airoha: Add the capability to allocate hwfd buffers via reserved-memory")
Cc: stable@vger.kernel.org
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1153,6 +1153,9 @@ static int airoha_qdma_init_hfwd_queues(
 
 		rmem = of_reserved_mem_lookup(np);
 		of_node_put(np);
+		if (!rmem)
+			return -ENODEV;
+
 		dma_addr = rmem->base;
 		/* Compute the number of hw descriptors according to the
 		 * reserved memory size and the payload buffer size



