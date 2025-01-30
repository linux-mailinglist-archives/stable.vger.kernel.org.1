Return-Path: <stable+bounces-111719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC8DA23232
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 17:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A94716417E
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7648A1E7C25;
	Thu, 30 Jan 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="O6nbydVr"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A21E9B0D;
	Thu, 30 Jan 2025 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738255535; cv=none; b=HIenUiAtYWoxKOmFCfUtFCoTW4ZxrQaWON20yRQvb3+YKb0azUDwCT6x9VevpoIBMAjg5EC7ZwbAuL4CvJdFkvJ0UcsnTKfQCmnjno1Hf1Qzdjt1z8ZAfqngEAKukJUdQKgcFRcVzmcD2Ta8Pa6DikHRNrPjkg46oVRij42nI4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738255535; c=relaxed/simple;
	bh=gwagDNpfgu0T0QjK4sFGSE7iI+gtHXaBFZP2KhFglbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0JkoWKL0nzKepJwE7SnPRVxcOHmVz9Njfj4Wa97fU+FdWtvnFlHGXgn3fBSbkEbq9/RxhBvJpS1bPCE0uvrEPckEvxFjO0ZNWZXUv6Vvjy0SDTllcrLmQVQZIeqK4dOgMMuoI76YTI3t2qHZsCnchVNKTRoT5rZj/rmLkiqc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=O6nbydVr; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iNsgTBm8+F8P6qtgM+4kJ05JkhyM0mmdnbSbngLa3hY=; b=O6nbydVr1wMPb5V6FsGwT9vNN+
	hV6nlEok1YbnwFV/3zPtiwy4aQNildD8m3e/j+kZS6U9FXx0jZKfPS8JrjTW0QH8DImrNpad1qGlX
	G/53JLRHvl/YlmweDj3lC2MPc4rq6+W6tEY1FFzEvEl5zL51D2meiJs6fmCiMNR5+y6k7itZfWIJd
	oXd62m094tRDACA0ghfPyvKOwQwWgK1dCQ+rd5k+qe5uOav2x3X3L+lZeYdyGoXF2nd9iyFKsPta8
	qdKjVb26zOyw52uMD8KwFDahiDms0n1388tuCp9bvitE+0bVEWU51/IYdYlLoQdOMHgmgfaaxbytR
	ASLXCpag==;
Received: from [189.16.81.54] (helo=[10.154.220.147])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tdXfO-0016b7-8p; Thu, 30 Jan 2025 17:45:28 +0100
Message-ID: <6b7a8ab6-3174-483a-a26f-895b5ecbdbfd@igalia.com>
Date: Thu, 30 Jan 2025 13:45:22 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 082/133] drm/v3d: Ensure job pointer is set to NULL
 after job completion
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 Sasha Levin <sashal@kernel.org>
References: <20250130140142.491490528@linuxfoundation.org>
 <20250130140145.823285670@linuxfoundation.org>
 <12607ce2-01f3-4fb6-8b50-33a9f7f26381@igalia.com>
 <2025013044-tipped-discourse-e9e7@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <2025013044-tipped-discourse-e9e7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,

On 30/01/25 13:26, Greg Kroah-Hartman wrote:
> On Thu, Jan 30, 2025 at 12:56:25PM -0300, Maíra Canal wrote:
>> Hi Greg,
>>
>> This patch introduced a race-condition that was fixed in
>> 6e64d6b3a3c39655de56682ec83e894978d23412 ("drm/v3d: Assign job pointer
>> to NULL before signaling the fence") - already in torvalds/master. Is it
>> possible to push the two patches together? This way we wouldn't break
>> any devices.
> 
> As all 5.15 and newer devices are broken right now, that's not good :(

I agree, it's terrible. I'm currently waiting for stable to pick up the
fix (as it is quite quick, thanks for the great work). For a even
quicker solution, should I send the fix for the newer stable branches or
you can queue 6e64d6b3a3c39655de56682ec83e894978d23412 directly?

I added the "Fixes:" tag to the fix and CCed stable.

Best Regards,
- Maíra

> 
>> If possible, same thing for 5.4.
> 
> Ok, let me queue it up now, thanks.
> 
> greg k-h


