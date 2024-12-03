Return-Path: <stable+bounces-96296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE59E1BCE
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00AEBB3F10D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE0C1E47B8;
	Tue,  3 Dec 2024 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mygRsT0g"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F9A1DA0F5
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226645; cv=none; b=q5Ht+cjiNf219eAaz3XDOaNjHLbvDoP1V7eSyz4nd3kHwjPoh6LLYHADrvEoex4whB+4acUWXP39aoZsfIf5f+kqebporWz86A9ihpEUqKe0KEz7e5CdShh0bZbXWofJACYxD4ghEH1hyUzXN0VARBHXW9CW960Fpu7qHGUWZvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226645; c=relaxed/simple;
	bh=VmRVHJ89hHaC702KNj5DVwjGknfJqcSrEMUZ3plgFAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+mx1HO3fggjcyLO48gvQk9j61swegVHGRDF3f5KnClJuLDdrCgICyUO4ia0SIwG3cMBCT/us/y81xpwqqnWb7xmz0WEa/Oxpf+Mp18x8oz7c73uUqFkB+BQU7C9ViekfT/a9M8UcYsPqt5BjizrA2FdCAwYiNUrYXe9WrjmZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mygRsT0g; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e396c98af45so4830899276.1
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 03:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733226643; x=1733831443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFlYiwHjDzAWalA/ssIPWrafHRu3dey++ZE5NO1gWmM=;
        b=mygRsT0gAYQ65F7Nq4GW4iAoPj6H7u+hmFZlJbJmbd6Jr1azQSUP0Ey5E/w0b8wF1o
         ISzUu0xGHVbt/RjudldUIzaW1VXlPPOpgHE0xmQg0ICWKZ/FQ1Hsu8Xdba4SUi0oXPHH
         Dy6UDOV6yURIxFu4urEyVnvA1d/6H9GbekoB+27jEtJmKnX/Bdaztbx16jQAc/RxpwSk
         kqBSIVyg0Mw48Pjf9Db2yEGYrYimWRBOvW4+TUFKEpbIcXHpV8PYjNiYdbjDHB+KXmbo
         Dfsdlp/PAesrcOYnV2RBV4JVjWURpWxyQWq+mOgdxF0gn8W5c9Lf28YnOfl6p7+erzNg
         slQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733226643; x=1733831443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFlYiwHjDzAWalA/ssIPWrafHRu3dey++ZE5NO1gWmM=;
        b=n7OPnF869/l7nrJYy2UJ5Po/zTAKOZFQzfMn9nAf0EBDFwt2ZAxbbbARwGq//RIxhs
         baOIJQv9tEzy17rfo3gMqKYc25wkXglIbPwe9FEIvAmmEmw6n9FkiBP5ZJA4fE5SLs2z
         47V9QBVOjTMWnelmE+xto1ynrR2dOOPPmCpFPlirBHxtXAd9+EcaXIKZST8M3G4p3/nm
         FFP13axjWP9iC4x9cL6mjJWPSDwwxU3InqyS9MQuGotc7BdHIPwgnifd8Sp8CeFlX/8q
         CCXkodBx6S6qZQJwrJclKxZWEvnTP8uua8PZ5BryvFV3d3EgnBthEJsAOfCw2Xe7pIZG
         QipQ==
X-Forwarded-Encrypted: i=1; AJvYcCU26NnDVy/2htWvBQwcsB/hex7+fdLiMMOXfgqyVFW7B+RQj47JI7PU0GzwF5repxWlVhihn7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHDcd1yHnXo2uyZPHOGZCG3r2zPwAEaVRp6W3NJUMHT0kDvkvL
	7ciOSgVbMp0nTWcgAgc/Mb5WsLkNYtVojwcXwSknhh+ZCf/YNcihdobVYSeem73fArYO/v9pNV2
	+RomMFEZgSfflF/ZceIL01Z9FPzjtec9BDqi/Vg==
X-Gm-Gg: ASbGncsE6/ehJJuRFmyImQzqWsiMFZv9rjwqi6RT0UbW6v6Z/sDYxEAYvLW3EKRTuXb
	v5jBZQ8o81Y0F3bViuFblFajJOSDo8Q==
X-Google-Smtp-Source: AGHT+IFyTnURgL93B+5dKdQPXnHOV8tQW0IsxTMXNH0c/0ZmEOV3U3JgbfPlCK64NvS19G7Z6OStEBzOxJ2NzXELGWo=
X-Received: by 2002:a05:6902:f89:b0:e30:e39b:9d72 with SMTP id
 3f1490d57ef6-e39d3a2a894mr2330987276.16.1733226643017; Tue, 03 Dec 2024
 03:50:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203102318.3386345-1-ukaszb@chromium.org>
In-Reply-To: <20241203102318.3386345-1-ukaszb@chromium.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 3 Dec 2024 13:50:34 +0200
Message-ID: <CAA8EJpqnOm0y5T+jAZJGL4FLzUz+jp+_ieaOC4j3av+tHaoJ_Q@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: ucsi: Fix completion notifications
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Dec 2024 at 12:23, =C5=81ukasz Bartosik <ukaszb@chromium.org> wro=
te:
>
> OPM                         PPM                         LPM
>  |        1.send cmd         |                           |
>  |-------------------------->|                           |
>  |                           |--                         |
>  |                           |  | 2.set busy bit in CCI  |
>  |                           |<-                         |
>  |      3.notify the OPM     |                           |
>  |<--------------------------|                           |
>  |                           | 4.send cmd to be executed |
>  |                           |-------------------------->|
>  |                           |                           |
>  |                           |      5.cmd completed      |
>  |                           |<--------------------------|
>  |                           |                           |
>  |                           |--                         |
>  |                           |  | 6.set cmd completed    |
>  |                           |<-       bit in CCI        |
>  |                           |                           |
>  |     7.notify the OPM      |                           |
>  |<--------------------------|                           |
>  |                           |                           |
>  |   8.handle notification   |                           |
>  |   from point 3, read CCI  |                           |
>  |<--------------------------|                           |
>  |                           |                           |
>
> When the PPM receives command from the OPM (p.1) it sets the busy bit
> in the CCI (p.2), sends notification to the OPM (p.3) and forwards the
> command to be executed by the LPM (p.4). When the PPM receives command
> completion from the LPM (p.5) it sets command completion bit in the CCI
> (p.6) and sends notification to the OPM (p.7). If command execution by
> the LPM is fast enough then when the OPM starts handling the notification
> from p.3 in p.8 and reads the CCI value it will see command completion bi=
t
> set and will call complete(). Then complete() might be called again when
> the OPM handles notification from p.7.
>
> This fix replaces test_bit() with test_and_clear_bit()
> in ucsi_notify_common() in order to call complete() only
> once per request.
>
> This fix also reinitializes completion variable in
> ucsi_sync_control_common() before a command is sent.

Thank you!

>
> Fixes: 584e8df58942 ("usb: typec: ucsi: extract common code for command h=
andling")
> Cc: stable@vger.kernel.org
> Signed-off-by: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> ---

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

--=20
With best wishes
Dmitry

