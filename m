Return-Path: <stable+bounces-62557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6377093F61D
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 15:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0C01C21AD9
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A9214B07E;
	Mon, 29 Jul 2024 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hOXkNMSv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A05146A63
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258314; cv=none; b=i0TKpUvGgNEpw4efKy7KTpJBEmqlWZnMaRo6ScEBxHXyPrNDfWx/PjFBVGDdZdfljFeNPZNan5njrft0t7TJESJj0Ynbk2CUsMTPkIGUv758NvQ+S+eQskmkPSorwEpR68i2FxXT+Ir9Zh2+A7JOS4P6syn8LuD6SdKrI/gxH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258314; c=relaxed/simple;
	bh=Nwdk1Zb376HFbM1m2aApZjKPiZ11wbxbpIpoPekhWTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLQE/G46dMfL16cS2s7kkZUsk6bEerQ2r8SAnVIjFIdCQ/SOSoWmlL9tJMWpGnv85KPOBwf0FKIgrCPzv7/3YByMcnmwwKMByKPIvwVC2ELBq3WT6BsiKCwwsAs1UO/YNvrsgpsYj9MLJSK+q4L/w+5pT2vYWDx8FqbeIvZu+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hOXkNMSv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so316499266b.1
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1722258311; x=1722863111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwdk1Zb376HFbM1m2aApZjKPiZ11wbxbpIpoPekhWTs=;
        b=hOXkNMSvLOzz3irBecp3MxDUVaNByZNfDwzrGas0ykxItE7BSuBSS8gm9HQrYV/7+Z
         rKeld+8m9mlDyxsovQm8uqfD/UIC/Xq6Ti+4ipfCQFgDg2QPDewb2HnkccGa0NnZpD2+
         Ps8LhgmDNJEZCit5ygCCarR5bH8Gmxa7wIyOFxQ/ULcVGuxDVvB2wypBX50cXE5P+94L
         Lw7k6X04AFrr384CTs8cYCDe9IMUxI8pLWFYbIR3vM1dKEOGjoUQG3NH4dTQ9msGfXKp
         kWGqqd5hS3ywAa35v63/yd0uwBktaibM3eCqme8WPyJ7DV/4qSzqzUeZfIAY1zBoCl2l
         t3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722258311; x=1722863111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwdk1Zb376HFbM1m2aApZjKPiZ11wbxbpIpoPekhWTs=;
        b=gWVjN0vpoN3z2p301oepcZUfte4Vhrr5qsP1GlhrbawM3SeIjVGKzmSloy8lXSRRLE
         TNAcDuoGYahO3D8YcKaBz4keVRu5pCR23tnBW/ADNcN6mozqtqMSkyxRCkehaom8ko8v
         5yF7Nffe0jCqcsVmqUFhYiF+0EHwuiwxqdn6TrUcai5N8jPFLTLT/qt3ukZcvmEZTStL
         tFlcW5F/2Lk8lq0EfUJIlymcFY6oTytg+vOUgyLWu1KCVq4n7ZnPy5CrAEMZCK6VVGQO
         Hq8L1L2WBIaE/OyYCHf6INYUwErTUAlSzrhwvIQj1IYlki6wIfkrop3GllrgEd+862ve
         kcmg==
X-Forwarded-Encrypted: i=1; AJvYcCWCL0nVxB3HCiDOb3KTqYooNTPABszSM3M5b4W/T3qds9OccTV+Gappf+/sWBIYD+duq9KPBOwa1ORgctWY7TinoTnitvUj
X-Gm-Message-State: AOJu0YwkznCwAOZ45o62WcXOoB0yL36PuT0NHE6iI69ooTfbjv7w49F3
	W42eto/iwVYrrVGp47GhWpQf2Y3BLBcK3fLzGZF9JAlePlbRkA7cmo/10qEuXhEh/kfFbr3l7aa
	13fM31qYv8MBT+AuUyGz80kyZ+89AE2i9Si0a8g==
X-Google-Smtp-Source: AGHT+IF3q5HRQsp30wvL513VaLZ8ou7ZSERFd1RF1FMGbO2FLdRRU63BXpRqD92PQM6mpbVkAMHS0DgJYlggtS8sCLo=
X-Received: by 2002:a17:906:d54f:b0:a77:de2a:aef7 with SMTP id
 a640c23a62f3a-a7d40150ad2mr553058766b.44.1722258310918; Mon, 29 Jul 2024
 06:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729091532.855688-1-max.kellermann@ionos.com> <d03ba5c264de1d3601853d91810108d9897661fb.camel@kernel.org>
In-Reply-To: <d03ba5c264de1d3601853d91810108d9897661fb.camel@kernel.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 29 Jul 2024 15:04:59 +0200
Message-ID: <CAKPOu+_3hfsEMPYTk30x2x2BoJSb054oV-gy1xtxqGycvyXLMQ@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/fscache_io: remove the obsolete "using_pgpriv2" flag
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, willy@infradead.org, linux-cachefs@redhat.com, 
	linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, xiubli@redhat.com, 
	Ilya Dryomov <idryomov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
> Nice work! I'd prefer this patch over the first one. It looks like the
> Fixes: commit went into v6.10. Did it go into earlier kernels too?

No, it's 6.10 only.

