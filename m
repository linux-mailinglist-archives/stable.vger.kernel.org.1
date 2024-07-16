Return-Path: <stable+bounces-60342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061BD9330A7
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE50284B22
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B2C1C6B7;
	Tue, 16 Jul 2024 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VtQ2jsFu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74B1643A
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155741; cv=none; b=j4goGp71UIKNNGn28Pe3W02kKLnzYTskzm8Ez1qdP99vAr+AJJNFaTDJeylDHkBawfC1ik5szVtVUbe+Tsc0JFA/OvVhstQBIdOweW7o5Iz7OF4h8LAleTHeXx5xtE5L/WVbOyFMvVVRaDVoQFDsCmmHygwu9CSyMRzA5zh/iEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155741; c=relaxed/simple;
	bh=4a9oizCqoNQJ0k84IxD0VO3ymLl8h+xl8RQJLQgE1k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqxieNU0aOUKVZGlfggbDDF5CyqKWo7Ncnx8Hj/J60hoZjaeJRTaZwhbQJkQi0hyAKtABg+o73u7of9GeRqWbKHJuOjPvyP8wQWhR26xtkLt1u3Fktgt9HtpoSiWmsNawZtgYaxAPsN6CsXcIyiGbFh5sqJnBxNVW6T/RfkqI9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VtQ2jsFu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc424901dbso6399715ad.1
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721155739; x=1721760539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjC4n0At76vs87q3pB+e4WmyBPsYZBikspG4sQouzTE=;
        b=VtQ2jsFu8yzIsgFNYjiO+59YcWfvQf2cNYZsuqBT5FaLYwwo1XdqDkUlQNqLjUsm2v
         PxSZ/jG1TiwZIBnQalREVFIr3KRvrN9ky8WZ0mzGSB2+hxTiR/68Dk+4TqepXhke+Dlu
         YYL7cTn4/mJ5/AaDTEDOi3/x4+/QFWOREar2iPm7lgPfWmFBGl4DVRorSQCaBA4JlnyX
         VmqxRuDYKNuxmmiaUANK+Vj6+IYAnWBW/Bq70l7BEHH+BtkqBV3Kb7R3anh02UwAJ04B
         gfu2FapXLqo+fnp30YX9Mge+F2sJp8tK9fVHOo7xgCnllX4BrQLxSZmE1MjfCUGlXLcL
         PV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721155739; x=1721760539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjC4n0At76vs87q3pB+e4WmyBPsYZBikspG4sQouzTE=;
        b=sNgm2vJ1xJDQPPfJdg0XNE1CZQDtKPb/qhVArF9zp/hu69Rhe3DbQzTCEhnC/v3nTK
         jkUMgecPrvx9Gy2nNJGt7EJVots5ACjYmxAe49ZQX4yEgaZVQR72b21IiCGWS+d9oax3
         S6QLUvyWRPTCqO0QDRPWvJq3PKMujh5PsGGMPKUnOMix8/rozTQDc/ZV6iPPi7MPaO1T
         krJDdz/fZ/NCe4ILP0ngqVY4+tvy2pJ1udfIm0ILyfcNCgyzljWbb5vQDvASVGiuvbNq
         65K/Pb/21ff8X7YwjIKJkn2Sx2DTDWyi+ljYbIDIWUsigwrpXloABJmhXjzpzHmqADWh
         Pm6A==
X-Forwarded-Encrypted: i=1; AJvYcCXr0v8mjcqU4oKDtHJ+5zpBHxvAO+xMitJEHzEbsir/O49ozeqNPEfptsXR7lQMa+zf/vcvoL0k5c0jjuZflw7orT8AJfbZ
X-Gm-Message-State: AOJu0YxvZLQ4sBYkVntO40n9rvUGMGQYaxyIWFHK0LzWz08iaD/ZMbi6
	hqOazV+AF409UwsE/XwaOC9rsMKgaJZ4+GZPwqZXjaVVhBYxYs8YRL3PqPi17A==
X-Google-Smtp-Source: AGHT+IFmEp4bRpiiSSOiyiVjI/X1kRp2cSYdIsnb99+Xoyu44AkxRUTvlxWO2rhInC3LaXp2lP+U2A==
X-Received: by 2002:a17:902:e945:b0:1fb:247b:aa2a with SMTP id d9443c01a7336-1fc3da1012amr26878315ad.59.1721155738703;
        Tue, 16 Jul 2024 11:48:58 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc5050csm61519755ad.268.2024.07.16.11.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:48:58 -0700 (PDT)
Date: Tue, 16 Jul 2024 18:48:54 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org,
	syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com
Subject: Re: [PATCH] binder: fix descriptor lookup for context manager
Message-ID: <ZpbAlnAeCv-eiNzF@google.com>
References: <000000000000601513061d51ea72@google.com>
 <20240716042856.871184-1-cmllamas@google.com>
 <CAHRSSEwkXhuGj0PKXEG1AjKFcJRKeE=QFHWzDUFBBVaS92ApSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHRSSEwkXhuGj0PKXEG1AjKFcJRKeE=QFHWzDUFBBVaS92ApSA@mail.gmail.com>

On Tue, Jul 16, 2024 at 10:40:20AM -0700, Todd Kjos wrote:
> If context manager doesn't need to be bit 0 anymore, then why do we
> bother to prefer bit 0? Does it matter?
> 
> It would simplify the code below if the offset is always 0 since you
> wouldn't need an offset at all.

Yes, it would make things simplier if references to the context manager
could get any descriptor id. However, there seems to be an expectation
from libbinder that this descriptor would be zero. At least according to
some folks more familiar with userspace binder than myself.

I think we can revisit this expectation though and also look closer at
the scenario of a context manager "swap". The procs can still reach the
new context manager using descriptor 0. However, this may cause some
issues with operations with refs such as BC_INCREFS/BC_DECREFS.

AFAICT, the context manager doesn't even need a reference. But while we
dig furhter into this I think the best option is to keep the behavior
the same for now: reserve descriptor zero for the context manager node
unless it's already taken. Changing this is non-trivial IMO.

--
Carlos Llamas

