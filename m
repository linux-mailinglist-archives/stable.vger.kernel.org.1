Return-Path: <stable+bounces-143569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDA5AB4076
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF5F7B3375
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5DA296155;
	Mon, 12 May 2025 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="APNGjZgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369DA1A08CA;
	Mon, 12 May 2025 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072378; cv=none; b=g0pwAH7e81vZiXn3NVVZaf/5jsHAkOgzBH6R7m0F2STShKYcYYl4PRciISjDF9OepVeRlcTRPMjuRaZYDGb8RFKmf5RFz4IoSfHT5Ydff55p7Gnt+yRp+7rsUiCmkJKixdmxLjldGGtm6fSZm0wpZ+W9D8eUWDcOaKoaRCtBT2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072378; c=relaxed/simple;
	bh=zNrPOHK0VPM3lxnBAPUwYCYxalhpWpaIJPgIUOuYnuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiDdMZ9b2FWY/a4zf6tX8qLQqHwl1+DzYyW7QXbfAP+s7XdIKgDSeGPI/k7W+VznKqzZqltoJ7Q8BdIfBlqzmM3jql1fL7BQCTZoHs5Xa+9n/puntuof9VL4b+zcDKI8C263T6jYBdm5p+N0+EgIJzC/1f56uQKUwH62KJlD++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=APNGjZgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97892C4CEE7;
	Mon, 12 May 2025 17:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072378;
	bh=zNrPOHK0VPM3lxnBAPUwYCYxalhpWpaIJPgIUOuYnuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=APNGjZgg1dIH2ezrVzxgvGOatocmxImMtLJVjW6S1nDHo5zjB8O4KriKalexDwEw0
	 No642wtVnZbIm0XxukdbV9FiAkYAw5ervLEhSsMf+F4GcBHX/ZAcC0UoAK1rRgtnb8
	 t2yKIMDFqbmqt3n401etrhFd/GPOzMtXj3l43AzA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 21/92] net: dsa: b53: always rejoin default untagged VLAN on bridge leave
Date: Mon, 12 May 2025 19:44:56 +0200
Message-ID: <20250512172023.984151704@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172023.126467649@linuxfoundation.org>
References: <20250512172023.126467649@linuxfoundation.org>
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

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit 13b152ae40495966501697693f048f47430c50fd ]

While JOIN_ALL_VLAN allows to join all VLANs, we still need to keep the
default VLAN enabled so that untagged traffic stays untagged.

So rejoin the default VLAN even for switches with JOIN_ALL_VLAN support.

Fixes: 48aea33a77ab ("net: dsa: b53: Add JOIN_ALL_VLAN support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20250429201710.330937-7-jonas.gorski@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index bffd23ff6e134..9d410c21416f9 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1958,12 +1958,12 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 		if (!(reg & BIT(cpu_port)))
 			reg |= BIT(cpu_port);
 		b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, reg);
-	} else {
-		b53_get_vlan_entry(dev, pvid, vl);
-		vl->members |= BIT(port) | BIT(cpu_port);
-		vl->untag |= BIT(port) | BIT(cpu_port);
-		b53_set_vlan_entry(dev, pvid, vl);
 	}
+
+	b53_get_vlan_entry(dev, pvid, vl);
+	vl->members |= BIT(port) | BIT(cpu_port);
+	vl->untag |= BIT(port) | BIT(cpu_port);
+	b53_set_vlan_entry(dev, pvid, vl);
 }
 EXPORT_SYMBOL(b53_br_leave);
 
-- 
2.39.5




