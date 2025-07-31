Return-Path: <stable+bounces-165684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CBCB175BB
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 19:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2913D567B51
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8766D24DCED;
	Thu, 31 Jul 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ur0Jxm83"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E175F1DE4E7;
	Thu, 31 Jul 2025 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983594; cv=none; b=u0qCIrwdiXzftDIsQlGttThhnU1lBxehx7TUyC9wBRoI+AB39TTZbbVOn/PN8MyIzngXapWFm692WAWE0T5+7VntejTuMLYJlJmzEqaBWpYyFMGGmLokoxTW6ONMni4YqbXex8qwBGjEJwcWjkmsOHE6xJRqfMf047nTduQUOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983594; c=relaxed/simple;
	bh=D0eyeakQXkUoxnhS6LOjXaO2NDWgEEQN8gNn6R8fmQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTRNTPanMkCBJQqPlkQwpBElNLShGEPhWd5M/G9qIAW8rxSfJVLn19G1xjMIKirsVWuZwAYosqD6q3k+fZCt7opt5faO4hXblkVtAh87qj2uNZyi+YhCAPsEpdiBv64mmKWoR+A8mBx0IFcNBam8o7RwO/vWtWxUmWS7Adx5zEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ur0Jxm83; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2ffbbe6ec3eso511075fac.1;
        Thu, 31 Jul 2025 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753983592; x=1754588392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JQSkOyzA6O++KgoodZR4f5SJR35/IGJdbUx6uOChaLk=;
        b=Ur0Jxm83/y+AN/7DPXXHUxJf/O/AkO+36kVxZ59BxyA3KLlXsMGYoch9PCco/LDWxW
         +xEpBPc7AAPUpvVlQFn1xNtO7Dv+fEHKS7BVvA8bDYUEBVZAj6Tj9nCRg9IfdwKUMu3Q
         m/G3tbE7aJmI5tdKUHgu2A7ULal06W9U7avX078xbOSbcIQ1jfcIMex/IDdTeKHA6j/f
         ZSgHBfywWl/Icd1xi1sr2stt7oXcN0PMLPUNrjbbI399pove6hsoZV90cJhOh5X1ORcf
         tKglx7BR5yEdkGddW1x9muCjWErfWIGO94PSz18YdpcXRizWv1qXtRwnRsNSLrIavqKS
         MITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753983592; x=1754588392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQSkOyzA6O++KgoodZR4f5SJR35/IGJdbUx6uOChaLk=;
        b=A1fSn6FG2jizi7hpbFGBQDD+lwzMlMprtH4T8R3VbK4cIWMy/SwUdAzv5hNbTEEkID
         4lPRDJQENiWtGhMvmyM2Akna5741CN+c7f3BGH8aL7JE4RiD8vEw61uvYkgo+GnvBwbm
         9yxI+SwinzNuWHbe9JaH/quOBVEa667cXHBSchP2FUmMmXhsQb5UpR/0NFT06RRJX7tL
         9cgIEwwb3VMYpOJjqYzUPX5Di9omQDsb+56AoKddc8ycm6OkAe5UMftbhUINV9MpIVsT
         zKZR+HhBz+KX4P713s48yKLWfUDtwBPL5cyoFG6lo0/4YuX0l2DEvrGMTDGINnjY9uIK
         sn+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFuVN1HuMf0oMO+1amMt/pFBL2g2nZHuxdHT4yecSdyvERZYPR18KBjjBgpgz91QvN0PSlISwHJEnqSkY=@vger.kernel.org, AJvYcCWr4PfOnLUE+vy9SzpLrOLWCTyseo7RSUTnXj/E0yOeLYvxFmu64MPWQMmi5RqE1f0UrOWY4my5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb10WGLr7Few51EKR2DOB+rI1FO03bY4wTRll2IheALX6lNC0Y
	sdHQBJBaqeZ0NL3kuBbTdLotdwcJCQPZvAjeBW1ZqIgYYqsgfync/Mlk1sBFjPfT+R2Du3u5PHC
	HwsFzkzAnl9j1V2ac00oOUa4p78XHtTioc+aZm/0=
X-Gm-Gg: ASbGncvz6sJY0Yl/zEG31dm9GEGMNVBFN5U2piGAmCFNYfQLY5pPlN9ts5qy92WGmRe
	EHjqJWf5/2H52yEwJ0l9OfejeQBNamyQueEhQP5VOnXpMz/yq5JL1PC5S7a4/tGj4SaBezJBFLH
	+qWw1+mWV2TkjuizyvO95jOcln5CbyVKMCYOeCBjKGlWU1TDStlpZG9UjoYBJgOMIie7kz1aGLf
	KC8uPQP
X-Google-Smtp-Source: AGHT+IF8K1aMntK0gup5gkIQtDoiv/HeMVtZBk8VrB6eUvqSgNrGCf42CNoqy8Qy6/0IJ5evV/G3Q9oWUL49MuaiG6Y=
X-Received: by 2002:a05:6870:702b:b0:306:eb45:960c with SMTP id
 586e51a60fabf-307859bfb80mr5396845fac.5.1753983591809; Thu, 31 Jul 2025
 10:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730042617.5620-1-suchitkarunakaran@gmail.com> <3093fd14-d57a-4fc6-9e15-d9ce8b075b30@intel.com>
In-Reply-To: <3093fd14-d57a-4fc6-9e15-d9ce8b075b30@intel.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Thu, 31 Jul 2025 23:09:40 +0530
X-Gm-Features: Ac12FXz5Tlex75MwJYIHpIkLDLQm1GiTbT22FXNrlirDozssD_dMrPmRplEz7ws
Message-ID: <CAO9wTFjaQZFg3U7eGjk+xXV6S-gKSAoV5sz7fqsuyYUkAMu_4g@mail.gmail.com>
Subject: Re: [PATCH v3] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4s
To: Dave Hansen <dave.hansen@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de, 
	sohil.mehta@intel.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 21:29, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 7/29/25 21:26, Suchit Karunakaran wrote:
> > The logic to synthesize constant_tsc for Pentium 4s (Family 15) is
> > wrong. Since INTEL_P4_PRESCOTT is numerically greater than
> > INTEL_P4_WILLAMETTE, the logic always results in false and never sets
> > X86_FEATURE_CONSTANT_TSC for any Pentium 4 model.
> > The error was introduced while replacing the x86_model check with a VFM
> > one. The original check was as follows:
> >         if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
> >                 (c->x86 == 0x6 && c->x86_model >= 0x0e))
> >                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
> >
> > Fix the logic to cover all Pentium 4 models from Prescott (model 3) to
> > Cedarmill (model 6) which is the last model released in Family 15.
>
> Could we have a slightly different changelog, please? The fact that the
> logic results in the bit never getting set for P4's is IMNHO immaterial.
> This looks like a plain and simple typo, not a logical error on the
> patch author's part.
>
> How about this as a changelog?
>
> --
>
> Pentium 4's which are INTEL_P4_PRESCOTT (mode 0x03) and later have a
> constant TSC. This was correctly captured until fadb6f569b10
> ("x86/cpu/intel: Limit the non-architectural constant_tsc model
> checks"). In that commit, the model was transposed from 0x03 to
> INTEL_P4_WILLAMETTE, which is just plain wrong. That was presumably a
> simple typo, probably just copying and pasting the wrong P4 model.
>
> Fix the constant TSC logic to cover all later P4 models. End at
> INTEL_P4_CEDARMILL which is the last P4 model.

Yeah, I agree it's more of a typo than a logical error.

