Return-Path: <stable+bounces-135295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937BAA98D5A
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BAD16AD2F
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B307227FD7A;
	Wed, 23 Apr 2025 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BscpPDtB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEC527F4F4
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419221; cv=none; b=nBIviFK04EDilgPYt7d/A84Pqv6KJ1hINKHrEhBTR4JPAJ6pVZelyULhhg+AQIabtlMkWbLOgdG5vCqIVYhAFAPOOjpbIEbbeqcw8A0L0ypOwBpWLJ4MS6GI+GJ1MyTi+S8ZF2IDgXs4Sr/Gw1Vr8j5jzAASRkcXL2qJQ40soAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419221; c=relaxed/simple;
	bh=Rmlfd/rSuvwlCl5x6LrGt0gYUPlUJFi8+DdXTz476Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lo30WD9DjtdXJm+wMRmzE6ubEDmr/x8k+Lhe0jj8zOH8hMvc/PCuOIh/pN7A90Sj5tfl4Ul6/XsIxdgrB3ydelhI1Yz0Lr/zIWSgu+0viEyEU42nZVIOWLvv2+mPRMDv2RrpjXgw7tLjnESxA+X//71oQp9514N34p813xipyA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BscpPDtB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745419217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkJug5w1edMe5yo1kpcyV9QLxwL/8dhEAUtpaAiUDeE=;
	b=BscpPDtBsuzpMhq/v9r0r74WsLHliWf038UeTHOg6asfU4ej2ESpikQVMQPsamRpiD1rpg
	rTs2Tj1pyczVlX0EU2Om8DA60miRpZbtn8MAnDh0DAegQJaAYCYUCL66T7NGAnZ9JzwkrH
	ZkyfKmA/AfIvt+bPDHPkb7p8ewT4rMc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-2URkWcanPWas7XrR3Ai0fA-1; Wed, 23 Apr 2025 10:40:15 -0400
X-MC-Unique: 2URkWcanPWas7XrR3Ai0fA-1
X-Mimecast-MFC-AGG-ID: 2URkWcanPWas7XrR3Ai0fA_1745419214
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac2db121f95so481269766b.1
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 07:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419213; x=1746024013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkJug5w1edMe5yo1kpcyV9QLxwL/8dhEAUtpaAiUDeE=;
        b=kWrsNjxxhkyGpmSOMEGmVOKb17opH8LiAjGZwZe6CJuis4mG6VqJLDI1Mn0ivt2IxN
         yZ7a7iqw1q3Nkd8KP7DkNKIeMaCRoDzyUgnCqFIJ6kPa2ebip4eUyrb1Oa+DRMTTkHUq
         yx+sSsCF49usVND8G2uWOKzxx0DEjGhX3MLH8/Ha2oj/Id23h2YAz5x61leVdS96AXpp
         XzRl+adamlzYCqVsksHi+C83Iwqyiz1NhNN/DhDr7R4zPLCSK4gLn7AmnVPeqUnLsm51
         bp7ALwLz1UmEhvqTa0GNec9KlobNMof6o7oHmsGEEjmujyFzMLU0SplzibN5FghjQPJ1
         X36g==
X-Forwarded-Encrypted: i=1; AJvYcCW6ho3wJjj986+IfD8qZRGQ4QesXvENGQHNeC0bSQn2Ufx6EajRdObLzz2obBWF63e8afuYNKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDy8uukiJMI2O6I9u5Ni/OHnT4lejLG/FobvJuqZ4oPOG+0S7A
	LtLa06UJMrWJw68aENejdt+n4q5MFVAaKvyy6jHbI0fB77/gQbdP/Tobi9LgK93BTQSD3uqo3F3
	JlQ3jEpvFAj6J7nbh0amNH4J1GgBf8W2XXztp2LJGZvb7cYzXGwu6D/FPzeCGAV1cSxDo1s/9+4
	Fio/cOVKKg4s7D46aXIywsu9Q1jfno1L9QiDL7
X-Gm-Gg: ASbGncvzwiornDCGeJ4Odpb+cSmMjMJMq+JuCNTKpYIh4o3YL0ruWLyt2QDr7NfQeEV
	QRg0ezRbakYVwar7A2GkeqPkHK68VN8VQ99Xy4tKik06f4vwVahIM7+iQYaqy4M+eb7Qhxw==
X-Received: by 2002:a17:907:c16:b0:ac2:9683:ad25 with SMTP id a640c23a62f3a-acb74b8ceb3mr1581377966b.34.1745419213226;
        Wed, 23 Apr 2025 07:40:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOejD5veWR6WGbbaeBjKvwZuxwQAGUxN7gY9/CIk2gXG+SuUIdiohcgVWDUliNqfKREDs/epDddZaSp+5t7Ew=
X-Received: by 2002:a17:907:c16:b0:ac2:9683:ad25 with SMTP id
 a640c23a62f3a-acb74b8ceb3mr1581374866b.34.1745419212746; Wed, 23 Apr 2025
 07:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423132250.1821518-1-max.kellermann@ionos.com>
In-Reply-To: <20250423132250.1821518-1-max.kellermann@ionos.com>
From: David Wysochanski <dwysocha@redhat.com>
Date: Wed, 23 Apr 2025 10:39:36 -0400
X-Gm-Features: ATxdqUFpiVavU7EZ3mWDQwA1ebMhcqjNgaQjiGo8g9QsoQ9FqiRsLXlzm93jeW0
Message-ID: <CALF+zOmH0fCwsLgWxOLh+Zpak9dZO5Z0D1WozTWjMMOjsyhbBQ@mail.gmail.com>
Subject: Re: [PATCH] fs/nfs/read: fix double-unlock bug in nfs_return_empty_folio()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-nfs@vger.kernel.org, trondmy@kernel.org, anna@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 9:23=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> Sometimes, when a file was read while it was being truncated by
> another NFS client, the kernel could deadlock because folio_unlock()
> was called twice, and the second call would XOR back the `PG_locked`
> flag.
>
> Most of the time (depending on the timing of the truncation), nobody
> notices the problem because folio_unlock() gets called three times,
> which flips `PG_locked` back off:
>
>  1. vfs_read, nfs_read_folio, ... nfs_read_add_folio,
>     nfs_return_empty_folio
>  2. vfs_read, nfs_read_folio, ... netfs_read_collection,
>     netfs_unlock_abandoned_read_pages
>  3. vfs_read, ... nfs_do_read_folio, nfs_read_add_folio,
>     nfs_return_empty_folio
>
> The problem is that nfs_read_add_folio() is not supposed to unlock the
> folio if fscache is enabled, and a nfs_netfs_folio_unlock() check is
> missing in nfs_return_empty_folio().
>
> Rarely this leads to a warning in netfs_read_collection():
>
>  ------------[ cut here ]------------
>  R=3D0000031c: folio 10 is not locked
>  WARNING: CPU: 0 PID: 29 at fs/netfs/read_collect.c:133 netfs_read_collec=
tion+0x7c0/0xf00
>  [...]
>  Workqueue: events_unbound netfs_read_collection_worker
>  RIP: 0010:netfs_read_collection+0x7c0/0xf00
>  [...]
>  Call Trace:
>   <TASK>
>   netfs_read_collection_worker+0x67/0x80
>   process_one_work+0x12e/0x2c0
>   worker_thread+0x295/0x3a0
>
> Most of the time, however, processes just get stuck forever in
> folio_wait_bit_common(), waiting for `PG_locked` to disappear, which
> never happens because nobody is really holding the folio lock.
>
> Fixes: 000dbe0bec05 ("NFS: Convert buffered read paths to use netfs when =
fscache is enabled")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/nfs/read.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> index 81bd1b9aba17..3c1fa320b3f1 100644
> --- a/fs/nfs/read.c
> +++ b/fs/nfs/read.c
> @@ -56,7 +56,8 @@ static int nfs_return_empty_folio(struct folio *folio)
>  {
>         folio_zero_segment(folio, 0, folio_size(folio));
>         folio_mark_uptodate(folio);
> -       folio_unlock(folio);
> +       if (nfs_netfs_folio_unlock(folio))
> +               folio_unlock(folio);
>         return 0;
>  }
>
> --
> 2.47.2
>

LGTM
Thanks for tracking this down, Max.

Reviewed-by: Dave Wysochanski <dwysocha@redhat.com>


