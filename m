Return-Path: <stable+bounces-213775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA3REHdkg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:23:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E03BE86D0
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B27F319536C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E551421EFC;
	Wed,  4 Feb 2026 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nsWK7huH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664518871F;
	Wed,  4 Feb 2026 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217470; cv=none; b=O63+Y+0slU6/HELz/H7rc/tkhYsRmgceu9QRKHSMevw5VcrhHTxjd5gh0zDlfAsrONZDpyRW/0W+tdI2+ceQDgE1qtNuKJcPv+zHwLgRDQWEO/fOSwJI9PNQJJE8GyUDg2+rVbdneH2tOfPZl+S9JRkIBcfga0UeRC0koCXM4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217470; c=relaxed/simple;
	bh=YBug2/feWgYH5DjZUsTkygCAo01TwRKGTl7GUJBHXz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3YDc7kY/Ua95PBX+0EgRMJ3TXT24t0lX0jDtGNvrXCSaFfeIDJN44iWDcparXr4DEc+CUN3KJOzy5ouSNuWOCJ7ucEJo3AO1ErrEjM224Qjklx3EYW7AGs7KRV36M007iBA4h4QYWcn+a7WWoKjcfRS7tfDM24to6BFKuQggzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nsWK7huH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B472C4CEF7;
	Wed,  4 Feb 2026 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217470;
	bh=YBug2/feWgYH5DjZUsTkygCAo01TwRKGTl7GUJBHXz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nsWK7huHSuBJT0+3VQJSIMzzgSh2GXh+maBvtgYU1R7gNqwRfVI5euTSX4/hkHK64
	 g3iRgwtTyirhhgt/bOlGFttG3MhgJ9ppNLL+WE8ksxbk2LqvdPqSrreoiF79RGGwVU
	 Rsr9zMfnb7qvzQ6OOE//zlrspCZQRE3qHvldjL/0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nimrod Oren <noren@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 025/280] selftests: drv-net: fix RPS mask handling for high CPU numbers
Date: Wed,  4 Feb 2026 15:36:39 +0100
Message-ID: <20260204143910.540041926@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213775-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E03BE86D0
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <gal@nvidia.com>

[ Upstream commit cf055f8c000445aa688c53a706ef4f580818eedb ]

The RPS bitmask bounds check uses ~(RPS_MAX_CPUS - 1) which equals ~15 =
0xfff0, only allowing CPUs 0-3.

Change the mask to ~((1UL << RPS_MAX_CPUS) - 1) = ~0xffff to allow CPUs
0-15.

Fixes: 5ebfb4cc3048 ("selftests/net: toeplitz test")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260112173715.384843-3-gal@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/toeplitz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/toeplitz.c b/tools/testing/selftests/net/toeplitz.c
index 9ba03164d73a6..5099157f01b9a 100644
--- a/tools/testing/selftests/net/toeplitz.c
+++ b/tools/testing/selftests/net/toeplitz.c
@@ -473,8 +473,8 @@ static void parse_rps_bitmap(const char *arg)
 
 	bitmap = strtoul(arg, NULL, 0);
 
-	if (bitmap & ~(RPS_MAX_CPUS - 1))
-		error(1, 0, "rps bitmap 0x%lx out of bounds 0..%lu",
+	if (bitmap & ~((1UL << RPS_MAX_CPUS) - 1))
+		error(1, 0, "rps bitmap 0x%lx out of bounds, max cpu %lu",
 		      bitmap, RPS_MAX_CPUS - 1);
 
 	for (i = 0; i < RPS_MAX_CPUS; i++)
-- 
2.51.0




