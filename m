Return-Path: <stable+bounces-226909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KfYNHvGuWmcNQIAu9opvQ
	(envelope-from <stable+bounces-226909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:24:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA1A2B2A00
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D61E3072656
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A667B390C92;
	Tue, 17 Mar 2026 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/H/oSp9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC53859D7
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782517; cv=pass; b=G0eWgjYGswkMobsQdxE6JTxxHvZXpJMyUhvaDYkQIHuAI1G//Dc2K68iAMBpCkOWF8rs9uys0ByFx2JVKFZOUj/9jXfznciNEUdWIRrCdcv5dZl7geMhnusXmk+61ulrXUCwhTNAtg4MewB92/g/zuKSNEm/dm+OwZytXe27/Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782517; c=relaxed/simple;
	bh=TlJCQUFeA7wXwWNxxCXKjq8200d9TSWk2kbn4D4a0F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRVKOD/1YctzTItXV+my4veHJU/xUfZpP3joi9iqMK8+8F+Z/x56/UcnhOr4QfAsBJNXkAE3M1Y9eQngeOfQaYyWO38fIXSD3p3G6oO4jK1osuVZKIc7V+BSgF9suH9A1VQKEXWYk1Q7ltsNyPv1cm6ZxyAtQgv0CsYT91x9ZKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/H/oSp9; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89c55a0a470so27717886d6.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773782514; cv=none;
        d=google.com; s=arc-20240605;
        b=P0eXsElvHXaUiJnTV8ILOPXmtUGb8l8doKkpk6izEG6BCDJpHy+1u34ZlE2RgSKVdV
         F9gQn/w9vKlnhDG1n0vcpYzcqPL2t8HQPJ/DGy8yNl2tH5kYfHOT+fHG0PAM4pIMbCsH
         sAHJKClhCQr7YIes/XHWt2xgXoCvyPK0edaPGgXTXsPuqxzlE0tEyZ8b1QsKcGeq6RTr
         SRZGBayd5Du0L3kJ9i8cwUGoX2QASBURxCPmSFmqNk1YlWqm4Ob9XSinhZ9AXfOwOdol
         pIdIDgsl1x94D96lGMM4Yj/4AlNizhUmfrk3ACgZbfRmE6xiAZ4JTI3QRLnZEO2Ysu/W
         RBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IW/QZFjwdstBVjqcVjvGz0a1qDUdxk2SOzhF/DKvYEk=;
        fh=EVftlAcxq16SY0QdqQbdxJuAF2HAKNNm0clqge/M1JY=;
        b=KQETFpDKMQc/7f4tS9YJNxcMrXMQbwqJH7Cgo9uLayMwUzGto5clBNkzer0mm86pbt
         R1ykPbbSKZbSu2q2tcG811l6WZ7+UNkXPwszPXJQOX1LPTBzjxGjK2Ag2BvCIr2XLxI6
         rE9NHavnYrAINoKrIkpYxcmoc3yhA6KEHOeap0K+F0tQl0g6ptfYvAnq5Z6ZnVqYyegS
         rIioVeZ3fO0heliBgs5mxyDV4Ja68rUMAUzXEEGTMR0oFBbqVHpOe9wIycvlu0PO1/U1
         QHt7ZQe0YHSLEnDNKhLTfPkXavpJrqSpezlIInDf7Ii83Gl3K3oJZ+jLcQyZgqbeVcHC
         HFhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773782514; x=1774387314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IW/QZFjwdstBVjqcVjvGz0a1qDUdxk2SOzhF/DKvYEk=;
        b=c/H/oSp91/Hvrma4o2VlwKyyV5Bkwm0b3e4fhaP3aSjHn5M2S9uYe/8JQZtKMbJHJh
         skRi85PPxleS4WIuW7D9z1E/CGCUy6fbZBHcYsC9BQ9DTwWB7yWVqYM5zLYuNvUpOE52
         wybdL7rSP72OreVTYDD5NDEGw8GuOoZpPc0icjtabGkPJYRN0Rxc/ZAJ7yHOwKx2GHz4
         Q7R/OxuoSaheotF1EL6AvzKeBOa2kmxZfDKqiPX3+RxEhqERFaC7b4vOvPNY4DTsRT2I
         bfZPSKennk/sK2AXwIfS+ngTP1KEdqdVNN5qhVNaXja0Ub91vrGtEo0hVebLtWubDfQP
         1dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773782514; x=1774387314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IW/QZFjwdstBVjqcVjvGz0a1qDUdxk2SOzhF/DKvYEk=;
        b=pfZ2ujDXpVDQAhwqW9yXWD6aMf1DFvqzjL9iLjK3pXf3AtaZB8FaJ1FVkQk4P/Qvmd
         UkA6xIGM1DoQl34C5g7RAzfDilXLernoir4IOZQB9m27uYJq/UGxuymPmEpsol3W0X92
         GY2yVyxF/qbn6Toi0CYFd2C9qRHw4dWbiwVCLRRL2ZUjCIxVq1tjNTLjOBpZ0nj1q3Gf
         6gfoiOcAbmwYHDdBZWrCjVaMeHRL3qcvMy+BuW7d7QO/4I/kS3RF2dv6JmIooxJ2G6xd
         cpKM38rGKA0zJpDI45ze9rD53DD3jQI8qTb7bOM6qftyzSh39AW8kDfWLr4CR2hkgmvo
         eYIA==
X-Forwarded-Encrypted: i=1; AJvYcCWiDPdMH8I9GRzF3ToKgAmhPsLD1EG8f1okWB2UkdK180rX1xF4zXtJ20RCBgtlhjgb3i1dHDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1KsvbbQLAnkPcrjwzXG8jfg2BcmD0Db0mki9DFX/op4JIsI1K
	DvbnJcGcLUQmNaW3lw4/r90TZFuBTEB0h3LGPeKBHZMYAoevlmaKjOTWfVzp3akYjC0+pY2xULM
	GfcmjYOPWUQyjmTOGaTtWmANz4VFr8fc=
X-Gm-Gg: ATEYQzwDggzlJvcf7L2deKh7Lry2z3GdCwSXSk1cNvcI/G9MyPwwgMZU+xzQnY48723
	L/TuW0wKEp+ZdWqBa/++9w77xOEWKlrKNedVBMhl4Dp5qz4XOssohNF8tXsW8mTBmLAae90SbCD
	PCfON7yq9RPZQxZUtN7esnUB7rH4lX88cTJVYdcFe3sny2a+U9ba6D2aSGXCLzdtnWuswDIXlmg
	edfHUK6G9UkdzmF5ToM/02d+0iLVVrqS3ncNrDFrnqTLv73aPOOAq0X8/0Y8LXulBblInnidU7y
	lX2hYpY9mLB/88Zf2A5RpgazhCkK5pTlb8B9IVWISPUSf1LfybiSk0usPPK8XtK2GwEE9iW9xoq
	aoqAbdVMyPwx8rD0b9L7MG+kepe9rGAtbRtyka5ixZCOzqZPovy4SjYsczGtQbg==
X-Received: by 2002:a05:6214:3d9c:b0:899:ea4f:12f6 with SMTP id
 6a1803df08f44-89c6b5596d6mr17924146d6.35.1773782514157; Tue, 17 Mar 2026
 14:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317094653.2236624-1-werner@verivus.com> <02e11b2c-a472-46ac-95a4-ffe7013c3133@chenxiaosong.com>
In-Reply-To: <02e11b2c-a472-46ac-95a4-ffe7013c3133@chenxiaosong.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 17 Mar 2026 16:21:42 -0500
X-Gm-Features: AaiRm51choAslW-OVKrp4xPS0WIxnqiM6ooeRdSaYZeh61kr9v7kXx6SFV22Wzw
Message-ID: <CAH2r5mvCJW4tNhbDRMCuAZOfzrS2FKusiRY3ym-0dF4PfT8c=Q@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: fix memory leaks and NULL deref in smb2_lock()
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: Werner Kasselman <werner@verivus.ai>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226909-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,verivus.com:email,sashiko.dev:url,chenxiaosong.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CA1A2B2A00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I see that Sashiko had AI review comments on the patch:

https://sashiko.dev/#/patchset/20260317094653.2236624-1-werner%40verivus.co=
m

On Tue, Mar 17, 2026 at 6:10=E2=80=AFAM ChenXiaoSong
<chenxiaosong@chenxiaosong.com> wrote:
>
> Looks good. Feel free to add:
> Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
>
> On 3/17/26 17:46, Werner Kasselman wrote:
> > smb2_lock() has three error handling issues after list_del() detaches
> > smb_lock from lock_list at no_check_cl:
> >
> > 1) If vfs_lock_file() returns an unexpected error in the non-UNLOCK
> >     path, goto out leaks smb_lock and its flock because the out:
> >     handler only iterates lock_list and rollback_list, neither of
> >     which contains the detached smb_lock.
> >
> > 2) If vfs_lock_file() returns -ENOENT in the UNLOCK path, goto out
> >     leaks smb_lock and flock for the same reason.  The error code
> >     returned to the dispatcher is also stale.
> >
> > 3) In the rollback path, smb_flock_init() can return NULL on
> >     allocation failure.  The result is dereferenced unconditionally,
> >     causing a kernel NULL pointer dereference.  Add a NULL check to
> >     prevent the crash and clean up the bookkeeping; the VFS lock
> >     itself cannot be rolled back without the allocation and will be
> >     released at file or connection teardown.
> >
> > Fix cases 1 and 2 by hoisting the locks_free_lock()/kfree() to before
> > the if(!rc) check in the UNLOCK branch so all exit paths share one
> > free site, and by freeing smb_lock and flock before goto out in the
> > non-UNLOCK branch.  Propagate the correct error code in both cases.
> > Fix case 3 by wrapping the VFS unlock in an if(rlock) guard and adding
> > a NULL check for locks_free_lock(rlock) in the shared cleanup.
> >
> > Found via call-graph analysis using sqry.
> >
> > Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> > Cc:stable@vger.kernel.org
> > Suggested-by: ChenXiaoSong<chenxiaosong@kylinos.cn>
> > Signed-off-by: Werner Kasselman<werner@verivus.com>
> > ---
> >   fs/smb/server/smb2pdu.c | 27 ++++++++++++++++++---------
> >   1 file changed, 18 insertions(+), 9 deletions(-)
>


--=20
Thanks,

Steve

