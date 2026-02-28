Return-Path: <stable+bounces-220419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADI+F146o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:56:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C4F1C66E1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF9831FBC44
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC9B480DD5;
	Sat, 28 Feb 2026 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ej/la0UB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B123B11D1;
	Sat, 28 Feb 2026 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300310; cv=none; b=in3+lxMwhnV14GJx9ZpToeqL1Qrdw9/FhtyibzKgpFjnqu/P1NXr4FmXJsUIWQaA3sKMCcVC8i0gokPPS/GBt/olVZDuolYsFn6+IHfYYOIAOkidAtE0/7hOJKhSkjQt72Hw+9jd5JuPuVFDW9kY/IMox9jf8mFpTHM3iG64GlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300310; c=relaxed/simple;
	bh=ePR/Zj3d6jqJncBptWbqG1xkmpftdrwOe5ga0jt3hkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnG6l4fuH/3ehE4wq6VtCbcETlV1wJpTU9807nlLbFQzBakVW7sMw/qA5F27r7RCPFD3310ZwUZkjj/tu2mccoLbGqFrwrjmDkzFIjOPBZ4tjlK9RVHLYfiomCjdVbu+gdmZd6si825+DLGA+czXcuYh7p0gx0gLvvBE79Y6yp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ej/la0UB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D43DC116D0;
	Sat, 28 Feb 2026 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300309;
	bh=ePR/Zj3d6jqJncBptWbqG1xkmpftdrwOe5ga0jt3hkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ej/la0UBfB4oOI12cemG1zkLsJE3z12MGEtC0fC9m9Z8o9RZsal4hrTsqOH12bMRN
	 l0AFQbxv1jfOsW24JCdwXbyzJkJJdpF/rERoWH758wqkKyMTGCy8e4YWChjfyTBaD2
	 kJr0Jm0GRPyFJ2d6bv7i0dabHELwdx8TlAOsJaJOS6aLHwD9mJr0psPVkai1m+I+rM
	 g/AlCaY05AovFqMj+tq1JQCrhM7QCtnWZUXE+F2YwfXHUrZykCcfCtZiSHW0qm3EU/
	 F3U3QgUfyp36lqzMzpwMkbHK5Ez3nxO4VPNEopHFEIh34h6CJXusNIg9nF07DrNWzV
	 PfUpx/oNXyJkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Longfang Liu <liulongfang@huawei.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 340/844] hisi_acc_vfio_pci: resolve duplicate migration states
Date: Sat, 28 Feb 2026 12:24:13 -0500
Message-ID: <20260228173244.1509663-341-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220419-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 84C4F1C66E1
X-Rspamd-Action: no action

From: Longfang Liu <liulongfang@huawei.com>

[ Upstream commit 8c6ac1730a977234dff74cc1753b4a953f59be7b ]

In special scenarios involving duplicate migrations, after the
first migration is completed, if the original VF device is used
again and then migrated to another destination, the state indicating
data migration completion for the VF device is not reset.
This results in the second migration to the destination being skipped
without performing data migration.
After the modification, it ensures that a complete data migration
is performed after the subsequent migration.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Link: https://lore.kernel.org/r/20260122020205.2884497-4-liulongfang@huawei.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index d1e8053640a98..8a05fb91929fb 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1570,6 +1570,7 @@ static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
 		}
 		hisi_acc_vdev->mig_state = VFIO_DEVICE_STATE_RUNNING;
 		hisi_acc_vdev->dev_opened = true;
+		hisi_acc_vdev->match_done = 0;
 		mutex_unlock(&hisi_acc_vdev->open_mutex);
 	}
 
-- 
2.51.0


