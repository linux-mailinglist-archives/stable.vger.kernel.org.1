Return-Path: <stable+bounces-78630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F095998D0F8
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20E71F227E2
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C62C1E5006;
	Wed,  2 Oct 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NBvMiFde"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5461E493F
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864042; cv=none; b=dDbFTuQ1QZxw57FjzUNfhD5bD7Z7+Z7G4MX1duweOUwWNVWrCWm+NBnouBvQOq2yJrx1Z/IPSEDFaYVN9DBszab8R3YIXWruy1CkESKJO3sugcGVTt2yNTaGJcEdz9tmIjJrUYqi1bNKE+K0egSuiZ5WQ/Kpr49WzJA55+kL8yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864042; c=relaxed/simple;
	bh=3UavAMtahwMk1bFX9bwwkEhCgh7tp6hu3Uyce5BitCQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dbbiy+1blApFldTKiSCrnKmGBISgeasjQSE/mGeFr3Yz+CtI0joMf7xdTZ+e/viYomMTKW2gyB0AbHHoyNTtrc9D+cKeGwcsATo2Bg4knmAphjeVx/c/dMuHyFoOlu5ozEaJB6R7AZy5zupqFGqiXWFOArB+5/WufoDwXzORXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NBvMiFde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67E2C4CEC5;
	Wed,  2 Oct 2024 10:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727864042;
	bh=3UavAMtahwMk1bFX9bwwkEhCgh7tp6hu3Uyce5BitCQ=;
	h=Subject:To:Cc:From:Date:From;
	b=NBvMiFdex7DNp8y5Opg0yNSQxxi29zIQZKOzFr7d6zLnt/ifOuh61eIXyNIEE0CWV
	 zZagpxYI0ClGt15HRQdKnCjOpqJ2Wo+FWDgsbI3XGgdc5csXfrxN4+KWcvPDPauPe6
	 EDL1JVdRuU/97D3lBsE4zy+BvpYtvtSbkehtx9nQ=
Subject: FAILED: patch "[PATCH] dm-verity: restart or panic on an I/O error" failed to apply to 5.4-stable tree
To: mpatocka@redhat.com,dfirblog@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 02 Oct 2024 12:13:49 +0200
Message-ID: <2024100249-snorkel-jockey-0dd7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x e6a3531dd542cb127c8de32ab1e54a48ae19962b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100249-snorkel-jockey-0dd7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


