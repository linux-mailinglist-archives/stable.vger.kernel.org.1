Return-Path: <stable+bounces-93783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72D49D0E5E
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 11:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C76C28272F
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D830B193060;
	Mon, 18 Nov 2024 10:21:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165D198831
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925261; cv=none; b=rKJGkMS5PQZaGlnHX86JpFC1oV63Kl909BebjnDMuKwDuFGxDpjfF3AMAhqQJgtU698oeW/EannRCe5ONy7MehRmIczgRuGbRFqBQgPui/HHlx77MmoQuzFpyzaAK4HBVdhFp+Xsh/Mu76oqJbQqXhUN2P6jTM0/ioQRT9DE65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925261; c=relaxed/simple;
	bh=OfnCczRsx/w7ezphhoclkYC30W61fOe2O9q7FAcnxZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J35kp8usqAP0pD+sHJqX8FkI56Uzqj1GgyalwIHHYQ9u2hKCazLTr5eiS48xEkzh5eLCeUbQPBmHjf8HpZagVLzmrteW+T9gV9KHhffI0SpJrdtynCBL/Yi9xCYyl7K/s2LdezI8cEMNG+M3lPpn9TCFys/jcrRjTSij2xsm5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id ED14A2337F;
	Mon, 18 Nov 2024 13:20:57 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	gerben@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 0/3] ext4: Fix warning related to siphash and ext4 filesystem mounting
Date: Mon, 18 Nov 2024 13:20:47 +0300
Message-Id: <20241118102050.16077-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by syzbot (https://syzkaller.appspot.com/bug?extid=9177d065333561cd6fd0):

EXT4-fs (loop0): encrypted files will use data=ordered instead of data journaling mode
EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem without journal. Quota mode: none.
fscrypt: AES-256-CTS-CBC using implementation "cts-cbc-aes-aesni"
------------[ cut here ]------------
WARNING: CPU: 1 PID: 4245 at fs/crypto/fname.c:567 fscrypt_fname_siphash+0xb9/0xf0
Modules linked in:
CPU: 1 PID: 4245 Comm: syz-executor375 Not tainted 6.1.116-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:fscrypt_fname_siphash+0xb9/0xf0 fs/crypto/fname.c:567
Call Trace:
 <TASK>
 __ext4fs_dirhash+0xdd2/0x14c0 fs/ext4/hash.c:268
 ext4fs_dirhash+0x1b8/0x320 fs/ext4/hash.c:322
 htree_dirblock_to_tree+0x723/0x10d0 fs/ext4/namei.c:1125
 ext4_htree_fill_tree+0x73d/0x13f0 fs/ext4/namei.c:1220
 ext4_dx_readdir fs/ext4/dir.c:605 [inline]
 ext4_readdir+0x2e87/0x3880 fs/ext4/dir.c:142
 iterate_dir+0x224/0x560
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64+0x209/0x4f0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3b/0xb0 arch/x86/entry/common.c:81
 </TASK>

These patches address a warning encountered when mounting ext4 filesystems
with the default hash version set to SIPHASH while the casefold feature is not
enabled. The warning occurs due to incorrect error handling and setup of the
default hash version.

[PATCH 1/3 ] ext4: factor out ext4_hash_info_init()
Simplifies the ext4 filesystem setup by factoring out the ext4_hash_info_init
function, with no functional change.

[PATCH 2/3] ext4: filesystems without casefold feature cannot be mounted with siphash
Ensures that ext4 filesystems with the default hash set to SIPHASH cannot be
mounted if the casefold feature is not enabled.

[PATCH 3/3] ext4: fix error message when rejecting the default hash
Corrects the error message logic for rejecting filesystems with the default
SIPHASH hash version, ensuring the error message doesn't incorrectly
reference the casefold setup. Also moves the check to ext4_hash_info_init
to ensure consistency.


