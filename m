Return-Path: <stable+bounces-46106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1BE8CEAB4
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 22:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACD91C214EE
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 20:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AEF5FDD2;
	Fri, 24 May 2024 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzY8fuDX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405BB84DEA
	for <stable@vger.kernel.org>; Fri, 24 May 2024 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716581305; cv=none; b=H9lQ6s07fA39CWAPouqvODZtM2Oej7zC2Z18GLuyK7hhf4WYFbEllPitMAO/q86ogsoT9LHfckOO7/EOqy077nU1kwXzxQOowqNBQA9qerT47acjfptri6DaJF7QRxCGsSrRVcI4IhNDmnS/9B9RaPKZgw5xbX/Nw/UmKUAsmOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716581305; c=relaxed/simple;
	bh=4FcReVOVCS7hYyDzoxRFPQL2lrzw79+DnOI7/JBY7bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvVCYjAiBZJOw7Wvgh4vCpsLa3rRWMO3pfeCH260Bxer/XOISegpRhwJ1d8xCAen/i9V2QTNY7ZxwWomVEUY8m/SVgjc67ZrpNiuhW2tZ+cGxnChmMRBSDainQdid7dZgGaT05MNy8XBfkpvyv8TLh+CQnWH51tx1101A1S0S7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wzY8fuDX; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-df7812c4526so598125276.1
        for <stable@vger.kernel.org>; Fri, 24 May 2024 13:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716581302; x=1717186102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eCIWhXYa2p87CDvkJmySfb+8QTD7UAzsT7978LLc4BA=;
        b=wzY8fuDXc2MIzqoc41UIfK6/pwnVFMAg/Ga7Jg7yC7gD7f7H50dLYsRddqUn3tgXK5
         rcXTUO/hpOywg5M+fsO1s8pcT+bTb+69rKZ27CyG/ijGbqcHxy1Nznow+ksZGN8g+hPw
         0xyITZRZi7kiEOSn6cYCdkVNtB2MYuvMRgOpC7yRffDXFHJ++7HSilg30XnRs3Tg67iT
         XnEWxbSZQRMp9t+BUqILT/ipSn4xnuGL9c/H2CLkuNno966Rf8aP+erDTB7nPDGFG5oB
         tt8VTlUelt82XcmMMc+4oXZTFe8y2PfxnjZOjbS/2zTKe99R1lrKwrKs8Aukb89fzg+t
         s4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716581302; x=1717186102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCIWhXYa2p87CDvkJmySfb+8QTD7UAzsT7978LLc4BA=;
        b=ao9CYeS/u1Wz7ALUDxzoBXHSR3LEcro6Cp5DDpIYHey4O1v8UBt9rqkOtulbP0GXTx
         Eyz3MoxXiRAfoo7VYkVY3o5c+7U4SWlVbqsj6DcNDam2KRo2Jj2RnjQpgh4nw2Nv661M
         n9+xOICVub4gEPQWaq9NPQehLXwS8t3Dysfv16ZwUkfFb0PdLRMSQfuatgqqX7EaLrDO
         pfhY9wOff93TMk259YBd2moE6sMfN53wxs5/QIj5T2g5yjUKNF2DHXwNwjqYloFUxmkj
         S9/YQIepxrBax2vk6sb7BlZ4FeztLUKVeye1VGJvL2PiTz3pjYy3E6aagoWLTmtaCT43
         E1XA==
X-Forwarded-Encrypted: i=1; AJvYcCVmPikCld5RrLb6q6WDCXAUvnGXQ4VxWFFSYWSENW7Tr1Mthe9U825pujkEYHQmLZs+rnYiNNs4EMnaPUWjbFOn6wNUjWaN
X-Gm-Message-State: AOJu0YzWR0aifIbTjhxHqMRJOqJRdeoL6DFWc1ITkQF97virux9/d9vP
	fMs9Pi/K6z8jzXlOpNOd/t64svT9sX6v/Y9TUNXY1+Y79HE2OsnOgpWKiOotD9PZDNkKt3ursyv
	c6WbHNWFIdGMujpcMvt1sNBMtsvYBVraYeODQHw==
X-Google-Smtp-Source: AGHT+IGfAILPpHKmHhMhPuha3zVO3krHrOtz2jtUmy9g1cSv1RC+mxHXjhsBUatjQc7ZmXfc28FlOTJyiuPQQbjt8K8=
X-Received: by 2002:a25:6b0d:0:b0:df6:ad25:f5ef with SMTP id
 3f1490d57ef6-df77237822bmr3447230276.58.1716581302201; Fri, 24 May 2024
 13:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37V5uqJ229iFk-t9DBs-1M5pkWNidM6xZocp4Osi+AOc1g@mail.gmail.com>
 <20240523064546.7017-1-jtornosm@redhat.com>
In-Reply-To: <20240523064546.7017-1-jtornosm@redhat.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Sat, 25 May 2024 04:08:10 +0800
Message-ID: <CAMSo37UyC-JRfZjd83Vx2+W-K-WqxAN9sHJ88Jev67Fnwci_pg@mail.gmail.com>
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set
 to down/up
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, inventor500@vivaldi.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, Jose

On Thu, 23 May 2024 at 14:45, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Hello Yongqin,
>
> Again, not a lot of information from the logs, but perhaps you coud give me
> more information for your scenario.
>
> Could you try to execute the down interface operation, mac assignment and
> the up interface operation from command line?
> That works for me.
When I tried the down and up operations manually from the command line,
it worked.
But it only worked after I ran the down and up operations after the boot.
It fails to work by default after the boot for both the fresh deployment,
and for the later reboot

One thing I noticed is that the following message was printed twice
    "ax88179_178a 2-3:1.0 eth0: ax88179 - Link status is: 1"
after I ran the up operation,

Is that expected?

For details, please check the log here:
https://gist.github.com/liuyq/be8f5305d538067a344001f1d35f677b

> Maybe some synchronization issue is happening in your boot operation.
> Could you provide more information about how/when you are doing the
> commented operations to try to reproduce?

The scripts are simple, here are the two scripts for Android build:
    https://android.googlesource.com/device/linaro/dragonboard/+/refs/heads/main/shared/utils/ethaddr/ethaddr.rc
    https://android.googlesource.com/device/linaro/dragonboard/+/refs/heads/main/shared/utils/ethaddr/set_ethaddr.sh

Is the one to run the down/change mac/up operations script.

Not sure why the up in the script does not work, but works when run manually.

--
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

