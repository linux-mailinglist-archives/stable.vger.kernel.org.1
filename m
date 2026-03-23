Return-Path: <stable+bounces-229778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMZ5BnltwWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:42:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D71A2F8A56
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3777431A2E30
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9F2283FC8;
	Mon, 23 Mar 2026 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y8CMugCl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9182C35958;
	Mon, 23 Mar 2026 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282839; cv=none; b=rOjEh8Zs61o3YJGMzMrdOrLmanz8i/nWkM/eiHo+EN9E+04NisoaZCzV/iepH8Hb84SPsY4M83q0jQzFjdcIHONIP6GoOrepiTjK5CB2iPPvooU5Yayzo3aoyizz0FagcUh2c+kyRH0HfYam/ORshdb6H2lmcBF2/HoxdMyh+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282839; c=relaxed/simple;
	bh=aq8qw3HHZhPtJwYqPc4bE/K903yfHcAOxZhGNfxBsxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO5vUJd8BDYvYX/kz69kj/Fr5jfYNd6xZ/yrExxlwSmi5MZygo8VSs8YWInCa5+HFOuD+0CYpYMUh/Y75eZjYZqRZ1hfBE/5jW5+uuNiXVs2Ens5oocAL/ZUv0RjOYuLyuhASReYFaTXYV6LTsJHG10wMaRPiikX3K097ioW5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y8CMugCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B43AC4CEF7;
	Mon, 23 Mar 2026 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282839;
	bh=aq8qw3HHZhPtJwYqPc4bE/K903yfHcAOxZhGNfxBsxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8CMugCl2OVD6rKPQVAru6O87rVtaNvALV7SQ0IbB3s2VaeHINOeCo3OOGRtgCmMQ
	 cdbNil0IJGTeINGJACkDilFbT9IlqDeIZcsgbhd5G6jnAQUkiptVSLKoESF5OKx6fY
	 qctGuzqbHwQylCre2ZkyJgXm7JPClP/1bWdURdmg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Cheng <benjamin.cheng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 305/481] drm/amdgpu/mmhub3.0.1: add bounds checking for cid
Date: Mon, 23 Mar 2026 14:44:47 +0100
Message-ID: <20260323134532.543519840@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229778-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2D71A2F8A56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 5d4e88bcfef29569a1db224ef15e28c603666c6d upstream.

The value should never exceed the array size as those
are the only values the hardware is expected to return,
but add checks anyway.

Reviewed-by: Benjamin Cheng <benjamin.cheng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 5f76083183363c4528a4aaa593f5d38c28fe7d7b)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -117,7 +117,8 @@ mmhub_v3_0_1_print_l2_protection_fault_s
 
 	switch (adev->ip_versions[MMHUB_HWIP][0]) {
 	case IP_VERSION(3, 0, 1):
-		mmhub_cid = mmhub_client_ids_v3_0_1[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_0_1) ?
+			mmhub_client_ids_v3_0_1[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;



