Return-Path: <stable+bounces-138140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C386AA16BA
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71A0188BDF2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F6C244670;
	Tue, 29 Apr 2025 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kW9rrtjU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069B22172E;
	Tue, 29 Apr 2025 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948288; cv=none; b=l4fQ0RYrHna08YsyjsL9+Kh0KQxtjgwj03cyY2CPOI9JA/Z8Fy64u5eD+1gaEjOVMXJ0dBH863wHBjyuVqiMObKIifwzr/lK6gFrKk0z9TdHNVU1wqWbLFalASi9OqXZ1sTN7HHdgDDAeHnwawLwZF34mEt7uJ0E2TQlUHKLLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948288; c=relaxed/simple;
	bh=isEw3xkvzfcKcLb0zXbpxUvDox4XxMAmBYVemyO+Muc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeFf1GHIHHv2S5hiGdktDzvFM639yYNmjmAk4noCC3ah9pMdU8tAUgtRBgKbd+sRHHsKKx8rwHQ1VJKsG9rRRRWsTWhcWvpKdGXa95kqQC8RrA6W2e7zdCaiXszAEhbNKVWSSUvSEEm1Bsf26KBHbJEweu4recCn5TNWGm04iFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kW9rrtjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7204C4CEE3;
	Tue, 29 Apr 2025 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948288;
	bh=isEw3xkvzfcKcLb0zXbpxUvDox4XxMAmBYVemyO+Muc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kW9rrtjUr6H/iz68zzxVD+vLEBnDOg+CGEtHOPk4ofEJDmjDCj1RDsG6ZIjEkDLzl
	 Uo6TLWRwcOxiIYIRFDfFeTeM6v6KOKYcAhHUpn7aJuQ1z3HIIVV4I+MgirZjp4g/A/
	 rxRMrBHC6sUIcISbhX33lJZ188vhLifoRYRDYD24=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Meir Elisha <meir.elisha@volumez.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 244/280] md/raid1: Add check for missing source disk in process_checks()
Date: Tue, 29 Apr 2025 18:43:05 +0200
Message-ID: <20250429161125.109376778@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Meir Elisha <meir.elisha@volumez.com>

[ Upstream commit b7c178d9e57c8fd4238ff77263b877f6f16182ba ]

During recovery/check operations, the process_checks function loops
through available disks to find a 'primary' source with successfully
read data.

If no suitable source disk is found after checking all possibilities,
the 'primary' index will reach conf->raid_disks * 2. Add an explicit
check for this condition after the loop. If no source disk was found,
print an error message and return early to prevent further processing
without a valid primary source.

Link: https://lore.kernel.org/linux-raid/20250408143808.1026534-1-meir.elisha@volumez.com
Signed-off-by: Meir Elisha <meir.elisha@volumez.com>
Suggested-and-reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 8a994a1975ca7..6b6cd753d61a9 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2156,14 +2156,9 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
 				if (!rdev_set_badblocks(rdev, sect, s, 0))
 					abort = 1;
 			}
-			if (abort) {
-				conf->recovery_disabled =
-					mddev->recovery_disabled;
-				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-				md_done_sync(mddev, r1_bio->sectors, 0);
-				put_buf(r1_bio);
+			if (abort)
 				return 0;
-			}
+
 			/* Try next page */
 			sectors -= s;
 			sect += s;
@@ -2302,10 +2297,21 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
 	int disks = conf->raid_disks * 2;
 	struct bio *wbio;
 
-	if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
-		/* ouch - failed to read all of that. */
-		if (!fix_sync_read_error(r1_bio))
+	if (!test_bit(R1BIO_Uptodate, &r1_bio->state)) {
+		/*
+		 * ouch - failed to read all of that.
+		 * No need to fix read error for check/repair
+		 * because all member disks are read.
+		 */
+		if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) ||
+		    !fix_sync_read_error(r1_bio)) {
+			conf->recovery_disabled = mddev->recovery_disabled;
+			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+			md_done_sync(mddev, r1_bio->sectors, 0);
+			put_buf(r1_bio);
 			return;
+		}
+	}
 
 	if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
 		process_checks(r1_bio);
-- 
2.39.5




