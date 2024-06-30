Return-Path: <stable+bounces-56141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7588A91D250
	for <lists+stable@lfdr.de>; Sun, 30 Jun 2024 17:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC631C208DD
	for <lists+stable@lfdr.de>; Sun, 30 Jun 2024 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512631534FB;
	Sun, 30 Jun 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GcCbrExb"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ABC152536;
	Sun, 30 Jun 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719761213; cv=none; b=AkyAUnF5gEHr/vmfLeBUM7ahlwpGpudqAfVznRUTVu88EeAEgClJeUjmzlYCzSSts419Q62M20Ib9jQMdEkzO0xNtPu0yfZrMBVbQL0utL2hbIfTzc4Rh8J7TML8k3ce9fwYa7CJtykp7zkKLWWxIZVhhmFXJX+17GoFR1cYNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719761213; c=relaxed/simple;
	bh=vO1NLBQxNQfA2xpyrK/rc/jpoKmQGGIJOtTb9QALIFo=;
	h=Message-ID:Date:From:To:cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snNyBgLwRcl6akSt+s14gCM0n9f9va5/HUwQ0jJh5QFR9FyOcw+4Wd/Avt10m4iAXEhodddY9vqPQyf4xI1oj3C6Uii5zI2OHUgCuEqH47UhmtDexRemBtaqvaaGVEOJMfkVQKXwhzjWucZOjOnpdNQS9guFpi1dGsFhwz7JyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GcCbrExb; arc=none smtp.client-ip=203.205.251.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719760902; bh=lZ3i5L1HLdTTCLMU39/mrQkhmO03fgVVzrbXx5lN1sk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=GcCbrExbiyLxe/FpoK0j8Rp0VI9RbN79etRgW/XlBCRpSjDiFL9SRdoWiqGQfE4u7
	 f++YZ0HU0nC5gXnNmn/WbaPTuTT55Gv/k1CGIaUx0mWSzHu131als7CsrbI/OZssm+
	 +tmxIHVUoFgHqeBcJ4mEMesczdT9dIfkvojfsgTk=
Received: from LAPTOP-PMPPB61H ([36.129.28.219])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 210974CF; Sun, 30 Jun 2024 23:08:16 +0800
X-QQ-mid: xmsmtpt1719760096te8gy3gs2
Message-ID: <tencent_6866D69439F77A09338872DC0398A84CB908@qq.com>
X-QQ-XMAILINFO: N2bAIxLK0elnc+9Xe7d2ddVQ9KxnEcqKNXLiYmjhiz5xuush6I9PgckgkgBUKT
	 tw3JK3gjPwyFA4jP9L00VIh1g+z5JHTzPi5lJcBD60NOsuSz9iy/wzc7QyoY80uvRsOtQAvSQXKm
	 o3xmxXWZWcmJXkdAYNHjaoApocQe8zXFmEvA0gEJi7b0la7aVpKvk2TOgh2hFv1hCuGtIUlWPqhq
	 59IhAo5e4+RoLzujf3IdYAICX5JlEDDzOrcr47MhBMzcuS3/ZOTQsPmIm1ltNPmg6FmPAVdYklvt
	 JhEHUqGEcXXf4I65JS2A+08tEOoUIIe5+yfRir0818kJTEel2R3OQIvFiDPFL2igZY2CKHMX8aw2
	 qqlMAEp2MsEYh5tkFFzg76XnDqJxngCW7aj1o7Yk/VBUw7fdilhG24mDROEkQAvqgJX6kCIf/CA4
	 esea8wg/EZZI7dr+lcaduRd7eto3BrLzDHPOvV8+a2Eowlu0E1ci+TdSkjTHoNoH0c2R9/BwP/yo
	 OpQ7plDI/Zsb++Au5SaV0f4YPTLRCaJG6BNe/kGVSskq1AxTeFR4zqgVC8VtDU1Ecltcgo+ckYQb
	 f4pfs8Aak5Vp70ARkteKdrvfCBHDBl95ctSiDyroarJ5pwuXsfvW26xsILCsBRHH7PpNc/ySx1Oa
	 +ttpX3X2HxOIqDE2nTUV+bTrwD8/OGMQgD7Do3jAXVXdowD3WYExSdJ0YAQ9R8eo4KpYUaACNGv0
	 3VvKyL6jdfedDoor17Vqe/LupGWElQ+jlSwajbwjONkY31OggxIpQf5T3n/SDaqNiz5MCbYsdhGH
	 HhbFPiox4p516EryjFJzOdA49VaP8QIJsHKUQP4QE5ktn9l2O0MN1xY6j9uj0bDUjLfpcwuqy7hf
	 d4Q7TdanBXQyOx9YPjoDsvR5sFdOSsWMepNyIjOl4HNjVTgvGxIEIELpBWXftC7B2JvMzB0OOVfh
	 1RfwGCmgWfy45v+IPuEhNnMB5X1/TixOvPcoYCla6wi6JpSDN/Ok3nPa8B/ZVi9ptAGRIFC3k=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
Date: Sun, 30 Jun 2024 23:08:17 +0800
From: Zhou congjie <zcjie0802@qq.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>, gregkh@linuxfoundation.org, 
    rafael@kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com
cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kobject_uevent: Fix OOB access within
 zap_modalias_env()
In-Reply-To: <1716524403-5415-1-git-send-email-quic_zijuhu@quicinc.com>
X-OQ-MSGID: <77765b34-80c6-6371-06b5-50be2a72e5de@qq.com>
References: <1716524403-5415-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 May 2024, Zijun Hu wrote:

> Subject: [PATCH] kobject_uevent: Fix OOB access within zap_modalias_env()
> zap_modalias_env() wrongly calculates size of memory block
> to move, so maybe cause OOB memory access issue, fixed by
> correcting size to memmove.
> 
> Fixes: 9b3fa47d4a76 ("kobject: fix suppressing modalias in uevents delivered over netlink")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  lib/kobject_uevent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 03b427e2707e..f153b4f9d4d9 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -434,7 +434,7 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
>  
>  		if (i != env->envp_idx - 1) {
>  			memmove(env->envp[i], env->envp[i + 1],
> -				env->buflen - len);
> +				env->buf + env->buflen - env->envp[i + 1]);
>  
>  			for (j = i; j < env->envp_idx - 1; j++)
>  				env->envp[j] = env->envp[j + 1] - len;
> 

I notice it too.

In the debug, I find that length of "env->buflen - len" is definitely 
larger than  "env->buf + env->buflen - env->envp[i+1". So memmove() just 
copy some extra '\0', and the problem will not happen when the length of 
env variables is much smaller than 2048. That is why the problem is 
difficult to be observed.

But when the length of env variables is close to 2048 or even more than 
2048, the memmove will access the memory not belong to env->buf[2048]. 


