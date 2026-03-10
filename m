Return-Path: <stable+bounces-224441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAf1Fm4FsGlAegIAu9opvQ
	(envelope-from <stable+bounces-224441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:50:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B3524B9E9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB9B13080C54
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DAC421EE5;
	Tue, 10 Mar 2026 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcAfWLOr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71D5421A19;
	Tue, 10 Mar 2026 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142174; cv=none; b=fLBhCK5O890iv1FjiP7VQy249zV9mc/Dz2YJFEEXc0oGwHQmi3uEnJQ4mFJHuez66TumIaLm6aAczphhPildTapa5Pg/947WMkoPiF8JjVlavrYKbQzigLXr06rpC94BQfL3mEoG2L06yy8FSpWEBuUYE/mC/ZmYC6n0g7Vq8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142174; c=relaxed/simple;
	bh=amrbikU7IN6hJui9TMZQlIjt1R5+iXG3LRSOilXiYBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WORQ1X7S1ZlZLv45Dz4Rx+RDS5i8pFqPzlBUokLgSKkXb1NEBrdwv6sfdd9hz6hKVncH7VGDlaJIePr3M4rQaQv6kX4ai6AR+6LMnjKkG8fZEwrVxXFEkK8WHq1Ra6/ih/DV3uUxjHELuS/zlcxd2AuBnfvca0KDpjwpZBOd+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcAfWLOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBC5C2BC9E;
	Tue, 10 Mar 2026 11:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142173;
	bh=amrbikU7IN6hJui9TMZQlIjt1R5+iXG3LRSOilXiYBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dcAfWLOr6zG4suwo3viY0b/ua+fyBSB8mCfa8GdFOgtvI4/hWjG1XxNw0vrQb2QkD
	 0MXMSM+fwYCkxnP4sbLmUuH61FeOAm9MOuhzMMOw2WuI/VtQWgZb+vZkhNPM2otaaR
	 qAf6s8cMywCk6fOyJEyydweaMqiLi3R3OEMhqixmktbpU0ZQ/y2A/20nTrwwgioXxQ
	 e416OX85ATgaHRAk/TekGu4KRkqzGgDog6V2TD923ZADcSXO6Zm6sJj5Dy0LgYgtKo
	 UFEJ51z37E9DQsxE/xeyo48+cp8sGzQhz67W3rLVfA6wpxoiWgPPmfVrmqffDPmP4M
	 2AA+y6WMyF6sg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 262/314] libie: don't unroll if fwlog isn't supported
Date: Tue, 10 Mar 2026 07:18:41 -0400
Message-ID: <271fe4ee3ace52042bde6b804d0e633ee2387b90.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66B3524B9E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224441-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

[ Upstream commit 636cc3bd12f499c74eaf5dc9a7d5b832f1bb24ed ]

The libie_fwlog_deinit() function can be called during driver unload
even when firmware logging was never properly initialized. This led to call
trace:

[  148.576156] Oops: Oops: 0000 [#1] SMP NOPTI
[  148.576167] CPU: 80 UID: 0 PID: 12843 Comm: rmmod Kdump: loaded Not tainted 6.17.0-rc7next-queue-3oct-01915-g06d79d51cf51 #1 PREEMPT(full)
[  148.576177] Hardware name: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 Gen10 Plus, BIOS A42 07/18/2020
[  148.576182] RIP: 0010:__dev_printk+0x16/0x70
[  148.576196] Code: 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 55 41 54 49 89 d4 55 48 89 fd 53 48 85 f6 74 3c <4c> 8b 6e 50 48 89 f3 4d 85 ed 75 03 4c 8b 2e 48 89 df e8 f3 27 98
[  148.576204] RSP: 0018:ffffd2fd7ea17a48 EFLAGS: 00010202
[  148.576211] RAX: ffffd2fd7ea17aa0 RBX: ffff8eb288ae2000 RCX: 0000000000000000
[  148.576217] RDX: ffffd2fd7ea17a70 RSI: 00000000000000c8 RDI: ffffffffb68d3d88
[  148.576222] RBP: ffffffffb68d3d88 R08: 0000000000000000 R09: 0000000000000000
[  148.576227] R10: 00000000000000c8 R11: ffff8eb2b1a49400 R12: ffffd2fd7ea17a70
[  148.576231] R13: ffff8eb3141fb000 R14: ffffffffc1215b48 R15: ffffffffc1215bd8
[  148.576236] FS:  00007f5666ba6740(0000) GS:ffff8eb2472b9000(0000) knlGS:0000000000000000
[  148.576242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  148.576247] CR2: 0000000000000118 CR3: 000000011ad17000 CR4: 0000000000350ef0
[  148.576252] Call Trace:
[  148.576258]  <TASK>
[  148.576269]  _dev_warn+0x7c/0x96
[  148.576290]  libie_fwlog_deinit+0x112/0x117 [libie_fwlog]
[  148.576303]  ixgbe_remove+0x63/0x290 [ixgbe]
[  148.576342]  pci_device_remove+0x42/0xb0
[  148.576354]  device_release_driver_internal+0x19c/0x200
[  148.576365]  driver_detach+0x48/0x90
[  148.576372]  bus_remove_driver+0x6d/0xf0
[  148.576383]  pci_unregister_driver+0x2e/0xb0
[  148.576393]  ixgbe_exit_module+0x1c/0xd50 [ixgbe]
[  148.576430]  __do_sys_delete_module.isra.0+0x1bc/0x2e0
[  148.576446]  do_syscall_64+0x7f/0x980

It can be reproduced by trying to unload ixgbe driver in recovery mode.

Fix that by checking if fwlog is supported before doing unroll.

Fixes: 641585bc978e ("ixgbe: fwlog support for e610")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/libie/fwlog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/libie/fwlog.c b/drivers/net/ethernet/intel/libie/fwlog.c
index f39cc11cb7c56..5d890d9d3c4d5 100644
--- a/drivers/net/ethernet/intel/libie/fwlog.c
+++ b/drivers/net/ethernet/intel/libie/fwlog.c
@@ -1051,6 +1051,10 @@ void libie_fwlog_deinit(struct libie_fwlog *fwlog)
 {
 	int status;
 
+	/* if FW logging isn't supported it means no configuration was done */
+	if (!libie_fwlog_supported(fwlog))
+		return;
+
 	/* make sure FW logging is disabled to not put the FW in a weird state
 	 * for the next driver load
 	 */
-- 
2.51.0


