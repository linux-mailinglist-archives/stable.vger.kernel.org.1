Return-Path: <stable+bounces-96567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6299E9E2A0D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 903F7B2DFF3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2740E1F7548;
	Tue,  3 Dec 2024 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B8XBIRhR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA71F6698;
	Tue,  3 Dec 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237933; cv=none; b=sGo/NTln29xG6pyWZGoVB68Cebn0LfSwk4AGcvGn7JfYV5ZaEMTH1qd0ytjdxiT7Ff3XXgP6fnQ6xFjZA4uPd+IkbFocZ9T6J47gLSe51Z6lxNmgVgxrl66gxVbeW2M8LgQOmp9ja3T7s+t5dRizKxLIKCeL/2BG1AZnPt0DIzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237933; c=relaxed/simple;
	bh=0FjO6V32k4rEnGmdMBWAXFSOkcEHGD3lHpsTCaslh0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2cnGaP/s7ARCAuz/8c31Py6YlCtQhB4Crz1s58on8MQzHkRV3KCTSOHA8e8m6YUhlWc6YbqpvOI4VpCEAeetHJhbOuSRCuCPzOylXllE965FcbRlcDvTpAeq3ZnxGaaWta+Ap66KTIQsm6OjnS+/06icgmtrreeYcL/1VcJabM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B8XBIRhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60151C4CECF;
	Tue,  3 Dec 2024 14:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733237933;
	bh=0FjO6V32k4rEnGmdMBWAXFSOkcEHGD3lHpsTCaslh0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8XBIRhRt7iuTETTKY7ENc8tRjZoyMurGuNRZGNrhWlqqLz1DOu9WlZTwgFX3SL8W
	 dvEnU5svHs+39XKqZuJwJffi77W9YJl1DZrrKY622XJIRfXHFngZ3EYZM/U+RP8Wdw
	 xEBEvI9wknsvm0MGqRjw8HYZ5d+DiF242BiPSW2s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Orange Kao <orange@aiven.io>,
	Tony Luck <tony.luck@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 112/817] EDAC/igen6: Avoid segmentation fault on module unload
Date: Tue,  3 Dec 2024 15:34:44 +0100
Message-ID: <20241203144000.083541435@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Orange Kao <orange@aiven.io>

[ Upstream commit fefaae90398d38a1100ccd73b46ab55ff4610fba ]

The segmentation fault happens because:

During modprobe:
1. In igen6_probe(), igen6_pvt will be allocated with kzalloc()
2. In igen6_register_mci(), mci->pvt_info will point to
   &igen6_pvt->imc[mc]

During rmmod:
1. In mci_release() in edac_mc.c, it will kfree(mci->pvt_info)
2. In igen6_remove(), it will kfree(igen6_pvt);

Fix this issue by setting mci->pvt_info to NULL to avoid the double
kfree.

Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219360
Signed-off-by: Orange Kao <orange@aiven.io>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20241104124237.124109-2-orange@aiven.io
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/igen6_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 189a2fc29e74f..07dacf8c10be3 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1245,6 +1245,7 @@ static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev)
 	imc->mci = mci;
 	return 0;
 fail3:
+	mci->pvt_info = NULL;
 	kfree(mci->ctl_name);
 fail2:
 	edac_mc_free(mci);
@@ -1269,6 +1270,7 @@ static void igen6_unregister_mcis(void)
 
 		edac_mc_del_mc(mci->pdev);
 		kfree(mci->ctl_name);
+		mci->pvt_info = NULL;
 		edac_mc_free(mci);
 		iounmap(imc->window);
 	}
-- 
2.43.0




