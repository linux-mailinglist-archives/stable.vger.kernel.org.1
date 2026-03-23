Return-Path: <stable+bounces-227978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Pw4Dy4+wWlaRwQAu9opvQ
	(envelope-from <stable+bounces-227978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:20:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ACA2F2BF7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1993C3040310
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D563A9D88;
	Mon, 23 Mar 2026 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M8j3aOwK"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FB438C431
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271437; cv=none; b=rTKw8OPko4cDOB1FZWvTdXlik7sffVrygd1OxQXJHwAhuzHD0pzUijWT+EueufQM97Mak41ndR0K/zu4OYVRPcG8mzw3CDPJrw5jOikwGzBFUjmEWR7UM+4hW2vGgcj2PCsg7L/Ev6F6WuGlcsiUEfSc68NtuWtWYHcLT4ebHSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271437; c=relaxed/simple;
	bh=ut4EjWQWHi2Ya+ADlwmr1k/l46CAguc9sBmTuYJuDxM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xhx+BejtFjUgZkVtdOX7ajO5/L/DP+nsr9LR4XZwl5ZD9gqqpiXp3LAglEK5Rjvne8JMXlUsdGPjzdRGxmjSQBsMvMBHZGfGl5fMSMnnhyGHDPV3vwidb4QCU7mTXdlmws1h/bFu3daUHk6bACpdgoJZozVVsk0Lw1XazlFrXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M8j3aOwK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a12c310e8aso2828160e87.3
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 06:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774271433; x=1774876233; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qnsMyVmCtM1pLUefAOh/O2M1WkfX+KWuLgI1EM7KbQU=;
        b=M8j3aOwKWOeR37B10cizWsFRP9CidkvmtRPbUCX2yuDf1Z3Gy2CCKlhO2vTTBwzxsP
         YnKK7YX1TgX0rI8ve56FcdOmKbigzZVFBOJvjNSndtLysU0mUx+TKs/3Pcf0fxTZ3ggc
         Mjp5G4ZdBwg5jZwgHyEeobREt2xQOzS/WARjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774271433; x=1774876233;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnsMyVmCtM1pLUefAOh/O2M1WkfX+KWuLgI1EM7KbQU=;
        b=n8OmEz/mXzm1kEEZ6S08tn32ZZR/3m8QtTpnQeU8agXHCpZteppdbJD35qimtls79a
         04D1rAuSDoO2paT05YNa+oEbzqxCBozC/YjMyg5l6PueGE+uHEJGUDFxTZeUsl6Nonsq
         IMvMoAnAlqUPvQIH/puAui87CQvZhiT/9pJA53ay4oak63YpGnuzEs+0oy5ZWaRygrqG
         4fl0jdaw8CwPtrTmvzdV8ysKXCPxX3dOBmnh/BdFycFeuUsTa88086q7T0iPJmnLEGOP
         UOTKxasxIa+5z6QXnCqXQ1BDPvSGGyvinAoOA5LmxFZvGEX+5AtGJMUlJxM1IQfa/0XE
         9YWw==
X-Forwarded-Encrypted: i=1; AJvYcCV1nbbFKXoeji79zbRShgV2OOs1UuWUzsUdFx5HMCay92aRAcpBePcA7Llr5MzjHZH/Snl/7FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVt9wzXSePAa3W7OUa6mMl2KJ0yINxOkwpbA8OE2JadW3kk9w1
	/YOHzSzExDaS+VbhmEj3DSTrXx8LmgaDQkbJLaWoQB4AqjiksLYwXPH217MzzryjCQ==
X-Gm-Gg: ATEYQzxFUuUTuO8dgKk8yzPrAVoYUQYKKw7IqfbmUTfnDKgFa4mBNuKNJk4EBc13/X/
	+zlKaG6Nd+JaTHStjOtpxcwIgk3HzfQ7HqShpac6uPqq48ihqrMmG39Mipn027KGp74IjNNI1+b
	cmWdzcVDrWj01fxM/IMPmRQhOFjpj0mJm0hmEVhcclqlA0Kyjib26YRd+fNQ192vSCn+obayR+8
	ZByr6qSNhxcwTrnhnzwRVduwwXGSloNh8Asl4umz53hmYTx46cWla5aSWCrz6o5puVGwpbRU8wF
	sj05fSsn4WHYqa2CZfHltLlXvjuju6yinUQlwBOiSEdZn4wyeeWF1zyBylIKeTLK2O4EUDqjYri
	BjdoapfOrx1pXb3kuU69yk6FLWHIsxAUqHAzgCReMBn/fRndzZn3NY3qrrvW0/wjD2ZoyHz4pC9
	T6uVlbILC95CMvKmaD4ovKQzolKZzDNb5vWUAe1Ypp09HImzscgnlMs6Xn4FUx/59eFxfhgjaX0
	hgvlXQ=
X-Received: by 2002:a05:6512:63d0:10b0:5a2:86a6:8c78 with SMTP id 2adb3069b0e04-5a286a68ce2mr2847366e87.28.1774271432909;
        Mon, 23 Mar 2026 06:10:32 -0700 (PDT)
Received: from ribalda.c.googlers.com (252.116.88.34.bc.googleusercontent.com. [34.88.116.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285305e07sm2515904e87.66.2026.03.23.06.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:10:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/4] media: uvcvideo: Fixes for hw timestamping
Date: Mon, 23 Mar 2026 13:10:27 +0000
Message-Id: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMM7wWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNL3dKyZN2M8pLM3NTiksTcAt00I9OUZCPzNFNzQ0MloK6CotS0zAq
 widGxtbUAl1iBRGEAAAA=
X-Change-ID: 20260309-uvc-hwtimestamp-f25dc27f5711
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yunke Cao <yunkec@google.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227978-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,chromium.org:email,chromium.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7ACA2F2BF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series introduces fixes for the hardware timestamp calculations.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (4):
      media: uvcvideo: Fix dev_sof filtering in hw timestamp
      media: uvcvideo: Use hw timestaming if the clock buffer is full
      media: uvcvideo: Relax the constrains for interpolating the hw clock
      media: uvcvideo: Do not add clock samples with small sof delta

 drivers/media/usb/uvc/uvc_video.c | 51 +++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 16 deletions(-)
---
base-commit: a7da7fb57f2a787412da1a62292a17fa00fbfbdf
change-id: 20260309-uvc-hwtimestamp-f25dc27f5711

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


