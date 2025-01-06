Return-Path: <stable+bounces-107405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A850AA02BDC
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3303A176C
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D1E13B592;
	Mon,  6 Jan 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oy6T7swS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08621DE4C7;
	Mon,  6 Jan 2025 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178365; cv=none; b=ryrl4AYKyZ5Wulx+ZpQLMSeGSGu2VVHSniZYm6LDCtaC01fGPkPWpH4G0u50StC+5/2pmAY9iWiE4jF3t9bpw8ZGlCqzC5EBYloLSfT6+P2Q+pcIFWGuf12WiNOkOUDrBhfZPUnQMID3fuzXdDugoW/wMvYYAZKXfZXTMy/PAog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178365; c=relaxed/simple;
	bh=um6bsh4EH+WwIldYpJO8w7M+DkMMivOi7+eeABMLYKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FiinXl0wifkhcMXVGm2zUX7yzKbLyMTuoGTL+wkZ4C4F06gi25YjbvLg3Q8jJCZ3XxQxH/mduKOm3k+mK0cKzQCJWJc9QnXmqpnK6glP8190TvHFDFU6anNyMnWnTMSQCKoQSE0cwSwSM2Am6p2Srib8Aek12SfU2ht7m+qE4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oy6T7swS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B61EC4CED2;
	Mon,  6 Jan 2025 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178364;
	bh=um6bsh4EH+WwIldYpJO8w7M+DkMMivOi7+eeABMLYKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oy6T7swSamoYdwzI3504Fm1b9AbyOAe1sPfKVEu7g3Ve6Q27wRkZZJ+IGYU/O417b
	 PYWrsB+LWYMvVdf85L039QuE6RP2P3fBcOXuj9zxLXnYsbh/vjsZOIcbi0sI2I6pcI
	 i4vYCAk+Z0hIBEiHHbsTPwChb+c/GF7YY2Wvp3OE=
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
Subject: [PATCH 5.10 052/138] phy: core: Fix that API devm_phy_put() fails to release the phy
Date: Mon,  6 Jan 2025 16:16:16 +0100
Message-ID: <20250106151135.205103339@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -620,7 +620,7 @@ void devm_phy_put(struct device *dev, st
 	if (!phy)
 		return;
 
-	r = devres_destroy(dev, devm_phy_release, devm_phy_match, phy);
+	r = devres_release(dev, devm_phy_release, devm_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_phy_put);



