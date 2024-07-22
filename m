Return-Path: <stable+bounces-60710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1721939212
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26942828C1
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C4D16E885;
	Mon, 22 Jul 2024 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wF2D5lE2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896FF16DEDC
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663414; cv=none; b=Z3Ycg4m/VkgGWf225h4z+16cXgplGIbd5JP/85nChkwHHxGxSJsIQ+40S1WcTMdIG4CDEXH7m9xdWxYCjEJd3Jbd+vgIRhgNGd6UekSFZfaGD6QQ/XHrqRfMgkzo5JTOsi9xvgDPVF9GT6R3420Mh5Snj7RUhncTR5ow0AbaH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663414; c=relaxed/simple;
	bh=cft8De0rOdLMA2TFzR9XQMhpnKUH+KqciFEMfcMmEHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBO383mXBJ5QjT/RNT70GdJG+OYSIWbEZZADUzuhZevF89IFbK6MrKxgiW2UfKw6vr/C7097bxQ9ZLFNQzW/4o9V5IM4kTxk+D+RrwoxoWaxf7zxJ3FKFDiou3f8Hiwm4uqT0daTvFoUNskcnFOscTa+JTYX+dVSdKaVOjhiW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wF2D5lE2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fa9ecfb321so28967275ad.0
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 08:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721663413; x=1722268213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7QwNuj6lZS/ftf4P4bJ0/0rg3/Xo5t3f0pEuL2apGvM=;
        b=wF2D5lE2XxXCHz+C3PqKHFzi6ojqzJYQNX6ZioB1SZj5BG9k6iypx1XzJt2Ke+evMy
         0JF+GZZXwy808mXS8jT9FifT6cpvOqGhwdI9wuGOfchZtidXm/36tuJecnV/nuR23UUU
         8mHrNoatcZEmE3AppyLXI5kgEWw5+7YZeXmWI8KPQ9EE5g9io2AuwbBwJi5B7Ck61Ndi
         zNUy5Cmi+9szsWeKfKY63StmH8ide8w4CMjGCNZn91AA2p4WWHT64zbXcFtr1NfwkG1i
         NVlngewpHljHZP5H+Yg8vtgV9+v/B9uZ2ncP/VFA1ux9C4jHweCdBg3qwDRPZ7LG3nPo
         Qtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721663413; x=1722268213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QwNuj6lZS/ftf4P4bJ0/0rg3/Xo5t3f0pEuL2apGvM=;
        b=V+TrVz11t05VtsZL2sukHIbnvAoLQqHtqiWKWBYYaU9YnQ+JeoPY8/HpGFuahMczVX
         WT8+hpnujfR9xFRLyxzPQ2kZwKlFcGg+BsV2kDevXvqu3dmwQyBLkjjlC8GzONAHIDvU
         Q636jUVkUHqWmUrq9Qagv0IGENTedHEud1smFsaFNgPgMT4Ogwfhv/7RZmpT9QcCfPTe
         yTBCVqcT5f5Sv0hftb1RZGMs5EKO6AQbbi8GCvNZ1yhWZBPUL4mH50LVNFSzAv4868t7
         03MrVUp5/tKy4H4ZV1MhqTzQnIQ5f2bquIqcL8BNUwOWvxz0WsNpOxUjurlxmhRaZJNf
         XDeg==
X-Forwarded-Encrypted: i=1; AJvYcCVDIl9IQCefgy1GdxdsHGUg3HgpJZDSVAYQuTtx++nUNpF3y4wLw55YHbxhVp/PGtvrye845OJchudhNIq7e8qPY627XFX0
X-Gm-Message-State: AOJu0YznxKV0rGXtp/q4rF3yjl8DZXyQXpI7ibL5Ni+rIdoWX3ugpHwp
	MxL/fh8AMw+SU+rS+67AvbKVZ3jg37jSnXBkLjxjdNnmmqKO5CWDodp0u7fNJw==
X-Google-Smtp-Source: AGHT+IHWAnm4Hy9monHHhuBEAiBgz1usw01NysziHWY6bcyDOE33yiAF2lcrSpqviyfFBWpbH5lEow==
X-Received: by 2002:a17:90a:e594:b0:2c9:a56b:8db6 with SMTP id 98e67ed59e1d1-2cd85dc819amr93489a91.37.1721663412310;
        Mon, 22 Jul 2024 08:50:12 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b2adafsm7234103a91.2.2024.07.22.08.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 08:50:11 -0700 (PDT)
Date: Mon, 22 Jul 2024 15:50:07 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	syzkaller-bugs@googlegroups.com, stable@vger.kernel.org,
	syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] binder: fix descriptor lookup for context manager
Message-ID: <Zp5_r40tsnm0AluS@google.com>
References: <CAH5fLgj6=6ZcVT13F8kP7g2NnRgBmZn+KKPANt=fSoFEJisi-w@mail.gmail.com>
 <20240722150512.4192473-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722150512.4192473-1-cmllamas@google.com>

On Mon, Jul 22, 2024 at 03:05:11PM +0000, Carlos Llamas wrote:
> In commit 15d9da3f818c ("binder: use bitmap for faster descriptor
> lookup"), it was incorrectly assumed that references to the context
> manager node should always get descriptor zero assigned to them.
> 
> However, if the context manager dies and a new process takes its place,
> then assigning descriptor zero to the new context manager might lead to
> collisions, as there could still be references to the older node. This
> issue was reported by syzbot with the following trace:
> 
>   kernel BUG at drivers/android/binder.c:1173!
>   Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>   Modules linked in:
>   CPU: 1 PID: 447 Comm: binder-util Not tainted 6.10.0-rc6-00348-g31643d84b8c3 #10
>   Hardware name: linux,dummy-virt (DT)
>   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : binder_inc_ref_for_node+0x500/0x544
>   lr : binder_inc_ref_for_node+0x1e4/0x544
>   sp : ffff80008112b940
>   x29: ffff80008112b940 x28: ffff0e0e40310780 x27: 0000000000000000
>   x26: 0000000000000001 x25: ffff0e0e40310738 x24: ffff0e0e4089ba34
>   x23: ffff0e0e40310b00 x22: ffff80008112bb50 x21: ffffaf7b8f246970
>   x20: ffffaf7b8f773f08 x19: ffff0e0e4089b800 x18: 0000000000000000
>   x17: 0000000000000000 x16: 0000000000000000 x15: 000000002de4aa60
>   x14: 0000000000000000 x13: 2de4acf000000000 x12: 0000000000000020
>   x11: 0000000000000018 x10: 0000000000000020 x9 : ffffaf7b90601000
>   x8 : ffff0e0e48739140 x7 : 0000000000000000 x6 : 000000000000003f
>   x5 : ffff0e0e40310b28 x4 : 0000000000000000 x3 : ffff0e0e40310720
>   x2 : ffff0e0e40310728 x1 : 0000000000000000 x0 : ffff0e0e40310710
>   Call trace:
>    binder_inc_ref_for_node+0x500/0x544
>    binder_transaction+0xf68/0x2620
>    binder_thread_write+0x5bc/0x139c
>    binder_ioctl+0xef4/0x10c8
>   [...]
> 
> This patch adds back the previous behavior of assigning the next
> non-zero descriptor if references to previous context managers still
> exist. It amends both strategies, the newer dbitmap code and also the
> legacy slow_desc_lookup_olocked(), by allowing them to start looking
> for available descriptors at a given offset.
> 
> Fixes: 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000c1c0a0061d1e6979@google.com/
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Sorry, I forgot to feed --notes to git send-email and the list of
changes in this v2 patch was missed. Here it is:

Notes:
    v2: updated comment about BIT(0) per Alice's feedback
        collect tags

