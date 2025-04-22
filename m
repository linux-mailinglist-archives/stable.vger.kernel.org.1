Return-Path: <stable+bounces-134994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B61A95C50
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B7C17274B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA5D86329;
	Tue, 22 Apr 2025 02:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQ2sCDw4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80828196
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745290163; cv=none; b=K9iviadf3KbZSrnxi88+pPM/eSMfDN8Dg/7a819jKk8ZG6nY3vUfp7SQPU+kpQe9J5Wq9go+icszO+TwFOzwhzscQ3XW57ltoWx7fI6KYeQKdnz7t77fXtx5K6X88IcyaEv+G/DdSJrvxU9/DzqkYHWOTbjU/feBmy028HgfhxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745290163; c=relaxed/simple;
	bh=5w5RFyx5Fde3sjleuIUHKTkCI9P3qZB2/QHcS9ihhf8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=mhq1XrIklX/UX2Mc/u2XP8UJ966g64aYbTVxurk+drftEFQzFvah3HB/QDt3SUwG0X5uYT4VJWJhkuilQsXEvY/EbkGvCSfxk/pzSvkMGq8XaaU6djN8t3RM0jeNEOIeAK/rBQLy6Sbu0N6GTVSxxvYg3cPchks5o6PHcIwHBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IQ2sCDw4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so42828005e9.3
        for <stable@vger.kernel.org>; Mon, 21 Apr 2025 19:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745290159; x=1745894959; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5w5RFyx5Fde3sjleuIUHKTkCI9P3qZB2/QHcS9ihhf8=;
        b=IQ2sCDw4yL8SyPx5DeTGMRWJZ/SNuCcvwCxcvtZMboc14ZaS+44a2PQO+Sf+7V3ThH
         5iSOvkNcruM3lBKjp4pm5nwK1JKIgz9VWzN802bmbKm5mJ4HM8oEXLIudUuyXRcrmD+s
         gu3WxjuxqvqfuB3zZPYRcs5Kapsj3QNB4Vkh+M2SjP1eYQWEuPLQUStbEF9J9iz70aRZ
         JEr28ossr6loKbRaxdiQ+4jeDH++C8RX2jS5rL0V2AjAbh/0II5XGeH0qZjSuF8rR4Qx
         qIXRWsikNSwkGahNp2XDKmGA0i8RL7bxjTJYCcNR6IeENPAVEAxQxc4/dbBr3yE4kQF9
         s6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745290159; x=1745894959;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5w5RFyx5Fde3sjleuIUHKTkCI9P3qZB2/QHcS9ihhf8=;
        b=SPU8BeZ5YyIlrHkGcQ2EIE2EUsYfmv/Ggwlmvph1svPXv/KVO+sr48plKSefTKAM44
         54krrbnNS7qZEvarKo3yvzOUrHkcYlSUXsLZliXHq1WMazrn+QK3PUKrfZnxQVAmQvOH
         PZeGr9ajkvp7sjuFeKwVlfVlRUFtdXSta62aCPshxm2c5sE0aeuHhmzJqG6iKjQ+yF9w
         eDscJW8GYotepwDLuL5WNJqP78UXyoPeqgscV96hYXdvHo/Gwsup+ZCN5NUy9Ics/iIQ
         XrOfTZ6kYqAJlhwp4ZGj24gWwrYIWZ/x27ljMcNjKmCyvogdOBVVmgKmw6BXArbo6xoC
         Ppjg==
X-Gm-Message-State: AOJu0Yw+SCEG6OKlTwycihnDsvNrgPRq2oqnrujBP2kFqCakjdAagpUL
	lPvhwy0Z3Och6GzQVrQcmCO/GTyf4Hnx7n6c9M+qTUjVjmNwkf4dMueCx9ypnbU=
X-Gm-Gg: ASbGncsGuGaLD65WXSwAXrysYJ35Myi6fGqnx7u3NWAg4SgBtZOJSBqFE2guD7lorEz
	NJy7nGZSPffqEjZNr3ywOZeBFUmyLAB/cA57I9HrLZ+iOL7tZDEhrD7Ash2J2j0nOVnAhBhgeMZ
	KoV5Vjvuh//WRlZaaQJJ9mri26I3WwDDAAX5gJ5N3Nx0wWQXcTF0H81nJXWXLObao5EbNpucaMW
	srYZ3tjBpUmRwYUMa/QEVLQ7Meo8l7zykdPNseBtNi1gziLcaOVbXadbWWA5vQbU4IXUq0anzOz
	F5LKEgad8foLm+ikWt3C0oCzHrbzcwatX1ehTsT3m1hfx5qTdv8=
X-Google-Smtp-Source: AGHT+IFHOUnGuFF7OKg26doAxP8+/Wmt3TKEqsEMokxQaF5Gq9QsD+XTtQwXLVRgj0GoP+lTjP1sNg==
X-Received: by 2002:a05:600c:4e8f:b0:43d:b51:46fb with SMTP id 5b1f17b1804b1-4406ab66eb4mr131770005e9.2.1745290158755;
        Mon, 21 Apr 2025 19:49:18 -0700 (PDT)
Received: from localhost ([2.216.7.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9e50sm156862795e9.6.2025.04.21.19.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 19:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Apr 2025 03:49:17 +0100
Message-Id: <D9CTQ5P0YSCF.2802I0W1M4AWM@linaro.org>
Subject: Re: [REGRESSION] amdgpu: async system error exception from
 hdp_v5_0_flush_hdp()
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <frank.min@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Cc: <stable@vger.kernel.org>, <david.belanger@amd.com>,
 <peter.chen@cixtech.com>, <cix-kernel-upstream@cixtech.com>,
 <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.20.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <1567c4e7-fd5c-42d4-8278-e1bba2ce46cc@amd.com>
In-Reply-To: <1567c4e7-fd5c-42d4-8278-e1bba2ce46cc@amd.com>

On Wed Apr 16, 2025 at 12:44 PM BST, Christian K=C3=B6nig wrote:
> Am 15.04.25 um 20:28 schrieb Alexey Klimov:
>> #regzbot introduced: v6.12..v6.13
>>
>> I use RX6600 on arm64 Orion o6 board and it seems that amdgpu is broken =
on recent kernels, fails on boot:
>
> Well in general we already had tons of problems with low end ARM64 boards=
. So first question of all is that board SBSA certified?

Yeah, I can imagine.
I can't find any info about SBSA cartification for that board hence I'd say=
 that
state is unknown, hence most likely "no". At least that's what I think.
It is a good question for cix or cixtech.com-based emails.

They have some updated potentially unstable UEFI firmwares to test though.

> If not then the chances of that board actually working correctly are very=
 low unfortunately.
>
>> [drm] amdgpu: 7886M of GTT memory ready.
>> [drm] GART: num cpu pages 131072, num gpu pages 131072
>> SError Interrupt on CPU11, code 0x00000000be000011 -- SError
>
> Any idea what that error code means?

Well, current thinking process that it means:
-- bits 31:26 system error interrupt;
-- bit 25 indicates that it was 32-bit instruction;
-- 0x11 in lsb is probably implementation-defined which can
be anything like bus errors, parity, access violations, etc

That's probably not very helping here.

Best regards,
Alexey

