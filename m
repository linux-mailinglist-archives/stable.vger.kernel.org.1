Return-Path: <stable+bounces-78626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B754C98D0F4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560C0B20DAA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1A41E493E;
	Wed,  2 Oct 2024 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qvFF29F4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9DB194A53
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864030; cv=none; b=LDz08xiynGJorxU5Aj9zvTOJTe9F3EUcRnOtEJUdyEcDbO8wSDE2W0+ztb9DmDSOZFcXweLIEMk5ZUw0C2MAkhUOtsZyMgIBeRvAJJhIbi58YWnmvBd7taO8vRx1NytWHv22opD3482nd6U1Ch6M5eybmreUkFmSsQiEAISrOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864030; c=relaxed/simple;
	bh=rU06EJvW4gSZLe/0Vlk9xQhBKG12+TfDA4KVr/g+vZU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=thWQeNTV1flsId9C5YIL0zHM1Cs6gecQW00Ykvinu+nvxxAjyK0cRZRyh1Dfd2n0vLcD0/hc7RdjP1IT34UqwZUtjnYuLyR/bgN43K8Phejvx5vP4b6V/8CEY3gx7U7S7FnYpCDGBmR9JpQlXN/6Z0PA+IPyLCD9A/U6YyB2wLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qvFF29F4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C836AC4CEC5;
	Wed,  2 Oct 2024 10:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727864030;
	bh=rU06EJvW4gSZLe/0Vlk9xQhBKG12+TfDA4KVr/g+vZU=;
	h=Subject:To:Cc:From:Date:From;
	b=qvFF29F47fD4uLdlw/mHVMDOSC1pivhTACaf5oK+Qen1/8G8LYbarMd48elfV84My
	 IlRmEeWftvJ6t11FyjvsFO7BwJ7jyk8bMmLA40nsnsqa9jkC8rqOMj6uBg2y4/evRC
	 vc23NINBXzXi/fDQZKe1ik8yOfOu1+ba8vOhnWBs=
Subject: FAILED: patch "[PATCH] dm-verity: restart or panic on an I/O error" failed to apply to 6.1-stable tree
To: mpatocka@redhat.com,dfirblog@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 02 Oct 2024 12:13:47 +0200
Message-ID: <2024100247-friction-answering-6c42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e6a3531dd542cb127c8de32ab1e54a48ae19962b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100247-friction-answering-6c42@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e6a3531dd542 ("dm-verity: restart or panic on an I/O error")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6a3531dd542cb127c8de32ab1e54a48ae19962b Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 24 Sep 2024 15:18:29 +0200
Subject: [PATCH] dm-verity: restart or panic on an I/O error

Maxim Suhanov reported that dm-verity doesn't crash if an I/O error
happens. In theory, this could be used to subvert security, because an
attacker can create sectors that return error with the Write Uncorrectable
command. Some programs may misbehave if they have to deal with EIO.

This commit fixes dm-verity, so that if "panic_on_corruption" or
"restart_on_corruption" was specified and an I/O error happens, the
machine will panic or restart.

This commit also changes kernel_restart to emergency_restart -
kernel_restart calls reboot notifiers and these reboot notifiers may wait
for the bio that failed. emergency_restart doesn't call the notifiers.

Reported-by: Maxim Suhanov <dfirblog@gmail.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index cf659c8feb29..a95c1b9cc5b5 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -272,8 +272,10 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	if (v->mode == DM_VERITY_MODE_LOGGING)
 		return 0;
 
-	if (v->mode == DM_VERITY_MODE_RESTART)
-		kernel_restart("dm-verity device corrupted");
+	if (v->mode == DM_VERITY_MODE_RESTART) {
+		pr_emerg("dm-verity device corrupted\n");
+		emergency_restart();
+	}
 
 	if (v->mode == DM_VERITY_MODE_PANIC)
 		panic("dm-verity device corrupted");
@@ -596,6 +598,23 @@ static void verity_finish_io(struct dm_verity_io *io, blk_status_t status)
 	if (!static_branch_unlikely(&use_bh_wq_enabled) || !io->in_bh)
 		verity_fec_finish_io(io);
 
+	if (unlikely(status != BLK_STS_OK) &&
+	    unlikely(!(bio->bi_opf & REQ_RAHEAD)) &&
+	    !verity_is_system_shutting_down()) {
+		if (v->mode == DM_VERITY_MODE_RESTART ||
+		    v->mode == DM_VERITY_MODE_PANIC)
+			DMERR_LIMIT("%s has error: %s", v->data_dev->name,
+					blk_status_to_str(status));
+
+		if (v->mode == DM_VERITY_MODE_RESTART) {
+			pr_emerg("dm-verity device corrupted\n");
+			emergency_restart();
+		}
+
+		if (v->mode == DM_VERITY_MODE_PANIC)
+			panic("dm-verity device corrupted");
+	}
+
 	bio_endio(bio);
 }
 


