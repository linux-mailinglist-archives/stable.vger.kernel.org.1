Return-Path: <stable+bounces-64738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EB7942B3D
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 11:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC1D1F25ACB
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 09:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24F61A7F7B;
	Wed, 31 Jul 2024 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMYX3VUw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2DD2E62B
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419407; cv=none; b=i8dtfgsVpKDtWzTq2hbFqsOfVnBRj0s0d9zhu3m1O12cqry7F620kmH+v4vi7FnhjTyL+XXC1CDhBuLhI8HQh4h2345+ILtgs2MinYKC78nlg/INSJBQChZozSLxMD1HO0EEXzXsP8Wpx87HtO6HcmczPMCimq9TXwpO1cvfqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419407; c=relaxed/simple;
	bh=TdambeWN8mEW8xNOTUJ4HyHJdaU9zUZOdPUICdRRuOM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZyErJr065cdCsHIpm5SqQDb8qzUb8lusVPZn4mn9CuBPIOOdOaRKgat31H+e7BjpDajiDQ08qt1qjiI1wE49CgCEzCz0Oh1bUCuHksY75L7Ed0VZ1Qj+a+GoGfbUWM/oGpZ5CVGq79TxZM7FwLnY6ljjHcleynu79aExpc/tIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMYX3VUw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso516476866b.0
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 02:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722419404; x=1723024204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JUs5+7tDQ6c4YCsH01ZcbUFpSrnJ5OsqAqUSMK+9qCY=;
        b=VMYX3VUwH+Ml2rv9LhGnX/xMArTYvDSsLLTBTP+AftAYjNHoL3crdNbLqGCHZvPox7
         wekHsjEf0yEFjsTmmGe0HMSWygGTZlgv519JXDg2bKtHcW99TiYMzDToyzYTlwRZSiZQ
         MKhbtTNSqVGofFYvxhZXgkSiPBtLav1Y0FCjHJsbhMI4AN0RaB/QVQs/kKJWLGyo6GMJ
         a+MVIOOnmrO7IXrTCe+L0FEGXOxVvePfDLMrwQCz3N0AVmkOzi/xZED7RK2NhQoyH1kP
         qcW9tqi4M3q4b627CNKAWQVQgb84HJSOA442FQbRHLB13iTmLZk9c4dFiTGyybCLbTU4
         qyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722419404; x=1723024204;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUs5+7tDQ6c4YCsH01ZcbUFpSrnJ5OsqAqUSMK+9qCY=;
        b=fkryAHVga53+joI+lGE+Sk+pYzGb35DZVbnQEXaJ9fnFQ0alsPb1rOQGMbWT7GuwyG
         QFk28ixWOxKjV4wRJc78+UgQRV6EEjpful3SWF6He8T9rj3EhyYK8vTzgVxwkhsFqAPL
         DFZaWO47vanPS8Ej7Hvh4p2C4Pfu7WivGzoyfF+gWZF+abgKuxF/tawRm3Uw61Embqc9
         MHS0yp6lTwGhFFxmtlBOeKN9IgApqky+LbAqGTLBczlK9pyQYRzNoQ8PoX+mGh2Tne4U
         70zS5/CWwmGK5RbAA1n/j+QWGuR82/V5mq4NXSGQDI67z05Sy7z8lK2+p6CcuGnCGtMd
         +u0g==
X-Gm-Message-State: AOJu0Yya6B5wKrMhMVs9oghWr5bUPE5J2d+icpWm+Yj8+0z1e5cpzxbT
	dc67YHGBCpcI4f6tKAu15RxeqxiSrk5y4lc4pEDkBJKAKfCe9SG1ZUE8N+JnZSN61N2DjV+BfzG
	yTXS81bP+qTvy9CJix3SnvO8ciINSRERW
X-Google-Smtp-Source: AGHT+IHQXAnah21hZoMmvITiAfn5yV+Qff3/bcRUa6mQhKtJ977xGe+IiARUr9Fx5Sq4FNRRkYAg8A8Atg7TSp363jM=
X-Received: by 2002:a17:907:3da7:b0:a7d:a080:bb7 with SMTP id
 a640c23a62f3a-a7da0800e5bmr89470066b.36.1722419403625; Wed, 31 Jul 2024
 02:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Wed, 31 Jul 2024 11:49:27 +0200
Message-ID: <CAHkwnC9B9TxSei36tkBe_GE4q=1DudUyD2uo9VuCa940qABHjA@mail.gmail.com>
Subject: Telit FE990 hardware support from v6.6 to v6.1
To: stable@vger.kernel.org
Cc: Daniele Palmas <dnlplm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,
please include in v6.1 the commit 0724869ede9c169429bb622e2d28f97995a95656
"bus: mhi: host: pci_generic: add support for Telit FE990 modem"
https://lore.kernel.org/all/20230804094039.365102-1-dnlplm@gmail.com/

Thanks
-- 
Fabio Porcedda

