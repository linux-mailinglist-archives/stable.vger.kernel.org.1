Return-Path: <stable+bounces-114694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29546A2F4F9
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 18:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 907077A322E
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E0924FBE9;
	Mon, 10 Feb 2025 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru1aknKU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603822257B;
	Mon, 10 Feb 2025 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207908; cv=none; b=q7SJS3IF6lfK1s/8W2JGJ4dUPc1IB34wQMRYE983oNblW1dzZHO26UXVVENmMspxk6YjJa1R6boM33qfudPEejxcXrqp5b5TEUZD2V/SzSzNreeiCSOw0j2/xuSIN4oupSh5O9AREET4TO/JlZtnTTjd08Ao4thbyi0YLwHzBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207908; c=relaxed/simple;
	bh=VC00JklNOrgwjOXHHIYgIMfJnTeRDFzcAi5RpR/TxNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7p8SU4POsFjoe70jn95DSCYv2LcLtqooO1U0AGWPRctcqFSP55m3nBejxj4f0+rlcIWII7Mt1SpxieBGOdtua9/hFfOXKkBfP6RuxB4RPi4HjAY6DD3M3QLT/0PfYp5mJ6Dltifkx82DtmwUE1+KY/6990NyiSlHXXpDHwfMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ru1aknKU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f710c17baso35402345ad.1;
        Mon, 10 Feb 2025 09:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739207906; x=1739812706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Hr2gj90SAJvZYYKvX3lI+NWXPn0IZtRtW+Ba4PvwI=;
        b=Ru1aknKUMj4mAD9llQ8heuqyYDGGqvLM1gw0TrJEcv9nVtJnOgGB3PfrVaRnMeXZgR
         gax1sfHkRLHNGISRAhcNLid4BzTIPXBRqNoRt3zN6XrfZbvimIjwO7EcAbZQ3a9I+/5r
         cl5f5WSF/XGsxQ52imY1jeVkM+z7CG0QnWUUaSKs+yJtNLC02GsxshthlKZehbVWfO8V
         0FABy0pd4frYwOzcM5vDv+qKQSU9/VhYv6CdSg58LaJcof06gFRfmqOK1vqDMa/dMbcz
         gGU+WxDqiu+x678c/S5vw4qAXi8CoOWdhiXvzjQ5wD5KSf/G3838Z/N0xyiJtf677Hr6
         HtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739207906; x=1739812706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6Hr2gj90SAJvZYYKvX3lI+NWXPn0IZtRtW+Ba4PvwI=;
        b=M71o19AVCKF8fbs9ee2V4bOD89/Szyfi+gxvnURBNjKOfJ+5AZBr2xLCoq7nioY7pM
         b/9sVbck/Plg5/7gvFOZXC5Ub3ADT+Atq+wOtOBWP7s/xM3tHYxpFsJB4spa/qu4+Rpf
         IXzBLff5Q0Ed6/oiCdc+sgqGMjD19+Bhhxj2bE63mqI9x11qgWU9byGdYkz1yauGtUZc
         IKPGBTdcPYVfDg1SW/tx8vR5hKuPKKHsmdqbBVuP/rU6fS4L4r9RxA47Czmu/Ms002bY
         rnJCZMm1WExnijXziuIwfTbuiH8jlOhYiJOTJniSbdtchH2PAQDllxvB+ne9Zutft8Vh
         XK2A==
X-Forwarded-Encrypted: i=1; AJvYcCWk9kLpdp6Njo50Nyk/X2gLY3dMABOBTkpSuV/AbVB0ntqiGl5r0pRTKNCOWMME3kcwF8UhsAASw1ap@vger.kernel.org, AJvYcCWkwCe+/oYho+2z3SOcbMkzFSunrF/02AHQrCyfKTexS0dtA/PgcpT0dtfO8QM04BpVi64SPWXGRUW4nCc=@vger.kernel.org, AJvYcCXerQr08FjLGFytexdqUnHU5DR7LGAz+b3P1kb90UF8xRrAv6Zyt4vYq4uEhPhg9izzITA4am/m@vger.kernel.org
X-Gm-Message-State: AOJu0YycojomQ89ANVpUcr++OsQU1dI/oY4p1Z9TBU/VDIM32GIOgj1M
	OGjN7VwM3xq2YUhASTw0lBnsldA08d0icpFbvRbWkjivpvrSK6trK91aCqo4VQ0twTp6+QEggNx
	19x97VGKYO6mbFd+dobLB+KI756E=
X-Gm-Gg: ASbGnctWe8yPHGexCtda9g3ivX/+OWJP0dCjBMUs1NXCOZ3M9fSGYP/mB43yxPHe+e7
	mDYUczL9oLLdrs5Wd8YjPVpgYvXxIdHoxI8npwVp/6WMLcEPdoaqT3GQBd7Of1Kdn09RiWIYJ
X-Google-Smtp-Source: AGHT+IEXZ5lqBOERsIeVCEiZf+6SKGWkoAr+EjNWtFeKsutJOZCFiQi7Te+5lhD9Pf+7cxxxQEYooMyUXelC0GOYWCg=
X-Received: by 2002:a17:902:d512:b0:215:b8c6:338a with SMTP id
 d9443c01a7336-21f4e6a05c0mr236794695ad.4.1739207905763; Mon, 10 Feb 2025
 09:18:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207203441.945196-1-jilliandonahue58@gmail.com> <202502082022.ILQXjseT-lkp@intel.com>
In-Reply-To: <202502082022.ILQXjseT-lkp@intel.com>
From: Jillian Donahue <jilliandonahue58@gmail.com>
Date: Mon, 10 Feb 2025 10:18:13 -0700
X-Gm-Features: AWEUYZkEYqytkrljgvhIt2HQh3vA3pz_JwF1sjfbnL48BEb20zELvkxqTlRWhmo
Message-ID: <CAArt=LhOBqH-qZVkdBsh13Csvv1GrDBqakfPGjpFt0TF8KBYsg@mail.gmail.com>
Subject: Re: [PATCH v3] f_midi_complete to call tasklet_hi_schedule
To: kernel test robot <lkp@intel.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ah yea, this error happens because in this commit:
https://github.com/torvalds/linux/commit/8653d71ce3763aedcf3d2331f59beda3fecd79e4
the tasklets are replaced with works. Should I request the patch to be
in v5.10 or should I update the fix to use
queue_work(system_highpri_wq, &midi->work) ?

> >> drivers/usb/gadget/function/f_midi.c:286:31: error: no member named 'tasklet' in 'struct f_midi'
>      286 |                         tasklet_hi_schedule(&midi->tasklet);
>          |                                              ~~~~  ^
>    1 error generated.

Jill

