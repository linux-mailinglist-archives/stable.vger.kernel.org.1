Return-Path: <stable+bounces-227860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id R3YALbJowGlkHgQAu9opvQ
	(envelope-from <stable+bounces-227860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:09:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 329232EAF3F
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 191A7300A74C
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 22:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043FA373BE0;
	Sun, 22 Mar 2026 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="gdNOrHad"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D431F98E
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774217388; cv=none; b=i5Nz+iqOfaf3cgHzK7lcjvpQ8tLa6p51mKG7pQW1MwFXRxPEXRvG8QULZ5V8XxVnhmzYVC1VjhdzmmzKJ4lvSS6f8PFpXmGYbair9doF74U/7a2zw6c+7a8q63Iy6SZZ+SbyMqgSCdw2NjzNnqNXQB1qrZHkgIA0/wGAQJWq9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774217388; c=relaxed/simple;
	bh=C+AbGO+IXiAylnzIXV7KY8aH2ceP+5Q/0HArBOMbwhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PwiWEr8oOwiWJaaCThFkwRwV8b3aZlyY6AyfJBUrp4Ie+Q5Ls4RD00W6ZfH5ZUM2vkuKFVpTdjlocZ7Is6r353lSBGGtFKSa2Hcc9r0SZbYLpzjyrNkbmCiZ2MR1Ssz5xDPqm10DpX6cZ+OUTp2Csvrdgij1xe2fYbdVJKEDuXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=gdNOrHad; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1274204434bso3567101c88.1
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1774217387; x=1774822187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiiQQ0nYA7Fu3VA4AXEfqp4dM8kdCa/UiUZIcb5KPa4=;
        b=gdNOrHadXKfyHbpaGzaxn3KF/3INj8H6mt7V7TIF05awTRMnFlugX+4lgpg/B39CPW
         4Np5XV6yU2DsEPbaocd3sDaSRI+xHZCOrwPEgM7SUju2dyM3LzuJLIx1a9hbzsfe6rjc
         pKn9hbbBfR0NCYgItS6FG+HCuPcGPI6eooi3NM/nhRmkxia68vfHH6hRBoMidxn+/OCn
         ub+48bEP8rYV+NsZ5jV0MH/A4IeNfVEXP1iC81kU4JaLf/531GVWQbm/jQG6SenwanV2
         hWsOGA5YQF8MZ7n2mhf2tvF+W1hSDldlEWkDMZEyJswIPWq+Bokc+HWsMwjsXTLVvXQf
         SOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774217387; x=1774822187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiiQQ0nYA7Fu3VA4AXEfqp4dM8kdCa/UiUZIcb5KPa4=;
        b=HBLXyqLJUhmQJM68yBVwl/xoe58ffn8rAY1L/jcj5Bdswk36p4otjAG7un9O56jHNH
         YRIou5k2xtzBer47bnvzdWY9tSFIbQW66QJZDsym1zw9+COZy5dCU3rbGdhNvzVLTfxY
         +dVStdQekiaAph2jMls2TVL8R+J9WamQVhdX+BM/QWOGNXqLqt/519xpdHe1wLuBRxqY
         ZbBQwkNovIojBq0P9vRMeV0a1NRmvXzna0tmvC0rqusMTEC89rXsgRJhOdi3IXMzebkp
         PcOiTVCSgT2xqlwwT3pblWQiF6BlG6RwIbe3tLT15o56wljVtKOioM5JZ/26CuW32aZP
         x4og==
X-Forwarded-Encrypted: i=1; AJvYcCVf0gyRnoZxG+15XtLj0seOrMo9+zSNnaj/0DedSUU/Zozen7DtOXDs0mNlO+PBQWD96Kkc8uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjRPnDyljqQiNcQjWOZbp8wySKYlHpUl4ub8D2JLsNqU4Hc4Gw
	FlRaK4M75B+8vS+atFSLFlRDWRXZ0FNv9JjMO7nBW9VhlzWANX0xIqDDMDBXfGNUFw==
X-Gm-Gg: ATEYQzwXjLqhLfoR3hRMRUqvfbryfkwEVHVnMmj6gi8EPmUKZG2vAKVVJ9uy/GjBxc1
	u0ZOaq0ArLPPnpzqA2N3h1I3bl5t1IY2pvHPd2NZwl5TLqnW6k9R2pbRMKaw9R0Ej4WjLA/eky+
	DpupOPlcN++0DJ2C3xVSB74ub3j0tF2Ov2WgMdQt9jcLACuUrQwDH8XNMjFP8cgnt8mR3x0rAZs
	WQsGHrYWTAtQzkFms9PVCpS/DXY8jBDmzlT5oWid6n5OrR+SQUG/LBxAH2AySFrAT1Mo9Z/wXHG
	jn6Tmx9cWo5JTXVIRoH4VnYlVHQB7IkM/1fngD9hUsykN1bHC8+RhgRynb5YSKSN5iacaIgGxxS
	juBvsnSiMnwC+jCIhWUmuPvvKmSlazoyk4X7cjId9VWfI2KprH5rBTnlwJUPaItsMaRkUYMU3DE
	MW7cuEhZ8i
X-Received: by 2002:a05:7022:6894:b0:128:cdb7:76e1 with SMTP id a92af1059eb24-12a72326a69mr3580238c88.13.1774217386408;
        Sun, 22 Mar 2026 15:09:46 -0700 (PDT)
Received: from katana.lan ([108.74.4.89])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a7330d1c5sm7707766c88.0.2026.03.22.15.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 15:09:45 -0700 (PDT)
From: JP Hein <jp@jphein.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	JP Hein <jp@jphein.com>
Subject: [PATCH v3 0/3] USB/UVC: Add quirks to prevent Razer Kiyo Pro xHCI cascade failure
Date: Sun, 22 Mar 2026 15:09:37 -0700
Message-ID: <20260322220940.1462189-1-jp@jphein.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[jphein.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[jphein.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227860-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 329232EAF3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Razer Kiyo Pro (1532:0e05) is a USB 3.0 webcam whose firmware has a
well-documented failure mode that cascades into complete xHCI host
controller death, disconnecting every USB device on the bus -- including
keyboards and mice, requiring a hard reboot.

The device has two crash triggers:

  1. LPM/autosuspend resume: Device enters LPM or autosuspend, fails to
     reinitialize on resume, producing EPIPE (-32) on UVC SET_CUR. The
     stalled endpoint triggers an xHCI stop-endpoint timeout, and the
     kernel declares the host controller dead.

  2. Rapid control transfers: sustained rapid UVC SET_CUR operations
     (hundreds over several seconds) overwhelm the firmware. The error-code query
     (GET_CUR on UVC_VC_REQUEST_ERROR_CODE_CONTROL) amplifies the
     failure by sending a second transfer to the already-stalling device,
     pushing it into a full lockup and xHCI controller death.

This has been reported as Ubuntu Launchpad Bug #2061177, with reports
across kernel versions 6.5 through 6.8. There are
currently no device-specific quirks for this webcam in either the USB
core quirks table or the UVC driver device table.

This series adds three patches:

Patch 1: USB core -- USB_QUIRK_NO_LPM to prevent Link Power Management
  transitions that destabilize the device firmware.

Patch 2: UVC driver -- introduce UVC_QUIRK_CTRL_THROTTLE to rate-limit
  SET_CUR control transfers (50ms minimum interval) and skip the
  error-code query after EPIPE errors on affected devices.

Patch 3: UVC driver -- add Razer Kiyo Pro device table entry with
  UVC_QUIRK_CTRL_THROTTLE, UVC_QUIRK_DISABLE_AUTOSUSPEND, and
  UVC_QUIRK_NO_RESET_RESUME to address both crash triggers.

Together, these keep the device in a stable active state, prevent rapid
control transfer crashes, and avoid the power management transitions
that trigger the firmware bug.

Tested on:
  - Kernel: 6.8.0-106-generic (Ubuntu 24.04)
  - Hardware: Intel Cannon Lake PCH xHCI (8086:a36d)
  - Device: Razer Kiyo Pro (1532:0e05), firmware 8.21
  - Stress test: 50 rounds of rapid UVC control changes, 0 failures

Stress test and crash evidence: https://github.com/jphein/kiyo-xhci-fix

JP Hein (3):
  USB: core: add NO_LPM quirk for Razer Kiyo Pro webcam
  media: uvcvideo: add UVC_QUIRK_CTRL_THROTTLE for fragile firmware
  media: uvcvideo: add quirks for Razer Kiyo Pro webcam

 drivers/media/usb/uvc/uvc_driver.c | 17 +++++++++++++++++
 drivers/media/usb/uvc/uvc_video.c  | 33 +++++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  3 +++
 drivers/usb/core/quirks.c          |  2 ++
 4 files changed, 55 insertions(+)

