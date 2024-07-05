Return-Path: <stable+bounces-58151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EFC928D5C
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 20:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD1D1F238B5
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DE114A622;
	Fri,  5 Jul 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="e9e+VsjG"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4461B963
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203287; cv=none; b=bLN1TnvgYjC80s/49QyXy+ugQvYQqC0Rp48U+pfcC2FrBhNAC8MAai5pQB/MIE+ZERJGpqW41CBvnPhys9HTe86nNP1+IyQhVl3yTKF2p2xCVxE/5RM7DBWb/l0rfvzSlpeIP3/WpZymvgvsKyNQdOtRBMUUFzyr7BIVwq9Ba9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203287; c=relaxed/simple;
	bh=jW8tpnAZmR7dedCYf59asBfq7pmHle9blkR3dUV0u9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tA58cijNtNOqdB3cszeXqTHjU61p0/4KdVr6aTJy6duiMkNV5WmZWSBE5y4iAUbh98EKMufeRdDfqDbaDvg7M4ClUENnWUK31/E9YCCI+JSjSv9RgD3x0ecFKoWhb3Dka7jhqAbVR6lRg3/ecdinFcWlTe9i0a5Qnlbu031195k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=e9e+VsjG; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-64b05fab14eso20023907b3.2
        for <stable@vger.kernel.org>; Fri, 05 Jul 2024 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720203284; x=1720808084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7w5i+uUzm/MdJWSBPCuC3y6bS1vwI8TpdM6Bxh8Bw4=;
        b=e9e+VsjGnsPNA4SLP0pv7TNhdkH9GTwQM3OdK2qJ/XOTxeFrW23gWJ4Atql30N603k
         3aAkilrWpa3loZwWvuoR9Ws+rEzYaTkAPAkY7GXkFL4lOTXyESyvqxzVA+A7a1DECIak
         ba3C+gX/0InxdE8HGye42eAcKBFcrhlRIoDj+w+yVPTlXYHgiwjMUoB3r9E0tywdbjFO
         pe9/rt095mmnrZAjWkW1WYaie0mNP0BL5cbHgmFIHjGpaL6Tjn6me/M+kOFdVfn4kKDK
         4H6wqqDa5SxzE6gnw78KI+G3D9dyp1bn3SsPK8f+gIVtrXjoBq52z3RNZ6O5eBrkIzyI
         MMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720203284; x=1720808084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7w5i+uUzm/MdJWSBPCuC3y6bS1vwI8TpdM6Bxh8Bw4=;
        b=Uv21f8iayEG9jLH2jDTNKQIJZ7Y+3olVdNRGi6gKUNi+a7zGbM3GsYlIQJ3dlqlvpU
         PLkmZJEv7kHu5wlLfnZHJNEWI6t6LsnMTcH7KC+kMeQIBw27Br9N2zj/FVG2SWgVcfT4
         gTYMpyKHAyqf6EuqzJyBaWxViwTmxZK2CN9+gSqBs7tFplaInAz7gNz8W+WBHWa28YJ8
         JQL6mni368Gv3/792h16g+LJhElqSh80K00rBsV/Em+ciAZHAMvXISG5j8xaoaYoaQM0
         FEVlxP3qir/NlR+q6HXXc4aP7RvneYcWQ0V19T7IM66TLBthnG4cHNwwJX9RtY/7FQpy
         D76g==
X-Forwarded-Encrypted: i=1; AJvYcCW1odLCLL+5bNSU9byjTCQHRV6bu1o6p48AfHCkMx/hdELO8RdC6lPe5CwrVDM7OE58E55TCgPEMBCDXp2KONglIw3wq7m0
X-Gm-Message-State: AOJu0YyiQ/2PUEYENdjpG1qhJDyCYvLeaMO3sh49hT71Q4HLZzjyh4n+
	qF8pzWwRqMHDPvIAUshJfu7ZnnFsviFhElWMGdpmfBsCOqlIHdZe/X08SqFUEEYZWAXTv4xsKQg
	U1wFz1Fl7NWC+4OWwwT+HiG3OF8CMzAi0Earf
X-Google-Smtp-Source: AGHT+IEmUkdPVW13jOml7KPZliQsvO4Hhjtjk4H1Q9/dsoSUBJbxmDM1h4Vu0rMH1Su/jN79iBECdRYnC4GqhHD0V6U=
X-Received: by 2002:a05:690c:670b:b0:64b:2017:b74c with SMTP id
 00721157ae682-652d823f524mr64971717b3.49.1720203283992; Fri, 05 Jul 2024
 11:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704104303.3330331-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240704104303.3330331-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 5 Jul 2024 14:14:33 -0400
Message-ID: <CAHC9VhSQFZnjvhLA8OvgXy0uhrWAXQzhGU3KnV19+G4FWuwVQA@mail.gmail.com>
Subject: Re: [PATCH] ima: Avoid blocking in RCU read-side critical section
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, stable@vger.kernel.org
Cc: zohar@linux.ibm.com, GUO Zihua <guozihua@huawei.com>, 
	John Johansen <john.johansen@canonical.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 6:43=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: GUO Zihua <guozihua@huawei.com>
>
> A panic happens in ima_match_policy:
>
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
> PGD 42f873067 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 5 PID: 1286325 Comm: kubeletmonit.sh
> Kdump: loaded Tainted: P
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>                BIOS 0.0.0 02/06/2015
> RIP: 0010:ima_match_policy+0x84/0x450
> Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39
>       7b 18 74 26 41 83 ff 05 74 20 48 8b 1b 48 3b 1d
>       f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73 10 74 ea
>       44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
> RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
> RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
> R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
> R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
> FS:  00007f5195b51740(0000)
> GS:ff3e278b12d40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ima_get_action+0x22/0x30
>  process_measurement+0xb0/0x830
>  ? page_add_file_rmap+0x15/0x170
>  ? alloc_set_pte+0x269/0x4c0
>  ? prep_new_page+0x81/0x140
>  ? simple_xattr_get+0x75/0xa0
>  ? selinux_file_open+0x9d/0xf0
>  ima_file_check+0x64/0x90
>  path_openat+0x571/0x1720
>  do_filp_open+0x9b/0x110
>  ? page_counter_try_charge+0x57/0xc0
>  ? files_cgroup_alloc_fd+0x38/0x60
>  ? __alloc_fd+0xd4/0x250
>  ? do_sys_open+0x1bd/0x250
>  do_sys_open+0x1bd/0x250
>  do_syscall_64+0x5d/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
>
> Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within a
> RCU read-side critical section which contains kmalloc with GFP_KERNEL.
> This implies a possible sleep and violates limitations of RCU read-side
> critical sections on non-PREEMPT systems.
>
> Sleeping within RCU read-side critical section might cause
> synchronize_rcu() returning early and break RCU protection, allowing a
> UAF to happen.
>
> The root cause of this issue could be described as follows:
> |       Thread A        |       Thread B        |
> |                       |ima_match_policy       |
> |                       |  rcu_read_lock        |
> |ima_lsm_update_rule    |                       |
> |  synchronize_rcu      |                       |
> |                       |    kmalloc(GFP_KERNEL)|
> |                       |      sleep            |
> =3D=3D> synchronize_rcu returns early
> |  kfree(entry)         |                       |
> |                       |    entry =3D entry->next|
> =3D=3D> UAF happens and entry now becomes NULL (or could be anything).
> |                       |    entry->action      |
> =3D=3D> Accessing entry might cause panic.
>
> To fix this issue, we are converting all kmalloc that is called within
> RCU read-side critical section to use GFP_ATOMIC.
>
> Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_mat=
ch()")
> Cc: stable@vger.kernel.org
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> Acked-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> [PM: fixed missing comment, long lines, !CONFIG_IMA_LSM_RULES case]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> (cherry picked from commit 9a95c5bfbf02a0a7f5983280fe284a0ff0836c34)
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
> Backporting notes:
> - Remove security_audit_rule_init() documentation changes
> - Add default return value parameter to call_int_hook()
>   in security_audit_rule_init()
> - Can be backported to 6.1.x, 5.15.x, 5.10.x
>
>  include/linux/lsm_hook_defs.h       |  2 +-
>  include/linux/security.h            |  5 +++--
>  kernel/auditfilter.c                |  5 +++--
>  security/apparmor/audit.c           |  6 +++---
>  security/apparmor/include/audit.h   |  2 +-
>  security/integrity/ima/ima.h        |  2 +-
>  security/integrity/ima/ima_policy.c | 15 +++++++++------
>  security/security.c                 |  6 ++++--
>  security/selinux/include/audit.h    |  4 +++-
>  security/selinux/ss/services.c      |  5 +++--
>  security/smack/smack_lsm.c          |  4 +++-
>  11 files changed, 34 insertions(+), 22 deletions(-)

This looks like a reasonable backport to me, thanks Roberto.

Reviewed-by: Paul Moore <paul@paul-moore.com>

Stable folks, the original commit ID is somewhat hidden in the
metadata above, but the original patch is 9a95c5bfbf02 ("ima: Avoid
blocking in RCU read-side critical section")
and it is present in Linus' tree starting with v6.10-rc5.

--=20
paul-moore.com

