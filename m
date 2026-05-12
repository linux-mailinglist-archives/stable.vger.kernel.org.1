Return-Path: <stable+bounces-245832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB0mDqVNA2r63gEAu9opvQ
	(envelope-from <stable+bounces-245832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:56:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A80B952429C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C7F5309D277
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B266362138;
	Tue, 12 May 2026 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="fCUd6a+1"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD435F5E0
	for <stable@vger.kernel.org>; Tue, 12 May 2026 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600878; cv=none; b=ua065Ye1KqGIgetzoiONkFuyq7SPNhWkMxjzdHK2E0DGoJJPXiVf/3s0MtPzyct/cuOVXAPcW+232vTiRVxgr0z7cxGSTMicHJu+pSfq5A4QiHIIm4Nfds8JUKcw50biTbRU4AvtkXLxp5D4b6USK9xDCyyjefMlhWTq7RZMRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600878; c=relaxed/simple;
	bh=+fFU7jIK5BFPkMYtAIwxntL9yQQw08VG6EF5OZCivYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XH8F+AYefucN2zyo98d0bEKV1UNs/qqCnpWqchkjl/WCIkE/bWgCwlhb8VccYFFu5NssuR7VB2xcuR8idw14BxdEsIFDMO+jMO9mlsDtyjUYLSYqO0RgOWaGc9wcKox8okFpuY9rDnW0dKyaaFN//+ycE+uG2A59kNfg5FHB+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=fCUd6a+1; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479e4835e26so3334141b6e.3
        for <stable@vger.kernel.org>; Tue, 12 May 2026 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778600875; x=1779205675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HdFF4dCw+6mO/bxdzEz9RKka+BXsp2V02/j635sy9XI=;
        b=fCUd6a+1dbTlbcXSBux+6ty7YaUaJK2/Z1Q3KqAMmY0eAiqtnrczr6SL6Z7aA0iZF6
         BHT67MdxypV8WhC16B72CE5D3TG0Ashob0PtRyi+h+O//McQTRWR7xc/79PdtTz6FzjU
         p1NuWIOTYXc+ZQhT2J9+Xk3+TKK6uXytEC0PlwkeyeK1HfnHo7UsBThAa2daH8n9QSg5
         lICLum0v2CWN85/U8OnyuDF6xieIG/LY5b8M6RZqAANb2UJ8dhzmsDQP6kdfox+vm7qM
         K4Q9i1WnmJYAyduXxMLUTOw8Q9mPJ+AuQs04KC6UDttq3VqkYNATLdxXWPB/ymg+gArD
         759w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600875; x=1779205675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdFF4dCw+6mO/bxdzEz9RKka+BXsp2V02/j635sy9XI=;
        b=b+Me2H0C1PpzT/7MYVeI7hmGl6WV1vAo1VY92YtI6PekZ3Oy0Xj71Ogvm2GSzJQB62
         T1GOzcw4Yr4scAcgB2E1ZowvCBkDGO2oqnOPmaoW/3OvsD88UQ2jSiNV0LPJx13BWaGd
         kmeHdNS4ZnTwFZ3l4rJPt2O+jMKVK3mn8eH+m6KgnV+c2d+EOq3esNY6EZpgVsmQhGHN
         G3CyZvC5w0ghfxJV63qVYIgQx+z72D3eGgKrT0WqHKVojdm5fh/xCCfQvH6/hES0MbwD
         G4Ic2F0/HEVbde5w9L+X2GEJ/rSozRZJ9uS4izs4ZOw6eQf4Towdbw6IxoYqOOftRnVI
         IFQw==
X-Forwarded-Encrypted: i=1; AFNElJ852gaHrGBJQoEpwBjVWxOexL4IaGhZsi1RNVJKjhUIAr8MFMN/KyFGdA8ely8PWDyTy9UonOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySV+IH3Pc5oPX+nTy4pFYRpcTeOREja5kpI7r6RCvTqXn4SlO0
	hViqTtAY5pa+lZ9cCx9j+G01UrXgWG3A4GCgvJjdBmebFPD+3IAfXekSaoB/cGu4PObh5hBCAbw
	PQ6U8
X-Gm-Gg: Acq92OGPdNfxdvlCYiyg9ojQ7N9WNeO2Bx2RDDnI5nNOv7bzmyaKhD/JBwjkOtdGuNY
	YVqqVj19trIcBxp6coPcAATb/eB1SAqJZ6gPUol9kqbx3J4fEjhaqgc03U5aWM9+bDdLdohZ4+2
	tGKAeK5jXqzUv7rUw2Gg9Bz9TKRUaHZsW5InoRcZfhuMX9thVKansxIbDSy0nuBeA+goFUtWpig
	6PZjI+BTiS215EugdUz5yc3gIOrY775MRed9M5XuvCtH6iaY244lDM3MjqbF8SyDRdhBL1vEXS+
	1OqaHL1bo/VyrgPJ6Rm3zUBAx/QtqzC2S0dKZwrms+2sKFzkqJhABswDKhyi4M6GIOivRsvV9a9
	RNrvy99CUv8UJYmNxdFzzXZ4POsq/+0vO/5mJx9Zh6KwQjEWd1o8Z01K0o/xH+O2XjPFQ0WUAOz
	8J27svnOHsPFAyCN7tPH616e8oJ6m+KxPqA09JLt7zgbzfrB3vlghtzvYsdY9iZu4H9Nr2Th0Ih
	A+CAWcAUG8gPvPtfbE=
X-Received: by 2002:a05:6808:c298:b0:469:fc59:b128 with SMTP id 5614622812f47-4829731fd75mr2139910b6e.25.1778600874805;
        Tue, 12 May 2026 08:47:54 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986f9dsm22873454b6e.16.2026.05.12.08.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 08:47:53 -0700 (PDT)
Message-ID: <e12d01e9-8934-4150-bcb3-09ba147fc842@kernel.dk>
Date: Tue, 12 May 2026 09:47:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 7.0] io_uring/wait: honour caller's time namespace
 for IORING_ENTER_ABS_TIMER
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
 stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260511221931.2370053-1-sashal@kernel.org>
 <20260511221931.2370053-13-sashal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260511221931.2370053-13-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A80B952429C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ntu.edu.sg,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245832-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel.dk:mid,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On 5/11/26 4:19 PM, Sasha Levin wrote:
> From: Maoyi Xie <maoyixie.tju@gmail.com>
> 
> [ Upstream commit 45d2b37a37ab98484693533496395c610a2cab96 ]

If you auto-pick this one, please also do the other one in the
series, 9cc6bac1bebf8310d2950d1411a91479e86d69a1. Makes no sense
to do just one of them.

-- 
Jens Axboe


