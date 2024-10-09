Return-Path: <stable+bounces-83195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3772299697D
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED24C2840D2
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 12:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4822D192B89;
	Wed,  9 Oct 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaRKU9pf"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8191922FC
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475435; cv=none; b=fqZe8XOkXckyNhl7GpKzmry8qUVew1VWAKopVZ23aK887IDoemdgGwhxU47WF35Af0rzZOfO2yiO9W2xrb2v+jDz3VuA1dhnKBj4EPPK6+q5U05yAprk8eqFdMAiMceXo1acQiJDfIpfOnyeCFfH4qw/SPLapTYjB0w4o2fuqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475435; c=relaxed/simple;
	bh=d8Kavz4pG0DrcMSTG519JLahfgY0ngVMi+UX0VgfOxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0Fot+FTij6KtnoUBAnrWdy+BHubld4ZYK58BbFE1P1lP+UDPvtxVDzsPhnsuCMoy6GbHYuYaTXZHmxkP3wAreJDaJmP4xJEOlM4v3c/TN3U5+7I0hSg60+6aImCk+lWXIxEmNW0NOcjm4zCcRKQtOJRU5LKxagOUS0P6UpvgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaRKU9pf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728475432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8Kavz4pG0DrcMSTG519JLahfgY0ngVMi+UX0VgfOxk=;
	b=aaRKU9pf/FlOC5TYh/NYDWzJD7cArUf6VXNH9in96tJDZpYfgSFNFo4r/IHj+AXeZekcQ6
	2qR4g6Hr0qvKJ7NrY1nUNnrDouLsdTix7vk6DJIzte6tGZtzvEwfPQi3yL3j8VQPSBGZpw
	NmiU0ZEp/bB1hNofzw36WVnPsldfEkY=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-2ugTCnsUM4exASM_g6ZLkw-1; Wed, 09 Oct 2024 08:03:51 -0400
X-MC-Unique: 2ugTCnsUM4exASM_g6ZLkw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-287308b475aso4600373fac.3
        for <stable@vger.kernel.org>; Wed, 09 Oct 2024 05:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728475430; x=1729080230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8Kavz4pG0DrcMSTG519JLahfgY0ngVMi+UX0VgfOxk=;
        b=JmLU2SLVxmvrbsIxc18Ttrx/ZElIra2TvqXN2yXP59M6bgrdfNgQDlCBJhvu90TMy8
         eJp+Pg2vLvKgjPF4vssvBVjvlMYlyMqsyA4TDG5k+m3CYz8v7lBTc5UgQvWGOSul429H
         Ljy3uA0RHvsNW6nvdXd6U14iDaEHg4qWm4Bie3xf3elPYuOFLk+O0R6sOsrw/izPZkQa
         pJu6NHclWlRHNkJKXj+Fl1tNbyUd9GTAEn1Aqsw+isqEpAkxA7Ay4/CsyTUxPjPY7OVu
         Y+qlxNUGAo/dJmwB/ZdyKR1lu9R2yJ4zWJwU8siRv3kVu74cdiiqpiO8sQa4L7zK0XrC
         KUvg==
X-Forwarded-Encrypted: i=1; AJvYcCUW1K3rWd/rJRMNRVn1L+7GKKeaFEqAVtDVlALdAAeRz7Nkq6EcSWcq1axd2GZ2iLpYEvHB/Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy1KiDgg4ZjMT0BVoX15MVXyk2iTkl/mt+iZok09P2lDAIlAGE
	bNIo5OnyMH5ArQMgKFmgBJFzC6LsPBfrFpbuIjxPYaVEaVy0nXKNLJV1Xrs08M2BIq2yUU0EPJR
	ix6zlI9A8fK24lvULZhtj3OWDVgZBJA21yWiPvNKzhMJ+BeO5M5t6HGpjZPmczekMMb7lR9eJ9f
	VrR3WDhHzrY/lGFxJagjyoo4J28/GW
X-Received: by 2002:a05:6870:d88e:b0:261:f30:fda3 with SMTP id 586e51a60fabf-288343063c1mr1385941fac.21.1728475430472;
        Wed, 09 Oct 2024 05:03:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEunAW49fg9TRqfk2Wul+wjLgorZM7rhrZCbIHsry+h80qprHZ8RuUHrprF5ApY/0Yivrsxi+udN4/j+iPW3fY=
X-Received: by 2002:a05:6870:d88e:b0:261:f30:fda3 with SMTP id
 586e51a60fabf-288343063c1mr1385884fac.21.1728475430088; Wed, 09 Oct 2024
 05:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008115648.280954295@linuxfoundation.org> <CA+G9fYv=Ld-YCpWaV2X=ErcyfEQC8DA1jy+cOhmviEHGS9mh-w@mail.gmail.com>
 <CADYN=9KBXFJA1oU6KVJU66vcEej5p+6NcVYO0=SUrWW1nqJ8jQ@mail.gmail.com> <ZwZuuz2jTW5evZ6v@yuki.lan>
In-Reply-To: <ZwZuuz2jTW5evZ6v@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 9 Oct 2024 14:03:31 +0200
Message-ID: <CAASaF6wdvXAZyPNn-H4F8qq6MpHmOOm9R+K+ir9T_sOG-nXpoA@mail.gmail.com>
Subject: Re: [LTP] [PATCH 6.10 000/482] 6.10.14-rc1 review
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Anders Roxell <anders.roxell@linaro.org>, Jan Kara <jack@suse.cz>, lkft-triage@lists.linaro.org, 
	allen.lkml@gmail.com, stable@vger.kernel.org, shuah@kernel.org, 
	f.fainelli@gmail.com, jonathanh@nvidia.com, patches@kernelci.org, 
	linux@roeck-us.net, srw@sladewatkins.net, broonie@kernel.org, 
	LTP List <ltp@lists.linux.it>, Christian Brauner <brauner@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	rwarsow@gmx.de, pavel@denx.de, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, conor@kernel.org, 
	patches@lists.linux.dev, akpm@linux-foundation.org, 
	torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:56=E2=80=AFPM Cyril Hrubis <chrubis@suse.cz> wrote=
:
>
> Hi!
> Work in progress, see:
> https://lists.linux.it/pipermail/ltp/2024-October/040433.html

and https://lore.kernel.org/linux-ext4/20241004221556.19222-1-jack@suse.cz/


