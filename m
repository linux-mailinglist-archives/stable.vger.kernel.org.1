Return-Path: <stable+bounces-114006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B377A29CC5
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 23:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A933A696C
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C4C217719;
	Wed,  5 Feb 2025 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXh4gkeB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60121505E;
	Wed,  5 Feb 2025 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738795332; cv=none; b=OfPTCJAOF6T07ep+IbIKowaGIMqAxkHjjHxKkNOAhxhTxvZOKdGmAy2W07Vl5igJyaMcGvCTvA9z4tXnbffrVUoH3Gp8nexD0Smi9S3UTxJRFg06hUh/rxfBmpe0Lk+ztQl0uxJ0/WRzzEiK/fylo78JodWo7NMypG7DqmLMth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738795332; c=relaxed/simple;
	bh=Fxuc+WuGK9LFrEppLkxQ+HGxGt0oSE9m6Bp6Oln8C2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=cHvQ8/K9mn/NpRKQaUSOrevPeCQmEpIyasvyiAvXET1cQkHOG1gD1FmxvF6dbxsXmDSwNhWbS1Sm83UHNjcwJdWMyGenvFt3nxrQBrwrR+mMGUxAMxKjB2PO/9lXWHx5sQqeUfrA8V25asmaGDFHaWrb2kjMYFQCFtsOMRNMRcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXh4gkeB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dcd09af4f9so696701a12.0;
        Wed, 05 Feb 2025 14:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738795329; x=1739400129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fxuc+WuGK9LFrEppLkxQ+HGxGt0oSE9m6Bp6Oln8C2A=;
        b=EXh4gkeBSRWHeGwcXf+RxLbx+FJ8LXfxhAK2VxUbIvCZRhRuNzbpiGPdNEG1BNIvQt
         ttRSt2H5i49pa+7nBFPnmGrpEL8bT4xNf4oycSdaBYVLYjSf2NiePsL1ylQO6HByYXvq
         oqrRtgn2lb+xDGFIXwDEUBVf2GsLOc9PZBftQ6AAHay81B8dI6OxzndkrHejo5r2w9K1
         aG8E30lLsXLHzrJygh3eutLNwM9msmdqcBXCDbo3mcxZaC4+VZMw3fqbQxXMC4mntPN5
         kJEudK6OBBBV7dcbcJx4cg3byZZJ3yX9cZ+cFxOis0/WEmNJL7a6o5UIYCgyJh0a8TAz
         3dKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738795329; x=1739400129;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fxuc+WuGK9LFrEppLkxQ+HGxGt0oSE9m6Bp6Oln8C2A=;
        b=WEmdgTG/JoiMvumiZHEQ9ojO1qm0FReWWe55zlZx3/+a4ujYShaWL6vzljSWjBp+aF
         n9YqEg+R0AOICIf0dU9K7wz7jnqDzMP7XyKQX1NiAfTqG2jlzEVfFLXPK03CtgTlQ2+m
         YzLz1qHXQQzOTC+Ba8S0kGrEd0jKds01AQuLkDGcXF7gKuBMLWcJCD8rQ3ikDt9und4p
         hP5thIYxQgtRH0fggDgVOWaYOxTk+6mecOGLxrTBzqO0NLxiGPrupxFjfLwd9uFsAAPj
         TfEMxX8QaV97cTwZVSJAhz+dyZOcQdmL7TUV+4dFJoB+U6A/mv4TE8cLqJVrSmX8eHIj
         wCIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhZu8sRYyXgCpCGBb9Gmw7t1jQ+MAQlT/+yEJvFDz3ino45d9cT28FbOuFLmP7DhX4KGhN4Fm/BBnq+40=@vger.kernel.org, AJvYcCVw6Y3DE9c2muKuE8Za2ZiYgRlvAD9ubG4VVSujd8y29RGQyQHDUxAKZG+Po7hFNHgAbOEOGQVlUciJ@vger.kernel.org, AJvYcCXjOB9KAgZsV8gchCI98f4HcWh2mvAjf8/+nmmGvbz/g8ppodB/xa5VTaZ4ZIYTdTD/SO0QsN8p@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3yvscEYafn1CPEXFJ7or4sNI/HFlIuiv2tJuGoAFoWMFAcJF
	eLkhrbI/QgNhIgYoM7LumrSv7S56UmhtmfDXYtieyR5xBMF6fkeZ
X-Gm-Gg: ASbGncvUaIWNWp4qWiSib7tE4qUo3rbVZtC0+3V+l/35Deiw1xD1QA1r3fa2wuHY8jh
	CaNLTc6GV7DkSTpzd79aD5hIhjmUPugsNFSnhUwVQOeUaGeZMS4Xi8zbfSflbcnebzBn46tQJeC
	L1flO4iV6yQLfGX6OsQrPdVOVCDV9QxImsoRU+UJO1wl5q2481SSD7ian4atjVr5N6GNbwxKzeS
	LqZQv+ATi5RxCZibpco4ImWsOMjL6BvWHRs2BAbmMX0CJ8t8zirf2KUkUTjwtfsR3o95ZGMC3q+
	XirN7v8uG+guwiAw5wE3jH0BhdDr4gMC
X-Google-Smtp-Source: AGHT+IETAJTW4b+efXQKaHPsDKb/nAvZaQXF/q7r/2Ski+H4KNiXwj9HdoGdiKWVsMRvPAc0HuJvzQ==
X-Received: by 2002:a05:6402:4587:b0:5d0:e615:39fe with SMTP id 4fb4d7f45d1cf-5dcdb757597mr5075568a12.18.1738795328838;
        Wed, 05 Feb 2025 14:42:08 -0800 (PST)
Received: from foxbook (adtt137.neoplus.adsl.tpnet.pl. [79.185.231.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc72407bd6sm12429808a12.48.2025.02.05.14.42.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Feb 2025 14:42:08 -0800 (PST)
Date: Wed, 5 Feb 2025 23:42:05 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: mathias.nyman@linux.intel.com
Cc: gregkh@linuxfoundation.org, ki.chiang65@gmail.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] xhci: Correctly handle last TRB of isoc TD on
 Etron xHCI host
Message-ID: <20250205234205.73ca4ff8@foxbook>
In-Reply-To: <c746c10a-d504-48bc-bc8d-ba65230d13f6@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> Not giving back the TD when we get an event for the last TRB in the
> TD sounds risky. With this change we assume all old and future ETRON
> hosts will trigger this additional spurious success event.

error_mid_td can cope with hosts which don't produce the extra success
event, it was done this way to deal with buggy NECs. The cost is one
more ESIT of latency on TDs with error.

I don't know how many Etron chips Kuangyi Chiang tested, but I have
one here and it definitely has this double event bug.

These are old chips, not sure if Etron is still making them or if
anyone would want to buy (large chip, USB 3.0 only, barely functional
streams, no UAS on Linux and on Windows with stock MS drivers).

> I think we could handle this more like the XHCI_SPURIOUS_SUCCESS case
> seen with short transfers, and just silence the error message.

That's a little dodgy because it frees the TD before the HC is
completely done with it. *Probably* no problem with data buffers
(no sensible reason to DMA into them after an earlier error), but
we could overwrite the transfer ring in rare cases and IDK if it
would or wouldn't cause problems in this particular case.

Same applies to the "short packet" case existing today. I thought
about fixing it, but IIRC I ran into some differences between HCs
or out of spec behavior and it got tricky.

Maybe it would make sense to separate giveback (and freeing of the
data buffer by class drivers) from transfer ring inc_deq(). Do the
former when we reasonably believe the HC won't touch the buffers
anymore, do the latter when we are sure that it's in the next TD.

Not ideal, but easier and better than the status quo.

Regards,
Michal

