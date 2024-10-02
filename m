Return-Path: <stable+bounces-78628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E81998D0F7
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B941F234E7
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D29D1E6316;
	Wed,  2 Oct 2024 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hy2ScGAW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB2A1E5037
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864036; cv=none; b=CxKVAKV/lxHITadqQnNJGsbtKEn4ppdQ2QVrB3WY5ZsJJXkwH9vu/j9pOOVVWyDp4TMRwL0HBcTMXJChlDZKUdLw3KHU83Etw8i+ObnuYKPyyNXJIYD2oVCi0jeBMREXx4JUwaOffrKlDTiV0i8otwFV0YU6sZnJavtNUn2X/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864036; c=relaxed/simple;
	bh=p4X0AZNLNYme+ahllwfVZ3/PqgBQ/PKIADctWQ6JJVo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N5hq8ClOIDLIYL0BZ8OybdUREbis+7twx5+VUnIoirPXGVYhyRn1dS1/dlbFReLlSyyDtRRLGr2y4G2R5xH/LL8VAihT0GkWEjYfmid9Y5AoQ4kOc7RqErhRCkNa2V4om5tO471LPOXYFDKJHKQu1CflaGbEAghy7mhLbrinDNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hy2ScGAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEBBC4CEC5;
	Wed,  2 Oct 2024 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727864036;
	bh=p4X0AZNLNYme+ahllwfVZ3/PqgBQ/PKIADctWQ6JJVo=;
	h=Subject:To:Cc:From:Date:From;
	b=hy2ScGAWS4Rtz7NWjwQpW4y60h7Fm94/PSkazfnLVo6sWcAALs22ioI7zXNhcCFWc
	 NYyaXV4yhDme33tzcG7PHdbYRdMNJ8gxMTpMSmpUtIYpZdz+geNB6YaW8bbVX9s3aQ
	 ARn4qEpZKywzX05TdKLUVPkOGmh48rS3CuxaQIRc=
Subject: FAILED: patch "[PATCH] dm-verity: restart or panic on an I/O error" failed to apply to 5.10-stable tree
To: mpatocka@redhat.com,dfirblog@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 02 Oct 2024 12:13:49 +0200
Message-ID: <2024100248-blitz-lapdog-06dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e6a3531dd542cb127c8de32ab1e54a48ae19962b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100248-blitz-lapdog-06dc@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


