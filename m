Return-Path: <stable+bounces-202525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60575CC331E
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90BDF3055E2F
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A10349B1E;
	Tue, 16 Dec 2025 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pcGX344e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067B342CBD;
	Tue, 16 Dec 2025 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888181; cv=none; b=EKcUpqpx5+ZVRqE/gkKP+sol/SP51TuOFjWKBoPfbGpbtGfGE3YkbK894pgwN7rnvX8fq8WRlaykSIro4Tkpm7H+WTBFbEh6R6wN3MP+WsigFGmw5kJOTIKlmSWPduDByW5Ll6DnvrQLuCSNAUjCT46PhtFRJEe3XDOVGdDzSKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888181; c=relaxed/simple;
	bh=DT8pyVDttQAEiYnB831TyXWZ+Nsrp6BCxruGFP89xAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbeH0LvJ7B4Unzp7TrCPSzj2hJiEYmfN83uqNIFsdI+gICwYp3FuyTKVyhdPe3ZnbogTYR618EN/6dhn+y+zHdvYHc8wpqQOl0dq3DtGtkssyU9rVpkfAY+mw+5/vwHEmQMTZWMRJI/Blk1x3cfV//9ezBcISEQkjJqTRTEiK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pcGX344e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D1FC4CEF1;
	Tue, 16 Dec 2025 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765888180;
	bh=DT8pyVDttQAEiYnB831TyXWZ+Nsrp6BCxruGFP89xAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pcGX344ewjjrhcbhe9YvUqZr4Qe5eE41ueRfcLO5bMa2Dm+oqfUAZXmQwCxJ7CM73
	 NJcrEArl7cw8tClAob/V/h4oQTVOlgHhwLXr9eWJt/CFVb5s06laI1COwtuHFwlC6d
	 2idtBIDOZt6LdNc6FW7wrAIUtuY2RLa3XetyP5mY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 423/614] RDMA/irdma: Add a missing kfree of struct irdma_pci_f for GEN2
Date: Tue, 16 Dec 2025 12:13:10 +0100
Message-ID: <20251216111416.698968622@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

[ Upstream commit 9e13d880ebae5da9b39ef2ed83a89737e927173f ]

During a refactor of the irdma GEN2 code, the kfree of the irdma_pci_f struct
in icrdma_remove(), which was originally introduced upstream as part of
commit 80f2ab46c2ee ("irdma: free iwdev->rf after removing MSI-X")
was accidentally removed.

Fixes: 0c2b80cac96e ("RDMA/irdma: Refactor GEN2 auxiliary driver")
Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Link: https://patch.msgid.link/20251125025350.180-4-tatyana.e.nikolova@intel.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/icrdma_if.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/icrdma_if.c b/drivers/infiniband/hw/irdma/icrdma_if.c
index 27b191f61caf4..5d3fd118e4f81 100644
--- a/drivers/infiniband/hw/irdma/icrdma_if.c
+++ b/drivers/infiniband/hw/irdma/icrdma_if.c
@@ -320,6 +320,8 @@ static void icrdma_remove(struct auxiliary_device *aux_dev)
 	irdma_ib_unregister_device(iwdev);
 	icrdma_deinit_interrupts(iwdev->rf, cdev_info);
 
+	kfree(iwdev->rf);
+
 	pr_debug("INIT: Gen[%d] func[%d] device remove success\n",
 		 rdma_ver, PCI_FUNC(cdev_info->pdev->devfn));
 }
-- 
2.51.0




