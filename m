Return-Path: <stable+bounces-74036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F151D971D08
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 16:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961D91F23235
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 14:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934921BB693;
	Mon,  9 Sep 2024 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fINFt5lZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43F1B81D8
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893271; cv=none; b=eulvRrMUDJDRcKFgPRQrQ5AXaiFBDl0E6NAhuBYHfrWNc6+yIBlq+fnzpe7noOki/IVnDmUh85dGkHNDOvc01Ex1lzCa3OTCTIoSzc5CJNpH0Iv+iVzqVLZ6AZSAzwcFxjV7TolE/7jyKVxirZvaIrVYJU4lFWHoiHWnBsZ4+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893271; c=relaxed/simple;
	bh=asAZe8YzvYhEV8FAxRmbmJaZ6esSeXwBmPV269inlNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzM5Gi6z4fCxUOWO0Sh2tyrpUW0vfvOnyM48pEwMq8T/OtYb5rRewFbku+BneZaD3rnA8HVn/Hlt7wWUAeZNTwkFP+wnRS9CiFV/2XaFo6wfAyc6GYReSRRWuZL6QObL6A5DKoF9jJFMDqTffUlfU44Lk8j4jvr7VADyt17ipUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fINFt5lZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-427fc9834deso125045e9.0
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725893268; x=1726498068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwgDAi1gLUiDWZhKqK1xpoJFYtWhb/ZP7ejGCNPGNUo=;
        b=fINFt5lZd8kdhrismc8ttdPFRZ6lqmJRWRW2rJtKp2Vy8eE9IuUi7EmtVAEv4xVY9Z
         g8VjR1AtBP9o9CnUDXGA932qQUNK0iEJOOa8h5ErOGwef1OGg/84TYymz3qXTj6dL0Gu
         1b701ta5WD91w9/JigjnTOy2mEB05sshE/AIvmPgrJhxGIJAaji6Pce3pDr3PyIkxRhE
         wy9kWV6lMrqRhh8WJhUNzRg08+YlV9FYY4QfqMDa8B8LkJa/x6Dm+Kw9qYlMQ9GI/QJq
         NHUuXVVe6CEICVKaoIg0aYjO89tDOeGwtiZm0HX29+regOPUB8p0cbaQp+nvYRaLHvqk
         buEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893268; x=1726498068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwgDAi1gLUiDWZhKqK1xpoJFYtWhb/ZP7ejGCNPGNUo=;
        b=TE1Q410OfLyZUreCp+a+AQ9Aay/SBXuaHn/iDX3gnQ6a7Jp6KSLAaUFxmtqO91LsWJ
         JcJPAwsC64sGSZlaId7zx0DuSsrMzNLUUGNCiHbbtI/tuU0TAVyMhpkwv32UG9SchGn3
         JzrGGfVBU94pW3IZBIQBc3rpOFaYMqV1Y6jrQ7SyZCR8NIj1FmC3+iH7pCXM/NfFjCUN
         q3Wnj3CdqBb5gCQgq0WfRVHf6Y+uUt8aphX1KEe/ApkraUAuox/0LMIN6jIfUQEbrpgf
         bCyxSui9BL2gBGGPuHYIM+FWBijPSby+2IoKF+1UKbt5U8PwkJ8HdUpHuPox7ZFbOp+5
         Nn1w==
X-Gm-Message-State: AOJu0YxpepZdaHhDhCDCtP2a47ScZ0XCoN/zRw7D0kqZfVPyyvoKw9P3
	VB3guShmF6ZZ2J3ttW7azOBHPTDdlgdl9hM7Xr8zOlkFEqwkZ7kowJY4MWPNu+WursSFgPS6KgX
	NJYiL3KBdmu+Y+TzK9c7dpy+zhT9bwAbXvL0971FsedgnLEzoi5K0
X-Google-Smtp-Source: AGHT+IHnEQNjibz7ncnOczoITR2Zv2f/YxqvzupCqqqX1E2j0n9LnLHv7RDVO+XCywWB7ZMdWTrBz4SHh7xBfyKChPw=
X-Received: by 2002:a05:600c:a00c:b0:426:8ee5:3e9c with SMTP id
 5b1f17b1804b1-42cad76493dmr3275735e9.6.1725893267373; Mon, 09 Sep 2024
 07:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909124838.1803757-1-sashal@kernel.org>
In-Reply-To: <20240909124838.1803757-1-sashal@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 9 Sep 2024 16:47:09 +0200
Message-ID: <CAG48ez3GBwDc=RWVixeNW8Ppt4J2dOk0wUdEjoYZ0x3_1ToyAA@mail.gmail.com>
Subject: Re: Patch "userfaultfd: fix checks for huge PMDs" has been added to
 the 6.1-stable tree
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 2:48=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
> This is a note to let you know that I've just added the patch titled
>
>     userfaultfd: fix checks for huge PMDs
>
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary

Thanks for the backport!

Are you also doing the backport for older trees, or should someone
else take care of that?

