Return-Path: <stable+bounces-180963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DA6B91966
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 16:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4691901506
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 14:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D147260D;
	Mon, 22 Sep 2025 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="Uor95Tkq";
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="zkFjRFPc"
X-Original-To: stable@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5F192B7D
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550098; cv=none; b=AYXFiI3OJecm8GvYMBaPZLJBOyk6L30s5Q9uxvAQ+IKu7npNW/wqJdJfKLEcV8rECt+fG/Pleda46AW/Jstsy+OwAomLjeS3sgP7RZ36IjQdy0+xn/Nd7tIO9UnJct4UFzV5takSa6r3dvM0Y1h9DuYfuE2IKHG+d/gSbttHkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550098; c=relaxed/simple;
	bh=Wn2ERJZBReH/HVXwSEVJzpKx25hStfXtnpi4xbk2SI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQR3egJhaQT8aW5zdMAofmy1Amh0MRW2ar1/XVi2QHSB1KBI8I17bypeS1WyBBwWZlyxI0WOl2votox5z1w7uyrPh3A1Ilp3Fn0JwUN1wdJkB+UcXTKIQNJ1QmdT8zxHi58nKM6qIzhLA57WxittlM9Q6AkuIn4Y41RKinK7+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=Uor95Tkq; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=zkFjRFPc; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Received: from mail-lf1-f72.google.com ([209.85.167.72])
 	by mxgoog2.mail.janestreet.com with esmtps (TLS1.3:TLS_AES_128_GCM_SHA256:128)
 	(Exim 4.98.2)
 	id 1v0hD8-00000005rHz-1DbJ
 	for stable@vger.kernel.org;
 	Mon, 22 Sep 2025 10:08:10 -0400
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-579671f82b5so3381306e87.1
         for <stable@vger.kernel.org>; Mon, 22 Sep 2025 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google; t=1758550088; x=1759154888; darn=vger.kernel.org;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:from:to:cc:subject:date
          :message-id:reply-to;
         bh=WKnomOL4D/KLKgjTfz4gh8wLW6IWnGzYul7o0AYMMCQ=;
         b=Uor95Tkqja2LVOJR3RU2GSseyw1ovy3rjzAMC5LotPlfrXipcXnlFnhT+cjNQQjw9s
          3kmMwMw/IZhmYv3aND6Z+8J0q2hujnygMGvy1aW25cc/y0tm6QcenFOJcdIE3rHnSNCL
          mUOgJz/8XeMKHmtWcTMBdJsgVkCXaAOUdWx1w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1758550090;
  bh=WKnomOL4D/KLKgjTfz4gh8wLW6IWnGzYul7o0AYMMCQ=;
  h=References:In-Reply-To:From:Date:Subject:To:Cc;
  b=zkFjRFPcrUaN/EvvZ7lc+yAV8egfTyiqS+6g9+cHbHQ+TD3GsXgI13gkU0ctJWI5g
  v4+xl8BZv+4tjMsw7fNKJUcJLyOTVP8RAFsTItvjFqgEtYfonvF6I+WvfbGE/BRdR3
  +/Efi1DT9IlFBQxwUb8WIJzRSz8ID2v3wTskM/QTo5veGTKlJCxGtgEl3omC0VrPO7
  nqBbZzzlHRTjF7S9tOX9WHE07FlrbJVgTBXCd7DOTu8Nt3Od+meZm8S3+dpqXr7Nrv
  Ypc+6gQ9K/zlVEhJJ9In/XyKebfB6MNfmrB5nl2XmztgVPUWfj7oIkvSMvyY3U0H6a
  NEXg9PlzqIIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20230601; t=1758550088; x=1759154888;
         h=content-transfer-encoding:cc:to:subject:message-id:date:from
          :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
          :subject:date:message-id:reply-to;
         bh=WKnomOL4D/KLKgjTfz4gh8wLW6IWnGzYul7o0AYMMCQ=;
         b=SYuBBmzBF/ApdpSXbzb6POgT1h6kJUvXCMEM1sVnQVqL86NeQK3G2S8Tq4iQoMX1zB
          c8FP/K5/4TJPzq0Z/deEaos12x1uoFZgjmR6ZziY5YiunVD0b2qtWxrGZTRas+3GtGhJ
          KpfSwqm+dIkzjqgg1ZqNNu1hx4yp+INLmnMhxwKKBU6HkjEaMIQ1YAYmaNYv4G9Nhc8S
          2HcNY6PlAd22osS0jQUoivbtjrCbbfYhoBRZ3T/kTFeBHCXxI8JfXcMgGS3Z+tv84n/I
          lqvC2CbLfqUGZ+WLRm5C642/ewlenIlVscQzOPlRUbWvqx6vg9jxl/w4YI0GtIEMZu4R
          hHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQlYEBYIfRVEzh83hWaZsbNNEGt1qqaiZQkKhDy31fRtMn/pPXO1okeFMcdqaFRsgRWZ0G/pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+lN6ViX4zeZTErROwPh7xEmoXbnBvOOWTc/cxQziDnFeGESB
 	P+8D/A9nAxBidEYtXSKlm+mf4+bWtZSp+sF2gWWfUWAoLTg+ucstT8+cYUh9HHfriI7eQvt0E/i
 	brz18PscjKMbdnkbAv82hKPEQGvBRI+bGk8FgrYauIxblCSqhUvZSdGPvS6Msu+Wl8HiF6O4P4V
 	rhUcBwALxdE+MOZQXFOSINRp7J37dlZPKV7gTDzXULsQ==
X-Gm-Gg: ASbGncvDrZ+u5G6XQ45TSnh1Ns3qxieheIntGF9T/P9HxZhOqerfRGEZZkx+TLVZZ7/
 	98cqoQE2Q0tgDMBD9NwBrB6DEz2gZESfHCrBlhr8/KlfYjmWJWSDVdtHYOmcIxUb2a3ss1FjAVT
 	jCPk3mA6iGP0eHrXaFZ52X
X-Received: by 2002:a05:6512:4488:b0:57c:56:ab46 with SMTP id 2adb3069b0e04-57c0056ae84mr2283416e87.33.1758550087618;
         Mon, 22 Sep 2025 07:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd1ySPecRcVCRJ1j/O1/bf3zsfejj7ps4M7McU313K/m4wquJeMlwHa0f3SSZHuyWlFMAJFdDpPO63NI3JoeI=
X-Received: by 2002:a05:6512:4488:b0:57c:56:ab46 with SMTP id
  2adb3069b0e04-57c0056ae84mr2283406e87.33.1758550087122; Mon, 22 Sep 2025
  07:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAH4uRA=wJ1W65PUYpv=bdGFdfvXp7BFEg+=F1g3w-JFRrbpBw@mail.gmail.com>
  <oqe6w7pmfwzzxaqyaebdzrfi63atoudeaayvebmnemngum4vmi@dwd6d4cs3blx> <2025092102-passing-saxophone-d397@gregkh>
In-Reply-To: <2025092102-passing-saxophone-d397@gregkh>
From: Eric Hagberg <ehagberg@janestreet.com>
Date: Mon, 22 Sep 2025 10:07:55 -0400
X-Gm-Features: AS18NWA25a37acPSHFt6CiouAw4nJtal_df5XFS0eCWTplfTrnfPoxz3nNisqd4
Message-ID: <CAAH4uRCRtMwG8B3my1-b=RAbAw=j3YBx+uhybu8PKd9T=k3oHw@mail.gmail.com>
Subject: Re: "loop: Avoid updating block size under exclusive owner" breaks on 6.6.103
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is what I applied:

--- b/drivers/block/loop.c
+++ a/drivers/block/loop.c
@@ -1472,36 +1472,19 @@
        return error;
 }

+static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
-static int loop_set_block_size(struct loop_device *lo, blk_mode_t mode,
-                              struct block_device *bdev, unsigned long arg=
)
 {
        int err =3D 0;

+       if (lo->lo_state !=3D Lo_bound)
+               return -ENXIO;
-       /*
-        * If we don't hold exclusive handle for the device, upgrade to it
-        * here to avoid changing device under exclusive owner.
-        */
-       if (!(mode & BLK_OPEN_EXCL)) {
-               err =3D bd_prepare_to_claim(bdev, loop_set_block_size, NULL=
);
-               if (err)
-                       return err;
-       }
-
-       err =3D mutex_lock_killable(&lo->lo_mutex);
-       if (err)
-               goto abort_claim;
-
-       if (lo->lo_state !=3D Lo_bound) {
-               err =3D -ENXIO;
-               goto unlock;
-       }

        err =3D blk_validate_block_size(arg);
        if (err)
                return err;

        if (lo->lo_queue->limits.logical_block_size =3D=3D arg)
+               return 0;
-               goto unlock;

        sync_blockdev(lo->lo_device);
        invalidate_bdev(lo->lo_device);
@@ -1513,11 +1496,6 @@
        loop_update_dio(lo);
        blk_mq_unfreeze_queue(lo->lo_queue);

-unlock:
-       mutex_unlock(&lo->lo_mutex);
-abort_claim:
-       if (!(mode & BLK_OPEN_EXCL))
-               bd_abort_claiming(bdev, loop_set_block_size);
        return err;
 }

@@ -1536,6 +1514,9 @@
        case LOOP_SET_DIRECT_IO:
                err =3D loop_set_dio(lo, arg);
                break;
+       case LOOP_SET_BLOCK_SIZE:
+               err =3D loop_set_block_size(lo, arg);
+               break;
        default:
                err =3D -EINVAL;
        }
@@ -1590,12 +1571,9 @@
                break;
        case LOOP_GET_STATUS64:
                return loop_get_status64(lo, argp);
-       case LOOP_SET_BLOCK_SIZE:
-               if (!(mode & BLK_OPEN_WRITE) && !capable(CAP_SYS_ADMIN))
-                       return -EPERM;
-               return loop_set_block_size(lo, mode, bdev, arg);
        case LOOP_SET_CAPACITY:
        case LOOP_SET_DIRECT_IO:
+       case LOOP_SET_BLOCK_SIZE:
                if (!(mode & BLK_OPEN_WRITE) && !capable(CAP_SYS_ADMIN))
                        return -EPERM;
                fallthrough;


On Sun, Sep 21, 2025 at 1:17=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Sep 17, 2025 at 05:47:16PM +0200, Jan Kara wrote:
> > On Wed 17-09-25 11:18:50, Eric Hagberg wrote:
> > > I stumbled across a problem where the 6.6.103 kernel will fail when
> > > running the ioctl_loop06 test from the LTP test suite... and worse
> > > than failing the test, it leaves the system in a state where you can'=
t
> > > run "losetup -a" again because the /dev/loopN device that the test
> > > created and failed the test on... hangs in a LOOP_GET_STATUS64 ioctl.
> > >
> > > It also leaves the system in a state where you can't re-kexec into a
> > > copy of the kernel as it gets completely hung at the point where it
> > > says "starting Reboot via kexec"...
> >
> > Thanks for the report! Please report issues with stable kernels to
> > stable@vger.kernel.org (CCed now) because they can act on them.
> >
> > > If I revert just that patch from 6.6.103 (or newer) kernels, then the
> > > test succeeds and doesn't leave the host in a bad state. The patch
> > > applied to 6.12 doesn't cause this problem, but I also see that there
> > > are quite a few other changes to the loop subsystem in 6.12 that neve=
r
> > > made it to 6.6.
> > >
> > > For now, I'll probably just revert your patch in my 6.6 kernel builds=
,
> > > but I wouldn't be surprised if others stumble across this issue as
> > > well, so maybe it should be reverted or fixed some other way.
> >
> > Yes, I think revert from 6.6 stable kernel is warranted (unless somebod=
y
> > has time to figure out what else is missing to make the patch work with
> > that stable branch).
>
> Great, can someone send me the revert?
>
> thanks,
>
> greg k-h

