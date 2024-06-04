Return-Path: <stable+bounces-47900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256A08FA7BA
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 03:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC380281F55
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2E33062;
	Tue,  4 Jun 2024 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1tmxSna"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F334A04;
	Tue,  4 Jun 2024 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717465803; cv=none; b=G82X4GqGHDQt5T1JifjGj8GCQr520Sc9s1QRZUWm/4BsDLQb/J45D8wMxEjdsd5Z6bDupX7W5roskAQ/Vry2kNYORz1ZRjBVK4yDNB5HY7rfrq2+XUhqKTYGHVoG1jEVRCAeTtsx1PZN5RDKk5FhA8mH8Jcl+tL8ZeNI6FVyysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717465803; c=relaxed/simple;
	bh=6MLfPln1m/J259AbxDGM/yyZs3jFw54dxWRttPsWkrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJR5dz05Qx/Od75hCFQHcapqTFq5tLZzQD1X634CZLiSKQPz86ghmtETdAVcUPLtrrYGvAneMcMWbTWnxqPC4z0SE7kNg41qLmfBhHS72S55Zuj9EPtj9UXDfiHQSe5OpLxjkuu4HpwbOm25naHIRO0ShJWYShMnEG0ir1j+Ros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1tmxSna; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-6c5a6151ff8so433445a12.2;
        Mon, 03 Jun 2024 18:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717465801; x=1718070601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+H4pqXxRrCq0m6vBhnz6FgDbkFxYIi3HVFe5Ghw4J1I=;
        b=K1tmxSnaEsNdje8RORw3y95ZwRhwjgdI6VUCefkGuey1W0iFJ5FWgIuXNDCZvbz7tn
         PAkMFU84OpQBsGG4/sPPyjygv1YZi88gqPfKQgLC+gaeta1j72uzm2BO7i+Bu8TC4AhN
         Ar/AQYSkYALPqOOvT2vfA4/xejiOJbf/yP+h/+nJerFvNqlVbM0475LoXnmVRudfBYVo
         Y2kGp9fazJxtFXtNrnexPt0Wl9IlcbjZ9C2XyHVw/KrgqKG2cRCcGkcrODcXxhxv8FM+
         cTL3/LWHA1WDS+LKltzG5SEmvfQi6pFZ67F8bp/79DEIe+8yHzI/ALywK5nGLC81jXvs
         XDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717465801; x=1718070601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+H4pqXxRrCq0m6vBhnz6FgDbkFxYIi3HVFe5Ghw4J1I=;
        b=r4c86ZUDxsF2qyJcJm9Ri4bzy4kYZ7YfX4FVLO4ApR1V/iUBorEqKyE3nkaD9BK9Te
         sFgQo2tvIPu7dxIgUSA57e0pEF9MoqiDTJmEwFZIt0zF+yXL5I5cg2BjA5NCzXqfxfKY
         pOVUQuk8sv7m59AeUok/ewJCV1oH7w2RmQcziCALsXjcYFlOemfVPvsfBe5EzYII0dXA
         taNR40s+iv+f46VouRnxuqQJBw3mrrl0X337oDZB/ucMXQAaPT0aTm8wD6RzTFliIYYI
         5OVTYJpR6Xs6rbX8S5Y9vuysZqRVZB7xz3qbZ2LNvDb2vsAveHdEjqxrE7Y6oAW84eei
         Mwbw==
X-Forwarded-Encrypted: i=1; AJvYcCXKGwaTEnkTPKV/nQJhyX1a8IfViWymml5hrQ+QqthU1ibHzDgoJ4tVSTGcOYFtamat0J9JhK7RRXNl6d+c3ankcqf2KYz7lsRXTR1XHndo10lmkqG0D56tF51djMCGKCv5HivG
X-Gm-Message-State: AOJu0Yx6xua2vhDUbw9FUVEr+QpgjwTCCjhk+/mUurp5rWWYeT+ZdeQu
	0rlE5qy98sWcON3oA+MuTINexOaZglFuNNDBTd7mXlsszOAywbvD4t6wXH9vf0zH5kcBvsexOKX
	fTyOEmDfSFn7oGTKM9xMoCzPCfVs=
X-Google-Smtp-Source: AGHT+IGcmMOxhyhO2/DrwQCt3Fcy8+rw8TRx36jgT/jXnxHEGeMRYs2KzXjAawrlomZM/k++yduuh+BE0QPcZU1zZ1Q=
X-Received: by 2002:a17:90a:71c6:b0:2c0:117e:42ae with SMTP id
 98e67ed59e1d1-2c1dc56ccbbmr9442988a91.5.1717465800832; Mon, 03 Jun 2024
 18:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603073953.16399-1-linchengming884@gmail.com>
 <2024060337-relatable-ozone-510e@gregkh> <20240603151854.4db274a6@xps-13>
In-Reply-To: <20240603151854.4db274a6@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Tue, 4 Jun 2024 09:49:35 +0800
Message-ID: <CAAyq3SaGPLkuiFw8ApjkWKvnoqiwsADs7pw07U1LA4bDPOa_Vg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: mtd: spinand: macronix: Add support for
 serial NAND flash
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, dwmw2@infradead.org, 
	computersforpeace@gmail.com, marek.vasut@gmail.com, vigneshr@ti.com, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B46=E6=9C=88=
3=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=889:19=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi,
>
> gregkh@linuxfoundation.org wrote on Mon, 3 Jun 2024 09:58:23 +0200:
>
> > On Mon, Jun 03, 2024 at 03:39:53PM +0800, Cheng Ming Lin wrote:
> > > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> The title prefix contains "Documentation: ", but I don't see anything
> related in the diff.
>

It seems there was an oversight with the title prefix
"Documentation: "; we inadvertently included it.
We'll make sure to correct this issue.

> > >
> > > MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC have been merge into
> > > Linux kernel mainline.
> >
> > Trailing whitespace :(
> >
> > > Commit ID: "c374839f9b4475173e536d1eaddff45cb481dbdf".
> >
> > See the kernel documentation for how to properly reference commits in
> > changelog messages.
> >
> > > For SPI-NAND flash support on Linux kernel LTS v5.4.y,
> > > add SPI-NAND flash MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC in id tabl=
es.
> > >
> > > Those five flashes have been validate on Xilinx zynq-picozed board an=
d
> > > Linux kernel LTS v5.4.y.
> >
> > What does 5.4.y have to do with the latest mainline tree?  Is this
> > tested on our latest tree?
> >
> > thanks,
> >
> > greg k-h
>
>
> Thanks,
> Miqu=C3=A8l

Regards,
Cheng Ming

