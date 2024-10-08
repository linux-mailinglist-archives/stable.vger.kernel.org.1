Return-Path: <stable+bounces-81527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A343994067
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41181F268EA
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B74A1F9A8E;
	Tue,  8 Oct 2024 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BaGPzpUi"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18821D54D3
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371180; cv=none; b=j1YHrKHrh86DPFOiGaYynhiEZ0IF6B4V+k4sJjmxlwg92g6V2zQV44vqhOBdbLELZ/mvqTlDsbv1poXfdBB0UaCkeo7ZNwGtqlCU6gPd4xAjksR1WMWQSf3YwkilPOgPk5aerQZDPWf5aBOvkR5FjEMsIjnr7E6mGevkb5bxR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371180; c=relaxed/simple;
	bh=H+geuf57kVocWSPbWf92D4pkiMUajwoEqTqIsmSA53c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RRaoQ8tzzsnUOJSEM2RmMfQu/QLoKdT59wxwPei0Wmwifs2s4rLh6cNqvR9u23NL6mI8GY7ShU0N2YwRAoEKGgF4LPVBHegazC2K9gnJO0eL4h+gpsb5if8u/9R/RhaiP87T3bglti7iDA2G7sbW2oWUsD0b97IyIMormKxn3vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BaGPzpUi; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45d8f76eca7so54435331cf.2
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728371177; x=1728975977; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TsZBFSwMT7x1FLd0qN3fP1nAhawS9beuZBZhTUuWxl0=;
        b=BaGPzpUi/oIMI4+Qs213dlM0XfqbzPknBBk6MFB97qvb064Y8RM8p7oe2bnjcgiJg9
         kdjPRTkXGYavnfTdy3f/Ok8KsbQtv5ZP+3m8pk5q0BrMXjns6stRitjvSNhq7+aSk/Sy
         cJIE8RwXsOJNxaBwJbQTbt/4PAEiWRnroPLZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728371177; x=1728975977;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsZBFSwMT7x1FLd0qN3fP1nAhawS9beuZBZhTUuWxl0=;
        b=iI1C7sgYsRoxsdEC5taClS8/CqT/ngr9BkBlEK1CBs7m8MaiyeQEtOngSn7C9ACcQr
         jui5MxitoWAT+prvFFqjfRdmB4kpS5btccbI3Cgkmqp2kjLR7Iq75IC5ga8VcySjZAwN
         TSbBnodOhIj6II71Bg177MGffpZK/kch6tE7SBQi6b6EIPyVEQ+SA5wlEoTkazdAcOzQ
         slLh2JQuo2DI/lFG2LU2DmFZflAo74GfMmIYRe1O6VTnquKw4qqUjvcKEuavEsjMOB14
         eX0425Bugml/VxCwUT27V+Km7pzV+PUvTOrZZ5i7/D8FlCRrKEzmoqODnazZJ6rRD8F7
         0kUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjdHuMxpFUbvmjDwkuG0OPWGjwWhWWDKzWFuJqn+91ys7YMCPejb0dQeSttMf3JmH7rk0zYok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA3hYwCGzV0tsUJPuXvSWll66rZjW25ZZSpsZYlEShxs1JM2pg
	qrK5SbndhPzmBYw06/YsS8nYqThYRR5LIqcNINgvHo8YLt++umXWnKlLU4xqVw==
X-Google-Smtp-Source: AGHT+IHx9p9tIVNfNz7+zbY6K/yGm0H8IQgkQooFDPYNa5377HZYiurQcINypBPsFkW86cXRYwoTvg==
X-Received: by 2002:a05:622a:124e:b0:458:3cb6:13cb with SMTP id d75a77b69052e-45d9bb47d37mr245733751cf.56.1728371176699;
        Tue, 08 Oct 2024 00:06:16 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da764043esm33801921cf.88.2024.10.08.00.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:06:15 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/3] media: uvcvideo: Support partial control reads and
 minor changes
Date: Tue, 08 Oct 2024 07:06:13 +0000
Message-Id: <20241008-uvc-readless-v1-0-042ac4581f44@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOXZBGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwML3dKyZN2i1MSUnNTiYl0j4zTLJIvkxBSDJGMloJaCotS0zAqwcdG
 xtbUA3vPO/l4AAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Some cameras do not return all the bytes requested from a control
if it can fit in less bytes. Eg: returning 0xab instead of 0x00ab.
Support these devices.

Also, now that we are at it, improve uvc_query_ctrl().

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (3):
      media: uvcvideo: Support partial control reads
      media: uvcvideo: Refactor uvc_query_ctrl
      media: uvcvideo: Add more logging to uvc_query_ctrl_error()

 drivers/media/usb/uvc/uvc_video.c | 44 +++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 16 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241008-uvc-readless-23f9b8cad0b3

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


