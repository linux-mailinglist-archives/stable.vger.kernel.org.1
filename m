Return-Path: <stable+bounces-220674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDIwIo0+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:14:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2EC1C6B99
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FE50313D533
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DE33F4AA0;
	Sat, 28 Feb 2026 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiU7X14Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379853F5299;
	Sat, 28 Feb 2026 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300556; cv=none; b=e/nkkP6gvDf4quIJICDCUB01GSp8TDIbn8CZiR1LFUKP3xW2wa007oOSfKlg+iYEU6jP+QvrMCFS3CzMVhaGg9eYlYxBJSvmRjHjWmPxceqzV/VoEgyFJpHZgdxiVhR7UqlndvkSwLT9VOxHee5ryBbZRtiV48dgV/SUzOIQ1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300556; c=relaxed/simple;
	bh=zMaUWkm3qmMDz0eMNZ10dyiuX56BqHuh7Glw3mA865Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKrguE07zPW9SWP/ftkM0pvudgauyQngUQZAdTIo+yHGNZ6naHiuQ63n9eIQObPwxEETuG1KQ+U3YCTVhvdLEDo5HmPNBJkcmpos6yK/LqxVMVBDzIGq+aDMRRNQ8Uasn0uGZjPXxmUNLstxl34UWVaNLazCNufBR9gZu74rdvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiU7X14Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB91C19423;
	Sat, 28 Feb 2026 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300556;
	bh=zMaUWkm3qmMDz0eMNZ10dyiuX56BqHuh7Glw3mA865Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiU7X14YIizonEsz6dEs5N2jb6ZALG/5wmrewess3DMqDHn7UMbxtz/vXYtoUbhnY
	 ge6bZXvp1FmQA/7ztzAk6tMyMzwJpKgmyY2H5Rdv72jNfASaASkj5frPofY4hT793q
	 BngBFS/8G2Q20o9T69d7onI65Qa77MAjc2p+jwHxRJ1toocE2ZmzWFbVjZDtaJgWuJ
	 q1KthEDzT/ZD0IT4tN9VmxxhGyMgSHUkp0g7dUwR6ClrgJxRr5J1S4u4CtMd5tvu37
	 VnZq/JTdqWoj9+a7FJ/elVZTJK6vA4K7ex6Uf5WP5Gs4OBLgU0XxYqDmdr+Hvt0/Z9
	 PZWZU2FtggwAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bingbu Cao <bingbu.cao@intel.com>,
	Stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 595/844] media: staging/ipu7: Call synchronous RPM suspend in probe failure
Date: Sat, 28 Feb 2026 12:28:28 -0500
Message-ID: <20260228173244.1509663-596-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220674-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B2EC1C6B99
X-Rspamd-Action: no action

From: Bingbu Cao <bingbu.cao@intel.com>

[ Upstream commit 1433e6ccc25e9ea596683ab66e1c51f37fc7d491 ]

If firmware authentication failed during driver probe, driver call an
asynchronous API to suspend the psys device but the bus device will be
removed soon, thus runtime PM of bus device will be disabled soon, that
will cancel the suspend request, so use synchronous suspend to make
sure the runtime suspend before disabling its RPM.

IPU7 hardware has constraints that the PSYS device must be powered off
before ISYS, otherwise it will cause machine check error.

Cc: Stable@vger.kernel.org
Fixes: b7fe4c0019b1 ("media: staging/ipu7: add Intel IPU7 PCI device driver")
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/ipu7/ipu7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu7/ipu7.c b/drivers/staging/media/ipu7/ipu7.c
index 6c8c3eea44acb..fa5a1867626f8 100644
--- a/drivers/staging/media/ipu7/ipu7.c
+++ b/drivers/staging/media/ipu7/ipu7.c
@@ -2620,7 +2620,7 @@ static int ipu7_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!IS_ERR_OR_NULL(isp->isys) && !IS_ERR_OR_NULL(isp->isys->mmu))
 		ipu7_mmu_cleanup(isp->isys->mmu);
 	if (!IS_ERR_OR_NULL(isp->psys))
-		pm_runtime_put(&isp->psys->auxdev.dev);
+		pm_runtime_put_sync(&isp->psys->auxdev.dev);
 	ipu7_bus_del_devices(pdev);
 	release_firmware(isp->cpd_fw);
 buttress_exit:
-- 
2.51.0


