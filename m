Return-Path: <stable+bounces-136468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CFEA997BD
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 20:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4788E5A009E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2D228CF7F;
	Wed, 23 Apr 2025 18:21:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152428EA70
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432464; cv=none; b=C5/1S+lDK7hg+caYBtXDAfi6QjRLyBqq2rsjdSy3OePSp3UbBKYGgb1qCVlHUBO1RtzZYRkq57bSiSfn0TW3plr0moCpIHyHxZfGWgPJVUcGVl8biP2BSgIytJaF5IcNetyK+1G8ZAUHGZaMj8Zzt3K5LkHMGBBizcQ8F+Zdti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432464; c=relaxed/simple;
	bh=nlObL/M0UKId+3FGKCIAHseXw48SZkt4goXdtRoEqE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seXgLzG80T0ruq8p7ft3FuAKkvsC0NcIM4Rvxu3Y1RodS3UUX3C/rCrir++kLdHElrhQPd/5vS0tzCvJVr8edoJQrYYyoZAaM6FgecmVh3mMFqMNiVJbAD2VIK0IpJARw2Pn3J8fYonxaqenDed7b9bZwZA0Ma4QuoNGu7Fpbs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-148.bstnma.fios.verizon.net [173.48.82.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53NIKd7i005125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 14:20:40 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 4E9A82E00E9; Wed, 23 Apr 2025 14:20:39 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Artem Sadovnikov <a.sadovnikov@ispras.ru>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Eric Sandeen <sandeen@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ext4: fix off-by-one error in do_split
Date: Wed, 23 Apr 2025 14:20:31 -0400
Message-ID: <174543076507.1215499.15040549215780274810.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250404082804.2567-3-a.sadovnikov@ispras.ru>
References: <20250404082804.2567-3-a.sadovnikov@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 04 Apr 2025 08:28:05 +0000, Artem Sadovnikov wrote:
> Syzkaller detected a use-after-free issue in ext4_insert_dentry that was
> caused by out-of-bounds access due to incorrect splitting in do_split.
> 
> BUG: KASAN: use-after-free in ext4_insert_dentry+0x36a/0x6d0 fs/ext4/namei.c:2109
> Write of size 251 at addr ffff888074572f14 by task syz-executor335/5847
> 
> CPU: 0 UID: 0 PID: 5847 Comm: syz-executor335 Not tainted 6.12.0-rc6-syzkaller-00318-ga9cda7c0ffed #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
>  ext4_insert_dentry+0x36a/0x6d0 fs/ext4/namei.c:2109
>  add_dirent_to_buf+0x3d9/0x750 fs/ext4/namei.c:2154
>  make_indexed_dir+0xf98/0x1600 fs/ext4/namei.c:2351
>  ext4_add_entry+0x222a/0x25d0 fs/ext4/namei.c:2455
>  ext4_add_nondir+0x8d/0x290 fs/ext4/namei.c:2796
>  ext4_symlink+0x920/0xb50 fs/ext4/namei.c:3431
>  vfs_symlink+0x137/0x2e0 fs/namei.c:4615
>  do_symlinkat+0x222/0x3a0 fs/namei.c:4641
>  __do_sys_symlink fs/namei.c:4662 [inline]
>  __se_sys_symlink fs/namei.c:4660 [inline]
>  __x64_sys_symlink+0x7a/0x90 fs/namei.c:4660
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  </TASK>
> 
> [...]

Applied, thanks!

[1/1] ext4: fix off-by-one error in do_split
      commit: 7e50bbb134aba1df0854f171b596b3a42d35605a

(Apologies for sending this late; I've been dealing with a family
medical emergency.  In any case, the patch landed in v6.16-rc2.)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

