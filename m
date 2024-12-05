Return-Path: <stable+bounces-98775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A87AE9E5266
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689E0284A62
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9D01D9A51;
	Thu,  5 Dec 2024 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUS+sSwG"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539BA1D3566
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394856; cv=none; b=fzUIKafS5S+6MQx+IbVavZOwN0aWv5aYh72utp1BoyRsvTEIrakVuFybmVSZZtZaiwcfKBlPYaGh0eZQowP1ZmOEgwLfb3sYXsv/LCTLvJK4z4zBJcx+rAi9UdlLH0rVVDU5ndXiNhR6EBfIKoTAsvYpB2CZ/1efVGuGxjiqSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394856; c=relaxed/simple;
	bh=iNNSlUMKio6BMScmGlcjZKiFLz/tKqFuBlOe3QJsMHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1sVx6XsjQDarhiYVrozUNlSQQRPtTPdV+3aDRYFKWa72cimW0VzOm9dPkMEdH6O/vPj8NGWoWg4BXZAVlPR3tOiVA/vWATemHb0NTsPii23rx0xyu7FrMYU9UScVUuljFqehSC9lc4SUNiuCPeprur3hAzYiqEjPiNFrPpCYXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUS+sSwG; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53e21c808cbso3814e87.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 02:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733394852; x=1733999652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAX9OZc5fi5Jorm88cMfQH8I9F+YyQu+8r7M5mFyRn4=;
        b=sUS+sSwGxt6DK9/VthAUdRIRcr5p0dID1Kqe3VoCWyeAtkYQb3j4FkoA+nLx83zWJj
         mSkOl0gUKKsjE1EK6z28MS4Sm9IS3hWyGC5OvKhBFUle5mzUNZhK4Npy4lisqJUiiN9R
         lfkY7BirXtyJaxkoWZHwsLHaObtUFh48XgRCo+veHPr+zna239nbCjZZIreUKefL7hid
         YsTBXmDoHSmcFf2Tgc+/mxJEiZwELPVb10IxXRP+PtTtMGRZcyXnV2T9UqUbHWfiUMAw
         sBaaJHMcTHisVDi3A0vlhn6PzR7Uoapwp4qIZIgIW+Zr+iJcm7TMtn5HCYhA3tZowP77
         6FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394852; x=1733999652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAX9OZc5fi5Jorm88cMfQH8I9F+YyQu+8r7M5mFyRn4=;
        b=VXjWrr4D0H0Z4bWaMnSvkPUR/loDRV1E8+6ZjJv1TRu/U0iWxQiASZn83bjbsCj3vt
         YpVhaf9KJoCiJjNHpgSugkOiEqNjihrZVY9DAxmG12roxgPtqIl2O8dJLvJzxnT4WoaF
         egLcwA3TBuLTR1SJXiWFh0HDPx3Gbv2vX32UonzB+jwUcYVdgLU/x3ePJy1LQrwxvc1D
         P8uD9C81sUQHghNSioULDZvCfO5METZUQ9lr6Dg72uXEca6ms8/lnpUU40KSOKtHyQGF
         s6g0+SJClf9Vpthe5MiWsMNgDV3UfqckjySihGpG3EbQJQkG4cD4bdZGQus7WSOayO/v
         X32Q==
X-Forwarded-Encrypted: i=1; AJvYcCVK2B3iq+0EUId/LfFyijxbLpfQ8GXRD2UxhBzXPO6FqOEXPxTZggkrPonBjaKHrzL9IBE6NRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnO6n31V/shiWYgcilSWQrpU6NU2s7JueBmRhaxdQh33oLh32q
	42vDzWuBi2TL/CB3/DJj6lsP0Lm2MgwyEcBLMu2mgISltBaqdsRSA6BdixJ91QyGwf4W8W2IpI5
	+eNSRPAPIUWxLYH/fgrVAfIEx+aE0FXlrpAeP
X-Gm-Gg: ASbGncs50BvlOkjMMLWQe+9/ovc//AYByKo/IalK96Bv/f+KxlCGHzVd2wq4g37R896
	QzWOSBA7HbxF3Jo0B+YVQUDzSNfQ94Cg=
X-Google-Smtp-Source: AGHT+IGt+5aP+iEfQ8woydcbNlVOoacxjPcRs4/5HKPXiqt0zdaJFDxLUiU7UR5wV85tYrUBnM1Yy3zidsxa1C+Swd8=
X-Received: by 2002:a05:6512:32d5:b0:53d:d8a5:2833 with SMTP id
 2adb3069b0e04-53e229c0d64mr130211e87.3.1733394851665; Thu, 05 Dec 2024
 02:34:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205010919.1419288-1-tweek@google.com> <6e526f37-960a-4db0-bd17-4dab7803ca68@googlemail.com>
In-Reply-To: <6e526f37-960a-4db0-bd17-4dab7803ca68@googlemail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 5 Dec 2024 21:33:54 +1100
Message-ID: <CA+zpnLezpYaagkF=WxoVFXRWhcRMSMD2JP6_G==HErp0LuE_uw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: ignore unknown extended permissions
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:42=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Dec 5, 2024 02:09:39 Thi=C3=A9baud Weksteen <tweek@google.com>:
>
> > When evaluating extended permissions, ignore unknown permissions instea=
d
> > of calling BUG(). This commit ensures that future permissions can be
> > added without interfering with older kernels.
> >
> > Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

> > -       BUG();
> > +       pr_warn_once(
> > +           "SELinux: unknown extended permission (%u) will be ignored\=
n",
> > +           node->datum.u.xperms->specified);
> > +       return;
> >     }
>
> What about instead of logging once per boot at access decision time loggi=
ng once per policyload at parse time, like suggested for patch https://patc=
hwork.kernel.org/project/selinux/patch/20241115133619.114393-11-cgoettsche@=
seltendoof.de/ ?
>

I agree, warning when the policy is loaded makes more sense. For this
particular bug, I am trying to keep the patch to a bare minimum as I
intend to backport it to stable kernels (on Android, this is
preventing us from deploying a policy compatible with both older and
newer kernels). Maybe we could land the first version of this patch
(without any warning message), with the understanding that your patch
will land soon after?

