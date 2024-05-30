Return-Path: <stable+bounces-47731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AA58D5102
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 19:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C766285B05
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3078945BF9;
	Thu, 30 May 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="TdOth+r9"
X-Original-To: stable@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE27481B9
	for <stable@vger.kernel.org>; Thu, 30 May 2024 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090086; cv=none; b=Hhbhd4P/5p5KdIX1zkwH6tAl275eu+m6dmo+yw7yacSkeCrb8RhpEFgdf98ILyuQnzodj/ZaWA2DZYaSxf5YAd4Gwws+j5+0jAA231cIsFHZxt7EG37fbpYAuIAvVBhV4WVVWKVGZ+NK2ClyJENPt5EX7KWJumTJtuolDd13i+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090086; c=relaxed/simple;
	bh=PI46eCB4yZKtLa8v3+mNZJr2ivbez7uXjw8+2tdM4wQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HE2L8A0RYS2G3GTA9n9zZLkhw2WC3Vvp9uWTtBAULZRYO5E094tbPQ6KViDHfR1ha6Fg/6iLnolyaP6ql+dJ49OE4pKLmLtqFfQ/94K/Co3TnyV2TAW1j7EYQ31W6NXGAsXiJX7Xrg7BXmoBn00w3g2GhFk1uL8T2ft2Ehs5K1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=TdOth+r9; arc=none smtp.client-ip=208.125.0.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1717090084; x=1717694884;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:From:Subject:To:Cc:References:
	Content-Language:Organization:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; bh=4dDEKgqaFMRPywzm35viCF7BQid0GTM7Vc
	2BfcyQt3U=; b=TdOth+r9pnnrgT689WLDeVGlenC6hSyknYw26sLo/BARRrYu/U
	t0iICoBHuR9g4Ppmvwo3lqhM3o10zDn4RAzYEBFJt7yvXDWRw4gY2E4YHMH6NMAz
	zyJnSQRxvtRoOkvIa6Hd204Kdadsnw5FxDnXwkpFfBbO+MLubCJcLT+F0=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 30 May 2024 13:28:04 -0400
Received: from [IPV6:2603:7000:73c:bb00:15fd:52c:fc39:4205] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v24.0.0) 
	with ESMTPSA id md5001003957181.msg; Thu, 30 May 2024 13:28:04 -0400
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Thu, 30 May 2024 13:28:04 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:15fd:52c:fc39:4205
X-MDHelo: [IPV6:2603:7000:73c:bb00:15fd:52c:fc39:4205]
X-MDArrival-Date: Thu, 30 May 2024 13:28:04 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=18808d123f=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Message-ID: <4afd6e76-6542-4452-bc92-7798f64c986d@auristor.com>
Date: Thu, 30 May 2024 13:28:02 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jeffrey E Altman <jaltman@auristor.com>
Subject: Re: [PATCH] afs: Don't cross .backup mountpoint from backup volume
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Henrik Sylvester <jan.henrik.sylvester@uni-hamburg.de>,
 Markus Suvanto <markus.suvanto@gmail.com>,
 Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stable <stable@vger.kernel.org>, David Howells <dhowells@redhat.com>
References: <768760.1716567475@warthog.procyon.org.uk>
Content-Language: en-US
Organization: AuriStor, Inc.
In-Reply-To: <768760.1716567475@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDCFSigsAdded: auristor.com

On 5/24/2024 12:17 PM, David Howells wrote:
> Hi Christian,
>
> Can you pick this up, please?
>
> Thanks,
> David
> ---
> From: Marc Dionne<marc.dionne@auristor.com>
>
> afs: Don't cross .backup mountpoint from backup volume
>
> Don't cross a mountpoint that explicitly specifies a backup volume
> (target is <vol>.backup) when starting from a backup volume.
>
> It it not uncommon to mount a volume's backup directly in the volume
> itself.  This can cause tools that are not paying attention to get
> into a loop mounting the volume onto itself as they attempt to
> traverse the tree, leading to a variety of problems.
>
> This doesn't prevent the general case of loops in a sequence of
> mountpoints, but addresses a common special case in the same way
> as other afs clients.
>
> Reported-by: Jan Henrik Sylvester<jan.henrik.sylvester@uni-hamburg.de>
> Link:http://lists.infradead.org/pipermail/linux-afs/2024-May/008454.html
> Reported-by: Markus Suvanto<markus.suvanto@gmail.com>
> Link:http://lists.infradead.org/pipermail/linux-afs/2024-February/008074.html
> Signed-off-by: Marc Dionne<marc.dionne@auristor.com>
> Signed-off-by: David Howells<dhowells@redhat.com>
> Reviewed-by: Jeffrey Altman<jaltman@auristor.com>
> cc:linux-afs@lists.infradead.org
> ---
>   fs/afs/mntpt.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
> index 97f50e9fd9eb..297487ee8323 100644
> --- a/fs/afs/mntpt.c
> +++ b/fs/afs/mntpt.c
> @@ -140,6 +140,11 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
>   		put_page(page);
>   		if (ret < 0)
>   			return ret;
> +
> +		/* Don't cross a backup volume mountpoint from a backup volume */
> +		if (src_as->volume && src_as->volume->type == AFSVL_BACKVOL &&
> +		    ctx->type == AFSVL_BACKVOL)
> +			return -ENODEV;
>   	}
>   
>   	return 0;

Please add

   cc: stable@vger.kernel.org

when it is applied to vfs-fixes.

Thank you.

Jeffrey Altman




