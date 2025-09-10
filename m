Return-Path: <stable+bounces-179183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ED5B5133C
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 11:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FB9560E3F
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C4E30DEC8;
	Wed, 10 Sep 2025 09:52:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08762FFDF3;
	Wed, 10 Sep 2025 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497956; cv=none; b=tS3vmmOpCoE+Qphq4oCiCS/NCqRWZxcrvVMcpg2wn1fjNNO5IhMLOR842pYgipR2gBgQCDMDIsVsgZP48xeUMZPUvjY0gDV2nuDWuKlWatSCE31AkYqWeTaV4Uoy/AzHJ0F31kKL3eIqOUYicfaaDCMLnSBo7of3aTN/cWuiiLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497956; c=relaxed/simple;
	bh=u1QIKXzBsENyeCgcrXRUzfKMMd5JUjni4MdiJztllnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cNJBhSL6VRBIWScSPvKy5fWe+e8XcnCOalFfj01iUn0IaE4Z3wtaSGeHzLv3D1HhFvMFq6VvsmNiMbSwBYOcA6vwrrsB1TfbyD4Fb4Ap3Ws9GLvAriAHwJWgOeBbIWuyAU9/XVXtCxaDk8ppwhw3GkwzDNtuJmp9Aj6yhJsaZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lee Jones <lee@kernel.org>,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Yongzhen Zhang <zhangyongzhen@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Brett A C Sheffield <bacs@librecast.net>
Subject: [REGRESSION 5.15.y][BISECTED][PATCH 0/1] console hangs at uevents
Date: Wed, 10 Sep 2025 09:38:01 +0000
Message-ID: <20250910095124.6213-3-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ee7a69aa38d8 ("fbdev: Disable sysfb device registration when removing
conflicting FBs") was backported to 5.15.y LTS. This causes a regression where
all virtual consoles stop responding during boot at:

"Populating /dev with existing devices through uevents ..."

The console is no longer responding, nor is it possible to switch to another
virtual console. It is possible to force a reboot with CTRL+ALT+DEL.

The system is otherwise still working normally, and can be connected to over
ssh.

This patch was not backported to 5.4.y or 5.10.y. Newer stable kernels with this
patch (6.1.y, 6.6.y, 6.12,y, 6.15.y, 6.16.y) and mainline are unaffected.

There are a bunch of patches that touch fbmem.c in later stable kernels, and I
started looking at this but it gets messy very quickly as e23a5e14aa27 is a
merge commit.

Given this was an autoselected patch that was not backported to fix any specific
issue the simplest and cleanest fix is to simply revert.


Bisection log:

git bisect start
# status: waiting for both good and bad commits
# good: [8bb7eca972ad531c9b149c0a51ab43a417385813] Linux 5.15
git bisect good 8bb7eca972ad531c9b149c0a51ab43a417385813
# status: waiting for bad commit, 1 good commit known
# bad: [c275eaaaa34260e6c907bc5e7ee07c096bc45064] Linux 5.15.125
git bisect bad c275eaaaa34260e6c907bc5e7ee07c096bc45064
# bad: [ff2932ac8ee1ce6f66ba1b5017843c87492cd1a8] tcp: Fix a data-race around sysctl_tcp_challenge_ack_limit.
git bisect bad ff2932ac8ee1ce6f66ba1b5017843c87492cd1a8
# good: [72ea28d88d30cefc5b0184e4666cf4817f2a0fa8] arm64: dts: marvell: armada-37xx: Remap IO space to bus address 0x0
git bisect good 72ea28d88d30cefc5b0184e4666cf4817f2a0fa8
# good: [acd12d16528152b32fa09be2c5ef95047f69af05] KVM: x86/mmu: fix NULL pointer dereference on guest INVPCID
git bisect good acd12d16528152b32fa09be2c5ef95047f69af05
# good: [ce49b94ddb70e607c476a12d26002715d694b23a] random: avoid checking crng_ready() twice in random_init()
git bisect good ce49b94ddb70e607c476a12d26002715d694b23a
# good: [6886327780254ba749b770373653b6afc2a339fc] fbcon: Disallow setting font bigger than screen size
git bisect good 6886327780254ba749b770373653b6afc2a339fc
# bad: [1f068f9da7436b11276f23ebf65dd641c8ae0b62] x86/entry: Avoid very early RET
git bisect bad 1f068f9da7436b11276f23ebf65dd641c8ae0b62
# good: [5a4bb158f4c638d1fc494d2730357cfb6f5a4eea] netfilter: nf_tables: replace BUG_ON by element length check
git bisect good 5a4bb158f4c638d1fc494d2730357cfb6f5a4eea
# bad: [e71d0e1370b162271a0053e1f1215961c31dc4cb] ASoC: codecs: rt700/rt711/rt711-sdca: initialize workqueues in probe
git bisect bad e71d0e1370b162271a0053e1f1215961c31dc4cb
# good: [2d84fcb6e6f74c96eb03e6a1b9eed0a164e37b2c] seg6: bpf: fix skb checksum in bpf_push_seg6_encap()
git bisect good 2d84fcb6e6f74c96eb03e6a1b9eed0a164e37b2c
# good: [06f818de1621ea4da689fd45f1eb54ff7617342b] scsi: hisi_sas: Limit max hw sectors for v3 HW
git bisect good 06f818de1621ea4da689fd45f1eb54ff7617342b
# bad: [7a2294c5f2e5636772afe6bd6c5b28218e0ea154] nvme: fix regression when disconnect a recovering ctrl
git bisect bad 7a2294c5f2e5636772afe6bd6c5b28218e0ea154
# good: [b952569e03168e23258fabf3faa4d6d2b8e08835] firmware: sysfb: Add sysfb_disable() helper function
git bisect good b952569e03168e23258fabf3faa4d6d2b8e08835
# bad: [833ecd0eae76eadf81d6d747bb5bc992d1151867] net: tipc: fix possible refcount leak in tipc_sk_create()
git bisect bad 833ecd0eae76eadf81d6d747bb5bc992d1151867
# bad: [13d28e0c79cbf69fc6f145767af66905586c1249] fbdev: Disable sysfb device registration when removing conflicting FBs
git bisect bad 13d28e0c79cbf69fc6f145767af66905586c1249
# first bad commit: [13d28e0c79cbf69fc6f145767af66905586c1249] fbdev: Disable sysfb device registration when removing conflicting FBs



Brett A C Sheffield (1):
  Revert "fbdev: Disable sysfb device registration when removing
    conflicting FBs"

 drivers/video/fbdev/core/fbmem.c | 12 ------------
 1 file changed, 12 deletions(-)

-- 
2.49.1


