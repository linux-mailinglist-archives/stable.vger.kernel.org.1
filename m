Return-Path: <stable+bounces-27341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD188785F4
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 18:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6AD1C20D7E
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4071A482DB;
	Mon, 11 Mar 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=totalphase-com.20230601.gappssmtp.com header.i=@totalphase-com.20230601.gappssmtp.com header.b="ZW3M3qti"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1EA2AE91
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176596; cv=none; b=cfsh+pfRyQTPIqJvlB6kh5Q57MYKHihvejZ6fjoHKH1438/ONLrBCIfMTphSJXqnXJvaIIGnEN70vVjzjM+rtqctgo6DyVkPhdXOorzS3RQwDNrDcgCJZ2/q9D3Xbh1gTegBEzBA6oS5ClqP8DgDNCV8d/Y2T+PNuVuQXTEjUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176596; c=relaxed/simple;
	bh=agaJq87etNffqdB6IMs5QiSDbY44VKyrosXTgjFI/t4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qo34g+lBnKqevQHCtcuqqxKzh75d5ZVjQgKX7bTcOIISW4nt8jmOPPWLnoY/46nDPzj+EsbZytX3PgbOanzYID2sxebkwvStlP/4dOuvq5rkQsmnIle2wQYBdgeil9sGFd46xU/NfagMCyLZj/W4hxymY/5iedVn2ZqZzoTCwq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.totalphase.com; spf=pass smtp.mailfrom=totalphase.com; dkim=pass (2048-bit key) header.d=totalphase-com.20230601.gappssmtp.com header.i=@totalphase-com.20230601.gappssmtp.com header.b=ZW3M3qti; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.totalphase.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=totalphase.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-6e66601f082so2809275b3a.0
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=totalphase-com.20230601.gappssmtp.com; s=20230601; t=1710176592; x=1710781392; darn=vger.kernel.org;
        h=thread-index:thread-topic:content-transfer-encoding:mime-version
         :subject:references:in-reply-to:message-id:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=shpVNyKeSTmB1beltwD0e8eAjAeqYSJLBZ+0bq/aWSk=;
        b=ZW3M3qtijUUIc+jXwItIq86R8k7helNDjK68pZhvrupx4gLTNt1Q/6P7knjha9e9U8
         gmmyNJ7FArIpUBZCtq2icluDdvFX8gGe9YvE3N8/aqf2MB+U1erBTRGczbYdOZ6booY5
         hcZzdUXuFNMiJhhQoX4q0V3TWUwZTlkIqXep7Fy888kX3OU1JsPHTwgvqPTX+tJcdNVa
         jzZRXsERK4vebJkWXQW4Mho0vp4C+rT3tdEYS6M5uM0OjpUwgy4NoqSQaSuZ48cyNaYH
         Us2aiFO7DcV7e073S1NTo5yEGHfN6M6U7Psbxhq+H32vpn3Qj5nfaqV7cywNBI26MyNJ
         znzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710176592; x=1710781392;
        h=thread-index:thread-topic:content-transfer-encoding:mime-version
         :subject:references:in-reply-to:message-id:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shpVNyKeSTmB1beltwD0e8eAjAeqYSJLBZ+0bq/aWSk=;
        b=DahGWBuF517qp3/mvVc4q9TPR1myfkc68UR1ZNH1N3YYwE0asVKvuFiWFZsdjmGrWx
         afVKwMaGazSTRM6DRQPeKYTWLiQqHgdaSGy/0Hgqrx6ay/HG/oWzunlKpxAHJ5ln73WH
         Xec9fSnUxQ1h3xKXEVwcKdo1KjPYvqCwevcATcV+7ULuu4SmpmspuLzk1oa7tMJGaLMp
         Q5K0jKAlq4enD2Dw1FS28aKgfGkSLchZWq7qVJfp+mbd5VBmSIgfpR4EfVKVDqP9QOsd
         S7Mk1EQO+lduczKz6RqRqh7BYt6ixmuGfUN9MyyeVCkEyTym33/v7wIyNXQw6scHr7gp
         DO/g==
X-Forwarded-Encrypted: i=1; AJvYcCXH8fKo8oZOSMg1Z0dUutFdD7qvmv+j5A1xmxwr8i+7Y28kQTFvLem3GKIj3etHYnYO93o1hhcK1vZcJVHK3TWfy4YPU/us
X-Gm-Message-State: AOJu0Yzn45q3D866wfX5x5LvnANaeQtk8gwguVh1R0aOFIFjLfBxsh3o
	WHSM9lLP85cAPArCZUrRFOxBpMTlsccqD6mA3d3Z6R7JW+1QvVbxEhHJI1nlIZ77tnzXkRcjPAY
	NmE27r1tD8wyHVqnIbxAYFg+Yhm+MFdDs
X-Google-Smtp-Source: AGHT+IE9dy7qP1AWuyzDV9+vOmVP7Cxxr7MyciseHsVaUm/V7/oyEVUvRITXAfD74JVyYFkequ25w9vWrbam
X-Received: by 2002:a05:6a00:22d1:b0:6e6:9812:9c03 with SMTP id f17-20020a056a0022d100b006e698129c03mr2384694pfj.31.1710176590780;
        Mon, 11 Mar 2024 10:03:10 -0700 (PDT)
Received: from postfix.totalphase.com ([65.19.189.126])
        by smtp-relay.gmail.com with ESMTPS id f14-20020a056a00228e00b006e698eaa3fcsm122133pfe.3.2024.03.11.10.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 10:03:10 -0700 (PDT)
X-Relaying-Domain: totalphase.com
Date: Mon, 11 Mar 2024 10:03:07 -0700 (PDT)
From: Chris Yokum <linux-usb@mail.totalphase.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	stable <stable@vger.kernel.org>, 
	linux-usb <linux-usb@vger.kernel.org>, 
	Niklas Neronin <niklas.neronin@linux.intel.com>
Message-ID: <1525093096.37868.1710176587331.JavaMail.zimbra@totalphase.com>
In-Reply-To: <717413307.861315.1709596258844.JavaMail.zimbra@totalphase.com>
References: <949223224.833962.1709339266739.JavaMail.zimbra@totalphase.com> <50f3ca53-40e3-41f2-8f7a-7ad07c681eea@leemhuis.info> <2024030246-wife-detoxify-08c0@gregkh> <278587422.841245.1709394906640.JavaMail.zimbra@totalphase.com> <a6a04009-c3fe-e50d-d792-d075a14ff825@linux.intel.com> <3a560c60-ffa2-a511-98d3-d29ef807b213@linux.intel.com> <717413307.861315.1709596258844.JavaMail.zimbra@totalphase.com>
Subject: Re: 6.5.0 broke XHCI URB submissions for count >512
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Thread-Topic: 6.5.0 broke XHCI URB submissions for count >512
Thread-Index: VuTzduXODhc7IqP5hozJk2GPpe5bnIAKY5/B

Hello Mathias,

Thanks for the help with this! We saw that it's made it into 6.8. Is it possible to get this into 6.6 and 6.7?

Best regards,
Chris

----- Original Message -----
From: "Chris Yokum" <linux-usb@mail.totalphase.com>
To: "Mathias Nyman" <mathias.nyman@linux.intel.com>
Cc: "Chris Yokum" <linux-usb@mail.totalphase.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linux regressions mailing list" <regressions@lists.linux.dev>, "stable" <stable@vger.kernel.org>, "linux-usb" <linux-usb@vger.kernel.org>, "Niklas Neronin" <niklas.neronin@linux.intel.com>
Sent: Monday, March 4, 2024 3:50:58 PM
Subject: Re: 6.5.0 broke XHCI URB submissions for count >512

Hello Mathias,

Yes! This fixed the problem. I've checked with our repro case as well as our functional tests.

I'll email you the repro code directly, you can compare the unpatched and patched kernel behavior.

Best regards,
Chris


----- Original Message -----
From: "Mathias Nyman" <mathias.nyman@linux.intel.com>
To: "Chris Yokum" <linux-usb@mail.totalphase.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Linux regressions mailing list" <regressions@lists.linux.dev>, "stable" <stable@vger.kernel.org>, "linux-usb" <linux-usb@vger.kernel.org>, "Niklas Neronin" <niklas.neronin@linux.intel.com>
Sent: Monday, March 4, 2024 7:53:03 AM
Subject: Re: 6.5.0 broke XHCI URB submissions for count >512

On 4.3.2024 13.57, Mathias Nyman wrote:
> On 2.3.2024 17.55, Chris Yokum wrote:
>>>> We have found a regression bug, where more than 512 URBs cannot be
>>>> reliably submitted to XHCI. URBs beyond that return 0x00 instead of
>>>> valid data in the buffer.
>>>
>>> FWIW, that's f5af638f0609af ("xhci: Fix transfer ring expansion size
>>> calculation") [v6.5-rc1] from Mathias.
>>>
> 
> Ok, I see, this could be the empty ring exception check in xhci-ring.c:
> 
> It could falsely assume ring is empty when it in fact is filled up in one
> go by queuing several small urbs.

Does this help?

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 6a29ebd6682d..52278afea94b 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -332,7 +332,13 @@ static unsigned int xhci_ring_expansion_needed(struct xhci_hcd *xhci, struct xhc
         /* how many trbs will be queued past the enqueue segment? */
         trbs_past_seg = enq_used + num_trbs - (TRBS_PER_SEGMENT - 1);
  
-       if (trbs_past_seg <= 0)
+       /*
+        * Consider expanding the ring already if num_trbs fills the current
+        * segment (i.e. trbs_past_seg == 0), not only when num_trbs goes into
+        * the next segment. Avoids confusing full ring with special empty ring
+        * case below
+        */
+       if (trbs_past_seg < 0)
                 return 0;

Thanks
Mathias

