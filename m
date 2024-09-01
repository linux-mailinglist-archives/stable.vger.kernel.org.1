Return-Path: <stable+bounces-71781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5969677B8
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D3A1B21AA7
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF54183CB5;
	Sun,  1 Sep 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y/74tlKJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC58183CA9;
	Sun,  1 Sep 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207795; cv=none; b=RMkvtjp4Olp8mcn8IIFRBNFdwBkkn8xwIhIomeGyTmaZFq7+vSysHR0gGGMabbVbREXdOkH+R18TXYLpwo9zg6M+HBC0Gm7N4NrgSLNz3XLu+7mrud5H1mHKBHfWOdGWCiE+/jzlTN3IXzVxs4KlkoVxZi1/WcAl4JQc5e1pkOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207795; c=relaxed/simple;
	bh=7RuL3w4S9k99jMEEUqhOIcwUs4nrhb6jvAzFuU07Eho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVOvunOIM0Wsg7c3GzDVrEmbFrSL44mxinSCvlbK2+II3EF1qNZxJEgWoJ6ZhOpXr2HpraEr48Z/MwCzSQN3hudqB+vf3B7EoGeC0N+/UXcq0xy09RMv9dZrhFl++5OIG9F5tqxitpl9VVLguKxJ3GOE3qHWPr4SXpP+EZFjzWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y/74tlKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880A4C4CEC3;
	Sun,  1 Sep 2024 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725207794;
	bh=7RuL3w4S9k99jMEEUqhOIcwUs4nrhb6jvAzFuU07Eho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y/74tlKJAzt8wejmDVqEgnu4IPkC+tlg6gJiXQ+t/F+duL9E1iatTrWxpXtjML3sJ
	 1AU8C9eQ1dLAC76WHEXWIAeGw1PqtSGEXf5gh7EtpB7Z+LqhHnF1GspxT1BxZFpCAY
	 jWn9LSuSDZdm88MQk4wR1Ty+HSpj4jcIH9Wn7SJs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Niklas Cassel <cassel@kernel.org>,
	Oleksandr Tymoshenko <ovt@google.com>
Subject: [PATCH 4.19 79/98] ata: libata-core: Fix null pointer dereference on error
Date: Sun,  1 Sep 2024 18:16:49 +0200
Message-ID: <20240901160806.675564579@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160803.673617007@linuxfoundation.org>
References: <20240901160803.673617007@linuxfoundation.org>
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

From: Niklas Cassel <cassel@kernel.org>

commit 5d92c7c566dc76d96e0e19e481d926bbe6631c1e upstream.

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
Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6159,6 +6159,9 @@ static void ata_host_release(struct kref
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
+		if (!ap)
+			continue;
+
 		kfree(ap->pmp_link);
 		kfree(ap->slave_link);
 		kfree(ap);



