Return-Path: <stable+bounces-136776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9942A9E06C
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 09:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C21517E885
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 07:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB961B87D5;
	Sun, 27 Apr 2025 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1pArKu3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1E5661;
	Sun, 27 Apr 2025 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745739036; cv=none; b=S3ZudYRiFCQ+Zmq/ecyzNpl78qgJ9lpuTzqWKUk1TyeyNQXHyhrDfhIP+29eY9y327hGaiBVXCQeaBYWzEYgvfvPmDOpRM5ZJSRgjIgg1M9fsGlhx6rP1k9S9vqvpELPrAD5eWwp0oWQG317wuft9/pavi+KPR6wQlV0bVck9sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745739036; c=relaxed/simple;
	bh=pX9nNDbBL/Gc3817tUD22GVpQ0iAbnkYpv0+HJ7bh0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWakYIm0cQciPaYjklyQErEA8N/HbUBdxKbUPegcgKz1yYWfwLfG5sGOhifYFJa3sxHNJo5cnkJ6XpZdtmslwve/33NryJ+deAzIl4y8BNIf72lvtZ/XP7T8jpUd3ZScBupq2MlFP50YK9/uMzLEGfOE7SNHA0B80rQPPQ7lMsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1pArKu3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso34779655e9.1;
        Sun, 27 Apr 2025 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745739032; x=1746343832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+/kh0oJ5ZqXsMvdhcSU/Q/8lDAOk/FPuCrqnKitQ7U=;
        b=b1pArKu3cES9ALUqgvdjkE+1T0vDQpEV6lRAA+ycGoJ7MGFRD4MNG0ExI8CYq2Z8Yk
         CqChjzWmzEFsSYr2SPwWyntgH2j403IJAqWbxKr2W8EGG6Di+hJ6Y8/ycz6NQQ+w/lkg
         5sJ3FQU1O1Ga6e4AKHLaH2Qw8Al8wGikqhBTmMmey9T1leez6vvPNnMTlxDJaLFzui7s
         LToQaO6/sJWFyDe+2zKiVRtrVDGbAT7PkOc9bgB3Snh97X3evtyzYRoyBndbwKzXjk1T
         13glTIbnMHchHwGSp+LQ50QlHLyUtRy1kkVWxPJWxoWhgQAaz/rAG/JNM4Ty+TwBFZps
         hWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745739032; x=1746343832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+/kh0oJ5ZqXsMvdhcSU/Q/8lDAOk/FPuCrqnKitQ7U=;
        b=KXdv9HIdDeKvIWHCYQQmRpINNjNjP5sIY9Gp74B0PFEwFAEbie0XfSdLdhIGy0JKob
         QsgyHIYOgyqguPcH/PzIakaSClj4XGu5GWLtujAWV2c67fi7lNaxL6t2lz9Fv8KNCoi8
         rCIswb+LdBWbLmHoNWKVLVnuIsOe9q7wUrloZQ2PTmfMf5k+csNjAsZh0sAWq8OsRfZP
         i0fxEy3XeQljmX/cwbwQGQAHHmcPEquEG1NaNLjR8P6zwgguDFdlDxj07e9tUb6hs68L
         hQiKtiqzCmAEUpNaKK6h0uA52ZbLPgy1GvGSKuYlmjnrWsFy+uyLtAfpL5lSrEy3McpP
         3UCw==
X-Forwarded-Encrypted: i=1; AJvYcCV0wKLID9cJmzex8uUKQ5T8b+w1eDMUOtvklL0O4kw1znrnSer2XR/iT4LLB1nvWSw+lblXwNq4Hyw=@vger.kernel.org, AJvYcCVlKc5N5uzPsgDxnM/rJaCL3ikAMb7V2DiLC5S2CTVbDGBLaEKqrW2oyf+jtRiVTPEE0t+UpgLn@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUGhma+z+j1I+SRS7iPHLuMDXqjnVz5ffUPUdSDR6suigXoQU
	wbXahP3o1pTrhoNC9URLbrxiuD8n643NMLg1qcE/69Bh2m9L+S7f
X-Gm-Gg: ASbGncsHlILFC4m/6X0s3NdwK+OZfl85bQcQQpD8mAST+i1MbVmD/fPh7Yd/sgVVRve
	NGGucFbUagx1/MnZpmG0V8luinNu7vus9TjZlZNTyn7IOtQCgbBBhuBcdOCq6MqczyO2EeL2FzZ
	3EVmz18R8FrbtkrVsNMDMPJPC7E8Htn46Z7V46VRHJecQC4Mx3aAq3i99c/ge3KaOjYL8ZCjEZp
	KtdjZ59BCgV03lmGn0tSxSbamtMUAF0mHecyta76uGbueu30CS4h09FfrrxMQUXh2WlLPZ91cuj
	T3pBg/ohIdfQnew6FjPp+0gZ287WGiwR75LgrBuErAIfGeAyi7pW5MuoRq7cKg+6oAUYa+r77bN
	oKEU4iGbVUPA=
X-Google-Smtp-Source: AGHT+IEsE8ctNUYA1Oek+I3kUFGzIDjGtXHurdPprH8thhoIebt0Nyg/1D6KrOBXe2dP+CzQhhAB+w==
X-Received: by 2002:a05:600c:3d0b:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-440a64c1820mr81106715e9.2.1745739032176;
        Sun, 27 Apr 2025 00:30:32 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a531072csm83924145e9.18.2025.04.27.00.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 00:30:31 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: guido.kiener@rohde-schwarz.com,
	stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 0/3 V2] Fix erroneous ioctl returns
Date: Sun, 27 Apr 2025 09:30:12 +0200
Message-ID: <20250427073015.25950-1-dpenkler@gmail.com>
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
2.49.0


