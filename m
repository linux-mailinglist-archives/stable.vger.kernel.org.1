Return-Path: <stable+bounces-233256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGJvD3Z30Gnf7wYAu9opvQ
	(envelope-from <stable+bounces-233256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 04:29:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99410399A5F
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 04:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 423413020A7A
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 02:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8218929DB6C;
	Sat,  4 Apr 2026 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDQVb9eX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43307296BBC
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775269715; cv=none; b=R2qL3bcGhESePS0IYp0i2I6KNbglT8IUf1mg8vJDuz2mpi3CsWzuKkXvq88OHHrWJEqAvS8vWj9ZrbIW/m+wXJ4z6vcS67GVFF7etxzjuyItebqtWstu/EEjnKV8K4lDJ/BJ+zd/uTly1dh0EG+f6/PXhbX2lTRWbqvEHdtKVgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775269715; c=relaxed/simple;
	bh=u4CUB0iQJSw1BJ7hyMEtZYGmMQ3t+SQ2foySZre2HZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljSWjd/y51+rfjIOKktBlvX0T0U5KV3prPY5ci+btYM5IUHEKgvmSAb8bx/fbYgZFIo+CNkiUPIyZFG5zBas+/y1CyVLjRIXz7iE4ryF/uSwyKx7VZbL+yE80zdbxdA6vdfBUnA/BGKmxhq0ju3UGt5corXrRfuJJ9e7x/mAOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDQVb9eX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5EEC19421
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 02:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775269714;
	bh=u4CUB0iQJSw1BJ7hyMEtZYGmMQ3t+SQ2foySZre2HZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gDQVb9eX6Bwhl5GDqaCu6tSisRgJ+8IQGCOzkui+hdgmKld077AJSh48IGztuc46D
	 VE+icQo736qDPHVxLA84GxkHRu2x13y1EGBdY39DP1UOwr0De07Br6KkvR0AbRjFSp
	 TFI8sqX7/ZLy9yJocYQGXOilYi5qe5Yw6tgqEv28QZT/k1QnVWkqq7rQRYUOMnhdHS
	 GtdjtMk9IY0EVTNp6FSxLu+6sy1FZOTNnypV1N8bz+S++gzk4AFeJGlGDf2dnhnrY5
	 UbcyFrDJxHSdEuYMcD7qjs7tG/lxriUtadgEsJTXawCBVRFLLYdjzbqdlZNlXvH/O+
	 BxABeuFLdyGBA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66a33f61d80so4222043a12.0
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 19:28:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvEK7/m4vdhtOEj2gazKDxaQV32n9pnWk3ShlZ5myJmUf1SyzvKlf7S/Q6GtDLn3VjEk7uCpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykU8qz2dRlWj9k57/vaBnDE9uyD7LzhstbRsjPU+g24qH1iYEn
	y+H8OUl6zRVqJmT+Z9j3022e39QbmlQ5jVOyB3OIpUrfciickOiTmuOXWouxuICSIWFoW6Yb3aa
	K9P3g8yTHh8Pu2k3Ru+glnYspYC53Uig=
X-Received: by 2002:a05:6402:26d3:b0:66e:8ce7:5461 with SMTP id
 4fb4d7f45d1cf-66e8ce7565fmr201222a12.16.1775269713325; Fri, 03 Apr 2026
 19:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402083912.457676-1-munanevil@gmail.com>
In-Reply-To: <20260402083912.457676-1-munanevil@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 4 Apr 2026 11:28:21 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9Qnq6YgTfbS-59YATBvnbtKrX3w+D+WNk=izZVvQOoVQ@mail.gmail.com>
X-Gm-Features: AQROBzCSnlJK3jQXwHW0ZwawgQUy3hrfgEGqFuO6mYbofu7ZSWzZ9MVCsRM4g4g
Message-ID: <CAKYAXd9Qnq6YgTfbS-59YATBvnbtKrX3w+D+WNk=izZVvQOoVQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix use-after-free in __ksmbd_close_fd() lock cleanup
To: munan Huang <munanevil@gmail.com>
Cc: smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,talpey.com,vger.kernel.org];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,mail.gmail.com:server fail];
	TAGGED_FROM(0.00)[bounces-233256-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99410399A5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 5:39=E2=80=AFPM munan Huang <munanevil@gmail.com> wr=
ote:
>
> In __ksmbd_close_fd(), when cleaning up byte-range locks on a durable
> file handle closed by the scavenger, the lock cleanup loop
> unconditionally dereferences fp->conn->llist_lock to remove each lock
> from the connection's list:
>
>   list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
>       spin_lock(&fp->conn->llist_lock);
>       list_del(&smb_lock->clist);
>       spin_unlock(&fp->conn->llist_lock);
>   }
>
> However, when a client disconnects without SMB2 LOGOFF, ksmbd preserves
> durable file handles via session_fd_check(), which sets fp->conn to
> NULL and arms the durable scavenger timeout, but does not detach the
> byte-range locks from the dying connection's lock list.
>
> When the scavenger timeout expires, ksmbd_durable_scavenger() calls
> __ksmbd_close_fd(NULL, fp). At this point fp->conn is NULL and the
> original connection object has already been freed by ksmbd_conn_free(),
> so it would cause a use-after-free or NULL pointer dereference.
>
> Fix by checking fp->conn for NULL before accessing fp->conn->llist_lock
> in the lock cleanup loop.
>
> Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
> Cc: stable@vger.kernel.org
> Signed-off-by: munan Huang <munanevil@gmail.com>
I will apply the following patch instead of your patch. Let me know if
I am missing something.
https://github.com/smfrench/smb3-kernel/commit/319ca5432460b0749e420f7cff63=
7dfbc7e16be3
Thanks.

