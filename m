Return-Path: <stable+bounces-4401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0897E804753
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395441C20CFA
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8723A79F2;
	Tue,  5 Dec 2023 03:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aDeuSArF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9E6FB1;
	Tue,  5 Dec 2023 03:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C142AC433C8;
	Tue,  5 Dec 2023 03:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747444;
	bh=VBYYWsmujcfNLNBN0m4HcJUp0YubCxckad9cEXzCSaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDeuSArFeltly+loywgRsiik0PTPBiFt6Bj/FCsskBZvRImWas7SmjEUbi5dI4WLi
	 FgPxV8G8/Jq0RIOaecDG+k0DVT9JEOSbdD/e51YxVhbbcKPQzayIUrnVwRJ4vKbpe2
	 Dubf7ddmOJoQrru/tNuxFcE40eABHEv07I701bso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wu Bo <bo.wu@vivo.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5.10 078/135] dm verity: dont perform FEC for failed readahead IO
Date: Tue,  5 Dec 2023 12:16:39 +0900
Message-ID: <20231205031535.407067851@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wu Bo <bo.wu@vivo.com>

commit 0193e3966ceeeef69e235975918b287ab093082b upstream.

We found an issue under Android OTA scenario that many BIOs have to do
FEC where the data under dm-verity is 100% complete and no corruption.

Android OTA has many dm-block layers, from upper to lower:
dm-verity
dm-snapshot
dm-origin & dm-cow
dm-linear
ufs

DM tables have to change 2 times during Android OTA merging process.
When doing table change, the dm-snapshot will be suspended for a while.
During this interval, many readahead IOs are submitted to dm_verity
from filesystem. Then the kverity works are busy doing FEC process
which cost too much time to finish dm-verity IO. This causes needless
delay which feels like system is hung.

After adding debugging it was found that each readahead IO needed
around 10s to finish when this situation occurred. This is due to IO
amplification:

dm-snapshot suspend
erofs_readahead     // 300+ io is submitted
	dm_submit_bio (dm_verity)
		dm_submit_bio (dm_snapshot)
		bio return EIO
		bio got nothing, it's empty
	verity_end_io
	verity_verify_io
	forloop range(0, io->n_blocks)    // each io->nblocks ~= 20
		verity_fec_decode
		fec_decode_rsb
		fec_read_bufs
		forloop range(0, v->fec->rsn) // v->fec->rsn = 253
			new_read
			submit_bio (dm_snapshot)
		end loop
	end loop
dm-snapshot resume

Readahead BIOs get nothing while dm-snapshot is suspended, so all of
them will cause verity's FEC.
Each readahead BIO needs to verify ~20 (io->nblocks) blocks.
Each block needs to do FEC, and every block needs to do 253
(v->fec->rsn) reads.
So during the suspend interval(~200ms), 300 readahead BIOs trigger
~1518000 (300*20*253) IOs to dm-snapshot.

As readahead IO is not required by userspace, and to fix this issue,
it is best to pass readahead errors to upper layer to handle it.

Cc: stable@vger.kernel.org
Fixes: a739ff3f543a ("dm verity: add support for forward error correction")
Signed-off-by: Wu Bo <bo.wu@vivo.com>
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-verity-target.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -583,7 +583,9 @@ static void verity_end_io(struct bio *bi
 	struct dm_verity_io *io = bio->bi_private;
 
 	if (bio->bi_status &&
-	    (!verity_fec_is_enabled(io->v) || verity_is_system_shutting_down())) {
+	    (!verity_fec_is_enabled(io->v) ||
+	     verity_is_system_shutting_down() ||
+	     (bio->bi_opf & REQ_RAHEAD))) {
 		verity_finish_io(io, bio->bi_status);
 		return;
 	}



