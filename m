Return-Path: <stable+bounces-77090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFAF9854EC
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 10:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBBB1C20AE8
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 08:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85F0155393;
	Wed, 25 Sep 2024 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mGvLtCl2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047341B85D1
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251387; cv=none; b=RJRWeh56CxDZjZ5URVKypMlfMLd1ZxRrgHgKt11QzLHuh9oNllI21H7lkW3z6Y3ot9nZBn/pkvWKO7dGiWGGJcPRWW33Ni+wJsnmN30vfS/PukHWl1QbuePDYqb8Pj34p/vN57TD4E7ZJucf842HOpLvDS3CAoOVZ7P4+tu1PZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251387; c=relaxed/simple;
	bh=KC4AtdJiQp/kNcVkRK65L8Wc0iJbJxqbXnpgkilXeOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLqkp4SGk21mi6QHUov3o6JzynZdaHss/AgGbP9BVAlU7HU/vmJMx2RBDTBct1u9MtpCKgTrGFRMdFQWxdgqN7KidfKsY2bQ8lFn+MQ3ZFGohLI+AGIWkDji6HsjhQ8siw/32t6IEfUDdgi+swfutxf8AwGr7sFUWTbt6lINphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mGvLtCl2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cc8782869so61285905e9.2
        for <stable@vger.kernel.org>; Wed, 25 Sep 2024 01:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727251384; x=1727856184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ+fam/PvLhYbOWT/a/RIKh+9OFa9edBiImjSc+55Pg=;
        b=mGvLtCl2zutrj0ej7dWUtnPtUOldd/Ay9Jioce1NXWpLetEVtmYckm8nVai84LAtoA
         wojI+iKAoz8ro1iYNVRLi+GZVxdY5oZ/QyVXEp34UlYlhwG5n5uX4G/x1KMrLinImdLy
         5lJAFFhUxLqtj/EEW+iuoMfejUXddV9/04Abr1gNjF1Xk5XL/ehruVreDeLZkJTtzNlx
         sZFQEegysOIDCAI6UrmEFqybrAr0Smeoc2XjwFn4zrwzio5gtFfXxHbr88QWW5eROt2I
         5sE7pYfJ9YOE907XSMCs3+efenhgQvLrZ92k8g2Eq2Zi6YaRwU/pFZHW+6UtBR16/via
         O+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251384; x=1727856184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ+fam/PvLhYbOWT/a/RIKh+9OFa9edBiImjSc+55Pg=;
        b=S3gDootVZDrgQVGNci58Qm3l0FvtzE+SYFr7XgMjd5WltMDNcJg+ftJTHUwLekejCp
         /IplZOtUZZgto/7A1xpERhzWPbVC1Lb4fpMKmERSuknopPZxYDnAKUL0OAo7/OzQRv/b
         HY94L9L9cZ0wEbegmARHZtHbHOPb7UmjLCrU/CeOI0mUkdZQtpBmhfss/HelR963/T7V
         Yy5YEJ9pC0veRy7d4OeAf4QabfZGoEbbeeBCF2+8rbySlDdVEiefaR/YPH7UgCb3ZWy4
         wtfhTBZE2wHMIYxJnrK9YsSHgrzoQAlGRUsWtTG1HX2DoGRX6WFRt8jRjc85OCuJDcpy
         LqNw==
X-Forwarded-Encrypted: i=1; AJvYcCXSgF7P1t3vcTd91kJzr3RCfdlnA3D3IojMmyVdZgSrUaRNBRazHnthGHxI42jRkNHVR+cKCis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmYSC8kJHjGodmUynw1D9IX1CC/1W3us7ZuPLKwsJGmjXcDUm
	3iFm6XWVjCaeHWPkOUNEHvppEqYj2fjZPVDdMEQanyGpSHIK682vJNJxFj0tG4i7nn7dibYlNqz
	23591d9wfXFO+0FwnBiplHlV4rEZ4DtlnyLOY
X-Google-Smtp-Source: AGHT+IG243UpCCYpCs5X1QJj7bDMyujqJv7q9NWuDQfoBISSICeehUSGZ+de78uCOSs+OYVfJHxdfLjC4AVlL/jFL78=
X-Received: by 2002:a05:600c:1d27:b0:426:61e8:fb3b with SMTP id
 5b1f17b1804b1-42e961362f3mr11298585e9.27.1727251384067; Wed, 25 Sep 2024
 01:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com> <20240924184401.76043-3-cmllamas@google.com>
In-Reply-To: <20240924184401.76043-3-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 25 Sep 2024 10:02:51 +0200
Message-ID: <CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6RWWUNKKyJC_Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] binder: fix OOB in binder_add_freeze_work()
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:44=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> In binder_add_freeze_work() we iterate over the proc->nodes with the
> proc->inner_lock held. However, this lock is temporarily dropped to
> acquire the node->lock first (lock nesting order). This can race with
> binder_deferred_release() which removes the nodes from the proc->nodes
> rbtree and adds them into binder_dead_nodes list. This leads to a broken
> iteration in binder_add_freeze_work() as rb_next() will use data from
> binder_dead_nodes, triggering an out-of-bounds access:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: global-out-of-bounds in rb_next+0xfc/0x124
>   Read of size 8 at addr ffffcb84285f7170 by task freeze/660
>
>   CPU: 8 UID: 0 PID: 660 Comm: freeze Not tainted 6.11.0-07343-ga727812a8=
d45 #18
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    rb_next+0xfc/0x124
>    binder_add_freeze_work+0x344/0x534
>    binder_ioctl+0x1e70/0x25ac
>    __arm64_sys_ioctl+0x124/0x190
>
>   The buggy address belongs to the variable:
>    binder_dead_nodes+0x10/0x40
>   [...]
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This is possible because proc->nodes (rbtree) and binder_dead_nodes
> (list) share entries in binder_node through a union:
>
>         struct binder_node {
>         [...]
>                 union {
>                         struct rb_node rb_node;
>                         struct hlist_node dead_node;
>                 };
>
> Fix the race by checking that the proc is still alive. If not, simply
> break out of the iteration.
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

This change LGTM.
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

I reviewed some other code paths to verify whether there are other
problems with processes dying concurrently with operations on freeze
notifications. I didn't notice any other memory safety issues, but I
noticed that binder_request_freeze_notification returns EINVAL if you
try to use it with a node from a dead process. That seems problematic,
as this means that there's no way to invoke that command without
risking an EINVAL error if the remote process dies. We should not
return EINVAL errors on correct usage of the driver.

Alice

