Return-Path: <stable+bounces-104324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6D69F2D1B
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 10:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2F2188328B
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 09:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62875201026;
	Mon, 16 Dec 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBHsERvd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682FA347B4
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341990; cv=none; b=XjmYXUcVX6xXcMAUtRNCxxzkPCeBKC67QGQRelNeyYuAn7Zuu8HhFU5w05akMWMZp4AazOLwN5QOquOLb5HXc/mHOx/9QOJ3CB2j99dJypBpOjIpFae05Yi+B90nCH3oj00J217ZGDsw7TAshRMTYwDvp/7cmdJ4fUZ1M8kDqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341990; c=relaxed/simple;
	bh=hrbq27qRXN5KI72b56XeNNXzWFizTi2GzU8q7E1r6bY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqj+T/yLYx65pPuAGz/3U2R7ZsMF2Xr/74I7J3oFPaLZSl3GVHlzcUvgmGDSDJkqfW0QUGZnIGf2o31lt0lakggZR29jis61DGyDG+T/zeBb4TSpZBuHJARwb2YCG2IT7i71Hg+iWnKyUIN24DQiRq7bb5Ux3ESwsn0aShpxau8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBHsERvd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso655103966b.3
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 01:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734341986; x=1734946786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d5gF1Q7o+38f7uJnVGm09gKr6aQPSRbKu2TxfoIhQ8c=;
        b=iBHsERvdA/zFO/Z60aHXUa2QabTZRQrAKxDCAxAuJHA4BEyUdtCBgjsZKaLl0A6XS/
         3/XajiDoInKSEXKtGAfnQAPXTyLWxc8YbtU8GSxNk/kSt/yegqNbkxYSKqDJi/s1jNpG
         OKJaP8c3mcJGK6eu6RwcSXZ6CzqUWqbYiT3HKw0f8HwygWld9ZQ7UiAH8PvocO90sITl
         oal6AYJKxM4qHPqpPNOqArW8iPwxa/VMgG99GygOkLf5qzRgu7/Yf6PKSCT363exVLD2
         8jJXqSJfpePZZwMtyNek3u4WBtRSI5Mx1yicC0cPFs7rzZtwV2wKIid6oak4NGfPyghH
         uUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734341986; x=1734946786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5gF1Q7o+38f7uJnVGm09gKr6aQPSRbKu2TxfoIhQ8c=;
        b=otpPY/hdLc+zHgj54eg1bjqMq4UjYwH1nJesWF6s/xwtasej2eGyG4UdqEkNz13tVH
         RqSkaDXFxp6Vrv0PIch8MmbOival42afePa3r3t/cst7eleBG8g9w/3AvhYk+tyaG1ma
         A0e1GiqBOuz2ItcaE/jatxGxNc4wESiq/Nre4mVhTcTtr1VfqkIofepqty2Vczm02D+v
         pk2XPpp4xRqdbvGLH/rdo++nxbG7zyHDlQEg40i29QeA5PyuT7txttHA4tMjoVXsiz1P
         SHhbV/UccAwB+pNPOv2pWBWE5xkChK48c4xWuoG23jhgcXnRt5KDjs+lBTvbtkjwoXMs
         T3jw==
X-Forwarded-Encrypted: i=1; AJvYcCUf0vipkYvSz+iRpTWJ827tsFKfdT6dX+faAW36PgB+fyWTLA9+lpcJjtV08Qj9T7hdznRZue0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxKmlM8g87PcXYLivJvJI8ng8k+PgroKRVbZ+UBUEUNzS1vgjG
	74JJAkKHV3yc5S43xcYP0UZmn5bKxSFZTuJC+fgiUSUB2dZEHgdG
X-Gm-Gg: ASbGncujJSZGFy7ZqiLv3NOJrXRIxbE2q3T5hrFiX84t6/iQKPSX+OaRMfCYIDEkBi5
	zCbZIbYcneJZXFBPODPtnZn1gbeBphY0GxpoXfD5B/v1DnuNnoxOnXHDadbdVvdJMBk1XiSsA5b
	imSzIIRbNk2naLrW2Fo1UzCHsde4955Q13S8enNswVDASsUXMDsA8giN+zYQ5vYu5LxqQlpHldp
	hvfT698Lf7yVplRbX3t8aNuH20cNWtBHCexyhG1ouw2pOjPrmyDyP/g3/FVvWG/K3llhNPHHP9Q
	PESslWQaIVN3F8SSQKkdW5O18WUZvA==
X-Google-Smtp-Source: AGHT+IEfrifGSX6mMSzI+lNM4N/cC+q163WrOU+++o20ATy1qBdD4mPzMcuRlW4KGkI4z8tJH3wCeg==
X-Received: by 2002:a17:906:3191:b0:aa5:1a1c:d0a2 with SMTP id a640c23a62f3a-aab779d16f0mr820457766b.34.1734341985860;
        Mon, 16 Dec 2024 01:39:45 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963c54adsm304142966b.192.2024.12.16.01.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 01:39:45 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Dec 2024 10:39:44 +0100
To: gregkh@linuxfoundation.org
Cc: andrii@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] bpf,perf: Fix invalid prog_array access
 in" failed to apply to 5.15-stable tree
Message-ID: <Z1_1YKhjE1FSBAlO@krava>
References: <2024121506-pancreas-mosaic-0ae0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024121506-pancreas-mosaic-0ae0@gregkh>

On Sun, Dec 15, 2024 at 10:02:07AM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

hi,
there's conflict because 5.15.y is not getting [1] fix (because 5.15.y does not have [2]),
I'll send new backport

jirka


[1] ef1b808e3b7c bpf: Fix UAF via mismatching bpf_prog/attachment RCU flavors
[2] 8c7dcb84e3b7 bpf: implement sleepable uprobes by chaining gps

> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 978c4486cca5c7b9253d3ab98a88c8e769cb9bbd
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121506-pancreas-mosaic-0ae0@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 978c4486cca5c7b9253d3ab98a88c8e769cb9bbd Mon Sep 17 00:00:00 2001
> From: Jiri Olsa <jolsa@kernel.org>
> Date: Sun, 8 Dec 2024 15:25:07 +0100
> Subject: [PATCH] bpf,perf: Fix invalid prog_array access in
>  perf_event_detach_bpf_prog
> 
> Syzbot reported [1] crash that happens for following tracing scenario:
> 
>   - create tracepoint perf event with attr.inherit=1, attach it to the
>     process and set bpf program to it
>   - attached process forks -> chid creates inherited event
> 
>     the new child event shares the parent's bpf program and tp_event
>     (hence prog_array) which is global for tracepoint
> 
>   - exit both process and its child -> release both events
>   - first perf_event_detach_bpf_prog call will release tp_event->prog_array
>     and second perf_event_detach_bpf_prog will crash, because
>     tp_event->prog_array is NULL
> 
> The fix makes sure the perf_event_detach_bpf_prog checks prog_array
> is valid before it tries to remove the bpf program from it.
> 
> [1] https://lore.kernel.org/bpf/Z1MR6dCIKajNS6nU@krava/T/#m91dbf0688221ec7a7fc95e896a7ef9ff93b0b8ad
> 
> Fixes: 0ee288e69d03 ("bpf,perf: Fix perf_event_detach_bpf_prog error handling")
> Reported-by: syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/bpf/20241208142507.1207698-1-jolsa@kernel.org
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a403b05a7091..1b8db5aee9d3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2250,6 +2250,9 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>  		goto unlock;
>  
>  	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
> +	if (!old_array)
> +		goto put;
> +
>  	ret = bpf_prog_array_copy(old_array, event->prog, NULL, 0, &new_array);
>  	if (ret < 0) {
>  		bpf_prog_array_delete_safe(old_array, event->prog);
> @@ -2258,6 +2261,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>  		bpf_prog_array_free_sleepable(old_array);
>  	}
>  
> +put:
>  	/*
>  	 * It could be that the bpf_prog is not sleepable (and will be freed
>  	 * via normal RCU), but is called from a point that supports sleepable
> 

