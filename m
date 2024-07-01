Return-Path: <stable+bounces-56252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1F791E291
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 370F1B28517
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652A2167DA0;
	Mon,  1 Jul 2024 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q2UgNLbL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696116C440
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844275; cv=none; b=pnD1Wu6c9D4+Yd0v5CC1M8tUzhF1HVprDlqEbyJHjuRrhzlXWhJlIBwxPkcZ/5q8N0lGJo5T5OmqH5VM+sVu6PTWwVU1Iq+8HEjAFe/svqqIAR6IOmjtjM+Csdqfrm8vS9RNeb687swZMRnBw/oq5+aN9HZTXjpBkoBaM3fvDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844275; c=relaxed/simple;
	bh=xod+EbmJFQZdGTD8L8PT4y12JMeRh75VzrznacN/CHU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M8fzNs+xBIJEnwsXDXBUufBOAAmXt0fDQfVvVCfMzQOF5RJ+zzeIp7SApGPjxccQWDoFHjIP474VRppRMgfRnYzK2oy+9Cs+a+E363MNsqItzY6ox+efBNL8Q8JK8Gh44enf2TfW1wkdCQOmy3K0nAtKRswmft/dsYmuLzUmm2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q2UgNLbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E57BC32786;
	Mon,  1 Jul 2024 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719844275;
	bh=xod+EbmJFQZdGTD8L8PT4y12JMeRh75VzrznacN/CHU=;
	h=Subject:To:Cc:From:Date:From;
	b=Q2UgNLbLfG/iP/WqiDOIyRhLBN/+30N6d4CpNqUiMkhRJ0ZbWgyiWiaw1Jb5ERC6/
	 50J9ddkMAbGJX0SVS74Pr7ZALCvotUmCE/l5jwMXFDfI7KvmKn1YxEoqorq69XMTNQ
	 6uv0WHXaX+QaNwq7gI6G4wYrrqdTjaDBkDkpLSgo=
Subject: FAILED: patch "[PATCH] ata: libata-core: Fix null pointer dereference on error" failed to apply to 6.1-stable tree
To: cassel@kernel.org,dlemoal@kernel.org,hare@suse.de,john.g.garry@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 16:31:07 +0200
Message-ID: <2024070107-underrate-unusable-ddb9@gregkh>
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
git cherry-pick -x 5d92c7c566dc76d96e0e19e481d926bbe6631c1e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070107-underrate-unusable-ddb9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5d92c7c566dc ("ata: libata-core: Fix null pointer dereference on error")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d92c7c566dc76d96e0e19e481d926bbe6631c1e Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Sat, 29 Jun 2024 14:42:11 +0200
Subject: [PATCH] ata: libata-core: Fix null pointer dereference on error

If the ata_port_alloc() call in ata_host_alloc() fails,
ata_host_release() will get called.

However, the code in ata_host_release() tries to free ata_port struct
members unconditionally, which can lead to the following:

BUG: unable to handle page fault for address: 0000000000003990
PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 10 PID: 594 Comm: (udev-worker) Not tainted 6.10.0-rc5 #44
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
RIP: 0010:ata_host_release.cold+0x2f/0x6e [libata]
Code: e4 4d 63 f4 44 89 e2 48 c7 c6 90 ad 32 c0 48 c7 c7 d0 70 33 c0 49 83 c6 0e 41
RSP: 0018:ffffc90000ebb968 EFLAGS: 00010246
RAX: 0000000000000041 RBX: ffff88810fb52e78 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff88813b3218c0 RDI: ffff88813b3218c0
RBP: ffff88810fb52e40 R08: 0000000000000000 R09: 6c65725f74736f68
R10: ffffc90000ebb738 R11: 73692033203a746e R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000011 R15: 0000000000000006
FS:  00007f6cc55b9980(0000) GS:ffff88813b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000003990 CR3: 00000001122a2000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die_body.cold+0x19/0x27
 ? page_fault_oops+0x15a/0x2f0
 ? exc_page_fault+0x7e/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? ata_host_release.cold+0x2f/0x6e [libata]
 ? ata_host_release.cold+0x2f/0x6e [libata]
 release_nodes+0x35/0xb0
 devres_release_group+0x113/0x140
 ata_host_alloc+0xed/0x120 [libata]
 ata_host_alloc_pinfo+0x14/0xa0 [libata]
 ahci_init_one+0x6c9/0xd20 [ahci]

Do not access ata_port struct members unconditionally.

Fixes: 633273a3ed1c ("libata-pmp: hook PMP support and enable it")
Cc: stable@vger.kernel.org
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Link: https://lore.kernel.org/r/20240629124210.181537-7-cassel@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index efb5195da60c..bdccf4ea251a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5517,6 +5517,9 @@ static void ata_host_release(struct kref *kref)
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
+		if (!ap)
+			continue;
+
 		kfree(ap->pmp_link);
 		kfree(ap->slave_link);
 		kfree(ap->ncq_sense_buf);


