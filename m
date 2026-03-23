Return-Path: <stable+bounces-227943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EgLNaETwWnkQQQAu9opvQ
	(envelope-from <stable+bounces-227943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:19:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFC32EFE26
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23BFB3080C20
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19056386C31;
	Mon, 23 Mar 2026 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rb3qw89F"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BE938A718
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260673; cv=pass; b=sHl4CnzHG0+N3Bhns2xwOEGgQ5jXvpimpqxZq/ESSE6OeSrzmsieJWy607kwhtoyUP4z04lLxuP48BUHJgAAqtEK856JeOhTj83BSFkfMl3StfV25IhWvgrk6IUt8eEU5mW1G8MQqxgAHfbpIvpKuAktrTbgUC1BRNKLjNSaOgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260673; c=relaxed/simple;
	bh=T4ovom7jSXlpz8s3ZLmDI+QYF0JuPUHaLKfOFcLtVLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkApbmSFPm6wNFXukokKiqcC3O23qkMLDVdIZJlR5ccTsEpfgIyoTCbjmctDhheUk3oog0BMh5LutI7JTKFA+EQ/8jiNOgFeDN6u2bhaFdg/aY8jmcQ/F0EOuavyH61qiaEbkNaa83rYV/UYUMCYFSiUuOR7NdKg+zet00BsN20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rb3qw89F; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439fe4985efso2344544f8f.3
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 03:11:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774260670; cv=none;
        d=google.com; s=arc-20240605;
        b=AUV9gCZeu2Qq29jhGvq9fMzY+H39FUJ92sEYXNI33q743JVJ2ZWxsfQtC6KpkUaKtl
         35eHH+afHPnuREvDrbbsLCrRggfSQdOek5X/JuBdi47jTQckAZofzIfCqjxB+pi/nPJM
         C0VWew4RjEq9Yh8JLcqFL2GtZvMgrp8v8mIpZ6wOJOwQvUULp0/9GwClsX3blsWGDNzV
         uY09YJDcXxSEc557/qr7SNbK1hYROKC4c4/KpqV1tY0MtBpeu72Nfbr+xWdOZQC99zJF
         CUJt9Y/A4n7PfXAjOav+zNzYvrbpH9RQaXvnOPjgLyt7h4uTUnbold/5c2ccgN20eml6
         V4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lsOdqtNgvK2CpdK8NDRleo1xxdKWmtX3BWj/pX4beHc=;
        fh=deyrYBr4J2AneodfmY2e6zyEfBR5lu5u7URuq0/Ggz0=;
        b=YkUjx3YpDaRH3/Wn/N9eCI3HUhYHyq4ixuuxVS0e30Yq/bcsYKJPRnMPkUieCTvZA3
         cIKViAz/vmhsxSIDXMvtuFp8heZvSubm/u1nsPKV7kYb9c3DmlnuBPgsU+1WIFas4A89
         4Cr2pR6gtsG5R5oJPtq3+tGcT2fhBBqUdSlBo8C+KcmhNuOx9lWvuI8jaD2TYQkeeiwa
         syQ36rkw9ouyZMf4DQJ5mbmKfzM3BiRx1pg3SIur5Cm0p+RlUM/NMAR3mmgZ0LB+zx5D
         MtWwUK3GvWIbfcwjNUhOf6tfeve2+VrlLKlDOiT63kQuWpvC1UUj6MZT99Q5ZgXSeOd+
         2D6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774260670; x=1774865470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsOdqtNgvK2CpdK8NDRleo1xxdKWmtX3BWj/pX4beHc=;
        b=rb3qw89Fblnn1NQLixbiX1Jf/K23XuNvzzv4PyLXt0ypWwXVR7qd2d7OcR6OB7lEcf
         LEuHWP3/RxRUjp5eMdMA8uA4/Q1hh2aHlLSdXcAJR9TvS+7sgxDgTUsYx3lzqKByUIjD
         R9T3Pq3hpgJlIAlZrk+k+ABZgSqi2oMw4ZpLLX7SOkG/yrm6X9SYnYjgHaPHkWe4ohjQ
         ki4NCAsw4/kzSSTzWTkruEaxPyzWZ/iiddWHY8ze5yOYRCu7PbvM7nHaxSvzcpfgVjri
         1p5vath/j8ORPCW3FWd+l0rsVYDmD1gK2st0CVmwUvlAKDIZfKKLG9qZRlTGMT2+5XKA
         KBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774260670; x=1774865470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lsOdqtNgvK2CpdK8NDRleo1xxdKWmtX3BWj/pX4beHc=;
        b=okPjgcsyDZpVmidkDpK11ZJ+81ymQpyAOtF/o9dwK+Kfw2D63XVIiXFA8wxyZc5ycS
         cbquNItuOojOIUrRhwYOKaGtCJczq4jVqtrBIHQgL+zPoc1JTtzOPtK4KOtTCXMYCjPY
         BY76908x6dWzMQT0cJ1E2yuK6BvCZflrC8KSQIHbi4ZjcwgRIpThzCh/waiKgldDKa4o
         hfiG6W+A/MEy2KuZeR/gPwGV/01dPncMv1HnzDIyXDAKXXbIjaxg10C4xQOVmxZHdC6Q
         3cLRs0i1Req5h+wFEqsd6x3V6L32cNp1m3wfDfkNlQySP5FhIV2SQbP119OqlT6FNGaS
         GTtw==
X-Gm-Message-State: AOJu0Yxdd5gNR4qIBGWVUXySPEBQRsQbnenwZqTXGWUPV454R7UJlz8J
	oSMMjHUGBVNjv2R95XmArKEyLfg3s6SUhvhV7SrP39V2NWq2lOZw5hqrcMYouQXPRz3/NoNzqX7
	pWZpyjJW9+lAomzFrUwu7B213UvBczxikOdsXocvItzjfTKEtSdc6obyh
X-Gm-Gg: ATEYQzysehBAgdLgfsO1AyfaL28MjYVnpHEWvhSdvQosdy0Cod6w2jeCL6WoAydVjLu
	iDrfeCoPEf4hbv2YL1TyBzqP/oG4eJxglg/NohYciAqpCYKqHBGb5zTr3M6qMHZ7jwq3DDCxG02
	wpLw/n+B02M8Ydrm28hZXhr/jxHAOX/9onaaFrk9ytrIWE6QjTUYRQerG+FsIY37dgc0XvFAhZx
	AHrK19TIQHH5y9wdbpKZM9kVxsW396vt1d6QVq6d4RmN8LJQY0K5o/dkBt1v0CSWOMHNZxkeTN8
	fWWdKJRIB2QgQymktxnL5s+jJk39M5hqawSXlILP8D1nogdozG25cAv2KvrIqEjHdgkasQ==
X-Received: by 2002:a05:6000:2010:b0:43b:4ec7:f924 with SMTP id
 ffacd0b85a97d-43b64264073mr17694737f8f.34.1774260669168; Mon, 23 Mar 2026
 03:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221161726.4075998-1-sashal@kernel.org>
In-Reply-To: <20260221161726.4075998-1-sashal@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Mar 2026 11:10:57 +0100
X-Gm-Features: AQROBzCV8XoI5nCiZRSfn0XYqZW0Gv_6NGhUghECAmSG5grHh561t3dL231lE3A
Message-ID: <CAH5fLggmuHNXpfHo2mPS0TYu8mwr8G6EKH0YPuCLX77u_dxF5Q@mail.gmail.com>
Subject: Re: Patch "rust: task: restrict Task::group_leader() to current" has
 been added to the 6.18-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,garyguo.net,protonmail.com,umich.edu];
	TAGGED_FROM(0.00)[bounces-227943-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4EFC32EFE26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Feb 21, 2026 at 5:17=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     rust: task: restrict Task::group_leader() to current
>
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      rust-task-restrict-task-group_leader-to-current.patch
> and it can be found in the queue-6.18 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit afd4cb72fea7e256c378bc90efc19e140da35e00
> Author: Alice Ryhl <aliceryhl@google.com>
> Date:   Wed Jan 7 08:28:46 2026 +0000
>
>     rust: task: restrict Task::group_leader() to current
>
>     [ Upstream commit 105ddfb2d2b3acec7a7d9695463df48733d91e6c ]
>
>     The Task::group_leader() method currently allows you to access the
>     group_leader() of any task, for example one you hold a refcount to.  =
But
>     this is not safe in general since the group leader could change when =
a
>     task exits.  See for example commit a15f37a40145c ("kernel/sys.c: fix=
 the
>     racy usage of task_lock(tsk->group_leader) in sys_prlimit64() paths")=
.
>
>     All existing users of Task::group_leader() call this method on curren=
t,
>     which is guaranteed running, so there's not an actual issue in Rust c=
ode
>     today.  But to prevent code in the future from making this mistake,
>     restrict Task::group_leader() so that it can only be called on curren=
t.
>
>     There are some other cases where accessing task->group_leader is okay=
.
>     For example it can be safe if you hold tasklist_lock or rcu_read_lock=
().
>     However, only supporting current->group_leader is sufficient for all
>     in-tree Rust users of group_leader right now.  Safe Rust functionalit=
y for
>     accessing it under rcu or while holding tasklist_lock may be added in=
 the
>     future if required by any future Rust module.
>
>     This patch is a bugfix in that it prevents users of this API from wri=
ting
>     incorrect code.  It doesn't change behavior of correct code.
>
>     Link: https://lkml.kernel.org/r/20260107-task-group-leader-v2-1-8fbf8=
16f2a2f@google.com
>     Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>     Fixes: 313c4281bc9d ("rust: add basic `Task`")
>     Reported-by: Oleg Nesterov <oleg@redhat.com>
>     Closes: https://lore.kernel.org/all/aTLnV-5jlgfk1aRK@redhat.com/
>     Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>     Reviewed-by: Gary Guo <gary@garyguo.net>
>     Cc: Andreas Hindborg <a.hindborg@kernel.org>
>     Cc: Benno Lossin <lossin@kernel.org>
>     Cc: "Bj=C3=B6rn Roy Baron" <bjorn3_gh@protonmail.com>
>     Cc: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
>     Cc: Christian Brauner <brauner@kernel.org>
>     Cc: Danilo Krummrich <dakr@kernel.org>
>     Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
>     Cc: Miguel Ojeda <ojeda@kernel.org>
>     Cc: Panagiotis Foliadis <pfoliadis@posteo.net>
>     Cc: Shankari Anand <shankari.ak0208@gmail.com>
>     Cc: Trevor Gross <tmgross@umich.edu>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

I noticed that this was backported to 6.18, but not to 6.12. Is that
because the first user of this function was merged in 6.18, or is
there some other reason?

Alice

