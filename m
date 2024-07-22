Return-Path: <stable+bounces-60709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AACE9391EC
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 17:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB993281FCD
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA1516E86F;
	Mon, 22 Jul 2024 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFaE+JAO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BFC2FD
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662778; cv=none; b=tw3Vk/zQyoZDQYqAr4Cnxl7YKoqZA0XE394FCtrZsporu6iF3JYhgYahkIzkBslrjuMtxBKM871DTQfHNp3zxt0QznBdNuCS2p4akpa1ef6GzLOuKGOgeuPxbhvdSj1eB/rLxoq6nABKgbMPvLAc3wjxW3TerGKdyh0kmDzZnTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662778; c=relaxed/simple;
	bh=cNUxyeKWJXB1FAFRTRbyYKPpovAm6su4pu9T1vm7jkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RskG+DP2ARnKcyU0heQCFzc/wkcnkr2SQyhpzvzsEbWEMht/JnywS3q39lutXr9NFON+6SqTl5OWGiqFOV7yEbLNPM5J61b9bIa69Zt+iNy6rfHy98zA0k5Jn9obXIg6N6LPF/nA5G24aeAHEaj9fTGvoERLG2mZCifs59/ZCqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tFaE+JAO; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so2430905a12.1
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721662776; x=1722267576; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9R1qE2tM8fwmnWyD6BchbvAYi/GTU3Fr9X7luY5GehU=;
        b=tFaE+JAOkfgvDYqFbi5mJBNUlreWmGUbPuBPaGcviIzvwUYzlQctR898V/U3oF8UcG
         WiSIGNSJc+oEqcsrnAGJAuBTsXRTEBpTg6khUUbjjptddxAJe+xyv55IbT/1OLl3CckV
         G5iKEoQ4h7Lwg99dIrIZDzlx6YFY8vI6Wq5fY36/1lydyFUPejS3u6CzYdV3yTmGNyyu
         PtN3HApWYh+Mp+yOsXqs6uF2R2tKZbF6qx6QH8q+u/84t58P9QhNzTTs8CsgTd+JpzGz
         N7xOnURlJXsFvWYSQkOkRMxSlx3NJCZvzxQh1tJvc/d3tR1u72ChVMKeqD3lxi1VDEYJ
         MdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721662776; x=1722267576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9R1qE2tM8fwmnWyD6BchbvAYi/GTU3Fr9X7luY5GehU=;
        b=gmq0dPw0iwo4miD9fJmNvWpR5QiOE7P2Zk1BY9DENcx0ftBtTuWcykhOxNfOboZdjL
         4d+0KYA7DYgZhWSU2zI6BKf4IubqLGUodDuFgQDTKnuB/wjhZQ4eeW2vLDEaO37vsVqD
         VrH1PEu60UK2dAu3vKPa07O5J8BbgtxZHBGMXpSdy6p4vdfdqXt0/gu5gCbTx9exNWbc
         pKbQLN5XJYOStl2vgVEuwLjs7vHbXbXuZ3oKRe0oVeTSu1Wm8TUxrXTaWzvJSudpL8IT
         MsrfoOoNjv2cCqe2l6d8sJHNbo7gXVBxEFs85G4mWtzegZE35QRNcpXuESWZIPuHwH7Y
         2ArA==
X-Forwarded-Encrypted: i=1; AJvYcCUdnOmK2g8+vwIN4eyXdBcr6bsbgZ+mrpCLAkdfglja/4mtzh3YvDHH+3TL99lenLM2ypI1E7dJt36J7jzNl+fw5LTuxfAW
X-Gm-Message-State: AOJu0YwKvfhv0HdhM+PRiYZkJZ8VXbEvG3eYe4ntgLkMXQidhWi7KPaz
	ScTvvPNVw+3fmdWbpK1Fxnf4p/QI4cgF51PnsodBSmT1tGvefPfpupR6DkdhQw==
X-Google-Smtp-Source: AGHT+IED4obCdFHeSA58xp77MyGtahX6dbeBPcDXk3YR6oCQtBWbIVPobSMxIjC4AH1psUO5TYtJkg==
X-Received: by 2002:a05:6a20:72aa:b0:1c0:f1cb:c4b1 with SMTP id adf61e73a8af0-1c44f84c1d0mr41341637.13.1721662775799;
        Mon, 22 Jul 2024 08:39:35 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0a3dee1csm4752900a12.14.2024.07.22.08.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 08:39:33 -0700 (PDT)
Date: Mon, 22 Jul 2024 15:39:30 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Todd Kjos <tkjos@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	syzkaller-bugs@googlegroups.com, stable@vger.kernel.org,
	syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com
Subject: Re: [PATCH] binder: fix descriptor lookup for context manager
Message-ID: <Zp59Mh6MGUtJOcIB@google.com>
References: <000000000000601513061d51ea72@google.com>
 <20240716042856.871184-1-cmllamas@google.com>
 <CAHRSSEwkXhuGj0PKXEG1AjKFcJRKeE=QFHWzDUFBBVaS92ApSA@mail.gmail.com>
 <CAH5fLgjP2uOJRKCpFrwGn7X3Gw=r=wCibejp59JhupDX+QA5fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjP2uOJRKCpFrwGn7X3Gw=r=wCibejp59JhupDX+QA5fg@mail.gmail.com>

On Mon, Jul 22, 2024 at 12:57:31PM +0200, Alice Ryhl wrote:
> On Tue, Jul 16, 2024 at 7:40 PM Todd Kjos <tkjos@google.com> wrote:
> >
> > On Mon, Jul 15, 2024 at 9:29 PM Carlos Llamas <cmllamas@google.com> wrote:
> > >         /* 0 is reserved for the context manager */
> > > -       if (node == proc->context->binder_context_mgr_node) {
> > > -               *desc = 0;
> > > -               return 0;
> > > -       }
> > > +       offset = (node == proc->context->binder_context_mgr_node) ? 0 : 1;
> >
> > If context manager doesn't need to be bit 0 anymore, then why do we
> > bother to prefer bit 0? Does it matter?
> >
> > It would simplify the code below if the offset is always 0 since you
> > wouldn't need an offset at all.
> 
> Userspace assumes that sending a message to handle 0 means that the
> current context manager receives it. If we assign anything that is not
> the context manager to bit 0, then libbinder will send ctxmgr messages
> to random other processes. I don't think libbinder handles the case
> where context manager is restarted well at all. Most likely, if we hit
> this condition in real life, processes that had a non-zero refcount to
> the context manager will lose the ability to interact with ctxmgr
> until they are restarted.

Using handle 0 for transaction will always reach the current context
manager. This is hardcoded so it works regardless of the descriptor
assigned to any references.

Things get complicated when doing refcount operations though. It seems
that some commands will reach the new context manager and others will
reach the old dead node. Odd.

This needs to the fixed. I'll look into it.

> 
> I think this patch just needs to make sure that this scenario doesn't
> lead to a UAF in the kernel. Ensuring that userspace handles it
> gracefully is another matter.
> 

Right, the main concern in this patch is handling the BUG() assert.

Thanks,
--
Carlos Llamas

