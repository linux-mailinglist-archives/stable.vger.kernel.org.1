Return-Path: <stable+bounces-75741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF4A974298
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 20:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A632899B2
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564FE1A4E70;
	Tue, 10 Sep 2024 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd6Umo48"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F2195FF0;
	Tue, 10 Sep 2024 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994109; cv=none; b=cVjz5xTJp35nawdvPZP/gVN232wBImtprGKNSdOpwttbllEmubdfA9WESK4X2OvMnwAK5xzkazwyOqkylXoLELb5Mcf8r1XkgIfMLXVt1s2cxzPXZqkw2yfrHOwU1Gx31vf/ytaa/HEV+zq9+QDvhKB27EM1vW5Ec0ZM0kwtCoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994109; c=relaxed/simple;
	bh=d/xjSlwYNHaCmAEJ52/LetuJr/79SrxTHSb7l1iYHbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSnxkMKUFit29988xmBJ0YH5UBJXI9h2FU3zZBBajPzqQSKMsJDBRHVzEcul5VOiZd4tp7+mWgQKuV1mW57binE0mZx6w+h4rgH3Wa+06CQP/KJOOBO3e6NKprHYV61bpqxaZzNNpvqfNYWpm1BUabLdVxZp6aYGCKQHEQwZgx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yd6Umo48; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6b47ff8a59aso56578807b3.2;
        Tue, 10 Sep 2024 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725994107; x=1726598907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/xjSlwYNHaCmAEJ52/LetuJr/79SrxTHSb7l1iYHbQ=;
        b=Yd6Umo48uVxcjF9IM//3gLhtyocJfRjhPQrSbA5RecyBDDLyfak/ji0F1ua00KtZHb
         YB0hE3pKzgPEqjELIl4HiQvoPDSE53GtoFM8YFf24Lnz1PSR9JNZduSQX+nvAOxqS3P6
         EPJOOVN5MlrYqTRt+PZs4O4AjLk+nB8V1/ROpehcYywq3qqasEQUvgPsoaoqyzd09vZ5
         kuZ4z9YYh/WWrKcKFg7ac7JzS9VDBcuWH+0KpO2eyvWKHb3aBKYATg9U+m+7TgTfg9fw
         YfrWgbXqgBjMGvEA/Tq01jQudXrOaKiO0+H4u5SYRhf6Vbg26gNpaY0YYN8ZsFqlqPAa
         qFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994107; x=1726598907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/xjSlwYNHaCmAEJ52/LetuJr/79SrxTHSb7l1iYHbQ=;
        b=ZiOZBRcrTPdkTwwRTTw+33fknU1cDw9V5KKZk5+mhmUh1QD4rtdIzD8VXdSAAETE13
         3b0/LaJbF6jUNH04PANVrFWjciBsUUhLitEL9jzPZQaiMxZ+gKj8Pf6SnWvXsbcAHJF3
         RkQ8xrKt5U1o8UlurA+OpZif/K2sp4bwbJd+cQyvLIjBJOPEFC7ieM3yfeyyDIFBsSfn
         5ntRt0Q/2hND2gnz4aDucik7TdvIb/xnBJEBqfgO6JauIucptltwYtShI9pLLIx9YUsk
         SfgxuGlFlSxZbt1PSmAmFGmCAG1WZcMKbMByjpbJzJuC8L5wb6uw1jKswZKAth8SR4f6
         BgVg==
X-Forwarded-Encrypted: i=1; AJvYcCUCf3dGERem+F2l5GYePrCiiunzSrqEDa2Ar1GrHg1bGqZSJ1YWUE/dAmdA6GZLnoBFvjKEpyV1Jsz1mSY=@vger.kernel.org, AJvYcCXk5WVeH+NeqMoGvVke4YP/5S3v9y9n628VyeLZmiimqCjE3RW+06ou7p5vmXXMEjXYSoqwoqYI@vger.kernel.org
X-Gm-Message-State: AOJu0YyIOAQB+tUhZ//noZgOeO+ElcF3XuB1Fv2IPaf67RGx9WJfSOjU
	XPZ6QP0N3uCMYuSAIOswY09uiyWwb8/hgwMh3BkIxAcAme/K62y/Gt2E0V8tetZJJ8EWv6L2yaH
	fauxaOzsV3FIgoLRBZQ/1KZl/Pjc=
X-Google-Smtp-Source: AGHT+IFAr+8UZL5HRuL9rkDVnK7n4fTwY7nIMZfqU/kfjldcZ7+fHI5Jwzd1hLqSNjwRpN6xh0YAP7kz2ZQjZ4kX+4A=
X-Received: by 2002:a05:690c:dc6:b0:6b0:52a6:6515 with SMTP id
 00721157ae682-6db44d6c4a8mr192458857b3.6.1725994106631; Tue, 10 Sep 2024
 11:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALvjV29jozswRtmYxDur2TuEQ=1JSDrM+uWVHmghW3hG5Y9F+w@mail.gmail.com>
 <20240909080200.GAZt6reI9c98c9S_Xc@fat_crate.local> <SJ1PR11MB60831AF34B75030EBA3D5721FC992@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60831AF34B75030EBA3D5721FC992@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Hugues Bruant <hugues.bruant@gmail.com>
Date: Tue, 10 Sep 2024 11:48:15 -0700
Message-ID: <CALvjV28edz1zzFeduytOMoVDyeXOKoxPiwcFp6Mbxz1ODSq17g@mail.gmail.com>
Subject: Re: [REGRESSION] soft lockup on boot starting with kernel 6.10 /
 commit 5186ba33234c9a90833f7c93ce7de80e25fac6f5
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, 
	"Chatre, Reinette" <reinette.chatre@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Julius Werner <jwerner@chromium.org>, 
	"chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 9:10=E2=80=AFAM Luck, Tony <tony.luck@intel.com> wro=
te:
>
> > I have discovered a 100% reliable soft lockup on boot on my laptop:
> > Purism Librem 14, Intel Core i7-10710U, 48Gb RAM, Samsung Evo Plus 970
> > SSD, CoreBoot BIOS, grub bootloader, Arch Linux.
> >
> > The last working release is kernel 6.9.10, every release from 6.10
> > onwards reliably exhibit the issue, which, based on journalctl logs,
> > seems to be triggered somewhere in systemd-udev:
> > https://gitlab.archlinux.org/-/project/42594/uploads/04583baf22189a0a8b=
b2f8773096e013/lockup.log
> >
> > Bisect points to commit 5186ba33234c9a90833f7c93ce7de80e25fac6f5
>
> Does that Intel Core i7-10710U even execute the RDT code? Most client par=
ts
> don't support RDT. You can check if yours does by looking for "rdt_a" in
> /proc/cpuinfo.
Thanks for the suggestion. You're right, I do not see `rdt_a` in `/proc/cpu=
info`

