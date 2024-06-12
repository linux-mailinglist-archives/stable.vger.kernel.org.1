Return-Path: <stable+bounces-50276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C58905580
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD1C1F223C2
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EDC17E8EB;
	Wed, 12 Jun 2024 14:44:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from er-systems.de (er-systems.de [162.55.144.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA417E44B
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.144.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203481; cv=none; b=nuV6iXR9obile2UEYaZauqiBLZeuTR6Jfk5kW1VWuDPHr2ZWKWvn/jzGl6qroclUTYG4OLSlBwku93u1Fk9VqKmxmuVfB3TmVk4ZXMlS33ojnMkn5M140Jp9raHzNyzXXsrfRvuv66O/PAeQYHvdVIei7Gdrb2LUe9bBuX4ASJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203481; c=relaxed/simple;
	bh=pDBTfVnO+hcJSgx9Jyc5sm2fUakNavPc7rmdrC4k8pE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ntajPWin33K/xuuKABZ7D5SA+Az1am9239v2D1M+SPbj1EHPh+zCuCZ1kcVO92S5M+rIW+OPu29Bov0jDN1c04x65NtAx1hhdxfV188TCNVEgmkyA+oZKS3qTr9K3vzY0kQPOlMJCYTjPr9pbhycv9Fh4Gh/paMTh63W6Cqhy/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lio96.de; spf=pass smtp.mailfrom=lio96.de; arc=none smtp.client-ip=162.55.144.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lio96.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lio96.de
Received: from localhost.localdomain (localhost [127.0.0.1])
	by er-systems.de (Postfix) with ESMTP id AAA0CECDAE5;
	Wed, 12 Jun 2024 16:44:28 +0200 (CEST)
X-Spam-Level: 
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by er-systems.de (Postfix) with ESMTPS id 91061ECDAE2;
	Wed, 12 Jun 2024 16:44:28 +0200 (CEST)
Date: Wed, 12 Jun 2024 16:44:27 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
To: Greg KH <gregkh@linuxfoundation.org>
cc: Thomas Voegtle <tv@lio96.de>, stable@vger.kernel.org, 
    David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>
Subject: Re: 6.6.y: cifs broken since 6.6.23 writing big files with vers=1.0
 and 2.0
In-Reply-To: <2024061242-supervise-uncaring-b8ed@gregkh>
Message-ID: <52814687-9c71-a6fb-3099-13ed634af592@lio96.de>
References: <e519a2f6-eb49-e7e6-ab2e-beabc6cad090@lio96.de> <2024061242-supervise-uncaring-b8ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.103.11/27304/Wed Jun 12 10:27:29 2024

On Wed, 12 Jun 2024, Greg KH wrote:

> On Tue, Jun 11, 2024 at 09:20:33AM +0200, Thomas Voegtle wrote:
>>
>> Hello,
>>
>> a machine booted with Linux 6.6.23 up to 6.6.32:
>>
>> writing /dev/zero with dd on a mounted cifs share with vers=1.0 or
>> vers=2.0 slows down drastically in my setup after writing approx. 46GB of
>> data.
>>
>> The whole machine gets unresponsive as it was under very high IO load. It
>> pings but opening a new ssh session needs too much time. I can stop the dd
>> (ctrl-c) and after a few minutes the machine is fine again.
>>
>> cifs with vers=3.1.1 seems to be fine with 6.6.32.
>> Linux 6.10-rc3 is fine with vers=1.0 and vers=2.0.
>>
>> Bisected down to:
>>
>> cifs-fix-writeback-data-corruption.patch
>> which is:
>> Upstream commit f3dc1bdb6b0b0693562c7c54a6c28bafa608ba3c
>> and
>> linux-stable commit e45deec35bf7f1f4f992a707b2d04a8c162f2240
>>
>> Reverting this patch on 6.6.32 fixes the problem for me.
>
> Odd, that commit is kind of needed :(
>
> Is there some later commit that resolves the issue here that we should
> pick up for the stable trees?
>

Hope this helps:

Linux 6.9.4 is broken in the same way and so is 6.9.0.



        Thomas





