Return-Path: <stable+bounces-78194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178E5989228
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 02:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E5F285199
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 00:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7499B469D;
	Sun, 29 Sep 2024 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y63F4iNr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5474C69
	for <stable@vger.kernel.org>; Sun, 29 Sep 2024 00:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727570548; cv=none; b=jZzVhDlAagUJnF0E9545II4IH8BsDsrYsZ+dEEczYrayyOXDA+YRqLEpyGfNdxApOTRFfSr3yTnipEzDJt8t6zaIH9N8C3+VuVooz65HuBTy3fWkPriYthFOw0i3SV4ICMyXhRg2hFxV7zP09SRpk4y/gl9MGm0ZkKpit9tXITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727570548; c=relaxed/simple;
	bh=fX/TKBgxmqq/Cm7k4gGbFxIXoSee8Pzh7b5XuizU8eY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kbBoPyQjhwMkJmD5/k9RjcAGWSpxBbv7WeKWxYx9G+nnEUyOzk9I+LAsYGa8ljAmS0cJ+69xbG3U3oZn6YaLhV5lani5qZ3gZL13lsxEsVH6/+OYGHWVk/ZkuN4ELefi69X/PmkmJ5b0P7Ya1SEAyIPShOG9UoqZoQeZLUXU9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y63F4iNr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e20e22243dso52470887b3.1
        for <stable@vger.kernel.org>; Sat, 28 Sep 2024 17:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727570546; x=1728175346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddcXYyq+SAcglICoDgYIAF7f5EJU3kjiPi667D1u/0U=;
        b=y63F4iNrK8g4M9naIXgLOIt9D9HTHw7bq4cn3ZEsgaVX+fgS9pOuBpVQ1BK0/h2o6K
         ZxE7UyjMI6LnDo3imSVapzyA6HPSudIcNgLXLj0EnvXuUhbP9iRsZlZ1boaYhSTG88Zw
         QYj6aCbvwee4j2+jkbY7C88RKoIf2RFirz5KYDBAIOMkzC5/v7JKST2++QpYnaqtCYCm
         pbSw+jkb5WM/GAeJYdymXwtH+49c+gK0iF+AKBgSAL4qTCjBIZLkTupsO5GoGzVLJ20J
         dhPLg0IL8XSF2SNWpRxEU2wxWDGxLttPKqNu8nL3R+pn+Sz7AQfFYfhrLyqcEzJwEUTE
         8I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727570546; x=1728175346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddcXYyq+SAcglICoDgYIAF7f5EJU3kjiPi667D1u/0U=;
        b=JZ1wONBaS+GdNpJWLpMUC1ykwQtRLTNeWfewV0FyNezVLbE1uLyBcXcJYqDAT8XgFz
         9vDZRZ3ZxN3eoPTV1zUr5Lx+yDJyB30+V5EKjr31hVsyh3ER2CY6ZXnl8QKUEWM8vZeA
         meMcEALmJseRDX/1bKl4E74nkiEdcyDIfaBhxjAZxMUa4PtjnKtCpPRteawF3uXFp+2s
         ZmThjOkjmbn5Em97I+pLpNTM44jKltkH9P6TRACoiANFfSW0uQ5asaEOoct5Y4mrwtU3
         Y1ShSJoH58HzVjYgt06g7bvxwVpcY8RL+iKN8ltfvW0XySvTGCxMYDkTBiVa2qYg3Jgy
         TRKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0lEsoOAi8pxC4qNWifVkfpmKoPP/e5jQBOA8fO9yY8eUEv75NaFbzSwoUVsWslmpgH4iYb4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj2yf7ZhkwMKgT+idv3gT8OMrEC1P1KHSv7YWMgJACrGrjb3bh
	BdQo3ianl0cdmBSRQQADecd6fCSFwI7ulCM4KoHLKTgEeqQbOQfz6E9kIWVzEoiGrzNRndNH0Z1
	hESBfMA==
X-Google-Smtp-Source: AGHT+IFqd5xuS/qL0EMIJC99TUR38fovCFRZ5eUYjAj0cNnKnTuNwT/JX33WcIFK2vjtJILXt7NjEAnkDXoj
X-Received: from gthelen-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:2c:2b44:ac13:f9ac])
 (user=gthelen job=sendgmr) by 2002:a05:690c:6211:b0:6db:da20:fa12 with SMTP
 id 00721157ae682-6e2473ab396mr683527b3.0.1727570545521; Sat, 28 Sep 2024
 17:42:25 -0700 (PDT)
Date: Sat, 28 Sep 2024 17:42:23 -0700
In-Reply-To: <ZvEr4IGyZ2x9FRU1@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xr93ikus2nd1.fsf@gthelen-cloudtop.c.googlers.com> <ZvEr4IGyZ2x9FRU1@sashalap>
Message-ID: <xr93cykn2suo.fsf@gthelen-cloudtop.c.googlers.com>
Subject: Re: 5.10.225 stable kernel cgroup_mutex not held assertion failure
From: Greg Thelen <gthelen@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>, 
	Shivani Agarwal <shivani.agarwal@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Sasha Levin <sashal@kernel.org> wrote:

> On Wed, Sep 18, 2024 at 11:01:30PM -0700, Greg Thelen wrote:
>> Linux stable v5.10.226 suffers a lockdep warning when accessing
>> /proc/PID/cpuset. cset_cgroup_from_root() is called without cgroup_mutex
>> is held, which causes assertion failure.

>> Bisect blames 5.10.225 commit 688325078a8b ("cgroup/cpuset: Prevent UAF
>> in proc_cpuset_show()"). I've have not easily reproduced the problem
>> that this change fixes, so I'm not sure if it's best to revert the fix
>> or adapt it to meet the 5.10 locking expectations.

>> The lockdep complaint:

>> $ cat /proc/1/cpuset
>> $ dmesg
>> [  198.744891] ------------[ cut here ]------------
>> [  198.744918] WARNING: CPU: 4 PID: 9301 at
>> kernel/cgroup/cgroup.c:1395 cset_cgroup_from_root+0xb2/0xd0
>> [  198.744957] RIP: 0010:cset_cgroup_from_root+0xb2/0xd0
>> [  198.744960] Code: 02 00 00 74 11 48 8b 09 48 39 cb 75 eb eb 19 49
>> 83 c6 10 4c 89 f0 48 85 c0 74 0d 5b 41 5e c3 48 8b 43 60 48 85 c0 75
>> f3 0f 0b <0f> 0b 83 3d 69 01 ee 01 00 0f 85 78 ff ff ff eb 8b 0f 0b eb
>> 87 66
>> [  198.744962] RSP: 0018:ffffb492608a7ce8 EFLAGS: 00010046
>> [  198.744977] RAX: 0000000000000000 RBX: ffffffff8f4171b8 RCX:
>> cc949de848c33e00
>> [  198.744979] RDX: 0000000000001000 RSI: ffffffff8f415450 RDI:
>> ffff92e5417c4dc0
>> [  198.744981] RBP: ffff9303467e3f00 R08: 0000000000000008 R09:
>> ffffffff9122d568
>> [  198.744983] R10: ffff92e5417c4380 R11: 0000000000000000 R12:
>> ffff92e3d9506000
>> [  198.744984] R13: 0000000000000000 R14: ffff92e443a96000 R15:
>> ffff92e3d9506000
>> [  198.744987] FS:  00007f15d94ed740(0000) GS:ffff9302bf500000(0000)
>> knlGS:0000000000000000
>> [  198.744988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  198.744990] CR2: 00007f15d94ca000 CR3: 00000002816ca003 CR4:
>> 00000000001706e0
>> [  198.744992] Call Trace:
>> [  198.744996]  ? __warn+0xcd/0x1c0
>> [  198.745000]  ? cset_cgroup_from_root+0xb2/0xd0
>> [  198.745008]  ? report_bug+0x87/0xf0
>> [  198.745015]  ? handle_bug+0x42/0x80
>> [  198.745017]  ? exc_invalid_op+0x16/0x70
>> [  198.745021]  ? asm_exc_invalid_op+0x12/0x20
>> [  198.745030]  ? cset_cgroup_from_root+0xb2/0xd0
>> [  198.745034]  ? cset_cgroup_from_root+0x28/0xd0
>> [  198.745038]  cgroup_path_ns_locked+0x23/0x50
>> [  198.745044]  proc_cpuset_show+0x115/0x210
>> [  198.745049]  proc_single_show+0x4a/0xa0
>> [  198.745056]  seq_read_iter+0x14d/0x400
>> [  198.745063]  seq_read+0x103/0x130
>> [  198.745074]  vfs_read+0xea/0x320
>> [  198.745078]  ? do_user_addr_fault+0x25b/0x390
>> [  198.745085]  ? do_user_addr_fault+0x25b/0x390
>> [  198.745090]  ksys_read+0x70/0xe0
>> [  198.745096]  do_syscall_64+0x2d/0x40
>> [  198.745099]  entry_SYSCALL_64_after_hwframe+0x61/0xcb

> I'll queue up d23b5c577715 ("cgroup: Make operations on the cgroup
> root_list RCU safe") onto 5.15/5.10. Thanks for reporting!

I verified that linux-stable-rc/linux-5.10.y commit 6e182a04f405
("cgroup: Make operations on the cgroup root_list RCU safe") fixes the
reported issue. Thanks.

Tested-by: Greg Thelen <gthelen@google.com>

