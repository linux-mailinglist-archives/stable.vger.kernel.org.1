Return-Path: <stable+bounces-211115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dfnaJ4ggcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-211115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:52:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BA05B91B
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD467B699D4
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799AE3101A9;
	Wed, 21 Jan 2026 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oqpLI/6/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF8D3BBA1C;
	Wed, 21 Jan 2026 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020488; cv=none; b=AkMzeruUtkvY1ZS0f0v1sRgbYeZ7kDqBVuRakKDs4XQ9AkMjrxyNcnsscg31e2NDNNCH7g2hnksV+1sradAMxaG27EIltfCx4pee1I6Y7+AYgW2EsmdZiPfwj6qgcErSM2fho1YCQFOOhypaEwXihREr58kwbhon0hwOoFIv/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020488; c=relaxed/simple;
	bh=vHEuC775ivhvC1MhgytT1Poij3J6NDmXm3xAPBw5VrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZXDgiDZkzftYifHadtTvGj+yGVAAvCYD30EdHJnVwLLPM0RGQurCkyQLC5IZwiQj7Qzv0YmAF7ReOgqoUX+0URwtkb0wPXk35jcGgARF7JvWrQbOgY1+/w/ym1yT7wrsjR+nT7P1Z5uglQVhHVjCsIa4hv4QKWE2twPjPGm1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oqpLI/6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA6DC4CEF1;
	Wed, 21 Jan 2026 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020487;
	bh=vHEuC775ivhvC1MhgytT1Poij3J6NDmXm3xAPBw5VrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oqpLI/6/4hJ0aTCzqH7akHSR4I3oopPgCVwXbIpSN9wwFvAq7kR6fWRjnJLXZmgYa
	 RfqtOyMIcpmDO2TroMV65tTBwkwJcm9fQdiujL6OSH8oev2BpuIZ6DrQq+98pTRI99
	 XFZa6taagC4/fzCKzBdYs6PuxtoZFgI5794XX5wU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Butsykin <pbutsykin@cloudlinux.com>,
	SeongJae Park <sj@kernel.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 140/198] mm/zswap: fix error pointer free in zswap_cpu_comp_prepare()
Date: Wed, 21 Jan 2026 19:16:08 +0100
Message-ID: <20260121181423.582986342@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,cloudlinux.com,kernel.org,linux.dev,gmail.com,cmpxchg.org,linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211115-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linux.dev:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,cmpxchg.org:email]
X-Rspamd-Queue-Id: 35BA05B91B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Butsykin <pbutsykin@cloudlinux.com>

commit 590b13669b813d55844fecd9142c56abd567914d upstream.

crypto_alloc_acomp_node() may return ERR_PTR(), but the fail path checks
only for NULL and can pass an error pointer to crypto_free_acomp().  Use
IS_ERR_OR_NULL() to only free valid acomp instances.

Link: https://lkml.kernel.org/r/20251231074638.2564302-1-pbutsykin@cloudlinux.com
Fixes: 779b9955f643 ("mm: zswap: move allocations during CPU init outside the lock")
Signed-off-by: Pavel Butsykin <pbutsykin@cloudlinux.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/zswap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -787,7 +787,7 @@ static int zswap_cpu_comp_prepare(unsign
 	return 0;
 
 fail:
-	if (acomp)
+	if (!IS_ERR_OR_NULL(acomp))
 		crypto_free_acomp(acomp);
 	kfree(buffer);
 	return ret;



