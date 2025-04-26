Return-Path: <stable+bounces-136742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB2FA9D782
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 06:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA244C6A94
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 04:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203431C3BE2;
	Sat, 26 Apr 2025 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CufnO01G"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE701624F7;
	Sat, 26 Apr 2025 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745640946; cv=none; b=AydOLcSfi6MiPZ3IUBVAkG/hRNGodMtp/qsxch/UNqGDkB7LsDhVu9UzKeEDwIlz65KCtrxZnbl1o95FOJ/+xXU0uTzM9g1uuSCh/POyHHnXoc7pN0IBJ9Ox6JPv9Oqx1TX2FxHfMPmPF436nsXnuJlCJK//Lsa0dtpKEY6DDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745640946; c=relaxed/simple;
	bh=IPAF1Vlgn6qXUcqVlmQM2IxucpBg2eJNpbVkZ21ztHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1Gkgurprr68Mnkneu54n//ssW3Lkzxa4RhHILV4zpMe//clF5Ps6VPW5xwR6zEivTXPwo48fZZTxnFuuMcnanArTyfGLpHJpBblpZrq+P4EZwVIozWUsvhNvPbsTLPD/JnumK+VDrmQZnqrBbGG6UPalDEpOF6pBR39xD8mOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CufnO01G; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223fb0f619dso33731965ad.1;
        Fri, 25 Apr 2025 21:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745640944; x=1746245744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JR6p9odKnHQw24ixy/MY8q6jAXIh1LvF/j84mGxfXM=;
        b=CufnO01G1R1ugc5gdukRoTm9GWH9dXP+5d/hv09WKGvF3WBO08sbqWwWwb/PWYWNl2
         Zm19Hk/Xb20GTG7wwKz89EMWze2Jili5srzJskHZN75Jdksvj5uhWtdhVAK16BC+w/yy
         4zxtfBiVXi7z0Jz9y2TYEcDFW5duBEA5yzv2htMhnWnuuZFHfdbkZSNgIj4+sAGMOT05
         VxvbNoGUfxzWjLYSWij89uSDuVK2M6igMF+Wbkedzss0EJxUj4xiaCLl3xKZouRX5LR2
         zFZd8/VyxIlkvdClWdCggNlEEEfTTMv3f6IS6eHSKW2Mbe8Potyj6/v9Yrpa5QXNdKd6
         K0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745640944; x=1746245744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JR6p9odKnHQw24ixy/MY8q6jAXIh1LvF/j84mGxfXM=;
        b=l42D1ik7oMK9juzDxgsb1uVtjsK83r55f4pj7k116cxXDFkNVDSUIVPlmlLqdJ8gi0
         /ZevUxKuLxPpJy2Ultii6QNXfOnCU3m5cD5POffpGLJxGtgvW1MoezwnK8rxz8Z9eoCT
         1lVMlnjjtinvMvffW5uZSeQutIVtjbpMCk8+pxZbpseGHee4bP6TOEkZZ6R6O0OwHxmF
         VXwzRU0cjdJ2JmJ7VRGDivHSZhpp3zF360HgjAbFE/BSfxm2M26O6zJbT0qHdVX9YRQW
         x/+kdxg4fFKACZZv+XQ6s/3uaUQMHuSgjJU1u5TU1D6Xmkx5A6c+SBQv+4lN5YhYQNez
         gWWA==
X-Forwarded-Encrypted: i=1; AJvYcCUAu6LLIW/V7ZY1HsQRh29pF4lR8jKGbPzhlnq9R/aYeq3Y1X9x32s3tJwZ+7DnC7JiNuougGABnZvfTOY=@vger.kernel.org, AJvYcCWdXbXvQYgEtnRHnfwFeU1YihCuDkk/VnobUNvOgaZKe7pzfJ13rUyaiMrgXSToiw7QbYNRhC60K0MChH9a7LEbSWGMzzh1@vger.kernel.org, AJvYcCWuvJxRdOApfR8IY7yUCedAWKzxSHKTGBF0GZlvTDqUNble2EhZHapG6FZsIc+6AnUR+IMUakmS@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZ1R1hQ/bBGpGDqYoroNMKoT2tbPma+pQaJvO81RwiZe/yBxg
	PaJWFYa0L1geRrsv/B5uK4QD3dhQI9/n0Wq6W1LKT2bbkCkPaRb9OROuLcUQ
X-Gm-Gg: ASbGncv85MaVwurNbaiYRZqoj97rw2b7Q5oJCSCzvgiTiVEoiAQ1KgH251jJo9q8b/K
	hEwIhm9oKOmmFyvfxFSpCAbk0UIdQ1YaJvxW3/QuZ6IRfc9EwluxWu+QfxoYlccRO4JctA58QTE
	ObGANqfZM6xyPhlQOVKxi1Wrw4npxNtvsvsswqvtoBgq/kAKdzIEiRk6n7nnBh8BVM2y/KShmsh
	Jvx05hx3MMXDTBFELvtwahkNeR1Oh20YnIezW51RcixecWnSMhOJs4tec/otUAO1g8gT1CUksjt
	NmeFKppZL/Cq7OxOg7aqzwxcyANCgn0/gNCnhRObO4WH1b9Pj5E=
X-Google-Smtp-Source: AGHT+IF7rJDPghuCTb4fGbZQXPshTIkDrSv8a4rGRiWbvC3kwKJIfIRIdBVog1gZuGX8sc9eebM2LQ==
X-Received: by 2002:a17:903:187:b0:224:c47:cbd with SMTP id d9443c01a7336-22dbf157b05mr71024585ad.0.1745640944230;
        Fri, 25 Apr 2025 21:15:44 -0700 (PDT)
Received: from VM-16-38-fedora.. ([43.135.149.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5216770sm40996495ad.218.2025.04.25.21.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 21:15:43 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: paul@paul-moore.com
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	chrisw@osdl.org,
	greg@kroah.com,
	jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	serge@hallyn.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] securityfs: fix missing of d_delete() in securityfs_remove()
Date: Sat, 26 Apr 2025 12:15:34 +0800
Message-ID: <20250426041542.23444-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAHC9VhROjCvwaEJ1-Vc9SQU-x3wmZjeFknxkFGJcpPL28fGm1w@mail.gmail.com>
References: <CAHC9VhROjCvwaEJ1-Vc9SQU-x3wmZjeFknxkFGJcpPL28fGm1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 25 Apr 2025 18:06:32 -0400, Paul Moore wrote:
> On Fri, Apr 25, 2025 at 5:25 AM <alexjlzheng@gmail.com> wrote:
> >
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> >
> > Consider the following module code:
> >
> >   static struct dentry *dentry;
> >
> >   static int __init securityfs_test_init(void)
> >   {
> >           dentry = securityfs_create_dir("standon", NULL);
> >           return PTR_ERR(dentry);
> >   }
> >
> >   static void __exit securityfs_test_exit(void)
> >   {
> >           securityfs_remove(dentry);
> >   }
> >
> >   module_init(securityfs_test_init);
> >   module_exit(securityfs_test_exit);
> >
> > and then:
> >
> >   insmod /path/to/thismodule
> >   cd /sys/kernel/security/standon     <- we hold 'standon'
> >   rmmod thismodule                    <- 'standon' don't go away
> >   insmod /path/to/thismodule          <- Failed: File exists!

Thank you for your reply. :)

> 
> A quick procedural note, and you may have gotten an email about this
> from the stable kernel folks already, you generally shouldn't add the
> stable alias to your emails directly.  You may want to look at the
> kernel docs on the stable kernel if you haven't already:
> 
> * https://docs.kernel.org/process/stable-kernel-rules.html

Sorry for that, I will read it. And thank you for your pointing it out.

> 
> Beyond that, we don't currently support dynamically loading or
> unloading LSMs so the immediate response to the reproducer above is
> "don't do that, we don't support it" :)  However, if you see a similar
> problem with a LSM properly registered with the running kernel please
> let us know.

I don't think that not supporting dynamic loading/unloading of LSMs means
that directories/files under securityfs cannot be dynamically added/deleted.

The example code in the commit message is just to quickly show the problem,
not the actual usage scenario.

I'm not sure whether existing LSMs have dynamic addition/deletion of files,
but I don't think we should prohibit these operations.

Moreover, since securityfs provides the securityfs_remove() interface, it
is necessary to handle the deletion of dentry whenever it is used. What's
more, we have EXPORT_SYMBOL_GPL(securityfs_remove).

(By the way, the reason why I noticed this problem is because I needed to
dynamically create/delete configuration directories/files when implementing
an LSM. Of course, I am not dynamically loading/unloading LSM, but
dynamically adding/deleting directories/files under securityfs according to
the status during LSM operation.)

Therefore, I think we need this patch and strongly recommend it. At least,
it has no harm. Hahahaha

thanks,
Jinliang Zheng :)

> 
> > Fix this by adding d_delete() in securityfs_remove().
> >
> > Fixes: b67dbf9d4c198 ("[PATCH] add securityfs for all LSMs to use")
> > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  security/inode.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/security/inode.c b/security/inode.c
> > index da3ab44c8e57..d99baf26350a 100644
> > --- a/security/inode.c
> > +++ b/security/inode.c
> > @@ -306,6 +306,7 @@ void securityfs_remove(struct dentry *dentry)
> >                         simple_rmdir(dir, dentry);
> >                 else
> >                         simple_unlink(dir, dentry);
> > +               d_delete(dentry);
> >                 dput(dentry);
> >         }
> >         inode_unlock(dir);
> > --
> > 2.49.0
> 
> -- 
> paul-moore.com

