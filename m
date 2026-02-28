Return-Path: <stable+bounces-220573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPK4MAo/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:16:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DE31C6C44
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16F5531EBDF1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19043DCEB6;
	Sat, 28 Feb 2026 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7x57UD5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314D3DCEAE;
	Sat, 28 Feb 2026 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300454; cv=none; b=Hu/rxCCTKEH6p6NCO5GAOxz1mr12gH2wTNNgKkwjS4nbzdaaep27CKTb6DUhagnV0CmjzSfCH6NoQ+KarK87yKYjpxoWT5LK/aglr89c2SejlTCoWqIi4Sj0Fg/3Fb7qizGSI/HpB+KundiUs7OotaxD87H90bLPXMn5jUwIzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300454; c=relaxed/simple;
	bh=xpotWUrM6lst7zkgzpHCfRXXRWuN+DrVm/m7yWLh7xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lql6Bc+SOryStUslI3UbbNePgBAYfPoCr8hRLIgI56PdNHXoMpw9At4j1opyw3Wwm2t9WqvOjO8MLa332tWmM0X+qZPOrI6jpU5kwwU6xUyoB6iQtIq1LhGP6Uu5PUpO9uOdZdIyBNMV0htn8+Nv9wzv7yupytklbjzTq6s8sb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7x57UD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9ACC19424;
	Sat, 28 Feb 2026 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300454;
	bh=xpotWUrM6lst7zkgzpHCfRXXRWuN+DrVm/m7yWLh7xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B7x57UD5/pbHJxcKVucvNm2EaQjdnY568C6sYfJzFEBVrxC3FQsWjFE4EaC8DXXaq
	 oyHCDMHlKTo6EhZHbkXVSEVDkj1tdiBqoVwgFh4XfcisZaEeYcaf/Hc+QDGmiQECkc
	 jdaP6BR5903WzotxF3IpKnUP173oQ25o/XJuey4TV8xNisziLpcQAtaXf+OWMx5Yty
	 x3NDeZ4pWQ8BIbZUH5jAnhOP4SqDT3KAQDA/y0utIsEeDHLbhBD+hv+VZW2iJ0DaJ4
	 h7xsPoZpuoCCIb70e/IPETvfDCI1WgY+BTM6/517tXukRpaN6iuOPdn6jFsGSL8cCX
	 d9j0zPTFkEeyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 494/844] net: mana: Fix double destroy_workqueue on service rescan PCI path
Date: Sat, 28 Feb 2026 12:26:47 -0500
Message-ID: <20260228173244.1509663-495-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220573-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33DE31C6C44
X-Rspamd-Action: no action

From: Dipayaan Roy <dipayanroy@linux.microsoft.com>

[ Upstream commit f975a0955276579e2176a134366ed586071c7c6a ]

While testing corner cases in the driver, a use-after-free crash
was found on the service rescan PCI path.

When mana_serv_reset() calls mana_gd_suspend(), mana_gd_cleanup()
destroys gc->service_wq. If the subsequent mana_gd_resume() fails
with -ETIMEDOUT or -EPROTO, the code falls through to
mana_serv_rescan() which triggers pci_stop_and_remove_bus_device().
This invokes the PCI .remove callback (mana_gd_remove), which calls
mana_gd_cleanup() a second time, attempting to destroy the already-
freed workqueue. Fix this by NULL-checking gc->service_wq in
mana_gd_cleanup() and setting it to NULL after destruction.

Call stack of issue for reference:
[Sat Feb 21 18:53:48 2026] Call Trace:
[Sat Feb 21 18:53:48 2026]  <TASK>
[Sat Feb 21 18:53:48 2026]  mana_gd_cleanup+0x33/0x70 [mana]
[Sat Feb 21 18:53:48 2026]  mana_gd_remove+0x3a/0xc0 [mana]
[Sat Feb 21 18:53:48 2026]  pci_device_remove+0x41/0xb0
[Sat Feb 21 18:53:48 2026]  device_remove+0x46/0x70
[Sat Feb 21 18:53:48 2026]  device_release_driver_internal+0x1e3/0x250
[Sat Feb 21 18:53:48 2026]  device_release_driver+0x12/0x20
[Sat Feb 21 18:53:48 2026]  pci_stop_bus_device+0x6a/0x90
[Sat Feb 21 18:53:48 2026]  pci_stop_and_remove_bus_device+0x13/0x30
[Sat Feb 21 18:53:48 2026]  mana_do_service+0x180/0x290 [mana]
[Sat Feb 21 18:53:48 2026]  mana_serv_func+0x24/0x50 [mana]
[Sat Feb 21 18:53:48 2026]  process_one_work+0x190/0x3d0
[Sat Feb 21 18:53:48 2026]  worker_thread+0x16e/0x2e0
[Sat Feb 21 18:53:48 2026]  kthread+0xf7/0x130
[Sat Feb 21 18:53:48 2026]  ? __pfx_worker_thread+0x10/0x10
[Sat Feb 21 18:53:48 2026]  ? __pfx_kthread+0x10/0x10
[Sat Feb 21 18:53:48 2026]  ret_from_fork+0x269/0x350
[Sat Feb 21 18:53:48 2026]  ? __pfx_kthread+0x10/0x10
[Sat Feb 21 18:53:48 2026]  ret_from_fork_asm+0x1a/0x30
[Sat Feb 21 18:53:48 2026]  </TASK>

Fixes: 505cc26bcae0 ("net: mana: Add support for auxiliary device servicing events")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/aZ2bzL64NagfyHpg@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 5 ++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 0055c231acf6d..3926d18f1840b 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1946,7 +1946,10 @@ static void mana_gd_cleanup(struct pci_dev *pdev)
 
 	mana_gd_remove_irqs(pdev);
 
-	destroy_workqueue(gc->service_wq);
+	if (gc->service_wq) {
+		destroy_workqueue(gc->service_wq);
+		gc->service_wq = NULL;
+	}
 	dev_dbg(&pdev->dev, "mana gdma cleanup successful\n");
 }
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 1ad154f9db1ad..d487bf2f1cf1f 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3690,7 +3690,9 @@ void mana_rdma_remove(struct gdma_dev *gd)
 	}
 
 	WRITE_ONCE(gd->rdma_teardown, true);
-	flush_workqueue(gc->service_wq);
+
+	if (gc->service_wq)
+		flush_workqueue(gc->service_wq);
 
 	if (gd->adev)
 		remove_adev(gd);
-- 
2.51.0


