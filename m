Return-Path: <stable+bounces-211866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJxFLubseGkCuAEAu9opvQ
	(envelope-from <stable+bounces-211866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:50:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F8697F74
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3576830182A2
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA366362129;
	Tue, 27 Jan 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMSbe1ef"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B79435DCE6
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532634; cv=none; b=cNid/yL6y5OLIuWaI11bcngkcmNOZUAcQlyZjxXlH51dLhflerTkQgqFaZ0MEc+x25obCGV46RxdfrSU3sYDIFPyb5pUYQYa26UVndpx7YOjn1vzzeZldTtvhFvzO1dpwoHRulXdQxNsZidh/11NMKMti5rG+oVknZLKjxS8moA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532634; c=relaxed/simple;
	bh=aEx3pLBj8gvBTEDpyhyp7pqHwhzZ8IHrcrqz1f12G78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ja0YiJmC2uEIFAnUPvS5p/47d9UBg3rVOQPNhK8KzuazrcSJULqr7N5f+WFxCtZXOJhv7Z9Nj3zBqtDE24/ZKliKE6YRMKiyex4J/PkIPuITF81Mx3tXtJIY4IxFX16nHNphT1S8GWg6UNNZiTz2IkYCOnQZdtIPlUqwCKGGalo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMSbe1ef; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29f2676bb21so58859655ad.0
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 08:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769532632; x=1770137432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HFUtSxTOqds6zm0elI90Vt4eXQm0HV+4Gibl436HNNU=;
        b=WMSbe1efUxlmBC/tnU21vJTuWfsil+HIYKpxT/azzzuEmIcyfPtyjQQlsXwyuyBuMM
         p6ccEVf6oRO0FQ2l+h4sKqxCzvXfQkNt8i+8RBOxzcNR8Kj4uvR3gq79slGU1CPD1zRO
         eHWkSvNm3KXveMrznxiaTQ2d55fN0xzDEh2II4+fOdQPbf5xfBIsNS9HXjAjc1US/zSv
         PNIQNaRB96TJT6nD/YCGnEmwAjbqg83IEyKHf79zQRldZ1DYZxJ6LASW1AaQiJq9xFD/
         BzzRsczNQdjp0JhVSKRPPqG/zqE/NMmfPu0Q+t6iYPI7Y2q5BSM+yCqr+2unZVKtlvfL
         bTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769532632; x=1770137432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFUtSxTOqds6zm0elI90Vt4eXQm0HV+4Gibl436HNNU=;
        b=BA2VMReXgsn/qI87ts+bhNO75YbrayN9qlbrmpLfH7+PpMmpfPVrdKXFifR6ozTx5u
         AJ3jSB6fJZ3kNHowVupuyXIwoWuC0scDsQuRWLsh1EO89WtA1Cwvdv5vJ8QpuWNiNu0d
         eT2yB5F4eGgQAdOOQ+Jqgx8ArSBgfXwTF6j9e4EjnLpPF1aJb1V3q1eT1ILej9My+A81
         twsCyPEHc4vOae4OE/HOVBvofPsbzmIGUQJNR9kbKCoXGLhktVIprcVk0LcSI3vW9i3z
         /fVJ3m0oUO8+9hTu/Hm3OlUYS7KDF7Swb9z96D3kfUYhktQ3IKRZ3r55BL6qJSbevJj+
         9gVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7cFKx+dQyMUzHB7KVq2NcdmFOnv2TJ2/IReS8yXkkcYvxV/JgT1E4/NiqYv1K6ASSL99S+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOWyie/EzlHH2RnMyY57K3fIzyy9+B7tCzq7vrTONrLtw/P2N
	RyPka1/3rHrJgHMUXdHiGnfoiVx70zaoFnue1DFQdEli07WYdhdNcShw
X-Gm-Gg: AZuq6aLbZuk0I0BvvrIMJcXculaIEepsoMOwhxRfT9W2c3v4PmPpraj9LLayeFS5Ak/
	BjVDQQ7woXEzOP1JctTndxu5EhZeXrIkZ6YS+Y2mOnOr7D36WjhXMfXXvBhpbvxmg9UmMa812Ur
	3Eec9mQAAktpeO6Lsz8nfUnWJ51lLxE0WYnwvWxFYcNQuZCXnUIMTQ5GL33mdqmiMEeeN2E8C5X
	XEzmKYUvHB1+irvK9UKKH3ypMG+mzEhmFQFnAB2mkefTrgSe+hGl32tOdZxRngxgC/ql4Qm4P6E
	IlaY5PJMW1ZGyclVOkbAHCs2L68y55skx215HpW+y6/vKMfsfJkuE7HHuC9P6fm6xnF659ms6jF
	pPnKhKTY6EIYDigPqYlAIOh2IBDGnEr0r9zfO1aAwofv/NnoSL4+jOjTrGxZp7BYBhxuEM26VCO
	b19EXp5A10BoAwYDgEzrBIo8DSgMgYVtdtO5g=
X-Received: by 2002:a17:903:1b10:b0:24b:24dc:91a7 with SMTP id d9443c01a7336-2a870ddda67mr26361515ad.45.1769532632328;
        Tue, 27 Jan 2026 08:50:32 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:d29a:ea37:2567:751])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa46fsm120318675ad.21.2026.01.27.08.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 08:50:32 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: linux-media@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	rfoss@kernel.org,
	todor.too@gmail.com,
	bryan.odonoghue@linaro.org,
	bod@kernel.org,
	vladimir.zapolskiy@linaro.org,
	hansg@kernel.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 0/2] media: i2c: ov02c10: Fix race condition and power sequence
Date: Tue, 27 Jan 2026 22:20:22 +0530
Message-ID: <20260127165024.46156-1-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-211866-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linaro.org,linux.intel.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36F8697F74
X-Rspamd-Action: no action

This series addresses driver correctness and stability issues in the OV02C10
sensor driver. It fixes a use-after-free race condition during removal and
aligns the power-on sequence with the datasheet requirements.

Note on v3/Brownouts:
The "Autosuspend" workaround proposed in v3 to handle regulator brownouts on
Qualcomm X1E80100 platforms has been dropped from this series.

I am pursuing the root-cause analysis for the regulator discharge delays
separately. The platform-specific constraints (2.3s passive discharge) will
be handled via the regulator subsystem (linux-arm-msm) and device tree,
keeping the media driver clean of platform-specific workarounds. I will
continue investigating the underlying physical discharge characteristics
and PMIC status registers as requested by maintainers.

This v4 series now strictly focuses on generic driver correctness:

Patch 1: Fixes a critical race condition in the remove() function where
resources were freed while the device was potentially still active, leading
to kernel oops.

Patch 2: Corrects the power-on sequence to strictly follow the datasheet
timing (T1) by asserting the reset pin for 5ms before enabling power rails.
This ensures the sensor enters a known clean state during cold boot.

Changes in v4:
- Dropped Patch 3 (Runtime PM Autosuspend) to separate platform-specific
  regulator fixes from generic driver cleanup.
- Modified Patch 2:
  - Reduced reset assertion delay from 10ms to 5ms (usleep_range 5000-6000)
    to match datasheet specs and maintainer feedback.
  - Removed the software reset (0x0103) and extra regulator delays to keep
    the sequence minimal and compliant.
- Patch 1 carried forward with Reviewed-by tag.

Changes in v3:
- Superseded previous "pipeline lock" and "brownout" series.
- Added strict power-on sequencing.
- Added fix for use-after-free in remove().

Saikiran (2):
  media: i2c: ov02c10: Fix use-after-free in remove function
  media: i2c: ov02c10: Correct power-on sequence and timing

 drivers/media/i2c/ov02c10.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

