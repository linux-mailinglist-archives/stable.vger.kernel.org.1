Return-Path: <stable+bounces-95826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33289DEC2B
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 19:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C586163BB7
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D46D1A08D7;
	Fri, 29 Nov 2024 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i410UNyd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A344D8DA
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732906068; cv=none; b=m9gZLPkLGTcPg6dx1qb0NM/a+tJZpvGcdWS5Gy4D3VrENhXiwDs01sPEohDQ4g2IzIZwuU5JQpn+o+THAXBOGCiG5iBdObSwNuUVVyOShI37kw9+PSO8kJfAmpc7g7kAbWz5R420MFxbHZKDjsfr8pack1OtcshK73QDfRphO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732906068; c=relaxed/simple;
	bh=yzFFrdXn8dr9euF4LM4kEvUL45wKK7RQ8v2pkms5H6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTKZGGynWA9DfenG9j6sO52gSP0f6ouoly7KvcInhnJOyfLg3unw1uds9zOdLiCH7YauF17j+akChWVhG+Z02qHhaaqQ4U/F/Oj73ozh5WcB+8VNW1Ma9J2Fzx+EeTY964yS/cBIoVpUbcHVp3eX06Me3s++H7/XSIHhgtRUBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i410UNyd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7251d20e7f2so2200551b3a.0
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 10:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732906066; x=1733510866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KcVxSp/SGlyLOWsY0V+J8c8oFuDtTzhTcOpyJE61Nhg=;
        b=i410UNydrQYb+gpW0UcVSk0E6iDpeHrNeLvqPwkQ7XC8MtBJFg8SprlJN61ONP2Njl
         JU0THHxj9Lai+9XTB52NpvylourApt6BM+PnpkfEHmWn5idXFQS3+hRBkdTtv9ieVsAA
         Jk8awmQfsq1yEXJVsNdk9dUoc2lk69dr6gKx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732906066; x=1733510866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcVxSp/SGlyLOWsY0V+J8c8oFuDtTzhTcOpyJE61Nhg=;
        b=FPes4LWPiLZxXEQA2DqKEx4Sn8jNqv2hWMWBItwAf2sELyKZuhgSEavdxeTIDAy5tr
         VnLT5ztynaSrIh1EXLVKUE38WhskIC+1b+aIRkuw0wvYzD/bh5IBEyCJEOQdaS01dNuU
         6fFLDu0O5n4TveYHLcKfff9TZPC+aHucvIjqWpDTSTHY635aZcnICJD0iLE4ovuWDxG8
         79N5spAXbq48pTWojaAhRu+H+SpZfEMZqF3IlJwJ1bdP6rPKY0UYqo0C0afeq40Al149
         gohZWvwYvxfCCTKe8E88GLGWzQBDnV4BkQv5Wqw1/7y5Jl2nOecjZ4L/ljLmWLPT2sEH
         ffdA==
X-Forwarded-Encrypted: i=1; AJvYcCUn6o5g0AJFySkf28JUfueRHRFMi3wvy/Nu7LJornpovuwManyaLodVzTbr/pbd1QMw3gIeB8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpn7yKLq2wfO2PszRTiyjpIljZMkbRf6WplZWEHLldjYSyJNv1
	17bH2XJ0rI2aIi36/CA0+pEH0Qs+l4E4yonx6DB2bDYQIrtOYIb7owjnr6xczCBEPMxeTQnupSw
	=
X-Gm-Gg: ASbGncsbS1G4h1y3GUq+wmN4MRQC+OLRIZFDUGInJnsG3xuxZGYS3++jPpETF138X9t
	xgg8IqOtVjhdABvW//bSokKUKqG35wOd+kv3eTQV2YQLGRJshnfgUJa+mkqKHS6x8YtztvU7Ve8
	5p1AufH6FLXcIn7cfZJQpNncBhZKZ4ehCIL72JkArNZqLNwh3qa0eb9Bs907SbP5yNonMnfjmLE
	mJ/xCYRG6xTzYDZDow14fA4Kzi4sXtjZBUpGNAcDN7sVpncjCn2hhj3TrTYeFvqSmebq6RkeKeq
	TMqR7/T9xSbcgmDb
X-Google-Smtp-Source: AGHT+IGtomojA9y2GMWngXHlMRVNVdWQkAHyx1/nsM6wMUjo4XEKJ8D8v65rzZU4v5NJOBrNwrXMrw==
X-Received: by 2002:a17:90b:2690:b0:2ea:7755:a0fa with SMTP id 98e67ed59e1d1-2ee08e9d433mr16750790a91.7.1732906065779;
        Fri, 29 Nov 2024 10:47:45 -0800 (PST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee58edd888sm1686926a91.25.2024.11.29.10.47.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 10:47:44 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fbc65f6c72so2019297a12.1
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 10:47:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTzqYIveDqR7VQQecnpxCUI4nDhcEmwyZQFLdZHRvVfSVkRPNi7RmcaXxTuDrQ9zXxenlUhFU=@vger.kernel.org
X-Received: by 2002:a17:90b:1fd0:b0:2ee:53b3:3f1c with SMTP id
 98e67ed59e1d1-2ee53b3416emr5720571a91.5.1732906063311; Fri, 29 Nov 2024
 10:47:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
 <20241127-uvc-fix-async-v2-2-510aab9570dd@chromium.org> <20241128222232.GF25731@pendragon.ideasonboard.com>
 <CANiDSCvyMbAffdyi7_TrA0tpjbHe3V_D_VkTKiW-fNDnwQfpGA@mail.gmail.com>
 <20241128223343.GH25731@pendragon.ideasonboard.com> <7eeab6bd-ce02-41a6-bcc1-7c2750ce0359@xs4all.nl>
 <CANiDSCseF3fsufMc-Ovoy-bQH85PqfKDM+zmfoisLw+Kq1biAw@mail.gmail.com>
 <20241129110640.GB4108@pendragon.ideasonboard.com> <CANiDSCvdjioy-OgC+dHde2zHAAbyfN2+MAY+YsLNdUSawjQFHw@mail.gmail.com>
 <e95b7d74-2c56-4f5a-a2f2-9c460d52fdb4@xs4all.nl> <CANiDSCvj4VVAcQOpR-u-BcnKA+2ifcuq_8ZML=BNOHT_55fBog@mail.gmail.com>
In-Reply-To: <CANiDSCvj4VVAcQOpR-u-BcnKA+2ifcuq_8ZML=BNOHT_55fBog@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 19:47:31 +0100
X-Gmail-Original-Message-ID: <CANiDSCvwzY3DJ+U3EyzA7TCQu2qMUL6L1eTmZYbM+_Tk6DsPaA@mail.gmail.com>
Message-ID: <CANiDSCvwzY3DJ+U3EyzA7TCQu2qMUL6L1eTmZYbM+_Tk6DsPaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Before we all go on a well deserved weekend, let me recap what we
know. If I did not get something correctly, let me know.

1) Well behaved devices do not allow to set or get an incomplete async
control. They will stall instead (ref: Figure 2-21 in UVC 1.5 )
2) Both Laurent and Ricardo consider that there is a big chance that
some camera modules do not implement this properly. (ref: years of
crying over broken module firmware :) )
3) ctrl->handle is designed to point to the fh that originated the
control. So the logic can decide if the originator needs to be
notified or not. (ref: uvc_ctrl_send_event() )
4) Right now we replace the originator in ctrl->handle for unfinished
async controls.  (ref:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_ctrl.c#n2050)

My interpretation is that:
A) We need to change 4). We shall not change the originator of
unfinished ctrl->handle.
B) Well behaved cameras do not need the patch "Do not set an async
control owned by another fh"
C) For badly behaved cameras, it is fine if we slightly break the
v4l2-compliance in corner cases, if we do not break any internal data
structure.


I will send a new version with my interpretation.

Thanks for a great discussion

