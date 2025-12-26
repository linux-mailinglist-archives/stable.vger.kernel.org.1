Return-Path: <stable+bounces-203424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E20CDEC28
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 15:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B99D43005EB3
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A726D322C83;
	Fri, 26 Dec 2025 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j4tb5Ztz"
X-Original-To: stable@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528281607A4;
	Fri, 26 Dec 2025 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766758939; cv=none; b=kuGY6qfrgv/WMyqXzOlFhMf7YHeZMuL38bGUxr5wMcMXD4j7zqJ3bZfTjW8z6TYre0GMl/JsUmc2eODey+i0lItD1pFOp38uxpgDv17x6IoDD8LubfNMhNr+IdJ897aB67N5iboouZ3f2e7TDTr5vtPx/nPuPS33xgL92SV/S+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766758939; c=relaxed/simple;
	bh=ff0ntZw7Gi4F++vaU/E8El4jhspXYH4arAN2FTm/6Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcpVYIPTjyZItOhXDUluxLxFAfWbtuHbsFcujI+qdT+t2SNdQJSPsVrgHDXNdEIzAni6CG9N/aA/JEsFCstwoF8uZJ7dNaznzhZR4VLrW2ncZrFH12+vjfD8Ys6s7sFRLJM8hSA9J8SXRnp7gO6r3Dqjfmnwt1+3bX26VVTpA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j4tb5Ztz; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766758932; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9xf2HFCC6Ziw68Fb8elQMRwG16Hpctrj/C6ytUD938o=;
	b=j4tb5Ztzcn1/uId5tzxEvo3r1QVyacbIVGxkDX7K1yBQmYg3Hsnzzi2pIn2FnbMfJWO/mFhYSfm+//2SNmow431+cCx09bKKty+7EEgdgp4+lwR21jOlDVRWW0xdLw8TU2Byl2kaFlJvZlHQvEvaETDLZSV7F2WSkUedAwRvABQ=
Received: from 30.69.38.206(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvhnUlN_1766758923 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Dec 2025 22:22:11 +0800
Message-ID: <eef84292-a81f-4af0-83b4-c124932b973a@linux.alibaba.com>
Date: Fri, 26 Dec 2025 22:22:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] erofs: new file-backed stacking limit breaks
 container overlay use case in 6.12.63
To: =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 stable@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 xiang@kernel.org, Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>
References: <CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




Hi Alekséi,

On 2025/12/26 20:17, Alekséi Naidénov wrote:
> Hello,
> 
> I am reporting a regression in the 6.12 stable series related to EROFS
> file-backed mounts.
> 
> After updating from Linux 6.12.62 to 6.12.63, a previously working setup
> using OSTree-backed composefs mounts as Podman rootfs no longer works.
> 
> The regression appears to be caused by the following commit:
> 
>    34447aeedbaea8f9aad3da5b07030a1c0e124639 ("erofs: limit the level of fs
> stacking for file-backed mounts")
>    (backport of upstream commit d53cd891f0e4311889349fff3a784dc552f814b9)
> 
> ## Setup description
> 
> We use OSTree to materialize filesystem trees, which are mounted via
> composefs (EROFS + overlayfs) as a read-only filesystem. This mounted
> composefs tree is then used as a Podman rootfs, with Podman mounting a
> writable overlayfs on top for each container.
> 
> This setup worked correctly on Linux 6.12.62 and earlier.

The following issue just tracks this:
https://github.com/coreos/fedora-coreos-tracker/issues/2087

I don't think more information is needed, but I really think the EROFS
commit is needed to avoid kernel stack overflow due to nested fses.

> 
> In short, the stacking looks like:
> 
>    EROFS (file-backed)
>      -> composefs (EROFS + overlayfs with ostree repo as datadir, read-only)
>          -> Podman rootfs overlays (RW upperdir)
> 
> There is no recursive or self-stacking of EROFS.
Yes, but there are two overlayfs + one file-backed EROFS already, and
it exceeds FILESYSTEM_MAX_STACK_DEPTH.

That is overlayfs refuses to mount the nested fses.

Thanks,
Gao Xiang

