Return-Path: <stable+bounces-119502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD56A43FF4
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF3427A77F7
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C68268C4A;
	Tue, 25 Feb 2025 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9VUX23F"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D11DB365;
	Tue, 25 Feb 2025 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488560; cv=none; b=JsWjg076yFSG+/yNp90DNOa1cT5xBdWzuMSv7fIcLkWUYhoReOmJvguBhONaVuxLsyt8LR1hccsi4IXIS7QwocWGdUAxgOTztNXz/m03arvu8LSEdTLH7y36GkMoelVNzbvmO6Htc+LOhltWLvk8RN/ODmIVcsfKlpgPG4OILdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488560; c=relaxed/simple;
	bh=GfBv0+2Ig6Q/5M8ohpa5wt34MrwK4ksWEyDMsdwY+ag=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BYL1NTLskWTira3v6n6bxIxEKWhtNvzj9vbvEHU4igKoNagKDlPs/djF8BAETiIiWAgmzWYqj6f3fXz5xv3OUyYJUpYP5PPshsA5HIBhW464cpbA2nkUTKvM6AjApIvnNtfFc2cjvtJJL3LpD27z+z4/z/Qc2dlS9s3uY9GnigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9VUX23F; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so9723765a12.0;
        Tue, 25 Feb 2025 05:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740488557; x=1741093357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GfBv0+2Ig6Q/5M8ohpa5wt34MrwK4ksWEyDMsdwY+ag=;
        b=W9VUX23Fj7pgwzBb20q5dEs1eaa+6P4komvm0zjJVnh/yV1DRyjgGOT53Odu/8RGj3
         lmgbvG0zdUoTPhij8MxcibrpgVH3kfo4IIrthXJZW+LMXITuCIVQd5q8o659dJJO4pAA
         /gKVWu+X79sPX3VMpuJb7Of5e5mxRUh7necwDNpvq7pwxDZyKJstwGoqit0nsaqr4RW9
         glNvjhilj7hqiQwefx1LYqpFIfFno4f3T8wzYD5pl26Yagkx7+7PHxSAjByYDcvMxUsH
         zUIBFQRVfOLynLEHW8eBqk4eWnXHtdXwO4vUPuGlKHjRdHXHc9eF8n8mrgpfc/SK/yK+
         ridw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740488557; x=1741093357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfBv0+2Ig6Q/5M8ohpa5wt34MrwK4ksWEyDMsdwY+ag=;
        b=dKN25JmjlQneVQw03JFY8h7RbVTcoUeqYcIveR4HyUEOm7vbn9My14ucKPmHjU+bfW
         bmMtaaprzwZS/xgofJIYixoifDpXwvhYuVfMSw2hQisI90xalWcjftRrFgpja4ZF+Umq
         xdF5QVQhe1/k35bEzkjKlcRTwbtkAxiprezeiIjC05aHFiK8tNjMqIUOj7wanAmm4O/v
         rPfi+KQqk/PlhC4nJyNCGL2PxD6n6LgDDct0JaoOX67Z+c97tvRHUVmNF1+VBTLsaWFg
         eB634M5if+i9w6W5ABZ70rhHwjAsb6IWTjkrthAMLMX9I2URM+b4PPXoRos+cVG9Wl4s
         NlRw==
X-Forwarded-Encrypted: i=1; AJvYcCUFiMf2WUfcJBDbSu/CRi1InBE656zlTC7hv84MRUJjMU6Kljt4LNZpCiwUKg0qYHkT/kuyhk3+@vger.kernel.org, AJvYcCVq5XBOznafgt/Nf133k/WvK06p3skkxMKlGqt0zvF0V5mX+iVykGL1gvElh9ug4y2vnC7zgkqUD8qn4A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeSzw3XTDwP13LjrIR39OnafhTRYUcFhO4f093fP2DX4ecoxia
	HyhxatDzAfUSdhUva/DRWCTnz0agKnlIid9kWN+r4Mhcdty5hy/nRaWuLQeeIDvISRpqqL11sbI
	FBFBpKGoPEen1Ec683IMSBehewWtKX/5Xa5zSkA==
X-Gm-Gg: ASbGnctO/N/OfbGP0GScxWdBzT23NjwVS+6DrgOtDAWUjz6tdLBcVJSwcum4SBMzZgn
	4B1nbnUaFn+cdvhPM+3wBCz3tkwFyQ5TyG+1KDWFFGnSpnK36IxVYE3/hYjLPi+NYT9WF9ysd0B
	aHjLQAeg==
X-Google-Smtp-Source: AGHT+IGKsZfJvxcjb7PkMuNRzzrsgmgOoQbOBOqi+Lpi6M86G4RV2k2x4pLduAa2f8R0g20kTsF2wgHa4BPUgRCp4Kc=
X-Received: by 2002:a05:6402:358f:b0:5de:5cb3:e82a with SMTP id
 4fb4d7f45d1cf-5e0a1116e25mr23027748a12.0.1740488556516; Tue, 25 Feb 2025
 05:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Tue, 25 Feb 2025 21:02:00 +0800
X-Gm-Features: AWEUYZlvHmVokT8MMhqWrzdI6JeU7QSjxyre4OI-nzDa3gkCtbDXRBtbozQqtC4
Message-ID: <CAOPYjvaOBke7QVqAwbxOGyuVVb2hQGi3t-yiN7P=4sK-Mt-+Dg@mail.gmail.com>
Subject: [BUG] r8188eu: Potential deadlocks in rtw_wx_set_wap/essid functions
To: Larry.Finger@lwfinger.net, phil@philpotter.co.uk, paskripkin@gmail.com, 
	Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>, 
	baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello maintainers,

I would like to report a potential lock ordering issue in the r8188eu
driver. This may lead to deadlocks under certain conditions.

The functions rtw_wx_set_wap() and rtw_wx_set_essid() acquire locks in
an order that contradicts the established locking hierarchy observed
in other parts of the driver:

1. They first take &pmlmepriv->scanned_queue.lock
2. Then call rtw_set_802_11_infrastructure_mode() which takes &pmlmepriv->l=
ock

This is inverted compared to the common pattern seen in functions like
rtw_joinbss_event_prehandle(), rtw_createbss_cmd_callback(), and
others, which typically:

1. Take &pmlmepriv->lock first
2. Then take &pmlmepriv->scanned_queue.lock

This lock inversion creates a potential deadlock scenario when these
code paths execute concurrently.

Moreover, the call chain: rtw_wx_set_* ->
rtw_set_802_11_infrastructure_mode() -> rtw_free_assoc_resources()
could lead to recursive acquisition of &pmlmepriv->scanned_queue.lock,
potentially causing self-deadlock even without concurrency.

This issue exists in longterm kernels containing the r8188eu driver:

5.4.y (until 5.4.290)
5.10.y (until 5.10.234)
5.15.y (until 5.15.178)
6.1.y (until 6.1.129)

The r8188eu driver has been removed from upstream, but older
maintained versions (5.4.x=E2=80=936.1.x) still include this driver and are
affected.

This issue was identified through static analysis. While I've verified
the locking patterns through code review, I'm not sufficiently
familiar with the driver's internals to propose a safe fix.

Thank you for your attention to this matter.

Best regards,
Gui-Dong Han

