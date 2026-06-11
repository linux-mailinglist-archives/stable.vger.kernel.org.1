Return-Path: <stable+bounces-262653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XvvnCQWKKmoPsAMAu9opvQ
	(envelope-from <stable+bounces-262653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 12:12:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D99670BCA
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 12:12:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=jQH+Awhi;
	dkim=pass header.d=redhat.com header.s=google header.b=QR3XvazO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262653-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262653-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE22530387BF
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80323CAA55;
	Thu, 11 Jun 2026 10:12:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D5337B400
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 10:12:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172732; cv=none; b=VPWb/KahcjONiC9j8lK7rY6cw9rFlstFvB9W/W+RJ4gy+KkGZtmcSSG7gLVhfwBGEEWDVhlbRmkRwB8yDQAixnBPFcpRl26HwlFqzpoxC9AQoGCM/NGXuzyLCPwAHBJWSXaSvU15G4ES5pVjSTLB+4X4rojRrm1jG0Ba3oDC7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172732; c=relaxed/simple;
	bh=0DTkubvoxHBUMHmj/JTP8y1M7mVG+8twCULO8Aq9NZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZsJMF1T3RQ/pcxgenJwmKiXiEuheUAQGxa5Jt/+4rKD7j0MNEtMTIAq9Aqvn/DwuNgTgVP44tQHbkdJ+lZChtTGdZroOYbo4fTeIpJhSri9eMT7yUeSSiGkV3ErY0N7aGN4DkT7+b/PTgr8OJeWXW+BlE3SMFuG2/oVfiV83f3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQH+Awhi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QR3XvazO; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781172730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0r9Bb05wU768Bts6kNipr0zjojivSJzgQogOHI5wH0=;
	b=jQH+AwhiNYfDNE+fpr4EyyfDzX+dLcde4fPwRfQtPkFv4U4Ir1NylXa63M2xY7sHY9Lsh0
	2QjNaTT2VebPP1X4WLmCuDf8Q08O5dzGXjc8KU7LN722trj0LbRBVADxg9kRbg8AOdBkGb
	FynE6i7WfrFwElLyvj9LvMXWaXI+0/g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-5gQ5w5F1PraTJ7ueB5WNgQ-1; Thu, 11 Jun 2026 06:12:09 -0400
X-MC-Unique: 5gQ5w5F1PraTJ7ueB5WNgQ-1
X-Mimecast-MFC-AGG-ID: 5gQ5w5F1PraTJ7ueB5WNgQ_1781172728
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso36863955e9.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781172728; x=1781777528; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0r9Bb05wU768Bts6kNipr0zjojivSJzgQogOHI5wH0=;
        b=QR3XvazOsjMUZk1ZXGzPlbIZJ65yiI1gk/o8VU5XSCgCZnJU8bl/twjoPQcdWbAdZX
         KdJ1vgB3WkGOxvyKlFmJzbxZtpUueoWp3eAMZRtTpz+PPmZoA9RbiKe5RdzGtJiUqnvS
         WVMqE+L/7wg+2Y3lczY7UNyXATbYk/0Zn/nfBSN/MwdTyAgfkHBq9bPh7QeAHhniaUQ/
         2NLUM/XdKhD+zdEqQlCdebSKp6IH3YdUT0fuLpL5IiNbG+dmC5429KH3FOX/v1951u1G
         8lP3yXir0mDlJOPir73L2UAUEoXWBLzqYyWcCyK0OvdEsrIa5MgaGkE8GANZORZtzRWY
         U15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172728; x=1781777528;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0r9Bb05wU768Bts6kNipr0zjojivSJzgQogOHI5wH0=;
        b=mXX8uc76dqeV7g+3ci3fimzOjGjCRQ2pvenuo7R28KIu+SVRFdcMwHYQ5FIGY5mxlF
         rXPqdAUn7JTF9tjptGLoOnAEuxaCq56lJACvkPJIc8SMSvn0jhGkcw86rNSU0M+Z/oP7
         6zET/AJ53wjI9qmKRaXUy6wDfp+UofClU99ZhCADaprSKa/a6Z/aMAzRCq9xcfrAUqRF
         nvbkNuL7i1TS9YjfyXtCfS7IOUcHbBIGAnYBV3JIY682g7OQJBCdIGNApbHsvIvW0Frd
         wp5eNG/zOsu9l1p1sPg6QygWcIyAIbY1T4ZpnayTF0Yhq0p3QrBvlUmJeJqbM0JvGlzl
         r9zw==
X-Forwarded-Encrypted: i=1; AFNElJ/n3jahccXFJsUXCYfebuhnQFFs0JZkBAM3t66OJrEFMSnteao/nVV42XI45x+DbQQQx7rQFV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQGdPL8O6EiFkCmLcIn4LAuJzLD7kOWtnvlJwLQc4kD+ZqmaT
	JwxmjB98Yg2YKuSh8VLVeSilAc8pqQvUUL7/xUNClDF7sy71XVdkk/H1n3ePAZvl+8O23e30ZBB
	kulBREvJlCZzyXciygi7xdrKoaegOOmA1nP2yoA4m3IbJzjboqN4iNet9VA==
X-Gm-Gg: Acq92OGe1RUvt+0AwhSiyt8jyUo6CdZicUSxgoQNisjqbjxP1i0M/BcwgKb3ReR+hS6
	nfv+xzDhtyALhZ168/NdVyXBZ50HQiqcPjYWrozfQJQQOMSXdP2NKbkSzitBT+v5981cYAkdsAr
	ysPEaHYt8BDHYBomjBcL2PW3eLMc3j1nut/7DHhR+mqM9KiSOk3FxyQWASoRQTDoOtKgrHdNVxl
	awVWlZMJ16kGToR95c6bCgqNiIvBPHp2GyMR0XYjfV/5JiSQgnZIlHCdTjfH2qvxb9i1Wl6nh8/
	WiAWgoohwx1yl3+TNmw5Olrc5+hFMLYzkpOqI4hwbkZu9916+7qGMbbR163j3c5OITVV9GuBAjB
	1JbuPh8u813q4BZZsaQEV6kwGTbA45T2qHjWaK+Q3k+LIgeJUBj5jaavRy5b+5qjLkoRgstnK0Q
	61773PVayKbkWMiFE=
X-Received: by 2002:a05:600c:a39b:b0:490:c08b:b24b with SMTP id 5b1f17b1804b1-490e5607e3cmr15876145e9.26.1781172728119;
        Thu, 11 Jun 2026 03:12:08 -0700 (PDT)
X-Received: by 2002:a05:600c:a39b:b0:490:c08b:b24b with SMTP id 5b1f17b1804b1-490e5607e3cmr15875655e9.26.1781172727683;
        Thu, 11 Jun 2026 03:12:07 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2d09a85sm51975965e9.14.2026.06.11.03.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:12:07 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklkml@zohomail.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Zack Rusin <zackr@vmware.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 03/15] drm/vboxvideo: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-4-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-4-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:12:06 +0200
Message-ID: <87se6t5qtl.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262653-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[javierm@redhat.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tzimmermann@suse.de,m:mripard@kernel.org,m:maarten.lankhorst@linux.intel.com,m:airlied@redhat.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:admin@kodeit.net,m:gargaditya08@proton.me,m:paul@crapouillou.net,m:jani.nikula@linux.intel.com,m:mhklkml@zohomail.com,m:zack.rusin@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:harry.wentland@amd.com,m:sunpeng.li@amd.com,m:siqueira@igalia.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:tursulin@ursulin.net,m:dmitry.osipenko@collabora.com,m:gurchetansingh@chromium.org,m:olvaffe@gmail.com,m:dri-devel@lists.freedesktop.org,m:linux-hyperv@vger.kernel.org,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:linux-mips@vger.kernel.org,m:virtualization@lists.linux.dev,m:amd-gfx@lists.freedesktop.org,m:zackr@vmware.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[suse.de,kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,zohomail.com,broadcom.com,amd.com,igalia.com,intel.com,ursulin.net,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javierm@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ocarina.mail-host-address-is-not-set:mid,vger.kernel.org:from_smtp,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91D99670BCA

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update.
>
> Test the flag in the primary plane's atomic_update and do a full update
> if it has been set.
>
> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
> to ignore damage clips") introduced ignore_damage_clips to selectively
> ignore damage clipping in certain framebuffer changes. Vboxvideo does not
> do that, but DRM's damage iterator will soon rely on the flag. Therefore
> supporting it here as well make sense for consistency.
>
> While at it, also replace uint32_t with the preferred u32.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

And for this one as well.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


