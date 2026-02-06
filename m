Return-Path: <stable+bounces-214688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E2yA/YdhmmTJwQAu9opvQ
	(envelope-from <stable+bounces-214688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:59:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A52E100A73
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7066F30EA304
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513422D839C;
	Fri,  6 Feb 2026 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="3RorNwzf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C82D0618
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396785; cv=pass; b=MgmWO2XnXBKhaePrJ7qH8B6CHzX+d6pTZwJsOuybdHRhbztFmqpzekP0ilKSKXgfDXon/TqsWunOf2Z5alJnYY5yzrQSA0txcaq+lLLHZNTQ56pNgar6N/8qcR5a1o4zXWTfKULQmhjJFtOa8YvTITwVLvPxYS/SH+QE/psOT5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396785; c=relaxed/simple;
	bh=zYWW6u+UkPXLyU3uuryhZGjbfPnDbJJ4Icg4NsSbQvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ib5mXMnUZHB48wKFqzZe5w4cs+89yc0qk2gnRy+DBi28T+h/EQZsv6+V5gEeBTldNlz3rE8z6KGRQocC7AW1nt4vnB0JBC2qTYErm6bf81Q6lUl2T+QRu+LcacNzQHX2XywI9a22ZdmZ6LqQRmGkDMJtBok/gVAEICcqWWnN/0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=3RorNwzf; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so165377566b.1
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 08:53:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770396783; cv=none;
        d=google.com; s=arc-20240605;
        b=HT2oEa9hn8jbSy/ExvNtGDAssUYS4V67Tg8YPq+4R9c8Y5mZkUcG30Mxq3+zvHcG31
         8Dq7slUsOQgRc/eWf5UyNmCUQ9+pIR2LNAuaJ608FHGWfjF91JLNafynteAKvVAnQNKw
         1McTvOIcS/gqDgHQELtNRN1obKEoSZTvH1JPzogFc21V5LJIZNeAN5U4Qlt4oPac/5GQ
         8Co+eHuKg4opOUxkmW8BOMzcnfQQqpLoNm7k6Tu5boEdu8zlK8MdTN1FgpHIA6I0FPX/
         /766POZXSPD2pwiyc4xLSdFjL0/7eFM/LbQTMn+rjRxLPDhlGFKs2tmVyR0J6IxDk5a9
         kt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bgFS0unxSCmVNV3e9euzRJlesOrpe6OnfIqHW27FT0Y=;
        fh=ltapmLRMzyKZTRFlV4NGQgGz2bEART/PBuc1EPz6pE8=;
        b=LprqlexxnzI4sEXLZhGxSMpLrecyt3PfZs3ofH8sXP3D7HC/61NhfIYTJeHh/hjfso
         DVYehgtJZUdUShfE6GY+GEEJ16TjnJDRDmzMNjmoA7Io2JPkCHCYwHRqw8PoNQAIDwRt
         6gcUmAekc5Me5FzhZOLYExhox5+Bw6TeN36mOYcKbxlxU3c0MkImdwNe9Jh0WBw+Slya
         tHMBAbAEF2+6P5YuvtosA9X1MtG59O+3j91CvEir8XRuoI/XYBN4mRCax8SrKvlWlPlc
         X0h6qyPYqJqfZGkNpJGwZuxCDZbrvrH0UjYGW57CfRDrGLPQoEjAIJkKWqQ07Y+HbphB
         9GZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1770396783; x=1771001583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bgFS0unxSCmVNV3e9euzRJlesOrpe6OnfIqHW27FT0Y=;
        b=3RorNwzfQm5mYXQGHCe4alTjZk1fEN0m9Xbar+KP4c78wJ2h/1+cpJ51106+dofOZH
         EzTD6LA236fOQz30PTiowv0MT0+y28RcYp+9gVyOudk0cBZPz2LwOmdx0T8y66JMUhK4
         qi+6bkJwHXLsLxBX3vxAGO9jrn7Y7LivWLuGYx8yxoRfyar7klrsqZnmDTHlGci5Chjj
         5SgpP8aZpTQD64nYh/N/jwTM2CMUTzaPs7lyTNcV8fWN4Lb5W38eQq+jp/S8i3RtWW8r
         jYYPRUJREm4Ud4Sx3hA8w69+NMb/nE0MnyY0Kk1e3JSaMK63SNoCrV8XYTBZVaDl5hpC
         8tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770396783; x=1771001583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgFS0unxSCmVNV3e9euzRJlesOrpe6OnfIqHW27FT0Y=;
        b=M37Aoi/gfsQ8QwzHbTKuTc7FISnznX1h9Dy5O/zb/10Rqa1bbX8Pobd+xvTr/BbOy5
         E+BQVWbfx+9AUSPIw871mJxCMC+4nE7VgXXTQ8j3B8LM93SvEbBW0QPmcgqz6ozfFWun
         qi73LdLCQSEsODwJOfh6IhaTFe4dn9wBkK0Q8Y7uxm52wo03rObeqz9Fl4I2KPbKmnWR
         wbJvsgkdSlDfKdmn1gF+i2B062ObiQCZzThfo9F2jbXB3YmoGwsY7anA+eIUbk6g1Ots
         ZgCRv5oSqdPbFJPqu73tPpXdzAs2yWsnaoiR01FxASAnGS5xHROLdpJKJ/0o9voIPu6j
         2ubw==
X-Gm-Message-State: AOJu0Yxta0Vw5KYkBByTqICG2Z3Urd0+xsLMS+27gkvNIxm1Stlm7il+
	FqK6jl6meZM97cS2dTVINcIOHhGH/VPDV+bkQDb3zjF5CS1TyVXtxiiXAdCI3OyXrHiq9KyFcLC
	+gNm4vGMmOJZNQO7C3decqBC6jcCRRdpikjKWZoXI1g==
X-Gm-Gg: AZuq6aIREo66DfCjmx9mEGLGyF6AuinlFW+q2oX1pp667l68N3WSKILqgWfW0wzHm8r
	LOFEru94aHrlGRmo/WU79LB8nmgDxXhKbKYCmnVqIJwBnhVLNVT+kN2iGXG6PlRefak8EkHZPz9
	IYvcTU2fBFTBCwyRPI3yugNW537yVthcS+2M6L3Wb/aEhwZqzCltQWCqRwcYHWzGjBD9hTFvYwd
	H5zxInOdPJJlh1FgEZGEZOLJ6KK+3vlAIFPD+e8cOerT5WPgVbC/oUfVO6MQmTN8OVhRJcO
X-Received: by 2002:a17:907:3f03:b0:b87:6c1e:9ffb with SMTP id
 a640c23a62f3a-b8edf3410d9mr207702166b.48.1770396782893; Fri, 06 Feb 2026
 08:53:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205143430.733102763@linuxfoundation.org> <CAG=yYwnDVbTB3Y+zX8yLATGRKeZzSXNu-eiU-ABReZhJ0vep3A@mail.gmail.com>
 <2026020619-eccentric-retaining-86ef@gregkh> <CAG=yYwkOvV_=hhzSkQ06UqUW2X_FOm6saGqBaz4hLxqAg_WcvQ@mail.gmail.com>
 <2026020646-lash-celestial-2c7a@gregkh>
In-Reply-To: <2026020646-lash-celestial-2c7a@gregkh>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 6 Feb 2026 22:22:25 +0530
X-Gm-Features: AZwV_QjA2n_29AcwIK8XJ6XD2j0Vy-wlYaEYqKlwDlV2CIcfqLRaaDTXE80AOBU
Message-ID: <CAG=yYwkLUJJPVTyAeg=gu0jHYhoeXWcdGW5m2sbr9APsKChzng@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/160] 5.10.249-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	lkml <linux-kernel@vger.kernel.org>, torvalds@linux-foundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Shuah Khan <shuah@kernel.org>, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	Slade Watkins <sr@sladewatkins.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214688-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rajagiritech.edu.in:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rajagiritech-edu-in.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7A52E100A73
X-Rspamd-Action: no action

> I tried your config, with gcc:
> $ gcc --version
> gcc (GCC) 15.2.1 20260103
>
> And it built just fine.
>
> I did have to do a 'make clean' first.  Did you try that out?
>
may be i did not try that out with this kernel. let me do that

> Have you ever built this kernel successfully?  If so, can you use 'git
> bisect' to track down the offending commit for you?
>
i have "built"  5.10.248-rc1+  successfully.
 let me try to built this kernel with "make clean" before doing git
bisect related

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology

