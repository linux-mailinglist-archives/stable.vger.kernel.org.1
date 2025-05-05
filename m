Return-Path: <stable+bounces-139641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D5CAA8ED4
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 11:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0805B7A5E71
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E4E1F416C;
	Mon,  5 May 2025 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=beldev.am header.i=@beldev.am header.b="FSk5Eozo"
X-Original-To: stable@vger.kernel.org
Received: from server4.hayhost.am (server4.hayhost.am [2.56.206.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335471A5BAE;
	Mon,  5 May 2025 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=2.56.206.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435906; cv=none; b=GXA4eZ5R/XxAe3QRaqzHJ69vX86nOuFEFUOSdNdXazPP+yGRP+O83hTOY0NIJKRD8TlplkJPNNVglQJKiNSxFDeaeyzrABaf5YjjRVwTCp42vHg+BZWA18+QV9J7T394gCv/0q1308ohU6fBmmpO0R0B3T6VmebUfT3od6OthNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435906; c=relaxed/simple;
	bh=4lJgME2oQsKohN+PPgjLtwbT1d7nWkf0Q0Ds6OawkX8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tB7+SiHwfNljYRKRc0/ApNK0OjQKsdjUo25PwK571HrweamrJPO/oBZCUO+l90QccC0PsqDrjOXjyN5oYxRZpn+uzNLLyjhIzqnBM0HbPLvt6GpqvbN1jjP/WZ1PBg0pK10Vglm5XoNk1DCceLP6CmNwrUOfQJwVMoDnk2YtXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=beldev.am; spf=pass smtp.mailfrom=beldev.am; dkim=pass (2048-bit key) header.d=beldev.am header.i=@beldev.am header.b=FSk5Eozo; arc=none smtp.client-ip=2.56.206.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=beldev.am
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beldev.am
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=beldev.am;
	s=default; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=S5vge2jGhBcL7afUWwjP03igXuS5eEbcN/RA0jomv/k=; b=FSk5EozodsedsVxhzeQjCnJn1r
	DOqNhtOqxU7QzOXDjUx0ENubv/fGwrhQxSYKk0S6p6TUQ1n8FEdwnSCB7Eu+UtVQ2ZppqAhnEStjH
	e7PJJm/7/qqUuvxYDZhQdfSfm/o7sN7LuB8kLctEIhM1iUvsv7dGLdrHQn4tf1JMoWTwo6bj+jr1s
	NKCg/GecUWoDWn5FbPiQ9SAq7iBfBddIbEK8usQz1n4NvCAzRFBPcsEkRi+N9DSc5QQg16yXnCDTZ
	1CeHqUqpETNtcIKmRaJeQcpz7olDM4q7eP2vSD2V6tu/33hX0+Tu0tOx0HiWZmZaqA8E96AWfK2sz
	Kjr4eZeQ==;
Received: from [::1] (port=25524 helo=server4.hayhost.am)
	by server4.hayhost.am with esmtpa (Exim 4.98.1)
	(envelope-from <igor.b@beldev.am>)
	id 1uBrlG-00000000FxV-1JWL;
	Mon, 05 May 2025 13:05:18 +0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 May 2025 13:05:15 +0400
From: Igor Belousov <igor.b@beldev.am>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim
 <minchan@kernel.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, Vitaly Wool
 <vitaly.wool@konsulko.se>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] zsmalloc: don't underflow size calculation in
 zs_obj_write()
In-Reply-To: <20250504110650.2783619-1-senozhatsky@chromium.org>
References: <20250504110650.2783619-1-senozhatsky@chromium.org>
User-Agent: Roundcube Webmail/1.6.9
Message-ID: <646103e14947d09668f84ed5536afa3a@beldev.am>
X-Sender: igor.b@beldev.am
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server4.hayhost.am
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - beldev.am
X-Get-Message-Sender-Via: server4.hayhost.am: authenticated_id: igor.b@beldev.am
X-Authenticated-Sender: server4.hayhost.am: igor.b@beldev.am

On 2025-05-04 15:00, Sergey Senozhatsky wrote:
> Do not mix class->size and object size during offsets/sizes
> calculation in zs_obj_write().  Size classes can merge into
> clusters, based on objects-per-zspage and pages-per-zspage
> characteristics, so some size classes can store objects
> smaller than class->size.  This becomes problematic when
> object size is much smaller than class->size - we can determine
> that object spans two physical pages, because we use a larger
> class->size for this, while the actual object is much smaller
> and fits one physical page, so there is nothing to write to
> the second page and memcpy() size calculation underflows.
> 
> We always know the exact size in bytes of the object
> that we are about to write (store), so use it instead of
> class->size.
> 
> Reported-by: Igor Belousov <igor.b@beldev.am>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Tested-by: Igor Belousov <igor.b@beldev.am>

> ---
>  mm/zsmalloc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 70406ac94bbd..999b513c7fdf 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1233,19 +1233,19 @@ void zs_obj_write(struct zs_pool *pool, 
> unsigned long handle,
>  	class = zspage_class(pool, zspage);
>  	off = offset_in_page(class->size * obj_idx);
> 
> -	if (off + class->size <= PAGE_SIZE) {
> +	if (!ZsHugePage(zspage))
> +		off += ZS_HANDLE_SIZE;
> +
> +	if (off + mem_len <= PAGE_SIZE) {
>  		/* this object is contained entirely within a page */
>  		void *dst = kmap_local_zpdesc(zpdesc);
> 
> -		if (!ZsHugePage(zspage))
> -			off += ZS_HANDLE_SIZE;
>  		memcpy(dst + off, handle_mem, mem_len);
>  		kunmap_local(dst);
>  	} else {
>  		/* this object spans two pages */
>  		size_t sizes[2];
> 
> -		off += ZS_HANDLE_SIZE;
>  		sizes[0] = PAGE_SIZE - off;
>  		sizes[1] = mem_len - sizes[0];

