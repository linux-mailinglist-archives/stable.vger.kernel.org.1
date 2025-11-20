Return-Path: <stable+bounces-195424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5304C765FD
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 22:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A4C24E1A23
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 21:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6984F30AAB6;
	Thu, 20 Nov 2025 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+KYuYi+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D72EC55D
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674118; cv=none; b=Bxu4pSArwuoBb6bEnueNHR8FiHCVQnVr2XuqckmUCBddGVIzc+XQkZq63vmT2t9Nv+hY0obB/qSMwRo83z5xm1+rGKhxW84txLsIarBsqE5L4TDtSzEUdavxc0uI0jKjUboeWhoUBP3+Hl7KbIZQDNwHJOREUz6EJxy6nKVzcs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674118; c=relaxed/simple;
	bh=Q8U3O6jgZZEpClalOlIGtLCm09UlDJ0npUO0CA7BwqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAznA4m4Rz1gi8SmtSz2Ez1X4cnM3JyYV5FntF9C+yG8BQ6LHeVf4RFsQXE95xUV3siYvVbC/4RoX0NHGZvMY9MRoepCqo2z/31nuMZsaXti2Jb4ZU3aJW2DOnDYbULz0R8vAn8u13+JahpLxjYELU/Acvyrthq6i6GT3/A0brg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+KYuYi+; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eda77e2358so10796431cf.1
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 13:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763674115; x=1764278915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8U3O6jgZZEpClalOlIGtLCm09UlDJ0npUO0CA7BwqM=;
        b=B+KYuYi+UNxb0Vhe9OJRva7kpG52MmIlo1GdB6PwClyWeW4AVJ9yzTzJdDOorPgikT
         zyx3pUKYsyrc0KUqcUkkPTW8YUDQOBWqcPs7tx2MXzbrb1fkJklBe6Rwl364/sPegnK1
         go0c3mHzo0WojQDH27l8zkJNwqvDGBpug6jtifwcpygUfkvp0hgs1tl90hwBg9QvkGap
         v71QPEIfTbmiqbQPYVMOj9dJkf+gimkZlHHS4X2751BUM7woBQpdAXVgPqyeI+meVnMT
         Cn/xR4+lC7kFlmrFBqnMB8pHb8S8MxirYkJm5zYErgtQIDsEcaYMiEuSlY9wWcDMECEQ
         XeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763674115; x=1764278915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8U3O6jgZZEpClalOlIGtLCm09UlDJ0npUO0CA7BwqM=;
        b=AeLrGJBYNX6l2atuwIoLVdmr35YYmYqYsBsPAbfrvDZHJZOgPDs7sza8QCSJJ641lc
         nQFNeFfn0Ua4F5s7u7Z9HmmLYmg2YUUwJQjfuPJxrPwEEV1YNx9C7CUTodEteaBIQS/G
         5fEm95Sgn0R247QCPtx97hM9/27R8xyTNSSsxSnPx/8VYQ4Ey4gPbrBH/95A8ZpYbbyK
         gXh7Oaf3NO0Wbi9qyR/Iuu/mefes5Ujn9CzEqXlB8FD8Fh/3nSaq8wwcIR2xEiqtf+Ur
         Gblv5U4sSRLSm0r/e1COloNe3DUQxSn8hj72Rqin73NJ1Mo8gXYrzzskXOeCN2GP2v5i
         LNWA==
X-Forwarded-Encrypted: i=1; AJvYcCXbUyiKSKqIVaMWpZfUqy+LAGqwBjKlpPBSP4hxG77SMEcVpyrB/KklUBCU1HJmaEwV2Nwfq8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS0U21zcBq3KVwQ2LTIf4IjMjtCAydhznUdAusorLD/+I04DiZ
	3MUg65b4AlyvQaHyrunv3NjLRUgZ8jdwL3sfbaE8+f1pmQo+WdiahfhRsTztYAv3JjHUmm72hwA
	Zz55DPOiyOjATuT+/lTpsiTGAGGzUe3c=
X-Gm-Gg: ASbGncu8xeW9xinncYpWTAmEU1nXyE8+IuAD6ANz095Y3/1rV6Uz94TCH0Qw5OVMCEw
	vlyWN0kNCK0T2AwE/wRScBhWhib+28FKUedmjynAIfH4Eb0/WNRUlPshvk57Pqvxkewp4pWFu7T
	/aZyIJT2MF3ZQdZSAGJgdKTj/TCOIsGq30z+dJsjbARx0x62liXNFbu0Zg6GoXzLwEldixNfGNd
	XMgqq3B9UzEJaXQjP/s+FlH/8TysrFvUW/pbfO5JnOrwdNsC9F2wj001SihP2FasFgDpw==
X-Google-Smtp-Source: AGHT+IEa5T+vJspuWQ+toPhdixw0WwlXC4G0HJVZEYNsBGrI4UEp3MsHvbWsFOZ191NkPJIFH9UZtf+mHSYJj1eRNx0=
X-Received: by 2002:a05:622a:4ca:b0:4ee:15af:b938 with SMTP id
 d75a77b69052e-4ee5892e29dmr992241cf.70.1763674115151; Thu, 20 Nov 2025
 13:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120184211.2379439-1-joannelkoong@gmail.com>
 <20251120184211.2379439-2-joannelkoong@gmail.com> <7fae20ca-d7b0-4786-8c31-288648db8ad0@kernel.org>
In-Reply-To: <7fae20ca-d7b0-4786-8c31-288648db8ad0@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 20 Nov 2025 13:28:24 -0800
X-Gm-Features: AWmQ_bmnvTHHOQkyw-5ik9LsEU1gIAn8vSNbEvhvGRrj7a058LOg6piKf3ugJVk
Message-ID: <CAJnrk1ZpU3eqh7jN8r-ZPyFsuAjkKgwJ-_Sx0L=710hD0UYwUg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm: rename AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM to AS_WRITEBACK_MAY_HANG
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, shakeel.butt@linux.dev, 
	athul.krishna.kr@protonmail.com, miklos@szeredi.hu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 12:08=E2=80=AFPM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 11/20/25 19:42, Joanne Koong wrote:
> > AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM was added to avoid waiting on
> > writeback during reclaim for inodes belonging to filesystems where
> > a) waiting on writeback in reclaim may lead to a deadlock or
> > b) a writeback request may never complete due to the nature of the
> > filesystem (unrelated to reclaim)
> >
> > Rename AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM to the more generic
> > AS_WRITEBACK_MAY_HANG to reflect mappings where writeback may hang wher=
e
> > the cause could be unrelated to reclaim.
> >
> > This allows us to later use AS_WRITEBACK_MAY_HANG to mitigate other
> > scenarios such as possible hangs when sync waits on writeback.
>
> Hmm, there is a difference whether writeback may hang or whether
> writeback may deadlock.
>
> In particular, isn't it the case that writeback on any filesystem might
> effectively hang forever on I/O errors etc?
>
> Is this going back to the previous flag semantics before we decided on
> AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM? (I'd have to look at the previous
> discussions, but "writeback may take an indefinite amount" in patch #2
> pretty much looks like what I remember there)

Yes, I think if we keep AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, then we
would need another flag to denote the inode should be skipped in
wait_sb_inodes(), which seems unideal. I was considering renaming this
to AS_WRITEBACK_INDETERMINATE but I remember everyone hated that name.

Thanks,
Joanne

>
> --
> Cheers
>
> David

