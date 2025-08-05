Return-Path: <stable+bounces-166657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF46B1BCBD
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 00:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94C818A4F0A
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 22:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F39275852;
	Tue,  5 Aug 2025 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FT0LqtIU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BA92609CC
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433659; cv=none; b=pOVE8uFCLGSwX3PcIBk5x8Q+Fl5R3RSxn3lSMSufeergCTtOQ3R65uP/w7za8A/ot4TeBgBRUwgOFZwKyE/bWRVkcW/tsjB/JBt7ydfN2KP/lAWwqv98XjM+M4Q2HdjRjAuL31jv/YEROgPHPk7btHZ1oZ7Vyp//3t+O5XUbSTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433659; c=relaxed/simple;
	bh=zS1zWvhTT+IcSshTBcgi0LvYfFbo8Wss63zrFGwEmv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1s3/X+TfX8WcVEFo/iCEzCqMbyb/af1Kzk6hDe0emsqNzn2T9JwAQ43PvsIkIbl4Rbp7+PDLr03/Uq9utQeAd1aQAWrN/P2Q3c5rnRZyjrfUdFMwxBjNueevYkxteyQOGLQNCO0adWneKTjWOfk8ROC7gqyMTWzLBez4bqhVM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FT0LqtIU; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61576e33ce9so666075a12.1
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 15:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754433656; x=1755038456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X3m+xXB2nDYY2FTeCIps+Dx8G8ytYsYqX18zczPNIoE=;
        b=FT0LqtIUmBcx446lNQHnigCVXEuppgMjgyAHhm0xKfIODHzlJ1ZA2vx8cTIt94Tcn9
         /7zYGXOsCw/PEMUhqx+DxUlqX0Pabt1h3fSA0DAb1O+s2IdwWz7s0cXNxs6f5gMJ2mha
         nReCwSkkILNSjCp9b0PdsE8eXTz2j141nqJcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754433656; x=1755038456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3m+xXB2nDYY2FTeCIps+Dx8G8ytYsYqX18zczPNIoE=;
        b=S5bJjdMoye/I9vgZWJXVk/C3b0wpZHbkDnWiSf7EdedpFs/CEVsIWO9fUzuKOBakmE
         CQHm6aq6S4MTu9zWPvZEJbV/zCxfH2ySsXnf9HpLtEb3ETWyLwVvZ3TNvhSDJzpsKsvE
         tdMBq+pI02WsGb8oPJILAAY9/yBtwD3JQAPlEcWbpAVyLujaUJjL0jj3Ct4MlabEGAJB
         PgLqs5gsO56L1saBiQkG0IERY2D2CzkF3eZefC03oIvRjqvWjiDDFpNuKPuRam29PEB5
         IxfunfWvXFzN9JFsc2VR5glYLO5JaTjsIlBmiJGRW4k5kXpWN1B1EdAiq+MCjM25s9Z+
         LadA==
X-Forwarded-Encrypted: i=1; AJvYcCXaVPmC9MbB44aEOeMzS8mxxYiWcfrLFKW4BEQW+PTjWAxgA8CzHSMmbvgk+YmqodRwIyFOwuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL2ogGN7COpecvkH4bNvspxHClioeJPxlIMwNrsxytJKQbWugN
	3RcBeZxhj8TilmHpr6iTNaNxjdIl+AH3ySOFPqt3s2k/am16SYwgkP+Zmj1JlJAus02HdvCmdWR
	NMeKXUQJmEA==
X-Gm-Gg: ASbGncvTU2FwvyP9f1hFHa9uZjSMfrkf6UjUDmfktjM6xKuJSzp7KIaZ8KqWYd/C6gB
	4BJmuZ159eXM6b3DMMisltLdHDjAWw4qxDWOAzAGGQuvdVkl7l7f6tGLxRQpIlWjWtDis+nEF03
	IMKw8xMRXjExbCw80S2A/ta8QOQyZda4HKCGonz1iErLc3PQXAzahBLBdmhHn1KSXvJlLRC2ytO
	OR/+3c2R8E2TxjNbfZj0JHQrGLkg9bji/DpVXra+ejKsL7yjhMj6/gBDbS7HKbB3IfCithJ23hZ
	NgtX3y1pPr56/GRYq2eViHphM8T7oam0xBp7A4Y6DvD5BXJQYk7zjvz/aw8Dsppjf1PkLI4s8SN
	1hzibJC+AJTw72wRI1VJQxnc6ThDMzKdyt+UeacOpaskoTbUxNdljF4DPweInT9+Z7tGmjZBKq3
	/uzcUfWFs=
X-Google-Smtp-Source: AGHT+IF07y4w+xndVB15bL0rlNGvgjpN3d0DENF1HqrKzfu/W2pNPNxyN9Dr1epVqru/Iwz8TE4Xuw==
X-Received: by 2002:a17:907:3d8f:b0:ae2:3544:8121 with SMTP id a640c23a62f3a-af9907ac82amr48969166b.9.1754433655735;
        Tue, 05 Aug 2025 15:40:55 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af938aa8275sm744715766b.57.2025.08.05.15.40.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 15:40:54 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61576e33ce9so666016a12.1
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 15:40:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4dKAdoGvIiH3uMtFV1/MCQAZYT5K1XWH6ZHplvrzyuyPBX6adKOq++wPpBdKWsS8jdEfKS/s=@vger.kernel.org
X-Received: by 2002:a50:d6da:0:b0:615:1ffe:7e13 with SMTP id
 4fb4d7f45d1cf-61796e84ddamr347112a12.16.1754433653535; Tue, 05 Aug 2025
 15:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org> <20250805202848.GC61519@horms.kernel.org>
In-Reply-To: <20250805202848.GC61519@horms.kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Aug 2025 01:40:37 +0300
X-Gmail-Original-Message-ID: <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
X-Gm-Features: Ac12FXzn6xC3GEWZwV8GpsWb-o1g1X9WA5sVZ0frXqURB1sH9fEGM06GbVjXWic
Message-ID: <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on() call placement
To: Simon Horman <horms@kernel.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, Oliver Neukum <oneukum@suse.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux Netdev Mailing List <netdev@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org, 
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 23:28, Simon Horman <horms@kernel.org> wrote:
>
> I have looked over the patch and it appears to me that it addresses a
> straightforward logic error: a check was added to turn the carrier on only
> if it is already on. Which seems a bit nonsensical. And presumably the
> intention was to add the check for the opposite case.
>
> This patch addresses that problem.

So I agree that there was a logic error.

I'm not 100% sure about the "straightforward" part.

In particular, the whole *rest* of the code in that

        if (!netif_carrier_ok(dev->net)) {

no longer makes sense after we've turned the link on with that

                if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
                        netif_carrier_on(dev->net);

sequence.

Put another way - once we've turned the carrier on, now that whole

                /* kill URBs for reading packets to save bus bandwidth */
                unlink_urbs(dev, &dev->rxq);

                /*
                 * tx_timeout will unlink URBs for sending packets and
                 * tx queue is stopped by netcore after link becomes off
                 */

thing makes no sense.

So my gut feel is that the

                if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
                        netif_carrier_on(dev->net);

should actually be done outside that if-statement entirely, because it
literally ends up changing the thing that if-statement is testing.

And no, I didn't actually test that version, because I was hoping that
somebody who actually knows this code better would pipe up.

                Linus

