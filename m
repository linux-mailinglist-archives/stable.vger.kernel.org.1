Return-Path: <stable+bounces-120451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC0FA5050C
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C791888F6D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5B445C18;
	Wed,  5 Mar 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z26IdHd6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2818D65C;
	Wed,  5 Mar 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192400; cv=none; b=tUoyEmqadmrEQmTJJRQGrtTD51t8Sbg3VYwf9O+X0y0hpMMikp2jJKro9mTKHE9B513Y7nk3/Mez8igwpv0Rp4RP3MD6/JAekB2Q1fIzgXkLkvxfu7nCdOO3ZmGvKB+LJ2UmwYcbje6Qb9ZZRkZXlJeoNo0evkbLH5FWax3PJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192400; c=relaxed/simple;
	bh=0kwY9FUG53nPfgHq+lB9nZ9aS4CCvz8fHFIvv5R3HGM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LKXIa8spqUnYXsW8MFm6CGubRUzCMxIQ3y+2hxKTgV2xmLHkhPPYXeGkmDjtbdqmk+GT8sWi2BHIoWr/zsYkox7g+hXE7bayuXRLJ8wvsIoRQAsyBowciW4EFSSuX9psrcUyyLVJPYyzU/HCXZbN1BikE7/sLEYSKrkwOD3h+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z26IdHd6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf6f3b836aso614797666b.3;
        Wed, 05 Mar 2025 08:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741192397; x=1741797197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JK4O2zf61Cn8wpdWW5Btx9mD0jmIMmD6EG+2ZAdy0IY=;
        b=Z26IdHd6DMr5IfaEV0CAPpCGi7mB7dZU4TxPmOdeherk21cs4z/+xem1bfuTtT6pGM
         4mUEqlkR+fpdmEoeHYefwTgBZRz67cRmpEJcJkaO5+ffMefWJQ2JUGBjJ9cHcdmSRMnn
         dLgAieW3lYadVKWGeF6KgyIKdG5w4heCXB6sUuVbQn6zHBtq+uoXmKr5l/EpxF4qS6wH
         qypstyjKOVpQA4OI/vKWrurCDVfHtmQzGHvRYORuDsKcb5tmsafL8nKo7LzNgtKAn8bN
         5llq/9pMNOubUsKdfG4uSrJhEUtEo/esoPFInqYUXqAap6g2X9pmVuK+TZoEhrDbUb6U
         7wiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192397; x=1741797197;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JK4O2zf61Cn8wpdWW5Btx9mD0jmIMmD6EG+2ZAdy0IY=;
        b=qNqt03ChQS9RVbFapI6Y6MHrAx5SW7+eD8RHGY40TB28xWMCFC2g8/vsMN3YXtL7g3
         KSp7zeCapupR+a5n2N6SEtPV/sEUWDD2YDGT0MvIeVwl6ngwpJYEzoXyke7y0TRs0Cme
         buMk3DeMS4iq76/nP49Mnqg7ToHGN7rBpHEeqht5IX8Dar2kSYtrM88KH4xBacx7+YuY
         jPzjJPqiKFiSJld7sjGQSAqw8PCQIEb4lPTDs8gbOVWDGyp+4WvxE5IEhaQO/NNayvPi
         vcST7VWPDGe0wENOnw1V+zJE5V/3jGHW374VeYmCWzCRxVkH/tecK2z79jLCoLhCGf+W
         VoIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7ECQFFCbWtUN97PpRMePElFSrENQJduM+AruvILe/HoyND2PvCrm3C2zYmwZZxlnVb98oEWxA8Sfn9X4=@vger.kernel.org, AJvYcCXJ3Ij5os9OKxUffhZrDAI1kKuIdiVMsgSPki1vkkPW3mjhbAJM+kDnEv4v5pfBp5WMMJDHsPNP@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqyh9GIGVb+dQRL6XALU9TPX6lafEkqH8TWjCkGW10lp0tW8f
	FV3MNQvJ0XJHWx1YnYqNpcJh12vvcvM8Nlzm8xSdudGzupOLyShhwTfC6rXQ3PcXNPK4AVRubW9
	FHyiMG4SmHO4ONqJk8Vcjb9N6Mto=
X-Gm-Gg: ASbGncvIVPW4d8F4s4Q8cJLz0ecAUeZLCcsxZBEZ7C0Gg2WObqwtu+TOQXslGQ/XA2r
	Mukia96LhJcnwoonokF5FrbgfkDoCMILM10FD/rNd9C89oaAQTKKETN6AxnUaWpC3viF/SkzVU+
	aq5Mpah/z5UadTlcmORt+Hw9FU
X-Google-Smtp-Source: AGHT+IHSHs2TnczkyuMBUdfcfAqotKfdhX9hyFyaHZ1GF4bnrCI3S8DVGv8T1MW99UUFRzlGXjXZR9k54XKDo435ao0=
X-Received: by 2002:a17:906:dc8f:b0:abf:4bde:51b9 with SMTP id
 a640c23a62f3a-ac20dd078b9mr357854266b.35.1741192396600; Wed, 05 Mar 2025
 08:33:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Se=C3=AFfane_Idouchach?= <seifane53@gmail.com>
Date: Thu, 6 Mar 2025 00:32:59 +0800
X-Gm-Features: AQ5f1JozTIGBqPbsdq4tnmrTjBsGE02f-EjWfm9qmjROqDAlMIVVEXpdJMzEuzM
Message-ID: <CAMpRfLORiuJOgUmpmjgCC1LZC1Kp0KFzPGXd9KQZELtr35P+eQ@mail.gmail.com>
Subject: [REGRESSION] Long boot times due to USB enumeration
To: dirk.behme@de.bosch.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear all,

I am reporting what I believe to be regression due to
c0a40097f0bc81deafc15f9195d1fb54595cd6d0.

After this change I am experiencing long boot times on a setup that
has what seems like a bad usb.
The progress of the boot gets halted while retrying (and ultimately
failing) to enumerate the USB device and is only allowed to continue
after giving up enumerating the USB device.
On Arch Linux this manifests itself by a message from SystemD having a
wait job on journald. Journald starts just after the enumeration fails
with "unable to enumerate USB device".
This results in longer boot times on average 1 minute longer than
usual (usually around 10s).
No stable kernel before this change exhibits the issue all stable
kernels after this change exhibit the issue.

See the related USB messages attached below (these messages are
continuous and have not been snipped) :

[...]
[    9.640854] usb 1-9: device descriptor read/64, error -110
[   25.147505] usb 1-9: device descriptor read/64, error -110
[   25.650779] usb 1-9: new high-speed USB device number 5 using xhci_hcd
[   30.907482] usb 1-9: device descriptor read/64, error -110
[   46.480900] usb 1-9: device descriptor read/64, error -110
[   46.589883] usb usb1-port9: attempt power cycle
[   46.990815] usb 1-9: new high-speed USB device number 6 using xhci_hcd
[   51.791571] usb 1-9: Device not responding to setup address.
[   56.801594] usb 1-9: Device not responding to setup address.
[   57.010803] usb 1-9: device not accepting address 6, error -71
[   57.137485] usb 1-9: new high-speed USB device number 7 using xhci_hcd
[   61.937624] usb 1-9: Device not responding to setup address.
[   66.947485] usb 1-9: Device not responding to setup address.
[   67.154086] usb 1-9: device not accepting address 7, error -71
[   67.156426] usb usb1-port9: unable to enumerate USB device
[...]

This issue does not manifest in 44a45be57f85.
I am available to test any patches to address this on my system since
I understand this could be quite hard to replicate on any system.
I am available to provide more information if I am able or with
guidance to help troubleshoot the issue further.

Wishing you all a good day.

#regzbot introduced: c0a40097f0bc81deafc15f9195d1fb54595cd6d0

