Return-Path: <stable+bounces-210911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uN2BOGoycWlQfQAAu9opvQ
	(envelope-from <stable+bounces-210911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:09:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF465CDC9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DC8A7E3511
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55F63A89AF;
	Wed, 21 Jan 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pjn6K0ag"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADDF3A7F5A;
	Wed, 21 Jan 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019799; cv=none; b=A+xxudSuHR9Nb9GIOoC21qzVz+g5b6pLJ7sfGCFSEGug2GOO9levPEBxL+Qsn5elwnz+UbtFy3S4H/kCBsUWJFnJ1VN9PhDewh1bUIRskHXA7J4SaSuAUmr91vd5+vlKBvGoyb6z1u7OMXJCgF/Bb4pXhIItLlJqfCLGDhlXBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019799; c=relaxed/simple;
	bh=sSrT81sPSuk4Az8yv+kvuizomqhQp5t6xtrOMBGOtTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVZabtnMoVlxs7cILdASwrDzFti8N18qxLQ2ZizDZjvBHGBvxImvaLDLORO6fG/Bz1C5mM1o1agoDGxBzrZsWdO9FwGl1df0i/Xedt4Z8UawYuKY3q+mvrXNXqttmD7dNT6OXEyljJFOvpTIeb0v29tpPYtMhRd3tVV3qdBesPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pjn6K0ag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55AFC4CEF1;
	Wed, 21 Jan 2026 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019799;
	bh=sSrT81sPSuk4Az8yv+kvuizomqhQp5t6xtrOMBGOtTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pjn6K0agyKSGZxzTvZodXHIrVJ5w04qbSRrpIsFV3/Jbzc6ohL5uoucuwQCZ5cmpc
	 errDjYQtLMDeKwHpqVCr8+czz9DBcTzgZEKsrbbR/Xk4X7BLL8pVgF+8YRauXElS+l
	 0S7keDm+38RAhICSLYiz6ZjmIXv5EemQHC3tArqQ=
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
Subject: [PATCH 6.12 094/139] mm/zswap: fix error pointer free in zswap_cpu_comp_prepare()
Date: Wed, 21 Jan 2026 19:15:42 +0100
Message-ID: <20260121181414.836439635@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-210911-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linux.dev:email,cloudlinux.com:email]
X-Rspamd-Queue-Id: ABF465CDC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -866,7 +866,7 @@ static int zswap_cpu_comp_prepare(unsign
 	return 0;
 
 fail:
-	if (acomp)
+	if (!IS_ERR_OR_NULL(acomp))
 		crypto_free_acomp(acomp);
 	kfree(buffer);
 	return ret;



