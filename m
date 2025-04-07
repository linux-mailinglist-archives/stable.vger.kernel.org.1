Return-Path: <stable+bounces-128777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A5BA7EF99
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 23:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA5B3AC964
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 21:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CFD22425A;
	Mon,  7 Apr 2025 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nHtDf5Sj"
X-Original-To: Stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35AD22D795
	for <Stable@vger.kernel.org>; Mon,  7 Apr 2025 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060229; cv=none; b=pROFGyj438bJNc07okyon6YVkhhOiJ8aeSgU1dfRwxaVfC2wZlKk3jgJ8TIahJtlTzwVr6q6fLLaHcNVn2T5TEZPa0EXJZp7vbA4UO2AMVnpM4K3iaiPdt1rY1d7Fsq/totW5kMphbq9+VossdWcuFmL97mtRJAaMWr7hJyjJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060229; c=relaxed/simple;
	bh=Cs3JRT0u4iOUCEOdJXAbObwY/0a42FVTlXSMgmPRyko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkMrrqe7I6w34aqA9hwjjDyaDPyacBerHRdkrbuQtuDNsvDhjFMfI+PHU6ODDra0dznWiDSoP+c+i49ykrwTltJi7RUKR64AVaRZtNE/x+4jh/KW+w1FgDG2pjne0Mi+kLJ1j+REZDMX2U2+Gj6nKSm6fOqesyUwPLAELjDW9fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nHtDf5Sj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736c8cee603so266722b3a.1
        for <Stable@vger.kernel.org>; Mon, 07 Apr 2025 14:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744060227; x=1744665027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs3JRT0u4iOUCEOdJXAbObwY/0a42FVTlXSMgmPRyko=;
        b=nHtDf5SjYxrAiusAsz6oEI9QlbhkY49srhgYuW1a3/c8xUEp7bFuYnc4c3SfWEvV1q
         uaGZxoifApFI4euxTAPPecgdpRxHKfNEmlicER1EaWMxdmmGsdnegYx24NpMrPusamuU
         W9b9G5u5dmy+4QWhR576zU7+QyfJpp1hEx95M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060227; x=1744665027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cs3JRT0u4iOUCEOdJXAbObwY/0a42FVTlXSMgmPRyko=;
        b=SMCBBHYgWYCgNfLjz7+uFDl3tYX6jpSaFU1jc5jIpvm/C3EWlxMSiJqepDBixWn97E
         CsqauxN648KkxQDp4FkHqKU7W9GKxEoev54HEcOj7oRQhoOsok+dTxjk8mhn2g/NM09S
         ENjJc5k8hsT44AVNwfX3OWWqwCxngOTM7WSIYvsUzSKffirwrZ1DEK2kkWkiYgOx1E4q
         7VUEmJC1OGu+z9cFnaCROpxVjFNwHF9nMc+/bVTxmP2hxn+mD09tVYygeK+u85GOV82L
         VI3GLDFYFKbuNc//i/pBuwRN+Iu+SnyjMWqqliuZp92wuprmeyMZP7TDc92CSzv5wvDE
         vhKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVs7XIN30yjtWq93J+Qv9SAhptrpkiIYk0ek5PtQhi+7vE3QL1eFAukyy18wETuaT9frKde/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbuPa1vJWy5i5XgoHfNmMc1IU4w9LPzYhzXTlAg0lKc2nzwTW6
	WoO5cR+brKspFBSv3OjtRuNuDCSDJ38R0hbn++vzddBqH3PDVdG79X2vw9e7FBjou+mr/Ghlexk
	cGQ==
X-Gm-Gg: ASbGnctEOeyPzWOal7mZ0Hbek3Lxrd478GLPBMpFdO+sEjs5SEtTTOkW9PPTLiUywqb
	oHLvkylcWjyWVNmxYGoxAhxpVlmGDOzbitlUlIVq6iUCJ9Jth9VYpfXvAzjx3Eik/LPZOGrzFTi
	+OELx1JS2JLj1lrJVLqv+y6XiUxPT/d/KjbrgoO2wQplDYcLuKswCBP7g1fqdeQxgkUO28g+peU
	mszMIcJba2665ng/8jbrXYbKoI84Rauq7cb1qHa9UiVy8B+hJt4ZNfoLzopWsHNPjOdhdNMUdX/
	vXXMTl5WmWsvU2KXvuT1aB0Bm7XozwiLG9yr6lO0mehln7ENBZUU+x/zuGbA3ON6A9ZTjQ2IV19
	zwXB4GI91UE7AgsqW/Ec=
X-Google-Smtp-Source: AGHT+IFkqJm4Y73iNctPDTVY1HPO6b+j0Rbl+hYMGhJiNPRkxcQDhBFhDkQA1XO6IV0aZC5PEaNF/A==
X-Received: by 2002:a05:6a00:1145:b0:730:9a85:c931 with SMTP id d2e1a72fcca58-739e4c7bb18mr6484811b3a.7.1744060226623;
        Mon, 07 Apr 2025 14:10:26 -0700 (PDT)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com. [209.85.216.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b430asm8995131b3a.150.2025.04.07.14.10.23
        for <Stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 14:10:25 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3011737dda0so3541861a91.1
        for <Stable@vger.kernel.org>; Mon, 07 Apr 2025 14:10:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1IJdresT8gyXsq/ZvFFedylC7kR5aqnXXbF4gXqDClBFANQDxu5seBfTrhHlBleon6glf2V4=@vger.kernel.org
X-Received: by 2002:a17:90a:d646:b0:2fe:ba7f:8032 with SMTP id
 98e67ed59e1d1-306a485e486mr21065018a91.9.1744060222504; Mon, 07 Apr 2025
 14:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d6f5f854-1294-4afa-b02a-657713435435@redhat.com>
 <20250404160025.3ab56f60.pasic@linux.ibm.com> <6f548b8b-8c6e-4221-a5d5-8e7a9013f9c3@redhat.com>
 <20250404173910.6581706a.pasic@linux.ibm.com> <20250407034901-mutt-send-email-mst@kernel.org>
 <2b187710-329d-4d36-b2e7-158709ea60d6@redhat.com> <20250407042058-mutt-send-email-mst@kernel.org>
 <0c221abf-de20-4ce3-917d-0375c1ec9140@redhat.com> <20250407044743-mutt-send-email-mst@kernel.org>
 <b331a780-a9db-4d76-af7c-e9e8e7d1cc10@redhat.com> <20250407045456-mutt-send-email-mst@kernel.org>
 <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com> <33def1b0-d9d5-46f1-9b61-b0269753ecce@redhat.com>
 <88d8f2d2-7b8a-458f-8fc4-c31964996817@redhat.com> <CABVzXAmMEsw70Tftg4ZNi0G4d8j9pGTyrNqOFMjzHwEpy0JqyA@mail.gmail.com>
 <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
In-Reply-To: <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Mon, 7 Apr 2025 14:09:55 -0700
X-Gmail-Original-Message-ID: <CABVzXAnLjNeTYFvBBXyvB=h63b-rkjncBMzkV=+PY-Mi5fvi3g@mail.gmail.com>
X-Gm-Features: ATxdqUE0HO7NR8RDwJ6zzKPsdwnp2tanOwCvCL2_IqsDFdqHWotUVnDaMU86evY
Message-ID: <CABVzXAnLjNeTYFvBBXyvB=h63b-rkjncBMzkV=+PY-Mi5fvi3g@mail.gmail.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>, Stable@vger.kernel.org, 
	Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Wei Wang <wei.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 11:47=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >>> Heh, but that one said:
> >>>
> >>> +\item[ VIRTIO_BALLOON_F_WS_REPORTING(6) ] The device has support for
> >>> Working Set
> >>>
> >>> Which does not seem to reflect reality ...
> >
> > Please feel free to disregard these features and reuse their bits and
> > queue indexes; as far as I know, they are not actually enabled
> > anywhere currently and the corresponding guest patches were only
> > applied to some (no-longer-used) ChromeOS kernel trees, so the
> > compatibility impact should be minimal. I will also try to clean up
> > the leftover bits on the crosvm side just to clear things up.
>
> Thanks for your reply, and thanks for clarifying+cleaning it up.
>
[...]
> >> IIRC, in that commit they switched to the "spec" behavior.
> >>
> >> That's when they started hard-coding the queue indexes.
> >>
> >> CCing Daniel. All Linux versions should be incompatible with cross-vmm=
 regarding free page reporting.
> >> How is that handled?
> >
> > In practice, it only works because nobody calls crosvm with
> > --balloon-page-reporting (it's off by default), so the balloon device
> > does not advertise the VIRTIO_BALLOON_F_PAGE_REPORTING feature.
> >
> > (I just went searching now, and it does seem like there is actually
> > one user in Android that does try to enable page reporting[1], which
> > I'll have to look into...)
> >
> > In my opinion, it makes the most sense to keep the spec as it is and
> > change QEMU and the kernel to match, but obviously that's not trivial
> > to do in a way that doesn't break existing devices and drivers.
>
> If only it would be limited to QEMU and Linux ... :)
>
> Out of curiosity, assuming we'd make the spec match the current
> QEMU/Linux implementation at least for the 3 involved features only,
> would there be a way to adjust crossvm without any disruption?
>
> I still have the feeling that it will be rather hard to get that all
> implementations match the spec ... For new features+queues it will be
> easy to force the usage of fixed virtqueue numbers, but for
> free-page-hinting and reporting, it's a mess :(

If the spec is changed, we can certainly update crosvm to match it; I
think this only really affects a few devices (balloon and technically
filesystem, but see below), only affects features that are generally
not turned on, and in many cases, the guest kernel is updated
simultaneously with the crosvm binary. I'm not opposed to changing the
spec to match reality, although that feels like a bad move from a
spec-integrity perspective.

Regardless of the chosen path, I think the spec should be clarified -
the meaning of "queue only exists if <feature> is set" leaves the
reader with too many questions:
- What does "if <feature> is set" mean? If it's advertised by the
device? If it's acked by the driver? (To me, "set" definitely hints at
the latter, but it should be explicit.)
- What does it mean for a virtqueue to "exist"? Does that queue index
disappear from the numbering if it does not exist, sliding all of the
later queues down? If so, the spec should really not have the static
queue numbers listed for the later queues, since they are only correct
if all previous feature-dependent queues were also "set", whatever
that means.

The way crosvm interpreted this was:
- "if <feature> is set" means "if the device advertised <feature>
*and* driver acknowledged <feature>"
- "queue only exists" means "if <feature> was not acked, the
corresponding virtqueue cannot be enabled by the driver" (attempting
to set queue_enable =3D 1 has no effect).
- Any later virtqueues are unaffected and still have the same queue indexes=
.

The way QEMU interpeted this (I think, just skimming the code and
working from memory here):
- "if <feature> is set" means "if the device advertised <feature>" (it
is checking host_features, not guest_features)
- "queue only exists" means "if <feature> was not offered by the
device, all later virtqueues are shifted down one index"

---

The spec for the filesystem device has a similar issue to the balloon devic=
e:
- Queue 0 (hiprio) is always available regardless of features.
- Queue 1 (notification queue) has a note that "The notification queue
only exists if VIRTIO_FS_F_NOTIFICATION is set."
- Queue 2..n are supposed to be the request queues per the numbering
in the spec.

This is how it has been specified since virtio 1.2 when the fs device
was originally added. However, the Linux driver (and probably all
existing device implementations - at least virtiofsd and crosvm's fs
device) don't support VIRTIO_FS_F_NOTIFICATION and use queue 1 as a
request queue, which matches the QEMU/Linux interpretation but means
the spec doesn't match reality again.

Thanks,
-- Daniel

