Return-Path: <stable+bounces-180383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6ABB7F7FC
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80357BA07A
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9825F31A7F8;
	Wed, 17 Sep 2025 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eNrKgr6H"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C433C765
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116394; cv=none; b=KPIzJoVY9zqc/0MeW9TRMcMBUDQIHMPqW2XL7CKekkuqSoG1ovle2H4tbml8c0jYZIXQ9ZBWmKR/HZVhr4dxbTSjZAgT9GGAjOgcYrZEm7xQiEeihscaWvxVQi19LQXDP+1H6FDIGKFQQq6zzKKyJIG8kJJS33k/KuwqO+FcTEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116394; c=relaxed/simple;
	bh=CBeHfXnYYlNYf7/y5kYqb3+gL7o7P/FRLBOn34fqRSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3cYwFmVHaM7W/eHSlCDqUOuryMBsMNu2tohazQLanVMOELr3Oz10aUmAX8OF+cbAmiENRUCq22aOLyyEnzlGwUKYbGTE4wjwY1iQl+x0eT9I8EdrpPIpd0YW6D2IrRqBo2EYEW3pDu9zZk1N+EUtS5TpDXwC13u8O2DCJMkeCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eNrKgr6H; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b0415e03e25so854558766b.0
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758116390; x=1758721190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBeHfXnYYlNYf7/y5kYqb3+gL7o7P/FRLBOn34fqRSY=;
        b=eNrKgr6HCQwQDC+GJgTjsluPKiV+A5hlNfqMKzhdYFBYDlFzX0PK5F2q64pQsT4J6W
         HTPma8M2FVFigPOQKFureNFyDWaNg1XubtMXMWWs8b+d8+AJGYXvkPCChf4xb3HyUOIs
         qoeVRGe9DxZiub5qMDNqQ5TUKgciXbDHlO7uM6Q6uZ05CvjtDg8308qjWFHCI9ZAJxye
         hvdsH2AVsq+TAMpKbjp31hu/0wsu0wOh2QVpdcyWU6elak//eb/TY+cEmZtNHLxUBCLB
         oB4BiWjcfoydBDkjL7x/9XrD5vxL2UI5ByyOcjOMv5uXWqHnD0SUYMWkWWWyQg2hGWOy
         ycIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116391; x=1758721191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBeHfXnYYlNYf7/y5kYqb3+gL7o7P/FRLBOn34fqRSY=;
        b=U9zAh6KlDhfzt0Xkq1yDiVYHSIek+OPUpJ/a+PWlO+oOhCu9XBbAf48YNJ5nDxOF5c
         MtfmN27P/QI+JqNXHE0rj2WxpY/yaiYxJznRPvbmO10ggz9fwguhq9YriyNjq6FuW5Gk
         GgEUIv3JnRhL/nHOJOWMzBXJyU3688aBEJYEoBnAwNdXHOI+Yjh3b8kdIGXfL5h9wFZn
         XegAKfIy3lXV8CWUPgg3TN66f3IMTdTrxK3O2cRuY2luHqaBz9G4NQiJQ4otaW8agxHL
         C0m/lTWYX3UZKXEP/OewuuoNxdLBGSvqrXubMMpfjJM/b2ke7jUSvzZ9LTgehjF2VrzB
         8slQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7VB/9kbV1sw4eQv9ognqzNg4UaQPmk0D9VaTTcAvE1UT+o9YNcqy30Gy8ys5eik6zMNXGHNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRkxeF6sie10RcvEBrJWne8xhsOztKztWAglQmcsv0FtiBdEz4
	vIOev0easNGIFhF0ek1qEmEt7HhdRafWr4fp2AKBy27naIN10SdSF1kOFE+yslpXNfrlOufymxE
	qR6t9cWirOBkQddQshWqjA0F/GI+KJzUUrwlovoUKpg==
X-Gm-Gg: ASbGncuvzq4/9ApnqGMAEAV+R/riVBq1UulqjkKSdOsAIvDgf1TxBU7LSgyKTeavHuo
	StpiuL1jv1kZ2Mtu+QH0BgsoPhcAWKEB0Ru1OAG/5O1j8e7XcVpxDXN2SuyN4/yVKqzvFDLAklw
	SH0FJVtdXLAMNsePDnbxRif3tkYwoOUzgYW+ySveSu8OALpBcEf3SbW656v6AhAHI4WBB9r7SxI
	/WfypvZ1iw64opscVg8iZ/qJujCp7IY9MVC
X-Google-Smtp-Source: AGHT+IGqqKefXP8WxcN/+l1jwy9unDcdcYQ+LOIaW5Cks3BIj9V+aI0trws7o6JbFaSx8xHpY7sjGGzFBBSJONjxZms=
X-Received: by 2002:a17:907:9687:b0:aff:9906:e452 with SMTP id
 a640c23a62f3a-b1bbb0678f2mr302885666b.31.1758116390548; Wed, 17 Sep 2025
 06:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
In-Reply-To: <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 15:39:39 +0200
X-Gm-Features: AS18NWCdr6GqUOQd4v8IrrCyA7jXtDhoQx-mp5NUMtPzl5TNlq5K2XQ23QjAEV8
Message-ID: <CAKPOu+9nLUhtVBuMtsTP=7cUR29kY01VedUvzo=GMRez0ZX9rw@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:14=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
> Does the patch convert literally all iput calls within ceph into the
> async variant? I would be worried that mandatory deferral of literally
> all final iputs may be a regression from perf standpoint.

(Forgot to reply to this part)
No, I changed just the ones that are called from Writeback+Messenger.

I don't think this affects performance at all. It almost never happens
that the last reference gets dropped by somebody other than dcache
(which only happens under memory pressure).
It was very difficult to reproduce this bug:
- "echo 2 >drop_caches" in a loop
- a kernel patch that adds msleep() to several functions
- another kernel patch that allows me to disconnect the Ceph server via ioc=
tl
The latter was to free inode references that are held by Ceph caps.
For this deadlock to occur, all references other than
writeback/messenger must be gone already.
(It did happen on our production servers, crashing all of them a few
days ago causing a major service outage, but apparently in all these
years we're the first ones to observe this deadlock bug.)

(I don't know the iput() ordering on umount/shutdown - that might be
worth a closer look.)

