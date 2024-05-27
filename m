Return-Path: <stable+bounces-46395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BCE8D03DE
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51A31F218F6
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA552194C88;
	Mon, 27 May 2024 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3GhvYH6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6561A194C82;
	Mon, 27 May 2024 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819383; cv=none; b=AC/mP8zB7vuEdqRjeRaUFH2ekiepHEMAdvsBFnksh+fXAnj98vwPch9NehPL4y1C3wpMll6t/HXisYqaaKte+NB9Nez43AqiOwE2p15ZObeSc8eQ3kLYveNZqvyQOa6zQ9NWBUQZemttAKR16fquIpGiTpJHFAB0wnHX4DCNG5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819383; c=relaxed/simple;
	bh=tNphdjirBb9tdMxisUu7AmYR16l1TQhNBoK7qKrb16g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ji9wNofnHiTZD6CrEcawkLY0pJ3+TZMvsZT1LmP23JYn/pRGG7l1GpQ37F/kHs9dw6iupmDqQv1yX673/v6ZARjP/MAT2Dzxi2ZRp+YiExnXsfszlbF4EYYM0ZITVxDe3dtk/iLHk+N/+4sA/5w2Gk3zbytDV+U1f+K3B+3VJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3GhvYH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146A5C2BBFC;
	Mon, 27 May 2024 14:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819383;
	bh=tNphdjirBb9tdMxisUu7AmYR16l1TQhNBoK7qKrb16g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3GhvYH64Qou1w0CG/9QpHDbGTpYJVsG5QyXbEpmuoCiKaUwVb37MoQvauZqy10aL
	 I2DmNW3Hi27sBvbIGMoFxDHHkiSBjRl7ujxznBE+Dq06FStlLPL51iq5Pa/rlR7tiq
	 3Re1AJBFLWTSesBadXGCXw/dJ31dCEGFU1SuXrGlQC/Tz8+DM8yVYID9D7AvduaIIH
	 kIUVOGn5RGPwJsPPe4EXG7LBoWFZS9Vyf4HZaIAlN/PTa1ApJNh5LmFTCA4+Dpe8fT
	 nPt9W6leMY0Rr0ntB4AUW+dAHb35KO/gPWsotXYLFmyKb6XjU8Pfj5Yx7OgoPCdWdO
	 pLjkS/HKSIDRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manish Rangankar <mrangankar@marvell.com>,
	Martin Hoyer <mhoyer@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	njavali@marvell.com,
	GR-QLogic-Storage-Upstream@marvell.com,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/21] scsi: qedi: Fix crash while reading debugfs attribute
Date: Mon, 27 May 2024 10:15:21 -0400
Message-ID: <20240527141551.3853516-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141551.3853516-1-sashal@kernel.org>
References: <20240527141551.3853516-1-sashal@kernel.org>
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

From: Manish Rangankar <mrangankar@marvell.com>

[ Upstream commit 28027ec8e32ecbadcd67623edb290dad61e735b5 ]

The qedi_dbg_do_not_recover_cmd_read() function invokes sprintf() directly
on a __user pointer, which results into the crash.

To fix this issue, use a small local stack buffer for sprintf() and then
call simple_read_from_buffer(), which in turns make the copy_to_user()
call.

BUG: unable to handle page fault for address: 00007f4801111000
PGD 8000000864df6067 P4D 8000000864df6067 PUD 864df7067 PMD 846028067 PTE 0
Oops: 0002 [#1] PREEMPT SMP PTI
Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10, BIOS U30 06/15/2023
RIP: 0010:memcpy_orig+0xcd/0x130
RSP: 0018:ffffb7a18c3ffc40 EFLAGS: 00010202
RAX: 00007f4801111000 RBX: 00007f4801111000 RCX: 000000000000000f
RDX: 000000000000000f RSI: ffffffffc0bfd7a0 RDI: 00007f4801111000
RBP: ffffffffc0bfd7a0 R08: 725f746f6e5f6f64 R09: 3d7265766f636572
R10: ffffb7a18c3ffd08 R11: 0000000000000000 R12: 00007f4881110fff
R13: 000000007fffffff R14: ffffb7a18c3ffca0 R15: ffffffffc0bfd7af
FS:  00007f480118a740(0000) GS:ffff98e38af00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4801111000 CR3: 0000000864b8e001 CR4: 00000000007706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die_body+0x1a/0x60
 ? page_fault_oops+0x183/0x510
 ? exc_page_fault+0x69/0x150
 ? asm_exc_page_fault+0x22/0x30
 ? memcpy_orig+0xcd/0x130
 vsnprintf+0x102/0x4c0
 sprintf+0x51/0x80
 qedi_dbg_do_not_recover_cmd_read+0x2f/0x50 [qedi 6bcfdeeecdea037da47069eca2ba717c84a77324]
 full_proxy_read+0x50/0x80
 vfs_read+0xa5/0x2e0
 ? folio_add_new_anon_rmap+0x44/0xa0
 ? set_pte_at+0x15/0x30
 ? do_pte_missing+0x426/0x7f0
 ksys_read+0xa5/0xe0
 do_syscall_64+0x58/0x80
 ? __count_memcg_events+0x46/0x90
 ? count_memcg_event_mm+0x3d/0x60
 ? handle_mm_fault+0x196/0x2f0
 ? do_user_addr_fault+0x267/0x890
 ? exc_page_fault+0x69/0x150
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f4800f20b4d

Tested-by: Martin Hoyer <mhoyer@redhat.com>
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
Link: https://lore.kernel.org/r/20240415072155.30840-1-mrangankar@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_debugfs.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_debugfs.c b/drivers/scsi/qedi/qedi_debugfs.c
index 8deb2001dc2ff..37eed6a278164 100644
--- a/drivers/scsi/qedi/qedi_debugfs.c
+++ b/drivers/scsi/qedi/qedi_debugfs.c
@@ -120,15 +120,11 @@ static ssize_t
 qedi_dbg_do_not_recover_cmd_read(struct file *filp, char __user *buffer,
 				 size_t count, loff_t *ppos)
 {
-	size_t cnt = 0;
-
-	if (*ppos)
-		return 0;
+	char buf[64];
+	int len;
 
-	cnt = sprintf(buffer, "do_not_recover=%d\n", qedi_do_not_recover);
-	cnt = min_t(int, count, cnt - *ppos);
-	*ppos += cnt;
-	return cnt;
+	len = sprintf(buf, "do_not_recover=%d\n", qedi_do_not_recover);
+	return simple_read_from_buffer(buffer, count, ppos, buf, len);
 }
 
 static int
-- 
2.43.0


