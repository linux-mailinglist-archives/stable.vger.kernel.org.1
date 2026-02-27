Return-Path: <stable+bounces-220008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iExXJFcAoml4yAQAu9opvQ
	(envelope-from <stable+bounces-220008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 21:36:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B891BDB7D
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 21:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB587300F165
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D19477E2B;
	Fri, 27 Feb 2026 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFjCaMb8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C1449EA6
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224596; cv=pass; b=Bs+bm7jnFbHV8q4LQiqLEp6NzQMdn0fBXkrOPnR3HD8GjvSvfZenh4upK2NmvPbagBhsQhn0DU3kqrFJW881lid/M4f22Wwogb/2Mxy9fWfPesZHz7c2rhN0umj9m/X3IHEB1+8fOIdtvwxv4X8GxedC1xa3ashmtrOoroQ+kbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224596; c=relaxed/simple;
	bh=GXPvU3yHGoGQr/QUWqXmSjT1rRuT8EpCRKuAZQSJr4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5k+BEEWAj63ZjJp0ReFJq8Mu0FoiUIQVBYYGc5ti5ERclm+8EOSusXt+FXJ5TEHijVPegxAs4p6s7ch3f4G3gWpb0rGQbLZfn1sK+zw1Nm84WWD8tQGyzcs8r8k8Wv20X7PVW89YOAmHEDgngTPXfVyU6v3ymFMEUVdMY99qDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFjCaMb8; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483abed83b6so20184595e9.0
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 12:36:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772224594; cv=none;
        d=google.com; s=arc-20240605;
        b=eHV6CVpsQxBfohWSlFPlHTA/lpzS9xUjuJdAk/A/7lMq2eGnhMCOWMOezZ+Owy9vPo
         ECHAuPOcW/zqnUKLxWyznZ1cEcKWB8dvB8SYoXUtmt6zV8ozoHB+6MWBJ96pU5gTGehf
         7NHixInXKHZfuGVlUn9pmC45JZG6rybnpzkPXPV15moyMWaLWZOmt+36pWG6SOFhhDcI
         xaiMINDyXJDbGwlblDzywhVTzBZV+OHsbFA+VQe7olo7204OK7kpH13xusHNnPLQ407M
         F1vOLcIovzKx80r56aqhuRVPjsvMTmh4oKQWCnUwSRXeIw/wPa8siJM1DaX3Q0eGzNX4
         NHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GXPvU3yHGoGQr/QUWqXmSjT1rRuT8EpCRKuAZQSJr4w=;
        fh=DNsGArJjDlv76Za+WFjivH5d5qT0eTGwgIHoPS9bR6c=;
        b=c14enkcHM6PWFpXkjUBis8MC/GoRWyOQ+1cTxSg35WigdcnOJVeIYwT9gBxz4hXNd8
         G5MVBP2pZQjLenDQfdx5JdBZpi1P7jDHsvRWS8bHpbdwh1HDNeKKmqNKJYsZe1jvZEVk
         Ec8ueJ8YJrOlRUNeeiePdLmY6gqDq4lqOn59nPVjeDL2MJXukemkz9YjJkpho4PaqyC9
         JN9nsBJn3vUv6bMibw5tTNkd1x+sb1y1R5EgMsHxP5ol3xy6Iwf6LGNdKvdr4+HnRoq5
         KdDjFBSCHXlGqFbnoPTYa4X/Do97PAeMEOWiokzbqdPDMsmeveyagEXM28G92XwZPqw6
         FhUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772224594; x=1772829394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXPvU3yHGoGQr/QUWqXmSjT1rRuT8EpCRKuAZQSJr4w=;
        b=KFjCaMb8I5AAEGgeQMgsZLULxczkwMf9T4dRaiyG1b5XL5D3+MrvBSXoaJKwJlma5N
         GNN0U1vgWUesJG2FU+l2Sa2AEYGBB4Oi+tYtJsgkMOvzC958i6oT4kv1ajk38xP/8paU
         fjLaL7fSi4l1SbTIfVNgWKzqBD/Ws1Wxctwchxjq+uIuGGXz+lI0kb4QIZ+cgZWcLQQR
         8ZVxFEKpfMa3rhKpIbxd1WhCnMmJOreD01RyKzPlhN4W02d+7fMP+vSqdKdnsMhyYXdB
         XNO7sV1OhRzJyIEXPhXGz1Sd+DOxQVH2XK69uqskT2wvrfVlOiVIwMZWBmdoHNrA50ck
         cF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772224594; x=1772829394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GXPvU3yHGoGQr/QUWqXmSjT1rRuT8EpCRKuAZQSJr4w=;
        b=VUxyaFsQne5n9H0moapzd+cL9Y1ZFdJzhh7lP7Mr53N/f6W81tqVj1VyYKRpRy9T8r
         J5D9hSLPLJNuflLRLyALOmSL31ueHrGhY2P3IqEnvUJfkYkOyr58fDsfsVMCdfAOlcGk
         21g0dc4drUJbXcB/K6i0ddmFHpluvFmuKO9v6u+PGNQtWoD4y9qpD4YYmv8d+u33vXCn
         iKol8JMRyH6LQm9OMANHnay5hTes/8+aPhdSi7G0eTr1nfNXSRTyRkC7LS+V3s2Z9NoB
         1Kqg7j4YzThwcz85IokAFvUy46eTlk79mZBFQck/K0iRg2+KJSJ2K4oStJO3dh3ABcsN
         JyQA==
X-Forwarded-Encrypted: i=1; AJvYcCUyllatZjRbF+/gBok1QsVIircENw+SPKmSRKJL5X3OxiEZ+e/OgkqVIrVP4y/WAha1BnowY0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNk9YvQMEJUVL1RcwQyw2ovxsenROpG7AEy1Z+B54RxQKtitjA
	2sj/RSNUD5agQ1a7zIvWGgpfVk780H7s2/Fdlt6CHFWmNo3d/mGyifJ4Cbg7VGZxJsdbSHHaXQ+
	qKzcSe4RMoWaUb+Y0ANvp/ke/41HfpiraTbemg5HX
X-Gm-Gg: ATEYQzyrWq06dSg8MaeOO04b8dSJkE7mndtwsBiHTKIN2OImkSEabkLdLUm9GRy6EG3
	+5h33LODXYY1tuPQpNLRw0HGPhRrHdhM70JQGQvAeLoYsViIZ16j6luHm4Z/wdtjLb9naYzXQBX
	qcQ8gcbf9OX9YK2C1rBZ/N5kkTHSUSbM0cX4M9icO/mP96M+5/Kz2nIaBkEELoOhliApnaouioY
	nTd08VqzJW5rLYYQpNIprA5hpLvmit7o4ewLRtMz/g9OyER4ukWtdEv9UXClh7WfJymhm7lYtR5
	HEOlr30SON9AQSGKnt7d8u/WrEJ/f47RE5pLUhuKNF9F1J/5
X-Received: by 2002:a05:600c:4715:b0:47e:e7e5:ff32 with SMTP id
 5b1f17b1804b1-483c9bfaf59mr58287215e9.34.1772224593291; Fri, 27 Feb 2026
 12:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227-create-workqueue-v3-0-87de133f7849@google.com>
 <20260227-create-workqueue-v3-1-87de133f7849@google.com> <aaHPs-nULPEt_wJB@slm.duckdns.org>
 <aaHp_pGBxA4pNiXJ@google.com> <aaHrxzWIFFUjzWhu@slm.duckdns.org>
 <aaHuXEO64ONKMW4O@google.com> <aaHvcvbmkl7oSFOR@slm.duckdns.org>
 <aaHwSxIaTqLWndkw@google.com> <aaH0e5YKnH7x1gCB@slm.duckdns.org>
In-Reply-To: <aaH0e5YKnH7x1gCB@slm.duckdns.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Feb 2026 21:36:22 +0100
X-Gm-Features: AaiRm506Ib-Fl2WN6TaIOR3S0tdq8UlbZS-JTeVYbkG7Q8VPGCiBJPP-KBkw-q0
Message-ID: <CAH5fLgh5M=HQ8XRNnpqMxHU5q-T5OYVGCLq46aqOP5dxOYDMuw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rust: workqueue: restrict delayed work to global wqs
To: Tejun Heo <tj@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	John Hubbard <jhubbard@nvidia.com>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Tamir Duberstein <tamird@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220008-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 18B891BDB7D
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 8:46=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Feb 27, 2026 at 07:28:11PM +0000, Alice Ryhl wrote:
> > > delayed_work is just pointing to the wq pointer. On destroy_workqueue=
(), we
> > > can shut it down and free all the supporting stuff while leaving zomb=
ie wq
> > > struct which noops execution and let the whole thing go away when ref=
s reach
> > > zero?
> >
> > But isn't that a problem for e.g. self-freeing work? If we don't run th=
e
> > work, then its memory is just leaked.
>
> Yeah, good point. Maybe we should just keep the whole thing up while
> removing it from sysfs. Would that work?

We can but there are two variants of that:

If destroy_workqueue() waits for delayed work, then it may take a long time=
.

If destroy_workqueue() does not wait for delayed work, then I'm
worried about bugs resulting from module unload and similar.

Alice

