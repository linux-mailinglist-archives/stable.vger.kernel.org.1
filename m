Return-Path: <stable+bounces-122523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B5FA5A012
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67AB018915CB
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6589E234966;
	Mon, 10 Mar 2025 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OyNghs+v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A12343C2;
	Mon, 10 Mar 2025 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628738; cv=none; b=M4yyzLn9lmi58LBijyusHodJ724sJwEgHvmekTZG6x6M0I/9mkDVkZOXrtuQwg5NYCfmK8fP77z9/O8oKo8is8PJS1gwIy+8lGwaoVzCeFndLXyiEgkgcULSygwyLvkMjBSdx22uQAxqYGoEh4sK3eNPnUP76Dr8ihy2vQuQIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628738; c=relaxed/simple;
	bh=PtGi4aJVD+4qKQkUMmQuHnu3ZQ53IHnAiiUa8oa6Lb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twzVMEefhExU5SiAPqx6WwvQCJeptc11vklJhqvumUbOTVONrgQRS+LGihxML7pdNAxJ39w4sUK4YaheQ8zugdfrfWYEgDe/nLtMHi/Lx6Ex7zSB03mMmn5UYs8tSG6kTGjmKk4AocEYyoky/+B+D9sURkhbx50WVyj4NhMeFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OyNghs+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246A5C4CEEC;
	Mon, 10 Mar 2025 17:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628737;
	bh=PtGi4aJVD+4qKQkUMmQuHnu3ZQ53IHnAiiUa8oa6Lb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OyNghs+v8Ovbort1jnNZOFEvyS0wpYXNeRSAIYo2Rv9l4/40dn2um/GAk2gyhpn+S
	 Z8W+jSDUpiIxeOe7TbVjdO8U8047pv/5+xeNTz5ezMSceJ+DPa0aslio/hZM6HElGw
	 Usxh2kO8z8hZDXeJxhgMTEvNdu7Vt/0OVxVUpZH0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 052/620] leds: netxbig: Fix an OF node reference leak in netxbig_leds_get_of_pdata()
Date: Mon, 10 Mar 2025 17:58:18 +0100
Message-ID: <20250310170547.631071469@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

[ Upstream commit 0508316be63bb735f59bdc8fe4527cadb62210ca ]

netxbig_leds_get_of_pdata() does not release the OF node obtained by
of_parse_phandle() when of_find_device_by_node() fails. Add an
of_node_put() call to fix the leak.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: 9af512e81964 ("leds: netxbig: Convert to use GPIO descriptors")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20241216074923.628509-1-joe@pf.is.s.u-tokyo.ac.jp
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-netxbig.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index 77213b79f84d9..6692de0af68f1 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -440,6 +440,7 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 	}
 	gpio_ext_pdev = of_find_device_by_node(gpio_ext_np);
 	if (!gpio_ext_pdev) {
+		of_node_put(gpio_ext_np);
 		dev_err(dev, "Failed to find platform device for gpio-ext\n");
 		return -ENODEV;
 	}
-- 
2.39.5




