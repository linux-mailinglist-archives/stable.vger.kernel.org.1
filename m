Return-Path: <stable+bounces-93780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C269D0ED6
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 11:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C77B2CB5D
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 10:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3C1194A5A;
	Mon, 18 Nov 2024 10:18:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903DA25760
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925114; cv=none; b=upPHVsoroZH//DNUPMW2WQfekuLB0FEAaWhMsOmG8Mgbs4Iqh+fnnDWxQQ3nN6yO1kD2IfTEFDQhi9J4RohwY0TOsYgynfutU2gsKJigvgb9N0iL785BnWyLdTOltbF8ZksBCIkXasrVZamxoXqx3N3908b6bLit7wPWdTIdVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925114; c=relaxed/simple;
	bh=Wv1797IJSAgCC7GxD5Esae+WJaTsqEoerXMj5gRaEr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TxES/29YIYEdsizvafdJJbqmft5kHUXt/o194A/2BS4y+w2EQ+tANeawFhMmpticlpldVK8+HfwB0DiMJSFS6+zmIdYOPHF2sjciJ//bA4+3O763RpXsW9O8Wd5WsF5B41XP1Wp+iUouGhkvffjVlWvjCoJPawe9FeiIG+F0nS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 19AF82337F;
	Mon, 18 Nov 2024 13:18:24 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: kovalev@altlinux.org
Subject: [PATCH 6.6.y 0/2] ext4: Fix warning related to siphash and ext4 filesystem mounting
Date: Mon, 18 Nov 2024 13:18:09 +0300
Message-Id: <20241118101811.15896-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by syzbot (https://syzkaller.appspot.com/bug?extid=340581ba9dceb7e06fb3)

log (6.6.61):

EXT4-fs (loop0): encrypted files will use data=ordered instead of data journaling mode
EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
fscrypt: AES-256-CTS-CBC using implementation "cts-cbc-aes-aesni"
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3775 at fs/crypto/fname.c:567 fscrypt_fname_siphash (fs/crypto/fname.c:567) 
CPU: 0 PID: 3775 Comm: fscrypt_fname_s Not tainted 6.6.61-un-def-alt1.kasan #1
RIP: 0010:fscrypt_fname_siphash (fs/crypto/fname.c:567 (discriminator 1)) 
Call Trace:
<TASK>
__ext4fs_dirhash (fs/ext4/hash.c:268) 
ext4fs_dirhash (fs/ext4/hash.c:322) 
htree_dirblock_to_tree (fs/ext4/namei.c:1127)
ext4_htree_fill_tree (fs/ext4/namei.c:1222) 
ext4_readdir (fs/ext4/dir.c:608 fs/ext4/dir.c:142) 
iterate_dir (fs/readdir.c:106) 
__x64_sys_getdents64 (fs/readdir.c:406 fs/readdir.c:390 fs/readdir.c:390) 
do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:81) 
...
</TASK>

These patches address a warning encountered when mounting ext4 filesystems
with the default hash version set to SIPHASH while the casefold feature is not
enabled. The warning occurs due to incorrect error handling and setup of the
default hash version.

[PATCH 1/2] ext4: filesystems without casefold feature cannot be mounted with siphash
Ensures that ext4 filesystems with the default hash set to SIPHASH cannot be
mounted if the casefold feature is not enabled.

[PATCH 2/2] ext4: fix error message when rejecting the default hash
Corrects the error message logic for rejecting filesystems with the default
SIPHASH hash version, ensuring the error message doesn't incorrectly
reference the casefold setup. Also moves the check to ext4_hash_info_init
to ensure consistency.


