Return-Path: <stable+bounces-95593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C760C9DA34D
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 08:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD66B23917
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 07:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B715575C;
	Wed, 27 Nov 2024 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gdZQeIuM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F25153836
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732693583; cv=none; b=NhkHNHupPqebbpiV8k1+diDxmToczN+NYLnOcnKbbfx5q1z9Sy80f5Zgy9jjfs6aExUwXzKA85lTqqB0AyjyEinghJ6ESMJiuX1i/KxU/HQT43j7EY1c2dYnCTIQOPLoaWXoy+n7qA4PPDxkWDdCcJBvPduOlCIgwkV7MwqbjWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732693583; c=relaxed/simple;
	bh=NFub0nakpRsmq3bNjhBqvGXTini1GDnZAkDIKXX8OzQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pbDeT49v37j9wZF3LCJ9KoCwYy4pv94KXVmy4rpzfswKgANJMLpAWnOy/1aYeMwvROmKkcYEH6/O/dLg3K5FkGeHyRS7hneWdTToL0146HZd9Umit9Y35vlVcWjYAx6/K5vSuwH8XdVunxA4cF5Xqvcl2p6LB4qbzICb2JW9Xvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gdZQeIuM; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d41ec318eeso45307636d6.3
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 23:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732693580; x=1733298380; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yfnG/mg+dg4mMvgmniivU1lb5hziEpjBC3xCnLCoRuk=;
        b=gdZQeIuMgQD8vrP7FGys56i+dEE8OG7OdgvS6gSbCgKOPu9VTX973eS2tvadi4T1R/
         8981o6wPcUi5fDx7KrR0IDByy6dKG3hDZ6O5JG5KpxizXluD9bkJcqAElajB1d+WMCYL
         9317z0b94fGI5EBfnZQgNA1YDqwDN7r5YCRcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732693580; x=1733298380;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfnG/mg+dg4mMvgmniivU1lb5hziEpjBC3xCnLCoRuk=;
        b=EOZGwXeuXVMtXlxtWpq8M9K/X5qDrSGgGhUj7FaKTY1sgt/ItGKm/BgaURyzYgk4Um
         SoeLpEiFn8HYjIhC6hTMgwEnidDrcyokzulYcTx/P0bSAHKKObIG3DXS/5helWAsVbxr
         XiLIi4fpBXzLK6xOExFBoZ3nVCSnbsDWWsgvxoXFm8vYwiWEZQhnJv4YQ1c7mx68HQNn
         JNEQKoNuObBM/wMTcmGx5TZVFJP7IxE13qpZ84LTyqZQAgRD8unw86SP8z5n9Qj5zd2i
         FWUBFgFUnP27itsiM1UmGMKdlo/vZCro4bnLctD+tUh4WO0p03XSs4T6+eemq8PRhUGw
         SPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqzWFRgh8adfQKZQXPfNogj5kxHNZ9afr4NCnDN02QOHkvF5ZUfO5/N+LsyObgbYANa9V9Mog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwD4NeuiWXidHGI6toYpxP+aqCx7ol+LLApMP/G/0iAr/yIA/
	KjTCwT6VLSW3V0BJcfW2LPwXgNNiPSecziM/1mcC1lSSra8ebhKZ55XKH0Pkuw==
X-Gm-Gg: ASbGncuzp2+C8qpt5wdLvBlUvEaTs9mPzbT+ArMHGCRjqKScPIknLTWVe7tM3zMmA3z
	NOXNgkivP7987H51uSIpliCpedbbGwNB7+ijxHdxSZwRHKI5RTf/tY8xAVxH4o+Hdw3SZkECJvq
	kog6hI68+AnXHibGNP3d/2J16KdN6JHHictmXAkbi7MwTKbPrg7eNTDpIHq91XBO79oaKcjVGYH
	PW1UN39tstZCHZhaO9fD0rXzqxVkZ9XYbD9kanpcGbn4tY6yOXC+EXOdLDY61rBUHTM4fXGM/zu
	Ih00cGR20pbBuCb184W4Rs25
X-Google-Smtp-Source: AGHT+IFfysEFAbHgZfaCoTo0H1CGxOVMO96onL+xqWkZS2/t9cNT8T6LeiMB0S6UXRh7Pn4PtadAag==
X-Received: by 2002:ad4:5cc7:0:b0:6d4:85f:ccac with SMTP id 6a1803df08f44-6d864d3eae0mr27270796d6.13.1732693580498;
        Tue, 26 Nov 2024 23:46:20 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a97b1asm63750386d6.40.2024.11.26.23.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:46:19 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/2] media: uvcvideo: Two fixes for async controls
Date: Wed, 27 Nov 2024 07:46:09 +0000
Message-Id: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEHORmcC/x2MywqAIBAAf0X23IKa0ONXooPoVnuxUJJC/Pek4
 zDMFEgUmRLMokCkzInP0EB1Atxhw07IvjFoqY1SesA7O9z4QZve4FC7yRtpVG/9CK25IjX5/5a
 11g8rh5jVXwAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

This patchset fixes two bugs with the async controls for the uvc driver.

They were found while implementing the granular PM, but I am sending
them as a separate patches, so they can be reviewed sooner. They fix
real issues in the driver that need to be taken care.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (2):
      media: uvcvideo: Do not set an async control owned by other fh
      media: uvcvideo: Remove dangling pointers

 drivers/media/usb/uvc/uvc_ctrl.c | 44 ++++++++++++++++++++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h |  3 +++
 3 files changed, 47 insertions(+), 2 deletions(-)
---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241127-uvc-fix-async-2c9d40413ad8

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


