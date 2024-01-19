Return-Path: <stable+bounces-12292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B354832DB3
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 18:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2699E1C22EB7
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 17:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9951355C2C;
	Fri, 19 Jan 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZcputRn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13D55C1B
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684292; cv=none; b=tQB+loHyS0B2uaqpCJirx2Uo6IIJgDhiZxBwzo7rL7y/2YQfaGLAvGohsAQWhAiIOSqc1PqD8nVJPXskLb2FmVQxmSg+9wz6tIlhmkB8z5NyccibS3L/XtgvTzinpo9DHzoCDELtASdctBebZEWUZUgqNr8qpDk4B/fhIfHk95g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684292; c=relaxed/simple;
	bh=2/p506ZvO5GsIXwzDe+zqGUr6ySQqKjLLVfiaEt2pL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laMkxM69KdjC5VBcI6HUjY0t+MDXh5hCqUy+CCaSA7R62Ko1r2dmEdJcKBDzYQ7rCU2RvfRbXr+TblzAsFUMRDYjMwX9UZ9JUVvlJQpctrXR0h4DSdAEgLZZ5iQSgCcKnDHFOZO8kvfR3+xNU/8X3HtcrcgN2qQGEJSi+PvOQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZcputRn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d70c3c2212so7671015ad.1
        for <stable@vger.kernel.org>; Fri, 19 Jan 2024 09:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705684290; x=1706289090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TP3xgW37E4s9QsJwv9VFLnSNrhK1MDLNOYdnQNaP7rI=;
        b=HZcputRnIOIIxhtpfjcFSN4V37glVlQjzPJhG2dkeJWK9KOK+8IGl4hWXp+syuRAuV
         3hAJ8Th+SQd3H1mHaf9sKM+74SvQKIIhpE2XwzmjRyzPVcLyTdGG9kGoSW39AaTJK1qM
         GqGTzNGXLd4HjmCmD5mtmzghYQRWnE0zJSTsiNpX+/I8g+TW+ikp0BDZEMnY8sbQlTzg
         MMKSQvH0FsoGurJKIS5cAvbcTmy9O4Omz/zthHCLGhFO2Yk54NU72iZRIIyAvDyBOh72
         qMreok4ieebQnvHm+FKJqg3vAgoeSQNpkz//e72WHooOE+ZdqfXnlKiv+kar4JlkML6d
         JJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705684290; x=1706289090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TP3xgW37E4s9QsJwv9VFLnSNrhK1MDLNOYdnQNaP7rI=;
        b=CsED+qXeNGP1mbS/intWbks0WN7toRPZMrYQYac8/rkeHJQOZopV7a9TPGIQDveg3x
         vUAMqgRyhkKE/Yc8X7Pp6ZgjDf2KhkaJkrTRq3N20iUlEcuQ8tBO9PV5Xo4aoLQZny0N
         DlWMkfCSUHfIpgbnf2eHSGb5amADd1T9subWP3cTNHyWexBxHhBAGX+ObmWMpp4CiUFp
         25upWTpy3vUk4z7fGrPdQpW9jkX+ogOxG+ApM8iygizhKojUISM8j6edRfBaVp18fl4x
         a7LW823UFUjcwV4O+kId9h1K3R3C38QFL6pbbFSA1hhSiikhWHPL4ZNa9J0bXUPEbn6r
         TIXQ==
X-Gm-Message-State: AOJu0YzK/AK3qX0zNX7JviT1Su6KBXgUibREp6vUrHzACvmKvBgvRN0s
	QZStCoquujTl3QoC6RF/zVKCU63SDZ9ntJ3m2EOw41+oz3CiR6UDCaU/oWWEhg==
X-Google-Smtp-Source: AGHT+IFGmoiv70FPHh58Z0FTxGqfyd+JtLAeEaWOLTUh5eTnZB2+fVnR/zBt1LSHBVJ2TW1fpBpu0A==
X-Received: by 2002:a17:902:e5c6:b0:1d7:2a07:7841 with SMTP id u6-20020a170902e5c600b001d72a077841mr105478plf.27.1705684290394;
        Fri, 19 Jan 2024 09:11:30 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id mg7-20020a170903348700b001d69badff91sm3290969plb.148.2024.01.19.09.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 09:11:30 -0800 (PST)
Date: Fri, 19 Jan 2024 17:11:26 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sherry Yang <sherryy@android.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 04/28] binder: fix async space check for 0-sized
 buffers
Message-ID: <ZaqtPrVhmfvDYzCU@google.com>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-5-cmllamas@google.com>
 <Zal8uGqP2lLZz_oz@google.com>
 <2024011948-sulfate-tartly-7f97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024011948-sulfate-tartly-7f97@gregkh>

On Fri, Jan 19, 2024 at 06:48:53AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 18, 2024 at 07:32:08PM +0000, Carlos Llamas wrote:
> > On Fri, Dec 01, 2023 at 05:21:33PM +0000, Carlos Llamas wrote:
> > > Move the padding of 0-sized buffers to an earlier stage to account for
> > > this round up during the alloc->free_async_space check.
> > > 
> > > Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > ---
> > 
> > Sorry, I forgot to Cc: stable@vger.kernel.org.
> 
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Oops, here is the complete info:

Commit ID: 3091c21d3e9322428691ce0b7a0cfa9c0b239eeb
Subject:   "binder: fix async space check for 0-sized buffers"
Reason:    Fixes an incorrect calculation of available space.
Versions:  v4.19+

Thanks,
--
Carlos Llamas

