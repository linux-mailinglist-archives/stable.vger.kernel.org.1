Return-Path: <stable+bounces-240022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFHoMgfb5mnH1QEAu9opvQ
	(envelope-from <stable+bounces-240022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 04:03:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A274355FA
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 04:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E97C63015A49
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 02:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76C6265CC2;
	Tue, 21 Apr 2026 02:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Mz7h+f6q"
X-Original-To: stable@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7FB18E025;
	Tue, 21 Apr 2026 02:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776737022; cv=none; b=fVIOhmjyaB42qVA5sbGOBR8s4S2oNFAeAB+2ApBj0wwNU5bi2LShUCI/DVV2Id3XHhla3G5cLVhQKM5PPzRkM4N0D60sZEtuS350OmtOiHlSL/b9LMP/80rGuBDnEPm8fI9xnYLnvPFn/yN4leCH0m3ApcAVbbEgT/G8ZKs00ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776737022; c=relaxed/simple;
	bh=dHUjxAOXkLVdU/zS2QOs1dhm6nRPmHFNN046VJ1KWAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1rbHGWQLpTzZERNvd6cEAQJ/2eWU4YagXOr/k5RiaBn9M8AvkvnfsCX51pxhm2UEt4kJrAOcMQLK42/UDvBUilKXu6WhwvG3nKf/jdWQCViMe3FQX4LwrqRCWXcPPPr8UktkWBE64q6O8Sn4OEuIEsFp5ROYmRIjucZbiR1Ec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Mz7h+f6q; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776737017; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PT9p61QumOTma43BB/QkhxMPjLowSNcnP2HWwqiAW7s=;
	b=Mz7h+f6q7ZA1BF3oQNkrVU7UbZTr7CMuXCT0DIWoi+VCCdQ35kElIOcTcAguUsHvN3ktm8aqx4z/RpCEYSSPpz2ccbrvcQelaeDr6YT0XOh5o7vt3Ga8Z2TmAFCICJMeq3GXpXX7PwRMUHDj2UfuXXf8pUOUajx9iW5xpS3oMu4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X1RNrF5_1776737016;
Received: from 30.221.132.26(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1RNrF5_1776737016 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Apr 2026 10:03:36 +0800
Message-ID: <78d564f5-5511-4c67-b6b4-6670b3babbbf@linux.alibaba.com>
Date: Tue, 21 Apr 2026 10:03:34 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 7.0-6.12] erofs: ensure all folios are managed in
 erofs_try_to_free_all_cached_folios()
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
 stable@vger.kernel.org
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, Chunhai Guo <guochunhai@vivo.com>,
 xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260420132314.1023554-1-sashal@kernel.org>
 <20260420132314.1023554-198-sashal@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260420132314.1023554-198-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240022-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vivo.com:email]
X-Rspamd-Queue-Id: 48A274355FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/20 21:19, Sasha Levin wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> [ Upstream commit 5de6951fedb29700ace53b283ccb951c8f712d12 ]
> 
> folio_trylock() in erofs_try_to_free_all_cached_folios() may
> successfully acquire the folio lock, but the subsequent check
> for erofs_folio_is_managed() can skip unlocking when the folio
> is not managed by EROFS.
> 
> As Gao Xiang pointed out, this condition should not happen in
> practice because compressed_bvecs[] only holds valid cached folios
> at this point — any non-managed folio would have already been
> detached by z_erofs_cache_release_folio() under folio lock.
> 
> Fix this by adding DBG_BUGON() to catch unexpected folios
> and ensure folio_unlock() is always called.
> 
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Chunhai Guo <guochunhai@vivo.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> 
> LLM Generated explanations, may be completely bogus:
> 
> Now I have a complete picture. Let me compile my analysis.

This is NOT a bugfix, but I don't mind if such random
patch backports to stable kernels.

Thanks,
Gao Xiang

