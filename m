Return-Path: <stable+bounces-210059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC46ED32F7B
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 15:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1534131D4590
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8C439524E;
	Fri, 16 Jan 2026 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rxm/VcE3"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF4E39449B
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574554; cv=none; b=E33SO3u/Ulz697WvZ2Fiemr/LKJA8d7xH6Q6gMcLTfJBOIEc+VR7SDUKkBTe1pgpstRpYlcsaXc0Ba9KSxrznonekiZd/POVBsOnsc3f2SoCjXjzIbEbrc1vEdcvkf4Xps5mOn+8oVO305cuuB9SGsvkRSPCWBVi1YrDAOl8DSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574554; c=relaxed/simple;
	bh=KX2IErmnbLgLJTuS0TqC6Ce02SpKwHVKEysgCsr18GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVrFjuWUSzLpCNC0DlZpY3iQWhgR/D8jQLj0NP/i/RKxIirhkFlTuK00oZWb7Su1ckzqDOJeVHD6wE8E3FXNlsPw6gvD314UFPN85L6WqHQxiueYZM6FdP61zMVCiJaT2xhcOJqWn8X1vGY28aZkenx8iKk+Fy7OOJlP3pMI9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rxm/VcE3; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78c6a53187dso21300317b3.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 06:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768574552; x=1769179352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0Wu6AiQkkS9+nilzgzJB3rMYTbS0yo7XGq1n41xVt8=;
        b=Rxm/VcE32t8SMJh3xjpZeY8t3pVt4CmxUbjEl9LWH+rgZso13cQ4bCS/kVpVtLkxRX
         yZu9GEelMDIa2tDnC8ycKTSELBaHkpwR8hQc8EpGiL7nbAJvCZy9z3tMFVnLdN71Fuo+
         q1euxx3NAmv0hvfssy6YGSuQh4KAz1Mu+JlIKR30bMhkUUXAJvWfdOVdulfQCcgITKD9
         M1Nc4bX4RnSvlcgk2OdktrtHUmKb75SNVnEhBNzLJz9s5+bTLvB0SK0Cqt4CGC1sYFr6
         ZiFoeRkR+ywalXaRESedd8XycHDuK89wOJYd+z5M1mPtkSUOao/TkO7AHw3zZu53oYpQ
         eB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768574552; x=1769179352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0Wu6AiQkkS9+nilzgzJB3rMYTbS0yo7XGq1n41xVt8=;
        b=ZpetsPsStQS+5TRWVjbh+cHZbib4SQkM6tSd/fSnBYvrDjNLPhgRmPXuxYEUg9hQ3O
         veDA5e+8Uf20cQrSq5QH1NK63vCKHhywSEmLbX+SjNFxXQooEV1HVuZkKvAFECrwcxsO
         7rF2TSHj0xNfjgiXM0qtTWkAF6y8hx702wU02X6IetD6xuRrHLQqDAwAY8SwyvsgZfcf
         CEZBkil0azWteKZryk+0i+duEJwWUGmgo+0Fjj69UGQNhx1XQ+kTNjcWd7J0Y5uGKw1W
         K5XpSj/F/o6baRGx3Wjdj9DalXNhxudvliWQaB2Lmmr8Y5h8NXZ3N71fmE7IEar6b9Zg
         Zo1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxvfAy5hw0SS/gFMuEp3LnEtGtZToa3hvCWj3OJ6oaxZ41pp4Yjl3ZIqjChhLfCG0xa8dWl5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0DX7v2vADIdC5VIydfm2u5LSeJvlaBEMRxMK/ygGBrHzDoHp
	Cx36xXu308EAvlsAHYTQD8zOarY5A4iogWAL8eKuQM1KVO8gVlEJcOYd0DAZOAFeP7pLli2SVHg
	22wNLyn9aWr2/Z1aJybL5MQTPeMwbya9gXre2
X-Gm-Gg: AY/fxX6Nr6bQFqJAVqOvL+0+A1cUWr573626qsijlfOuTI5Af6B2nuzt2tdejOQbHr2
	1nuFWxgqY6pGM2tF8euo511ruS2BRqmjNadorZUHcck+z8EDcWmXfAU1ijqpjdN8Xu1sdsq/ebm
	7qLhUjZJZhV+AAf0Wbf2sYT/ddhgTRSseVAUIA0pgrzy/+EGnjmS7MwIQszs4iwr5WcpxeQSK4I
	CKhp4qxzzIYn7os0fqt3LFxhjdY14pv62TtucO27PpYmqdWztzorQTGiExi4njb7mE9fKDGA+eO
	MFY9YX0zhSBBVfi0BwJgATpChFp9bqJwhk8CpX2qVdVa0PWN7wwRYq7ir0axUuyUNuHn
X-Received: by 2002:a05:690c:6609:b0:792:7828:b709 with SMTP id
 00721157ae682-793c66f4bd6mr24042237b3.22.1768574551609; Fri, 16 Jan 2026
 06:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107033924.3707495-1-quic_shuaz@quicinc.com>
 <CAMRc=Mce4KU_zWzbmM=gNzHi4XOGQWdA_MTPBRt15GfnSX5Crg@mail.gmail.com>
 <212ec89d-0acd-4759-a793-3f25a5fbe778@oss.qualcomm.com> <CAMRc=MdoUvcMrMga6nNYt8d-o8P-r3M_xY_JHznP3ffmZv8vkQ@mail.gmail.com>
 <96472b7c-9288-4f81-9673-d91376189a18@oss.qualcomm.com>
In-Reply-To: <96472b7c-9288-4f81-9673-d91376189a18@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 16 Jan 2026 09:42:20 -0500
X-Gm-Features: AZwV_QhPiDz6MueN4sUXp8m2kkBxLdWM5NMAxLszIhWWEfsuGtFDaz5gEkCX6YU
Message-ID: <CABBYNZ+5ry0FWFSgOskw60jja9mE6WG5AwOi2pKxrkzqMn9bkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix SSR unable to wake up bug
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Shuai Zhang <quic_shuaz@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Fri, Jan 16, 2026 at 4:48=E2=80=AFAM Shuai Zhang
<shuai.zhang@oss.qualcomm.com> wrote:
>
> Hi Luiz, Marcel
>
> On 1/16/2026 5:20 PM, Bartosz Golaszewski wrote:
> > On Fri, Jan 16, 2026 at 9:37=E2=80=AFAM Shuai Zhang
> > <shuai.zhang@oss.qualcomm.com> wrote:
> >> Hi Bartosz
> >>
> >> On 11/7/2025 11:37 PM, Bartosz Golaszewski wrote:
> >>> On Fri, 7 Nov 2025 04:39:22 +0100, Shuai Zhang <quic_shuaz@quicinc.co=
m> said:
> >>>> This patch series fixes delayed hw_error handling during SSR.
> >>>>
> >>>> Patch 1 adds a wakeup to ensure hw_error is processed promptly after=
 coredump collection.
> >>>> Patch 2 corrects the timeout unit from jiffies to ms.
> >>>>
> >>>> Changes v3:
> >>>> - patch2 add Fixes tag
> >>>> - Link to v2
> >>>>     https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@=
quicinc.com/
> >>>>
> >>>> Changes v2:
> >>>> - Split timeout conversion into a separate patch.
> >>>> - Clarified commit messages and added test case description.
> >>>> - Link to v1
> >>>>     https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@=
quicinc.com/
> >>>>
> >>>> Shuai Zhang (2):
> >>>>     Bluetooth: qca: Fix delayed hw_error handling due to missing wak=
eup
> >>>>       during SSR
> >>>>     Bluetooth: hci_qca: Convert timeout from jiffies to ms
> >>>>
> >>>>    drivers/bluetooth/hci_qca.c | 6 +++---
> >>>>    1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> --
> >>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>    Just a gentle ping. This patch series has been Acked but I haven=E2=
=80=99t
> >> seen it picked up by linux-next.
> >>
> >> Do you need anything else from me?
> > I don't pick up bluetooth patches, Luiz or Marcel do.
> >
> > Thanks,
> > Bartosz
>
> Could you please help clarify this?

There were no Fixes: or Cc: Stable in your changes to indicate they
need to be applied to the currently RC and stable trees, in which case
it will only be merged to next-next at a later stage.

If that is not correct then lets us know if that needs either a Fixes
or stable tag so I can send a pull request immediately.

>
> Thanks=EF=BC=8C
>
> Shuai
>


--=20
Luiz Augusto von Dentz

