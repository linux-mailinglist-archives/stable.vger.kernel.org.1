Return-Path: <stable+bounces-50096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0099024AA
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 16:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D08B2829F
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E409A12FF88;
	Mon, 10 Jun 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KUtjUmW5"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9669132113;
	Mon, 10 Jun 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031028; cv=none; b=iNuB/9dgxND1Ug8vo3S3Qm+/r9Yraak2dYdLUMWD3y9xeHgMDfPucSmixXJKP4XiMkil2tCrbbbDaUDwoO8kw3yfWcifImFRopsvAOMGnfUXpz5uLpQq/YeXHKl7evxqAZxL6BZMf2EyMylbCYnekXZDYWb1aqMpef5DbJ3QiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031028; c=relaxed/simple;
	bh=Bu/1Eza/p7DLVmqlX9siAp8nBNaky3a3wcHUbzcBwJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuT5SjgNsm3y2tOddGu6BPCcvruoEuOut5TAuh+p7+VpQSwpqmCGAetnYh4mGK4PZj9872eYVpBF05BOw9bKEDVWiZPUfsSi5QfYGU7GC209BDFOil4c+uEwioIlMZW7yAEImmbRJWIUhb+mSXGwMimJnjCi6oo5S5mNpvoIkvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KUtjUmW5; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=DZquqoa+k8YMi8hvyXrMyI884vgcezINgyGLYQPzP+o=;
	b=KUtjUmW5QDfyHwmKFr2qs6s7/OywIOhBoCxWnYAjif8VWO9T84bmt6OlunBWqf
	tt7vngQt52w2iJnkQMEZNqFM51QL9v5iyySeMT4bPiQLlPXWHpa17jM3HxB4R+fl
	Uzmjk7MNQtGFCHLXyVAaNEkNLi8oUe7vUHGwv/tTStnwI=
Received: from [192.168.1.26] (unknown [183.195.6.47])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wDn77NEEmdmGNrcCQ--.11657S2;
	Mon, 10 Jun 2024 22:48:36 +0800 (CST)
Message-ID: <59380ae7-47f6-4a3d-a3e1-bc8b5762086c@163.com>
Date: Mon, 10 Jun 2024 22:48:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kobject_uevent: Fix OOB access within
 zap_modalias_env()
To: Zijun Hu <quic_zijuhu@quicinc.com>, gregkh@linuxfoundation.org,
 rafael@kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1717074877-11352-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <1717074877-11352-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDn77NEEmdmGNrcCQ--.11657S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF48Gw1ftr45GF4DZr17trb_yoW8ZFyDp3
	WfZr43K34UtFn7Jw1SvFs8WF1Uu34kWrnxGa4rWFyrJrW5Zrn7tFy8Jr1kWrWjyFykA3Wx
	AF12q3ZFka4DJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRXyCXUUUUU=
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbiyR35NWV4JkR3BgABsX



On 2024/5/30 21:14, Zijun Hu wrote:
> zap_modalias_env() wrongly calculates size of memory block to move, so
> will cause OOB memory access issue if variable MODALIAS is not the last
> one within its @env parameter, fixed by correcting size to memmove.
> 
> Fixes: 9b3fa47d4a76 ("kobject: fix suppressing modalias in uevents delivered over netlink")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> V3: Correct inline comments and take Dmitry's suggestion
> V2: Correct commit messages and add inline comments
> 
> Previous discussion links:
> https://lore.kernel.org/lkml/ZlYo20ztfLWPyy5d@google.com/
> https://lore.kernel.org/lkml/0b916393-eb39-4467-9c99-ac1bc9746512@quicinc.com/T/#m8d80165294640dbac72f5c48d14b7ca4f097b5c7
> 
>  lib/kobject_uevent.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 03b427e2707e..b7f2fa08d9c8 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -433,8 +433,23 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
>  		len = strlen(env->envp[i]) + 1;
>  
>  		if (i != env->envp_idx - 1) {
> +			/* @env->envp[] contains pointers to @env->buf[]
> +			 * with @env->buflen chars, and we are removing
> +			 * variable MODALIAS here pointed by @env->envp[i]
> +			 * with length @len as shown below:
> +			 *
> +			 * 0               @env->buf[]      @env->buflen
> +			 * ---------------------------------------------
> +			 * ^             ^              ^              ^
> +			 * |             |->   @len   <-| target block |
> +			 * @env->envp[0] @env->envp[i]  @env->envp[i + 1]
> +			 *
> +			 * so the "target block" indicated above is moved
> +			 * backward by @len, and its right size is
> +			 * @env->buflen - (@env->envp[i + 1] - @env->envp[0]).
> +			 */
>  			memmove(env->envp[i], env->envp[i + 1],
> -				env->buflen - len);
> +				env->buflen - (env->envp[i + 1] - env->envp[0]));
>  
>  			for (j = i; j < env->envp_idx - 1; j++)
>  				env->envp[j] = env->envp[j + 1] - len;

Reviewed-by: Lk Sii <lk_sii@163.com>


