Return-Path: <stable+bounces-52169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D6B90878C
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30AD0B22F98
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 09:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE19B190071;
	Fri, 14 Jun 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="lkGFFcMA"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA621922CE
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357649; cv=none; b=UPP474cszLjCm3MxTaQ3tu8sV1Ok7pb411fER+P7Awce8lqJLOemTliQJir/wOSETiu9rV+TfFlWs8r4mk980Zd7j5amLVdXafdy79X2/NpvJEu+2SB/Aeg0oyrrjjH4wARH1/6TQOa2o0a+cH4qfjkdjWYfIkD4kDwXaKoWnPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357649; c=relaxed/simple;
	bh=2EuV9lv3QZLgMS2+OeKIHzFtsXdoP8ptE/XMKM3QLU8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nTG/sBN33cs6mELi8Y5KRumg7oodIc8vsVTBNdCPhVXdQJsXTOvqnBH9tv/xqYSi1xOJz6QKAiTV5obpgi6MzqZdWNw66cfx4ExpegCFJ/vlJSrGtwRXyQk1Oeg4ZDNv6+ParNrVFux29hNVU5k2LUmjFxYvEPBoFqklxGDIXF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=lkGFFcMA; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from [10.10.2.52] (unknown [10.10.2.52])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2FEE54078524;
	Fri, 14 Jun 2024 09:34:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2FEE54078524
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1718357645;
	bh=B6cLvZe1zxnCNFAeqntK3finkaqniYPq6CFKUMWgshg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=lkGFFcMAWfkaTt+cCvZUCUQ5CkCwpHO28k80ni28lGRWGqbwCmUWdVUsDxFtPrjve
	 VcnylkbT3002ObG3uZ2SHLIAo/RNc7qtDUqnomREVR0nIjyXq8DEf1FrdEpR+HOWMX
	 rDDpgQ6HCbJAsdg56dbxColRUjFHHFx4lJ+dAAk4=
Subject: Re: [PATCH 6.6 267/301] Revert "drm/nouveau/firmware: Fix SG_DEBUG
 error with nvkm_firmware_ctor()"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Dan Moulding <dan@danm.net>,
 Dave Airlie <airlied@redhat.com>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20240514101032.219857983@linuxfoundation.org>
 <20240514101042.344516025@linuxfoundation.org>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <1fc2fb82-aad2-8587-cc5a-2076d1f63862@ispras.ru>
Date: Fri, 14 Jun 2024 12:34:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240514101042.344516025@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 14.05.2024 13:18, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.

A little bit strange situation to add and revert commit in the same
stable release.

Is it intentional? Or some scripts should be updated to avoid that?

--
Alexey Khoroshilov
Linux Verification Center, ISPRAS

