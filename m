Return-Path: <stable+bounces-178035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAEEB47AB6
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 13:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7B3189CB88
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 11:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64D022AE7F;
	Sun,  7 Sep 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htmCOdb1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2491EBA07
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 11:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757243298; cv=none; b=eahyFFB7pzqQDyfPu6V4HV1YtK5xaPKSC/gHTkBDr55k8fLYyLaJv2lZu5y/Qr4vwW3j3dAAXdXo6w9Xm+K8AOzbXYWi5kdJgePOimRIUCDBCOWL+42LPOquyHP941SenGzwccIlICdjKZ74SlKoqyqDwPj6ZBaxCzqu8aBgdjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757243298; c=relaxed/simple;
	bh=zOziwSPIu0WET9EHNeTPg3wVq9hIILgGCIvIqC80lfM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=H30SqZb8gI2qNj0vv5+ucY4UqSXDbrdr3QYDosf3XD3mpdv0rurPDggTryMaLFd64XVnXUyUOjyOVYYUMLu0kUrdKwNMMtIo30OZR+c0XBtu8Htl1HYM3rpyb3ru0ulTNZ1Jw/WKACiTeVopNRQg+G0hIUH8T8Ub/GX82w8Tsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htmCOdb1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24b1331cb98so5817695ad.2
        for <stable@vger.kernel.org>; Sun, 07 Sep 2025 04:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757243296; x=1757848096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sBOTEsY9UWsu1DHsCYQ2z8rwKlK6Xo31VY89YiOAU3M=;
        b=htmCOdb1c7VKL8Gy6yd8qTookVnZAL79Y42Y6XAyaa47U8zh/3Qbxw5FWuJKpG9dIn
         2nRfT179wfeDTvERfRVlthzlbUpezgN0AQ//ydA5aHsNTwBzGCSk9tiZa3cVDHeWRnNo
         lmmy3XyAdxcOnV+UzpYuaIjUnqz3wCZJot9y6HKn9fFhmKGsxnFpoKCJq61mM1Dnb1Kt
         xb37B//ZOIyNo1P3ZjWs7DY3YszNPnKxlMJnGgL68Or2+veS/3KlSq2/WhPsRz8UGQFS
         NRcZMAxa2TqOynOz5ijqbPBFoedNNEC7es+YVPVCOH8L1vZ1rUC88I3M9inZYtW5SLvW
         D5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757243296; x=1757848096;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBOTEsY9UWsu1DHsCYQ2z8rwKlK6Xo31VY89YiOAU3M=;
        b=RCrDsG64q0OTO1eBvYNq485u3KbCnZliWUTJ0UT5WNMcTpIs4A+5GBwWC6iqoyPlCK
         OcSIW2nYseIHWm9utBugmRvHe1tZ1EM9tbUGtWdu8I90m8Z4ODYGpHhH/WLPnN4/+/lq
         3ZfKM/yOFfmqAqIs80sqB8sjijqoA10ma4MXMhoed3+/9F0eefnfaNfY3AkeAJfasqCN
         GqEztEreWNz3A1+73D1/tNnYxPZMGOsqCMBtKY7gjZ0sxFUF4GLcapNbaQTcDhQAhJP8
         MvHYNbp4hDaSkNDY7TltJIz2RPVd6GaRv98hPBAaqjrp99gSl7TOUmfPRu79EXGksd3r
         S8Jw==
X-Gm-Message-State: AOJu0YxoLBzN95xfWdhoXYhCdGq6K3rXNf/7s7wUaN0Ee8BuydxOF7NA
	ByNXSBfgZehxpGSwNi2fqi6oLIIAhjKv6OiPBrZFTMXEgv5RvAQwATlbdr9zQabfuZB5/SDMFPy
	qdRfwZpH2/uL3+fitGiVyIKj3ToPFRzs=
X-Gm-Gg: ASbGncsCFVWgfLJ1lJYNdIqPX5RHlHSHJfzRYlgUmQxnCFqB53J6HsB6hywOlD9IzvU
	/w5L1TEJV/ZRlSYvoIg7epSP5ArS6h+2Wh+xOOVNwmkxIJKkwsLjElrtBHrAZxwiHZQCRygWHf/
	1bcIrUCGU2YhJh7SwYtMUgjHDGO+Fd1rOYh+nUPKHhT64Xnp6ZUeR5EYMEfsCRtYM7k+O9i/qtQ
	t99qgBtv8eVAeYeC5HtCt3utH/8b+s++yRHJU8zFVSO1a/wkTnDwCx+iYU4y4D7u9lv4A89NbDC
	5DirjCOr/dRMHZztI4asFXQa5kIECSm7FLJa
X-Google-Smtp-Source: AGHT+IEZ2zOQxzZJRweJPwQURc5nEJgNyOrKa6SmlZwPccZ5NaKR2VJLuGXK3RwlsEbsxo64v5VDb8HM6XRkUM3D14I=
X-Received: by 2002:a17:90b:17d1:b0:32b:4c51:628a with SMTP id
 98e67ed59e1d1-32d43fb18dfmr3583768a91.8.1757243296483; Sun, 07 Sep 2025
 04:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 7 Sep 2025 13:08:03 +0200
X-Gm-Features: AS18NWDHN4WloA8ErM1SUIxc5Z6zZztKGHg4EK1UN3y6-BnvdlsVayA9WSOFXgk
Message-ID: <CANiq72mp-t40F0scCVT1ew_xRdaG=8x-0xx1qQabUrEjS1mQvw@mail.gmail.com>
Subject: Apply 8851e27d2cb9 for 6.12.y and later
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

Please consider applying the following commit for 6.12.y and later:

    8851e27d2cb9 ("rust: support Rust >= 1.91.0 target spec")

It should apply cleanly.

It is not urgent, but will be needed in some weeks to support the
upcoming Rust compiler versions.

Thanks!

Cheers,
Miguel

