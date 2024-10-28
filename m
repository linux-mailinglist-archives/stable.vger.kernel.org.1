Return-Path: <stable+bounces-89059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61629B2EF0
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79541C219C7
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D2D1D3648;
	Mon, 28 Oct 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="NjXd1y07"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716254765
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115152; cv=none; b=sSWdMm8njuRdawRC95z0ZxJUlmDIDsSnuP9b6mxTcJhIo/s9AI5wpTZmMhOa99SOc0bT2xndfbUZ4+ilOIYcx0KOQHRxlPtsKJVRsqAOQyLoaNVqtbFRBlNsxyOITWWN3oyTJLKRQb1v5/ytL15nIJqHAj6Amz497/BFILtlr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115152; c=relaxed/simple;
	bh=L2bXbq3PIxh7Zm3SHa0cpC0fOa4pqViT0QVnHxOBQcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHkVNXm4Da734u7fACBelWfAfuuHuMRnh6BKAtIXsdfTJRaFS/VgBQOfgLTRneZQffSrZB74R4+oSoOYybw/8KZV4ikYv4CZwG3pV+Y6MwB+0nLHBHeplv11YKDHJ+Ertr1aO532TmttSzIxAyE9J5OwYnew2tJuHxwCOCamxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=NjXd1y07; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7180dc76075so2095036a34.3
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 04:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1730115150; x=1730719950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/DR918lxz2xV2iocC5zSbeuPsDzY0FXd6yi6ZYmadw=;
        b=NjXd1y07Cq4ceq1+fYrsKgbDb3MQStdhHRp5NOrf5w+BEqzjZXYOjqfr+xkZwTf3vC
         6raSWOuLvY2e07JLK/KNYCIrURO+hg4cH3PgRL03N5c1QBEZPvMnJoFYd+dJTXSIQzJd
         NEtKw30TKH1k+tWA1f2m3xt182s0TB2mwiJFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730115150; x=1730719950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/DR918lxz2xV2iocC5zSbeuPsDzY0FXd6yi6ZYmadw=;
        b=KZu9Q8EHUfXsvvmVaSmPwP8V+HvBVj5srSo5rimK43aCAnM1/5jHEY+KafZpvrEaKO
         S2JBdn/PZTWxV7sp5HVx69Dyk4XIFDLM6eTsiHwjiV6l/rcwFS5eaauYKxikCXUK3eN3
         yaDI1745PrfEkIECbbmZ7vCWX1Aphd49xRYiV4iMJ4WeSStAidsrrMp32ww09AkdEEZC
         CYkwmb/hsNxe75dFDM08062kN+YhpFgvgsxqaNNFDF6ZDOKML+MotOzGUQRifUCYjeDG
         0O/LgoqR0Ps9jcgzPpMUMuLHKl4/2bf1a5Z/siKiFZWt38cz/NLahraaBwpvL12ZaIwi
         4GYw==
X-Gm-Message-State: AOJu0Yyz3JJhgQ6Dhq9V2CIoXJcH6lG36es7I9cUKtQUzG84zOrL0Qg2
	pfE86f6F/85wTxKUdkK/kNOHOvOCSP7CVgZHaavxEtJEeknToEQS7yV/20gxh+eikqnmZliBIrc
	vwIbAgPrkZ/klHAslYnH3uJW2yQCnXWNoPpIAiQ==
X-Google-Smtp-Source: AGHT+IFjImVBhmJ8dxS5xkN0jdCuK5nMHGWj0G72Dd2XGbFptWIit1vsNfbMq6ubR0LUFbnUWGrNiUL1xyvI3FLAcTM=
X-Received: by 2002:a05:6870:e0cb:b0:288:5f71:4e71 with SMTP id
 586e51a60fabf-29051db63ffmr5822247fac.44.1730115149780; Mon, 28 Oct 2024
 04:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1729316200-15234-1-git-send-email-hgohil@mvista.com> <2024102147-paralyses-roast-0cec@gregkh>
In-Reply-To: <2024102147-paralyses-roast-0cec@gregkh>
From: Hardik Gohil <hgohil@mvista.com>
Date: Mon, 28 Oct 2024 17:02:19 +0530
Message-ID: <CAH+zgeFzURTdg5n9kxXb-yMcAqC1rp6Y8t426YeG19YwWayXfg@mail.gmail.com>
Subject: Re: [PATCH v5.10.277] wifi: mac80211: Avoid address calculations via
 out of bounds array indexing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, 
	Kenton Groombridge <concord@gentoo.org>, Kees Cook <kees@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>, Xiangyu Chen <xiangyu.chen@windriver.com>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 3:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sat, Oct 19, 2024 at 11:06:40AM +0530, Hardik Gohil wrote:
> > From: Kenton Groombridge <concord@gentoo.org>
> >
> > [ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]
>
> We can't take patches for 5.10 that are not already in 5.15.  Please fix
> up and resend for ALL relevent trees.
>
> thanks,
>
> greg k-h

I have just confirmed those are applicable to v5.15 and v5.10.

Request to add those patches.

