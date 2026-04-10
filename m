Return-Path: <stable+bounces-235522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLEfCVdD2GnfaggAu9opvQ
	(envelope-from <stable+bounces-235522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 02:24:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4893D0C2E
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 02:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 955523013D54
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 00:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B394F2777FD;
	Fri, 10 Apr 2026 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="z6IkpPg9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAA26F29C
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775780690; cv=pass; b=kIaTT5GL0Nyf3Rbti0KynTQwEcHtGxO9EZTzg27MhhHeRSvM/hhTrl+0L8uyD5OVv+OS/Cy0zbI/X8wX8HOU/68+vzVpFt3WRbZv/lflp3Re+YadST43XwNx78Eth8BEQFu7TW3eOWQL9AEUjURlwcZU42vbt4wlKSpjQ4l67po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775780690; c=relaxed/simple;
	bh=lGEEv9glUe1Iivgjd8wqmSvhwzywsg/HbvNLx2jLX8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IN6NNcSpDM7mrXrw/sn9AYjtxXhHsOw/ejiUxnjMgN+ofYLJhMM+66HMuGsTsiTB2KcAo5oGGsUR3WOt4+C01coOU+7AmbHNNrU50P9URinYfX8oEDsbAdoOdDrPyt6zW3fN38YTCTLns0hslmBne3TWooDkL4R00WXxKeFrYMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=z6IkpPg9; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64e87a81639so1530484d50.0
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 17:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775780688; cv=none;
        d=google.com; s=arc-20240605;
        b=ZVDeeBE6K/UW1R7iDTMNAJ/rxddGKiBprtgpjen6erLLHqRq1iPchP+TUZyJpgWm1K
         CbMZ4cVi7cXYdI1Io/iALGunc8/InVV+bpY30a2JUNSFWUT9APZdlM1aiHVpx45LetGM
         UCYpuxDa3PnxeUO5CCNKJwluDJJAlGCjh7uOlYMfukQd4tW0JfTUfxCfAXaZytdMkHl2
         ouN+a5Jr4rcWQP+e6nZYH7BlvlHK8uglBb77VNFYfEaS+qP0JRlmrn6iYYaJgHb5o9TV
         Eq/kYS8eV3GbRb++3UrVynivVp4GKAyq8Roz7eaFP+UPFwq5dTNDvQhVI7/mzhluBxXA
         jrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PSTynu5H3U6NvBdR0vN3EDqTZRC1PjpEAUrWz8MB7/U=;
        fh=gx6nRu1rnC+R0FnArL+/CelOqhI3d7MkaJPS8ISYxeo=;
        b=NqUb/wvPPVJIXJYYldSHOEiDC67X7SJPD3abjmfaXTkmuhNvMxflqnF1DH/oDrC9WR
         YTRI++DBVFVCcrv/3pIPEhVHo9AyajZviGhxnr2nCb5ezz2S5t9/iiTKwx5R9mHo0EkE
         FlWick0ToA3G9305f4iAVffdcm1E+3oIl4H4zwf2LANjz/k+bMfUy042lQQbEDiR2dD+
         46A2MouO+316y2UEo/jAGidyBl63WrJT1cxDrU+/9iA0RKT375JhC6AVmvAbkshR5OTS
         IYBKAkF4YOtC9B+Js+3zv26P+uPYPwo24lfscsIKZbxSoCTLu5Me2riVK1hbYc40oHgQ
         TbJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1775780688; x=1776385488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PSTynu5H3U6NvBdR0vN3EDqTZRC1PjpEAUrWz8MB7/U=;
        b=z6IkpPg9FiZX7MjmO1pGQMtosfRaIzbLwoFgylFlF55hVUqQhcRlvSN078b6SW9kVT
         q3pnL8Qi+AVlztf2QjgGn3bgTB8vQaVYK4PfjCZgGlltRiqodgHVd2yxVKdUYA/KGLL5
         0TtRYwCyepCMB0L0tNfOTSrnNase9xvbmhH8K1Rj3QLMUvqtpcdpR4GU4MaE478fBpGD
         Nq1RbjedD/gswOODFUoazeB9M3movUAegUCfEdlJNRtPgnCf4NSqhHJbepgTYjB4OKqf
         mOfVcWa31DtojL8eIKY4lkLvhyL6BV9qJAkr7ttMK0ndQIIBSIrFJtlUZZYeyhT9BbtJ
         dTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775780688; x=1776385488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSTynu5H3U6NvBdR0vN3EDqTZRC1PjpEAUrWz8MB7/U=;
        b=CN5mmBhoNUDEuMnztdRoyyXnrwt9urjQ0BkHyd6iVL6sJPk/WBS4CeisN3xhkvZgw/
         qm/OydGBpA/gih3exuOzk8ItJy7vANRK9FVkc239yXu6TehF2wn4fhUh3DCe1CimucPJ
         CFek8PWNuD8bZrEDP1ULSp8xilZwSNr1q6YYFQCvQq62c42TAnbJHnGdrEYD3FNhPbg+
         vtZvRjLBanesqABmWaNpzer4cQF65PqHLKKDOjyUDeq3pLve7n1QpfEYPf6+cvr5mMWV
         Zk0d7V1qK5q5yifnNBdv4Ib3N+ylKQIah7iOz8gKwVsYCiDLRT3Ma3Tpqi0BQ332q8YJ
         fdnw==
X-Forwarded-Encrypted: i=1; AJvYcCW4jMEsU6OWRBBs8HGKTChWh2CzixWfdviGWGigPIgH6rMWiYBD+cSc++AD4RAj7RSGXwf++dI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/b2F9ZIYGSg7GhbuWbrdUkb9FixTZ64kumvsPpfqysP16D8eR
	PrAJrw+M4gauZMs6733DPL2ArPx6aaZfTqyzoL6m0iKz0ueHefwh0uzIxH+C8kES8HZwxvP3PQE
	n4dP/WxwNfKUly49i13c5oF5aomehLt7AF+TPwx7djf6UFs7SP7c=
X-Gm-Gg: AeBDiev8W0kRoN7BTJu7lV+XxLtqiQQLJObGN5B/j59aSy3hzYTjdNOP8kbzdJrS7A+
	YD12p+6MsbjXP6r2jVK79uuRPnI1gSbGxCW3lfgGcQv3We3wh+HIEog35O4h5lPWkljKwpRUTfw
	nfxJAhOsNgSxqCy0nVJSP40clz/pQF6BkIY1vJsqqjKQywFzzUAHbUJ1ZQFNuhuQYe09KES0sm4
	zySt5gFUbuV+YME3yjIQiru3As6AJ8P6eC4mx8M+gVb6bYegBYITqELnyAiLQKEsczoXYbkFKWP
	+dNmcNjLSg1ITksNU6ee6pkVNmqYDSRDi8GZ8/VnsLsKmkR7LiMbUPNI83qp8mAxcw==
X-Received: by 2002:a05:690e:244e:b0:650:36e6:2acf with SMTP id
 956f58d0204a3-65198a9d38cmr786361d50.15.1775780688340; Thu, 09 Apr 2026
 17:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331003806.212565-1-jp@jphein.com> <20260331003806.212565-3-jp@jphein.com>
 <CANiDSCvsxP+npQTHUrMTp+Z8XULYKSLTz2AFu+WQnsLbRBGa2w@mail.gmail.com>
 <20260409100247.7cfb62d1.michal.pecio@gmail.com> <20260409221749.5e6bccab.michal.pecio@gmail.com>
 <CAD5VvzBQLGDrbrds=OrOOh5ptmVjP+nyq-jRHF5dCFzw+S6iQA@mail.gmail.com>
In-Reply-To: <CAD5VvzBQLGDrbrds=OrOOh5ptmVjP+nyq-jRHF5dCFzw+S6iQA@mail.gmail.com>
From: Jeffrey Hein <jp@jphein.com>
Date: Thu, 9 Apr 2026 17:24:36 -0700
X-Gm-Features: AQROBzDJCjlxavks6Ub5ZF6jfWDfLUTJG7_G3iHuw1Ym3HvJjO5KZjGocMMy4Jc
Message-ID: <CAD5VvzCVxn6ehen4vzbzJzm3Akc-0BREhMZrfsffXTz782jQcw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] media: uvcvideo: add UVC_QUIRK_CTRL_THROTTLE for
 fragile firmware
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[jphein.com,reject];
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235522-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[jphein.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jphein.com:dkim,mail.gmail.com:mid,linux-hardware.org:url]
X-Rspamd-Queue-Id: 7E4893D0C2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

One more thing -- you mentioned referencing an lsusb from
linux-hardware.org for an "identical(?) device". Here is the actual
lsusb -vv from our device, confirming the wBytesPerInterval mismatch
you found.

EP5 IN (interrupt) from raw SS Endpoint Companion descriptor:

  Endpoint Descriptor:
    bEndpointAddress     0x85  EP 5 IN
    bmAttributes            3  (Interrupt)
    wMaxPacketSize     0x0040  1x 64 bytes
    bInterval               8
  SS Endpoint Companion:
    bMaxBurst               0
    bmAttributes         0x00
    wBytesPerInterval       8

So wBytesPerInterval (8) is indeed 8x smaller than wMaxPacketSize (64),
matching what you saw in the third-party listing.

Note that lsusb -vv does not decode wBytesPerInterval for this
endpoint -- the value above was parsed from the raw descriptor bytes
in sysfs. The full lsusb -vv (934 lines) is now in the repo:

    https://github.com/jphein/kiyo-xhci-fix/blob/main/kernel-patches/crash-evidence/lsusb-vv-kiyo-pro.txt

I will follow up with the test results from your patch.

JP

