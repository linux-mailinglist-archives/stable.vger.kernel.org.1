Return-Path: <stable+bounces-211208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBAPG2HhcWk+MgAAu9opvQ
	(envelope-from <stable+bounces-211208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 09:35:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C863293
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 09:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9635D5C045A
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 08:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D81936D50E;
	Thu, 22 Jan 2026 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zj17kUSo"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC129B8EF
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070438; cv=none; b=AGJ4txtvmjom3WpZE9Qqz9TprQIZ6etxrddbqhch9lkctsJcw30YOH2SvF+A8QUtk4EY5C+oQGEBM4xFI4EtlNSqYhOHahq/tSU4hGv3S4N0+nMTqUTE0LSxV1jJ8IerAOg8WGZkn7+TxkSdn7FHLaG+NH0Pbx/wsA3qu0E8Unk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070438; c=relaxed/simple;
	bh=zLhPrj/S3Lp1YrH7R76kkkL4Hx2aqqVlWoq/PKx9VfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rO0C93DHrD9fGq85PN0PN6aQ2uCHm44FWO3SrHqQZOrI3xVNpwIO2VtHJBqHqBh3Fz9hg1tgt3qqiNSRFDhUOyPHdqFw86ISLgzpyZQe+rb8dnvAqjBEFq3s3GO6u3xcHN0dpXlovz/BTcZootIRdGDtX3N12DvdV2WPp/y0wfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zj17kUSo; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-431026b6252so531653f8f.1
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 00:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769070435; x=1769675235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/Ugv7hVdM3oQW5SxzPuVxLvg8zpM2o/7djZvyT/c+Q=;
        b=zj17kUSoAAPpAH5HItMxb1opLyraVI1gx9GUNtCLOHpGh7vUpf7di4Dne7j9cZHQfO
         A/6Ga9mZfXW/KUpP3YhBL+9tV53O0ed5C1G14c+VJ0fe6xJ4P+d++mRNhIlU929UJrBx
         volxW4QxwbVt6zMa7eJh6Ryr3rRTzWhYlLZv+MxQxPlWk4PVIAtf54u22f1xxluWXk5O
         kM9N2xEsbZO/mZStCV8F0eH+5G98EGt/GrDGdncfHiAKPlKNCZp7NhnbNb9ifKVfW6zS
         4EVQ42lGTaeZXiKnPfzVITppKPs8B7JgGDo9Ebz9FFxBaZAsim4iNMFNnhLjqiJVOECW
         j8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769070435; x=1769675235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/Ugv7hVdM3oQW5SxzPuVxLvg8zpM2o/7djZvyT/c+Q=;
        b=ptMjeJWVk9/ILt46f1Un2r3qR574D//HDUAiab37puw0dTJSCU2P1OKw5UN5419iEF
         MhxAGGVuRoZMu1L3cJ2VGTh0Gg8vDrYUzy8liwZ/tI5ip+HL64Wh7dgcgEL0l/wXHPUG
         uAnyiujZb6Oz9NuoFpZpX0ZvPZlgq0eqMQ+qOixIvIkRfxb+3q9DZN88B8NyQHb5nMRk
         zBzxSr4bzoarir1jtT+R0NekHxdziHAhHssmDbpoqgTAusZEgOg125G1d5FCUoQmNyHU
         QzMvmy3l5UPmZC4OBplhcLUCb2fyN/5ywziYFG7PioHGstvi5khy/t5BO2kXhpS/sx20
         ucvg==
X-Forwarded-Encrypted: i=1; AJvYcCVRCi0Ax+bRKKQSulxSuYjz/NTO86k/wXn/FlyJBqYJnDUkz/hdqxKBhbzrVFa1nI3S9jy9RXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdLda2hcHCEztFNgqdA8oMHBpSyjALs9l2SHi19D0uYMBLe31g
	4zi6P2R8d54OWyp5pLPQGT+oNhYMVQWPCS7WaN+1ITW+6KECwPwbBo0CMoTCdjt+cB5Re8wyhIT
	xtx3TUae0nox3VAebyA==
X-Received: from wrxm12.prod.google.com ([2002:a05:6000:8c:b0:435:9228:8a8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40ce:b0:435:96ec:679e with SMTP id ffacd0b85a97d-43596ec685dmr10833855f8f.23.1769070434846;
 Thu, 22 Jan 2026 00:27:14 -0800 (PST)
Date: Thu, 22 Jan 2026 08:27:13 +0000
In-Reply-To: <aXEFObeAwlzXprDC@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121145005.120507-1-cmllamas@google.com> <aXDvlhDvCpzf62KH@google.com>
 <aXEFObeAwlzXprDC@google.com>
Message-ID: <aXHfYfNZ20-3J8qR@google.com>
Subject: Re: [PATCH] binder: fix UAF in binder_netlink_report()
From: Alice Ryhl <aliceryhl@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Li Li <dualli@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	TAGGED_FROM(0.00)[bounces-211208-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 537C863293
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 04:56:25PM +0000, Carlos Llamas wrote:
> On Wed, Jan 21, 2026 at 03:24:06PM +0000, Alice Ryhl wrote:
> > 
> > Erm, this solution seems dangerous to me. You access t->to_proc and
> > t->to_thread inside binder_netlink_report(), and if t has been freed,
> > could the same apply to t->to_proc or t->to_thread?
> > 
> > After looking a bit more: I can see now that you do call
> > 
> > 	if (target_thread)
> > 		binder_thread_dec_tmpref(target_thread);
> > 	binder_proc_dec_tmpref(target_proc);
> > 	if (target_node)
> > 		binder_dec_node_tmpref(target_node);
> > 
> > after this ... so I guess it can't go wrong in this particular way.
> 
> Right, the access to the target is safe because of the tmprefs just like
> the rest of the transaction().
> 
> > But I'm concerned that we will add fields in the future where this is
> > not the case. For example, let's say that tomorrow I want to include
> > t->buffer->clear_on_free in the printed data. If the transaction is
> > freed, then t->buffer might also be freed.
> 
> You actually can't access t->buffer already, there are scenarios where
> the t->buffer is released before calling binder_netlink_report().

Hmm, I suppose you are right. It may be worth mentioning that you can't
access t->buffer in a comment inside netlink_report?

Alice


