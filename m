Return-Path: <stable+bounces-48118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A188FCC90
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4F328883D
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00E519307B;
	Wed,  5 Jun 2024 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnhknYVA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537631BD515;
	Wed,  5 Jun 2024 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588582; cv=none; b=D+O7XF9ELjTXrDffQKKGOc0GXJlohBQB/YYWo0T7IV3/mEIBTuJLM+SgH1aSeTK4fW8RwCNa9tOrhD2J8DR0qFXkf+qxtNtVSWBC4JNrShP68KNStKwvx4b2/X4i+AKsXBOqkCKutrgV8JbsbT4KqICP5Pb4R8h3AIt4oBYFwbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588582; c=relaxed/simple;
	bh=d40pCCEkuKjon/8B72AMqtYwBOiL7AlEvf0kD1jsMRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Juxmu0wrqh9AaGL3V4mzaOKpfisb2iSY6c2UiRRDolik1qttrOLMdOwPOaEgb4BZXi561KlmjvcUvVYnN2TJh9W6ttQ1zTR10/88zHa3UJIlDwr+tP4a50E37uQbcYdhifdPeQyz51bPyZdFh23fP7rq58tYGCxcQAgqrjkFXKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnhknYVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34697C4AF08;
	Wed,  5 Jun 2024 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588582;
	bh=d40pCCEkuKjon/8B72AMqtYwBOiL7AlEvf0kD1jsMRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnhknYVAV4g5ALYh+pgDCCR+I+blNhcqfgBjxcMEgan4+gJ3AS5tiTkFxdQKJshtK
	 4wTFuKIqfeazNLvrSc0U5wzOd3cxZ+6K4bvTEHCbdySQDSKB6z9T/DVIrAZKOKkncb
	 zVabeFswb5HSahpY+NeC2CQRVVVzUZvI4TWRDREItb72nic4G4eEifKVLYgVIDtk8r
	 svznGIqwL+JKXroazaiC2tu012qJIJvMbkb9+SDiB+TtA8hhcp+01kS3pfcZkjEfdt
	 1v+dQCJoLEp/VEs29ngvSKmHhzWQPKKGOHxIwfzRJrxI4suOYrQ4K7+FCEU3DeD76R
	 YTGUrgl7w/NvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	Phillip Potter <phil@philpotter.co.uk>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 2/4] cdrom: rearrange last_media_change check to avoid unintentional overflow
Date: Wed,  5 Jun 2024 07:56:14 -0400
Message-ID: <20240605115619.2965224-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115619.2965224-1-sashal@kernel.org>
References: <20240605115619.2965224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Justin Stitt <justinstitt@google.com>

[ Upstream commit efb905aeb44b0e99c0e6b07865b1885ae0471ebf ]

When running syzkaller with the newly reintroduced signed integer wrap
sanitizer we encounter this splat:

[  366.015950] UBSAN: signed-integer-overflow in ../drivers/cdrom/cdrom.c:2361:33
[  366.021089] -9223372036854775808 - 346321 cannot be represented in type '__s64' (aka 'long long')
[  366.025894] program syz-executor.4 is using a deprecated SCSI ioctl, please convert it to SG_IO
[  366.027502] CPU: 5 PID: 28472 Comm: syz-executor.7 Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
[  366.027512] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  366.027518] Call Trace:
[  366.027523]  <TASK>
[  366.027533]  dump_stack_lvl+0x93/0xd0
[  366.027899]  handle_overflow+0x171/0x1b0
[  366.038787] ata1.00: invalid multi_count 32 ignored
[  366.043924]  cdrom_ioctl+0x2c3f/0x2d10
[  366.063932]  ? __pm_runtime_resume+0xe6/0x130
[  366.071923]  sr_block_ioctl+0x15d/0x1d0
[  366.074624]  ? __pfx_sr_block_ioctl+0x10/0x10
[  366.077642]  blkdev_ioctl+0x419/0x500
[  366.080231]  ? __pfx_blkdev_ioctl+0x10/0x10
...

Historically, the signed integer overflow sanitizer did not work in the
kernel due to its interaction with `-fwrapv` but this has since been
changed [1] in the newest version of Clang. It was re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Let's rearrange the check to not perform any arithmetic, thus not
tripping the sanitizer.

Link: https://github.com/llvm/llvm-project/pull/82432 [1]
Closes: https://github.com/KSPP/linux/issues/354
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
Link: https://lore.kernel.org/lkml/20240507-b4-sio-ata1-v1-1-810ffac6080a@google.com
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Link: https://lore.kernel.org/lkml/ZjqU0fbzHrlnad8D@equinox
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
Link: https://lore.kernel.org/r/20240507222520.1445-2-phil@philpotter.co.uk
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index cc28398059833..01f46caf1f88b 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2358,7 +2358,7 @@ static int cdrom_ioctl_timed_media_change(struct cdrom_device_info *cdi,
 		return -EFAULT;
 
 	tmp_info.media_flags = 0;
-	if (tmp_info.last_media_change - cdi->last_media_change_ms < 0)
+	if (cdi->last_media_change_ms > tmp_info.last_media_change)
 		tmp_info.media_flags |= MEDIA_CHANGED_FLAG;
 
 	tmp_info.last_media_change = cdi->last_media_change_ms;
-- 
2.43.0


