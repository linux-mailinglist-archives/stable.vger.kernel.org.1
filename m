Return-Path: <stable+bounces-86644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 691DF9A2838
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 18:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC81B21F8A
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F7C1DED68;
	Thu, 17 Oct 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpZg5/nd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6931D95B5;
	Thu, 17 Oct 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181699; cv=none; b=I3APtjarXGZd/JorKTQunny7IcdGMlKUgX821EHYgMVf1KjoDJqixEndN9mHQQitl5K5Td/oGjlPsQ31FsnFBJOdko5JtTQdp4WgEQqqx4AFAJtnEv0jRAoRLHWkis4WjyBZ/S+6ilSlcj1+sL8HQ4Bbrrd78vlpyRi2ozgaW1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181699; c=relaxed/simple;
	bh=tpShQNHtumSM41nXef2olRvTjih43wzhUc+kzri07sM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXlNIZDJZW30dTfgp9kyKukNg3KeCZaXFI1JcguD+bugSggjSavwJkDN2+gHiEn3mezreoUEde8C3PpfBxXmNQKaw7tNV1RaLWUkZcUOjMGDa1tlyBU2fGBroS/OAG9Xrh+AORbYDPQV+LN6iumksyx/IDw6ZWBLZf+yRJoqFMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpZg5/nd; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso14530431fa.1;
        Thu, 17 Oct 2024 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729181696; x=1729786496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4hXvrT2L3+xEGILS6wPWbu2sYf1CJ6fKS6oVacPkSk=;
        b=TpZg5/ndZ4gVxkXhZnh1g7emy47zQ5Tj7imiqScQVgmU78cl3/x53sYMD9Fx2HVjS3
         hitq0VePcPdrjLHsCwRmqtuPb/B6p5KdrkKh6EJ9tX/LQn1WqrQ+qm874viK6nP+2DdI
         tKiOOwZpqX8aXIKEIaH8OYnUvtfc6e50MiM5sfTjHotWRZeTIdpkDdzfxWgABYtbD00D
         q7tJ9h480ZgltqRvipq7KJn6/T1lObH5T9qoGV/f+ppqLMvCQEaY2Rw/ng2jjCOX9Zfl
         HwV/ivsK/aiyB63P/VR8YpILq4si59QWzMygbfk0PeXCRwcGqxROKXvNS4+Zc3P5HCm5
         bsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181696; x=1729786496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4hXvrT2L3+xEGILS6wPWbu2sYf1CJ6fKS6oVacPkSk=;
        b=wlfq5h4uUiI+/eau0kFoCl63Raa9hARMcza+OVGx6/sC8q/ZfHiOVrKDiToCtTNg73
         FHj4GBhvo4sn9kFfH0tqLUmy1RRoN4Twx1v/gNtdaZWqbYpp6fNSrMv8607LmM7UB5Je
         IACorCUiW+jyY4FEel6dUwLHFT8nEMWMCVRNDW1idKBEXfuFecqKW/SLungeP9HbmJQ7
         GZqgevXUw0SFRLyLVEmuJqKptoFXX/8VFANs2VhZCvsO6DMSqzRCN+ETWE9d3BBGBKGj
         IwAg1md3zPMDkjdRMdo7+/caYePVBcjbqAhpjbiN9MeFtmP+LfGDkcDJLyTwwasS9AKU
         kalw==
X-Forwarded-Encrypted: i=1; AJvYcCUYe112YI+QD9F8IEEIE4VN26hDGRTFT4D0dx1VxwfVOVarmlkMMgbvfk/93v9b9uiMnFCTzQ28btg=@vger.kernel.org, AJvYcCXkBgfa+cZj2N38Mh7BgvCuFWxNo8RkW/doNqNVf/Utk4Xklr9AU6dW3F97rJJb8Hz9VvZcdRCP@vger.kernel.org
X-Gm-Message-State: AOJu0YyGxgHomKm1tLH/wHsLoH6fakgi8Kxzy86/QpiYkhcBOVL56JYv
	u+RCC2HbIvrEmOKtnxuLljnWhCRUHAyM5WiGUL/rHGwz/RF6aFMp
X-Google-Smtp-Source: AGHT+IHJfXtYAifz9j8MAhDmADXqOMXK4adNhFkG4S35c53KZQDvkQpW1o1tPoZPRjVqwbo5O4qsRQ==
X-Received: by 2002:a2e:be15:0:b0:2fb:5723:c9ea with SMTP id 38308e7fff4ca-2fb5723cc2emr73836691fa.30.1729181695580;
        Thu, 17 Oct 2024 09:14:55 -0700 (PDT)
Received: from foxbook (bgw164.neoplus.adsl.tpnet.pl. [83.28.86.164])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d1a86c4sm7416211fa.107.2024.10.17.09.14.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Oct 2024 09:14:53 -0700 (PDT)
Date: Thu, 17 Oct 2024 18:14:47 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/4] xhci: Mitigate failed set dequeue pointer commands
Message-ID: <20241017181447.7c712c4b@foxbook>
In-Reply-To: <3a22e31a-12bc-4fdc-90d2-e09a7f9d067f@linux.intel.com>
References: <20241017084007.53d3fedd@foxbook>
	<3a22e31a-12bc-4fdc-90d2-e09a7f9d067f@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 16:10:39 +0300, Mathias Nyman wrote:
> > Hmm, wouldn't a long and partially cached TD basically become
> > corrupted by this overwrite?  
> 
> Unlikely but not impossible.
> We already turn all cancelled TDs that we don't stop on into no-ops,
> so those would already now experience the same problem.

No, I think they wouldn't. Note in xHCI 1.2, 4.6.9, on page 135 states
clearly that xHC shall invalidate cached TRBs besides the current TD.

Same page, point 3, mentions that software "may not modify" the current
TD, whatever on earth is that supposed to mean. Unfortunately, I can't
find a clear "shall not" in 4.6.9, but I would see it as such.

> We stopped the endpoint, and issued a 'Set TR deq' command which is
> supposed to clear xHC TRB cache.  I find it hard to believe xHC would
> continue by caching some select TRBs of a TD to cache.

The idea is, if Set TR Deq fails, the xHC preserves transfer state and
cache and tries to continue. If the TD wasn't fully cached when the xHC
stopped, it remains incomplete. Missing TRBs will be filled with No Ops
when it restarts, yielding an ivalid TD (e.g. No Op chained at the end).

So it may turn out that instead of "EP TRB ptr not part of current TD"
something else would show up, perhaps TRB Errors.

> But lets say we end up corrupting the TD. It might still be better
> than allowing xHC to process the TRBs and write to DMA addresses that
> might be freed/reused already.

There is some truth to that, I guess. It's bummer that those bugs are
here in the first place and no one seems to know where they come from.


Was this tested on HW? I suppose it wouldn't be hard to corrupt a Set
TR Deq command to make it fail, stream 0xffff or something like that.
It may be harder to come up with a realistic test case with long TDs.

Regards,
Michal

