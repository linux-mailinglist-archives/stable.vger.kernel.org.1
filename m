Return-Path: <stable+bounces-71539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82426964C12
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53241C22CBD
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA311B14F6;
	Thu, 29 Aug 2024 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ief7QQmX"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03A1B5EB5
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950323; cv=none; b=dZx1drqSaxnVshdv9/GSMAmI5K9U3T58LoaukTs75DGy3XbZXBzIAy7FyVl/XSQNdC+kG9hTSr602X+8ZfGzX8od3v5RubeGkZSLmxQfILqM9AaMBNPPUslZN0gHUVRycjI2Z/c5LamVxnfxyoHSU9F3OHWIrMeybQdwx/woJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950323; c=relaxed/simple;
	bh=xNkeEavtwbx0mAt+8xqeMZ+/XtuQ3/8CDtF98LR+grU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXvZcbgSaUkW9h6AqYlPfvX3BPvzyyPQ313n/MDeDKcnWwyL9QNnj91HeJd8/BN4fCUkG3sH+AtlNZOER6oUWKnkYrug8sG9ziFduLKRbHiSxzvtjodNSE80Oh4OmKxaA3359vpWjfoii6u2oMKOrdIl8LUOjXtzSGDf77XJPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ief7QQmX; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-533521cd1c3so1068427e87.1
        for <stable@vger.kernel.org>; Thu, 29 Aug 2024 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724950320; x=1725555120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPG/wl3r47+GhDQahEwoaa/XPnwwxMkatRYg2lbVpFs=;
        b=ief7QQmXNaenzNrorJdVdRSAxf9KXUwYB/Z5W3UnlLGGJgYpNUr5REkvOnBVbJ3qTW
         5f9r11YOaNYW/vVzm4Q92NbT6Z3W4bzRDyrlKNj8OUVi0xo/VWoq9/bmYmgxynyP1tBo
         1Rli4E2jpmivF0elHCUAkXqpXRm9xc2iUFi6tfObysGdj41e+gsrMHY3mIBcy8enFfor
         3JY3A154U+7W09NkmFDERKgvfmIWs30+OOMIWbF5gTmLaYK/TOI4uNwtQkYcqfaI98MS
         tK0nJJ7PLQHKfzgwQ4VrcY+aywnoCdLpZ8nDeL5w5Fh8oWIMl2hvf8YP+sVWZL9WeWWM
         zptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724950320; x=1725555120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPG/wl3r47+GhDQahEwoaa/XPnwwxMkatRYg2lbVpFs=;
        b=fvQOX9aSfwXuooXQ2JtjDBNxx4aut7TBChu9WiTRR7WDhjUkiuBXbr+KGuu+oKG6SD
         4qdr/xJiAe3UKon/9XO3WN5E/P8uDEhSsOkj56AfjXal6avb2TvEwkxePKp+EPEGA3Kd
         4eFT623vGxK7fX8bQWmjgL/465y8Q8YoKqxa/ao44B7l8u2xoCqmp3ew0ArGztCf44Up
         mYIU0xAKePpoiMz0J/iePmDZ/Syj1PTb83S3nUgG+dYcJWMTmpR3MMWW+bWJmymSK2Ra
         k6YfZHEwdOu1sI93LAqIdtHhxiPOwKCwNU3oQ6Ty8oY7EpxFXO8o7iyXzI6B3+Old3Mj
         NNYg==
X-Gm-Message-State: AOJu0YwAY5VOVB5aogrKbCm75sQBaFF95USK1+HV7XoS3d4HS0wYtSFM
	kjO10bM99Favhk4x66Lq5c0oOfmCSWcrYAaJIOBBLahmo7l6gAdz
X-Google-Smtp-Source: AGHT+IHzNUWzKl1RJe53Mn1fQQdXrgH7PIBCm4a9ZM+Sk5E8u40akZbhk3aFzGoTGp5QyYaBEhwgUA==
X-Received: by 2002:a05:6512:398e:b0:52c:8342:6699 with SMTP id 2adb3069b0e04-5353e5b7902mr3559191e87.55.1724950319513;
        Thu, 29 Aug 2024 09:51:59 -0700 (PDT)
Received: from [130.235.83.196] (nieman.control.lth.se. [130.235.83.196])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079baecsm200187e87.22.2024.08.29.09.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 09:51:59 -0700 (PDT)
Message-ID: <d762f4e9-92fa-4e67-ba9a-2a0fd1f57047@gmail.com>
Date: Thu, 29 Aug 2024 18:51:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [PATCH 3/9] xfs: xfs_finobt_count_blocks() walks the wrong
 btree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <dchinner@redhat.com>
References: <172437083802.56860.3620518618047728107.stgit@frogsfrogsfrogs>
 <25fab507-bf7f-446f-9ea1-cec08e9ebf1d@gmail.com>
 <2024082928-unguarded-explore-0689@gregkh>
Content-Language: en-US
From: Anders Blomdell <anders.blomdell@gmail.com>
In-Reply-To: <2024082928-unguarded-explore-0689@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

It seems like it has not reached Linus's tree yet, but is still pending in 'https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/'
in the branches {xfs-6.11-fixes, for-next}, where it has commit id 95179935bead.

I'll come back to you when it has reached Linus's tree.

Sorry for making premature noise.

/Anders

https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=xfs-6.11-fixes&id=95179935beadccaf0f0bb461adb778731e293da4


On 2024-08-29 18:17, Greg KH wrote:
> On Thu, Aug 29, 2024 at 02:08:37PM +0200, Anders Blomdell wrote:
>> Dave forgot to mark the original patch for stable, so after consulting with Dave, here it comes
>>
>> @Greg: you might want to add the patch to all versions that received 14dd46cf31f4  ("xfs: split xfs_inobt_init_cursor")
>> (which I think is v6.9 and v6.10)
> 
> What is the git commit id of this in Linus's tree?
> 
> thanks,
> 
> greg k-h

