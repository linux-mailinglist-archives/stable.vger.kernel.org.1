Return-Path: <stable+bounces-136768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C175AA9DBB3
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 17:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FA4461025
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DF625C83E;
	Sat, 26 Apr 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoFcCDA/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4DA13E41A;
	Sat, 26 Apr 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745680176; cv=none; b=RXdULS3ufu3ORs6puuKU6BoVRYYUK1vUB8iAo7pXCObm/k959796Xwtrl5CIdFdlm3LQ9t6zNuAz7CQvSpK3g9M9Len9av2fU5gv0jq1GWDdQMs85uGLyXrhIlF9hEw7HMQSSpFsrQSDXmUyr5cC1Ke688V/P9D3w7n4LQiOV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745680176; c=relaxed/simple;
	bh=dIJQCfly37yJJb55F7nZvqhj0sWzo07/GmJoBmU9rWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2EOau8k3gKltDM1lfATiYkkn4zDaKd96ddM4Nv8xbnpyGgh/p6TJ+udASiI5dj5cpvfFc6wVfOstQj7NPcYx1+Ckkr/8HSXm/qp/36SomjvVJuePghwKcmi0uHxSOeU7sysT4R7yZVibfaiwifIwUuenvQjF7kHBiDLWIXz2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoFcCDA/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22435603572so38583495ad.1;
        Sat, 26 Apr 2025 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745680174; x=1746284974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vC5wgcHdVfrww8xne54WZgEIJ58desjmSpFYHafJJ6o=;
        b=FoFcCDA/qtWSSwg+vfx7HouEYzKJAUgVrAltBJ2oxvIgCCwE2dU2TU8hvwrPBDFhp3
         i5QNEbCO0Bi4rSVxDcvWBm8oOE79oUzoOtV4BmsSbMEQ9DeS4Nh6ZTcuwBj1FjHYWTdS
         kepi+sJMZS1pnvCslKXOAxuJCPTa041WQdxji/YepKzVdoBXjKfVfAo439ue8d92YHMe
         T7tFW4H5Ya7DGTvPWG2qnye0tNB4o74eOjQmdAThvRLDoZqQlfTj3AYbieojGuDbCkQg
         q7i36mwiB/DJDodnuLMqvaAwYWAw4cmrbQulDpjYlNElvrWQVrfZZmTGzhJhqwvCT4Qe
         oTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745680174; x=1746284974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vC5wgcHdVfrww8xne54WZgEIJ58desjmSpFYHafJJ6o=;
        b=Si+1ChJI/8t8v9s/0TIpOvNUIRb4+sgE4nLeOSqmcrEoNIHO+57/HMM231aNNnUgy4
         Alwy+BAGlh3YM2COfRx4q1rHCVUJuV2RxFUZr7O6C8DkEjvuo+a7fIDxdG6MCCdgzFrz
         43KGGXZxZcvXGh6YnuagxMAkTk02J/auvkGqGYzEV0vvCFyt28q+A/vcDp5llmux4glA
         jk0jvvi3TVO28pF8ic8q7+wOBxnUGauf/rYUHrxoOcAhrMRCPhPdu/IwK0SzC+oZzgM1
         p481lxge3bJOjQgl/WTqVYYTX9e/hsLhINTg8VmNxki7/NJnyybXKHynqJNpuOaTsyw1
         3NUg==
X-Forwarded-Encrypted: i=1; AJvYcCV9YATuwBZZs10/kf3dU/IWCjBXfepV4bJmmHaCAyVsardFTOZ5eRC0JuPx8HX7Ck3v/nitKXSsGDCAvlr57kcpNg0YOCXK@vger.kernel.org, AJvYcCVHk1wknoY+MLbk0r2l9zh9HPJ4qK59iLR/8geGmaPVun+OdlyrSud4wqF2wqEvhfSeexNBkgUM@vger.kernel.org, AJvYcCX/msPdzXwyNqa1zo0UooYIly8OiB8gfn9C53zWAltsa9KHQY4CgeJ1ZQaTNET5uoUuAFo/z6Q2eWdEs7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKTh6ay+fCq8RXRj14/lAwX4Cs2egbp090ZJxvbyTkDvlwQaw
	m4X3I3H/qGlmV/UNa6jGmBnRiYQ5y5XWxMWJhmchbRbja19onUaJ
X-Gm-Gg: ASbGncu/JKDvuMrA0QBvzOf/9HiSMZuVZ/uPg7qiWCK89gagus7R8y5+FpF6tqCU2VX
	vY4C/J9xMVrYA8y6GeD1oSj9hV82/e8Zglf+sd8SNYMYfg9jU3U+3fi9eOTManjCsJgmH8e6NE4
	1WhRc7IKTGKG+AjXOT2p8c0Mz+6vZe1FEhG24cnX+Tk6YooDb6chFxXOzCMVwoveiaizKOI4Aj6
	+4PcZJ36ADwhdGGRN3RHlatpl/YZWMMBxOIR+6Os40DKVJBCKp4UmQlUobu9tOSxnOWR2QqJLRA
	hAjyP9DHfAU0iCY5IDMk3wiXr/tzrNw1TCOVbyBrqy4tcFMVhZU=
X-Google-Smtp-Source: AGHT+IHkmkhpvvi4d6Fkcw3am8Io+arHKaPgDsEECl09AsYacM7KJy7vLa8HbySZyQmB7nAtExrfmA==
X-Received: by 2002:a17:903:41d0:b0:220:cb1a:da5 with SMTP id d9443c01a7336-22dbf636a78mr95100985ad.40.1745680173780;
        Sat, 26 Apr 2025 08:09:33 -0700 (PDT)
Received: from VM-16-38-fedora.. ([43.135.149.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbd230sm50575075ad.77.2025.04.26.08.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 08:09:33 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: wufan@kernel.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	chrisw@osdl.org,
	greg@kroah.com,
	jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] securityfs: fix missing of d_delete() in securityfs_remove()
Date: Sat, 26 Apr 2025 23:09:30 +0800
Message-ID: <20250426150931.2840-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAKtyLkGyaoHr_xVGrWCTSFkqyf8b+hkOX1A0vyOpZUkTcTGtvQ@mail.gmail.com>
References: <CAKtyLkGyaoHr_xVGrWCTSFkqyf8b+hkOX1A0vyOpZUkTcTGtvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 25 Apr 2025 22:57:08 -0700, Fan Wu <wufan@kernel.org> wrote:
> On Fri, Apr 25, 2025 at 9:15 PM Jinliang Zheng <alexjlzheng@gmail.com> wrote:
> >
> > On Fri, 25 Apr 2025 18:06:32 -0400, Paul Moore wrote:
> > > On Fri, Apr 25, 2025 at 5:25 AM <alexjlzheng@gmail.com> wrote:
> > > >
> > > > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > > >
> > > > Consider the following module code:
> > > >
> > > >   static struct dentry *dentry;
> > > >
> > > >   static int __init securityfs_test_init(void)
> > > >   {
> > > >           dentry = securityfs_create_dir("standon", NULL);
> > > >           return PTR_ERR(dentry);
> > > >   }
> > > >
> > > >   static void __exit securityfs_test_exit(void)
> > > >   {
> > > >           securityfs_remove(dentry);
> > > >   }
> > > >
> > > >   module_init(securityfs_test_init);
> > > >   module_exit(securityfs_test_exit);
> > > >
> > > > and then:
> > > >
> > > >   insmod /path/to/thismodule
> > > >   cd /sys/kernel/security/standon     <- we hold 'standon'
> > > >   rmmod thismodule                    <- 'standon' don't go away
> > > >   insmod /path/to/thismodule          <- Failed: File exists!
> >
> > Thank you for your reply. :)
> >
> > >
> > > A quick procedural note, and you may have gotten an email about this
> > > from the stable kernel folks already, you generally shouldn't add the
> > > stable alias to your emails directly.  You may want to look at the
> > > kernel docs on the stable kernel if you haven't already:
> > >
> > > * https://docs.kernel.org/process/stable-kernel-rules.html
> >
> > Sorry for that, I will read it. And thank you for your pointing it out.
> >
> > >
> > > Beyond that, we don't currently support dynamically loading or
> > > unloading LSMs so the immediate response to the reproducer above is
> > > "don't do that, we don't support it" :)  However, if you see a similar
> > > problem with a LSM properly registered with the running kernel please
> > > let us know.
> >
> > I don't think that not supporting dynamic loading/unloading of LSMs means
> > that directories/files under securityfs cannot be dynamically added/deleted.
> >
> > The example code in the commit message is just to quickly show the problem,
> > not the actual usage scenario.
> >
> > I'm not sure whether existing LSMs have dynamic addition/deletion of files,
> > but I don't think we should prohibit these operations.
> >
> > Moreover, since securityfs provides the securityfs_remove() interface, it
> > is necessary to handle the deletion of dentry whenever it is used. What's
> > more, we have EXPORT_SYMBOL_GPL(securityfs_remove).
> >
> > (By the way, the reason why I noticed this problem is because I needed to
> > dynamically create/delete configuration directories/files when implementing
> > an LSM. Of course, I am not dynamically loading/unloading LSM, but
> > dynamically adding/deleting directories/files under securityfs according to
> > the status during LSM operation.)
> >
> > Therefore, I think we need this patch and strongly recommend it. At least,
> > it has no harm. Hahahaha
> >
> > thanks,
> > Jinliang Zheng :)
> >
> 
> We have added securityfs_recursive_remove() for this purpose.

Thank you for your reply. :)

Yes, but I think securityfs_recursive_remove() is not equal to
securityfs_remove() + d_delete(), it has its own extra work. Therefore, I
think it is better to add the work of d_delete() directly in
securityfs_remove().

There is no reason to do __d_drop() only when deleting files recursively
and not do __d_drop() when deleting files non-recursively, which seems a
bit strange.

thanks,
Jinliang Zheng. :)

> 
> To the best of my knowledge, IPE is the only LSM that will delete
> dentry during normal operation.
> 
> -Fan

