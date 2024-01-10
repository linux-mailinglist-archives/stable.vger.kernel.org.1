Return-Path: <stable+bounces-9832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2268255A2
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 15:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21671F240BB
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 14:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B72E41A;
	Fri,  5 Jan 2024 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="amrXPqQq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F8D2D7B5;
	Fri,  5 Jan 2024 14:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D41C433C7;
	Fri,  5 Jan 2024 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465654;
	bh=Nk7mdn3UZ+QUrzHkxgZDB/oyES1s853sRfRVSvpWwQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=amrXPqQqQflrrQKFDGaQebHkafoLMjw3qf+fSa523jtpc1a0KwhGEKXxcEUO8qa1E
	 9AG/s/CoKT6LUztw6AyO07h1bJTvSIXiPJFK8oOcDdAq4rvwAH3RtSjAwff2SqfknJ
	 AakXMIs7KJHthbpBEz0qGqO6kYBerx3kuNsAVJvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Morris <rtm@csail.mit.edu>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/41] smb: client: fix NULL deref in asn1_ber_decoder()
Date: Fri,  5 Jan 2024 15:39:00 +0100
Message-ID: <20240105143814.844738700@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105143813.957669139@linuxfoundation.org>
References: <20240105143813.957669139@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 90d025c2e953c11974e76637977c473200593a46 ]

If server replied SMB2_NEGOTIATE with a zero SecurityBufferOffset,
smb2_get_data_area() sets @len to non-zero but return NULL, so
decode_negTokeninit() ends up being called with a NULL @security_blob:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 2 PID: 871 Comm: mount.cifs Not tainted 6.7.0-rc4 #2
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  RIP: 0010:asn1_ber_decoder+0x173/0xc80
  Code: 01 4c 39 2c 24 75 09 45 84 c9 0f 85 2f 03 00 00 48 8b 14 24 4c 29 ea 48 83 fa 01 0f 86 1e 07 00 00 48 8b 74 24 28 4d 8d 5d 01 <42> 0f b6 3c 2e 89 fa 40 88 7c 24 5c f7 d2 83 e2 1f 0f 84 3d 07 00
  RSP: 0018:ffffc9000063f950 EFLAGS: 00010202
  RAX: 0000000000000002 RBX: 0000000000000000 RCX: 000000000000004a
  RDX: 000000000000004a RSI: 0000000000000000 RDI: 0000000000000000
  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000000
  R13: 0000000000000000 R14: 000000000000004d R15: 0000000000000000
  FS:  00007fce52b0fbc0(0000) GS:ffff88806ba00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 000000001ae64000 CR4: 0000000000750ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? __die+0x23/0x70
   ? page_fault_oops+0x181/0x480
   ? __stack_depot_save+0x1e6/0x480
   ? exc_page_fault+0x6f/0x1c0
   ? asm_exc_page_fault+0x26/0x30
   ? asn1_ber_decoder+0x173/0xc80
   ? check_object+0x40/0x340
   decode_negTokenInit+0x1e/0x30 [cifs]
   SMB2_negotiate+0xc99/0x17c0 [cifs]
   ? smb2_negotiate+0x46/0x60 [cifs]
   ? srso_alias_return_thunk+0x5/0xfbef5
   smb2_negotiate+0x46/0x60 [cifs]
   cifs_negotiate_protocol+0xae/0x130 [cifs]
   cifs_get_smb_ses+0x517/0x1040 [cifs]
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? queue_delayed_work_on+0x5d/0x90
   cifs_mount_get_session+0x78/0x200 [cifs]
   dfs_mount_share+0x13a/0x9f0 [cifs]
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? lock_acquire+0xbf/0x2b0
   ? find_nls+0x16/0x80
   ? srso_alias_return_thunk+0x5/0xfbef5
   cifs_mount+0x7e/0x350 [cifs]
   cifs_smb3_do_mount+0x128/0x780 [cifs]
   smb3_get_tree+0xd9/0x290 [cifs]
   vfs_get_tree+0x2c/0x100
   ? capable+0x37/0x70
   path_mount+0x2d7/0xb80
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? _raw_spin_unlock_irqrestore+0x44/0x60
   __x64_sys_mount+0x11a/0x150
   do_syscall_64+0x47/0xf0
   entry_SYSCALL_64_after_hwframe+0x6f/0x77
  RIP: 0033:0x7fce52c2ab1e

Fix this by setting @len to zero when @off == 0 so callers won't
attempt to dereference non-existing data areas.

Reported-by: Robert Morris <rtm@csail.mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2misc.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 7177720e822e1..d3d5d2c6c4013 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -302,6 +302,9 @@ static const bool has_smb2_data_area[NUMBER_OF_SMB2_COMMANDS] = {
 char *
 smb2_get_data_area_len(int *off, int *len, struct smb2_sync_hdr *shdr)
 {
+	const int max_off = 4096;
+	const int max_len = 128 * 1024;
+
 	*off = 0;
 	*len = 0;
 
@@ -369,29 +372,20 @@ smb2_get_data_area_len(int *off, int *len, struct smb2_sync_hdr *shdr)
 	 * Invalid length or offset probably means data area is invalid, but
 	 * we have little choice but to ignore the data area in this case.
 	 */
-	if (*off > 4096) {
-		cifs_dbg(VFS, "offset %d too large, data area ignored\n", *off);
-		*len = 0;
-		*off = 0;
-	} else if (*off < 0) {
-		cifs_dbg(VFS, "negative offset %d to data invalid ignore data area\n",
-			 *off);
+	if (unlikely(*off < 0 || *off > max_off ||
+		     *len < 0 || *len > max_len)) {
+		cifs_dbg(VFS, "%s: invalid data area (off=%d len=%d)\n",
+			 __func__, *off, *len);
 		*off = 0;
 		*len = 0;
-	} else if (*len < 0) {
-		cifs_dbg(VFS, "negative data length %d invalid, data area ignored\n",
-			 *len);
-		*len = 0;
-	} else if (*len > 128 * 1024) {
-		cifs_dbg(VFS, "data area larger than 128K: %d\n", *len);
+	} else if (*off == 0) {
 		*len = 0;
 	}
 
 	/* return pointer to beginning of data area, ie offset from SMB start */
-	if ((*off != 0) && (*len != 0))
+	if (*off > 0 && *len > 0)
 		return (char *)shdr + *off;
-	else
-		return NULL;
+	return NULL;
 }
 
 /*
-- 
2.43.0




