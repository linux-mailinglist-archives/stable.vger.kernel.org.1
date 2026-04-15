Return-Path: <stable+bounces-238221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AbZ3BIEH4GmXbwAAu9opvQ
	(envelope-from <stable+bounces-238221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:47:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7619F40845E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61E31301DB9D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7644438E12D;
	Wed, 15 Apr 2026 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20251104.gappssmtp.com header.i=@lixom-net.20251104.gappssmtp.com header.b="TSeDHxhN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0592F069D
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289656; cv=pass; b=EGlXyJuIkJxm2eH6DgWHa4ZOPlgwnp7zkUWII3zFCpYxEXMvwRnqSDEDpwp85LkHrAAsjj32RXLjo2r822N0C/RXHDbZoVy9WQgu9hYOGVfR6r//aoFySERyVszH+rnWAqtHw7e3bv4zg3xgEkCG+V2aSMLvKeLIkgRSLHBIpoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289656; c=relaxed/simple;
	bh=cqfM3p3dtURbZdqvd+c8DRkDzgdh1jmbfZ+39j58QNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUj3QKOzer796yzIan3Uq6ObxgseGbKzHZV1n47gD9Se3oKySRCWskkEesz+PEnA2/S+vrz32j/DeKAyoc6MmLSSJWg7nbQAd505UZz6Z4GUNyU//yIXE4B61b1wEdlWnOJbGlAL9R5suf7w9hruZdYVs9zvJfYdxpxRPNx7QIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net; spf=none smtp.mailfrom=lixom.net; dkim=pass (2048-bit key) header.d=lixom-net.20251104.gappssmtp.com header.i=@lixom-net.20251104.gappssmtp.com header.b=TSeDHxhN; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lixom.net
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50b3488fb31so320681cf.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 14:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776289653; cv=none;
        d=google.com; s=arc-20240605;
        b=b3wuvA3z5/0Tvaom+OoV+PoNGjVx/m3GnJn05QihUuuFPVsanO+ERNs+7YvM4SlSgV
         UBXArH8MfD8VP/UHn8arrNmmnmNw+ib7PnYAVQi9VsL7rop+erNE+wR7cSr0KhmcDSv5
         3jdYteDnM5+yjKD7Hdk27GalV4hUH3PI1hhjD23UTUHeJ8hA/jfMW+jpU59ozEDrAfxq
         c3D5kJ3K2lpvJElokOMvf2bfa2ouqiHkIxBzj7rl3DQdM0bgTMn3zLTkdNEGjLpCygf4
         Ne6FiXIuYZSiUlxtr1VdVQzzvrby2xkMA94y5H/YbowZr/j+aM9cr5Nsw7MQvJXA5sOt
         bk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u3U48THEC4nMTtCBDzNK0NRPPsHr3hu/KLPlfI3gXgo=;
        fh=KYuh8pA0YWHwVzMw7UB4pWAM7tkym/CCddK6Z73jbko=;
        b=bS0BGUVNz8cPDlVbj7lECQQlQd+mQBNvLLV7VYHLPwUqoiUu7+XicZSJcb6/lf8ADO
         tLKIw3O5XjeWmfBeRQGdrgkols3NAz0edp270plF+2gHsCToaLdl7ivEXQexExlST6Ql
         GjZXx4Yu4XqfNefizd+Z2JEHnsuPEO2VZg3hKG3/2zyBEw0w+DEztCB/EjUatkpu3Poe
         qpAImOGQYrYr/QKbvy1yNjBtqIofujvI8kShzlU+x5RCfZMg20gGskHvTKnZXnbkd3BB
         4W1QWzwN0WkKVEj5rai33N59f5TdZ7YAcx7zMWn/nEPQmkgYz7DRmzHvr2AMMuQ0XjBf
         VeTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20251104.gappssmtp.com; s=20251104; t=1776289653; x=1776894453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3U48THEC4nMTtCBDzNK0NRPPsHr3hu/KLPlfI3gXgo=;
        b=TSeDHxhNN8ktUlEFISZ1RHG3B4iioHV+bgwAqZqV5JGGxEA4EjmxhgpIWXeX3V4lz9
         v44zu7JMWlBF04/LQbhHee2UX6Yne2VMYsVAM9a4Yedjr1ODOAY1L56C+3VM3IXyLCYi
         8S/l//nexdB+zS5ByisMv6U+xrxx/TWrWDL7a0MNmoaowAGtwNCgCr6D4uMz8GEaSCQa
         qCLpFneZeyMLKRCd4jIpoRgWIxZ7laMOsOmNfP+gqEbamuUGoeaNP8mYAH9QqDe/UmuM
         6kyFjRz5as9MPsi/FUAN7/OlUET2ogsqTeHdCwDAGOAq2YApZOVpdfPn8prIyxv6qQKH
         xFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776289653; x=1776894453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u3U48THEC4nMTtCBDzNK0NRPPsHr3hu/KLPlfI3gXgo=;
        b=Lx5Kei4F8y0VYUd+K0XNR+wj/Kf+uCXJDuQdkgFXQSAlONvviOCh/HAZEpVI83OD4f
         nArCTHMw/dazp5f+DFZM0yl2zymhkaxebu+Du75s1zpS7AI+7gjOw5PtUEpbc1v7bFML
         zMVyuFyVfBe714abnnaPoXoDCCfkOA+BwOOZxmXQtudmrgpdpRZDg3OS0L3dX+ywXy9U
         swjWaLQCIVTML7Y/+qQU20dL920iub43D6z9EpO+RbwktFb6Hcd+zk/z1tGdrKbsygwr
         5JLWgCPDs9KAC8mc2YjWX7nPwT0JAeSwJLm7q6rRsEgnQIuzrmUijTJtZbtrKGRLBD2u
         jj5g==
X-Forwarded-Encrypted: i=1; AFNElJ+mhBkKJPB9f+m3tmOJPSbiAVAAG2nDsaPvJXBfQh+Dmkiuul8h9Qy53yBbVBYtLvf9Gwa+t1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KzfV22Z+WY7ZBPIHTcK5N6ORdLK9Hql6X+m79NW7mD0FrQ2r
	Y7eqPUNFl5n+eHyUikjdVVwpFyraeQqLXupWPf2vaLHzlyXcLpe7FgU3iCtty4RIS31AkV9sOxa
	AeSneUUmfFzHDVXCARckHZrGAsyeGtLLMNKMYIRbJZA==
X-Gm-Gg: AeBDieuj3P0RMpyJ7bfuqIa9oUNLkyjFBllbCvBSdyRoeT1ZRY6WCXX+msnV3ICbOU6
	uJpGG7/r6MmXtIDJL+0ZDTICBMKMVWYXjnWlvTAfpDiqUrVVbIAwASIOOrViMghFuigGQU5rOSt
	yTwlgyKJft0BwdqZEy+hHgR8vPC7Lbu8wYD6Kh0S2xCTf9HPDyKDmcY6ziMvnyT3FGbBhbPItuZ
	dX//bFr7TckT2pEMFhqLd5zEL0JygpWgfZd52Vz8QhrEx19WHq2uO0rMXGNFanPM/LMCAC2f4NT
	zt0TLOs=
X-Received: by 2002:a05:622a:5c13:b0:50d:7eb4:4c5d with SMTP id
 d75a77b69052e-50e24b5639emr20852491cf.21.1776289653609; Wed, 15 Apr 2026
 14:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415175038.3633384-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415175038.3633384-1-lgs201920130244@gmail.com>
From: Olof Johansson <olof@lixom.net>
Date: Wed, 15 Apr 2026 14:47:21 -0700
X-Gm-Features: AQROBzDIYTuyQ86-JK9iO8k9ZnW3TX9j6sPqHLmUbcGJ5w8ppMKCOhRl4NRHgrY
Message-ID: <CAOesGMghHi5bEcec9L6d1YUec0Cn5uEs8MrjdoT-zHSr-FJ8pQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: fix reference leak on failed device registration
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[lixom-net.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[lixom.net];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238221-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olof@lixom.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[lixom-net.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7619F40845E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 10:50=E2=80=AFAM Guangshuo Li <lgs201920130244@gmai=
l.com> wrote:
>
> When platform_device_register() fails in chromeos_pstore_init(), the
> embedded struct device in chromeos_ramoops has already been initialized
> by device_initialize(), but the failure path returns the error without
> dropping the device reference for the current platform device:
>
>   chromeos_pstore_init()
>     -> platform_device_register(&chromeos_ramoops)
>        -> device_initialize(&chromeos_ramoops.dev)
>        -> setup_pdev_dma_masks(&chromeos_ramoops)
>        -> platform_device_add(&chromeos_ramoops)
>
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() before returning the error.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: 9742e127cd0dd ("platform/chrome: Add pstore platform_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

This looks like slop to me. It doesn't even compile (there's no local
'ret' variable in the function already).

This is also a no-value fix, the chromeos_ramoops structure is static
data and not dynamically allocated. Please don't burden maintainers
with these kinds of "fixes".


-Olof

