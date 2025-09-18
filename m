Return-Path: <stable+bounces-180478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 629CFB82E86
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 06:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B76417F840
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 04:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCCF258CDC;
	Thu, 18 Sep 2025 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="idI6twVp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B324676C
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171157; cv=none; b=c2If2qQBA7VL78VCiu4Ritz+57ovAM3GGb6yDYR2A6Mpi0qxXjt9g7AFOvR6HUY+uh+VLNd/e9kOfcoa32ZSCILrDaIHNte79iR14ZRRiXWDV0U4G9HG1MZ/ChYkXGnYiuy80fcoAjm/X7h/TArlh6tQv9VmblGz23nE+Si8Et0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171157; c=relaxed/simple;
	bh=roMRSfTHwvWbIYHIw5SlvXsbEkqQ/myQD+bxde55/zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNTswbvfDpCiCqj5JSre2imgm3vZLEyzvpqscfFkm3byt3Js7bw2bTG0AcrJb1RU2jJ6Vh+tTwt42pUjj/JkABiwazPlFG/8ifzsQx8CTMDSwFPRsQvs7/e3IsBvjxKIUFkY1n2IRzaLjZneFUqYPD717pdT363P+rh6ykHlJMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=idI6twVp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07e3a77b72so234735266b.0
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 21:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758171154; x=1758775954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9QRU1VKJtdE0ZocHMFrYMEWDnZZ/HDzFw4qL2PHiIk=;
        b=idI6twVp7T8x/SEXiTdGr76RIW/PQHsBT9ZgX7wHMdhcQriS/6tAHinzSMFwEXrkhJ
         zd6LHHTSr2P3h8YjXbj8yiCmrZzQycEN7zaIYG1sZP+SxkaG0rh0uSPavCn5678DDtvP
         qbKmMP4yZ/JgKinx0SWgpQi+ysvzHZyfp7ClW3vZNGn4QXs15wwcrM3dMLfsQcOz+aie
         10fc0LE2geYsqA0D9afY7OwhLlJ6olB/AWxap93eyCKwT18WhN0XP1H0a2M/aAwbdTFE
         9Sq56lwclcSKDvksOkFNl6XRO4MF098SdY8gN49GKESi09nKIBwodaWppKrEM815B4gz
         q9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758171154; x=1758775954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9QRU1VKJtdE0ZocHMFrYMEWDnZZ/HDzFw4qL2PHiIk=;
        b=s0ep8W6J40TbUeCmzjKpUUFMNsTWivtJY/gufLbq/mv35cqz1gIhrZO9857MWN5uIW
         mprwHnNWZy3hK5MzWgTdEUDtbKXg1hTcOWs2KR6262B6zZ1KEAhVU5+o2EoTciThHKyW
         aTKYSqnltP/7xsTGU0jP8mXgz07oHVl5xHFZaEvF/g4chtQIMnZ1GR1GzI0rUAm5hiDg
         TZTG8yDLvUG3zgyjVJgLZwlCazS0Sse8QbOEoPMxsQEOyxmyLk1dgaZGhzHy86T+suS0
         n5DROpLMVL2l0uK3TkQ4p5kBRiWpPSp/wqsAUT6NbKQUzTgZPEIeQfScCaZ3+Vc+felH
         1O6w==
X-Forwarded-Encrypted: i=1; AJvYcCU27El+19Bg7MVOdT3K9kCtFNKbIqm/2lMd5C2oaiuZcrNrLfBlBsl6wRxJOtRK7oieJvWWWao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3btPUEVKDr0aANjP8lK+UzeD1jDWjlQlS92IUUPTJLlDBm7bL
	GOaJrKIlHHdUaaIPCCrRxMzYz7kb8+h5ZwyRnWqj3tmAEzY4AT01pUTTx1BkxWBisZ9Udnrc2gj
	eCZLeXUH1JkoH5rTQ8qz9m3U189BkdCdebQMKRRWe2Q==
X-Gm-Gg: ASbGncuQuQNqMk9fG0nXchAHL9Q2w7mpZbDXYkwWQ2MWS6FvrlEO3wAesyhsRy3/2ah
	/njWkCVLvfl39xi1UzkmsNlmJXzRIiFkOaiB6mgp64Iju5kW5HEvVDqkBvnPCdKxPiAhgSMnkQ7
	kLhI13thNwBxxMMaa7f2XCd4mRMNzbPEAZOzpvH3KVP2ULr0tS0iQFTEkLgSesta+HL02CwnwXa
	/sx0mYsbzAQrKjtcfQnMAs3p83PL3xMUZh/zKVp6mNKEkEGJITDPlE=
X-Google-Smtp-Source: AGHT+IH78/YwtfdEEvgvHSMTlAUPH/eYqgNUZ9char1Npv5jG23ahXW8pg2svda031uaJNRKWZjE53pxWARfwi2BnY0=
X-Received: by 2002:a17:906:9fc5:b0:b19:f444:5bc8 with SMTP id
 a640c23a62f3a-b1faef71aa1mr223957466b.31.1758171154075; Wed, 17 Sep 2025
 21:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
In-Reply-To: <20250917135907.2218073-1-max.kellermann@ionos.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 18 Sep 2025 06:52:23 +0200
X-Gm-Features: AS18NWAZzXNs77ONQtxSPqI0-tNgs2QxD25qWiDPS307ZO8zwzS3_Wc3r2CSBy0
Message-ID: <CAKPOu+9o4FfXQU5O=iEhi=aFWfTUZ-mJVD6qqVi3UTSsy44agA@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: xiubli@redhat.com, idryomov@gmail.com, amarkuze@redhat.com, 
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:59=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> +void ceph_iput_async(struct inode *inode)
> +{
> +       if (unlikely(!inode))
> +               return;
> +
> +       if (likely(atomic_add_unless(&inode->i_count, -1, 1)))
> +               /* somebody else is holding another reference -
> +                * nothing left to do for us
> +                */
> +               return;
> +
> +       doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n", i=
node, ceph_vinop(inode));
> +
> +       /* simply queue a ceph_inode_work() (donating the remaining
> +        * reference) without setting i_work_mask bit; other than
> +        * putting the reference, there is nothing to do
> +        */
> +       WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_wq=
,
> +                                &ceph_inode(inode)->i_work));
> +
> +       /* note: queue_work() cannot fail; it i_work were already
> +        * queued, then it would be holding another reference, but no
> +        * such reference exists
> +        */
> +}

Folks! Guess what I just found in Linux 5.13: commit 23c2c76ead54
("ceph: eliminate ceph_async_iput()")

-/*
- * Put reference to inode, but avoid calling iput_final() in current threa=
d.
- * iput_final() may wait for reahahead pages. The wait can cause deadlock =
in
- * some contexts.
- */
-void ceph_async_iput(struct inode *inode)
-{
-       if (!inode)
-               return;
-       for (;;) {
-               if (atomic_add_unless(&inode->i_count, -1, 1))
-                       break;
-               if (queue_work(ceph_inode_to_client(inode)->inode_wq,
-                              &ceph_inode(inode)->i_work))
-                       break;
-               /* queue work failed, i_count must be at least 2 */
-       }
-}

This looks very much like the code I wrote - only with a loop for
queue_work() failures that cannot happen here.

Jeff Layton removed this because "Now that we don't need to hold
session->s_mutex or the snap_rwsem when calling ceph_check_caps, we
can eliminate ceph_async_iput and just use normal iput calls."
Our servers proved this assessment wrong. Calling iput() while holding
a lock is obviously bad, but there are more reasons why iput() calls
can be dangerous and inappropriate.
I guess I can add a "Fixes" tag, after all.

