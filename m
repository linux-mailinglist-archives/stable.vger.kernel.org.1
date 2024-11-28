Return-Path: <stable+bounces-95756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF809DBD16
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 21:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9789281C2B
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E551C3045;
	Thu, 28 Nov 2024 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K3jI/5hp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616971C2334
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732827259; cv=none; b=XONt6WOXRnb+11sRvyo4CoqqbGttv1cB5msHckFW3kuWXbER8YRKU0H3ux6vL0hZ+b6j1QnogR/u2/b9UquVHbJwA+QrEShflSTKrJtu1PGyOKlcJheMA44SX8R9G4Fd6yJ0fCXr68r7DDIQ/5fp5MqWKsSg4JGeultK1auFJRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732827259; c=relaxed/simple;
	bh=FHu7xsPNIFx5yEIyoPkkng/BvphDpd2Y2mvhSZv97MM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iyevth0yeoY67SLYeNcJYfrMHJt1pGFDXaO9WwTkbEQfzPW0ghLOBnZsd5CcNvk855Go+Zkwxs/Br4Ref0A7sW3kIDq52LOjz3qGVPbKuWAk4y+FV99/wA+btwhcndgp07JmPv9Slq+P4LEveAfRLfpos6Qxd5ng8++VWOC6cuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K3jI/5hp; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4668f208f10so8186411cf.3
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 12:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732827257; x=1733432057; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1xCF7LNbFLYTpKldHQ+hspxekaIZZtHO9TlcY3bVcA=;
        b=K3jI/5hpU0eBHytKNPRLKOIQEYQDHAkJXq8JoWQrRuYhc0ou3265l50EveClD8Rkuu
         9uQnvu8TY3qEArqzn/BzHOEa404vJQG0JpTGIY0byHghb+DfUqnqexydybySPls5MTpX
         eJP+bm6j5l7GRyiOt2wqzveArGeUvkPHaIExc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732827257; x=1733432057;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1xCF7LNbFLYTpKldHQ+hspxekaIZZtHO9TlcY3bVcA=;
        b=CG6QV1BklocW8mgTrezdXcnoXxSatynN9ia0WYXDoR4l5LkWHyAeAPtE3ip6ABXIXW
         jwMB3SaM65pKcUzXHylqGDKyFttx4rfVoEVILI4CYxo1/plAn4NW08I2ItIqrPBK2pyR
         KXTwvs/y5yqun77eHBoJ9Y9cvv4Rs7JTuCZBv/z9kh5bMoxpDiGOSfWtOOI3nogOuhnk
         4pRP0tM/8mro2mtSu/ohJOWkRXuUtPBKH3iTWLNQ2TWw9Yi9kAWMJfCYqyz9yGU5OH08
         w+bIeQb+f7mtUgtB9emgvEmCO1BTi/elflAMNOjnMIfyTNd83FBu+tOxiO/VFGKt4uJB
         yY3w==
X-Forwarded-Encrypted: i=1; AJvYcCWmOj4VDsloiM7/uTZJOjPbteV+tbSIkdsCRJyHBCAnDG/GhgjIchu5N03qe0iCOwNFWaAEiOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6y1mmGAt8IPh6rc/rwxyp7N42ysaEecKprOWwPe0GetnmNZv
	br6fnNXt8v8J+TETroEhUY9C2oJaDw1zbmY5H7SOzdT9nUe95WhMJjsFCwVPUw339PZoQnV3q+Y
	=
X-Gm-Gg: ASbGncuU4DuKSyY+Yc4jjstNwAxSFK1y1q3oonMokTbpjviMLLDK3o/IB5Odgi6vgf0
	ApLP8obutqmREVbTWqGiMxHtDjvfxKIpfvoy2uDZtoya/NCdcK38mdgKb1WDjJbGfVuQj/veYBH
	4DOBzXe82FiSzRfawsPV62OQZOeMDdbmI4KKKALkAhfiqN6jd0jyWMYOiuZoiLCQoUALwVcbHuU
	gbvtIket0/ffXJ1oMeNxEWkBJk8WgYpLGzeY/Y2Ag8XGl9b359Ch2Pbg+I2ESMUXA8BuvMkmIz5
	by7tYahdyDterq9svnx56hIJ
X-Google-Smtp-Source: AGHT+IHRpN6NATAmbciIyy05yWURRecQ9xopikH3OnMGV1553UEz0YTGxwbOrQhhCSSQmgCEPnswmQ==
X-Received: by 2002:a05:622a:180e:b0:466:a308:292c with SMTP id d75a77b69052e-466b359e2cbmr127726571cf.32.1732827257019;
        Thu, 28 Nov 2024 12:54:17 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c407e6acsm9923421cf.52.2024.11.28.12.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 12:54:15 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 0/2] media: uvcvideo: Support partial control reads and
 minor changes
Date: Thu, 28 Nov 2024 20:53:40 +0000
Message-Id: <20241128-uvc-readless-v5-0-cf16ed282af8@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFTYSGcC/33NQQrCMBCF4atI1kYmyVRbV95DXKSZqQ2olUSDI
 r27aTdKqS7fwPfPS0QOnqPYLl4icPLRd5c8iuVCuNZejiw95S00aFQApbwnJwNbOnGMUpumqkt
 nCWojMrkGbvxjzO0Pebc+3rrwHOtJDdcfoaQkSEBtHRalahB3rg3d2d/Pqy4cxdBK+p/Xo6eKC
 mWZi/WMNx+v1NSb7KnaOGUNlEgw4/HLa5h4zB7XG001N4Zw+r/v+zfYVY0OawEAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Some cameras do not return all the bytes requested from a control
if it can fit in less bytes. Eg: returning 0xab instead of 0x00ab.
Support these devices.

Also, now that we are at it, improve uvc_query_ctrl() logging.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v5:
- Improve comment.
- Link to v4: https://lore.kernel.org/r/20241120-uvc-readless-v4-0-4672dbef3d46@chromium.org

Changes in v4:
- Improve comment.
- Keep old likely(ret == size)
- Link to v3: https://lore.kernel.org/r/20241118-uvc-readless-v3-0-d97c1a3084d0@chromium.org

Changes in v3:
- Improve documentation.
- Do not change return sequence.
- Use dev_ratelimit and dev_warn_once
- Link to v2: https://lore.kernel.org/r/20241008-uvc-readless-v2-0-04d9d51aee56@chromium.org

Changes in v2:
- Rewrite error handling (Thanks Sakari)
- Discard 2/3. It is not needed after rewriting the error handling.
- Link to v1: https://lore.kernel.org/r/20241008-uvc-readless-v1-0-042ac4581f44@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Support partial control reads
      media: uvcvideo: Add more logging to uvc_query_ctrl()

 drivers/media/usb/uvc/uvc_video.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241008-uvc-readless-23f9b8cad0b3

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


