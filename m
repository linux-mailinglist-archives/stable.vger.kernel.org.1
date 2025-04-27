Return-Path: <stable+bounces-136780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2991A9E095
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 09:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C37D3B8562
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CFF1F463A;
	Sun, 27 Apr 2025 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpnxmehx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5CA10E0;
	Sun, 27 Apr 2025 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745740078; cv=none; b=K0C9/yQelypi0FDN9R8mccvZP2IApLBVvhV3lXF6IArAXZggTg+lM2cfjNmgrrvunCuugqe8l+/QSdELAkAG94K2EzkLzVXEW9qLd5BxDrxRHFZ6vlg4koPJrr2zFwIgaJ3Rq8qtMSCVfDWEQRJO95gPMjojkSupj7jPFVwcY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745740078; c=relaxed/simple;
	bh=Zv9UkLIihex6h6uTzkv6W5mgHkrreKRyi05a5WoLInI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TALxscnTsAP5ImfWyDDibGMAkZre1o8KAPYmiT+A4WOJF2bHbJbZqC4tfjDOkw8cedJriT5JFXTwlCXqUq/aNZTSAiLlF8PU2vFPvAQKx0RShKDIRczHHfEkSS/8B9/SNy+XI5acRRgzRUzZDmIHMoccJJS+iD7UPdK1okBPmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpnxmehx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so24302555e9.1;
        Sun, 27 Apr 2025 00:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745740074; x=1746344874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ep7HI99e/tGud544tNPRZD7MzU2VMMJjX/Q3bJALYng=;
        b=ZpnxmehxZsjv4IzefgcYPbrMgLwChKJ4Q4aKRgWuxTGOcLFfsEmGtliaRC+SVdOyW+
         fBI8WsJj/c30rX904oeEIN3V6vpPIFAHqp2iRjwCaCH3e8Ro/ZFOyc4Rw77PJXI5Cbdm
         wVB1m6wyPSJQ/j58mjhbBKoJTaG8+5ot0eA8O6cW9BdEQMKluECXCVwjJlCckqQEooPW
         lhCQSb5/bLsWlVcDc7P0gUDQaHV2OuMuKy2nFPaRCQBARVR63c+DXlRjH3u3lbSzz9N1
         oPrf8t6kRkhMjGjN3fLbMUr93EajIlNpAsKjd9vsRty7gvmjqHW1sLM6oyXTS02Xy7Aa
         0sOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745740074; x=1746344874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ep7HI99e/tGud544tNPRZD7MzU2VMMJjX/Q3bJALYng=;
        b=hr/Da9N9R/Vm2xfGWqM1L3P4hZ43Vs7OmiV86/Q7DqiZNpYrxoO3TXBIQHr58ETkVE
         FDBl/0xzjxJb63xDnEUAEXPW2oBqbO+2aCJe3AAX9/kzwwEPsPIYu5G//AgPG2pjKPiG
         y1F+UH1xGlI0pH85u9mvMC88ydKiTrwO297JTP9zCSiQVpeookEOqzFVh7ehwUWz5kMa
         EI+qva7RtKCMwWKgS2kTSlOGWdCKP1QuCB7NPhBOUy8htdo+flrNCOkV7gavpimUfRUl
         i90aLCqxn/NVNEFpWJODqvgZ/8M2bJ9YLhNrCUq8NjcQGrVharNLWXCPBoIRnamQNbgR
         HZeg==
X-Forwarded-Encrypted: i=1; AJvYcCWj/ldd9Rxy6OD6E5yJuS+GgpC0JhS64Bm3S8KZBB3AsVNdOqgekiPYpzqxgU3QmqiDzMUqUu8X8eY=@vger.kernel.org, AJvYcCX7SdSXGkTMhGdhNuHxQ/sH11E6spZFnOq92B6qPmPcausCpunKddhkJDPqjW1jiBxz4BiceYGg@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfejYc3UldEhPYMNwMMvxj3Gg0msFVgX/j7yw22ag82LQ9Brf
	iA3JQt6kC4oJinMO3YhVES0jImx6zoVdaW7fh4rp4YRZYej50XTn
X-Gm-Gg: ASbGncvWS14ZLwj64brNBib8SuuXlGkDXns4LpjOtlqUAnTp5hoOo72PqI/dAKvShoH
	r/1MhHk/Hq0TZVPejADPv1GGugr+9k3aP6yBPqxLuI11JxvDZ2Jo5QkAbplaAwZUohNRrPkGxiN
	Ofc0leSbKxnG498uTrRWIUtn8NJbDH5DViXYbgzz5DkRX5peElTBpwqCGdYlm2KD3WaoTi0fHv9
	avPIP1OkAAzzGCwcpqVf0sQAW5Klb0uR9Frc6AhNsC/zdLBcwq/8PvnwzaCr9xAnYsNj8o91TfA
	WW/mnjEbKUF4RsZzp2pa1yIXB01goq/lXhWzMTpsBkovZzxtuK3qPuJf6s8Ty9kTyrDJOmL1ftM
	v
X-Google-Smtp-Source: AGHT+IHuLsA8CHbCmxeHV3GAcZ+vmQwXwyb5kGgaVUUzbsCSaucWEw8NINf+yf7jJY/b8kbPUjvnew==
X-Received: by 2002:a7b:c384:0:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-4409c4dfb60mr85412155e9.12.1745740074577;
        Sun, 27 Apr 2025 00:47:54 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a53044besm84930655e9.14.2025.04.27.00.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 00:47:53 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: guido.kiener@rohde-schwarz.com,
	stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 0/3 V3] usb: usbtmc: Fix erroneous ioctl returns
Date: Sun, 27 Apr 2025 09:47:50 +0200
Message-ID: <20250427074750.26447-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent tests with timeouts > INT_MAX produced random error returns
with usbtmc_get_stb. This was caused by assigning the return value
of wait_event_interruptible_timeout to an int which overflowed to
negative values. Also return value on success was the remaining
number of jiffies instead of 0.

These patches fix all the cases where the return of
wait_event_interruptible_timeout was assigned to an int and
the case of the remaining jiffies return in usbtmc_get_stb.

Patch 1: Fixes usbtmc_get_stb 
Patch 2: Fixes usbtmc488_ioctl_wait_srq
Patch 3: Fixes usbtmc_generic_read

Dave Penkler (3):
  usb: usbtmc: Fix erroneous get_stb ioctl error returns
  usb: usbtmc: Fix erroneous wait_srq ioctl return
  usb: usbtmc: Fix erroneous generic_read ioctl return

 drivers/usb/class/usbtmc.c | 53 ++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 22 deletions(-)

--
Changes V1 => V2 Add cc to stable line
        V2 => V3 Add susbsystem to cover letter
2.49.0


