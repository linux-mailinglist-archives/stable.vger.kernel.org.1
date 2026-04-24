Return-Path: <stable+bounces-240651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEXaAv1j62mtMAAAu9opvQ
	(envelope-from <stable+bounces-240651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:37:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D69E45E84D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C3F630209C3
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D723CE480;
	Fri, 24 Apr 2026 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ul5j2fWd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA43CE4B2
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777034199; cv=none; b=ieJIpFHbbIDQFg+RXbtKJi2MxfnRz/ao7YjfPaZDAxNFIO+kFZPrdrwU5i+pT/oct+LPhgJTAlyyUu6sdp2ijSu0Eq5v2Frr13NHP/ImkSJVB9ESRvFpQ1BKm7OUq0dYT5IrgSuHGBZGMLKUJNABCCHW+9l9hWQRdyjhglWH88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777034199; c=relaxed/simple;
	bh=QuGOGzEl2zKSjdMEscGE1XyfHnKJW16637J7RxEz44U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sddetWfPoo9vbDQp39BkhrPrbBAVCLFOBmJK0FVnAEf9KWJie1Qt/i+NEQdgLqqcjZRsIJ9k3Cf6qr0YiGm5p3HYIfzMsElKsQfRlSLXXBcnKAXdEXWo06SWTFLVUmYlssyd6GoAoiyCvdLT6PrK6R0J4bCMzPC2eUeeT7zBUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ul5j2fWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8633EC19425;
	Fri, 24 Apr 2026 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777034198;
	bh=QuGOGzEl2zKSjdMEscGE1XyfHnKJW16637J7RxEz44U=;
	h=Subject:To:Cc:From:Date:From;
	b=ul5j2fWdUBoVE0M3YFk38Bd4n/WmxjVDNfE9jF+OxBal4uavSiKQcCndwKX27koGa
	 DpWKN5oPU7TElAI78qu4Wt8SRstzhHdb9ZwfmEa/QSjD2ItPSuTkq43qaAcdHa0RiP
	 PW8Pd/knoeSGobc9hsn+Pdg0Il9oe36KKBmUrdS4=
Subject: FAILED: patch "[PATCH] md/raid1,raid10: don't handle IO error for REQ_RAHEAD and" failed to apply to 6.6-stable tree
To: yukuai3@huawei.com,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Apr 2026 14:34:26 +0200
Message-ID: <2026042426-unpledged-outgoing-5f58@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D69E45E84D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240651-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9f346f7d4ea73692b82f5102ca8698e4040469ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042426-unpledged-outgoing-5f58@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f346f7d4ea73692b82f5102ca8698e4040469ea Mon Sep 17 00:00:00 2001
From: Yu Kuai <yukuai3@huawei.com>
Date: Tue, 27 May 2025 16:14:07 +0800
Subject: [PATCH] md/raid1,raid10: don't handle IO error for REQ_RAHEAD and
 REQ_NOWAIT

IO with REQ_RAHEAD or REQ_NOWAIT can fail early, even if the storage medium
is fine, hence record badblocks or remove the disk from array does not
make sense.

This problem if found by lvm2 test lvcreate-large-raid, where dm-zero
will fail read ahead IO directly.

Fixes: e879a0d9cb08 ("md/raid1,raid10: don't ignore IO flags")
Reported-and-tested-by: Mikulas Patocka <mpatocka@redhat.com>
Closes: https://lore.kernel.org/all/34fa755d-62c8-4588-8ee1-33cb1249bdf2@redhat.com/
Link: https://lore.kernel.org/linux-raid/20250527081407.3004055-1-yukuai1@huaweicloud.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index c7efd8aab675..b8b3a9069701 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -293,3 +293,13 @@ static inline bool raid1_should_read_first(struct mddev *mddev,
 
 	return false;
 }
+
+/*
+ * bio with REQ_RAHEAD or REQ_NOWAIT can fail at anytime, before such IO is
+ * submitted to the underlying disks, hence don't record badblocks or retry
+ * in this case.
+ */
+static inline bool raid1_should_handle_error(struct bio *bio)
+{
+	return !(bio->bi_opf & (REQ_RAHEAD | REQ_NOWAIT));
+}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 657d481525be..19c5a0ce5a40 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -373,14 +373,16 @@ static void raid1_end_read_request(struct bio *bio)
 	 */
 	update_head_pos(r1_bio->read_disk, r1_bio);
 
-	if (uptodate)
+	if (uptodate) {
 		set_bit(R1BIO_Uptodate, &r1_bio->state);
-	else if (test_bit(FailFast, &rdev->flags) &&
-		 test_bit(R1BIO_FailFast, &r1_bio->state))
+	} else if (test_bit(FailFast, &rdev->flags) &&
+		 test_bit(R1BIO_FailFast, &r1_bio->state)) {
 		/* This was a fail-fast read so we definitely
 		 * want to retry */
 		;
-	else {
+	} else if (!raid1_should_handle_error(bio)) {
+		uptodate = 1;
+	} else {
 		/* If all other devices have failed, we want to return
 		 * the error upwards rather than fail the last device.
 		 * Here we redefine "uptodate" to mean "Don't want to retry"
@@ -451,16 +453,15 @@ static void raid1_end_write_request(struct bio *bio)
 	struct bio *to_put = NULL;
 	int mirror = find_bio_disk(r1_bio, bio);
 	struct md_rdev *rdev = conf->mirrors[mirror].rdev;
-	bool discard_error;
 	sector_t lo = r1_bio->sector;
 	sector_t hi = r1_bio->sector + r1_bio->sectors;
-
-	discard_error = bio->bi_status && bio_op(bio) == REQ_OP_DISCARD;
+	bool ignore_error = !raid1_should_handle_error(bio) ||
+		(bio->bi_status && bio_op(bio) == REQ_OP_DISCARD);
 
 	/*
 	 * 'one mirror IO has finished' event handler:
 	 */
-	if (bio->bi_status && !discard_error) {
+	if (bio->bi_status && !ignore_error) {
 		set_bit(WriteErrorSeen,	&rdev->flags);
 		if (!test_and_set_bit(WantReplacement, &rdev->flags))
 			set_bit(MD_RECOVERY_NEEDED, &
@@ -511,7 +512,7 @@ static void raid1_end_write_request(struct bio *bio)
 
 		/* Maybe we can clear some bad blocks. */
 		if (rdev_has_badblock(rdev, r1_bio->sector, r1_bio->sectors) &&
-		    !discard_error) {
+		    !ignore_error) {
 			r1_bio->bios[mirror] = IO_MADE_GOOD;
 			set_bit(R1BIO_MadeGood, &r1_bio->state);
 		}
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index dce06bf65016..b74780af4c22 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -399,6 +399,8 @@ static void raid10_end_read_request(struct bio *bio)
 		 * wait for the 'master' bio.
 		 */
 		set_bit(R10BIO_Uptodate, &r10_bio->state);
+	} else if (!raid1_should_handle_error(bio)) {
+		uptodate = 1;
 	} else {
 		/* If all other devices that store this block have
 		 * failed, we want to return the error upwards rather
@@ -456,9 +458,8 @@ static void raid10_end_write_request(struct bio *bio)
 	int slot, repl;
 	struct md_rdev *rdev = NULL;
 	struct bio *to_put = NULL;
-	bool discard_error;
-
-	discard_error = bio->bi_status && bio_op(bio) == REQ_OP_DISCARD;
+	bool ignore_error = !raid1_should_handle_error(bio) ||
+		(bio->bi_status && bio_op(bio) == REQ_OP_DISCARD);
 
 	dev = find_bio_disk(conf, r10_bio, bio, &slot, &repl);
 
@@ -472,7 +473,7 @@ static void raid10_end_write_request(struct bio *bio)
 	/*
 	 * this branch is our 'one mirror IO has finished' event handler:
 	 */
-	if (bio->bi_status && !discard_error) {
+	if (bio->bi_status && !ignore_error) {
 		if (repl)
 			/* Never record new bad blocks to replacement,
 			 * just fail it.
@@ -527,7 +528,7 @@ static void raid10_end_write_request(struct bio *bio)
 		/* Maybe we can clear some bad blocks. */
 		if (rdev_has_badblock(rdev, r10_bio->devs[slot].addr,
 				      r10_bio->sectors) &&
-		    !discard_error) {
+		    !ignore_error) {
 			bio_put(bio);
 			if (repl)
 				r10_bio->devs[slot].repl_bio = IO_MADE_GOOD;


