Return-Path: <stable+bounces-137642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05ECAA145C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D131B63C80
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1764224A06A;
	Tue, 29 Apr 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pCotcl1l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87E1221DA7;
	Tue, 29 Apr 2025 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946685; cv=none; b=BzMQJR+Jck2rdu4exmiMYsddyBCz+z/j+yraknLhtUG3lRlAy0sM9GgGXuWshzf1yL6TQL80tI1r/5VObMIrl3fZIgo42AFl3eN/HVNVKGffyynTOKcVfi4oFBZNfyqXcyo07xBIX/s1SK5FGg34IeNB+7pdf1E/Qly/yn9ruK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946685; c=relaxed/simple;
	bh=J2nTXZ96p3eUKzXErhJuU/xUZ+nyZrFcbpMMuDHqXIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arviPzmJMmZRxVwNr1csSSehvj6wRLsIrSnQXlNlTHUnTcbgeMrMP0QxeQWMwm4fRyY2Rh+Ndfr/z9a8R9B7Zya0K0395UiGzkfvVyI7CMFm/JTFZ599aDzh2MHTSoEf+HWMerH1yMbjbSogGmse8H7VuCpfOc1dXv4D9AQ0Asw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pCotcl1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F047EC4CEEE;
	Tue, 29 Apr 2025 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946685;
	bh=J2nTXZ96p3eUKzXErhJuU/xUZ+nyZrFcbpMMuDHqXIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCotcl1lO5eDG4wMEixhLu7dOQS2U1NJ+yJzFiyFhPwwHXsneas0PLyWqmLDMicmS
	 4tzQjzb7vCbODaXhxeX/1GWwpK3Y9M3z4G8K3O1X5J6pieGexDp0A64JzMNcdHArG5
	 2irV+KkPGIdTW+a6Xb4xeo5QoGY1jxMItZ5PfDLE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 007/286] nvmet-fcloop: swap list_add_tail arguments
Date: Tue, 29 Apr 2025 18:38:31 +0200
Message-ID: <20250429161108.159787742@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit 2b5f0c5bc819af2b0759a8fcddc1b39102735c0f ]

The newly element to be added to the list is the first argument of
list_add_tail. This fix is missing dcfad4ab4d67 ("nvmet-fcloop: swap
the list_add_tail arguments").

Fixes: 437c0b824dbd ("nvme-fcloop: add target to host LS request support")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fcloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index f2c5136bf2b82..f1aaabc5bec7d 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -478,7 +478,7 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	if (targetport) {
 		tport = targetport->private;
 		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
 		schedule_work(&tport->ls_work);
 	}
-- 
2.39.5




