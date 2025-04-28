Return-Path: <stable+bounces-136971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3D3A9FC9C
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 23:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3F23A8C66
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 21:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9AD20CCF4;
	Mon, 28 Apr 2025 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UvQulCF4"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6771F872D
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745877549; cv=none; b=T+EwXgUoEzairL4B8+lHnnijFFFwDnkkLQdDFuU1FkTIZC+tfLRIrP+7Au/sYr1dN+/fK6VAE7gN2Kaa9Px9FV/r4/2T2pDEe2UXPrjCu3aVkMrkBGuiiL1AMke4xc/IZxDKorMgkEsAX4jAGJ4sC7B5ob5WX8xOsrfbd1nPTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745877549; c=relaxed/simple;
	bh=53Vnm9hvK3khkxEnThEFfsRSKQm2C6bKgIF34oGKA7A=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=P47ErYKPXDHGtHHtY6igfRT8Oeej5o4OnBlG28TuM89WlOi1Y/AaMAg3ibD/mhdpF2OdGdEs5LnXbmIVSkfOxpzmgNa6ZClYoEWN7d7A1uZY/JCBK3tTvM9Yvy9k4YVc14/P465pylWxRTyr1nJ/vflnrzw5hEU7nCYVn15h4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=UvQulCF4; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e730ea57804so3883669276.1
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 14:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745877546; x=1746482346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FE4dKVoW8moTlKoFNRtvp32RdPrHjumPK5vEbrjDXw=;
        b=UvQulCF4/a0QrV7RNU88/ZoV1x2w+Xr9TYsTgdKO9HTMPr87xTMq+IIVg8dtzBwBxb
         QNkjGzsfTv3YVifY5fULtsczX2cSUf349U9Yip2IYIpab8sVpgmHfAEPzFrlbJXhsVZk
         y7gW+/gC34BHF8fC2mvtDa6WO3K/JITnzKVmP8rqLysEfx0pJff/+qsKDDkaW1czufAQ
         8HPrZ/egeUr5uiqKcXMxB6gX5MeayboKAmshQeR6DF2QtvHZoRlA94fHAsd4zXiVjsDP
         NCElY04KV0Pg24/fsJMEA76P+2eIQ5u2svGEEDHfcqFXmfdSLVlJhSicWxSedExLLsYy
         H5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745877546; x=1746482346;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FE4dKVoW8moTlKoFNRtvp32RdPrHjumPK5vEbrjDXw=;
        b=RRWco5fHN/yT4F4NqKTjGN+K2Y2yf9hG5BOJycjujxfiIdhuj1gFzQi22PkErUHbCA
         ssOJzWqsfskafb+mE4wK54zQrrIKTeDNWNQEZQiMDZ5aBWQmR7fvznvSWXToAposg5A0
         yzSHHoQvXMD4BTOel6O6Irx5AmdQbkKte9mt7TI4eutwRBkRN/MuLwe9pxyFNSRcgPFH
         njn/gTnwW77NVPuuidW/wCXZZP3RT2qS0pXzKIfnmDi4OGMtweABTnt1X29CZpumOQ/5
         55Y9EJVRJZmxZVA5E0QDRr9n9YrAANRp9SpL5Yq0PkPr7WKLsa4wx0HwclTJsv8HinPr
         zMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlhNPOG8tb5MW7NfV0vXbVT5OyjsPxE23ktjVDk1PX9gvbhRXAlh+28RthICoLu43S9t42OvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGKlUsoITfKGZcMpSP2rW3/5jezEuWQE2q87g4d3klH492CYWy
	jRuKkcv4UYwYtFyYGaemsN/Fi2Lt2avSPIX13jd1je7+YiZrJWBI7eqMwg+YM05nuUEGHGThh/J
	g93XiqllePghZcNnFyyojaMYV458qddg/+5WZbQ==
X-Gm-Gg: ASbGncteKzFZbsvW7l+fxshpyzm1Xx6POnrPaZ4YPnfUmLl8mKFV9BEonF2/q+u5TD3
	cbJoNinksbc31qEUbG1GlAHlY3yKYIxgjRDe2ylHqmtKzS9mbyzcGeIgq2hpsrgRVvkdMO6Kx2k
	I/GPAuwz3NuqoaSP/5cvU7
X-Google-Smtp-Source: AGHT+IGoo4Thch6otrDJcJBCA5eRAGcyv67+L2i1kHhZpfwgD9CsJWQkJknQjFDucjgCz4wU1VmVjeMAFQX1BRSYHXw=
X-Received: by 2002:a05:6902:20c6:b0:e72:81b7:bf80 with SMTP id
 3f1490d57ef6-e73510f3336mr1344797276.8.1745877546491; Mon, 28 Apr 2025
 14:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 14:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 14:59:04 -0700
X-Gm-Features: ATxdqUH_E6L4jyJAJRP9VibVG23kVBKHb7i5dI-2GZ6cRg_yOBcDfLJ3KCVrjCs
Message-ID: <CACo-S-0kuwkXsWp5cGVuQcJBiVpnY+qxrmMSYGUpjwYFYj4nkg@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) use of undeclared
 identifier 'MSM_UART_CR_CMD_RESET_RX' in drivers...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 use of undeclared identifier 'MSM_UART_CR_CMD_RESET_RX' in
drivers/tty/serial/msm_serial.o (drivers/tty/serial/msm_serial.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:5e7d4ac9b1bb62b7ce4e9d81fe31aa0726357a6d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  bcf9e2b721c5e719f339b23ddfb5b0a0c0727cc9


Log excerpt:
=====================================================
drivers/tty/serial/msm_serial.c:1742:27: error: use of undeclared
identifier 'MSM_UART_CR_CMD_RESET_RX'
 1742 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART_CR);
      |                                  ^
drivers/tty/serial/msm_serial.c:1742:53: error: use of undeclared
identifier 'MSM_UART_CR'
 1742 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART_CR);
      |                                                            ^
drivers/tty/serial/msm_serial.c:1743:27: error: use of undeclared
identifier 'MSM_UART_CR_CMD_RESET_TX'
 1743 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_TX, MSM_UART_CR);
      |                                  ^
drivers/tty/serial/msm_serial.c:1743:53: error: use of undeclared
identifier 'MSM_UART_CR'
 1743 |         msm_write(&device->port, MSM_UART_CR_CMD_RESET_TX, MSM_UART_CR);
      |                                                            ^
drivers/tty/serial/msm_serial.c:1744:27: error: use of undeclared
identifier 'MSM_UART_CR_TX_ENABLE'
 1744 |         msm_write(&device->port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
      |                                  ^
drivers/tty/serial/msm_serial.c:1744:50: error: use of undeclared
identifier 'MSM_UART_CR'
 1744 |         msm_write(&device->port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
      |                                                         ^
6 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:680fc02043948caad95c0cfb


#kernelci issue maestro:5e7d4ac9b1bb62b7ce4e9d81fe31aa0726357a6d

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

