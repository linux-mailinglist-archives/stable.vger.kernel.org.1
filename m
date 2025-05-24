Return-Path: <stable+bounces-146232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EB0AC2E4C
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 10:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873EC4A6720
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 08:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B923320DF4;
	Sat, 24 May 2025 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="YY1nrYvo"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D414C6E
	for <stable@vger.kernel.org>; Sat, 24 May 2025 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748076363; cv=none; b=blIfjk3h/KLI/dQLshuPaOnnrx8EESpoqrAYlom6FBWS8614Xu0w5AxLsMM4/Ri11sMAqU22LzxrV8kmXCBvMhfk6o4u1h3Xf/mJ5izfjV9uub/neo+ltIxhdBGbB4E6Ld+tnrDFdLxJX8qN7IbqZObE0iR1mfDBK0Tp3+jb9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748076363; c=relaxed/simple;
	bh=NmDNS5zf7QTX7uW3JD05QSNWZ9rwxxxv0+F1Y0RgjK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Qt/1kyRFKaDy9WZhFyIa7JnOO7hmqot9IXVE0Zo2h1SCT7nflSBNplxOHfM+7ERNYRfXc4bit3HpVxuNF0SEfc+De/uIiKBAKcIV0jOomSLudmeSAL/hxiP9yRCSZ64+IO+Ct4ftGeQrp0aQBaOS0J/ITcVkz8Ik/+3kif3Yoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=YY1nrYvo; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1748076028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27JSk38LhIsSAuHUvbrg5vTv9ei6hNot7ltF9fPT8ng=;
	b=YY1nrYvooIoae0pi5IxdIBBhHsusbvN4nDIp9YXgowOVIJ6OWs9TSrDi+/ynmYv3JtJ4Wb
	oyyxx/NwvvTAdLCA==
Message-ID: <97e0dda6-b2f3-4433-b19c-dbc5d538669c@hardfalcon.net>
Date: Sat, 24 May 2025 10:40:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "libbpf: Pass BPF token from find_prog_btf_id to
 BPF_BTF_GET_FD_BY_ID" has been added to the 6
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20250522210809.3119959-1-sashal () kernel ! org>
Content-Language: en-US, de-DE
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <20250522210809.3119959-1-sashal () kernel ! org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[2025-05-22 23:08] Sasha Levin:
> This is a note to let you know that I've just added the patch titled
> 
>      libbpf: Pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
> 
> to the 6.14-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       libbpf-pass-bpf-token-from-find_prog_btf_id-to-bpf_b.patch
> and it can be found in the queue-6.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 7a8beec7026564efe57ebf9c4c568ed0071f2e39
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> Date:   Mon Mar 17 17:40:38 2025 +0000
> 
>      libbpf: Pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
>      
>      [ Upstream commit 974ef9f0d23edc1a802691c585b84514b414a96d ]
>      
>      Pass BPF token from bpf_program__set_attach_target to
>      BPF_BTF_GET_FD_BY_ID bpf command.
>      When freplace program attaches to target program, it needs to look up
>      for BTF of the target, this may require BPF token, if, for example,
>      running from user namespace.
>      
>      Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>      Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>      Acked-by: Yonghong Song <yonghong.song@linux.dev>
>      Link: https://lore.kernel.org/bpf/20250317174039.161275-4-mykyta.yatsenko5@gmail.com
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 359f73ead6137..a9c3e33d0f8a9 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1097,7 +1097,7 @@ int bpf_map_get_fd_by_id(__u32 id)
>   int bpf_btf_get_fd_by_id_opts(__u32 id,
>   			      const struct bpf_get_fd_by_id_opts *opts)
>   {
> -	const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
> +	const size_t attr_sz = offsetofend(union bpf_attr, fd_by_id_token_fd);
>   	union bpf_attr attr;
>   	int fd;
>   
> @@ -1107,6 +1107,7 @@ int bpf_btf_get_fd_by_id_opts(__u32 id,
>   	memset(&attr, 0, attr_sz);
>   	attr.btf_id = id;
>   	attr.open_flags = OPTS_GET(opts, open_flags, 0);
> +	attr.fd_by_id_token_fd = OPTS_GET(opts, token_fd, 0);
>   
>   	fd = sys_bpf_fd(BPF_BTF_GET_FD_BY_ID, &attr, attr_sz);
>   	return libbpf_err_errno(fd);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 435da95d20589..777627d33d257 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -487,9 +487,10 @@ LIBBPF_API int bpf_link_get_next_id(__u32 start_id, __u32 *next_id);
>   struct bpf_get_fd_by_id_opts {
>   	size_t sz; /* size of this struct for forward/backward compatibility */
>   	__u32 open_flags; /* permissions requested for the operation on fd */
> +	__u32 token_fd;
>   	size_t :0;
>   };
> -#define bpf_get_fd_by_id_opts__last_field open_flags
> +#define bpf_get_fd_by_id_opts__last_field token_fd
>   
>   LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
>   LIBBPF_API int bpf_prog_get_fd_by_id_opts(__u32 id,
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 560b519f820e2..03cc7c46c16b5 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1619,12 +1619,18 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
>   	return btf;
>   }
>   
> -struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
> +struct btf *btf_load_from_kernel(__u32 id, struct btf *base_btf, int token_fd)
>   {
>   	struct btf *btf;
>   	int btf_fd;
> +	LIBBPF_OPTS(bpf_get_fd_by_id_opts, opts);
> +
> +	if (token_fd) {
> +		opts.open_flags |= BPF_F_TOKEN_FD;
> +		opts.token_fd = token_fd;
> +	}
>   
> -	btf_fd = bpf_btf_get_fd_by_id(id);
> +	btf_fd = bpf_btf_get_fd_by_id_opts(id, &opts);
>   	if (btf_fd < 0)
>   		return libbpf_err_ptr(-errno);
>   
> @@ -1634,6 +1640,11 @@ struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
>   	return libbpf_ptr(btf);
>   }
>   
> +struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf)
> +{
> +	return btf_load_from_kernel(id, base_btf, 0);
> +}
> +
>   struct btf *btf__load_from_kernel_by_id(__u32 id)
>   {
>   	return btf__load_from_kernel_by_id_split(id, NULL);
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 194809da51725..6b436ec872b0f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9959,7 +9959,7 @@ int libbpf_find_vmlinux_btf_id(const char *name,
>   	return libbpf_err(err);
>   }
>   
> -static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
> +static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd, int token_fd)
>   {
>   	struct bpf_prog_info info;
>   	__u32 info_len = sizeof(info);
> @@ -9979,7 +9979,7 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
>   		pr_warn("The target program doesn't have BTF\n");
>   		goto out;
>   	}
> -	btf = btf__load_from_kernel_by_id(info.btf_id);
> +	btf = btf_load_from_kernel(info.btf_id, NULL, token_fd);
>   	err = libbpf_get_error(btf);
>   	if (err) {
>   		pr_warn("Failed to get BTF %d of the program: %s\n", info.btf_id, errstr(err));
> @@ -10062,7 +10062,7 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
>   			pr_warn("prog '%s': attach program FD is not set\n", prog->name);
>   			return -EINVAL;
>   		}
> -		err = libbpf_find_prog_btf_id(attach_name, attach_prog_fd);
> +		err = libbpf_find_prog_btf_id(attach_name, attach_prog_fd, prog->obj->token_fd);
>   		if (err < 0) {
>   			pr_warn("prog '%s': failed to find BPF program (FD %d) BTF ID for '%s': %s\n",
>   				prog->name, attach_prog_fd, attach_name, errstr(err));
> @@ -12858,7 +12858,7 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
>   	if (target_fd) {
>   		LIBBPF_OPTS(bpf_link_create_opts, target_opts);
>   
> -		btf_id = libbpf_find_prog_btf_id(attach_func_name, target_fd);
> +		btf_id = libbpf_find_prog_btf_id(attach_func_name, target_fd, prog->obj->token_fd);
>   		if (btf_id < 0)
>   			return libbpf_err_ptr(btf_id);
>   
> @@ -13679,7 +13679,7 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
>   
>   	if (attach_prog_fd) {
>   		btf_id = libbpf_find_prog_btf_id(attach_func_name,
> -						 attach_prog_fd);
> +						 attach_prog_fd, prog->obj->token_fd);
>   		if (btf_id < 0)
>   			return libbpf_err(btf_id);
>   	} else {
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index de498e2dd6b0b..76669c73dcd16 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -409,6 +409,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
>   int btf_load_into_kernel(struct btf *btf,
>   			 char *log_buf, size_t log_sz, __u32 log_level,
>   			 int token_fd);
> +struct btf *btf_load_from_kernel(__u32 id, struct btf *base_btf, int token_fd);
>   
>   struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
>   void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,


Hi, this patch breaks the build for Kernel 6.14.8 with all the other 
patches from 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.14?id=71ea03905d96af45fbbd377b7ea848e5ea5f2b39 
applied on top. A backported version of the same patch is also in 
queue-6.12, but I haven't tested if that one also breaks the build for 
Kernel 6.12.30.


Regards
Pascal

