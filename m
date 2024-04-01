Return-Path: <stable+bounces-33885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02CA893956
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 11:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593B31F21149
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCAE101EB;
	Mon,  1 Apr 2024 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ya1I+3Fl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91EDDCD
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711963330; cv=none; b=GUMpJ4LRvnO5jn2OXZg2RvdvTY4O+H3DmfEurNlHu8r+BocFCtS1xKG0aaO60U37QjKsLSIRMYvk9gvClQ8O2ttFksIUzygB1JJCFXZrtvgBQqJYS8a4tUlcEt+PRfFG4ykOreS/AAldJzOkHtBWgxOymbAWWVsNI2HUR0p7RPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711963330; c=relaxed/simple;
	bh=GSVXEStJNMGpvr7TAsH4ARvQbzpEQfnc/S5JofY958I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dpojx3tuePsAf8Nv3HS37BI84tvPu3e/EvaiDnWWZKr5hrZ09IPFpzguB396bS5f+OVbvD4+5EKVOhywKkaBNEc04GNPsrscyyjzOm1AQWNHk68na+sukRMLRWGBj1esvG1xjRpbBD8uBCmKODrdREqyLcq1xKWPwaRWw8YTYc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ya1I+3Fl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51381021af1so4863515e87.0
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711963327; x=1712568127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoKRupfTK4Va8twlK+MFQHx3q2WwCC/n+qoReimCgfw=;
        b=Ya1I+3FlbT8NnvfbSY+Qx3bflYsyxp6k+/h47IiJubtYuwV0YgRL5ueiW7wuBIy515
         CgJHtTzEwiunttkTuLtSF/wuOtkKehIeszCWmeomUOL9KdZCzFMZ9lvBkL3fEQJZYxoR
         b0CkRYGrhBG7PyKCMCz25D4cti/+7L1TqqeXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711963327; x=1712568127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoKRupfTK4Va8twlK+MFQHx3q2WwCC/n+qoReimCgfw=;
        b=PwuHti6I0o0TWn413Fp/Ldx6tMXQVLhyaWHT5Guc6QFKROLQTQINh1xwxDmPa9h4Av
         KpFzKNTT70/344CKgYMpeGtaWyUkWIZCVCqmS19cCPrFodfklNZJj2KYQAQZjjlRYwcH
         FJQ+rztYjfFIyBXWlIxC84KrE15Bs+fXjb1sIKe7nwtxbujDGckOiZWQ/fZp/FwObxL8
         QCqqawpufzTNf0xFk72eJI07Ga55vjSwcgujN7BxLambDYT2yxg9tCWVMK8Wlfh2vCQ+
         Cn8ffUN1f06y/X44ErmpwiaHQBKh/vxd7BL8A6vZkUN27M/xAzL6982emgt17ztyXSBo
         Z3nw==
X-Forwarded-Encrypted: i=1; AJvYcCWBrpJ3WRnbJgNa1wQtxsetVtUlFW6iZ0E+PvjGUWGk7qKIhtry+SIt8k53G0BDDj+tJgrb8RgcCEtN29Ou2kqw+UZmq6wK
X-Gm-Message-State: AOJu0Yx6XYFCA1vqz2lT1QXYSpfrtU/wyZJCclrQp48guxipNfD6HwBP
	Pf/6LKMfYuqTM8n4Du1foWZMB8cq/Nlw9hHQ99KrnygDTVpH/xjxGHJSNab/fb4c65CGdhWtKAr
	foU7Ck8XImTEzI+RgbU0X4aZjSAjCtaQVo9Hg
X-Google-Smtp-Source: AGHT+IGiFvWbOA1VyZ55Hsox9CkDx02TTPb/sWdvz92Q64Wdznn28ZE1w6EZRiY1EOXcq4LfpD86tlCCjUVz3neaShk=
X-Received: by 2002:ac2:52b0:0:b0:516:a2ee:71df with SMTP id
 r16-20020ac252b0000000b00516a2ee71dfmr3334289lfm.50.1711963326793; Mon, 01
 Apr 2024 02:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191208.88821-1-kuntal.nayak@broadcom.com> <2024033014-deception-cartoon-7470@gregkh>
In-Reply-To: <2024033014-deception-cartoon-7470@gregkh>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Mon, 1 Apr 2024 14:51:55 +0530
Message-ID: <CAD2QZ9aJtFpXWYRVmgJRjad6qXXECvi+-J++QAR2t4opa6cdUA@mail.gmail.com>
Subject: Re: [PATCH v4.19-v5.4] vt: fix memory overlapping when deleting chars
 in the buffer
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kuntal Nayak <kuntal.nayak@broadcom.com>, stable@vger.kernel.org, jslaby@suse.com, 
	linux-kernel@vger.kernel.org, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, Yangxi Xiang <xyangxi5@gmail.com>, 
	stable <stable@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 2:37=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Mar 29, 2024 at 12:12:08PM -0700, Kuntal Nayak wrote:
> > From: Yangxi Xiang <xyangxi5@gmail.com>
> >
> > [ upstream commit 39cdb68c64d8 ]
>
> Please use the full git id in the future, it makes it easier and our
> tools want it that way so that we can tell the difference between a
> "Fixes:" tag and an actual backport.  I'll go queue this up now, thanks!
>

Thanks Greg for accepting the patch.

./scripts/checkpatch.pl confuse developers, as it gives error/warning
if we use full git id.

Example:
ERROR: Please use git commit description style 'commit <12+ chars of
sha1> ("<title line>")' - ie: 'commit e26d3009efda ("netfilter:
nf_tables: disallow timeout for anonymous sets")'
#6:
commit e26d3009efda338f19016df4175f354a9bd0a4ab upstream.

Or shall we have something ./scripts/checkpatchstable.pl or
./scripts/checkpatch.pl stable (pass argument)?

-Ajay

