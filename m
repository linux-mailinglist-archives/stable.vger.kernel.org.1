Return-Path: <stable+bounces-50112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D1690290F
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 21:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D241C2137D
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 19:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2081147C6E;
	Mon, 10 Jun 2024 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k7lecxZx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254CE74404
	for <stable@vger.kernel.org>; Mon, 10 Jun 2024 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047084; cv=none; b=TA7vtwGlKzKzh3yVMt9nLhs/ttnP3SfzW4QnCKrNcL1XRaYsuLUBObAFYDTUHXWdEFo/8wDtLFZQ7+NHlpMEgWQ3aQRhDkRFn3INb7iC2jPOEsik5796hmdUjtswEfmHEoRQxDKduTVynA4LU0IWWVHt1dUeZwbZoy0pJxmJkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047084; c=relaxed/simple;
	bh=ZLDDNoFT0RjZQZE3Qbp0+gYlvPoMfNcLfWYnfekiwsQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qoSCddcV6SoQbfDtJIS/YnurHFfCjfQWZoYxpHGghu+PWu93eHzuDGnM9TUsr2ITv7qBbaTKTJZD8sPOcjJMmBGMnkeLX8UEYP+ggnAIg6t77QKhwg5wP6tpaIHXwSGDVmq46NxwTO9QqC1XozXfzx7hJwpH2O8ol+yzz/AEVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k7lecxZx; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b0645351ebso818456d6.2
        for <stable@vger.kernel.org>; Mon, 10 Jun 2024 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718047082; x=1718651882; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKTxfDepAOASvtboGdygz0hOxMNQauCfOA/I6qs8Ids=;
        b=k7lecxZx91arwFmCAdvH1NKX82YTeXHe1fVLkS2gUirODAciMumBLdMLjn2ljPfPTc
         HoVXlN7HA+CNrb8KTEPfQdbog9YtfAJJuJshqB+EId4Nnm0oIQbbrD/oBOHL3bghYi1Y
         FYiRiohW7FUjvZwXqlNSIO1VP5y2gPGGP1qk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047082; x=1718651882;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKTxfDepAOASvtboGdygz0hOxMNQauCfOA/I6qs8Ids=;
        b=wKmDPwh4txpDP6CFImcsNNOOADqbPLln2HnSdFouc+3AC81r8pX4mxEk+fV3FhyQ+X
         WsvZl9cbmqTdOzyudHpS1BQYT+yhR3TFdWVFJwF64WxBw+WAEYww3GhsDW04g+wu+4t4
         tF6DfNkq5ZyCLtwQr56wrcrrw6wIDDFnB+L2Dc0rM94e7KsAT9QpkHIZ44VBoZQouC/o
         BjT9kGH9IzZodESluWrTTLajqfjhVi2zhc33KS5nsDNypDfUsmGQ313kV31R7eNs0Yc+
         ls/59ekDRnGflJa+N0/zt1DLHYUmxK6GbjtBR7CIhZHVFWZnD4rA4P8wXIl5V/IM+zVi
         9bAg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5gko1kYUqYdGUpyVGwp5JvnhQdV5ZCcTvS4qFqX7VveeqmkKg9XcZtFBmnn9INz2nDguI8MImfv30lR/YjxKfVAio1lR
X-Gm-Message-State: AOJu0Ywgg5hIEg39gEdCF02d27KYxxG/p0b51zSm0tusdYsM83o5HUiq
	TKGhpVFTt5Y/ojY9MWzLbE1YKUJohdBZQPfc+c9HJA+j2sYg9Wv6fB+DnAV2EYoUroi0NpC+HiM
	=
X-Google-Smtp-Source: AGHT+IGTHC2QWXZRQO4gJ0793VX7ja5aesUujATsRoC5Hlxul/gYz9PU7GfQvoK3IF5jsveTUHrAtg==
X-Received: by 2002:a05:6214:3282:b0:6b0:7c52:ae4e with SMTP id 6a1803df08f44-6b07c52afd1mr26693336d6.24.1718047081987;
        Mon, 10 Jun 2024 12:18:01 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06e66ad80sm26224546d6.129.2024.06.10.12.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:18:01 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/2] media: uvcvideo: Followup hwtimestamp patches
Date: Mon, 10 Jun 2024 19:17:47 +0000
Message-Id: <20240610-hwtimestamp-followup-v1-0-f9eaed7be7f0@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFtRZ2YC/x3MTQqAIBBA4avErBNUSqyrRIuyKQcqRfsD6e5Jy
 2/xXoKIgTBCWyQIeFEkt2eIsgBjh31BRlM2SC4rrgRn9j5ow3gMm2ezW1d3n57JSjemVkqPUkB
 OfcCZnn/b9e/7AfnfBcNmAAAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 HungNien Chen <hn.chen@sunplusit.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4

The series 
https://patchwork.linuxtv.org/project/linux-media/list/?series=12485
was all merged but one patch that Laurent found a bug in the index used.

When I tried the fixed patch I found an integer overflow in the
timestamp calculations. This bug can be triggered with slow framerates.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (2):
      media: uvcvideo: Fix hw timestamp handling for slow FPS
      media: uvcvideo: Fix integer overflow calculating timestamp

 drivers/media/usb/uvc/uvc_video.c | 33 ++++++++++++++++++++++++++++-----
 drivers/media/usb/uvc/uvcvideo.h  |  1 +
 2 files changed, 29 insertions(+), 5 deletions(-)
---
base-commit: ef1e48f725d30cb18d3f2d40c48f50f483080cf7
change-id: 20240610-hwtimestamp-followup-2489c5668b21

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


