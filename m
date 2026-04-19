Return-Path: <stable+bounces-238620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VINxJBJe5GkTUgEAu9opvQ
	(envelope-from <stable+bounces-238620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 06:46:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D79BD4231D8
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 06:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04D85300DE19
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 04:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB8633260F;
	Sun, 19 Apr 2026 04:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="KYaA8dW0"
X-Original-To: stable@vger.kernel.org
Received: from sg-3-28.ptr.tlmpb.com (sg-3-28.ptr.tlmpb.com [101.45.255.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E7371056
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776573805; cv=none; b=t22l7zahNtYjRn7e8K2NLv9ImI08vN0QTjQzmjBdxKaIvfYLdsQvaa0rMXKLBkxvT/1wkaXZjGJoiYcirke3eJvbqi/FDhfEoEBj8owIqIg4ossBFbfR6T8q4jdJgc5i+R+1U6LmHIckDVT9YO+MZOMy8usP1ypl+Zqp3BoJaoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776573805; c=relaxed/simple;
	bh=o92FNG+o8yVlytdVp9668qDC9TykpyHWOXrALR21bQQ=;
	h=Cc:Subject:Content-Type:References:Date:To:From:Message-Id:
	 Mime-Version:In-Reply-To; b=CMoszleVsGq5rW7fb+VSnUNB8kbGXF24GAjQjfLWODsKLo5ex7q74hLwPQRkjqGed9VWJgK7DO+kdtV6yiT4wlcxY2PnbbH62GE314CW8J0Xfn61kckebSqsUBWLPFRHd+ueTpc3B1LS7/AQQnonqraU2IctzPcM/rOZ827LwMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=KYaA8dW0; arc=none smtp.client-ip=101.45.255.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1776573753;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=7Bgv2tBKVpKFjQdOeZ5XJrGcrpcG4WqyuCOUQGmT50o=;
 b=KYaA8dW0Uoa4iw1tTQMaF/V/Nel6DbcBj6PuTX+CIKAnXFjvbwoi3ti7h1P7tjg8sLzLPY
 oeVFDUaOerLuiDPHg1Av8mak3SrPUblkeDmNG4NvZED1usrFys2bhQZTOGDT8FrXaeBTOS
 RNfoX7qGtIYV6OrhDSaz4Waqc56wM3cPPW2jMIjEN3g+ULTibOQNVKpsX3GcyRtXcU0qYE
 MsEMIZ1dh6IpPbPJMb0SWM1n8w5sg8bH4DyZ5fos81nHzANBg7y4gavMcelNin3cfirQ8M
 AVKgIGEqzrxh1hRzI/a3GuWjMcl17m5Aq+ZM+Hisa4jr+2LcnokagUccaHzh5w==
Reply-To: yukuai@fnnas.com
Cc: <stable@vger.kernel.org>
Subject: Re: [PATCH v2] md: fix kobject reference leak in md_import_device()
X-Lms-Return-Path: <lba+269e45d38+a9bcb4+vger.kernel.org+yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.feishu.cn with ESMTPS; Sun, 19 Apr 2026 12:42:31 +0800
Content-Type: text/plain; charset=UTF-8
References: <20260413141759.2970973-1-lgs201920130244@gmail.com>
Content-Language: en-US
Date: Sun, 19 Apr 2026 12:42:29 +0800
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
To: "Guangshuo Li" <lgs201920130244@gmail.com>, "Song Liu" <song@kernel.org>, 
	"Greg Kroah-Hartman" <gregkh@suse.de>, <linux-raid@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <cdc869dc-ba1a-4cc2-a44c-3d147ca6bbbc@fnnas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260413141759.2970973-1-lgs201920130244@gmail.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,suse.de,vger.kernel.org,fnnas.com];
	TAGGED_FROM(0.00)[bounces-238620-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	HAS_REPLYTO(0.00)[yukuai@fnnas.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fnnas.com:replyto,fnnas.com:mid]
X-Rspamd-Queue-Id: D79BD4231D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

=E5=9C=A8 2026/4/13 22:17, Guangshuo Li =E5=86=99=E9=81=93:
> md_import_device() initializes rdev->kobj with kobject_init() before
> checking the device size and loading the superblock.
>
> When one of the later checks fails, the error path still frees rdev
> directly with kfree(). This bypasses the kobject release path and leaves
> the kobject reference unbalanced.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> After kobject_init(), release rdev through kobject_put() instead of
> kfree().
>
> Fixes: f9cb074bff8e ("Kobject: rename kobject_init_ng() to kobject_init()=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>    - note that the issue was identified by my static analysis tool
>    - and confirmed by manual review
>
>   drivers/md/md.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 6d73f6e196a9..4ce7512dc834 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -3871,6 +3871,9 @@ static struct md_rdev *md_import_device(dev_t newde=
v, int super_format, int supe
>  =20
>   out_blkdev_put:
>   	fput(rdev->bdev_file);
> +	md_rdev_clear(rdev);
> +	kobject_put(&rdev->kobj);
> +	return ERR_PTR(err);

I think it's cleaner to move kobject_init() after everything in rdev
is ready.

>   out_clear_rdev:
>   	md_rdev_clear(rdev);
>   out_free_rdev:

--=20
Thansk,
Kuai

