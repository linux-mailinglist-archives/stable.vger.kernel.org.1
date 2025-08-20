Return-Path: <stable+bounces-171918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A57B2E2C7
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 19:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4853BD2F9
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A3D221F24;
	Wed, 20 Aug 2025 17:00:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D6C36CE0D
	for <stable@vger.kernel.org>; Wed, 20 Aug 2025 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709219; cv=none; b=JJqFiU/ljDPT0P7rFPH3AI1NVbHiOJDKZQ1rMTBy5av/LIsO6V/smsC06c0PpgGOJ49AjG+secU3Q+4howPkewRnfZ2+S3yDFKVMeY6/9wN0CrxcipFFJISXT+t5vQ6GvA7BTwvefE2VIEf6l7Mzt6eGppyggekYp8HwF9yTGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709219; c=relaxed/simple;
	bh=rnm3G/177RWvkQY5hGEujcOu6NdYdVq1hsk7zN9J+y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs+J8uf09XfIbiVpGM/BtQNKgtjWScA+bh17qjMqIvOwQiWDhhyWgIsisfWa1v61D6uLSDroAOYm0B0bfT587bctYPOef0R/tkz7bwMVbWBg8jDfklZhJESMGWLXbsRFBpu2isYhlmzRGd6ZvgeY15DosyUcOzKkzK9sMQEwwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CC4C4CEE7;
	Wed, 20 Aug 2025 17:00:17 +0000 (UTC)
Date: Wed, 20 Aug 2025 18:00:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Waiman Long <llong@redhat.com>
Cc: Gu Bowen <gubowen5@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, linux-mm@kvack.org,
	Breno Leitao <leitao@debian.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v4] mm: Fix possible deadlock in kmemleak
Message-ID: <aKX_HvAK6ZopNX35@arm.com>
References: <20250818090945.1003644-1-gubowen5@huawei.com>
 <113a8332-b35c-4d00-b8b1-21c07d133f1f@redhat.com>
 <aKWrSfLD5f1r5rg_@arm.com>
 <fed73718-8001-4db6-af36-86c60e85d224@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fed73718-8001-4db6-af36-86c60e85d224@redhat.com>

On Wed, Aug 20, 2025 at 11:01:00AM -0400, Waiman Long wrote:
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 84265983f239..eb4e0af5edba 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -856,13 +856,8 @@ static void delete_object_part(unsigned long ptr, size_t size,
> 
>         raw_spin_lock_irqsave(&kmemleak_lock, flags);
>         object = __find_and_remove_object(ptr, 1, objflags);
> -       if (!object) {
> -#ifdef DEBUG
> -               kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
> -                             ptr, size);
> -#endif
> +       if (!object)
>                 goto unlock;
> -       }
> 
>         /*
>          * Create one or two objects that may result from the memory block
> @@ -882,8 +877,14 @@ static void delete_object_part(unsigned long ptr, size_t size,
> 
>  unlock:
>         raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
> -       if (object)
> +       if (object) {
>                 __delete_object(object);
> +       } else {
> +#ifdef DEBUG
> +               kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
> +                             ptr, size);
> +#endif
> +       }
> 
> Anyway, I am not against using printk_deferred_enter/exit here. It is just
> that they should be used as a last resort if there is no easy way to work
> around it.

This works for me if Gu respins the patch

Thanks.

-- 
Catalin

