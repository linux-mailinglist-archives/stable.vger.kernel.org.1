Return-Path: <stable+bounces-210086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14467D3844C
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 19:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3574330066C6
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D75347FD0;
	Fri, 16 Jan 2026 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNSYgp3E"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32533230274
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588229; cv=pass; b=XjZ8ofiQPj95KfmLySJnXtX4xJtg94+bQad7r/b/DW/t7ujRGv8HJ5VWX2CuRad218Tx2807fnxJkGIG2yE1K7hWPYzbZo87pO4yxqqyzkCVirNo/PsBXR+hX1cFE94Y49tnMjccPVS0dth2aVuBLaAZ8/I0FgfLFFOj5uCg9Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588229; c=relaxed/simple;
	bh=gIA9cnkunWjSA6aBsAeXZeJQx2q9RSEgvOoE0mcOzHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ibg7CqDu6ZR6pINGxc1T3ORlmAkIcG9e3yr/dHszKHTe1IzW8zRxXBo+GwsqWiOw8QltsX55pmsEE2EB4yq/8yvYMw3MsB5IrN4c+XM6YJwC5Ccu2bYTZKD+vC5oiQ10c7GNk5Znt9i0fgdMprGhUDPp45xuwhXJeQa/pPhrs3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FNSYgp3E; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014b5d8551so15371cf.0
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 10:30:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768588227; cv=none;
        d=google.com; s=arc-20240605;
        b=aeuXW+E26jXdWsRc86TnUGGLGg2hJmODk2wpAh1wXYom+imqhuXKCpyxCQfPwYkfjR
         RsFEvRwCX8imrMgravF8KeIo7tebqhef2W73vda3cazsXXhRn6z7/fSB3cKaa8GcFJev
         QgYUdNSO7HvRJJ629c0KWI6u6aiLZfRXZsAPNOZQ43VnwQIUtjPEstBOa14JjjYHXn0q
         dWYyxOC+31pBUnEGJYZsAgWjH+3M+MP+S3R57BOAUWa7Zwakl2EdwQGR8hqrtF1Z7TdG
         i0gM5WvnCIDUZzDf0taVctiLr7kE6FtuP6k9eizoYeWfzuiWwgMBub4QfhVoFlv8YfUS
         TiNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=78gXhgLyIFLLpASS5oKJ8Lx5Grl+s0Di0xH8SDZDXS4=;
        fh=TQfXuLFMnZFnSoFF9ONeJSeJOhVJ7SvrfynYd6xF2rc=;
        b=RkadUPI0hmFejUHq+SafFh7mPbA1hJYIwRhSbOL3OilkhPP4kihSQPxqutbS3o9Mpe
         BAcHDcy4YQ99/6xsOsHqD9G4438FohjG2P33V545ex/glJgX5hTqsT/biis+kyhGRicg
         aGT/e1zgA88z+CDSYgz6yflD/dn3Pg+h9S+7u18sG5Uelbk8nx3glen8+o4RX9hrSI0C
         32ZffxmFRz+Uj8YChHiFFQqbURrLZqSWkZKq4jywiMxkyN2+4vtXWUmIcixz4RZoJyoG
         AgN9Ev04Ef/5Z2jBT/GjFE/VlIqRVBAD7B1mooZ42ZiWDzcI+NOfoHfk1c89ZMO2Fa69
         cgUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768588227; x=1769193027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78gXhgLyIFLLpASS5oKJ8Lx5Grl+s0Di0xH8SDZDXS4=;
        b=FNSYgp3EPnyCnvQy2fzGWc1q7nFzQMQR4pk8MZfkIZyWCeulmhsnIOGU+39PVa4/k4
         2dM3APrNRfCi70ABSeDpuKA464G07F1jRd3GlS7kyTHRPM2fwlh+rPPxvY4aeVx3bVOO
         d9aZ0/uDe+FZZaKgT5heNfiUVrJ0mPO7VF78wP7Nnd8pU3QU/2PdAp+gOQDLcwgVihP/
         VrSrD1wd/NWwH07W57Ug3TLF2wd/TyXuzkXgNFd51tGdtoBVsEPTyr40YdnUgDtIxz++
         UI1l53YWqZrz37UbDHGKsVQhK3KtM4vcrsE4bNet/474p5EciDittjhVd1uNOeTx5bRR
         GsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768588227; x=1769193027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=78gXhgLyIFLLpASS5oKJ8Lx5Grl+s0Di0xH8SDZDXS4=;
        b=pG5k+bHakPR3ngFY6Wd4KP74LX1n89p1+n4h5eeZu3Ab1HsbVL90ign/C10Af06f/x
         9uvmSWd6e/qB8ybA/cFK9cYBRiLmdDPI3dCewbq3nI1hIW3at6L98PRHghihxF9g8buj
         4pif08tWboAsvg3H93cZZTrRtlGudh7mGWtxySYJeAPUV9CPH7TxUYVZMCLF1JQXRD+P
         nS39WnqGaPacPvcQc/9DaTywBS77w1MIinxuvQOGayI+0OaSOGQhGKhrQsXko/21VmoF
         zvMtrBfoPknZzrbypz5H1oayQNV2hAbnG42kEXsgSdX3W9Ab3q+S3INOIyx/mc7iM2/8
         bklg==
X-Forwarded-Encrypted: i=1; AJvYcCXRpIK0gIS1mkrE5z8W749whc/chHDj25Eti7IXO13Lbhk2jaS3rVd4JWEJDqL/JBPluFFm15Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6b8XT5uv5/n6zrsxoNDKmLSylSzRYgMIzIJMziUPq4PeEToT
	eZCA/uMVehCRWf4CE40C7cBVAw8cG5FMm4S8DJM8+ayb01tBGAPqILuvcCJ7IRmj0Capt5f6ZAA
	EDRYsWs0i9z2hBk2Ff7OITwNjOui4V+snw5zZoWnk
X-Gm-Gg: AY/fxX4EREekhQfMCLIbNAL2BZps3cQXncXIf3VRlCEd9eQipigG6x+ZCZvVrXeJhwK
	GiQoKEB14eSHpaLg8i7PippyBi9VjQVVcpBPL+pShFL448ZbvJ/SUtynUbGDD9UiIPcp24wYuuF
	aNpdarAh6rQdMBsLWXrcEtyNl1rLDjVw7EkQ+GCdMuLMoM711QNZ7eB7/o8FgNPTSPbOvMPe8hn
	T6gMcK9/XnmYclX6mulgyLj84/h5OfsVlhrcwlplg2BxzJNyWMFySbaGv8WEu2MRCQzaw==
X-Received: by 2002:a05:622a:1999:b0:4ff:c109:6a4 with SMTP id
 d75a77b69052e-502af961d0emr427261cf.4.1768588226665; Fri, 16 Jan 2026
 10:30:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpEQZMVCz0WUQ9SOP6TBKxaT3ajpHi24Aqdd73RCsmi8rg@mail.gmail.com>
 <20260116021835.71770-1-sj@kernel.org>
In-Reply-To: <20260116021835.71770-1-sj@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Jan 2026 10:30:14 -0800
X-Gm-Features: AZwV_Qijfm4QX7A8EtjaARaEPudSI5DCWWeSwN_9u_yVlGn-gJw7kPfo1GWvE2U
Message-ID: <CAJuCfpFevUwXxwOrpH3+VOibjJw0rBw3=QL-nqeKreNEky7_Gg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Docs/mm/allocation-profiling: describe sysctrl
 limitations in debug mode
To: SeongJae Park <sj@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, corbet@lwn.net, ranxiaokai627@163.com, 
	ran.xiaokai@zte.com.cn, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:18=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Thu, 15 Jan 2026 09:05:25 -0800 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > On Wed, Jan 14, 2026 at 9:57=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Wed, Jan 14, 2026 at 09:45:57PM -0800, Suren Baghdasaryan wrote:
> > > > +  warnings produces by allocations made while profiling is disable=
d and freed
> > >
> > > "produced"
> >
> > Thanks! I'll wait for a day and if there are no other objections, I
> > will post a fixed version.
>
> Assuming Matthiew's good finding will be fixed,
>
> Acked-by: SeongJae Park <sj@kernel.org>

Thanks!

>
> Fwiw, the typo is also on the .../sysctl/vm.rst part.

Correct, I'll fix in both places.

> And from the finding, I
> was wondering if it is better to put the description only one of two docu=
ments
> rather than having the duplication, and further if the 'Usage:' part of
> allocation-profiling.rst is better to be moved to
> 'Documentation/admin-guide/mm/'.  But I ended up thinking those are too t=
rivial
> and small things.

Yes, I didn't want to complicate reader's life by adding a reference
for a couple of sentences.

>
>
> Thanks,
> SJ

