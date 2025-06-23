Return-Path: <stable+bounces-155356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A72AE3EB8
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0233B7277
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1981ACEDE;
	Mon, 23 Jun 2025 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BGMu4WMM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F121188CC9
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679768; cv=none; b=FmrPXInEKMXbP26uVHhbE8iHesc0Rrgvc2jgKPXA74tg2jrvA54OPt3n83NG9KbBwFYpV/nHxNEOU+K1u7nL7YuGjHjSNNF0567TGab4GhStmdtqajXLMh2si4azXkNYvVxN27PZDgmyRDUY3M7GVTg9I4yGVzylERJc3faCRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679768; c=relaxed/simple;
	bh=uM4EdnLIuHjbpaFCtrbzRLAunHEqX6/gBWjXJzNGkJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dygNHWZlpx+7uDZSDpxwGBMJ6q6JmEBKT2Z2KZ+Q0zc6d1EFbzWJ7tNZevCQrhsfSgT4ZpZvNa9WHIyVX0XlT4346WT/8FzcNdvbCJMUMun3RZP5QHWx2Pzz2Ye0snw7tfmS1ES1BYoyIKY23PKph9fPliSOPh48xSdlQuuXykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BGMu4WMM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3122a63201bso2869278a91.0
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 04:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750679766; x=1751284566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/f0TwhQJhVEIWvNcSfadL2Sm2uxpvd3yJV7/osAtIkA=;
        b=BGMu4WMM+5ukogHavrDjdCFgHGLBLriGib8QomBLaBJQ/Ow4x+ABX/55vQATuXY9A0
         uYHjA4iQGZkFXIpw/3uqcqtLHC4/5FRP1zkrVcDWdfqi5c+JwITTKfJcH2hdFSQXICHT
         QwsJ4kwCtGqnG4B1Ni7xfCjWWuCv2DF9BMuZx6ma6y6buQ7edLoY00LBl/QKik73bjip
         8ezc8G2GQlO10O5ULjLiSYYYI5hNdw1Q6nyVMZYzrGJppHalkWVmyJya1yf1MCNPU1vI
         SpXv1v1G25ppd4C5zFa0eaXVJWtnrBty7kuK2GtxzFZNtgCKwXfmDdW7/CCGLhO/TZBV
         JUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679766; x=1751284566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f0TwhQJhVEIWvNcSfadL2Sm2uxpvd3yJV7/osAtIkA=;
        b=dN0OIDWBFHI+SAS0xqK5PcZZSwiqKux67h1zdSjFsaem7A4bCQWAS2LAYP+34kf3Ye
         exO1LQwkREk1Mk941ODKCZ1SwBA+ErtxHAns9N1OgiQfuqPlT3LymlO12jXCTJXG83dU
         Hx6CAHThD8yZmjO1crvzmFKZWBmGaP6ZKtliV8nzAQiN17ZrVRgK/iTdwQZIi9exWtWL
         hpEW41q9KtXX/HP7cRXllWSNhLzZx89K72JZu8dUTv6Zth8SyqxyxgXS0yjGOvQCjyfu
         ilYUghTnEM/17czh/l5QugXWuTfp7TfbAQQvmPYwX4mJhL1fBTuz9xN5Vz/Cb5sFvtQf
         6ORQ==
X-Gm-Message-State: AOJu0Yy+Wvr/LhoMLb5nN3QGdAe/hAq2tUFElkzH1W81LSt7pZk8pvb+
	tPxx8G6dDCXkzn3EtgVt8ymYfJWJfp4WuvLN5LyF05XWcB4zTTD+0JG0nB+2O4NtGg==
X-Gm-Gg: ASbGncv+I+6/YH6Km/15K+M3G3tLWLpNMwkL6uWHY9TaVxlnh8pnYYWkKR9sGmdNbRj
	QirHmpg1xa6qBY+dp7gDuPbJ4xmjk3K1VybDrDpszMU5dxiHYRYf/SADoCtJD1I9W14pyWAIItK
	GFlClkAKHw1vIVP6c+IVgNOclsnH72n4GYtDzCJTIvnMDXoeu2rGeG4esK6jUZTav6zrHhoWGFr
	R7s9qr9g8PtfTJs9E3SYE9yhSB/u91xS/E05S/mHTq7EAx2KWLkEyK1gFi+ecU0sw7WyJweuRD+
	TFBfDEmYb+Q/2uyIBVRMcq6177kEfi0tHyYPeWLenalpxVzNPy+iUCORXRHmp9hC9u8vJLE03PY
	n7sRc4aM=
X-Google-Smtp-Source: AGHT+IFjAxQCVUvIgF9vPkoblrX2l/zM+9Wvc0RXSeVS1gWSJEjjeN8KJCcR9Usr5DVeJtoc2UCzfQ==
X-Received: by 2002:a17:90a:d64f:b0:312:f0d0:bb0 with SMTP id 98e67ed59e1d1-3159d648319mr20070127a91.12.1750679766505;
        Mon, 23 Jun 2025 04:56:06 -0700 (PDT)
Received: from bytedance ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159e06acfesm8617380a91.36.2025.06.23.04.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 04:56:05 -0700 (PDT)
Date: Mon, 23 Jun 2025 19:55:52 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Pu Lehui <pulehui@huawei.com>,
	Luiz Capitulino <luizcap@amazon.com>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: Re: Host panic in bpf verifier when loading bpf prog in 5.10 stable
 kernel
Message-ID: <20250623115552.GA294@bytedance>
References: <20250605070921.GA3795@bytedance>
 <20250616070617.GA66@bytedance>
 <2025062344-width-unvisited-a96f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025062344-width-unvisited-a96f@gregkh>

On Mon, Jun 23, 2025 at 10:17:15AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 16, 2025 at 03:06:17PM +0800, Aaron Lu wrote:
> > Ping?
> > 
> > On Thu, Jun 05, 2025 at 03:09:21PM +0800, Aaron Lu wrote:
> > > Hello,
> > > 
> > > Wei reported when loading his bpf prog in 5.10.200 kernel, host would
> > > panic, this didn't happen in 5.10.135 kernel. Test on latest v5.10.238
> > > still has this panic.
> > 
> > If a fix is not easy for these stable kernels, I think we should revert
> > this commit? Because for whatever bpf progs, the bpf verifier should not
> > panic the kernel.
> > 
> > Regarding revert, per my test, the following four commits in linux-5.10.y
> > branch have to be reverted and after that, the kernel does not panic
> > anymore:
> > commit 2474ec58b96d("bpf: allow precision tracking for programs with subprogs")
> > commit 7ca3e7459f4a("bpf: stop setting precise in current state")
> > commit 1952a4d5e4cf("bpf: aggressively forget precise markings during
> > state checkpointing")
> > commit 4af2d9ddb7e7("selftests/bpf: make test_align selftest more
> > robust")
> 
> Can you send the reverts for this, so that you get credit for finding
> and fixing this issue, and you can put the correct wording in the commit
> messages for why they need to be reverted?

No problem, thanks for the info.

I have sent them:
https://lore.kernel.org/stable/20250623115403.299-1-ziqianlu@bytedance.com/

