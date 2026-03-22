Return-Path: <stable+bounces-227866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DPymJD5ywGmDHwQAu9opvQ
	(envelope-from <stable+bounces-227866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:50:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ED02EB101
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0D7E300767F
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 22:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEDA30C62E;
	Sun, 22 Mar 2026 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="z2XWmGKp"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD76279DA6
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774219835; cv=none; b=Fa4Dr4EKImAFqkczHiP/3Z1LJZ5Mf97linDrGhP33nPRfZUI0yYcMcbZ5/2hRudA5ttuPWctRiE5ZSldMcXYbsIgOODCbrauCIgyia5Mj1Tu5X8cXyEckhoyGZLvPCi9+dJfO1BW8ItbNUEoVw0Exb1lwJeVVwYO6XjLnQ848eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774219835; c=relaxed/simple;
	bh=0rBP9cmP3Rq9XVksFITPmsWOgg65fxpyDfXQOlq5fX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WemmGM9kRf3Yy+PclsJgmscLvdMdHFR4N4skJU6kT1YJ2PJ4ZkRuGIeditySMVyM73ENxS6xlRERT+6C2UUMqNwmoCLBlFPmSrc99gficlM7vrPvxf+CgwcSErq0F7r4B6wi/6NxZGaqTP/d4A3BcKMA/ScpE6N5rHaN7tnu/so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=z2XWmGKp; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c0ea57fea7so4224362eec.0
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 15:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1774219833; x=1774824633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUoyhbPcIc2EMQIlt76bSFYcSIJJ4Un7MV9DQ53afaM=;
        b=z2XWmGKpJraYTn2kyGrsxQMAG1glpDCkGtmHAeyFXyOJc9spdTOkWirOjegwJUI48y
         4oCCHqCv5X85ZFM3YBhqapdfLO3R8Z6FfVW+aGuk7QY2Yn1lo06fYJVB8r0BbGaq7ujU
         2mVBMJzk7MnNz4MWqvpwfm83hPDzQf5uZKNtjMyOygkd/Yg55G67nD7fUkvurPUPOHx8
         /Bv8WRr15RqK9gLjXfkHA3/+B8jc82TTUUMu+ncyrvfSx6XWVNr9pJQjGyF7grnITJj5
         KTAvMC/eQhSktskUgeLZKMGa9heHb+MvgkBQemuX6Y1QO/OYcNkEiCIxM9j0UqHOrocb
         6/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774219833; x=1774824633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUoyhbPcIc2EMQIlt76bSFYcSIJJ4Un7MV9DQ53afaM=;
        b=iIuqG74RJmhvLOye31eirzEppN1kbfrJTsrQXPV52u58mCWX/7l1v8gbh6253lf8/+
         1QOBoe86YUEghrhLmGkY6UV52/4Us+/CgSAcJ9cHDpukM8GJwHVwhwLPRZUbsVNLo3JB
         nzm+b3wghlpLhAI+MWO/Wox4nnqOIswefj+yxtQ1TyveJZbaYwCHlyp6wzNyxxsimctn
         KAicqT0RQ0wi/f5nEdUUsnLDYeKA8zI9Gx8Yx3yhDIQH9V3Tc3QdfVTP9/wVyrbF3iw1
         lBpinb7KdjRGgIDrSI8M2x6JIHhdp2frZCqO9FInIGfGUXON0SKgFrKQPvfHjIf3VQHX
         6qaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZfkOo9nKchfj74Ve4N/sDs0z1Xkw4/M7dl4bBvptFzbDSk8AVbTHh7ZbBueVotGBsXVfAuRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWhSb8W5PJmV/T1/w1DWObO0XRrJO6KvPDmWEOS4iWnTJFFCza
	VsDQikZtEf3RmIsEIejep82Pf6QZNMyskz1ww0+k4s0+vvH+1YKEKMzoczKofrqAcg==
X-Gm-Gg: ATEYQzxF/xivaR3txEzKcuQC0MZaaqru15n01szU0BmxhWuJTGxFFAiEnv622TJvTZK
	sTiA2IYcKWceGch69wx/xXOKxBV97cGWbnz5SDLEadqWuOvT2+jCOtAi9D7t9p+ih2VscSY7dkv
	lRjCaXOUxaMKB7RglDPhQy3PTsIcjKE4TbfezMXcn1M29gOKIDB92QNrQSfuMQsjNXc6PvnGCQW
	qTCQ76Lxly23aCbNNStz/a/ggAl4LXKFOIu6Tsm88m+fsO3N6tP840dUarFVg3OPHm1XF16pkPN
	EX1/FQJQDP46WWU9IRDpPiKLfXr5LLcevf/LpNOatsSur6J9WZgyfP6oXSo69WcGhFx8NpDR0sm
	E52UuOMMrJfYU8xQThNG3frZTYR5FdMY4FQVlvGeu4QB3toqT7v5utn5H5ZnG+/bN+2OD8xu55B
	dNRSvdSXei
X-Received: by 2002:a05:7301:1f15:b0:2be:884e:17c3 with SMTP id 5a478bee46e88-2c1095a7a7amr4111742eec.7.1774219832489;
        Sun, 22 Mar 2026 15:50:32 -0700 (PDT)
Received: from katana.lan ([108.74.4.89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b31ebd5sm10928052eec.27.2026.03.22.15.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 15:50:32 -0700 (PDT)
From: JP Hein <jp@jphein.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	JP Hein <jp@jphein.com>
Subject: [PATCH v4 0/3] USB/UVC: Add quirks to prevent Razer Kiyo Pro xHCI cascade failure
Date: Sun, 22 Mar 2026 15:50:09 -0700
Message-ID: <20260322225012.1817920-1-jp@jphein.com>
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
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227866-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[jphein.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 05ED02EB101
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

Changes since v3:
  - Regenerated patches against media-committers next branch to fix
    context mismatch (v3 was based on Ubuntu 6.8 source)

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

 drivers/media/usb/uvc/uvc_driver.c | 17 ++++++++++++++++
 drivers/media/usb/uvc/uvc_video.c  | 32 ++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  3 +++
 drivers/usb/core/quirks.c          |  2 ++
 4 files changed, 54 insertions(+)

