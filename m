Return-Path: <stable+bounces-237889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPNkBVhN3mnvqAkAu9opvQ
	(envelope-from <stable+bounces-237889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:21:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F45E3FB113
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8F2530125AD
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411B3D646E;
	Tue, 14 Apr 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="BY31uBrq"
X-Original-To: stable@vger.kernel.org
Received: from mail-108-mta239.mxroute.com (mail-108-mta239.mxroute.com [136.175.108.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA71C1A3157
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175840; cv=none; b=t2W8cgX/9CIgKkCpSOL2mYL/QWrxVMM0OLgjuI5EtmwmOzg8F5OGPmANgiMJ0G5IOPfnRe6SG+P7Im0RRfBTKUSnbmnYTmQZmtjwoblD8oPv82PdI8ASyN7O7XN7DdbyrF2ke5eaNK4AhZb68mRannR/XwVdj6eFnwH1x7Yp7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175840; c=relaxed/simple;
	bh=OMe49CQ8VFGwE5edSEP7UuWApy7ts2LpQs7I8fECmvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q2IPOKpb/l+pbyIKFGfEPnE5yY484bD2xu4BY0w21IJ3q4PbjkVEmpf+vlBvuaLR015HuxX96erutNMYSh5v7uQ/J6qvWtkQB2tFrQUyAFiAC9kXpBeeIJj9kRR/nP+Qp4DaRXt+0et4rO529EqXva7IX6I2hf78nF4Yz+LivCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=BY31uBrq; arc=none smtp.client-ip=136.175.108.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta239.mxroute.com (ZoneMTA) with ESMTPSA id 19d8c4fa54100032bf.007
 for <stable@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 14 Apr 2026 14:05:23 +0000
X-Zone-Loop: 1ed6a9840e9707dfdd26a97708c8aef607363dca956c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:
	Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ToGyh3oxvVYg+NQqeqbdwB97E4qhjONyP4wJVRZvJjo=; b=BY31uBrqMaItpakt4jDci59oFf
	q/1c47Kh3CkcjVhYrCkjpA0BYqRn6zUmIr6C9eLsA8NipXaEU9dW2AclMOroBEhbk6I1UH0N8xSFy
	2rKo5zT65P9tj6S2OPYi6v24TbRijskSLtxhf4IT4+gEU6L6HUGWaNaX1abuv/sUqNWH+i0r0J2O0
	fatbNXmCM4aS97wSBAU98Jk87MRIvbNinNoUtwQTGFcv9KuBD5FBEMyTYEbrm7J2MuuL/t82pDYnf
	K709rsVf9pl5ScVWDe+jJX/U7OII1nI5b+y08LknBRQPXyKsQA9lxTn1zHxb2p3UWjTUsK8SVTHRZ
	zJKa+uqA==;
From: Su Yue <l@damenly.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Song Liu <song@kernel.org>,  Yu Kuai <yukuai@fnnas.com>,  Greg
 Kroah-Hartman <gregkh@suse.de>,  linux-raid@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2] md: fix kobject reference leak in md_import_device()
In-Reply-To: <CANUHTR-G1X5OBXQNiw8-mXGiugnuP8ryHcsrMXLKcD4VefuKmw@mail.gmail.com>
	(Guangshuo Li's message of "Tue, 14 Apr 2026 19:32:07 +0800")
References: <20260413141759.2970973-1-lgs201920130244@gmail.com>
	<fr4y8h4f.fsf@damenly.org>
	<CANUHTR-G1X5OBXQNiw8-mXGiugnuP8ryHcsrMXLKcD4VefuKmw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 14 Apr 2026 22:05:12 +0800
Message-ID: <a4v58wo7.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Authenticated-Id: l@damenly.org
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[damenly.org:email,damenly.org:mid];
	R_DKIM_REJECT(1.00)[damenly.org:s=x];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237889-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[damenly.org];
	FREEMAIL_TO(0.00)[gmail.com];
	GREYLIST(0.00)[pass,body];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[damenly.org:-];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[l@damenly.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.243];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,damenly.org:email,damenly.org:mid]
X-Rspamd-Queue-Id: 2F45E3FB113
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Tue 14 Apr 2026 at 19:32, Guangshuo Li 
<lgs201920130244@gmail.com> wrote:

> Hi Su,
>
> Thanks for reviewing.
>
> On Tue, 14 Apr 2026 at 09:29, Su Yue <l@damenly.org> wrote:
>> Why not just:
>>
>> out_blkdev_put:
>>         kobject_put(&rdev->kobj);
>>         fput(rdev->bdev_file);
>> out_clear_rdev:
>>         md_rdev_clear(rdev);
>> out_free_rdev:
>>         kfree(rdev);
>>         return ERR_PTR(err);
>>
>> --
>> Su
>
> I wonder if that ordering might cause a problem.
>
> After kobject_init(&rdev->kobj, &rdev_ktype), 
> kobject_put(&rdev->kobj)
> may immediately drop the last reference and run the release 
> callback
> from rdev_ktype:
>
> static const struct kobj_type rdev_ktype = {
>         .release        = rdev_free,
>         .sysfs_ops      = &rdev_sysfs_ops,
>         .default_groups = rdev_default_groups,
> };
>
> static void rdev_free(struct kobject *ko)
> {
>         struct md_rdev *rdev = container_of(ko, struct md_rdev, 
>         kobj);
>         kfree(rdev);
> }
>
> So in:
>
> out_blkdev_put:
>         kobject_put(&rdev->kobj);
>         fput(rdev->bdev_file);
>
> it seems possible that kobject_put() would already free rdev via
> rdev_free(), and then fput(rdev->bdev_file) would dereference 
> rdev
> after free.
>
> That was why I changed it to:
>
> out_blkdev_put:
>         fput(rdev->bdev_file);
>         md_rdev_clear(rdev);
>         kobject_put(&rdev->kobj);
>         return ERR_PTR(err);
>
> so that the cleanup which still needs rdev is done before
> kobject_put(), and this path returns directly instead of falling
> through to the old kfree(rdev) path.
>
> Please let me know if I overlooked something.
>
Thanks for your detailed explanation. It's totally correct.

--
Su

> Thanks,
> Guangshuo

