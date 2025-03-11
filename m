Return-Path: <stable+bounces-123672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92489A5C6E6
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDF63B5F51
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB8F25D918;
	Tue, 11 Mar 2025 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CbvIqGzX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857325E806;
	Tue, 11 Mar 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706629; cv=none; b=XG3baSSqPoNPihqKSMbBZDKTl7Nm197ZJe+X9Cg39N/OgXwFVvtpmXEfhVJYitVrfKCFIEIgFV6CadZDDwfYSTdvKRBezsWYdZBzhlpIYlkE6ChA9y55W88zZ4OKI8PgucDnaLEmUIGHWsg2zA60lhvEp7hRBDQ7P4rHGjI5UQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706629; c=relaxed/simple;
	bh=MkYZZ8ZKE6oaNQZ05S7g9S4VlMUNfCqB0kqKFAOp78I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOc4GGQPgPZyZsn29a/PNEKSwI2MKhypPnZPrsSfLPi44VI+7lpcdz+nYAKS+GOARXPSz7nnlSzrjndQ2r+yCZWxKV0LOTzcLQ5WN9nJRiiVCRIGSCnYZkXj7FKZBvfSsSz7elm4yZAQpvc+z4ZEOUld5jrW+oHos4cfgTiKK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CbvIqGzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15594C4CEE9;
	Tue, 11 Mar 2025 15:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741706628;
	bh=MkYZZ8ZKE6oaNQZ05S7g9S4VlMUNfCqB0kqKFAOp78I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CbvIqGzXMEz5cfiN5rKhqedPG/FbFsp8KlQsFFcqg2ii5Ze6qhrU6hLqadzwcredw
	 pogDWCqicSUCbVTYbQ0eYoqd+ToEbwzEuvAXfmHzQRRZ+nAd7nFLPJNrVuEwx2GX3m
	 c8pP3NKwHAxWpKx+6CtAQZC5NQgil7fwznvKbbYw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 082/462] PCI: endpoint: Destroy the EPC device in devm_pci_epc_destroy()
Date: Tue, 11 Mar 2025 15:55:48 +0100
Message-ID: <20250311145801.593787897@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
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

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit d4929755e4d02bd3de3ae5569dab69cb9502c54f ]

The devm_pci_epc_destroy() comment says destroys the EPC device, but it
does not actually do that since devres_destroy() does not call
devm_pci_epc_release(), and it also can not fully undo what the API
devm_pci_epc_create() does, so it is faulty.

Fortunately, the faulty API has not been used by current kernel tree.  Use
devres_release() instead of devres_destroy() so the EPC device will be
released.

Link: https://lore.kernel.org/r/20241210-pci-epc-core_fix-v3-1-4d86dd573e4b@quicinc.com
Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index ea7e7465ce7a6..8062bc2432303 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -616,7 +616,7 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_pci_epc_release, devm_pci_epc_match,
+	r = devres_release(dev, devm_pci_epc_release, devm_pci_epc_match,
 			   epc);
 	dev_WARN_ONCE(dev, r, "couldn't find PCI EPC resource\n");
 }
-- 
2.39.5




