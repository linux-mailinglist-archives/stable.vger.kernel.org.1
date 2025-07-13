Return-Path: <stable+bounces-161785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71509B03201
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 18:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE797189A62E
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE25C2797A1;
	Sun, 13 Jul 2025 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH6PZkBZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7581EEE0;
	Sun, 13 Jul 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752422769; cv=none; b=A+Jxmnby5AbT94ByME7pTmgoyKZmBR1ZEDalIV7ymI5FnZ53i+NmMwsH6WfqUSBsw3R2+Jy2io++8wB8aS72Uqv2KaJyPT16JgRXStAiPsGp98YWNEK45WMUojlt0vfWwzOA1b4IySr+DjAlLdh81nUvpH24RVWk6/jFzOarjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752422769; c=relaxed/simple;
	bh=5OxDQXyY4URrF3P9mUulIaAkyMsAeyIXYocMcv5kJLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4hEhhehh2ghyP6d8xBvKTGGl6/EOZxjPiIz7zuD2FaviC5OhB2WKHhVtOMC47tPY9B0LAx2GB2fEb0BX9Umcv6RSzQNYdgEjMGidNIB1W9BWHfQX81WTd1l394phl5ZU77jtfNPlYWlKQtNcdBerUalntkzibDw30fCQlW8cxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HH6PZkBZ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fb1be9ba89so31845706d6.2;
        Sun, 13 Jul 2025 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752422767; x=1753027567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZcK1QUAW+5a7xVqjfrgwGtPRqq6Ew7Nn7a5EpGCHW8=;
        b=HH6PZkBZwJkYbjbT9vvj5EKA7MFAkAzRX7ZV6YSUtvMYUm3ZWqYXDpAJYge7svKzZ+
         lcwclnvwlTQ89DuhKrI3r6AotCKfr3hA6vE3XFzA6tHBNBBTgucXmNb0tH4CjTTCbc4S
         XJiOO0N2aetIFKyHs+lXJqo3YbU/JN1c8SDitIg4wNbHR/IIkl8tR/ViE3DWEtJGYMbM
         4z/qYVfJoHV6AWgRccOQbObTI+PeLVdlM4Fpf4isAa3NX2thlgWTys7wp0KEJ7pIo8qj
         7qrpAUXKUUozV/9KxAKnIaKoBz988Jz0FmBoMXwpLmV4CeOrKlqNKTniIQeQWzm0SeDc
         81bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752422767; x=1753027567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZcK1QUAW+5a7xVqjfrgwGtPRqq6Ew7Nn7a5EpGCHW8=;
        b=fH6PJn8kc1HevV+ZE9rYujrp8OyoI8rjeoiz2S8r5DX6Ssy0KvEl7UGbGL5X609gP8
         J7rDB66fCv80dRKsCaethv8PnMNbRtWAs92sfao5cS/u9CM074SuqM79eHLgNqpNDuKm
         CXDsxuuR8SlcaL4ktjyYlOKPGDAmB2HrJIcwVjbnopt64xtE3fuDg/o8hk05bbe749ED
         qcIig8lJS82nmAyWcskUm5EReUJjSDjtmjk0qrPLG7uW+efrdlBmjFnlg0oGtxNEtxFq
         LUDkqvTcdddExCRcke5NjDbnGzmbtauBuyf/riLAteNuLRlOzBEs9HlYmzfqKhJ/HxXu
         G61Q==
X-Forwarded-Encrypted: i=1; AJvYcCUElmHhjnForB81cnEiZR1t4duu69xsqMaWgW6+awFLbvscJTXuRGo9s6kR6bCLCDlvqSBC769DfVvk@vger.kernel.org, AJvYcCVfHyqpnL5Xqv0Zey6Fj9jNvHX6kh3n40N5aq9WIVt0WFZDlODMwm7ln0giBMVhkEf3JbTM6vzzzwUyutU=@vger.kernel.org, AJvYcCWZPhkl/Pnc3qwaqq5JUmpyd2R2s4SPwR0uXR/NK0OIA2UNbq6F8OZexg9weZmZQx46dqvHEYQC@vger.kernel.org
X-Gm-Message-State: AOJu0YySec2LvGBcCetcU3Utiu2wSA+or5a9bUuvFGMIx0arjVh0x2mF
	XIM5ZpwshyoyqM0x7E8yQX8JVk8HV2njJNsGZ5bMwNmJRTjz+YNqHaHy
X-Gm-Gg: ASbGncs881+9NPiVJqcNsEw8oAtQcxqh3j96pU99cRWXWNqRBMda7pj+f+7lWrumezu
	PxM9K+Llli4rixWwZtqFFfCbcgyeByw84HMcb0+Wt3mVoNMtpXHe/GbtcF+XRgMdfjOrdnNzyR3
	43J0EvpwNtSctAfH5SpUgtFpCqRmCIZBaCYLa1wIihIKQDy4vEp/5s3r6Eztr5bKkkUnybYlZcr
	i25oD8n/NJObsMGUGAOSxYplQ6jHQuTzmlMwNJ34WbBWu4jArrZab6/BXKHuaQpTlFdi6eXIq07
	9XHrbXrrdrYZc/8Q3gcTMQcotpWBZ54SKw6Q0eOeDjShvUGmpXYNLN18BDqct2HNd5/HcGQmSg2
	PlaQHAdv7XjmqIevsKJ3GRFASwqZAIt2M0h3ReZ5JKVXTpyYfLZU=
X-Google-Smtp-Source: AGHT+IEDBjwKKJNiMI1f5doxO+PsDIYjJdPVQtkWqnJwLuQ59AtIxU42y76cJ3gKWN4/T2YAELVtAA==
X-Received: by 2002:a05:6214:5017:b0:704:95ce:17da with SMTP id 6a1803df08f44-704a40c8425mr156221926d6.11.1752422766949;
        Sun, 13 Jul 2025 09:06:06 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e3146sm38340516d6.41.2025.07.13.09.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 09:06:06 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Felipe Balbi <balbi@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: gadget: max3420_udc: Fix out-of-bounds endpoint index access
Date: Sun, 13 Jul 2025 12:05:40 -0400
Message-ID: <20250713160540.125960-1-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025063044-uninvited-simplify-0420@gregkh>
References: <2025063044-uninvited-simplify-0420@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Also, you sent 2 patches, with identical subject lines, but they did
> different things. That's not ok as you know.

My apologies for the mistake. I will separate them properly in the
next version of the patch series.

> And I think you really need to test this on hardware.  How could that
> request ever have a windex set to greater than 3?  Is that a hardware
> value or a user-controlled value?

The wIndex field of a SETUP packet is sent by the USB host and can
be controlled by a malicious or malformed host.
This same class of vulnerability was identified and fixed in other
UDC drivers, as described in CVE-2022-27223 and fixed in the xilinx
UDC driver by commit 7f14c7227f34 ("USB: gadget: validate endpoint 
index for xilinx udc").

Following this established pattern, I added the necessary bounds
check to the max3420_udc driver before wIndex is used to access
the endpoint array.

Thank you.

Seungjin Bae

