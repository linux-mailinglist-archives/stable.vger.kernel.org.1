Return-Path: <stable+bounces-33097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD348904D9
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 17:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AD328BCF7
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB9131E34;
	Thu, 28 Mar 2024 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0r/vY99k"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA5E130E35
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642736; cv=none; b=kHBe1neIUrCBXWWdXwtt2aWtVzmpoToCAb4yh2MVwVML8R0mY3uav3GXcEfc4Eikm3+N2kREmxgIkqxHXkEVBgejzWuXhWyX0OVAq9l4WSe9kYrH/ACzOa5kuUrphPfKzJcl3LB8ueRQk9CojwF3PXadBvEEhnJNcG2lG10JYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642736; c=relaxed/simple;
	bh=GBsn4xh0VH3bSK4OltJrohHyGLgnl+zZmaIezM4iDdA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N2nHrvAgFLtroqxaDvj5SRP3Mbj1lBDZtROhMXUDwcyoL3lOVwuxJhNE5DAdAiNRnIBptUuAN6dQBlILF2MwRnCEnSRfXjRAmJLdQX7xbcdn/rXK7gCddS9KGxrJn7Nz0lPQclG/QuEb1WHrgr7z643BmhbILqMIEKmaByfsLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0r/vY99k; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so1667196276.3
        for <stable@vger.kernel.org>; Thu, 28 Mar 2024 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711642734; x=1712247534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=umIDKJbLUeVjB30WBmxntoX4c0W2blxouvOQBNQgTYQ=;
        b=0r/vY99kXoMzxkp4WPFgKJ0GDP+V8Gwm+QmvZ+Fc9oyjqDd5/gHMIjMRlRhtHIY10D
         WVDAlKUYiZWlKgYN67wG3236TFGcol02GKfz0/4C0dUcq25hVT4GJk+RFoGPsmFBSGLt
         KK5rOj1yqtH7/2QFgvAuwJf9X7QMZfYvkLZCGs9c0u7h4hbhxSh2VlLzdXGYrn02EEkX
         ix7r9HQCoNchwR6mXhKkBziU3ubyXuEMouTDkkeOH63kgPA5AdHsK3YdXechPbqHEP6c
         Q169M/2uYfBbNUDkJSEkiMvdeXyImB4UCpnzJwl7joD4KsmkbKeuJfvTjdEZDeyhE9pd
         2fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711642734; x=1712247534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umIDKJbLUeVjB30WBmxntoX4c0W2blxouvOQBNQgTYQ=;
        b=NGZRfk9InP+m6lF5tG+5yoozILJs/NDxdIIzKvxWHxk749BHuBCRQ+X72tmHSFukrE
         IJl19ctRmPgTAJKx0hyCEYx6dksF3qVJTuEFVX7h6vQmvmJCLhN1HatNXjtcJlu2GImk
         SiMCohOPlR+vjBbdWDmySlXQe0w+zD8sT8rPeTbBDj2rJrEdxm+ZV+MF+sm9hNJAP0fz
         ScTEUiunrhbxbTuP4H4Jyw71PBC09M+HxnwHh8Clrg9TYjLevb5uJorNW36uczANI9Hn
         RK2HuUj4DNx7Y0Y5jQqsqxQoYh9ZnVny2z3ktlTtanuUT5H0TeNsgpCAAfbbY/aMsNlg
         KM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbnmLpBCnHRXWga+0JHmyZ3zBMFqUMXUEMHUS+Jcu29R0O9igZnCqaHh3YP+8PyYimKXMbRa0EJ5exAAeKx9XTaD0qqML4
X-Gm-Message-State: AOJu0YzsItQVvegYcfR46SzDoxVuB0IWfp5j/1B8T+slCqi4wuzT+GWP
	P/y5/kY62E3qP1sL+mkJvtiIOGf755dHmh1SlZmtGVEKTcQ1zxx2GrX5b6KPtLvpOhUear+Uhu0
	UTFHBnA==
X-Google-Smtp-Source: AGHT+IG3wG69Xu1UOnAeobYYfeZbnbL1W7AO1OICQ5yW749ORUJQcN09ufbTLMPe/kI+kz+CtqMiH5GZrRAU
X-Received: from gthelen-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1b13])
 (user=gthelen job=sendgmr) by 2002:a05:6902:2292:b0:ddd:7581:1234 with SMTP
 id dn18-20020a056902229200b00ddd75811234mr194893ybb.11.1711642734480; Thu, 28
 Mar 2024 09:18:54 -0700 (PDT)
Date: Thu, 28 Mar 2024 09:18:52 -0700
In-Reply-To: <20240328110103.28734-1-ncopa@alpinelinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328110103.28734-1-ncopa@alpinelinux.org>
Message-ID: <xr93zfuifhxv.fsf@gthelen-cloudtop.c.googlers.com>
Subject: Re: [PATCH] tools/resolve_btfids: fix build with musl libc
From: Greg Thelen <gthelen@google.com>
To: Natanael Copa <ncopa@alpinelinux.org>, bpf@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>, stable@vger.kernel.org, 
	Viktor Malik <vmalik@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-kernel@vger.kernel.org, Khazhy Kumykov <khazhy@chromium.org>, 
	Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Natanael Copa <ncopa@alpinelinux.org> wrote:

> Include the header that defines u32.

> Fixes: 9707ac4fe2f5 ("tools/resolve_btfids: Refactor set sorting with  
> types from btf_ids.h")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218647

Tested-by: Greg Thelen <gthelen@google.com>

> Cc: stable@vger.kernel.org
> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
> ---
> This fixes build of 6.6.23 and 6.1.83 kernels for Alpine Linux, which
> uses musl libc. I assume that GNU libc indirecly pulls in linux/types.h.

>   tools/include/linux/btf_ids.h | 2 ++
>   1 file changed, 2 insertions(+)

> diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
> index 72535f00572f..72ea363d434d 100644
> --- a/tools/include/linux/btf_ids.h
> +++ b/tools/include/linux/btf_ids.h
> @@ -3,6 +3,8 @@
>   #ifndef _LINUX_BTF_IDS_H
>   #define _LINUX_BTF_IDS_H

> +#include <linux/types.h> /* for u32 */
> +
>   struct btf_id_set {
>   	u32 cnt;
>   	u32 ids[];

