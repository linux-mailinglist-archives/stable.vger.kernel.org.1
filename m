Return-Path: <stable+bounces-25450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F7086BBF1
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 00:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41061F26E22
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 23:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB1613D303;
	Wed, 28 Feb 2024 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqf1b/Fs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A013D2FB
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161795; cv=none; b=gRsg1xpSgc/dqB55spSUF8NywN25dXFrZjPme9/nMR8+zhCgRoSu+Aq2C1ryur8TEz6c5NaXY0fOyVCRWLl41Nu95ZuhHUpYG6VfYgpfNA1GGd0o8Ud2Ys0T1ii+aRB5LKDW2RZk+YZtqV013uMle/3/4QS4WQ14qqvaIXAkFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161795; c=relaxed/simple;
	bh=tQPwMcJnWlsfjLGPuN9MxoeAz6jfRjvKCSyaROjNjXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIPNBKMlfmnT0RaF1sYYQSXcpILehrraMh8g2Dt0E3WtO3LAaSrHyIUICSJp97r7lSwBQ2Dt7z6sSbKPRcY2HIhJVrjzEDzX6Jx1xpEvZMamDDbanTB81t3gcKZOpM1sur4X02m+y6dwwfeEyyCZSqKqGCqO8GzDbVexnyT6iCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jqf1b/Fs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412a9f272f4so30215e9.0
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 15:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709161792; x=1709766592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tQPwMcJnWlsfjLGPuN9MxoeAz6jfRjvKCSyaROjNjXE=;
        b=jqf1b/FsASpjqE0hcZWN7Ml8HM15eVWOQU6MZVKPsoQm2jk9zlkEN/U7kfJdEoCq12
         4/ymkPqjC0V8+SYlXwMd7Z9uRQEK7gZ0J933QzAqGDZJ01P6CrhFtnH2jHJhj/8RhX1u
         cj0t1UNZNy5znKsjR0reUHzC5Vv9LHr1TBfHxgIe6/DSF06QLjosb1TbkeN2t7TaDdr+
         hsrtwqxWPvy57IMJyVM8aruvglvAAYs7lG/5lfgq06UV6/mXc/NLskrpb2rWF2TkMK6Z
         MRNMzh/O0ZdzOarYXpKo3MI3gz5umOOmNy7kGn6EGKa+a60XzvbrKRLWkSH+tsD4HGvk
         sDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161792; x=1709766592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQPwMcJnWlsfjLGPuN9MxoeAz6jfRjvKCSyaROjNjXE=;
        b=QfulYwqhEDcKUbDJbabMR+Ov4Lf09jvVEi3qt+SmOgIK7zZVR1znKXjj0A3Qq3nHuZ
         7t3lt1L1fSjeE1j+UMH38hsR7L9FccUO1LpK6VUnPKta7WJDTrG9AJd5bKoR0mHtko5c
         GC4lkUx3EsFzXPv4SwWpEJMKEwXItSeon1+IfTH/Xct64h527ICiHvZAEZ1z/VxUPAku
         zifhHZ88uzUKISrRgSBbA8PS2Sk0/5muSizo+icchmEaJrClwwZUJpq6vKpmLWIcp6P4
         wpx+4rsvq4p1mXwjk4/1HPfggqrO0PPk1ucS0yClZO+mJPmKoh0m1we9cDHjDPl0aVQ/
         NauA==
X-Forwarded-Encrypted: i=1; AJvYcCW7kYXc4wcN0T8kwh1hERzaFQwed+Si3g+WTaMBsYJB+IWaHby/wTLqxH55xvbDgK3O6074jXSAxRnGVyHd9cixrb2BzlJr
X-Gm-Message-State: AOJu0YzeWZDEa4s7SNDby5TrYICHXjV4M5pJcUeHPIB9ojmrOhen17A4
	G2k6WDVBN2jJgopWZxd5KgI+rNYnn1XjZnBLPBc8esKydXf3KZb28YLqf0rgwyIxoOGx3/bzFMK
	QWTWC9oHTf0Lfebtl2JS25n5La5YEmciKZLe4
X-Google-Smtp-Source: AGHT+IFaBr4ou5rad4Vy2KOF1zJQLth3lKTUU5sXoI0D9Y0AP76f/bm/fMAN2JjwGX5iHC5QewNHPi3Hcv1eyjkFA3c=
X-Received: by 2002:a05:600c:1f09:b0:412:a9ce:5f68 with SMTP id
 bd9-20020a05600c1f0900b00412a9ce5f68mr29447wmb.2.1709161791779; Wed, 28 Feb
 2024 15:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228220251.3613424-1-jthies@google.com>
In-Reply-To: <20240228220251.3613424-1-jthies@google.com>
From: Jameson Thies <jthies@google.com>
Date: Wed, 28 Feb 2024 15:09:38 -0800
Message-ID: <CAMFSARd33yHhxNRkioX6T90+SrFfEVHW9StXToTj_NEXnowftw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Sorry everyone, I CC'd stable incorrectly. I'll follow up with a v3
series shortly to resolve this.

Thanks,
Jameson

