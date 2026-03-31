Return-Path: <stable+bounces-231460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPqnHrDwy2m5MgYAu9opvQ
	(envelope-from <stable+bounces-231460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:05:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F83536C54C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45A0B3034651
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5394219FB;
	Tue, 31 Mar 2026 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Yl56894w"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEFF401A2C
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774972893; cv=none; b=fGjG6dHxRG7+QHZa3d1jyyqrEP1v8melBLIQK/m+8LhQ/KagV9N0Xv0S+kWDXP763ZYjJFynWZXFtlIVd350/05i7PAs3nDcUW38OgHSm3d5qVGfagYExtfvVSRr1z/LLFbtCMSjGXDrA69zQfjEoHVMRBV8iyIeOWtU2/RzOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774972893; c=relaxed/simple;
	bh=UeZWnJT7iOsYzEMEYCQI2P+oNw4o6H7bxKmYK1DTknM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0bpyZW3ewrDwovWH/vArw3CgMM0zZlhgW6Ql1zZAsRnvlkUDeAmHCk9qcXWSQpmhdvbVRpNGo9a2+4IziTGXcFABqtfwu7wiA9j71qZoBfibXaahVpaSCcOHOwTYi6FXT1mi2ht6se1rYQhgWLU1bXF5O/UPTAbOlI1sFsDcx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Yl56894w; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4836d9d54f6so7785085e9.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774972890; x=1775577690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vzSeNrlyjIpdA5QjVt5ncgOyFtChlyyVRQ3D9frbF90=;
        b=Yl56894w7vaIzS+AA30THNOEHOmLpliDAe7JgJaZ5R2fTHvMNP6Z9DdZYENBv9kWks
         rtL5jNhb6LKmoPK2kbpvX7KuZaXMb1MDSx0VIx6pi1D8tWBkHUHsq5Fi+Sbo2Ju1jX4m
         jTXv/IoLCccloojhF4s+w5Tm05/h7ifRmGb2JNn4xHCF//+aGhfTe14rmkokdZ4b/7UQ
         9i8RwooFKZKDueSAMnJv033Q5fPaUyblGSGMJT02T1a4xvZnFbahjc64FdTBO2Sh/pSn
         y4j44tVRiNiHmuFsoKTbtpPgF0RRtTJ6M9P3yO/rwdsjGSNNqHnJp5vpY4Nncd/+mpjF
         icIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774972890; x=1775577690;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzSeNrlyjIpdA5QjVt5ncgOyFtChlyyVRQ3D9frbF90=;
        b=nQ4rJkcj9QssGvTGh2VhfRldTrSKpGx4h/z0t3HQUCUxjlyg1YwXaDTJcOgPmYw1pK
         98AR/6d0Vyzr4ou+5rAJjJqmyqx+ToUOWhG7ejCuY6RPPjPLdDNrsPheoxpr8oIewUyZ
         WVGOgHQrSaITiYIPDcnpk66qJXYohv2VwYUHdmGcgDwnUb/t4Ep7JnbbyKFg6UkrG7rS
         xGt6vYOU/1kMR3y+wJdLLVteK4jSGg/quJEoEg/8h3jX9gQGtGrU+pO/AYbukDEGslZr
         5vNfl0JHgNshVo+yZu67hOkSzVmySNHb5xJ+6mNRAGAS3rcCfd0+I1gJOr7MiJU07Eza
         okrg==
X-Forwarded-Encrypted: i=1; AJvYcCWsWN6dD91V5uZE9brWBwe8zM03+xRI4LEujhx9qz031ZeF4eLtlyIPQwYFd+GOnhB5qFOmyxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbxY/grHwg1C/MKqe48Jkwuli0MDu5l2GqAZBD4x+6Ys903sXv
	0QtMT/ArxLEYKLGS0BZgSOOtAuDF5ckE5P06g6FLp5bti48+SjM/bE+I6q9KfpZOWlw=
X-Gm-Gg: ATEYQzx4rnzlNJhDCK9pU82AEnjww6qI3NkVDPy1Hl3pvibGP4YS4U8e6rtFhGRT9F0
	wMbF2LqYJmL5H4Gr86r/MnG9dXLzvbkCsaZ4AXk16fVoo3Blpe5aClRitYmRHXi/9KX/38optFc
	WHiT/JK2s16UBGg64U+9B2a46HH6/2++tnlxYNl3F2AlPrszpKZ2YqTdXT50CqWrdFlIMJkKDfh
	GlsmOz/8g+/NE163j4fwjzT0nHVjCzHG1JhvS16w9KzhAMuwBWCyKx8Uxe/ahnv1OIngTGTZXYW
	97wPaWX7J9A/H25e/q3eSDvrjnazoXWjM9XY5Qn5Vxs4HFmnckNr4RjQYjNfbPGSo0MF8+unieQ
	JoZMESXh3ROq9rOsk2TefZ+yTe7jtEQ8y1hhukmr9QLNuUlx2HmhAw8YXKRVJ6mvXrrXNCjd6no
	azPmjKMLgfGK64wA5GADazOFwTH+WNPfyuMBQPWVTOYBg1vskNzJsuhz0KWG8UOxGoj87pmt+0r
	YMLQAK6oCtotzk=
X-Received: by 2002:a05:600c:4ed3:b0:487:2439:b7c3 with SMTP id 5b1f17b1804b1-487282be016mr148577775e9.4.1774972889800;
        Tue, 31 Mar 2026 09:01:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm57095615e9.0.2026.03.31.09.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 09:01:29 -0700 (PDT)
Message-ID: <ed0d3cd2-0e2d-4bc5-855d-fba079a7db79@6wind.com>
Date: Tue, 31 Mar 2026 18:01:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/2] seg6: separate dst_cache for input and output
 paths in seg6 lwtunnel
To: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 david.lebrun@uclouvain.be, stefano.salsano@uniroma2.it,
 paolo.lungaroni@uniroma2.it, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260331110755.25042-1-andrea.mayer@uniroma2.it>
 <20260331110755.25042-2-andrea.mayer@uniroma2.it>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260331110755.25042-2-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-231460-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniroma2.it:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F83536C54C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 31/03/2026 à 13:07, Andrea Mayer a écrit :
> The seg6 lwtunnel uses a single dst_cache per encap route, shared
> between seg6_input_core() and seg6_output_core(). These two paths
> can perform the post-encap SID lookup in different routing contexts
> (e.g., ip rules matching on the ingress interface, or VRF table
> separation). Whichever path runs first populates the cache, and the
> other reuses it blindly, bypassing its own lookup.
> 
> Fix this by splitting the cache into cache_input and cache_output,
> so each path maintains its own cached dst independently.
> 
> Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Thanks,
Nicolas

