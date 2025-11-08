Return-Path: <stable+bounces-192792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 689B2C43579
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 23:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13BAC348858
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 22:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540F429D27E;
	Sat,  8 Nov 2025 22:25:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A48829BDA2
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640700; cv=none; b=oEb0yMsBO5/1H3/FXj9JIIvDLNepWputDHXwg3IIWc41vTViXK407lqs3vbKjfSGZbWeaDj+f0DgnqKEP+oOnu4rUX0gGYBKIMKNztcZhh9rlHNR8ESTYnDPFOiCEzP8x+rN75Z5cSHDielLM4p7LVzpLEO3sWrVKKnv1Dwxz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640700; c=relaxed/simple;
	bh=2Mv2eWVx/Gp/9zmenLTCFy4zz2PyZwi5pO/4yt7VAqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqZesJ9rl58DaAwszg0MKEya4rC+Gl/FFhNrX0+dFXAKnPBze4DC2AUHa60vAXr279W/zWkK8XrdL/iO3htzASAal4HeXfhHS+L24zwmZ/OY4v96Ea/PPKllGeZUN/ERLkPeB9jEpHwQT+TsP9rmTR9JFAn6BRpyz6SZR0LLEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88058103dcfso12301416d6.3
        for <stable@vger.kernel.org>; Sat, 08 Nov 2025 14:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762640697; x=1763245497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIK9zYAgTOFKn0gaT0fUYRv/pXw/XsmvNmFsqqYFUAk=;
        b=mbL9wiJjKt2W4MQm1t2GT0YMjMRd9RJMixTGf8PmhuyL3tbxhn4w5TBeouJMzC/c2J
         +KYkT5zZ8/6SdRtXe5fbD6GA24MHtPaG2N7MdnEgIYvrTaZetGFdNFzz7vVpnJ8Mo2At
         CYFhsAGNLWkI6tPIoK4MVhZKxfg5q3nJxG+hafW8axKtqsSlNunx6WJmF+cfH2RayLeg
         KsxMTVR+3WFKokQIZzQ73YwODVH2az2vin5jO+Bwz38PGsuLwLjAo+yKl9pS4ddMK5ay
         0f4IqsDeYXtfT0RGbpzyizbhu6wcBngLXYBPsnig/EGV4HGkqOAHA32pnY33vy2AkPWj
         uumg==
X-Forwarded-Encrypted: i=1; AJvYcCVFuNiE7rvqnwDKWylLptf861wbgbPsit6gL92z02PFZEe4by9ocBDmfwWwfW3BdxTK4m8p3OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGLCOm3XVZW/1KTlpxnWT6DxYngHQle7ZnEZUbV4tXBdPFPug
	vTqr3rIVTgbOkCalGZIF1VEzuUOwmrif8CrWHwi0P5J3dOIS9PKWd3sH
X-Gm-Gg: ASbGncuj18Xf5ILm7BJJVk8Wz99NLIgYxobvhAgVWSIzRjCxcy+oPF29ww4WY7TwVzx
	IRuu8PIBvd0X/LjYt9qNSaWV9Dcg9oxZKzmY8IrozFYXTKVvl5NRXNvbwKtnswN+4ml9EB+96MW
	WxkziChOVcgqk4B49euhYEJag3FaCjJaILSfIIRJHvA628FirqCW6UMSkUPV2lOo5Qo33QJqDcp
	hMyXYJy9vbnDkg7hvLRfCZQyXfAGzgG6FXBxODcnTAhc0HMP5OcZrP1l/TnmsJ4XetnvYzFiT5M
	ZkEuadGGl85Ki0VLWI3k6RIGJq7600I+CK2CAJfsq+MvtVsjMFD9m3nDXZ90B3vs09Lnb5jUZps
	O8vm8uoCG0TVLfH1GLCz5aWRUrpUoHoimXerlyvUh6pXOosZs35CG7NMM9VadsCzpGNYzGAeimk
	15
X-Google-Smtp-Source: AGHT+IEjXFwr+Srm4QmfVRgu2vNEak6lu57AWOlSK22OF1wICTm1uk8SpWxSTMr5t0Nyhn7q3c8MDQ==
X-Received: by 2002:a05:6214:daf:b0:880:5851:3c61 with SMTP id 6a1803df08f44-882384ae832mr39079716d6.0.1762640697346;
        Sat, 08 Nov 2025 14:24:57 -0800 (PST)
Received: from [192.168.2.45] ([65.93.187.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238928a80sm21582896d6.9.2025.11.08.14.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 14:24:56 -0800 (PST)
Message-ID: <baf4fd6c-1796-47cb-a9bb-72521a217453@vasilevsky.ca>
Date: Sat, 8 Nov 2025 17:24:44 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: Fix mprotect on book3s32
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Nadav Amit <nadav.amit@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-mm@kvack.org
References: <20251027-vasi-mprotect-g3-v1-1-3c5187085f9a@vasilevsky.ca>
 <878qgg49or.ritesh.list@gmail.com>
Content-Language: en-US
From: Dave Vasilevsky <dave@vasilevsky.ca>
In-Reply-To: <878qgg49or.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-11-08 14:16, Ritesh Harjani wrote: 
> Shouldn't we flush all if we get tlb_flush request for full mm? e.g.
> Something like this maybe? 
> 
> +void hash__tlb_flush(struct mmu_gather *tlb)
> +{
> +       if (tlb->fullmm || tlb->need_flush_all)
> +               hash__flush_tlb_mm(tlb->mm);
> +       else
> +               hash__flush_range(tlb->mm, tlb->start, tlb->end);
> +}

That seems reasonable, I should be able to test it next by next
weekend and re-submit.

> Thanks again for pointing this out. How did you find this though?
> What hardware do you use?

I'm on an iBook G3 from 2001, running Arch Power:
https://archlinuxpower.org/. I found the bug because SheepShaver has a
configure test for mprotect, which was failing--I was quite surprised!

The bug reproduces easily on qemu (with the `mac99` machine), if you'd
like to try yourself.

-Dave



