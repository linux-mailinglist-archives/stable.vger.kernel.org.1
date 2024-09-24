Return-Path: <stable+bounces-76988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5CF984568
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 14:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3519285C21
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 12:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5621148823;
	Tue, 24 Sep 2024 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB21x9yd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D3317C222;
	Tue, 24 Sep 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179283; cv=none; b=uSu52zIUrZJmjK/8AXqjN53D/4Ig9LzRq9aivj4h22992G3kZ741ofQitm478aj7GVCbWMJysqtq2pzrTrD2S/XK4hG76g74ywN1Ir+JZMEElvXtszpE60iu0AuFsnZLczm+KEixI1IfvPJpP4H6nB07qeRFoJljxc8N9f7vX7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179283; c=relaxed/simple;
	bh=D2wkM8MceUdpaz5tbti6HFcDG2ZYxeGIAjkCyA9IpVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=py9z1e/XX3/Sbu2uGFtGDgENusNAzHHiGm777AV5uhapVP/u+jPnjwQIC/bgaKXj/1EWG2xM2H9EMncjXE8ElnwjsGzyfTs47Lzu+LJLSTbThMT8QCAi4IrcJE7Fzl0wkx1C5TYXtyRcz/2EbtQKApEOYWs+uwv1uEMv763YQOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RB21x9yd; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a8d446adf6eso840633166b.2;
        Tue, 24 Sep 2024 05:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179280; x=1727784080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D2wkM8MceUdpaz5tbti6HFcDG2ZYxeGIAjkCyA9IpVw=;
        b=RB21x9yd1leqUY7hB/C+obVNjtMUBvxqM+H4RCkr0HaSVNfZVaPBenSYhB2DKnlHIw
         pCZZkTofN7iKE9CaxuajkAB0tU7ndlmQJAwW0xFGmi3lqhC6QZkUzYmnheibNXlWCTDa
         BrnNn2txFKbCHvhUBoFt/wKTpL/GxLwCFCqtxhLAwNHWrqb+M8IudyP5FjbFV6DPOWiS
         YE3k6MUxeH1p++Pv8L8OyvOY/L/1Rdtqxe6W6VG9AclFJ0zUgRgr0C1Hevnz3CiRWmtk
         lY4Hs0aNh76mAO6DfrSwFPFi7IgwhDo+rRiqKAjTVI4tsWSkNOJKFJc5Ihzm5h2YtYOy
         D8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179280; x=1727784080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2wkM8MceUdpaz5tbti6HFcDG2ZYxeGIAjkCyA9IpVw=;
        b=toN/hjoYFNkJe+VNDUKp93nQ+M6YHFhbyAIFqPMFgnuIrRsxgfBPCPZWnYPb7vn3cm
         3DBDWvQiqLpEZv4h9aeuTmV5c7o9qle1rCUJhztTvaGdDxSICZqD3rx3lEoSXp5SpyeK
         7dx6HTqYlh46QW6MNnjISfc21APTMBSEDTTlyjQ89zCTmGjdt0ZgIlLpDmDXU/+jfQGm
         /kE2gEzpoNkMBb5YN2PEyxMCh1DDRNgOmbNR82FWpiX0FM8oxMZsQV+89J5KOIR/0e/N
         E7lS+HtjJNs4wDrsxIRQu+CeIBKOo5jLIEJKysf7+AZvVsVXQrTtc6vqEsYykvAyDXgI
         sKrw==
X-Forwarded-Encrypted: i=1; AJvYcCUPmTDeGGqVgtRPvS3tllzbIEaeBWaPuLTeLIFMF16iBwSppkBQjcLVxFeI2piliw+rkyQ65ueB@vger.kernel.org, AJvYcCVUSQQ9YHT7ZnxdhUy7DXjvxk7yaVaPr6pQ7ki/zrQzmJVOTFJ+OCivK17ZqQ4NcDP3UGn4AsGeUD26uOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB9ashJ+a5ylrcO/s7pfC6KMNYYY00CpGLCFFZBuQ6/Ve/FL7d
	6X+pdmXcutP8jb1qw366KQI/ilWXSNtg85+fxy67x8QocE+DeXybVsVIjq3Q+NgbU9TkizgBNtZ
	Pl6SpJFi9i8DI1aFen5/YHoGkS14=
X-Google-Smtp-Source: AGHT+IFj3aAX7TONduQVRl0aDVye9cHiXiB1Q9dRt5Ij0vv8gJiBD7Z0JZgMv9QkrrMa2dqXYtZEeUy71igP0MXxbek=
X-Received: by 2002:a17:907:e246:b0:a90:d1e1:eeb3 with SMTP id
 a640c23a62f3a-a90d50d0521mr1357512066b.44.1727179279902; Tue, 24 Sep 2024
 05:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913091053.14220-1-chenqiuji666@gmail.com> <ZvKNVut_V9fiiaaT@phenom.ffwll.local>
In-Reply-To: <ZvKNVut_V9fiiaaT@phenom.ffwll.local>
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Tue, 24 Sep 2024 20:01:06 +0800
Message-ID: <CANgpojXKgZXjeCO9MYr83=p-Kz0_Migm4c9-4qTidHYp=G+fMg@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: Fix atomicity violation in vc4_crtc_send_vblank()
To: Qiu-ji Chen <chenqiuji666@gmail.com>, mripard@kernel.org, 
	dave.stevenson@raspberrypi.com, kernel-list@raspberrypi.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, stable@vger.kernel.org, simona.vetter@ffwll.ch
Cc: daniel@ffwll.ch
Content-Type: text/plain; charset="UTF-8"

Hi,

In the drm_device structure, it is mentioned: "@event_lock: Protects
@vblank_event_list and event delivery in general." I believe that the
validity check and the subsequent null assignment operation are part
of the event delivery process, and all of these should be protected by
the event_lock. If there is no lock protection before the validity
check, it is possible for a null crtc->state->event to be passed into
the drm_crtc_send_vblank_event() function, leading to a null pointer
dereference error.

We have observed its callers and found that they are from the
drm_crtc_helper_funcs driver interface. We believe that functions
within driver interfaces can be concurrent, potentially causing a data
race on crtc->state->event.

Qiu-ji Chen

