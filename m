Return-Path: <stable+bounces-235320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGOnCSFM12lYMQgAu9opvQ
	(envelope-from <stable+bounces-235320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:50:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B963C6B0A
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48C17301053A
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 06:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779B134AB00;
	Thu,  9 Apr 2026 06:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MPqdH80T"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3573349B0A
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775717405; cv=none; b=T+9/2wM59se/hs50OyK/MZDmM6avT6tg/DwLgG33ihaFH3aK0NTw8x4L9OqBOZhmk7kU0KvuMmJiPQ2EDlI35K4p+n2BnMCRunpU6Pv7XAKFwlz62QW7AIJu+r8EBRkvLmxpdxi0G7tHYudbgzxSLk87e3nsulIEUxPd/GAZKAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775717405; c=relaxed/simple;
	bh=amjMdpMLXPnpXnEVjD4WOv+bzX5GrYRST8oWtDMrcME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bc3pBwXjBFNdZRsPxTKFU7phbOT35Zy8PYPGGzrtFb9FUwYwH80g25K2Hz/Sl+EObAkUWmCVuF5Ep/AzA4b6WvZQnYYpNuDsn8877F/yN5Uq2tedbztkfyXolkZMxoXyhxfBIBzZg8IM5dUYEmC1Z/HYoKYJEOmf+/PCa+eFOLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MPqdH80T; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b886fc047d5so68994666b.3
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 23:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775717402; x=1776322202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7X2yjy3G3AjVzbkMNhFNNa6fZ5R4PCuwspi3NYnJRiI=;
        b=MPqdH80TvoTDuK4Z3MZIcDXI1GvKZbvNGOAiiiOWSYo/cXfH5Aa+CJFBkfuyqcBbnY
         yBl11frqS2X3EMJlPttIE7r66nxkjfskekQkq3c6mvBApxOaoXXHueCspz9QULP3zqx5
         e/R0U83MajrdY6PQG6DHmDEhcpoWFCW/osv90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775717402; x=1776322202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X2yjy3G3AjVzbkMNhFNNa6fZ5R4PCuwspi3NYnJRiI=;
        b=NsShLPWGSNdo9nUfdy5Sba2Qgs7LRp4HTi+x3YoXhi6Uc1WQNC0sWxPh2Cr8MPqM6f
         IxBo3w0G74aLD+6ud+ke4XGE6EZQUokxhSPWnUp80XcnmsoCABzDIsEZDElbPIbgfg0m
         psBqxg/ZAwnJDzaFRuRxgbtikDLYoxYagqsvZVXh7Hs7X6u76i7P6JBeDoomJt7Ij+zn
         kIeKeivmBzx2u2t9DoXv4Il4ir1YvmNe7HkcBWNwrCIQU4hunU4NbzaYMy/3M5Ry9B9Z
         aVIR8kX+qnxG6U/n4v3Mh+vXz/TsJcwWV9cnAqZF4KErrGMPldpCvN6dVNdVfA24ECeX
         mU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCxxHbBHpA2SdCfYZRpjCGeIa2Q/2Vz8Xzl9IVyzVsoSLOWms/Jbek179jLu5tY0jCd0Xq3qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeFJbAk3NuAwSfm39RvpxYr6Dq0MM6CXGxEH0TgzMfLGRgR4nV
	mzlllXrGKJ/hTZ6R/RfNMgUBw2EZXZTOGytj73uAbnPBbRAMoX1Bs2fKqsyyrn1QqY6CDc9GGrZ
	QKY9NJQ==
X-Gm-Gg: AeBDievsRn+QA7uABdqw3o8RaCdsfEJvPQmoSQD1Km7T9qifvFpVRCC5wnegqjAS88J
	+gmSjE78tn5aeulNpuqPz9pojyYd+X2OUg97Fcg/FeDd1FQGl5Y4IdVFmE7LHDo43ZP4M529W5s
	esLvrShvz65CG3OD8MQUQ1MBJv/7UgASWtBfywwW3gY4n3F5VOlktwRIlBZ+iW5SA5DcrLC4sza
	ALQK/5cMvzQ7vOZx+qpvcWgUFZ/RZZ4Luj0yXTf1TctRmhqmLBLpjCE7xbK5gFqfT6iN8LXKrNv
	KOa3kUnWTSG9LeRbgTxTHpfmh1HilDCYjsrkVUMpSSXCqwhgD0VN60dOixaklDUY9OiaLkC1F57
	76VjLh0IrlymXTjfXa1sbUTbMD3o8MY8S0/slgBhiQ5oMBRb3qPuAc9RwNK+Tb+q1yJ8vb+Iwvn
	dKxMkgQJbNTlsEKBHBUG1wfLG7I7MImGKGEnumb+Tz2StYjrcD9Bldt/O5DhC1gsj87kNm+3Y=
X-Received: by 2002:a17:906:478e:b0:b98:1129:51 with SMTP id a640c23a62f3a-b9c675492c5mr1180310966b.17.1775717401513;
        Wed, 08 Apr 2026 23:50:01 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cec6c11sm747221066b.30.2026.04.08.23.50.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 23:50:00 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b886fc047d5so68990266b.3
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 23:50:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWB97qDQoqVKo8VoB1NqIhJKLM57PhJWnVzKAnpd6z4TXqJ/rCUXSgEa2lJGQKLA/o9qPrAEeY=@vger.kernel.org
X-Received: by 2002:a17:907:6e92:b0:b9d:33b5:6ba1 with SMTP id
 a640c23a62f3a-b9d33b56dfdmr256685766b.15.1775717399530; Wed, 08 Apr 2026
 23:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331003806.212565-1-jp@jphein.com> <20260331003806.212565-4-jp@jphein.com>
In-Reply-To: <20260331003806.212565-4-jp@jphein.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 9 Apr 2026 08:49:46 +0200
X-Gmail-Original-Message-ID: <CANiDSCs2Mt1XziD9w6Dv1uid82UdkeQ2EuyU0+W1RxtqaHTyPw@mail.gmail.com>
X-Gm-Features: AQROBzBsfD4ymzSBIuuyaH-Qc_jqwlmKYUxuJe2TlFq6gdFCbWCcLr_Y33tBcFQ
Message-ID: <CANiDSCs2Mt1XziD9w6Dv1uid82UdkeQ2EuyU0+W1RxtqaHTyPw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] media: uvcvideo: add quirks for Razer Kiyo Pro webcam
To: JP Hein <jp@jphein.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, Michal Pecio <michal.pecio@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ideasonboard.com,kernel.org,linuxfoundation.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	TAGGED_FROM(0.00)[bounces-235320-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,jphein.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Queue-Id: 73B963C6B0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi JP

When we add a quirk to the list we include the output of `lsusb -v -d
1532:` to the commit message. Please add it to your next version.

Thanks!

On Tue, 31 Mar 2026 at 02:38, JP Hein <jp@jphein.com> wrote:
>
> The Razer Kiyo Pro (1532:0e05) is a USB 3.0 webcam whose firmware has
> two failure modes that cascade into full xHCI host controller death,
> disconnecting every USB device on the bus:
>
>   1. LPM/autosuspend resume: the device fails to reinitialize its UVC
>      endpoints on resume, producing EPIPE on SET_CUR. The stalled
>      endpoint triggers an xHCI stop-endpoint timeout.
>
>   2. Rapid control transfers: sustained rapid SET_CUR operations
>      (hundreds over several seconds) overwhelm the firmware.
>
> Add the device to the UVC driver table with:
>
>   - UVC_QUIRK_CTRL_THROTTLE: rate-limit SET_CUR (50ms interval) and
>     skip error-code queries after EPIPE to prevent crash trigger #2.
>
>   - UVC_QUIRK_DISABLE_AUTOSUSPEND: prevent USB autosuspend transitions
>     that trigger crash #1. Same approach as Insta360 Link.
>
>   - UVC_QUIRK_NO_RESET_RESUME: avoid the fragile reset-during-resume
>     path. Same approach as Logitech Rally Bar.
>
> Cc: stable@vger.kernel.org
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2061177
> Signed-off-by: JP Hein <jp@jphein.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index b0ca81d92..e8b4de942 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2920,6 +2920,23 @@ static const struct usb_device_id uvc_ids[] = {
>           .bInterfaceSubClass   = 1,
>           .bInterfaceProtocol   = 0,
>           .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> +
> +       /*
> +        * Razer Kiyo Pro -- firmware crashes under rapid control transfers
> +        * and on LPM/autosuspend resume, cascading into xHCI controller
> +        * death that disconnects all USB devices on the bus.
> +        */
> +       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> +                               | USB_DEVICE_ID_MATCH_INT_INFO,
> +         .idVendor             = 0x1532,
> +         .idProduct            = 0x0e05,
> +         .bInterfaceClass      = USB_CLASS_VIDEO,
> +         .bInterfaceSubClass   = 1,
> +         .bInterfaceProtocol   = 0,
> +         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_CTRL_THROTTLE
> +                                       | UVC_QUIRK_DISABLE_AUTOSUSPEND
> +                                       | UVC_QUIRK_NO_RESET_RESUME) },
> +
>         /* Kurokesu C1 PRO */
>         { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
>                                 | USB_DEVICE_ID_MATCH_INT_INFO,
> --
> 2.43.0
>


-- 
Ricardo Ribalda

