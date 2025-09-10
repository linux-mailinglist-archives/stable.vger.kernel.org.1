Return-Path: <stable+bounces-179193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 282B9B51510
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 13:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4D2546C79
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4891A31B13F;
	Wed, 10 Sep 2025 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYONtoEZ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C09031814C
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502571; cv=none; b=jUcWAukn+G8OtAXkJP2qpfsERL1z49YWWfjNkBUFIPSL5h2l5KnNNCsKtdLW5Q/m9d1MBydF7kwsQbo88dFeDJQNg58DXFGue8RnqQZD6/diutK5JR5h7yr8EBXQ42WPeSI5ACKpmX/LaFWM6ubfsRXoADvG2Rr1S75vpes43f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502571; c=relaxed/simple;
	bh=BQ2XtYRwei+F/8LMUKBdKEm+z8pxUaNiGAkH40rNEKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aAahDEdcxcGr/xj96moukanyU8tGe3EGuSvA1E5ttLawRz3Z5zh+ArUoHsbQrzkzn4XyUfALUOEZxi64mpN2r6hAPW11AupcPE9UqzMC+Xb1HqM32frzTEAQFKhR/JMynoLH/nK3a41rbXv2EBDXgc5/SYUfTiyEfaRvhn4UK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYONtoEZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757502568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EEfKAAgF77B0N35cHlVCZR8H3qoPVBq2FQNy2mJIamk=;
	b=JYONtoEZ9+9kfTQXg5T9LNFeOUV5afuSWSIja66oCJoSl0HwnqC2MPn4sq5tZYkGCMcAw0
	kkLwD5fhfCxrAGFVNZHJZFW3/9DrDo0gyUyOb+HZ3pChFiz7pgQ1WRt82VBlD/CV8rX3Ai
	Ziq9RWwsE1+vICG+0ChuskRzGElGJaE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-phmbjhz0MliiW7LqofRrjg-1; Wed, 10 Sep 2025 07:09:25 -0400
X-MC-Unique: phmbjhz0MliiW7LqofRrjg-1
X-Mimecast-MFC-AGG-ID: phmbjhz0MliiW7LqofRrjg_1757502564
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so52180155e9.0
        for <stable@vger.kernel.org>; Wed, 10 Sep 2025 04:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757502563; x=1758107363;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEfKAAgF77B0N35cHlVCZR8H3qoPVBq2FQNy2mJIamk=;
        b=cYAwLwZI/62rneI7Kn4FfPp56prWqlo3HmNuOvf5+jj3blwKjZ4pf00aa47gwUbPxN
         nITyQzQRzNuo6m28tkpOtjhl99oWGDa+7ewtFPF4UqlsF1cXWL459DUVPR1vbqCYJ4dL
         v+8/i84QjDlKI7sHm3cNBgMUzp6T0o9GZBYiqrm4lmHto3l2tIYKNomVGIcmQZ3F4TIh
         k3yR0b2gXm5nmJbswSJqg/NMgM5ia0+Z+fDyMdiuoDUbbAauUXFc4cSM3T+pYYGODCXr
         1sykYJHIM29jgRSt3wRfEg5qYy4Mk5H+CPyn34Zap9lwPMlk1vKjS4q30rMt1hZDM6f6
         p6sw==
X-Gm-Message-State: AOJu0YwJw9AR7UFp/+rzbQDZXwBI+ih74wroyGcWXCmKMtvl1U1Ornru
	+AkAZfPxLYPkomyISSXNMEZRytn3ylDsggfv3Fxz+6VdifP6NlvYXF4o9lAOZHNswNal0bQOJkn
	G4J+e2puOHBZs+3olkxByEvylEKtAewVVm1DCJyIhhmNoUQn5pxVTgwUYGug+Fou9UA==
X-Gm-Gg: ASbGnctbrQI6RBRK+BiatKVjOAvA+7wzt0NRpIctSB8pEP1lYNbiV/Di99Zk+YjudWa
	9GpU0MZTRu02HXmBvNA0m4ccc6Je6aoEF0dDoh0yknr+/bSfKHch4n0lu57dhgHPhX6/1+/0bqD
	4tQ5b8y2neE4g/b1LHnm2+DVejkTjVe1c0gOgr7/IWn+8u7JsPKZwO9sALX5YsC8JDGAj9h6aXr
	59JmSi95LrSCD9vUJoitWGzo9/709jjJ0CUIl8ytqiVZb6l3+XXJlTB3v5NUFsORFbxsLymAENJ
	xeQR7Dn2KoMCjhAeiQL8NunHZYUmUJdR0jf6lqalLtOlO2cteIKkN8BDcvheAlEyhnSOo6cchi3
	hv8wKA/OHZFabfLf/xAnbZg==
X-Received: by 2002:a05:6000:2889:b0:3e5:50:e044 with SMTP id ffacd0b85a97d-3e643555859mr13543078f8f.45.1757502563469;
        Wed, 10 Sep 2025 04:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtsE6TP99LwCM9DefOr4NgVBIR7vSn0IU371t63+HnR3UaFYs5LDu32sAvz1H1Dto10pgN1g==
X-Received: by 2002:a05:6000:2889:b0:3e5:50:e044 with SMTP id ffacd0b85a97d-3e643555859mr13543046f8f.45.1757502563021;
        Wed, 10 Sep 2025 04:09:23 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df1ba282dsm26332925e9.5.2025.09.10.04.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:09:22 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>, Helge
 Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones
 <lee@kernel.org>, Murad Masimov <m.masimov@mt-integration.ru>, Yongzhen
 Zhang <zhangyongzhen@kylinos.cn>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/1] Revert "fbdev: Disable sysfb device registration
 when removing conflicting FBs"
In-Reply-To: <aMFYeV4UdD7NnrSC@karahi.gladserv.com>
References: <20250910095124.6213-3-bacs@librecast.net>
 <20250910095124.6213-5-bacs@librecast.net>
 <87frcuegb7.fsf@minerva.mail-host-address-is-not-set>
 <aMFYeV4UdD7NnrSC@karahi.gladserv.com>
Date: Wed, 10 Sep 2025 13:09:20 +0200
Message-ID: <87cy7yef8f.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brett A C Sheffield <bacs@librecast.net> writes:

> On 2025-09-10 12:46, Javier Martinez Canillas wrote:
>> Brett A C Sheffield <bacs@librecast.net> writes:
>> 
>> Hello Brett,
>> 
>> > This reverts commit 13d28e0c79cbf69fc6f145767af66905586c1249.
>> >
>> > Commit ee7a69aa38d8 ("fbdev: Disable sysfb device registration when
>> > removing conflicting FBs") was backported to 5.15.y LTS. This causes a
>> > regression where all virtual consoles stop responding during boot at:
>> >
>> > "Populating /dev with existing devices through uevents ..."
>> >
>> > Reverting the commit fixes the regression.
>> >
>> > Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
>> > ---
>> 
>> In the other email you said:
>> 
>> > Newer stable kernels with this
>> > patch (6.1.y, 6.6.y, 6.12,y, 6.15.y, 6.16.y) and mainline are unaffected.
>> 
>> But are you proposing to revert the mentioned commit in mainline too
>> or just in the 5.15.y LTS tree ?
>
> Only the 5.15.y tree. Sorry - that could have been clearer.  There's no
> regression anywhere else. Mainline and other stable kernels are all ok.
>

That's what I thought but just wanted to confirm that was the case. Thanks!

> Cheers,
>
>
> Brett
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


