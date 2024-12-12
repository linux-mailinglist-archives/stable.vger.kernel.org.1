Return-Path: <stable+bounces-100882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A164A9EE47A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BE91886A21
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F77F20E304;
	Thu, 12 Dec 2024 10:47:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from er-systems.de (er-systems.de [162.55.144.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4AB1F2381
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.144.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000451; cv=none; b=XsHQZ4ovKTSbLYfGtjrwt/IWn8aZF3CJaKuGDBRVoNb/bEG98aBG1mYTJjo01l6Wnncry3x+wbyH3w0pYZpmRCBihKCLluyOP0DxDKyNpcTJwrXcUXIvTU+xPgAGmoVeD0tFzq5KOaT+ECShhBcxLNBnqh4n/3S+Z8aPazNna14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000451; c=relaxed/simple;
	bh=SeAdeJp+0vdyb0K1+xNlX0Ahiakkt0trCZW5AU6dPZs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FZCXY+4m4pZDkfu0hY5TpD9+u1apXQORxGBcW+v7mnSkVBEY2u6MDQWHcTMuxRS95K6byVPwuZgfSxJkteCI0DawdOEMOyRVpYT4r9oOKSj4IMyr+Pmn1WxPsCnsjjEEMUWm6YDWqx4HeLs1j8X3qKnc1+PosKF8f5/e+NUp9O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lio96.de; spf=pass smtp.mailfrom=lio96.de; arc=none smtp.client-ip=162.55.144.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lio96.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lio96.de
Received: from localhost.localdomain (localhost [127.0.0.1])
	by er-systems.de (Postfix) with ESMTP id A4657EC005B;
	Thu, 12 Dec 2024 11:47:25 +0100 (CET)
X-Spam-Level: 
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by er-systems.de (Postfix) with ESMTPS id 8B6F3EC0059;
	Thu, 12 Dec 2024 11:47:25 +0100 (CET)
Date: Thu, 12 Dec 2024 11:47:24 +0100 (CET)
From: Thomas Voegtle <tv@lio96.de>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
cc: Heming Zhao <heming.zhao@suse.com>, Su Yue <glass.su@suse.com>, 
    stable@vger.kernel.org
Subject: Re: ocfs2 broken for me in 6.6.y since 6.6.55
In-Reply-To: <0f122ee5-56e3-45b0-b531-455fcf9cea3c@linux.alibaba.com>
Message-ID: <2735fe61-3c53-90d2-5571-647fef41b9ea@lio96.de>
References: <21aac734-4ab5-d651-cb76-ff1f7dffa779@lio96.de> <0f122ee5-56e3-45b0-b531-455fcf9cea3c@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="933399184-1198121845-1734000445=:18909"
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 1.4.1/27484/Wed Dec 11 10:42:35 2024

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--933399184-1198121845-1734000445=:18909
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 12 Dec 2024, Joseph Qi wrote:

> See: https://lore.kernel.org/ocfs2-devel/20241205104835.18223-1-heming.zhao@suse.com/T/#t
>
> On 2024/12/12 18:32, Thomas Voegtle wrote:
>>
>> Hi,
>>
>> ocfs2 on a drbd device, writing something to it, then unmount ends up in:
>>
>>
>> [ 1135.766639] OCFS2: ERROR (device drbd0): ocfs2_block_group_clear_bits:
>> Group descriptor # 4128768 has bit count 32256 but claims 33222 are freed.
>> num_bits 996
>> [ 1135.766645] On-disk corruption discovered. Please run fsck.ocfs2 once
>> the filesystem is unmounted.
>> [ 1135.766647] (umount,10751,3):_ocfs2_free_suballoc_bits:2490 ERROR:
>> status = -30
>> [ 1135.766650] (umount,10751,3):_ocfs2_free_clusters:2573 ERROR: status =
>> -30
>> [ 1135.766652] (umount,10751,3):ocfs2_sync_local_to_main:1027 ERROR:
>> status = -30
>> [ 1135.766654] (umount,10751,3):ocfs2_sync_local_to_main:1032 ERROR:
>> status = -30
>> [ 1135.766656] (umount,10751,3):ocfs2_shutdown_local_alloc:449 ERROR:
>> status = -30
>> [ 1135.965908] ocfs2: Unmounting device (147,0) on (node 2)
>>
>>
>> This is since 6.6.55, reverting this patch helps:
>>
>> commit e7a801014726a691d4aa6e3839b3f0940ea41591
>> Author: Heming Zhao <heming.zhao@suse.com>
>> Date:   Fri Jul 19 19:43:10 2024 +0800
>>
>>     ocfs2: fix the la space leak when unmounting an ocfs2 volume
>>
>>     commit dfe6c5692fb525e5e90cefe306ee0dffae13d35f upstream.
>>
>>
>> Linux 6.1.119 is also broken, but 6.12.4 is fine.
>>
>> I guess there is something missing?
>>
>>
>>     Thomas
>
>


Ah, thanks, I didn't read that.

     Thomas
--933399184-1198121845-1734000445=:18909--


