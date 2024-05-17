Return-Path: <stable+bounces-45373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C18C84F7
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 12:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAAD281E76
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF7E2E852;
	Fri, 17 May 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adyVflj7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C48364AB;
	Fri, 17 May 2024 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715942478; cv=none; b=dmyX/ORfK7jE+c4E/sWvGvm60dKTkulmvwhIXhD4jBLa0KKbKGAlAVXUzw4xGk6fnYSPd+zkG7FpdWU7SQeSGX76Gejmp+xkaOgIxn/keIeizPtPErS4rrRLXZ3gRkzNGHOsKV98c63qRekxo7vBmJfYAZRGSBFZ5ikcD0PPT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715942478; c=relaxed/simple;
	bh=HnELnEyUYaEKQpflPqcDhBPrjVZ6I+K13o1A83gtzZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ/oq6foEjL/hAdnSIffQBgjEWBcOpGIFTQavFf/OEehOkn+NBXEcNA/jFqR0+yG8gK2ssWHyiKUfZM679YjzyFz5ERhhCf7Im2yW6YRjkDcctmLzhmEhvIH562G6WTLE0nNmGyAVUnvb0nQ61xfUtRpo8zaETL0ED2hp5qkkKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adyVflj7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso2602545ad.1;
        Fri, 17 May 2024 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715942477; x=1716547277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnELnEyUYaEKQpflPqcDhBPrjVZ6I+K13o1A83gtzZg=;
        b=adyVflj7nCc+6gD08I6huhizTRHZgdCB7YkH81R3p3WshtwccUvD0KkFdwYxWwAnaP
         huoMB5eGUsxOkulZYb4QjSfaXFoe0khyzrOfd0KMZnBN4GnqCmSI5K2n6/w1/HPF/Epr
         kcx9ndK/U3gExZYW0pVBZmCkIH3ttjVY+7TseEFDNIexQRF9saYyadvYxd5KEylx6aMp
         jvlKgsa8LVHOzvON2RccyppMUUGBl2pt6CFII8+CKB8W6PIytv3mXE2fm1e2AqOPk3IT
         LKqSfAGgSeS1qCNKlSENgyYoTY3YdX7LDQTSj4WOZIOoJbEw+qj0EsW78u7cyzPBDGrF
         6KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715942477; x=1716547277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnELnEyUYaEKQpflPqcDhBPrjVZ6I+K13o1A83gtzZg=;
        b=H1JYb03oPGazrOS+892rwCBkuEyaMs++OJMKXqQUtXgW4g4jXjz33LLvkYWMd8G0zG
         2Bm9Zrjobrm0sxV125PmlHRjidO1QGarQfWfBM7/eHcxknF4kJA0NlqXhOYpaCbiwYzt
         bEMV6tZu7DUDEkBjUtCf5QP1+GWj3LbuTAOhxz15i13n6LNYH03NNi2AUa/Ro+HAHVrZ
         hVyJYBGhfK8T04r1ySvEKdCq6pMQ4XEOgFec6U57ZItNacbijKhDsjqvoHOZOZwMB2Qe
         APdqGLaJsnJNCk8JF+vimWPB1/QRkxNIbzoqVB3Wu06qYagWwzGIdZYDzISHKrcTopKy
         3RZw==
X-Forwarded-Encrypted: i=1; AJvYcCUvrHuKYdUHEaVrmBTyEPXtC1YV6iVtaFq7KNc1QvFANN1+YXY4gPdlhI8AebYW6AmsaCdU54svSUr84J3BLAWgswve6CuMVEujJQxWsakszOaBy3eKNQLaFNH/O+91tum62MBa
X-Gm-Message-State: AOJu0YwXQ4X765rDuO4y4H5O5+vd23Oh4vAOa/xNQkblW1qd2lhyG5ro
	EgLr/9XR3yIgTfG1ueHUGAvx3ackzGweTol0jMevyOiRtxeMjPBzc676Kno7RxML2g2NBdZqSxi
	JDYGB/JowNhn8mdLc8oxedTl+jZk=
X-Google-Smtp-Source: AGHT+IHuZeKXtTVhGQKp1k29cbNkxgUfOuOsqfJ7eybmj4e6pQ5Rztp131C+Gw30g0TdCnnwnVqbyby7gn/y+vnmB+Y=
X-Received: by 2002:a17:90b:1d05:b0:2b8:e75c:c7e3 with SMTP id
 98e67ed59e1d1-2b8e75cc8abmr13712438a91.6.1715942476620; Fri, 17 May 2024
 03:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516091232.619851361@linuxfoundation.org> <ZkYCYxoxqrwlVSI5@duo.ucw.cz>
In-Reply-To: <ZkYCYxoxqrwlVSI5@duo.ucw.cz>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 17 May 2024 12:41:04 +0200
Message-ID: <CANiq72k_JQVy=xYeFYb4h-gds=_4HPcV_1uBmUnaveSXVBPkdA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/244] 6.1.91-rc3 review
To: Pavel Machek <pavel@denx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, richard.weiyang@gmail.com, 
	masahiroy@kernel.org, ojeda@kernel.org, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 2:56=E2=80=AFPM Pavel Machek <pavel@denx.de> wrote:
>
> These are marked as Stable-dep-of: ded103c7eb23 ("kbuild: rust: force
> `alloc` extern to allow "empty" Rust files"), but we don't have
> ded103c7eb23 in 6.1-stable, so we should not need these.

I think what happened is that I asked for ded103c7eb23 to be dropped,
but its deps didn't get dropped.

Having said that, "kbuild: specify output names" was a fix in its own,
so we may want to keep it anyway (with its fix).

Cheers,
Miguel

