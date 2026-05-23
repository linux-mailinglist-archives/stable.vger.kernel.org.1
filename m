Return-Path: <stable+bounces-253891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCx0GbY2EWpeiwYAu9opvQ
	(envelope-from <stable+bounces-253891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:10:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 027655BD3D2
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DC5D303FFE2
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AD32860B;
	Sat, 23 May 2026 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeoP6MnF"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC83331A63
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512809; cv=none; b=gk9XKc501Nt/EenAIFbk2PZMixfN3S/iHbJiHYu9xqblSA/Xn0mZ9yL0dUPM7MyADwyZBspmFn1o7fviB/LdY0SQc3QSSbEdYG9zewhMK7wiMfY4gczTV0EYwkwPZxkFpLA/46et59jxThOdWoQPFKYhGqSHvyXUrmLsh36c2mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512809; c=relaxed/simple;
	bh=eYtv1lkT9JAScsMqNpsnBxVKcem9nE2s9ZDyYN1kMoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqsBGbnMYHDy3AWuIPxO4NvYlKEGJaSL55viGf1TAIXuvgXSBsniN7dZydsPn5jKiADuTvdxNPb3R7pUZ6Ly9Bhto1Wf/paU+fnxWKvRnVdZm9WawSnoZkGOJKGWP3qXHB4TkcXRuRGUxvj0nPAZKC8Ib8sqdb6ijoe+rdWvoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeoP6MnF; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3025d725a05so19112192eec.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512807; x=1780117607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFO8Uu1VVSz//xwzZEbkB241DoN8aKb8CDZkxNZZvD8=;
        b=oeoP6MnFHyyAeujPYmJidup4ff0OX3fylPp+YVIjNrbriZaeinYH7KKhBp9ny35JZ9
         orWnlIbNeckDTptZOlcEpweR2tVoNQUADzCAYjSx3CW8wAwpVFeBJbvSBQVZchSIf0ul
         qb413QzkKAHVzOC7XBE1VY1yrs77olYE4O/Y/afBBapuoY2AH6Lt8FP/kkN6vLnfNIDQ
         oNSnTFTAk7T/al09SJ694F3CJTC58HWhwBRZF9SF3JhLaauDnbi/d3kkvmd7VJRJhdxr
         te9WVuNWiPoq778co9VI3mzBRi/ABk7aQi7ZFmj6NexWxs3sGiS1pz/BDNRjV8cnyStU
         4wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512807; x=1780117607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dFO8Uu1VVSz//xwzZEbkB241DoN8aKb8CDZkxNZZvD8=;
        b=GZP1yMYNvnv3TJYqDI04qzr1obKBTORDe3ZFc8Klk00v4Em9SQw3TmKLDDu/0UIHp0
         UUzt5UZ0LmjgjRjYrSHTKZXeM+JweZ4hovUMcpsyLtjqFgUt/EXd7G1K0EEWU5Uw2PVE
         RRfwrQ4eoEM/NxkYmFvNq2fVyW65FjATQJJIspsPCIpR4769X4pc5WpwmgjJj37a/8Kb
         pqmryovqJSM0Ezv6EqoednglhsrGcvE/Q/icJpvB19la38Eh7oftKCkShsGVXZSJ0rEW
         x3U7ltvESk4GSjTy42Aj1lAD51EkMyU8gI8bbEQXQlrSiqqlXJnsEiOb2jdMeLFMbnjL
         YSNw==
X-Forwarded-Encrypted: i=1; AFNElJ/OmlGQUPAIWsHq+7BF97hrloRxQhqik/97gVTNPuABJaqCssPtofOpNb5DyuibcynRRPXa0yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQHlZMt9MXjCCg/stIb3//aVeD0RpYM22/gsRL5ICkCZV2n4v
	RRIOPqgWveRjD+pecdfwn0S+4e+qRnK2ArL9s3TGNWTyVSCQSkhq8721
X-Gm-Gg: Acq92OFY+S3igQVR6Tj5DLCJPDnyXfiTCE2IIIRRoG3714FbqfBAYZbXc03bt/+sIU7
	MitOgMPDfWynci6hr1gxnRe/OJ6OAA5O05LtGPRifZUf/vhqNYoKMjOI/D15tYPdN7BcuFVQEM8
	HvATdAJpxyL5lRKuhxYjD/VBP86z23uRUpr2LhE+d+QkN+N46PFNlPcon1Hy0eZkAyEYR28xFCp
	zEowiiEnfViZbvKyDhKQmk5SrEoHDKBl2t8Z8BBfxUZFzZ6dB48xa5XjksnEFbwlU9DgY7N0oY8
	G8+fUIVV9AXUUwnt+V7bEgghzJ09KQGIsmyvh1x2bjAdEyJrRORfsEMEZ588lMv5WyCFyfo9IRm
	s9jY1fxIYRM75Tk5ZJzodQm03S/EbGCmJ0Jdt6KkvGwv6342Yy2KPaPvt5/130nPtgbuw1LdgaA
	SzTBw3gCPc4AqnH58VFQ39ZRQFUvb6upbbaYWhJ5R7gEznxNp8ICUPdy4xjlBLP9HoOOyl9c9Ay
	fIdsuys3ujdzw==
X-Received: by 2002:a05:7301:2b06:b0:2d9:6373:ad10 with SMTP id 5a478bee46e88-304490383d1mr3310920eec.7.1779512807127;
        Fri, 22 May 2026 22:06:47 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:45 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 05/11] Input: ims-pcu - fix race condition in reset_device sysfs callback
Date: Fri, 22 May 2026 22:06:23 -0700
Message-ID: <20260523050634.501509-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253891-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 027655BD3D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ims_pcu_reset_device() sysfs callback calls ims_pcu_execute_command()
without acquiring pcu->cmd_mutex. This can lead to data races and
corruption of the shared command buffer if triggered concurrently with
other commands.

Acquire pcu->cmd_mutex before calling ims_pcu_execute_command().

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index f86f9a5a7564..7fdff9dd1b5f 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1152,6 +1152,8 @@ static ssize_t ims_pcu_reset_device(struct device *dev,
 
 	dev_info(pcu->dev, "Attempting to reset device\n");
 
+	guard(mutex)(&pcu->cmd_mutex);
+
 	error = ims_pcu_execute_command(pcu, PCU_RESET, &reset_byte, 1);
 	if (error) {
 		dev_info(pcu->dev,
-- 
2.54.0.746.g67dd491aae-goog


