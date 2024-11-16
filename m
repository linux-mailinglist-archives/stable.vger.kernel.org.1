Return-Path: <stable+bounces-93646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F4F9CFF2F
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 14:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E4CB21071
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9406BEADA;
	Sat, 16 Nov 2024 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD9PMywx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382A2F29
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731764952; cv=none; b=O/zEvAhXfnXSrAG1HrEg71BXXpGcQRJgT4JV58krrOvOqU0FT4bVnJlXIWi4VoCL7zSWPL4d5spuYqUtkQ+LDJrcZwrGRCw8aKrqkdKblQn+NM4YUFVqNuJjB0CFiDJXxe6xG1c7vBdWweaAbXuC+eCaVslUECGkoT0ukNE22Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731764952; c=relaxed/simple;
	bh=vLHUnEgmtrs8QgwZx5mDv5ZNOauwd5pYOZ3w87k59Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgff1xNMa4u8xuDAw/1nJt35hGMFkBbWm7+x71Ia0/zoKB4WwbAI0Bq3j3Ae7yQ3C/ocypUlz2V/gUhSopMsABKL8fPVoGCPbSO832cyZ0NnbPtWLvT41VRg+lFOeW0jLTlemKKzMTARnFfAlscl/ASXvP8b+TSHYSLLM0fxMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DD9PMywx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ea33a70fdfso77932a91.2
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 05:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731764950; x=1732369750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MerGvk+LX7m5wHiBfzLF0OhywQg23ssTve5F8EamuDU=;
        b=DD9PMywxdQvt4FGCoEks29iLbRaUufpQ4kMz2HU6jZhPr1DE9CXg0v1zXWICPCuPsa
         Lmae/vApcvOn25QEaUrMFvyDjbN/dSJlTS+nTV/6qgDjgGz6PztvuQ6V16mrjWfixgVZ
         gXXdO3uVeUl1XfGpaaE4T8smQGuADcVfu2EWjpYJdMZMODKrSATDdBv+civ77J0OEvVE
         BcghdXKIrLqdjjHCZfCbVPfIMwdwY6AZDwUvxkh+BUfjnFghHWaUkgeNdvI9fbSgeswJ
         /F+gFwlZ85xI+qmALO1p71IWJ8iVlheynk2+LFDeIO4MNWpAKkxMfAbKwMO6hdB4iy/r
         2R9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731764950; x=1732369750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MerGvk+LX7m5wHiBfzLF0OhywQg23ssTve5F8EamuDU=;
        b=EmE4xL4XCzTnBB/EupFis7uWugpfYHrpTXIP0O5yDAHVdtmEkW11e2wSvPO50V69hF
         r88iV9SQ3/R8Gq/1T1foY/v5vcxt9KMoh36w2cRibA09MQXBS/fQcUNd6u+wi5vyhDys
         tBdD4hgXbdbdSu2W68FJCIVFdcgKKzBkYGvXwsgtDBWKHJGOTx88obrXSBh9YCXwfN0S
         gCFAZNQF5rLze2s5ccjy5wR2duQIKcyDsGNqcFD8jlmiTpD5Zu5wWIfyg/InWR6O8k2C
         oIslRHHnzxEG28Rx6Y3FKNGC+dakJNcRTbzi19Yk2oeZvosiwf6l43SjFADM2AQp6BNk
         j10A==
X-Gm-Message-State: AOJu0YxCY52LOVEy9PLX4zyzaI62GT21RyRCVYZjYHrBluJydnNgV953
	Si2F1QZwwxayehdm9ygdXfnWvB6vs+T5zZzywu/8SOd6K3sPmFzCSLgdyQwRUL3cdQDR6K9tMaJ
	KFirAWQunw4MaUJBuN9Cah1dg0pA5Gqtq
X-Gm-Gg: ASbGncugjbf86XQ2zilrU0e9DgzR3FrUJIraTFsiD6q8OVGvQUiMLGX+ejrdSv5YlPB
	jNyEr/tYu7/uBf/3IXxvxxMAyjkbNAhs=
X-Google-Smtp-Source: AGHT+IFN8ryR2wZ4zfmfwwlxibMw10sXShwT3DC3YNRkpCSM1/+tQvbbihhkC9yN3+xVIXZ2PQIblDpE+WPswBIa91E=
X-Received: by 2002:a17:902:f70c:b0:20c:f6df:6aee with SMTP id
 d9443c01a7336-211d0d7ac0amr37134185ad.6.1731764950260; Sat, 16 Nov 2024
 05:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116130427.1688714-1-alexander.deucher@amd.com> <2024111614-conjoined-purity-5dcb@gregkh>
In-Reply-To: <2024111614-conjoined-purity-5dcb@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 16 Nov 2024 08:48:58 -0500
Message-ID: <CADnq5_PkG8JywBPj5mivspUPJUC6chEGuNEH5a1_A-FCd_8wog@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/pm: correct the workload setting"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, 
	Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 8:47=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sat, Nov 16, 2024 at 08:04:27AM -0500, Alex Deucher wrote:
> > This reverts commit 4a18810d0b6fb2b853b75d21117040a783f2ab66.
> >
> > This causes a regression in the workload selection.
> > A more extensive fix is being worked on for mainline.
> > For stable, revert.
>
> Why is this not reverted in Linus's tree too?  Why is this only for a
> stable tree?  Why can't we take what will be in 6.12?

I'm about to send out the patch for 6.12 as well, but I want to make
sure it gets into 6.11 before it's EOL.

Alex

>
> thanks,
>
> greg k-h

