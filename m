Return-Path: <stable+bounces-49421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CAF8FED30
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A6C282156
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B42019D069;
	Thu,  6 Jun 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1NPgTCtj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C938D;
	Thu,  6 Jun 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683457; cv=none; b=V+pPQ6D3h5azyQ6PVuNng4FNCiajwkfz8NjLG3Bl2V62p6yLLb5aopTIbjsdGGxVze5B1Q89BHAWO7iAvHAavFi+LGx3CGo/Ih3ELQuLJn3gCoGQoh2OcOADfqn023TtiQR+DhShkeZbkfogtGeo+PD4I9YEr+Y5FqVLpMeK9HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683457; c=relaxed/simple;
	bh=SyUebccWWwPBHgWsHKom0XZqG1C9mqNy0KOBmudkRxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWMp4KDrrqOVNnCdKqH5vAlu/rLNX9Bs1xlf/hc5BC3iwLban8A2mkKz5VXu/OQnECldkqGOspYllhXD0jrst0qnMwnhnGmPHY7TwTnX6CfgdCmJfu16/h1bnamyGseMMAS3RXCXezNOXO5MyRrdq6+pJd0nLqB8fd80M/EM+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1NPgTCtj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A75C32781;
	Thu,  6 Jun 2024 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683457;
	bh=SyUebccWWwPBHgWsHKom0XZqG1C9mqNy0KOBmudkRxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1NPgTCtjKCRCXUM83Sk3CiA64gHTS6nUypNI89irYhswVgzbFCeI9294pZEGZPUVm
	 umlaAKr5lxGCWJ0Cf+CVJTJe30KvFIm2SvWS2xETkFDfZaiVkvB2SwFKkTx+6RSKJF
	 1hu1e/JVZg1tlxhoiRc5eeUOxVO46CbWwBNuNFBU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 402/744] usb: typec: ucsi: simplify partners PD caps registration
Date: Thu,  6 Jun 2024 16:01:14 +0200
Message-ID: <20240606131745.351354916@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 41e1cd1401fcd1f1ae9e47574af2d9fc44a870b3 ]

In a way similar to the previous commit, move
typec_partner_set_usb_power_delivery() to be called after reading the PD
caps. This also removes calls to
usb_power_delivery_unregister_capabilities() from the error path. Keep
all capabilities registered until they are cleared by
ucsi_unregister_partner_pdos().

Fixes: b04e1747fbcc ("usb: typec: ucsi: Register USB Power Delivery Capabilities")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240329-qcom-ucsi-fixes-v2-5-0f5d37ed04db@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 4aac2a719b7cd..7f575b9b3debe 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -694,12 +694,6 @@ static int ucsi_register_partner_pdos(struct ucsi_connector *con)
 			return PTR_ERR(cap);
 
 		con->partner_source_caps = cap;
-
-		ret = typec_partner_set_usb_power_delivery(con->partner, con->partner_pd);
-		if (ret) {
-			usb_power_delivery_unregister_capabilities(con->partner_source_caps);
-			return ret;
-		}
 	}
 
 	ret = ucsi_get_pdos(con, TYPEC_SINK, 1, caps.pdo);
@@ -714,15 +708,9 @@ static int ucsi_register_partner_pdos(struct ucsi_connector *con)
 			return PTR_ERR(cap);
 
 		con->partner_sink_caps = cap;
-
-		ret = typec_partner_set_usb_power_delivery(con->partner, con->partner_pd);
-		if (ret) {
-			usb_power_delivery_unregister_capabilities(con->partner_sink_caps);
-			return ret;
-		}
 	}
 
-	return 0;
+	return typec_partner_set_usb_power_delivery(con->partner, con->partner_pd);
 }
 
 static void ucsi_unregister_partner_pdos(struct ucsi_connector *con)
-- 
2.43.0




