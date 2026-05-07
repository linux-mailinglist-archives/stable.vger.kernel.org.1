Return-Path: <stable+bounces-244647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFhDLDMV/Wn+XQAAu9opvQ
	(envelope-from <stable+bounces-244647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 00:41:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 301D54EFDF4
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 00:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94893301107B
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 22:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F093038F232;
	Thu,  7 May 2026 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="fv5WlKYc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC46340281
	for <stable@vger.kernel.org>; Thu,  7 May 2026 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778193710; cv=none; b=KfJdHxmD0u9fIcOvmoxgicX1v+03wGlY91OE+FQhiP8rL5Ci5S6Zniwjtfo6OexbLDArGq6cnJ7OwWSB+fGi/FDPTPQYX8oxEkdGdJO1+GXMGHP7HA/TM5gkC/9dAtisvtRdzLtPGFE/tnGBh1wB8wcN9Tes/HjENvZHwuz03fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778193710; c=relaxed/simple;
	bh=A0WjhpQBv6rdWB9/3o/KES8iI3nc2Hd+1xh7YJeWp9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lp14/jPpjSDX4Bcptg2AobuOFsJYm/xs0G2Ia033C6y/RGZfN4D3oetME6Mu8LpZkMrtrab5bgSS182PLl5YUjjuwr9AqnOlWTPOlhWqDBYruhQJYCkR2BfHQAfmebF9/abE8POT1YjXFbsg8F14IF7S7Pc5Edi+FpdJv1Cd1P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=fv5WlKYc; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7de46b8e432so1272721a34.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778193707; x=1778798507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ilg6+WLzTDlspv20RJVdqcQ/EoRyuCOx5HjlDtRUcDI=;
        b=fv5WlKYcx8sjDg0gcFq2pdDFI85rqSVgukBodKEfOgiyuk6OPx1Hxwo16S7mddmOGg
         DLYdHt63saSPckgyYD7pzRN6KaAwStptoMLgHVH/x57j2tr9jCLiUJNmJwsUm2Im3xin
         iy1DzYjI58TPh54NbftHx5xTAk6hE3bTEqAylBMuJmoY3LnUyBtmwG+v2N1PaN4xHCDS
         epN0c/FuyYLuzAJXJ+fLKvwjLdyU+oOrUIynq8fAEcG6eCuCttq3iY80j4xHS4twEJPK
         yfF1St/wC9uRtToRRZBZrIQIxi8KMFwA1Sf0twPDU59R9kJkygkssd8KTE+mSaY4WmZ5
         mqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778193707; x=1778798507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ilg6+WLzTDlspv20RJVdqcQ/EoRyuCOx5HjlDtRUcDI=;
        b=OKB3xy2gY/bfvBAmLksxgp25yQu2VkKCIs2jOpXWVsISfCSqE35MIcORgHpibx1pbY
         I86HXxDz4S2iCgFVxFItydDJr44fEe6U/HG3tSOwH3/IeGYRn2/q9uxIhOQ3rm+w7xzG
         BleDqT6ZqKNIziFuBHzTvmd02UWUc+wv6oa3pKnoHjWo/La/YQlBhl3NX5OpacFGcBSa
         m4rYJ1ibV54WO/5k4nqp5ly/6NFVaQw11gogcVkbcAH71hkSd0evAzxDi1T2GCCVu1sp
         WGsvohA/Z8uSrS9RMt6qLumCARGl8kDFqLi3lJ/Y5xsJ2T2Dky2sGhU3iwq0JkP+ShTP
         K5xA==
X-Forwarded-Encrypted: i=1; AFNElJ8MLoIWBUWpItrO9LxYxfRO4QI7PbvDJGhDvKG+UZY716/V9CyqHV1FtxxFBlhVP2ATr0oWEII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6sDoS2Iixyb0o0Uy7eXmI2Pphc8a+R4YZmhj9UyEpXFLxnn7+
	eJOaRxDM/zhed22pD7mYt/uwruvGVf621M383A6a118E3N2nYP4ces8h4cgUaEiVeo/tiZQCe/c
	vHsH8Erq+xA==
X-Gm-Gg: AeBDietM7zPC8p0zJMoaLEamwTEMqrKvj+Uo16mlVTfpJshrX2hA/05hSCTWiQOq9KS
	SMP/l6TQkrWQevROu9iUfyyMyKYoL6OvYW94N9Oj62Bc/Jq9nfg/5D6d26O12z0suh8VBkAchgq
	c8cMx7ITfafvdcCjr0jzUN5WbIME0LwoYibL24qO7FOHP9Yd8Litky5MxC4bst/pKaf2TlSap/p
	hvpqBPRAsep+Dp9NBCPUVJq5Vpj4hybTWy5TI/f+KauGmm5jfK3+3yYySCQwPUJ4RikERs7rqEz
	fZ3sdbVmKolB53fXm9Lo6RRkHT0EvJB6sLgbR2FcPgRQOfEnxsDDHbhKh09Q7cgJ/lyFruaplaa
	v9HPon+GWJjeNBNb8Velg6oeTcNqSncikf7b9R2eCzOp82K1BKXcRNtD7pP+9MF4L0fSjyy4hr3
	cr/d6rlrAJBcIoB2hq3H12B2BL0Jd1vyYeMFsjvbbqiafbB3ExfuuIDGWOLYA0FB+XLGG2xG7P9
	dEdBprJwfdx+DL5Uvny
X-Received: by 2002:a05:6820:1892:b0:696:6440:9e1d with SMTP id 006d021491bc7-69998cfe2a3mr5624741eaf.39.1778193707355;
        Thu, 07 May 2026 15:41:47 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435573e6ec9sm98414fac.15.2026.05.07.15.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 15:41:46 -0700 (PDT)
Message-ID: <5fed66f0-ea72-4f36-bf50-2d7c39c4fdeb@kernel.dk>
Date: Thu, 7 May 2026 16:41:46 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0.y,6.18.y 0/2] Backport io_uring commit to affected
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 stable@vger.kernel.org
References: <20260507124253.97596-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260507124253.97596-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 301D54EFDF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244647-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[kernel.dk];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On 5/7/26 6:42 AM, Harshit Mogalapalli wrote:
> Hi Jens and stable maintainers,
> 
> The intent of this series is to backport commit: 770594e78c39
> ("io_uring/zcrx: warn on freelist violations") to 6.18.y and 7.0.y.
> 
> This above commit likely is fixing commit: 34a3e60821ab ("io_uring/zcrx:
> implement zerocopy receive pp memory provider") in 6.18.y and 7.0.y.
> 
> Pulled in a prerequisite to cleanly apply the fix. Only build tested.

I don't think these are actually required, but at the same time it does
not hurt to add them. I'll leave that to Pavel to decide.

In any case, thanks for doing the backports!

-- 
Jens Axboe


