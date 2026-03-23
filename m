Return-Path: <stable+bounces-227940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKPPGJgPwWk7QQQAu9opvQ
	(envelope-from <stable+bounces-227940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:02:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B548C2EF951
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9646F305BAB3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AB63876A0;
	Mon, 23 Mar 2026 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VX5Vkz5H"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97B387578
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259778; cv=none; b=tSKWdwr2s2YK7EkUXpEtyTXREYF9W0SeskxamyRXeYEJoHD7zrENwK2wkyXVCDE4nsB1M/Y7mHVkbm/gWXclnwiZrg9H1gvV2u0uLG/biLOv4U3s308VKPFgMr6w6BImviPQkJmOV9hNbXY70GeC/ZQhEdhZvb+QhOeWH1mKnXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259778; c=relaxed/simple;
	bh=3/Rg/BX2DfUy3s37k/M8yXA5dRTcBuREAmBzZiqXRP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6XZ5OoNTiLncga4JHMZvLCG1QLhGhal4cTciC3a1a9xGj1DIXd5F+Y7hdFNPtGJ4REt7gKvSXV29DHK6+AK8rvESYBfiw1ll4lU3aHP4X1qfJg5EvNcN4BWgJpr91Uhaafqcs2Sh7Isln79mA2q/CFZ2M9AUNxwMbDxqFw3sQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VX5Vkz5H; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b97a06d7629so510587666b.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774259775; x=1774864575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU5I+1pCOUAYiUlxW8VCH/e+rD3CTOAJqq49cAprQ0w=;
        b=VX5Vkz5Hy6v/t11nplR0UL5XbFI7BAdAryUaNuzkOZ55rPeSmTl8bpQWwU36XgvlYT
         kJU0sjWu7/fbq35NcyAjvlVZxVZcg0CqqOhd1bj+tu/3fcr0EPhf2OqzmVSL8xqyTvtW
         1VJznp9sA5XAA657G3b8SwTawd5WcGzRrtU70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774259775; x=1774864575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bU5I+1pCOUAYiUlxW8VCH/e+rD3CTOAJqq49cAprQ0w=;
        b=BBAmOe/g73ioffR9lgkfQpJzsDr55cNupFa7fSoTbWifwKEu8wT3LDTcyYUjkNBByc
         wFhB+aenvCQh8eIneo5Aaapr5YAIIrTVLaAXwVnlXQ9KmAQTVinhFDflTR2F/oh7CTkt
         ebMfxGnAV5SveGFkMBBbf9u+5KI1oNViLmmGrQ/2RmAoDjZlVHpUNNqpgqVYU0mh8YBq
         bOjzILfj58mfWxtcR66CzA2rCkq4DFI7ulKNRmSiJuV0+rx9HvGNZH5IxMBxFp5r7RHu
         6L8IvWEmKKWyMaqSmmhrEshC238LHnJTry81PUExAL9hw6dNT4iG8oYJyv3QTA65m39T
         5ZNw==
X-Forwarded-Encrypted: i=1; AJvYcCUFjnd0C885BHmPS5CdVGNxGUmyFmUQmWeBhFrDLpfOAmAy7R7sL8aasYdZppjARbOgQukMcKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwBYEy2CXxQkUm3wfLV+Aii5oWmouKQFddWsFJLGjEmNRz2KLB
	y9Q5PgkpMCyTlLFp9InKse+5lVI+ZDY0bmXmpKB87XR4yDG/AtfxV+tgdadJ8e+LUG5IVFGeIL9
	pt48=
X-Gm-Gg: ATEYQzzF+5lC36Icd6BhztNImyvlZah1xTZ/5O4yBdGNGDGCYibOQN/hiTzW974xFHF
	8d5Nr7wMHBR2DOMoGx3L+Kq2PWeRMhrumhOy3RIV2b1/nea1CfP489TC2cE39vNjwm8qIazJbSQ
	jXiyvDvpCVseJuvJEPhs9SLyXouIdGpwmKV9ymaVd8Ax7iPTbwnywjlCOecIqd6xjcLkTHeLVW8
	O3C7+W3xipP/WkHFRQRVdGJNbCObiTWkHtCESPma51Ph0PFbNUriGL1pxFEt1S13FMxTMyrYyXx
	hATaiSDKAMNCZP4DfqSD6H12pROoIcVSs0FhoKg1ZeYTG+dUMxW1pkvq+ehsbktHczlv3zJHNux
	hbc9w4RhMqE6QwUnSyV95pOcSEHkJZCukbR+REPmlGyhCg21TeRInDV1eawUwF7c/5et7uVPltk
	opkGXLeNaqBzUQAqLwTAS49wNIJeoHHhECP4ssvEabAHHbBUMgpZTXMyASXqHC
X-Received: by 2002:a17:907:c281:b0:b97:b03d:d264 with SMTP id a640c23a62f3a-b982f0bbca3mr834234766b.4.1774259775173;
        Mon, 23 Mar 2026 02:56:15 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f44034sm477690166b.4.2026.03.23.02.56.14
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 02:56:14 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9795ca4e6dso604301166b.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 02:56:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRx5+iZ+u3KpV/8i2PcIvYomjz/bsCoDio3n+CyJVFA1LA2L7Bib5KlGlo9P9WJpNbDE97j/I=@vger.kernel.org
X-Received: by 2002:a17:906:a895:b0:b97:8503:8313 with SMTP id
 a640c23a62f3a-b982f30378emr724881766b.27.1774259773686; Mon, 23 Mar 2026
 02:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321223713.1219297-1-jp@jphein.com>
In-Reply-To: <20260321223713.1219297-1-jp@jphein.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 23 Mar 2026 10:56:01 +0100
X-Gmail-Original-Message-ID: <CANiDSCsZf0QWzCQdgFC=hj+V4ChCynwjRNAz6u-F3Y8vzZXXDw@mail.gmail.com>
X-Gm-Features: AaiRm51pgrzPjR2hqfRCdAFfdxEd-_k1LaQPVJwPrlN7jYDCE9YsC62lPeYFY_o
Message-ID: <CANiDSCsZf0QWzCQdgFC=hj+V4ChCynwjRNAz6u-F3Y8vzZXXDw@mail.gmail.com>
Subject: Re: [PATCH 0/3] USB/UVC: Add quirks to prevent Razer Kiyo Pro xHCI
 cascade failure
To: JP Hein <jp@jphein.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227940-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,chromium.org:dkim,jphein.com:email]
X-Rspamd-Queue-Id: B548C2EF951
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi JP

On Sat, 21 Mar 2026 at 23:38, JP Hein <jp@jphein.com> wrote:
>
> The Razer Kiyo Pro (1532:0e05) is a USB 3.0 webcam whose firmware has a
> well-documented failure mode that cascades into complete xHCI host
> controller death, disconnecting every USB device on the bus =E2=80=94 inc=
luding
> keyboards and mice, requiring a hard reboot.

Have you tried reaching out to Razer in case they have a new firmware
that fixes your issues?

>
> The device has two crash triggers:
>
>   1. LPM/autosuspend resume: Device enters LPM or autosuspend, fails to
>      reinitialize on resume, producing EPIPE (-32) on UVC SET_CUR. The
>      stalled endpoint triggers an xHCI stop-endpoint timeout, and the
>      kernel declares the host controller dead.
>
>   2. Rapid control transfers: ~25 rapid consecutive UVC SET_CUR
>      operations overwhelm the firmware. The standard error-code query
>      (GET_CUR on UVC_VC_REQUEST_ERROR_CODE_CONTROL) amplifies the
>      failure by sending a second transfer to the already-stalling device,
>      pushing it into a full lockup and xHCI controller death.
>
> This has been reported as Ubuntu Launchpad Bug #2061177 and affects
> multiple kernel versions (tested on 6.5.x through 6.8.x). There are
> currently no device-specific quirks for this webcam in either the USB
> core quirks table or the UVC driver device table.
>
> This series adds three patches:
>
> Patch 1: USB core =E2=80=94 USB_QUIRK_NO_LPM to prevent Link Power Manage=
ment
>   transitions that destabilize the device firmware.
>
> Patch 2: UVC driver =E2=80=94 introduce UVC_QUIRK_CTRL_THROTTLE to rate-l=
imit
>   SET_CUR control transfers (50ms minimum interval) and skip the
>   error-code query after EPIPE errors on affected devices.
>
> Patch 3: UVC driver =E2=80=94 add Razer Kiyo Pro device table entry with
>   UVC_QUIRK_CTRL_THROTTLE, UVC_QUIRK_DISABLE_AUTOSUSPEND, and
>   UVC_QUIRK_NO_RESET_RESUME to address both crash triggers.
>
> Together, these keep the device in a stable active state, prevent rapid
> control transfer crashes, and avoid the power management transitions
> that trigger the firmware bug.
>
> Tested on:
>   - Kernel: 6.8.0-106-generic (Ubuntu 24.04)
>   - Hardware: Intel Cannon Lake PCH xHCI (8086:a36d)
>   - Device: Razer Kiyo Pro (1532:0e05), firmware 8.21
>   - Stress test: 50 rounds of rapid UVC control changes, 0 failures
>
> JP Hein (3):
>   USB: core: add NO_LPM quirk for Razer Kiyo Pro webcam
>   media: uvcvideo: add UVC_QUIRK_CTRL_THROTTLE for fragile firmware
>   media: uvcvideo: add quirks for Razer Kiyo Pro webcam
>
>  drivers/media/usb/uvc/uvc_driver.c | 16 ++++++++++++++++
>  drivers/media/usb/uvc/uvc_video.c  | 33 ++++++++++++++++++++++++++++++++=
+
>  drivers/media/usb/uvc/uvcvideo.h   |  3 +++
>  drivers/usb/core/quirks.c          |  2 ++
>  4 files changed, 54 insertions(+)
>


--=20
Ricardo Ribalda

