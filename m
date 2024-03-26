Return-Path: <stable+bounces-32326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47D388C579
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 15:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F3B28176D
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 14:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A5E13C3F8;
	Tue, 26 Mar 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7eF0AEr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629AE13C3EB
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464238; cv=none; b=fjqbHjRHvtKeBMxhij9CI5yCnMcHc6LSpjmIoa1UD6ZyUM8dqXc7Sy3aee7y/s+8LtY0pl9/ny3Q08/1F55dvJujgqRhz/eWbSgQi4qGw82I2SaQ03obykGNl4YlCF+/Lj05tXiwv6ObLUatCOJEFZDD/DNkIaZZwAFcpJmCKWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464238; c=relaxed/simple;
	bh=PKvs+Ifa+14hX9p1LNFxIABmBql5tpHj1BT+AEjdf4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQhFdGac6uxagty3d8tdy3etEBQiB8zZ7UXIx2ZpuQEhtanMdg6OMwKWxEc7U8/jV4a3CeggXirvICnqusWQIBYnwGx8cXYKclcvO0TO9JTls6YLy5E3NXrBNsdW1+eZeP/g7WGjVJdfSrXrdYNiyLJ8ZOMbbc9yGlzYd4D6Bj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7eF0AEr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-413f8c8192eso81575e9.0
        for <stable@vger.kernel.org>; Tue, 26 Mar 2024 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711464235; x=1712069035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvRPX0srI6Nwl8MPf7Dm2KIiqeWF1NL4djSI9z970zQ=;
        b=j7eF0AErNCfdNZ2PD1wsOWfXdC5Jh8J7dBnJO33CYFakuVAfmomB1afAjrA2ZQKaf7
         SMCUShieYJmAq7gWFqeKiuzNsdPlakY567KsZgQtG6gDsvwrQnihtDX9+7U6NnTFaRZx
         RHdmBYPFetsNb4ILWudJVYpkr4lIVhA7ivbuDLUlArt/M4CW8YovnQw3HaJC3Vve4LJk
         07Dc1d2Xmbg2GP5NJiN4sJkJFjjOH+WJ4ise/PHJgmz0GVRw0XTJDFpcV+OEaxiIIlbM
         5ZVB2IfKYG47wlrtEXxWyDwcV5YZW42vBkqVqTdsC59D7fdDc8Bu9Y/dWpeZ/dX6pmg1
         KlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464235; x=1712069035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvRPX0srI6Nwl8MPf7Dm2KIiqeWF1NL4djSI9z970zQ=;
        b=RDj340SmryIiVi5V/0AaQUY2/ORzp/3n9VQShBg/WzxssTXgp87wB8nYJ38x/Vxc8X
         hi6ptg9f/aWqNWQE28zbriHrz1LYtxZ7RWZf8RyAPrwVitPUzNO57WYc485gTuTDGExB
         CzeEjiXQtQ7QloGbFUzaXSVmkY4FKv0R9C7oBT9aL3wjeSmyWJd1hFOx27po4ldaiMto
         zN2iJCJo8yuGVS42kOmDkUsrYQaOXpy4Ya14Y93Llg25rUTeDXx9aUEjlNHYzbH4JycP
         V9/oPsYkfcl0eUyC4KJArBUjlLaCVqxLHXLJKp9OgKuTcvY33r7iCjMPFF3U+KSt9Yd2
         wlrA==
X-Forwarded-Encrypted: i=1; AJvYcCU+wqSGYMH5EAkp4OC6KYZ/lKpXBbIoWWr2ZAwUvtD9jze+gV+H+lACM7MNy91SBW2uwOiJQt+D84MYWq+bfnVZCLO9Hgrm
X-Gm-Message-State: AOJu0YxoopyGor6cSJbADiM4sXljrHkXyzb6xMDwqc0XnESqkv+2OD9K
	U1MW7CVByy/wf5KgOdJrM2jjbwEh95KCWvnjv9CJRMpGxHZ1gr0zjWiBfPalGaw5zQxNta8TwOn
	TmBrWfXyZiAVE8wleyuU8MFdIEMKnV8TrAi04
X-Google-Smtp-Source: AGHT+IHyQfy0mSMBb57kAfmIDvkx81N8QcG0TvDbWsHX47nCDYyzaS87QB9tRR8mdSTMbNlTZoEBVpDdNz8bsVEN72U=
X-Received: by 2002:a05:600c:1c06:b0:414:11:ec14 with SMTP id
 j6-20020a05600c1c0600b004140011ec14mr185229wms.6.1711464234407; Tue, 26 Mar
 2024 07:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319074337.3307292-1-kyletso@google.com> <2024032624-drizzle-coaster-c97f@gregkh>
In-Reply-To: <2024032624-drizzle-coaster-c97f@gregkh>
From: Kyle Tso <kyletso@google.com>
Date: Tue, 26 Mar 2024 22:43:36 +0800
Message-ID: <CAGZ6i=1BGzRD7nGnLKcbZJOWT_d88gAS_NWUg9KvZ4=wmT8xsw@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: Correct the PDO counting in pd_set
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux@roeck-us.net, heikki.krogerus@linux.intel.com, badhri@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 5:30=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Mar 19, 2024 at 03:43:37PM +0800, Kyle Tso wrote:
> > The index in the loop has already been added one and is equal to the
> > number of PDOs to be updated when leaving the loop.
>
> That says what is happening but not the issue that is being addressed.
> What is the problem with the number being off by one?  Is this a "crash
> the system" or merely "our accounting is wrong"?
>
> thank,
>
> greg k-h

When doing the power negotiation, TCPM relies on the "nr_snk_pdo" as
the size of the local sink PDO array to match the Source capabilities
of the partner port. If the off-by-one overflow  occurs, a wrong RDO
might be sent and unexpected power transfer might happen such as over
voltage or over current (than expected).

"nr_src_pdo" is used to set the Rp level when the port is in Source
role. It is also the array size of the local Source capabilities when
filling up the buffer which will be sent as the Source PDOs (such as
in Power Negotiation). If the off-by-one overflow occurs, a wrong Rp
level might be set and wrong Source PDOs will be sent to the partner
port. This could potentially cause over current or port resets.

I will update the commit message in the next version of this patch.

Kyle

