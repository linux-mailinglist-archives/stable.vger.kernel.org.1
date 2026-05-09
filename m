Return-Path: <stable+bounces-244971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YADeIBpc/2mQ5QAAu9opvQ
	(envelope-from <stable+bounces-244971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:08:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 222F65006E0
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60CDE300382D
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1C71A9B58;
	Sat,  9 May 2026 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHnIEW3i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50626282F3F
	for <stable@vger.kernel.org>; Sat,  9 May 2026 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778342933; cv=none; b=AdZklzbGckCIWttAnEdeD+fwrBNVdsd9zIj396jvDE1uMB5kPfNVfxZY51Y0LPmBSBbC37Ca4DJaxIrXd/9/MJh7H3axAs5/gBRJjdG3dK2wkWCdPQ2bz56PrLghaHVj1kfK1EyLv3x+w9HNZyPtCVxdQ7lcX1qThkA3+4wQpU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778342933; c=relaxed/simple;
	bh=U8WPamdscQzXlNyNivT5bJgwehvgsmCNihrs/HkCl/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU6QnnO7DSj7hDpj0c6IAa8deQ25hBClTNu1d5Jfpser2wb1FOZxnrlWiK80r1WCHhapBmH2sHCfvxmpC/8qQn9iMq0CX0U9tVlGG3Hx0A0+Rj69BxrSzEIkQp6P9/F7rre8d+UwP8e74osMPnloHnuGed93Fzxgjq1UrkDlA3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHnIEW3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815AAC2BCC4;
	Sat,  9 May 2026 16:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778342933;
	bh=U8WPamdscQzXlNyNivT5bJgwehvgsmCNihrs/HkCl/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JHnIEW3irEuvulKK4DJs1OQVXv5rEuP33aVXXm1CbyMAYiC1PC5cZWB5PJv5XlCNb
	 OQryUyG+SbNSBM6BrozGc3a7n38ul1v0m0+fpdQIQbUcW0Sg5zMWYqJ+VmhhiAdbFu
	 8O9WJHGTczsCisSlwmPV7CZSJliPGuufJ3IX7WqmZ/ap6VaGft94BZEYNy94uB0s1/
	 jsP7o/42sjyxQZdTINrK4Kp83dgs93bnuHy+cxxeqt2Ler1N33ZDGGt8ey7OT6z/zQ
	 9lUAFd8Lpm5edIBgEdMc2k98tBqRqlFHMwLPJMuTKg8584IO5aVLKUak8CF6Lp10jS
	 uUy6uSpkH7+0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] scsi: sd: Add error handling support for add_disk()
Date: Sat,  9 May 2026 12:08:47 -0400
Message-ID: <20260509160849.3584738-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509160849.3584738-1-sashal@kernel.org>
References: <2026050456-overview-shaking-6135@gregkh>
 <20260509160849.3584738-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 222F65006E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244971-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Luis Chamberlain <mcgrof@kernel.org>

[ Upstream commit 2a7a891f4c406822801ecd676b076c64de072c9e ]

We never checked for errors on add_disk() as this function returned
void. Now that this is fixed, use the shiny new error handling.

As with the error handling for device_add() we follow the same logic and
just put the device so that cleanup is done via the scsi_disk_release().

Link: https://lore.kernel.org/r/20211015233028.2167651-2-mcgrof@kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 1e111c4b3a72 ("scsi: sd: fix missing put_disk() when device_add(&disk_dev) fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index f06cb6c5615a7..91cbe7d569c05 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3458,7 +3458,13 @@ static int sd_probe(struct device *dev)
 		pm_runtime_set_autosuspend_delay(dev,
 			sdp->host->hostt->rpm_autosuspend_delay);
 	}
-	device_add_disk(dev, gd, NULL);
+
+	error = device_add_disk(dev, gd, NULL);
+	if (error) {
+		put_device(&sdkp->dev);
+		goto out;
+	}
+
 	if (sdkp->capacity)
 		sd_dif_config_host(sdkp);
 
-- 
2.53.0


