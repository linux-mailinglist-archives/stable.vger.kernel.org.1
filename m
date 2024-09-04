Return-Path: <stable+bounces-73000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5AA96B8A8
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 12:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D7D1C2219F
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA01CC169;
	Wed,  4 Sep 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+JX88Xz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0415D84A40
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446185; cv=none; b=qncKNei0FnULkwBGDr2Ro1tcGb5sEOpYEw9N13l6faf+t/sSQvaYyzOg224tS+FzMj1JzBfGLP5Hf3YNPhVqiGTMUKYN4wWQ5V8/d/pXBagG2A/VEjSce9T9XmXaOgq0pgcnqz7u7JBC0x2GU0o4lL35BoVkCrd5s/RXukdagh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446185; c=relaxed/simple;
	bh=YH0TtsLp6zym9FUTrPBqkezxoM9K9mVcvUrz3Mxd8Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6eX4dfywyq3gukSO/P4h3uYN1vfxsAK8w64OvoEgHirXZs5p1x3UUQN0cLUa4IT+lD8SbagDAuZ7+SoIT+RFlcLHDk0gOeOBnEGWK92O8xU2i2gEWBMBi2QrddtlFWEh9KCh48Yqc9LJBHuRlLx/6BpvSWERjvcybGQsyJ1CfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p+JX88Xz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42bb9d719d4so48725495e9.3
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725446182; x=1726050982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7ThHoGL9ATbLn8Z6ELJvHOLdmXbio31tKhUCMOrvCw=;
        b=p+JX88XzvSVG5HgeYOClXf0ymdoT1LgZp0hN07CLp6leGjjheJs7OEMP4q+P0LWCXb
         XixJ+JpEinzEXdHu7F8e6setZmzSVCIUPj2QvOpZ3vDeMZpjwkYCotFysDcgxyMXkNtU
         QEInVQyq+J0pImC97dyM75y+fONcSIKELLoliJikLuUnna0XPYa1P3roPcknoYqBb6tS
         ZckFka3aZUIiqEWep+NHrQPRPBy8nOWCkPyU93AZzyc7+x25qXVWe6qdPsbpJaMNHfGt
         ufwjxSdWJ2RtdYNivcZhRPOL98bQhssz639XLVeNNT0qT/Ngf37NErT60mHnuZAdyVMU
         vlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725446182; x=1726050982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7ThHoGL9ATbLn8Z6ELJvHOLdmXbio31tKhUCMOrvCw=;
        b=IVmW0wwFBJGQyyax91ZlN8NTnImsM/ldLaGK/GxvlLwjlkWu6j+ObYNOvO8eak4Ztd
         8DY3sUWNILmowtvwX4N8mmMrYHsh2fN+JFkAdTaldrRFdBviUI8Tc0YyrCbFxxIP9OCE
         DXbRC6qx+mV8KTS5kU7C28xnoqSUQgVOmXEjdzotXh+moW8BLvWIhKE9BFSfS6+GPMxD
         k8cIchXoy//T2koGWckoucrHBvW6LTqwQV3pvVlz2U2Yxk/mj9ZzU0FYEEzK84JY48Wf
         5IafWhf9T84ES2gMTlQJruiU9LqOpqbylLpMt151BVn/bAM4vfT/lV2E7mpEN3LygACH
         LH4Q==
X-Gm-Message-State: AOJu0Yza6rEOhHelZ5IMa4heJbpE+E9t6mM+YuHwSdHZ0HZHN7y/Gdyr
	027spb+j+fkBZWX8n3FaVX8WsktOd474GDjUen2iq6G/oqbTpJrpl7PGH/PrrEQ=
X-Google-Smtp-Source: AGHT+IGtQD3Yn0nbN+/WjsJx3pcA2XI9bB4EcC910kHJw2Z6hl4XhPtG2GB8FRhoqyDuToUoWmndxA==
X-Received: by 2002:a05:600c:4f93:b0:426:622d:9e6b with SMTP id 5b1f17b1804b1-42c881030e7mr52159615e9.23.1725446181921;
        Wed, 04 Sep 2024 03:36:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c800554d6sm117852935e9.43.2024.09.04.03.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 03:36:20 -0700 (PDT)
Date: Wed, 4 Sep 2024 13:36:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, jslaby@suse.cz, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH stable 4.19.y] ALSA: usb-audio: Sanity checks for pipes
Message-ID: <4aa53a07-05d9-4f80-b4dc-c48d16ac240d@stanley.mountain>
References: <2024081929-scoreless-cedar-6ad7@gregkh>
 <7656cec0-3e12-47cf-af5c-178b7103ef17@stanley.mountain>
 <2024090408-trustless-carload-35fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024090408-trustless-carload-35fe@gregkh>

On Wed, Sep 04, 2024 at 12:01:32PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 04, 2024 at 12:17:37PM +0300, Dan Carpenter wrote:
> > We back ported these two commits:
> > 
> > 801ebf1043ae ("ALSA: usb-audio: Sanity checks for each pipe and EP types").
> 
> That commit is not in 4.19.y, it only is in the 5.2.8 and 5.3 releases.
> 
> > fcc2cc1f3561 ("USB: move snd_usb_pipe_sanity_check into the USB core")
> 
> Same here, not in 4.19.y, it's only in the 5.4.282 and 5.10 releases.
> 
> > However, some chunks were accidentally dropped.  Backport those chunks as
> > well.
> 
> Perhaps those commits were never applied to 4.19.y and you should just
> backport them instead?  :)

Oh.  Duh.  :P

Sure, I can backport them.

regards,
dan carpenter


