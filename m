Return-Path: <stable+bounces-216005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOVDAmptjmnuCAEAu9opvQ
	(envelope-from <stable+bounces-216005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 01:16:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA90132012
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 01:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 423DA302A2FF
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 00:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525AC219FC;
	Fri, 13 Feb 2026 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwUS1aZ2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387913A86C
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770941797; cv=none; b=ZrFuPEr4Mfa2+6rK0StGs9wA3vSdOTs0ZC7dHMXzoA89+ErQhSDTFgb3tp3hsTjgtivVUubRTV0waehuqA85fsQLHWDI4Lvn7OACpBIMfFEgPwICTLUv7kEVTQI8O3wivYNHHYpE829Tj0Aae+LZGmDtuKY6xC9uH83c5bIc8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770941797; c=relaxed/simple;
	bh=Bjue3QOpIjKbVkSdodL/+toTxYDAijaIIOR7ocEymxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9cLTpa1OvWfQe/qLNSNLnYQl5bmoTXDdmeoMLwyo2Tsh8raw2/9OHm8+Df61Ls4oXBGcSkU010+cbbqzHnZeR7jS4P55jZlBUiLwkkyC5JAofSX95n/x4ANp7ZerDt6ICS5xYhbOHJLE1CRbbsm0akh3rDHl4TMRDugtqgORh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwUS1aZ2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c0c24d0f4ceso124303a12.1
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 16:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770941795; x=1771546595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJJWFT1l7GNpPMZ8f5fVGYkrxp6Tw+LeNuPObvL9Fe4=;
        b=BwUS1aZ2rasDVp3BTiSBLYPGBo+BcKE2g+Y6+pcOvQdSm52C6pbYJ8sjzBDpScxwSm
         KAoN15N1Zyz7d71hgpBfqgyAxT/fn/ZwGXVTlITSprhaJundYoZamNPWxtXSMYBlgUQo
         VTSzi5AVmD1UXJLJajdVV4+5ZcfIFZVcn6kS2uTUtmvzriM5d1BWvhbnjcfAnsow6fKb
         5OFX/VIjcYkFLi1CSiBZmUWGORbOZqaZ58uNhLOFkRxQSRoAnzdDqBgCCE3iPLMhrJwt
         toZd9OJPX7rzx8/9YmxWT0qCSR7NyyWZOf/CGGQ3/LSZf7YekSPqRpKZIwt8zsE8VzbR
         /A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770941795; x=1771546595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rJJWFT1l7GNpPMZ8f5fVGYkrxp6Tw+LeNuPObvL9Fe4=;
        b=oZDjbqsHRJEIzA43VQ6b3DNFX0dd+vrTB4ugHcU7RD7zgEnKanULrD8VI0n9s3k2e/
         Ndr5rVzfi0jTtRnH+gvrk+1FZpxhzHZQl7LJO4xBGa96kC2hVDBsycJmsSw+h26PM1os
         Rf+/Fjl6bRQQAnIGJxMKz979vLKQmuWs7Nsbu5cpRK3rQmeiMKj2YJ+tNZS/AUna4AFs
         UkGWqr1gBOVVa3Fzr/UuGi5V/uOoCG11uPfiXKtE2TTP3I+UrgEXpIV5dvJjM7ATmy8j
         USTlQl+FDCLbGbzdA71hWODD4UwzJ9dYZpt5IFo+UkYbmRk9ffzKMZbIuIFjgWe8WHwA
         P7NA==
X-Gm-Message-State: AOJu0YwwgRsN8YGIlcpBJsZlLffNk8cRj8eZnJkpg7G/z9c9WLCjJZFp
	jXre7PagGtheKwY1hwZwgob0jBkBLDd65Ym15PoC4Q1fGLAGuhSzXivl
X-Gm-Gg: AZuq6aLVmpBPS8DICVWz5p17850SYsgS45HOi4NS/hYnu+BgVwg/dDG0ikW6NtKBint
	j1MGjDtmPp8tool8iXOmafPUw0Y0A8ZTT1YAYMcJZQ6Iey0F6MB2CdpVWdrwXidrqvJt37vMgCx
	NoGCs2ioZa6U2fSqNNEsQDZeX34JQ8yUAigxqACn9PXwu7Zc3NQlxrJ/Td7yBsPH2fnHPRZcAGj
	Ft2rJ9wsuM6ayjR3JDXuaCj6oFHSy2e8CDrnJv7d5nJ8736AE/OLHs5+jR79rgkHQEYOSS3sGhE
	MthxORf7mKEE0xu2C4/74Zwq+tHZbL5kle3pKE46cGtybZTii1ardEj9CKhGcRLzUxzfygRHsTP
	s11Mvnrwr9sn9YoxAk/fFtvq33wfH4rWLhoerTjlXrugxa7vaTrArj4JwmFEJ2fz2Jvm/9WSXdt
	cjgNe95773ZNShGAQhWMYOcTuXo29HRHk8ZhTh
X-Received: by 2002:a17:902:9004:b0:2aa:d5ea:4cfb with SMTP id d9443c01a7336-2ab504cabcamr353655ad.9.1770941794707;
        Thu, 12 Feb 2026 16:16:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29999c80sm60524925ad.89.2026.02.12.16.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 16:16:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 12 Feb 2026 16:16:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Shida Zhang <zhangshida@kylinos.cn>, Coly Li <colyli@fnnas.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 30/87] bcache: fix I/O accounting leak in
 detached_dev_do_request
Message-ID: <df94d6c8-f236-46a7-9053-40b00a3a1a5b@roeck-us.net>
References: <20260204143846.906385641@linuxfoundation.org>
 <20260204143847.995871393@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204143847.995871393@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-216005-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid,kernel.dk:email]
X-Rspamd-Queue-Id: 3DA90132012
X-Rspamd-Action: no action

Hi,

On Wed, Feb 04, 2026 at 03:40:28PM +0100, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> [ Upstream commit 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f ]
> 
> When a bcache device is detached, discard requests are completed
> immediately. However, the I/O accounting started in
> cached_dev_make_request() is not ended, leading to 100% disk
> utilization reports in iostat. Add the missing bio_end_io_acct() call.
> 
> Fixes: cafe56359144 ("bcache: A block layer cache")
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> Acked-by: Coly Li <colyli@fnnas.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/md/bcache/request.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index a02aecac05cdf..6cba1180be8aa 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -1107,6 +1107,7 @@ static void detached_dev_do_request(struct bcache_device *d,
>  
>  	if (bio_op(orig_bio) == REQ_OP_DISCARD &&
>  	    !bdev_max_discard_sectors(dc->bdev)) {
> +		bio_end_io_acct(orig_bio, start_time);
>  		bio_endio(orig_bio);
>  		return;
>  	}

In 6.12.y and v6.18.y, the code continues:

        clone_bio = bio_alloc_clone(dc->bdev, orig_bio, GFP_NOIO,
                                    &d->bio_detached);
        if (!clone_bio) {
                orig_bio->bi_status = BLK_STS_RESOURCE;
                bio_endio(orig_bio);
                return;
        }

The NULL check has been removed in the upstream kernel, so the error path
does not exist there.

It seems that the above code is still having an accounting leak if
bio_alloc_clone() returns NULL. Is this indeed the case, or am I
missing something ?

If I am not missing something, is it necessary to add a call to
bio_end_io_acct() into the error handling, or is the problem theoretic
and can be addressed by backporting commit 6ea84d7a92cb ("bcache:
remove dead code in detached_dev_do_request") to v6.12.y and v6.18.y ?

Thanks,
Guenter

