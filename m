Return-Path: <stable+bounces-152440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D89AD5A52
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 17:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC44189B87B
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC2B1CBA18;
	Wed, 11 Jun 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="An9ldRSC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132041AC458
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654849; cv=none; b=IK6it+bxi/rSLOcVvCEMXBXGkM0bxvtrzCcCZnbkwhfjZy16/8jx7USK14YPlUY7AKMrmFpGTpjyD5/D5GS9zkCZw7yQMpctn2Wdl1Pq91cCQ/yapSXPCMHAEe2Esiv9tOWjVqe1n33kWHBSa62r1hqfkVKiU47QoMo+mPzzkyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654849; c=relaxed/simple;
	bh=xXF1fKQYQwjTZw8iXbTlsihrAwKe/UiVkJhwQdslq/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blI908fBuWrcDF5q+lom0zVuZxAgJFd8sWhR6Y+X1lTKruhuCN8rM5g605eJNvb0R8K3WXfSaEw/ONPuoFktkuM70SwcJ2VNhWDDcRnRcFGicaf0+Aas55nzhSI6qq1xFePxmLEEEhT6PIiZhVbzSpDQJQNc5yk8n0wQ5exaOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=An9ldRSC; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so7670055e87.1
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1749654846; x=1750259646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXF1fKQYQwjTZw8iXbTlsihrAwKe/UiVkJhwQdslq/U=;
        b=An9ldRSCdLRkipqgVv/skcPgiURxe11hGCS7E3tbTBbNHTK8cdAtHj8cDJjaXDYzfB
         gd2yjyERbvy1MJPwo6HigNPfk1bcebLu5gjtwxn7MPvqbbTYmeCRPiYx59miRTYOVCHw
         acDl5JX45HU2QvV+zF0Ob6sq5I1odFhCNvzhKFsuzl7SziC13LtY7y3ZnAN+/v6aOzXO
         mYJWq0HrchckMgeczwD/LFcsVfouB5FECagEbxRMUcCZWTa0uufCWhMMW1AW1UD3wbAQ
         ZvX32eH+wz7XO7IdPZck6hpDYcg8MbOf4N9LhWhUC1PEceIaS6YaxheylvzgpEpZLDcz
         pKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654846; x=1750259646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXF1fKQYQwjTZw8iXbTlsihrAwKe/UiVkJhwQdslq/U=;
        b=K6oOncPgu6zUcFdhoMTHCr4CAS0aaig0jRyjRPfPLIAHfqYkc4NaGjwYbxsaMfff4I
         EZ9wh01yJ0+dBxlOouhcHx8bF6GMQijDJk9IwHnvUuPu4xOW2JUtdHoHeHhaq2+4ebGP
         oyAtGL8qTL0irLsK/n8F7+XDi78zIt4F9HUMzLURMctFxngBhUKyX7ejQq+38fWBZsEe
         t8btgTljysQOjHm8MYqoLzmc9aPpGbTlc2WjRyMY3ZM7AJTq0Kl1Wp3FP0k4oDEq6Mjo
         nc0jtPqUiEwxCUVp35jaMKJV4o6BJM6+yiYC+JlgoU0Dm95BxJltAuflW4HHq6Vj2WJL
         624w==
X-Forwarded-Encrypted: i=1; AJvYcCUqm6nRgLDbmRNeR8FKyPEipQOCKwDCXwgIGSnWUdTPoSXyVQxG275e5iag/CGRrb4s1nyCt6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxi1Lkgus07b0tdttSWeeOwAmd+CLn947TWWOOiXnsg/57PBX/
	4GxWee0IRrdARTbOcuPvkSXhhfqUe2TAMGDuMG+ihg/68Wj5OjDRcMP7lnrCESoQJ1LXnZVXRtE
	mb5gaX/+QBS/uQ5XPnro4DPp0wVuuSH8D35OCsdHCGA==
X-Gm-Gg: ASbGncuzJCQccZRQ9wFG5uHPN5L0YcaiJAV7c26CfHnJyutJGKimU5Lo/9hTpkEqjZp
	A9C7TxnqOYuHp+dHSBH86XQpI1lkdQz2q70oUGHlf+08vGmJ8b5WFS5vr//alwAppMPVMs0TIUE
	oQPjPv/IfxCxcPnsQnKLBLcBA1QRHZ6KbcOj66+PI8MFdYR1SL7inZGp5Si8/znlvWCMrn65VP4
	nw=
X-Google-Smtp-Source: AGHT+IGw+q2yvYWpmAIUWy0VGe58eE1SrQ78oJJGrnBnU83UjI38DO9zFzggcPEe+DrUAq6iTBI5SWIZkHBiPk9ESOc=
X-Received: by 2002:a05:6512:2355:b0:553:3178:2928 with SMTP id
 2adb3069b0e04-5539c0e243emr1434831e87.16.1749654846050; Wed, 11 Jun 2025
 08:14:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611143911.48501-1-brgl@bgdev.pl> <3i6ni6jfq7vzij5cj4h35sy4ceegeekuv3lr5b3nmyqtheky6q@mlrspoyavfwt>
In-Reply-To: <3i6ni6jfq7vzij5cj4h35sy4ceegeekuv3lr5b3nmyqtheky6q@mlrspoyavfwt>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 11 Jun 2025 17:13:54 +0200
X-Gm-Features: AX0GCFtymhBATZElPAXX9UTuzF3eRZfHttarjFE9PeI16lNBM-F_-vPrq_rdhb8
Message-ID: <CAMRc=McF+eRfdo73Z_WHj75vOJcc3=yvd2QbVFwGNp7OOYyHHw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: msm: mark certain pins as invalid for interrupts
To: Bjorn Andersson <andersson@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 5:03=E2=80=AFPM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Wed, Jun 11, 2025 at 04:39:11PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > When requesting pins whose intr_detection_width setting is not 1 or 2
> > for interrupts (for example by running `gpiomon -c 0 113` on RB2), we'l=
l
> > hit a BUG() in msm_gpio_irq_set_type(). Potentially crashing the kernel
> > due to an invalid request from user-space is not optimal, so let's go
> > through the pins and mark those that would fail the check as invalid fo=
r
> > the irq chip as we should not even register them as available irqs.
> >
>
> I had to go dig into the code to understand why there is a problem with
> GPIO 113 on RB2 (i.e. UFS_RESET on SM6115)... I think it would have been
> better to document the actual reason for the problem, which is:
>
> "The UFS_RESET pin doesn't have interrupt logic, but is registered as a
> GPIO. Requesting the interrupt of this pin hits a BUG() in
> msm_gpio_irq_set_type() because intr_detection_width is invalid"

The UFS_RESET() case is the one I figured out initially but then
realized that the issue will be the same for other non-PINGROUP()
macros which set all the interrupt related fields to -1 so I made the
message more generic. I will include the above in v2.

Bart

