Return-Path: <stable+bounces-143942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D6AAB42E1
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B9418861B1
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CEC1D7E5B;
	Mon, 12 May 2025 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZIjXsSi8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56251299A9A;
	Mon, 12 May 2025 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073366; cv=none; b=lpqJ+8SCDcs/mAP8u4ab1KWy9rH3CQy590y85n5PphCMIMJXnIZTJFb1WdtrcraPv2MHRo81tXK7wvml7mPmmv3X/ZWZUu3cNxcGNQeZyZMvmZ+fIyd7tiwkyfBNYXiJEToU6TH/g6lDJd4fyw8QQ9JVnThNRnZ5Kk1oPhocTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073366; c=relaxed/simple;
	bh=JvNE5xeBftyKgKjgql5aFo9lBEbGUZxgI6eyZddoiRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=co9ngyR2vqLInbZpWsq3KHE6Zi+gduSg110QTfQwCv3RI8IzxSeoiLNqIpGrohGBtyn5htVemnp/u3RSSCmni8actn6XPDl/hXJfDImZz+AVc4UjI5nUtFFsp2k9lPuq8a+4GarW8JkfxQT/l3nc5F4muHizHcX5u7vegNfMbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZIjXsSi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F02C4CEE7;
	Mon, 12 May 2025 18:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073365;
	bh=JvNE5xeBftyKgKjgql5aFo9lBEbGUZxgI6eyZddoiRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIjXsSi86Cqc2LqmC3pUFn+wL5Ec5q6COJOdMz26IW8lbXMmV/esPVYbYgLvyoOJt
	 2Ckht0l0Hnycycah8L16fMtcXeiJKrjWQZdchR43Ng8ANJI0uOZCMI0QC3YCo4/dqe
	 NHxA+T6AsR7Vz3UxUIut2lz+kXVR1/l5elEw9tHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 022/113] net: dsa: b53: fix flushing old pvid VLAN on pvid change
Date: Mon, 12 May 2025 19:45:11 +0200
Message-ID: <20250512172028.586601962@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172027.691520737@linuxfoundation.org>
References: <20250512172027.691520737@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit 083c6b28c0cbcd83b6af1a10f2c82937129b3438 ]

Presumably the intention here was to flush the VLAN of the old pvid, not
the added VLAN again, which we already flushed before.

Fixes: a2482d2ce349 ("net: dsa: b53: Plug in VLAN support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20250429201710.330937-5-jonas.gorski@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 584de37a61c76..55893d4e405e8 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1555,7 +1555,7 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	if (!dsa_is_cpu_port(ds, port) && new_pvid != old_pvid) {
 		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port),
 			    new_pvid);
-		b53_fast_age_vlan(dev, vlan->vid);
+		b53_fast_age_vlan(dev, old_pvid);
 	}
 
 	return 0;
-- 
2.39.5




