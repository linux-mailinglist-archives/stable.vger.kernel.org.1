Return-Path: <stable+bounces-54924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 211A6913B3C
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE541F21A93
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6486193067;
	Sun, 23 Jun 2024 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuJNTny1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A0192B93;
	Sun, 23 Jun 2024 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150304; cv=none; b=piDUXkgcHTRcQBqf6NX6qdx1eDnPkUDoUq+KZEW73BFp9K6D3lzSfa+juZ9TLR2EdbS0jCt5omfMRfOVtuo+dkEZ4ClyjBIDB7R9hHP2wjIwBI+VucW+hA2B/KQne8YynMbRrkXy3r0GpS4z1O8iEzT1/wjpZRWLe7zTp2JSWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150304; c=relaxed/simple;
	bh=y8uvdmfORf3nk7mi6zAzHTn5eJ7ZcWbeD6bCIZtOy/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SK/wx/cTtU0GwIN5Y1+7FMdeW9UL7VxoVSzE4tb++SMuVVleGO5VnX5gF1A2K2bbqKhW5FoSdxgXPJ2FTNOKh184h+dr59IM0fxQ7cNdQB2y5iANt12nt6HxEI4GJN2XJnWb6dK1iZZnMwDwz3UMTchcsJfoshDsG7l99BGz5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuJNTny1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D23C2BD10;
	Sun, 23 Jun 2024 13:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150304;
	bh=y8uvdmfORf3nk7mi6zAzHTn5eJ7ZcWbeD6bCIZtOy/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GuJNTny1OV8S3ayMh5z+50K+GeCOafPoJcN/Vmfco93RKt1C4jXQLsMaZRAmDFU43
	 VTyCOu0Ho31btyzwyJ3oyWI1Y3a8T/mKGWXchLdU36ImAg0YmdRwVKsHCgJQLhFqEJ
	 yGm5heU/fC8fa86qUDcdubiWb3WQ90AGmFLiHn8H04e5uCwZJtvAv16jGFtKwO+0Vz
	 HL5L473TAB1QjfdWVYRfi5RtMYnEoXSA3FzQ6Y1HORP1Oj6ae5YEtfIu9nbCJkeTzU
	 L9y1QgMPx6hwjbuOaUHHQ7VQOgpuGZeGkt+LGAt7t30alJXVX7olNiPRXinE+QnUG9
	 YXS+vaEPUk+Qg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 10/16] mei: demote client disconnect warning on suspend to debug
Date: Sun, 23 Jun 2024 09:44:39 -0400
Message-ID: <20240623134448.809470-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134448.809470-1-sashal@kernel.org>
References: <20240623134448.809470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.35
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

[ Upstream commit 1db5322b7e6b58e1b304ce69a50e9dca798ca95b ]

Change level for the "not connected" client message in the write
callback from error to debug.

The MEI driver currently disconnects all clients upon system suspend.
This behavior is by design and user-space applications with
open connections before the suspend are expected to handle errors upon
resume, by reopening their handles, reconnecting,
and retrying their operations.

However, the current driver implementation logs an error message every
time a write operation is attempted on a disconnected client.
Since this is a normal and expected flow after system resume
logging this as an error can be misleading.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20240530091415.725247-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index bb4e9eabda978..c018534c780f9 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -329,7 +329,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 	}
 
 	if (!mei_cl_is_connected(cl)) {
-		cl_err(dev, cl, "is not connected");
+		cl_dbg(dev, cl, "is not connected");
 		rets = -ENODEV;
 		goto out;
 	}
-- 
2.43.0


