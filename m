Return-Path: <stable+bounces-76728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 662A397C419
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 08:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93EC2B22042
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 06:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF7815382E;
	Thu, 19 Sep 2024 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nboSvK1Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BDB1514DA
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726725694; cv=none; b=DDf41nMSUeU5YqIvWHc82EpQAIHdKx3UC9gKtY9AxfDkYa95blBpJvdNVzCc7KhI0NaUMm8MZoNjimhJZ5Po0KeHLH7OqPkF/NJVYDAH5+hDe4WTsJLl73HFPcFBNkZKkaZxcO0bVvFMyeehCJVzfI9WmAbW2jpiU2iH8haBpUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726725694; c=relaxed/simple;
	bh=JJiPfyK4QHIwTIpjSJG6OvTKj5j/LKjnyl/O7PpiOi8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n1nSEEwgLHw9chp3HsfORDRzraZ/idu+XXdi2CM3H+xfFjzeG4MK6xlsx/JfBdkOXn3UhJ6aWlM2khzIICBVRh+ypi9ZybNPJ6FyBWQm+wWIgSc4fH1b/5+2E9HN3AlAyNMEWUCllq+nbeNJvfmuZV/DhwwgE1DkR18wsr6OAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nboSvK1Y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ddbcc96984so7945547b3.2
        for <stable@vger.kernel.org>; Wed, 18 Sep 2024 23:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726725692; x=1727330492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VPGDOQhQEg5s3NDFwuqJJNmJqpj9EuV1IZIqjE32Cw0=;
        b=nboSvK1Yon8yOOVtMxolDwN4CbXe+6fuWkwiuJquO1ijiROt+ECG2kUrxLn4Z6bgbs
         qBsaYnP50WVyiT5D8+x082cFmiNmFm8bLFMnGEao39fvAIFNUwbBn+ZcUBDn0Meu6ZXv
         ScZ7gVvRmeajNhy64UNkdUFiEjp/rU/kMqHQgiwQX276cuo3xCAxE+f5OnJnlV/oH8yL
         G8IdrGKGrLp+t3XXZh+GLuIihhSzWYb/dzLgaTLSzzfVfYwYpo+ps5oDRZZ2UCAzit8S
         ChSgrZ0L/6aNQWyKRZABvHxGOEKoyVBf17YwMAX3yf3LJccGr6ngXx6Twez8wWuNVz3n
         o5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726725692; x=1727330492;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPGDOQhQEg5s3NDFwuqJJNmJqpj9EuV1IZIqjE32Cw0=;
        b=mZNkzLYaCZtCyl9YMTh9JgmxqRK3UvxgZpzZ2VDtVgfxcplq5kwzbqRstXz4Y3TJ0f
         iD1vkM2aeXcvmFxPfw3XEdy11lnhsS14NYWIw90mnH2ThfWCx7dNdWuGI2ue8zHeAPZC
         LODGW8R5jnerA+ne+vTw8FL3plDMtNWwRopbfBovaCJ3MuYFbg6tmHQ48SIVwp6KRF5V
         swHIoZsHvB114lgruKNPBWko0ovMlnal/sToF4e/+y8rfvJsJiq1Gcihq4DiZ5JUiSlr
         bAYBVRb4Hyyl53iCyCdCYFb4sGcxkQAkJwcAwosvw/0WuZXpSOMRf/R1wiymMcC9IpOt
         oPwA==
X-Forwarded-Encrypted: i=1; AJvYcCWeQNMoklZ2OSR0N4j1d5IMLtyovxFNY7m/Gh572pEVam//eg8SDDwRSMJi4v1RoXLanejsxwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBOq4BoRaXyFHEl4Kg+IFjg5WFYAHJ8DgtGviX/MjWCrm0TOQT
	rBqBpCQ493ovG8QYeLtx/4CBVkiP0wkYbvX4nysxz3nwRrviyf4XO0zgp2rHC6vjijz5O5GNrTL
	YCA1uRA==
X-Google-Smtp-Source: AGHT+IGERMOPhhKvLpeKAJVYE/JExDbzWwuzzZ0vNx3KklSg136h/eX+oqopAqatX15tPJy7WvSAIRBqwNeF
X-Received: from gthelen-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:2c:2b44:ac13:f9ac])
 (user=gthelen job=sendgmr) by 2002:a25:d851:0:b0:e1c:ed3d:7bb7 with SMTP id
 3f1490d57ef6-e1daff59ccemr26808276.1.1726725692080; Wed, 18 Sep 2024 23:01:32
 -0700 (PDT)
Date: Wed, 18 Sep 2024 23:01:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <xr93ikus2nd1.fsf@gthelen-cloudtop.c.googlers.com>
Subject: 5.10.225 stable kernel cgroup_mutex not held assertion failure
From: Greg Thelen <gthelen@google.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: Tejun Heo <tj@kernel.org>, Shivani Agarwal <shivani.agarwal@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Linux stable v5.10.226 suffers a lockdep warning when accessing
/proc/PID/cpuset. cset_cgroup_from_root() is called without cgroup_mutex
is held, which causes assertion failure.

Bisect blames 5.10.225 commit 688325078a8b ("cgroup/cpuset: Prevent UAF
in proc_cpuset_show()"). I've have not easily reproduced the problem
that this change fixes, so I'm not sure if it's best to revert the fix
or adapt it to meet the 5.10 locking expectations.

The lockdep complaint:

$ cat /proc/1/cpuset
$ dmesg
[  198.744891] ------------[ cut here ]------------
[  198.744918] WARNING: CPU: 4 PID: 9301 at kernel/cgroup/cgroup.c:1395  
cset_cgroup_from_root+0xb2/0xd0
[  198.744957] RIP: 0010:cset_cgroup_from_root+0xb2/0xd0
[  198.744960] Code: 02 00 00 74 11 48 8b 09 48 39 cb 75 eb eb 19 49 83 c6  
10 4c 89 f0 48 85 c0 74 0d 5b 41 5e c3 48 8b 43 60 48 85 c0 75 f3 0f 0b  
<0f> 0b 83 3d 69 01 ee 01 00 0f 85 78 ff ff ff eb 8b 0f 0b eb 87 66
[  198.744962] RSP: 0018:ffffb492608a7ce8 EFLAGS: 00010046
[  198.744977] RAX: 0000000000000000 RBX: ffffffff8f4171b8 RCX:  
cc949de848c33e00
[  198.744979] RDX: 0000000000001000 RSI: ffffffff8f415450 RDI:  
ffff92e5417c4dc0
[  198.744981] RBP: ffff9303467e3f00 R08: 0000000000000008 R09:  
ffffffff9122d568
[  198.744983] R10: ffff92e5417c4380 R11: 0000000000000000 R12:  
ffff92e3d9506000
[  198.744984] R13: 0000000000000000 R14: ffff92e443a96000 R15:  
ffff92e3d9506000
[  198.744987] FS:  00007f15d94ed740(0000) GS:ffff9302bf500000(0000)  
knlGS:0000000000000000
[  198.744988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  198.744990] CR2: 00007f15d94ca000 CR3: 00000002816ca003 CR4:  
00000000001706e0
[  198.744992] Call Trace:
[  198.744996]  ? __warn+0xcd/0x1c0
[  198.745000]  ? cset_cgroup_from_root+0xb2/0xd0
[  198.745008]  ? report_bug+0x87/0xf0
[  198.745015]  ? handle_bug+0x42/0x80
[  198.745017]  ? exc_invalid_op+0x16/0x70
[  198.745021]  ? asm_exc_invalid_op+0x12/0x20
[  198.745030]  ? cset_cgroup_from_root+0xb2/0xd0
[  198.745034]  ? cset_cgroup_from_root+0x28/0xd0
[  198.745038]  cgroup_path_ns_locked+0x23/0x50
[  198.745044]  proc_cpuset_show+0x115/0x210
[  198.745049]  proc_single_show+0x4a/0xa0
[  198.745056]  seq_read_iter+0x14d/0x400
[  198.745063]  seq_read+0x103/0x130
[  198.745074]  vfs_read+0xea/0x320
[  198.745078]  ? do_user_addr_fault+0x25b/0x390
[  198.745085]  ? do_user_addr_fault+0x25b/0x390
[  198.745090]  ksys_read+0x70/0xe0
[  198.745096]  do_syscall_64+0x2d/0x40
[  198.745099]  entry_SYSCALL_64_after_hwframe+0x61/0xcb

