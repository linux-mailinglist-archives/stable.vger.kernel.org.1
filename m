Return-Path: <stable+bounces-136261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296DCA992F2
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EADA1BC06B3
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9313529E06E;
	Wed, 23 Apr 2025 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uVQ5CjhP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502BB29E069;
	Wed, 23 Apr 2025 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422081; cv=none; b=po8n7Lm/ITAxIC2dTeWGL6Yl7kcpdHS4XtOVP/0ufKbT6BL7dlG1N3m1EJ3/aiie/iqP31UP316QEjQZsDVej6IRpHtCrNiGPRQwx3AbcJY5EFBWD6oS1SlpeuK92L5LGbQ2XCp3ZEOs+eY1T4D/IqXCIuTOvvhsBKpSbFGGvp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422081; c=relaxed/simple;
	bh=IIaoCVDZU8FBwIbOyUd/Yx/bXbrHYHmgU8P1OI6Gu4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GN3iZZnH4jHmYssPTk4QSWq6kLhE/qioWp2pfhhv2EZry0hgjml03u52kKhpL0kwrv3I0dsqy5ztFh2S/1B0+nCM6U4z/aRm1RXjCfXFEpSP39pkEAJLQNgd2dSibjHvy5lgiWQXwrfdICNe8kJsDHWDisbnSCeLRejWzJYzGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uVQ5CjhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62B0C4CEE2;
	Wed, 23 Apr 2025 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422081;
	bh=IIaoCVDZU8FBwIbOyUd/Yx/bXbrHYHmgU8P1OI6Gu4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVQ5CjhPK21p/WqkrNPuT6QRA1dkNwUSSzqIr1UmyNggCIrTAGhiJqD3/YBnUzzla
	 FhobD1+sF+J/vC6mOFVjDEYwnq9cK5/xPmdGy7971Hadw+Au/swQbJNaiHXoOU4LR4
	 BCUebdMxrMqkflW4rGim7vF/UiDBpulAm4omu9M8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 212/291] loop: properly send KOBJ_CHANGED uevent for disk device
Date: Wed, 23 Apr 2025 16:43:21 +0200
Message-ID: <20250423142633.048628295@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
References: <20250423142624.409452181@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

commit e7bc0010ceb403d025100698586c8e760921d471 upstream.

The original commit message and the wording "uncork" in the code comment
indicate that it is expected that the suppressed event instances are
automatically sent after unsuppressing.
This is not the case, instead they are discarded.
In effect this means that no "changed" events are emitted on the device
itself by default.
While each discovered partition does trigger a changed event on the
device, devices without partitions don't have any event emitted.

This makes udev miss the device creation and prompted workarounds in
userspace. See the linked util-linux/losetup bug.

Explicitly emit the events and drop the confusingly worded comments.

Link: https://github.com/util-linux/util-linux/issues/2434
Fixes: 498ef5c777d9 ("loop: suppress uevents while reconfiguring the device")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Link: https://lore.kernel.org/r/20250415-loop-uevent-changed-v2-1-0c4e6a923b2a@linutronix.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/loop.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -629,8 +629,8 @@ static int loop_change_fd(struct loop_de
 
 	error = 0;
 done:
-	/* enable and uncork uevent now that we are done */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	return error;
 
 out_err:
@@ -1104,8 +1104,8 @@ static int loop_configure(struct loop_de
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 
-	/* enable and uncork uevent now that we are done */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
+	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 
 	loop_global_unlock(lo, is_loop);
 	if (partscan)



