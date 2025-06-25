Return-Path: <stable+bounces-158520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FC4AE7DB9
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 11:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEB21C2381B
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2642DAFDC;
	Wed, 25 Jun 2025 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bj/dYUU6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B820B207
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844008; cv=none; b=OogH2uhOHYL6X48pbwrFKo7YlNZy7B7HrSBax5noLZtiE7r5JN54VU7VHXIynyj6zwTDdlrVp5tGowxgu55VMeI80OPgr9iFVGdvGk3EEBeojB1x9qt8x7Gg2X0/CucITrEQf/POe8aKJobTB/wboZ5rA6/Lvwnc4lfo0JYGz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844008; c=relaxed/simple;
	bh=k+nx7nu6cPVQDfFrsuNjU3DCQm8tTXSlINmjdu61A9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw1AsrH8Yxi8HzkeVN1UZDnFH1sx7zTDfWds4Y3aWHjcAzuSE9u8yeGESf6BPqPTuOd1yEMIY/KoDnbCndGc8tqYNDFhqnKknfMGIB3mxVDJuGb2c8O9W3UgIjXBldxjoQGzcXerZYF/gTK+pYVbT2dyV7xumKOpcBR4qrV33Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bj/dYUU6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73972a54919so5064291b3a.3
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 02:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750844005; x=1751448805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i1RX7jUG5qc7uQ8DMghFIDB3atd+XiDw5bOTF4+xmIo=;
        b=bj/dYUU6XF8rBJb2tyljNZLao6nHq414h/cLGLi7ftBL4dcX9wVOGhLCHLVemoV2jq
         h5ZdU1tDSJd7LNgYZoilMhLuXpTwqGMoEgLFbHVE4Y0AUx6pw0E5ZfJF+IkspB+RV3Je
         EErgAzTnpivmRl/bkWZyjdH0Sx+QmjVs18gvkVoPytVdb8NhtUWza2FQyaIDgG79HG4x
         jiL5MGCHVxz0lqhVS5/0c5+s1qjjg1QKNzxXU/zE98ofs1uE6JCxV37VZFejWBG8spao
         HSyXBrhAVTXGxrGFXD0Zn5qip79sif8QOuy/qByCEHyao9rdoJybdFUjB5FOlJcwawwf
         ssRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750844005; x=1751448805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1RX7jUG5qc7uQ8DMghFIDB3atd+XiDw5bOTF4+xmIo=;
        b=sRjvd4WBU/dtkAiSoqZvs206E+eTVKN9rZ8ejlL8+96uW65zFYP/SHtlbW0Feu9BAY
         JUJFl0TspZXSHLVZNUJaE/uZJz57AWjA7Qkd2rH5KM/JolF87ZZ4ahOY60g+WU2ih2A8
         GwctJdZgL6R3V9H1tOL/GmXtj9u/sNibaiP34UEIsaULXdsp9AU4g4FNiGrAcOYpctBi
         3xcZtMX5SSjgHppMbSDNM7B479uiugTPWe8c5lO2aCVLIEkVLYxI46IsN1nGo9t8VMOx
         nXOpOMnQKY2OikGlgykae0f0XYI1yjdq5caXAW8Sj+RBduwTtYRx12adzfmiKui5M1dR
         OOkg==
X-Forwarded-Encrypted: i=1; AJvYcCXtxEW52pf23n4D4vToto7+gmG0pXHz8bkiavobXWZM09iuMEl9cbcNmGzFxMLODE5+kUc8Z+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx69Y+y9yO7rokV9vWcn2V7L40dfPFgXnBg91n14uNtuMO85VcM
	UejgN+tbwiLQ1AXoC7x8ahyayffMiZFQM/uHG7in0QhXPXfElwbyZGzP48lR6nwVeA==
X-Gm-Gg: ASbGncuB3wXPDEr68DWuaTHqzJbTvKoUgOGKnOqNk4Mxei+oqTeNg817JoioTHeyHeV
	+BSAjeJbhILMlRqD3m3LE+NIKArMP3VxWcx2cjyXK4LY4R7h2sIqPG5MyqcXdCxnb9SORvPOSRJ
	ByGE7+xyUhWz2+nC9NvRU5X/VX3U/MlDFKIJPAVwzq3AQERwAMt6VGzHjdqZNpUtekb8sUntgD5
	aqwNr1QKZ6HdpWWoKVU87XRQs1ArbJINFKrrF19DvgbiihnDNH5VhpTVl16FqpTLQRd73PFgg9H
	M1yPxAHWfeydteJ05sm3aIH9goawOLksK0Ju1QvF8HTiMC+rnTlGZ4sATeCdqgjpxpzBTgI4fN2
	9OJXdZy0=
X-Google-Smtp-Source: AGHT+IGWyUhHQC/H6QAYdZwYrHfK48YB8WyI5hj/nD5yR8mjV1LWyySwj9eD/DPynCfUMhnTQllbJA==
X-Received: by 2002:a05:6a00:4fd5:b0:748:e8c7:5a38 with SMTP id d2e1a72fcca58-74ad45d9ea4mr3726827b3a.23.1750844005495;
        Wed, 25 Jun 2025 02:33:25 -0700 (PDT)
Received: from bytedance ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c883869bsm4019424b3a.105.2025.06.25.02.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:33:24 -0700 (PDT)
Date: Wed, 25 Jun 2025 17:33:11 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pu Lehui <pulehui@huawei.com>, stable@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: Re: Host panic in bpf verifier when loading bpf prog in 5.10 stable
 kernel
Message-ID: <20250625093311.GA388@bytedance>
References: <20250605070921.GA3795@bytedance>
 <20250616070617.GA66@bytedance>
 <2025062344-width-unvisited-a96f@gregkh>
 <20250623115552.GA294@bytedance>
 <2025062316-atrocious-hatchling-0cb9@gregkh>
 <e9fa5e34-eacd-4f35-a250-2da75c9b7df8@huawei.com>
 <20250624035216.GA316@bytedance>
 <2ed4150a-e651-4d10-bada-57bc3895dbe7@huawei.com>
 <2025062458-flask-enviably-20a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025062458-flask-enviably-20a7@gregkh>

On Tue, Jun 24, 2025 at 11:33:20AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jun 24, 2025 at 02:41:56PM +0800, Pu Lehui wrote:
> > 
> > 
> > On 2025/6/24 11:52, Aaron Lu wrote:
> > > On Tue, Jun 24, 2025 at 09:32:54AM +0800, Pu Lehui wrote:
> > > > Hi Aaron, Greg,
> > > > 
> > > > Sorry for the late. Just found a fix [0] for this issue, we don't need to
> > > > revert this bugfix series. Hope that will help!
> > > > 
> > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=4bb7ea946a37
> > > > [0]
> > > 
> > > I can confirm this also fixed the panic issue on top of 5.10.238.
> > > 
> > > Hi Greg,
> > > 
> > > The cherry pick is not clean but can be trivially fixed. I've appended
> > > the patch I've used for test below for your reference in case you want
> > > to take it and drop that revert series. Thanks.
> > > 
> > > > > From f0e1047ee11e4ab902a413736e4fd4fb32b278c8 Mon Sep 17 00:00:00 2001
> > > From: Andrii Nakryiko <andrii@kernel.org>
> > > Date: Thu, 9 Nov 2023 16:26:37 -0800
> > > Subject: [PATCH] bpf: fix precision backtracking instruction iteration
> > > 
> > > commit 4bb7ea946a370707315ab774432963ce47291946 upstream.
> > > 
> > > Fix an edge case in __mark_chain_precision() which prematurely stops
> > > backtracking instructions in a state if it happens that state's first
> > > and last instruction indexes are the same. This situations doesn't
> > > necessarily mean that there were no instructions simulated in a state,
> > > but rather that we starting from the instruction, jumped around a bit,
> > > and then ended up at the same instruction before checkpointing or
> > > marking precision.
> > > 
> > > To distinguish between these two possible situations, we need to consult
> > > jump history. If it's empty or contain a single record "bridging" parent
> > > state and first instruction of processed state, then we indeed
> > > backtracked all instructions in this state. But if history is not empty,
> > > we are definitely not done yet.
> > > 
> > > Move this logic inside get_prev_insn_idx() to contain it more nicely.
> > > Use -ENOENT return code to denote "we are out of instructions"
> > > situation.
> > > 
> > > This bug was exposed by verifier_loop1.c's bounded_recursion subtest, once
> > > the next fix in this patch set is applied.
> > > 
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > Link: https://lore.kernel.org/r/20231110002638.4168352-3-andrii@kernel.org
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > 
> > Alright, this patch should target for linux-5.10.y and linux-5.15.y.
> > 
> > And better to add here with the follow tag:
> > 
> > Reported-by: Wei Wei <weiwei.danny@bytedance.com>
> > Closes: https://lore.kernel.org/all/20250605070921.GA3795@bytedance/
> 
> Thanks, I've dropped the reverts and now queued this up.  Let's push out
> a -rc2 and see how that goes through testing...

Thanks Greg.

5.15 stable tree also has this problem and after applying the above
patch to 5.15.185, the problem is also fixed. I appreciate if you can
also queue it for 5.15 stable branch, thanks.

