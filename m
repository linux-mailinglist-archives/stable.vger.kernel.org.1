Return-Path: <stable+bounces-11842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF4783050E
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 13:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C831F259F3
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 12:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A7D1DFE4;
	Wed, 17 Jan 2024 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ndoVtZu2"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F1D1EA71
	for <stable@vger.kernel.org>; Wed, 17 Jan 2024 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493874; cv=none; b=jGGU8w76+GtGOo2+SXfPRbYMnfPbPks8dl17qSQaL88TBiesXlLKSA1av4B2DDgBEc1ogY+S8KNucQfW4LPyunSDRHZwVLDabpY7szGuLkKKkhQvXFU+hFGl2SVI5DJLBCIYuY1m9CHSdQy2VVZYf7HuvIaBLPQHYhIFoP66mlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493874; c=relaxed/simple;
	bh=OFihm6yOSdyrIX3TVPPEgVNi0cjH0fyFN/STG0Fxcuo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=POXhbhFpg+qBYPa4zNm3eAsfXXJE1YMszHwmH71ox523PlCpMpmfzkgpsNI3Rt7GFy9lhooHH8uL8sV3o4VC+YxTQXrqttlKcDJNPJ1Q/X00r9F3BHmxpvPOsZJ7sQ4n3WWTQAn7/HqHpXH0DnS7RKNL+rUQBVpM1RUM3Tscq28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ndoVtZu2; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5edfcba97e3so115811717b3.2
        for <stable@vger.kernel.org>; Wed, 17 Jan 2024 04:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705493872; x=1706098672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tqn31a8Q43TcX43OmGCB3MQCcwEGW2dYHZPltYe4F0o=;
        b=ndoVtZu2kFu0MEO1J/zCXgpPJ6zKpbg5yHfQF+FM0aTdLs4Y1r5W4enpH6RzYR/dWw
         LpyA/b8ryl/qPxAshlv7LgYALNCg5sBzAaA8sM5Y3/dd1XX7X26jhf0xnnMKlxdSWYxM
         uad68sFf/xkB+o+LnncFagHMVW5NU/LAsuQS33RO90uIxeweKKil5lY/dY+LAFlsYebm
         nOw97WJ7v+W28SlxRsrZEGkS0Y0unz6bmUl27SmMrr9gCMrtU1ZftGqu50fzwNR9qasf
         3Z1NVG8XYMCF7pVd2+Z1BISmqztOFg3ZFWqrF8huinxQJrE/XbOVCIohh42o3g8IEfsu
         Muyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705493872; x=1706098672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqn31a8Q43TcX43OmGCB3MQCcwEGW2dYHZPltYe4F0o=;
        b=ACcp6OQID2U61TPwto2drzJe916RAFNMpAEjg0mzaLYlTlZmWX5wTX9lHTb9QMqoSm
         J/qh/KlFfSZ4DUASrbDn6eKgS3ifL/e3t+CuntVayIeVsyj/qJD1frCh8qXn1G+N7l0g
         /JPEKa7FRSnXTDedbZ22dEvr++7w72MOh3rEwJE5BUOI188WHGJs4LqkPdkZz54vguSB
         91pHO4cwtsPOr5ffe3bTuQ8sPiMDq9AaPWHnFPINQE9h4cA5bWYTeomqxspsAT/DOPNE
         M06sutdtXAA3f47H5/7+vE6Ows7r8sN5408h26QSMlpyEa7FzBvbvExomop8WXgwZbD+
         mkUQ==
X-Gm-Message-State: AOJu0YzXDvACjt4uy24wpZwom+JnXGCiDZwL0BwaL/jhTgymQUt1TpfY
	L2Ttkb7ummQFgoXZJPMDhHdK6zDXFaz2QewA76Lqp9QHoCOKZQ==
X-Google-Smtp-Source: AGHT+IGw/fXZv725zSW8uXVwy6JkTDYuc3XQeWu50ewepPBAUHHJ59De9Mw105ifwTwf0eNnDx1V1J/0oNjB1rT41eg=
X-Received: by 2002:a81:b656:0:b0:5ff:64d6:ee49 with SMTP id
 h22-20020a81b656000000b005ff64d6ee49mr833182ywk.64.1705493871659; Wed, 17 Jan
 2024 04:17:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116194225.250921-1-sashal@kernel.org> <20240116194225.250921-44-sashal@kernel.org>
 <ZaeJ8Sh4JLo5GAQw@hovoldconsulting.com>
In-Reply-To: <ZaeJ8Sh4JLo5GAQw@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Jan 2024 14:17:40 +0200
Message-ID: <CAA8EJpoQZc0f2HusJOMa_45bh8Eh=sVg-aOUbNR3S0+oQQQ+MQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.7 044/108] usb: typec: ucsi: fix UCSI on buggy
 Qualcomm devices
To: Johan Hovold <johan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, fabrice.gasnier@foss.st.com, 
	quic_jackp@quicinc.com, saranya.gopal@intel.com, quic_linyyuan@quicinc.com, 
	andriy.shevchenko@linux.intel.com, minhuadotchen@gmail.com, 
	johan+linaro@kernel.org, robh@kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 10:03, Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Jan 16, 2024 at 02:39:10PM -0500, Sasha Levin wrote:
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > [ Upstream commit 1d103d6af241dbfc7e11eb9a46dff65db257a37f ]
> >
> > On sevral Qualcomm platforms (SC8180X, SM8350, SC8280XP) a call to
> > UCSI_GET_PDOS for non-PD partners will cause a firmware crash with no
> > easy way to recover from it. Since we have no easy way to determine
> > whether the partner really has PD support, shortcut UCSI_GET_PDOS on
> > such platforms. This allows us to enable UCSI support on such devices.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Link: https://lore.kernel.org/r/20231025115620.905538-2-dmitry.baryshkov@linaro.org
> > Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> Correct me if I'm wrong Dmitry, but while the commit message makes this
> sound like a fix, it is not needed unless you backport follow-on patches
> that enable UCSI on these platforms.
>
> So this one can be dropped from all stable queues (unless you're
> backporting patches that enable new features and that depend on this
> one).

Exactly. It didn't have the Fixes: tag. So I'm completely unsure why
it ended up in the autosel queue at all.

-- 
With best wishes
Dmitry

