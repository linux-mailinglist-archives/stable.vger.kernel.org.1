Return-Path: <stable+bounces-270421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TcpeGBFZRmpKRQsAu9opvQ
	(envelope-from <stable+bounces-270421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 14:26:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 360446F78DC
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 14:26:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=pQMCWR48;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270421-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270421-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B75B03002B74
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 12:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960B848C3EC;
	Thu,  2 Jul 2026 12:06:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96B47DFA9
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 12:06:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993988; cv=none; b=GmxD1/IgeYVma+wr8RxJIqR64zSxCV3VY7vGbZZlaPAQBHwABG9MQ+bIrHMy/GJqldWL2ij0FTgfGrzpH0iZUO2tWN+axMAqx4jvCFn+j7ogcYAIm7vR0ainrNBdviYQaXllTIOjFrQLPWNV9Jq8TtGUh+5qYUJRqbRq5mnHQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993988; c=relaxed/simple;
	bh=ZZW7lUB7b9ygP6ck5Uz5hyt0C+D3AW01lrX5XsNNbiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azMjvylbNeCAilCAjvRofdaV4Tf55XsWACjiiBXZHjRsALUzJem/AWZFF8JNOEzY3blRjOrp5FX7PuMGO3ZG6Ez3jgeoSnRpNM8qQyJs0YcYirOd6yo48QCzBByewSTXk23X8aCF2CvN9+fT6V9VasqlpNmyzia+QF4BpBJRP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pQMCWR48; arc=none smtp.client-ip=91.218.175.172
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782993980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpJZ25WsLuIlkqseCrbEHPfxQ4Tt5MBUyDicJs/5yFk=;
	b=pQMCWR48HrTKFfEiVKfi3/l06Bn2GCOjXTwUOGzFrAnKZcmvhvluO3+UaatJOkSq7qmNkD
	BpG54LO/blIyC7cRma+a7KEYb4Jo4iyWMKGYobz2/uwVbDVVmH7VZ2tkCN56ditIaondft
	9cFplZVafSFdbAsFXOZjOA4zmnZT0d0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Jiri Bohac <jbohac@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Scott Wood <oss@buserror.net>,
	Jason Yan <yanaijie@huawei.com>,
	Diana Craciun <diana.craciun@nxp.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc/kaslr_booke: Fix reserved-memory reg property length check
Date: Thu,  2 Jul 2026 14:05:51 +0200
Message-ID: <20260702120551.3046-4-thorsten.blum@linux.dev>
In-Reply-To: <20260702120551.3046-3-thorsten.blum@linux.dev>
References: <20260702120551.3046-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=thorsten.blum@linux.dev; h=from:subject; bh=ZZW7lUB7b9ygP6ck5Uz5hyt0C+D3AW01lrX5XsNNbiQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFluIQrtvdNeHSuNDfwSuzHeO7lImX/H3yfFzLp32cRfv +/TzF7cUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABMxYmdkWPU35oAA092GnbNU ZxX/NbK0UFWbdFUlQVrj/VxFjYxHqowMbRF/0x2+uN0U9H/nZOpw01O2ZDrDg3lHL/+evVczrVS SEQA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:jbohac@suse.cz,m:akpm@linux-foundation.org,m:oss@buserror.net,m:yanaijie@huawei.com,m:diana.craciun@nxp.com,m:thorsten.blum@linux.dev,m:stable@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,suse.cz,linux-foundation.org,buserror.net,huawei.com,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-270421-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 360446F78DC

In overlaps_reserved_region(), fdt_getprop() returns the reg property
length in bytes, which the loop condition compares against a cell count.
Since each cell is 4 bytes, scale the count to bytes before comparing it
with len to avoid reading past the end of a truncated reg property.

Fixes: 6a38ea1d7b94 ("powerpc/fsl_booke/32: randomize the kernel image offset")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/mm/nohash/kaslr_booke.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 3e5e67c76bda..82106a9d9d4c 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -123,8 +123,8 @@ static __init bool overlaps_reserved_region(const void *fdt, u32 start,
 
 		len = 0;
 		reg = fdt_getprop(fdt, subnode, "reg", &len);
-		while (len >= (regions.reserved_mem_addr_cells +
-			       regions.reserved_mem_size_cells)) {
+		while (len >= 4 * (regions.reserved_mem_addr_cells +
+				   regions.reserved_mem_size_cells)) {
 			base = fdt32_to_cpu(reg[0]);
 			if (regions.reserved_mem_addr_cells == 2)
 				base = (base << 32) | fdt32_to_cpu(reg[1]);

