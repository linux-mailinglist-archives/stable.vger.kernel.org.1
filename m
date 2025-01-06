Return-Path: <stable+bounces-107364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FDAA02B91
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3AE1655F6
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A021607AA;
	Mon,  6 Jan 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r++5/WJy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109577082A;
	Mon,  6 Jan 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178241; cv=none; b=tO1r9f1/6HX9TTK5kAoOdgis2/0fTpi0CWQJzm719bsPNNPShKD5KgeVGZXUN0jsq9mCzLwVuJzYjSRpCz2s4PZAq8npjjzc69CHtjrq880ZOhc63uC5BRY+6pTaNNR7JeZKsLXCFQ/WiotJGA8xBpmWK4DsVe5O5P+10PCSuHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178241; c=relaxed/simple;
	bh=ebnyWLlG2Uk7BmbVTEoPcdgxMjCioFKj+agkteESrbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLW2BzRwAWBm34ZHmhcV7X8MuLdeeKSB95rXMpPEc2t6ShU5E95wf+KZIRWRwDuHS7lz7EjjwfuxpJLX9gzvtNX5YFK0Nt7O/VaW9qNdzzlN6X+dBq2+Z16oIgwXkx7n0b/tb72jF/PP0orDXdm5M3Z549/o9hD3VdqFZCvWxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r++5/WJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87910C4CED2;
	Mon,  6 Jan 2025 15:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178240;
	bh=ebnyWLlG2Uk7BmbVTEoPcdgxMjCioFKj+agkteESrbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r++5/WJylNjP2XoYbguNj9nzDRu6MpLw8u5Z+JywM7oThBFw+0H6il/ubKdgv28Ts
	 FxLNI7+cpUSBZQck4EiYr5fjHKsvDexWjQjJdP91L5pXXg5xCVDM5f7L4T9QbgQs9G
	 hSlDJ4p6cArt2T/a+TuXyc7nRD3PuobrPvZwhwPU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.10 051/138] phy: core: Fix an OF node refcount leakage in of_phy_provider_lookup()
Date: Mon,  6 Jan 2025 16:16:15 +0100
Message-ID: <20250106151135.167939233@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151133.209718681@linuxfoundation.org>
References: <20250106151133.209718681@linuxfoundation.org>
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

commit a2d633cb1421e679b56f1a9fe1f42f089706f1ed upstream.

For macro for_each_child_of_node(parent, child), refcount of @child has
been increased before entering its loop body, so normally needs to call
of_node_put(@child) before returning from the loop body to avoid refcount
leakage.

of_phy_provider_lookup() has such usage but does not call of_node_put()
before returning, so cause leakage of the OF node refcount.

Fix by simply calling of_node_put() before returning from the loop body.

The APIs affected by this issue are shown below since they indirectly
invoke problematic of_phy_provider_lookup().
phy_get()
of_phy_get()
devm_phy_get()
devm_of_phy_get()
devm_of_phy_get_by_index()

Fixes: 2a4c37016ca9 ("phy: core: Fix of_phy_provider_lookup to return PHY provider for sub node")
Cc: stable@vger.kernel.org
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20241213-phy_core_fix-v6-5-40ae28f5015a@quicinc.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/phy-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -138,8 +138,10 @@ static struct phy_provider *of_phy_provi
 			return phy_provider;
 
 		for_each_child_of_node(phy_provider->children, child)
-			if (child == node)
+			if (child == node) {
+				of_node_put(child);
 				return phy_provider;
+			}
 	}
 
 	return ERR_PTR(-EPROBE_DEFER);



