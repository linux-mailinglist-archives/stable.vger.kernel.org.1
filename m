Return-Path: <stable+bounces-207298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC52D09BF0
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81F4430A565F
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3699131A7EA;
	Fri,  9 Jan 2026 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GcZa18EC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4A3335083;
	Fri,  9 Jan 2026 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961658; cv=none; b=XVtqIyT66NJjCjyw44Z+p1CBnFR7/2wtJcVOnOYvtYYPO6Pp2lQ1Ams8gPaQAx5HO+uTmTRK5sRYKKOZjCFyLC4Amd4PvDJ5kgcC0uWJH2D8NIdKa2U3kY25DG9EY9qUeTWw/DPMMSYDg7NX2A7qjhoOxRVL3B4XUT84CIcVHBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961658; c=relaxed/simple;
	bh=CGx4QrCwVmcZvqWa4Q8hgfSde6tVRjti6np4rYPxsg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WthHgud6wKECEp6+0I/SjHUqH9UGyGe7ik5ZwhLDjcJxMv8cA54inluVEzXA/j9aWEPc5N1rqmAnWOB8FmUDHL6fgokrsFmQInbm90wuXkhki/Czlzv/Ayrq1xKtx7KUm8bFMMa1zHS2n+HMi+/pFA4sUjynAERwyt9ApSb9W3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GcZa18EC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3211BC4CEF1;
	Fri,  9 Jan 2026 12:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767961657;
	bh=CGx4QrCwVmcZvqWa4Q8hgfSde6tVRjti6np4rYPxsg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GcZa18ECMQ3TeT2p82Ut+hKMGM/w8giNLywxxQTT2+cABLSJ4l6kgxiHlwDHctBKO
	 dvH0NKFVRkKHWN3Q/2ZkDOnRpqns6E1OSkPcUs2+ssuHB6zsXhmvYYsHnJmNHDbVhr
	 7gmkiDRSY0a1cwHHUbim85IQNdDgqNJH92fJ6sk8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 090/634] scsi: stex: Fix reboot_notifier leak in probe error path
Date: Fri,  9 Jan 2026 12:36:08 +0100
Message-ID: <20260109112120.822036740@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit 20da637eb545b04753e20c675cfe97b04c7b600b ]

In stex_probe(), register_reboot_notifier() is called at the beginning,
but if any subsequent initialization step fails, the function returns
without unregistering the notifier, resulting in a resource leak.

Add unregister_reboot_notifier() in the out_disable error path to ensure
proper cleanup on all failure paths.

Fixes: 61b745fa63db ("scsi: stex: Add S6 support")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20251104094847.270-1-vulab@iscas.ac.cn
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/stex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 6b07f367918ef..56b29b52fce71 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -1846,6 +1846,7 @@ static int stex_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_scsi_host_put:
 	scsi_host_put(host);
 out_disable:
+	unregister_reboot_notifier(&stex_notifier);
 	pci_disable_device(pdev);
 
 	return err;
-- 
2.51.0




