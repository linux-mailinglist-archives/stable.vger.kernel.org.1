Return-Path: <stable+bounces-77896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E31988250
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A920283276
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211D1BAECB;
	Fri, 27 Sep 2024 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q19ldVu0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D622482E9
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727432378; cv=none; b=pWByy2nhpcoWAEPaJLtjNQUH+PwXiDYA3fuCGQrdoKP2iqqNEV/Nxt2vBpazD9uDw682vY6BEGZZxLJNmW9TsccECySuwmFkiUq0NJBLhoHOLqJi2chELsWZhIOEeVihiIcPohWOwsoBqGsczpwdquUk6oK6E8SA7NwpFG0qjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727432378; c=relaxed/simple;
	bh=r2nGY5XosZLvhL8LG7BirJ7fcx9zXAPApYpYoQ7lA6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOpjHerer+GUumozcSyy8tboqHLge3Hd9YoUiHJ3f2qFx/qmumpIZc0c7AfK/oJDhuBVYOuhov1XjB10hPBBmtZz/R8LeXyPYhygp4LVPS/d+u1jXW69hqcD4gyx/Km7iD1mAxaMX2M55CbtnxfynnB0zNB7RD7eJnchsGPWTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q19ldVu0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso16509695e9.2
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727432375; x=1728037175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHVAa8lbYDFK8qlwbMQEGU86eNjcQw5XBOmf4eoXKXU=;
        b=Q19ldVu0ksy1QsyimolHs5wzaqMFoeKQYOf0Ps7q8G9u8MN7UDX7E+NfYcYzHD57wh
         1nPPSezl5vdxVeJ6DXa/KiBgMYtw973BBXy+Ek6qeTYKKnYF+VMx8JkOvHZUkzK+6UyP
         6XHTncA/q80xLxeyyY9nWzbVj8rmhwAww+R6j4ckTqBle1D1c7+BrEKdQQJzViwX13A2
         eJAs500oseHROntppCPmNMxbPsbTM65Xi8SLg3WG2ly3jf7Q8fR8Lr1laP22IEXpVtBO
         xjZARmfSpEsnLITLH0C/svV88OQB10fmnXsnZUT9cYqo+xBSwQ+m/vO9ZfznzZOZgkIz
         m89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727432375; x=1728037175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHVAa8lbYDFK8qlwbMQEGU86eNjcQw5XBOmf4eoXKXU=;
        b=T6UtJG4vplSA2wL6Ug5+G0NoVZxygEW5SYW9bfp4iFnoJbSsLuSCtuKbB+qlQ0gf/+
         +eQ8k9amIV9XQ6PQY+DCY5ZA98XAwVICbrbZxxVIMQliS1OMJUGajEo/F39Ps08iFLm3
         R7JMjK3wcRwLW0hxoxIHjIiMnT5cG6MQCbugvPIzfponCz6xpgw5VBR2KzJF7nxWWkB8
         Mt8FffSH0Pt9ZLS9+rUmYLQWaia0p6bfYnC/FV2TrrBfQXbJT1/HgFwQ5dgtIJ6K9uXJ
         dEakRFnj4p6WxQgHFP0PirxbN25dQiZ2OsnbqgidFEoplod11hnRLDCY9ACw6PZao6d8
         YwWw==
X-Forwarded-Encrypted: i=1; AJvYcCWnBcrKf8u27eCUovuipO4krji5C1xNfMVRddVv1cTHiO1mMAFdz4K9/etwHkvCGk+KnGiXuA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfuDFDOM1WpgYpo/E+33KHnoJi16dyiUXKE+8B5tHkkU6YXjPi
	fVbzbCy/r0yLcchZ9xeDCGv9Dtp+h3A+y8c9xIeEDhYZVLAzCwfbg2BTOirBsTyNUqwRUhNCeSP
	+HVkuvZeHnmsd4Quh+/Ye5407PIK739HT6DL+
X-Google-Smtp-Source: AGHT+IHxWcgo5ekOuFArzW82z6A/HrHrycAuGRUsEhyuNoazP534GrzgJtxXZlGOSM14YyHH+6fTEuzheNk4xcGmx3g=
X-Received: by 2002:a05:600c:511a:b0:426:8884:2c58 with SMTP id
 5b1f17b1804b1-42f5840e1famr17846585e9.4.1727432375238; Fri, 27 Sep 2024
 03:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-8-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-8-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 12:19:22 +0200
Message-ID: <CAH5fLgjAX9GGWaDwgztp1-x0O+geX__SDBBrkXHy9o3bBymVNg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] binder: fix memleak of proc->delivered_freeze
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:37=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> If a freeze notification is cleared with BC_CLEAR_FREEZE_NOTIFICATION
> before calling binder_freeze_notification_done(), then it is detached
> from its reference (e.g. ref->freeze) but the work remains queued in
> proc->delivered_freeze. This leads to a memory leak when the process
> exits as any pending entries in proc->delivered_freeze are not freed:
>
>   unreferenced object 0xffff38e8cfa36180 (size 64):
>     comm "binder-util", pid 655, jiffies 4294936641
>     hex dump (first 32 bytes):
>       b8 e9 9e c8 e8 38 ff ff b8 e9 9e c8 e8 38 ff ff  .....8.......8..
>       0b 00 00 00 00 00 00 00 3c 1f 4b 00 00 00 00 00  ........<.K.....
>     backtrace (crc 95983b32):
>       [<000000000d0582cf>] kmemleak_alloc+0x34/0x40
>       [<000000009c99a513>] __kmalloc_cache_noprof+0x208/0x280
>       [<00000000313b1704>] binder_thread_write+0xdec/0x439c
>       [<000000000cbd33bb>] binder_ioctl+0x1b68/0x22cc
>       [<000000002bbedeeb>] __arm64_sys_ioctl+0x124/0x190
>       [<00000000b439adee>] invoke_syscall+0x6c/0x254
>       [<00000000173558fc>] el0_svc_common.constprop.0+0xac/0x230
>       [<0000000084f72311>] do_el0_svc+0x40/0x58
>       [<000000008b872457>] el0_svc+0x38/0x78
>       [<00000000ee778653>] el0t_64_sync_handler+0x120/0x12c
>       [<00000000a8ec61bf>] el0t_64_sync+0x190/0x194
>
> This patch fixes the leak by ensuring that any pending entries in
> proc->delivered_freeze are freed during binder_deferred_release().
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

