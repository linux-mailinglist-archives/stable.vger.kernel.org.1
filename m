Return-Path: <stable+bounces-76875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5044997E60E
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 08:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05231F21365
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 06:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2046412E5D;
	Mon, 23 Sep 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fstab.de header.i=@fstab.de header.b="XXu6Ea7f"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D612E5B
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727073276; cv=none; b=Ge+rQ9HrmolQptggP8o0RgA3bXXT4l++qiNOkvc1gyvOcoCDBgmppHValIoink4S4wm7dw3fCQpconWtxHwHP5KPiWBTLb2iEnZ+GIW1addvQ3JhyKmdCXRP6bdI0oVb0EjON0FYwb54eKYeJO8fX+LDz1SeMUoNc20gX3j4rHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727073276; c=relaxed/simple;
	bh=figRSM5uwXBz+DqKm9Y8ViKtaULHMXexiRKciLKh50s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AU1yoikZ+CBgU0fDNT1YjnDrdxQsKir2iYRCpH7MW1PIQ5zXvtOaecMV5mJT0/uTP8A08rNLn9l6zdmH2Ktt8R/ZJnQVDvOhtiBu0x1gFpkNxki4fQY6RF7sPFgDN2bynGfdUfo0SoHAFB8Kkd6fv3YBV2sBgtHnzcHVUMPwBtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fstab.de; spf=pass smtp.mailfrom=fstab.de; dkim=pass (2048-bit key) header.d=fstab.de header.i=@fstab.de header.b=XXu6Ea7f; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fstab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fstab.de
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c54b1f52f7so26293236d6.3
        for <stable@vger.kernel.org>; Sun, 22 Sep 2024 23:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fstab.de; s=google; t=1727073274; x=1727678074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=figRSM5uwXBz+DqKm9Y8ViKtaULHMXexiRKciLKh50s=;
        b=XXu6Ea7fuQBNGgUCHBLwk2UUqfRVj+YyVtJRlvz5TN+gs0apbKh7WH6qt4u8NeHnrd
         sElrvOSsGZHRbU63HJAqeSkxPn9DBMZr8dylMfvodrbJO2+KdmD1WnMRalXVHFL2lsS9
         zhHYhWDU7883s6sgn9fQaxz2kTyyGKTYfpKQKREYM1XQXE438459kPCOFATSpVrgryuw
         F4icYxMI4MufPl+ijKPhi36vhYviT64Aw/F+7/QfXQhzpoWpR4LSJycvywTWSM+F5UeJ
         KddEBOc+msLU7q17YEBjvYxMmBjHeRr42aTx0s/i4+h82yOk14Q+J4Eh+DL1mCK6cpMT
         yuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727073274; x=1727678074;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=figRSM5uwXBz+DqKm9Y8ViKtaULHMXexiRKciLKh50s=;
        b=vsic2k7AuOPgbur+u1CFxG4ETlnkPW/wVN9cIGBgllxiNeQJ5gY1ifTWxJ0V8Gs+/w
         3SN365i8/iTgnm7v7Sr7OHkyswlWAp6jgG63bFi8456BR46WmV0b/vws5yO1DLBIMkV0
         lmyDWLegDyS6LfegXm2/5L20KRKWBIIeySRUK8Hp2aaObrixv/4eJ7Lf2EEOeRKNqRWq
         gCzacvjJqEsFldFvAD1wohBJQDfYOJAMrdRAlWaB54sRLKLrxm646FweEHKfSmpsh+WM
         YiDxUDLGCwJwhc39G/kGpjBf7Y/qapXlMbFpgireZd16Qdw7VZE0JIKS93vB941XR0tl
         JAEQ==
X-Gm-Message-State: AOJu0YwWtDhtJZwSd4yNLAbOWVsxCP4DD5ECmxaMfX1yT/CRKPERlH5m
	ZvRBpFXRCpeRFBrCmPhfTo8T2D7rzkO0xHq1TOBwn1WWZDy4ylwuwDmGaXdDmilSWtmGuk+a3QE
	2ORPPXsxQxK2u8oQp7d/uq+wFQixPIZP0BlHqxv1P8yLiezNjXLh4jg==
X-Google-Smtp-Source: AGHT+IEe0Zy6MhQISPBXaDCPM/WYVBEi1fTtVz5ghNsYw9MwlfuQwCVE1xCje7qKRKsBXQR+uJ9+UZLjDvO/To1/kLY=
X-Received: by 2002:a05:6214:2f8f:b0:6c7:c650:962b with SMTP id
 6a1803df08f44-6c7c650966dmr131212646d6.51.1727073274090; Sun, 22 Sep 2024
 23:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fabian_St=C3=A4ber?= <fabian@fstab.de>
Date: Mon, 23 Sep 2024 08:34:23 +0200
Message-ID: <CAPX310gmJeYhE2C6-==rKSDh6wAmoR8R5-pjEOgYD3AP+Si+0w@mail.gmail.com>
Subject: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I got a Dell WD19TBS Thunderbolt Dock, and it has been working with
Linux for years without issues. However, updating to
linux-lts-6.6.29-1 or newer breaks the USB ports on my Dock. Using the
latest non-LTS kernel doesn't help, it also breaks the USB ports.

Downgrading the kernel to linux-lts-6.6.28-1 works. This is the last
working version.

I opened a thread on the Arch Linux forum
https://bbs.archlinux.org/viewtopic.php?id=299604 with some dmesg
output. However, it sounds like this is a regression in the Linux
kernel, so I'm posting this here as well.

Let me know if you need any more info.

Thanks a lot

Fabian

