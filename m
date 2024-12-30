Return-Path: <stable+bounces-106365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC809FE807
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC8160581
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AD31537C8;
	Mon, 30 Dec 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MOc+X4+u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B82AE68;
	Mon, 30 Dec 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735573723; cv=none; b=ot9iER6NFEtAk6yELALp11T+iHROm39gDiXTaozFvHKESCFSSaG4oRHj1H8BK+tq453VP6vEliMYprSCKwO1cHi6Gv7OjsJPifEXprtPZ+wAdWyNqBX2dlGZ7aNdl/loA1KtJ8THphx6I02KPYy+w38Rpu7S7zFYjoTbRKRLQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735573723; c=relaxed/simple;
	bh=ynsGoMSVz+3sdMdU2GCdW64KVCewY5JfqsB0ootUTjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gi7WIEUgIQExPMa6j5lJx5WxvdctfMYZ1294s5+DhK1PAyY3UJQCkcGXS5CC0tZDAH1s+OCh5ZRXi+BugC20fBqbiYTrNYYlMn8nTVRZc5+0zj6cQiTTvBLInpNJEmQtIHa8kD3ChG9zCNRiR4hDD7ILtvxJK832V81vAWU7DFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MOc+X4+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93237C4CED0;
	Mon, 30 Dec 2024 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735573723;
	bh=ynsGoMSVz+3sdMdU2GCdW64KVCewY5JfqsB0ootUTjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOc+X4+ubokol00t2C7WII20TAQ7QexS6fniFR8Wgl930FN52E2E6bdBA41F1D1vE
	 8xBJrhfiVzwvuvW8l6pV/1YdlA70ICvXzkMi7cDHUVumdx5ZYOHHKLi+EoPi+BTunm
	 rOnzBaTPdc79nvI2cZ5edIM2/bvx3I1ad+4W/quI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.6 17/86] phy: core: Fix that API devm_phy_put() fails to release the phy
Date: Mon, 30 Dec 2024 16:42:25 +0100
Message-ID: <20241230154212.376791402@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154211.711515682@linuxfoundation.org>
References: <20241230154211.711515682@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

commit fe4bfa9b6d7bd752bfe4700c937f235aa8ce997b upstream.

For devm_phy_put(), its comment says it needs to invoke phy_put() to
release the phy, but it will not actually invoke the function since
devres_destroy() does not call devm_phy_release(), and the missing
phy_put() call will cause:

- The phy fails to be released.
- devm_phy_put() can not fully undo what API devm_phy_get() does.
- Leak refcount of both the module and device for below typical usage:

  devm_phy_get(); // or its variant
  ...
  err = do_something();
  if (err)
      goto err_out;
  ...
  err_out:
  devm_phy_put(); // leak refcount here

  The file(s) affected by this issue are shown below since they have such
  typical usage.
  drivers/pci/controller/cadence/pcie-cadence.c
  drivers/net/ethernet/ti/am65-cpsw-nuss.c

Fix by using devres_release() instead of devres_destroy() within the API.

Fixes: ff764963479a ("drivers: phy: add generic PHY framework")
Cc: stable@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Krzysztof Wilczyński <kw@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20241213-phy_core_fix-v6-1-40ae28f5015a@quicinc.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/phy-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -690,7 +690,7 @@ void devm_phy_put(struct device *dev, st
 	if (!phy)
 		return;
 
-	r = devres_destroy(dev, devm_phy_release, devm_phy_match, phy);
+	r = devres_release(dev, devm_phy_release, devm_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_phy_put);



