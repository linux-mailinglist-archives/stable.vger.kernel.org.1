Return-Path: <stable+bounces-131193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91FBA80877
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E441C1BA3B7F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBBD277028;
	Tue,  8 Apr 2025 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hIw6GNNS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022D2690FB;
	Tue,  8 Apr 2025 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115739; cv=none; b=D/MOD6LzyncSzn7R5C0QvfsRxT85SQbM4wOJsTeYOdYFNN1zC1lO/PpzJwuJtqd9Aq2KjaolC103g479nKCakm+OgB1vw8K4gSXPpVKVgdTj1SHTPAChf9EBWYioeYuizBSuY8DAwVLdcvTRa+UVvM+HGULKU6LVD2t1M4/4Dno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115739; c=relaxed/simple;
	bh=TlbvO2k3UpVXutnygaPHYW5d2mu5CnyVqpcsQ3yVq3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uu9CEbihZ2knP2iW+sDkwv09bBifBuCMdGwk5Obh9v22dd9qxUHAz8chZcJeIepNYON1ORdXyWHPw5035beWfe3iBnM3MRroWP+Arr6+cI17ILR6aQiw8zWGU5AbcYVu6yjXgh6V5Ep9CykpeecQSKGF67h5SSbu4ehCaDkzRsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hIw6GNNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835D5C4CEE5;
	Tue,  8 Apr 2025 12:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115738;
	bh=TlbvO2k3UpVXutnygaPHYW5d2mu5CnyVqpcsQ3yVq3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIw6GNNSpsUA6TUwoCHntSFrJ3FYx5DU66YYopiMuRn1TfAVlOvVjbt3q5I2SjHgu
	 9uXA87wESbP2tSKFRr0jJrfUCqCZCh/0pMa14uZdD/frXLuCEv/vLubSCygp8CDVLO
	 5mBbXG8KKUJm2aPOYwgcO0WsalkCmoZti54Fnoiw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 087/204] soundwire: slave: fix an OF node reference leak in soundwire slave device
Date: Tue,  8 Apr 2025 12:50:17 +0200
Message-ID: <20250408104822.908221204@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

[ Upstream commit aac2f8363f773ae1f65aab140e06e2084ac6b787 ]

When initializing a soundwire slave device, an OF node is stored to the
device with refcount incremented. However, the refcount is not
decremented in .release(), thus call of_node_put() in
sdw_slave_release().

Fixes: a2e484585ad3 ("soundwire: core: add device tree support for slave devices")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20241205034844.2784964-1-joe@pf.is.s.u-tokyo.ac.jp
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/slave.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index c1c1a2ac293af..28b0d7b6d780c 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -12,6 +12,7 @@ static void sdw_slave_release(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 
+	of_node_put(slave->dev.of_node);
 	mutex_destroy(&slave->sdw_dev_lock);
 	kfree(slave);
 }
-- 
2.39.5




