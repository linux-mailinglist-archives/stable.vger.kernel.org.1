Return-Path: <stable+bounces-1395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B823D7F7F70
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7DE1C21497
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7528DA1;
	Fri, 24 Nov 2023 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="stpW8EwP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C92D626;
	Fri, 24 Nov 2023 18:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C9FC433C8;
	Fri, 24 Nov 2023 18:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851291;
	bh=U0xx4Z0x5Hb1RiCqvn43z9/+Hg99OwyCu+ddMpHoqDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stpW8EwPlUy0Y9lixXGpLDCqYZWgQ2jf539OwuJTCtr2/kPB41hFXGLWZCMvpabv3
	 e+w20br10C3VuyNmHb0hSAJqYraQG4fH+rueUSn7ZcFX7naFXpObvOxmYarha2g0pO
	 0IdHoAaA75vP89Q+7nLEEy5tRgFLQkt/9VyEzyfo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.5 390/491] smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
Date: Fri, 24 Nov 2023 17:50:26 +0000
Message-ID: <20231124172036.323700710@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.com>

commit d328c09ee9f15ee5a26431f5aad7c9239fa85e62 upstream.

Skip SMB sessions that are being teared down
(e.g. @ses->ses_status == SES_EXITING) in cifs_debug_data_proc_show()
to avoid use-after-free in @ses.

This fixes the following GPF when reading from /proc/fs/cifs/DebugData
while mounting and umounting

  [ 816.251274] general protection fault, probably for non-canonical
  address 0x6b6b6b6b6b6b6d81: 0000 [#1] PREEMPT SMP NOPTI
  ...
  [  816.260138] Call Trace:
  [  816.260329]  <TASK>
  [  816.260499]  ? die_addr+0x36/0x90
  [  816.260762]  ? exc_general_protection+0x1b3/0x410
  [  816.261126]  ? asm_exc_general_protection+0x26/0x30
  [  816.261502]  ? cifs_debug_tcon+0xbd/0x240 [cifs]
  [  816.261878]  ? cifs_debug_tcon+0xab/0x240 [cifs]
  [  816.262249]  cifs_debug_data_proc_show+0x516/0xdb0 [cifs]
  [  816.262689]  ? seq_read_iter+0x379/0x470
  [  816.262995]  seq_read_iter+0x118/0x470
  [  816.263291]  proc_reg_read_iter+0x53/0x90
  [  816.263596]  ? srso_alias_return_thunk+0x5/0x7f
  [  816.263945]  vfs_read+0x201/0x350
  [  816.264211]  ksys_read+0x75/0x100
  [  816.264472]  do_syscall_64+0x3f/0x90
  [  816.264750]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
  [  816.265135] RIP: 0033:0x7fd5e669d381

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifs_debug.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -452,6 +452,11 @@ skip_rdma:
 		seq_printf(m, "\n\n\tSessions: ");
 		i = 0;
 		list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
+			spin_lock(&ses->ses_lock);
+			if (ses->ses_status == SES_EXITING) {
+				spin_unlock(&ses->ses_lock);
+				continue;
+			}
 			i++;
 			if ((ses->serverDomain == NULL) ||
 				(ses->serverOS == NULL) ||
@@ -472,6 +477,7 @@ skip_rdma:
 				ses->ses_count, ses->serverOS, ses->serverNOS,
 				ses->capabilities, ses->ses_status);
 			}
+			spin_unlock(&ses->ses_lock);
 
 			seq_printf(m, "\n\tSecurity type: %s ",
 				get_security_type_str(server->ops->select_sectype(server, ses->sectype)));



