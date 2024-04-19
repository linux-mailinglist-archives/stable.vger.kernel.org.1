Return-Path: <stable+bounces-40304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A888AB25E
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 17:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70CB3B2271A
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7DF131BD8;
	Fri, 19 Apr 2024 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kLNBUJaj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CD2131BCD
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541798; cv=none; b=QdcFj5C234xoQh9hEaguX1CcxB1T6JbH7cT2HplIKFBmi5C1Wln76BvFbEUlK9BPda+aQbow7vjK32X0yM+M7zg3vnkd0OFhIFue/E+N+6tjK/9NAuo9JetMsuMvkCSFzQ/3dHCXuufxmc7m7JyWx0MnwvAz64iX3Gm3vVkkT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541798; c=relaxed/simple;
	bh=o9Wt0L7mfn4e5SKlBKe2quNuWXCmRKz/1hA/dP3UNk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2lq9E2BXHdz9ybfrbY2t5/nc1rzmlrOHHDlWTM57/hMfCxfP0LFWKH7idXMOgF5ihjckwg9i2WDsh01XHI7N4EKwlgBAhEvzhV/BGjolAZ6RGwCSehuDcbuziO1z4QOaZ9JfeokTTEwd4jlk9D+h67Dqf27SyNTpb8ecqko924=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=kLNBUJaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09F4C072AA
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kLNBUJaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713541796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o9Wt0L7mfn4e5SKlBKe2quNuWXCmRKz/1hA/dP3UNk4=;
	b=kLNBUJajHs0RNwPRN71/HPZ43tQkV8qR4cnxgHg5xmECXNLff3sqOxYjFX86apc8U4A/no
	7a8yzJ1+IHp3W+OfA8sNxRGZ43qlvQgk89UVYbsu96nVV6GSZuFFgeoxm9E3nXG7H/6pvo
	+PQi0tEi9YLgsDq2vFtHLIxz3oIhIpw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 992b68b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <stable@vger.kernel.org>;
	Fri, 19 Apr 2024 15:49:55 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2274116276.1
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:49:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjC7w40cLBqGqJNypiha7dH9PVrClD7Usu8sp3FVBa/3IGvRkd4K5zNhh6ku/3VscA0IYcwBEPUnP7H2NW3ZVG3N9Eqa+r
X-Gm-Message-State: AOJu0YwuCPhGmDZAFzJ6gSfmIWD/dsHGdzZfnXZrKHd4RLOjhWRL1T4j
	ZXxRVf5YYmX454yL7pP3xfbTWxGSftxk8pDWpIQDGf9agRMT2eB0JJEE0RwD1Q4MustpMOS1PU4
	r2eQMV8LlAPLUsyr3ZopxtVI3vdQ=
X-Google-Smtp-Source: AGHT+IE4XWVS+lUXEINOq+AOps/uOZeKCMuA2Ae4TQ/qKPW4xbcIeT3GxaXEod0xRU1RYBwyw0LY9RdrxVaSEuqw53g=
X-Received: by 2002:a25:b222:0:b0:de4:8c46:e7f9 with SMTP id
 i34-20020a25b222000000b00de48c46e7f9mr2338049ybj.31.1713541795439; Fri, 19
 Apr 2024 08:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024041905-obvious-blush-10d8@gregkh>
In-Reply-To: <2024041905-obvious-blush-10d8@gregkh>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 19 Apr 2024 17:49:44 +0200
X-Gmail-Original-Message-ID: <CAHmME9rDDAB_6FA37LfvyyKZeBmLo-s52GiOQXJF8K2Rt_t3kA@mail.gmail.com>
Message-ID: <CAHmME9rDDAB_6FA37LfvyyKZeBmLo-s52GiOQXJF8K2Rt_t3kA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] random: handle creditable entropy from
 atomic process context" failed to apply to 5.4-stable tree
To: gregkh@linuxfoundation.org
Cc: guoyong.wang@mediatek.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

5.4 doesn't have f5bda35fba615ace70a656d4700423fa6c9bebee because of
61f87ea3f957298b05dc62e3722da0e3d4232c5b and so we don't need to
backport e871abcda3b67d0820b4182ebe93435624e9c6a4 to it. So nothing to
be done here.

