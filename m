Return-Path: <stable+bounces-209535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 436CDD26ED7
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4761328A6C3
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4932D73B4;
	Thu, 15 Jan 2026 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P0Ttko5Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ECD39E199;
	Thu, 15 Jan 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498973; cv=none; b=J4WkbOXSrEOy9HJXmgT5Jx4JqG8e6r5qneo2m8qMQSJGBqTahMnu2rYaVCokz7hrshcnp3TT63eYqPJvrxhYn0NXQoynt2uc2XjjFT1Yqo2bi2MrDJFbrNoWxbwZu++DL+6RDtV7QByNktvqHvwDQKWlxXJFkKHCe4ba+E+KgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498973; c=relaxed/simple;
	bh=b+PN0cG9NiJDQnqeDQOsqCQb5KJpgdsjhvHvDk0YkXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEAQYiCS/IHjBLMO0ZZYhDbHfUOijxp9GB5ofeyD5nTUAjA3/TMmaiavgD7jHkvtsO9JO8n5jV1rY6rl40lxwNLBBDaASJvGLz7CAKKd7c3wZmtrBgOp72deOF7Gs3u+6QyLo5ZvUqYmS98N9SGnCSYhFIIt+/FuIRlnbtsxY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P0Ttko5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4AFC116D0;
	Thu, 15 Jan 2026 17:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768498972;
	bh=b+PN0cG9NiJDQnqeDQOsqCQb5KJpgdsjhvHvDk0YkXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0Ttko5Y+FnSNkCyaz51cyft66SEF7vkDOMN5/32e7ko8oALO9pBJWKKGcfu2fYHR
	 KjrIx8H4qIgazD/mxQMsoC2dtoUb6fW3XO2XoHuZbkxWQ/EAwMCK5cSIT3+KlDglFz
	 b47ka+Jzyv/FL64L7boC470KNTwN1VpVKOX7QDsA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 064/451] scsi: stex: Fix reboot_notifier leak in probe error path
Date: Thu, 15 Jan 2026 17:44:25 +0100
Message-ID: <20260115164233.214267928@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
References: <20260115164230.864985076@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index fa607f2182500..2b074b26db725 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -1849,6 +1849,7 @@ static int stex_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_scsi_host_put:
 	scsi_host_put(host);
 out_disable:
+	unregister_reboot_notifier(&stex_notifier);
 	pci_disable_device(pdev);
 
 	return err;
-- 
2.51.0




