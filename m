Return-Path: <stable+bounces-235565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGGJI+SA2GlSeAgAu9opvQ
	(envelope-from <stable+bounces-235565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:47:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 285083D2269
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 06:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2AF730179DF
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 04:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFEE3314C5;
	Fri, 10 Apr 2026 04:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js9oGNSO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337CE2DE6E3
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 04:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775796443; cv=none; b=uPCxEYD3aVVHbk03JfqD6btDOBBwCa/3KmCxlF19Ly9qpSDKhYeB8GiLmRMpO77u7LPkevFPK4cTknl3Ea6GQITIaPyExNtf7CwaIbPtfP8MSbFVU7zs16KzoT7+WhF3wWNz3yHeL8uxNqiVqv03aIRkUD4YHLAlH9nYQE8KjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775796443; c=relaxed/simple;
	bh=WcxeK9jeT8gDosToL/33rlNmTvgpqWSN96aht5IGIUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ranzdIWKKGTy/ktmqfG9H0R6onl4Qd8BCYN2wLSl2Wp0xZcFkEi1orOqUCp58NSPTGP0qgnww17N4z3rEH7EIWuaGeyqkQ7/d+eFuI5be38iWGIOmgmkLfr3oQzwEj3etIIwmZGcAxOmon67EzWLXrFhbSYkveqLVOKdO4exkfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Js9oGNSO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488c2690057so15581705e9.0
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 21:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775796440; x=1776401240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcxeK9jeT8gDosToL/33rlNmTvgpqWSN96aht5IGIUE=;
        b=Js9oGNSOku5Q7scL15U30zOQono+G7GBbuPgznZtXW5ucnxLfFdaqQxS1sQugIBCv3
         gwbqnXBCDJkgangX6vi/TF3MAlmsegGXLzGcNmCIAc/by/8pHu98hDz15lD5yjMq+1Ur
         dSG95hHTvY3WQj2KyTQq0of7+x8oLVyZ7hfnKhM7UZy6R5CiWSNRVZJletn0w/XTIROo
         vSGFzrlGUbY6BtwBezAT9ieC+yvj06MCk8Iwu3LgiGSnXSLHVfT/v7dpw8lfVIFAk4q2
         2Devl8SRDxawGvg3zjlMjHdyzLCEPSrsNTGzeNMECct/gRs4KbCTZSFGFKlgDfd+MqyD
         VK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775796440; x=1776401240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WcxeK9jeT8gDosToL/33rlNmTvgpqWSN96aht5IGIUE=;
        b=fHO71xJUzg4SkDDtlXRHwZwHA1gtqYKzoBHf566SNu4XQCRj0j8SfYQwBMTeXxrocQ
         jGe5o4XcPfCibDoBxJcv7JEKR1pEKMHaXgFACYG17dIm4E3PJFEBbauTrIYNA7sLu19q
         OhSXLvlmdFvuNKi+XqiATXsvMSn+qvK/LSMg8IBuqPMlqW33MsyCXt+RW6gkzgwjRLNS
         eA7Ec3Q/gIq3pNg9q6yr33/YI7fEHBsmEdhHA9NnIAndnXigHxM5jDN1R0vG71MArNZK
         TryuwFEEbwcv/5uFjVXoTqdAEYcVLKV6xl8qMzkphuRz3kzUkTFWuJWSAjaylYAqQEvz
         WysQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVT6fa7ohQILbrHUYkPVE5PRFFJzOGDvENYwZLhnPaflK2j+Pp0KrzsT6FdUycsKLzgRVGeV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy85F0lTJtNY06OoFzu0O5sngB34U3rW8N2AsYqn2v1cKARUjHD
	PNef8aVEPlTUewmnqmrrOyFKdK4vdZ48Vm24qa8DU1x8cJHhvfed2KjjLfytBw==
X-Gm-Gg: AeBDiessqcMrCIyYQNGpCHnSmZSUSrhajixJH0/LZhKCr1jzoVRS9t6ryogbPHubL4G
	Mww/qR1pXOS83V6W7Q0DU6ElGygygt4+4VJpuFdpQHCpU/P3gSO76bWRTXm5KkAeg1PbdmGXavW
	dbxN3kPpJY9hV7lUO3zyDoZ0F+aQ6Tv4obxAY/mlUSsWhhT96Lj7OLAXk1/tMoZ6Ud1g1lR4y5M
	u69LThUjXJKXEYYBrKBBcFespBJ7xhM9LQ3UGibZpt0nKTjR4jBdOLH2wcWr8wA4GsnIuiM7cic
	brkfvs4go3H7mhohFFK8R6VWs1+QryV35ounMM+HMIHS0CVvpjN6f772jpUwNgMSIkE9xTrQfz0
	Sshr9w3r1mu/shNx0fzPj3ayEKIoRljmsQbs1xZ4FBclfZcmxjXv5PmsANE3XrTxK9CKLM81Avh
	7razb8g6jNy5A/B0FNCkuEili7QDTAfoHKV6I=
X-Received: by 2002:a05:600c:4709:b0:488:caed:5ccf with SMTP id 5b1f17b1804b1-488d68af17bmr14064815e9.16.1775796440369;
        Thu, 09 Apr 2026 21:47:20 -0700 (PDT)
Received: from foxbook (bfi125.neoplus.adsl.tpnet.pl. [83.28.46.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d689110asm10548365e9.35.2026.04.09.21.47.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Apr 2026 21:47:20 -0700 (PDT)
Date: Fri, 10 Apr 2026 06:47:16 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Jeffrey Hein <jp@jphein.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Alan Stern
 <stern@rowland.harvard.edu>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org,
 linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 2/3] media: uvcvideo: add UVC_QUIRK_CTRL_THROTTLE for
 fragile firmware
Message-ID: <20260410064716.1f5d69c4.michal.pecio@gmail.com>
In-Reply-To: <CAD5VvzCVxn6ehen4vzbzJzm3Akc-0BREhMZrfsffXTz782jQcw@mail.gmail.com>
References: <20260331003806.212565-1-jp@jphein.com>
	<20260331003806.212565-3-jp@jphein.com>
	<CANiDSCvsxP+npQTHUrMTp+Z8XULYKSLTz2AFu+WQnsLbRBGa2w@mail.gmail.com>
	<20260409100247.7cfb62d1.michal.pecio@gmail.com>
	<20260409221749.5e6bccab.michal.pecio@gmail.com>
	<CAD5VvzBQLGDrbrds=OrOOh5ptmVjP+nyq-jRHF5dCFzw+S6iQA@mail.gmail.com>
	<CAD5VvzCVxn6ehen4vzbzJzm3Akc-0BREhMZrfsffXTz782jQcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235565-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 285083D2269
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 17:24:36 -0700, Jeffrey Hein wrote:
> So wBytesPerInterval (8) is indeed 8x smaller than wMaxPacketSize
> (64), matching what you saw in the third-party listing.

Technically it's a spec violation if a device claims 8 bytes but
respons with a single packet larger than that to a 16 byte (or any
other) URB. Though no problems were known to result until last month.
It seems most host controllers ignore byte per interval on interrupt.

> Note that lsusb -vv does not decode wBytesPerInterval for this
> endpoint -- the value above was parsed from the raw descriptor bytes
> in sysfs. The full lsusb -vv (934 lines) is now in the repo:

It does decode it, but you need the latest usbutils version 019.

And there should be no need for lsusb -vv, just lsusb -v.
I think the output pasted into v6 patch was truncated.

Regards,
Michal

