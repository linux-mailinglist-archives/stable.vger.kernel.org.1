Return-Path: <stable+bounces-244110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJtGA57W+WmDEgMAu9opvQ
	(envelope-from <stable+bounces-244110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:38:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 127374CCC7C
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 13:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C04DE3019323
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0814D386C37;
	Tue,  5 May 2026 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2RyVsO+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD29309DCF
	for <stable@vger.kernel.org>; Tue,  5 May 2026 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979924; cv=none; b=c0xPa6UoB/35CvFpjNivyNoQXAnz6faf0mUtddTSLKHJJVCID3Ez8b8faV5sNAkIdDZ/q1Lgoy5gK/DLmcsmHSVEC7neqkfTYktVd6gxJuH9FgOhXNAvlQ2/GFBr91otlQeuQ4M9Zer6VR6Pn2ZAZ5UnTvgL072Fi6ViVMJ9HAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979924; c=relaxed/simple;
	bh=goTqNX4LIT0yuiv/ihZXreJ6jCrxDpey8ywhTwK7eI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k3uZqOUERRyeVnZwZD6E0CeAUNrtVa6mhf8RMO6XC4Ojh+l2hp7Z7MQYUjrrYG9hzh4jiD+38aDUqmY5fmnGQfl9MDdaHjVp9aIjNsYNo3PnVU38U997IUuhFfqIUr64X8fm9WIu2kCjpa5uLSXyCgrgRumTThLAbBAN+TzDmLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2RyVsO+; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-130c9dcbd25so157085c88.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 04:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777979922; x=1778584722; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMDieuGvwMdUNo4lHwtE/hWCLLdhMWURBnkYQ/fDr68=;
        b=P2RyVsO+1fESbSzF5RBCsUh2CfR0+NVd0DEW7rvm5kWpCOypLxbS0TNzAur70qdY4W
         d9rLRGHv8PsDeoGf/thxF+Cv6ozHoTtdkJSIdDxCN9/C9ueuVwudieOig1oSD/gKSaz+
         LJV6vpdkhLIhwOVj/stgkpiwdRKqVc9IrZkDdc32AUmtClpATdPuIdfvtAWJroEkOKtW
         YF5mOQ2OVQ2Q0kdB6pfYJmiGDuGLLSyjooFuGgvLmlL7lRe2j3MsutuErnfMLWPXxWkf
         lyjQIJMo6cdAmqU+Wv9HSxTUX2Dldm75bjZL9MhMhDbher5Ng9vdIqc9x9nN4L0PwMRo
         lgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777979922; x=1778584722;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMDieuGvwMdUNo4lHwtE/hWCLLdhMWURBnkYQ/fDr68=;
        b=NmnSDLDdQB9f/DFc5ujwwYnZYqMa8CMA69vpPWGkGR5S8YUL0m8vdt/7aZtj8GwN0V
         bI5EXyVk7IAFKRSm/w9aRuS+6TFZHcENKcSddNQDHIOYEtLPYqBNpw8vX5PbZdNGt2Sl
         g5R+/TcrdAv77MyGeROnu+syleLdqm8xSV/fwobr1miBXs3A/d4y9+NpovlKJWBjh9iR
         WEe2Nr87woIlNrsg4Rbgo3uoufvZbMCu3Th6xqJMi9d7Y4v1if8GlY79rzpn2ihFMIWJ
         X52SbA0MOIPfZEo22S/EoyceWlSPQ+OO2YohqbbibOs46BbFIdMlb20CpakykqRqWXsb
         44xQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QPBX6inm60MUxtnbAWubM5LrjZ5pugfDJOUoLQaeO4n2jVDz9JWhzznl7DIOgreF3caoA9Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk15xzpfnibuuztaT0+szOO4/YFQg0n9hWmXlWmoJ74XnHCooe
	xeoWvIE+fF7YlkxerNy9VqMT0pna2HcG5opToWfgde735GwEzXdbiU/v
X-Gm-Gg: AeBDietrFYOABYAoMQ5kcX2SNN+ZYI38fiHyo5WIr6VDzAGY8H5uTVKaARoHyAPvu+7
	Psi4Moie4jtwm2X52EFhYxjSUtEbzv3/ztx17KqFEqbuGuiP6PX75ZzG4mXI1cdpXytq8K3dXBs
	yNHOseip7rCSXStEd3N3F7JPCbltDTkZiwUcIa120VZ8ZoeaVmkI0n4av8s44uhggKdHOYYSmC8
	7rpdEunq2BjuZaRC039Vyh9CLV6cR5l2QISleHC1uRy6dQrzs5Vx6dGZb7WJqluQrzw2uQK5rlH
	DtoXP2TjOq1ikv3Xw4fISplRFI43J39r/qo/UUqiaUfMDZVlD78VzWRK41dqYkFy6MGsqZcCGi7
	UxLguZzXNb6dVx+jHSN6TtanbzzKvcW6YpAaXbomUCafz7sYDPtCePe8ipVpJ1RnU1Uyfa1FA2b
	W+yCWYgvh6a32l4eWZLF0Xwwf9YgFxk7K3XqCu+L+iFmeeH7s4THRAONi1u1I/YrTf5vacLWTns
	Gpny1ThhWOM
X-Received: by 2002:a05:7022:22b:b0:12d:b8e5:5e2 with SMTP id a92af1059eb24-130a9ff69abmr1380445c88.23.1777979921750;
        Tue, 05 May 2026 04:18:41 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df828849dsm17247290c88.5.2026.05.05.04.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:18:41 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Subject: [PATCH v4 0/2] firmware_loader/ALSA: Fix TAS2781 async firmware
 teardown
Date: Tue, 05 May 2026 08:18:15 -0300
Message-Id: <20260505-alsa-hda-tas2781-fw-callback-teardown-v4-0-e7c4bf930dc8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/52QzW7CMBAGXwX53EX+I3Y48R5VD7u2Q9yGBNmpK
 UJ5dxKoVMQJ9TjSp5nVXlgOKYbMtqsLS6HEHId+Bv22Yq7Ffh8g+pmZ5LLiWgrALiO0HmHELI0
 V0JzAYdcRui8YAyY/nHpQZCrNNVEtLZtdxxSa+HPrvH/cOX/TZ3DjIl8WbczjkM63Q4pYdr9Nx
 V9sFgECrNGqMr4iLWi3P2Ds1m44sKVZ5L+sEjhIZ7ytHSlhNs9W9Wfd8Ff/U9Rstb5urFFUG/K
 P1mmarlJRyX+YAQAA
X-Change-ID: 20260421-alsa-hda-tas2781-fw-callback-teardown-3b76404bb928
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2860;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=goTqNX4LIT0yuiv/ihZXreJ6jCrxDpey8ywhTwK7eI4=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJk/L/FWz9tzskQ32vnFwVcbV9V5fdOWOqXwJ+HXjsWnB
 JnnCy5K7yhlYRDjYpAVU2RZnbTIck/Xg6v1cSs8YOawMoEMYeDiFICJLLJi+CuVVvnHUu+YptHZ
 h45zmIU5z+T68Ga2W/yOmvDkQHuNbD4jw40DnEvcnc14zh34tHaug2DAwxO8tzd3hSR0vJ2Q7PB
 PmB8A
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 127374CCC7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244110-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]

TAS2781 HDA I2C and SPI queue RCA firmware loading with
request_firmware_nowait() during component bind. The firmware loader
keeps the callback module pinned and holds a device reference, but it
does not provide a way for drivers to cancel or synchronize the queued
callback before tearing down driver-private state.

Add a small firmware-loader helper to cancel or synchronize async firmware
requests, then use it from TAS2781 HDA unbind before controls and DSP state
are removed.

No hardware runtime test was available.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
Changes in v4:
- Use spin_lock_irq() in the worker and cancel paths, which run from
  sleepable contexts.
- Fold kfree(fw_work) into firmware_work_free().
- Keep irqsave in the request path so GFP_ATOMIC callers do not depend on
  IRQ state assumptions.
- Link to v3: https://patch.msgid.link/20260501-alsa-hda-tas2781-fw-callback-teardown-v3-0-8d9f873b97bd@gmail.com

Changes in v3:
- Keep request_firmware_nowait() manually managed instead of making the
  existing API implicitly devres-managed.
- Track scheduled async firmware work in an internal list protected by a
  spinlock so request_firmware_nowait_cancel() can find and synchronize a
  pending request without weakening the GFP_ATOMIC caller contract.
- Match pending requests by device, callback context and callback function
  instead of matching by callback alone.
- Avoid the devres_add() / schedule_work() ordering race pointed out in
  review.
- Leave devres-managed support for a separate devm_request_firmware_nowait()
  API if needed.
- Link to v2: https://patch.msgid.link/20260430-alsa-hda-tas2781-fw-callback-teardown-v2-0-2c7d89cb3175@gmail.com

Changes in v2:
- Add request_firmware_nowait_cancel() in the firmware loader instead of
  tracking the callback lifetime locally in the TAS2781 HDA driver.
- Keep the TAS2781 change to a cancel/sync call in I2C and SPI unbind.
- Drop the unrelated cached kcontrol pointer cleanup from the previous
  local-driver version.
- Link to v1: https://patch.msgid.link/20260430-alsa-hda-tas2781-fw-callback-teardown-v1-1-874367d6b41b@gmail.com

---
Cássio Gabriel (2):
      firmware_loader: Add cancel helper for async requests
      ALSA: hda/tas2781: Cancel async firmware request at unbind

 drivers/base/firmware_loader/main.c            | 68 ++++++++++++++++++++++++--
 include/linux/firmware.h                       | 10 ++++
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c |  3 ++
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c |  3 ++
 4 files changed, 80 insertions(+), 4 deletions(-)
---
base-commit: 0d672ef050d4e1c3891c9944f72c85769978bbee
change-id: 20260421-alsa-hda-tas2781-fw-callback-teardown-3b76404bb928

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


