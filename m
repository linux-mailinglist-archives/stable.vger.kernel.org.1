Return-Path: <stable+bounces-74133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2585F972B38
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953C9B239DA
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC4317C9B9;
	Tue, 10 Sep 2024 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vtwlE8p+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEFA17E00F
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954835; cv=none; b=eUjoya4tCeEEKHbuqGPgMZREHcF+APYnOSeqStbGL6RiOtRsefZ2h/VXIBnMlu6rkvD7wDodO8YDN7U0HAi9ZRVGBowXXBpMzbtsMQM/0dw9eocX8Rcl5LS2VHCmdWJTxK5YKl95H89tcQeTH9yrCTRerHYHznEd09NcA4EGv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954835; c=relaxed/simple;
	bh=mqO8eTuIMcFKXwiOXlhhWVxknS5LDG9KlEwbD3zQsis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6M7iBXHKffDHshZcB309V4lZh7a/NQIkxv4SvMFZndY+OatXG2Vcd6bGnECl+8h8g3dN/JCSA3b5FUTwXooBrnXVBF9MTrirc3OkmeIzf1yttwLPK0sHJ/5O4E2Halo7Ci6fYJgc8YF6lvKXq4ytmlhdU5SZGaZgB5kHxL7Ja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vtwlE8p+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40A2C4CEC6;
	Tue, 10 Sep 2024 07:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725954835;
	bh=mqO8eTuIMcFKXwiOXlhhWVxknS5LDG9KlEwbD3zQsis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vtwlE8p+Tz/+DQcLqEzq+9DRjT6vjQpxWVz/HKFm0fSUbqC7IzSuQTzVn4SNDAUm8
	 eiwVHwXJNXh++5SS+R4f6QKlEFTuRDUErLY0Hgpf0jd9im+WZMWFem7Kfw12N8ZTrZ
	 fIxvt0BB6ItbOa/hx8lXjGtOxRQsB6D/3PrdhC2I=
Date: Tue, 10 Sep 2024 09:53:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: stable@vger.kernel.org,
	syzbot+958967f249155967d42a@syzkaller.appspotmail.com,
	Yonghong Song <yhs@fb.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH 6.1.y] bpf: Silence a warning in btf_type_id_size()
Message-ID: <2024091044-exhaust-yogurt-d9e7@gregkh>
References: <20240909231017.340597-1-djahchankoike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909231017.340597-1-djahchankoike@gmail.com>

On Mon, Sep 09, 2024 at 08:09:58PM -0300, Diogo Jahchan Koike wrote:
> From: Yonghong Song <yhs@fb.com>
> 
> commit e6c2f594ed961273479505b42040782820190305 upstream.
> 
> syzbot reported a warning in [1] with the following stacktrace:
>   WARNING: CPU: 0 PID: 5005 at kernel/bpf/btf.c:1988 btf_type_id_size+0x2d9/0x9d0 kernel/bpf/btf.c:1988
>   ...
>   RIP: 0010:btf_type_id_size+0x2d9/0x9d0 kernel/bpf/btf.c:1988
>   ...
>   Call Trace:
>    <TASK>
>    map_check_btf kernel/bpf/syscall.c:1024 [inline]
>    map_create+0x1157/0x1860 kernel/bpf/syscall.c:1198
>    __sys_bpf+0x127f/0x5420 kernel/bpf/syscall.c:5040
>    __do_sys_bpf kernel/bpf/syscall.c:5162 [inline]
>    __se_sys_bpf kernel/bpf/syscall.c:5160 [inline]
>    __x64_sys_bpf+0x79/0xc0 kernel/bpf/syscall.c:5160
>    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>    do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> With the following btf
>   [1] DECL_TAG 'a' type_id=4 component_idx=-1
>   [2] PTR '(anon)' type_id=0
>   [3] TYPE_TAG 'a' type_id=2
>   [4] VAR 'a' type_id=3, linkage=static
> and when the bpf_attr.btf_key_type_id = 1 (DECL_TAG),
> the following WARN_ON_ONCE in btf_type_id_size() is triggered:
>   if (WARN_ON_ONCE(!btf_type_is_modifier(size_type) &&
>                    !btf_type_is_var(size_type)))
>           return NULL;
> 
> Note that 'return NULL' is the correct behavior as we don't want
> a DECL_TAG type to be used as a btf_{key,value}_type_id even
> for the case like 'DECL_TAG -> STRUCT'. So there
> is no correctness issue here, we just want to silence warning.
> 
> To silence the warning, I added DECL_TAG as one of kinds in
> btf_type_nosize() which will cause btf_type_id_size() returning
> NULL earlier without the warning.
> 
>   [1] https://lore.kernel.org/bpf/000000000000e0df8d05fc75ba86@google.com/
> 
> Reported-by: syzbot+958967f249155967d42a@syzkaller.appspotmail.com
> Signed-off-by: Yonghong Song <yhs@fb.com>
> Link: https://lore.kernel.org/r/20230530205029.264910-1-yhs@fb.com
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> (cherry picked from commit e6c2f594ed961273479505b42040782820190305)
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
> ---
>  kernel/bpf/btf.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7582ec4fd413..2c58a6c3f978 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -466,10 +466,16 @@ static bool btf_type_is_fwd(const struct btf_type *t)
>  	return BTF_INFO_KIND(t->info) == BTF_KIND_FWD;
>  }
>  
> +static bool btf_type_is_decl_tag(const struct btf_type *t)
> +{
> +	return BTF_INFO_KIND(t->info) == BTF_KIND_DECL_TAG;
> +}
> +
>  static bool btf_type_nosize(const struct btf_type *t)
>  {
>  	return btf_type_is_void(t) || btf_type_is_fwd(t) ||
> -	       btf_type_is_func(t) || btf_type_is_func_proto(t);
> +	       btf_type_is_func(t) || btf_type_is_func_proto(t) ||
> +	       btf_type_is_decl_tag(t);
>  }
>  
>  static bool btf_type_nosize_or_null(const struct btf_type *t)
> @@ -492,11 +498,6 @@ static bool btf_type_is_datasec(const struct btf_type *t)
>  	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
>  }
>  
> -static bool btf_type_is_decl_tag(const struct btf_type *t)
> -{
> -	return BTF_INFO_KIND(t->info) == BTF_KIND_DECL_TAG;
> -}
> -
>  static bool btf_type_is_decl_tag_target(const struct btf_type *t)
>  {
>  	return btf_type_is_func(t) || btf_type_is_struct(t) ||
> -- 
> 2.43.0
> 
> 

Now queued up, thanks.

greg k-h

