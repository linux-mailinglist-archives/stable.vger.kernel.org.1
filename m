Return-Path: <stable+bounces-57929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318D39261DF
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 15:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D301C2341A
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC7C17A93F;
	Wed,  3 Jul 2024 13:30:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868F117A59D;
	Wed,  3 Jul 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013402; cv=none; b=SIHrjiUQpji1emv50MdbijdqYlkAwOjPGOSbyf+/2J9+hvNeAMn1hFd2lmujlSQdzDOE/UGpEr8QAHCg/VyNLxoNVwKj6QgbcpZPRMql6pKiD5BuO4XdOGKWJUaO0n4dnkaAva6XNcHQjR8m9biB1/YCGICYRKqlyHydgvLBffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013402; c=relaxed/simple;
	bh=ptQm01RcHA7mO1G3O9PkrXB6S2aalrKa1AfSeWlVWYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uj+XrlSk87l5JTJuH112MLJsElR3WlbiMR/+/XRl0+fMicdy/Qym7K8aJ6OQlyqZwqLm/aIY+YFvevld7HZwzw1ndOfama9lB9EZNzSruaDLoT2XsAAYmo9YgiqeDAqrlZEhKKldfuuxwFyiaMKzKN/52TUe6obYXXI95MbBrq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B10A7367;
	Wed,  3 Jul 2024 06:30:23 -0700 (PDT)
Received: from [10.1.37.29] (e122027.cambridge.arm.com [10.1.37.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED0D83F762;
	Wed,  3 Jul 2024 06:29:55 -0700 (PDT)
Message-ID: <3f35f423-e6dc-4a14-80dd-273c73cc1c55@arm.com>
Date: Wed, 3 Jul 2024 14:29:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Mark simple_ondemand governor as softdep
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
 Diederik de Haas <didi.debian@cknow.org>,
 Furkan Kardame <f.kardame@manjaro.org>, stable@vger.kernel.org
References: <4e1e00422a14db4e2a80870afb704405da16fd1b.1718655077.git.dsimic@manjaro.org>
 <f672e7460c92bc9e0c195804f7e99d0b@manjaro.org>
 <20240703152018.02e4e461@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240703152018.02e4e461@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/07/2024 14:20, Boris Brezillon wrote:
> On Wed, 03 Jul 2024 14:42:37 +0200
> Dragan Simic <dsimic@manjaro.org> wrote:
> 
>> Hello everyone,
>>
>> On 2024-06-17 22:17, Dragan Simic wrote:

<snip>

>>
>> Just checking, could this patch be accepted, please?
> 
> Yes, sorry for the delay. Here's my
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Steve, any objection?

Nope, our messages crossed in the post ;)

I'll push to drm-misc-next.

Thanks,
Steve


