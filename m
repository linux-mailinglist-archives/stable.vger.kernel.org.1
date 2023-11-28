Return-Path: <stable+bounces-2903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAF67FBD0A
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 15:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE47E1C20DFA
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2135475D;
	Tue, 28 Nov 2023 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QamduNEm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B9C1B5
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 06:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701182661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=djUZFKrYN0Kble9zgAfouo+reIDsZTVLhC/pLABbWaU=;
	b=QamduNEmAKPtQ0yywKGw+toXVtkB0XZm6Qtt09WqfeYxTQkKyBJbR25HykgZfau3q3VRFd
	F6DxHArac72wo0+RxriucsTEccb4GQ6vsJmvZQRlxGAiI3Kjqx070bN07zIgU1wcMlBg79
	/Cyc3uxR+VhjIQiv9SHZ92FiKtoNuwY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-BTsw8p_LMtWAWST0HsStbA-1; Tue, 28 Nov 2023 09:44:20 -0500
X-MC-Unique: BTsw8p_LMtWAWST0HsStbA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77d55e875aaso701970785a.3
        for <stable@vger.kernel.org>; Tue, 28 Nov 2023 06:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182660; x=1701787460;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djUZFKrYN0Kble9zgAfouo+reIDsZTVLhC/pLABbWaU=;
        b=enSXjQAkW0dnQ+tEJlNx7COn60H2uMLZP5ruIyH5XzZEjRbNWQ+4/W/9LxWgii/9U3
         xrgHD+MyF8Rye+a1IxBZQsToU3M3bSA+W/zzW9JSn8Ki/I/RA29PcFS4OzYHa1TWUCu1
         SdCrDAVLOlRfBCmtif0hD3wywOP9F5aO5nAeHSYvwSXIAfxxfkYB6i4X66UI4uW2ou2e
         E1c8Gzj5jC7homXEL5Kl7QNoW0lONr6GnvpgCFM1afSkFmMc80pb1Jsr6ec4AEGvpVka
         LviWKbf+Xnhej/NMwBsVzfS2NZc1sMJneK9Ox2x2ubb2273+JKxXzLl4LeCc6/EAenSt
         lutg==
X-Gm-Message-State: AOJu0Yzj6oJaJlRKLxyl+acDi3PrNTLWf1swND1EjLawkIn12tGxZ48Y
	G/zFqTAH7J7tbzgI5qK5QrEnh73Kr5Wz83KFdh8MITMIT6XtUnt6Ws68tdiZtAuwZdBAfnRFL6d
	2UnVYxwP6S63TENif
X-Received: by 2002:ad4:44ae:0:b0:67a:218c:efc5 with SMTP id n14-20020ad444ae000000b0067a218cefc5mr13807812qvt.35.1701182659960;
        Tue, 28 Nov 2023 06:44:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh9N2Y7H9VGX3UaXfwoE797A34tNrjgnz8/vHkQlSgzn5oGS/BgJhrVEADqEdgXqXsl+bnpg==
X-Received: by 2002:ad4:44ae:0:b0:67a:218c:efc5 with SMTP id n14-20020ad444ae000000b0067a218cefc5mr13807798qvt.35.1701182659738;
        Tue, 28 Nov 2023 06:44:19 -0800 (PST)
Received: from rh (p200300c93f306f0016d68197cd5f6027.dip0.t-ipconnect.de. [2003:c9:3f30:6f00:16d6:8197:cd5f:6027])
        by smtp.gmail.com with ESMTPSA id kf2-20020a056214524200b0067a1e5ef6b1sm3867496qvb.106.2023.11.28.06.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:44:19 -0800 (PST)
Date: Tue, 28 Nov 2023 15:44:15 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Mario Limonciello <mario.limonciello@amd.com>
cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Mathias Nyman <mathias.nyman@intel.com>, 
    Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
    Sasha Levin <sashal@kernel.org>
Subject: Re: usb hotplug broken on v6.5.12
In-Reply-To: <28799328-a70c-40ff-ae4a-cf1933c8dbc5@amd.com>
Message-ID: <6f9218da-3fd0-a765-6515-e75ed9dd6978@redhat.com>
References: <2c978ede-5e2f-b630-e126-4c19bd6278dc@redhat.com> <28799328-a70c-40ff-ae4a-cf1933c8dbc5@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 28 Nov 2023, Mario Limonciello wrote:
> On 11/28/2023 07:12, Sebastian Ott wrote:
>>  usb hotplug doesn't work for me running stable kernel v6.5.12 on an AMD
>>  based Thinkpad t495s. Bisect pointed to 7b8ae3c24ef ("xhci: Loosen RPM as
>>  default policy to cover for AMD xHC 1.1") - which is 4baf1218150 upstream.
>>
>>  Reverting that from 6.5.12 fixes the issue for me.
>>  Current upstream rc kernel contains this patch but doesn't show the issue.
>> 
> I believe it's the same discussion as 
> https://lore.kernel.org/stable/5993222.lOV4Wx5bFT@natalenko.name/#t
>
> The outcome was that another missing patch is in the stable queue for various 
> kernels and will be part of the next stable release for various kernels.

Great, thank you!
I can confirm that v6.5.12 + a5d6264b ("xhci: Enable RPM on controllers that support low-power states")
fixes the issue for me.

Sebastian


