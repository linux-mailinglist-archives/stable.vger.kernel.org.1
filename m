Return-Path: <stable+bounces-195498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8CBC78C54
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 12:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDF9635F2A1
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 11:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489633D6D4;
	Fri, 21 Nov 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqZMuCt3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7919DFA2;
	Fri, 21 Nov 2025 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724288; cv=none; b=QUm7HZ03SezDqQM3cBAPtm/mp6CgkrasviP9Lvg/zjWKb3Os67lqN6+KnH+RuyTRW/DREuvwcSN7zooEn6hqhNKvqWF/Tov5JYo0H+Ag+gc8pVRiFEmozj3j9bk3VLulBRurQjfzrMwNYZCf1jZvpIs+U03RnjH/+1IJ3wq5heI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724288; c=relaxed/simple;
	bh=jdJtsYuqXaicdXVMWm0tMN7CbHJmNW9uyT/z2e52K9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nU/UbCbgORbHb0Z933uZpJHJIUdcKsGpaJ4O4bBkfhrZUAd+/W3Yw4iJAlrMEJ0Rx9WqZ32eRV5gxkoma32oIhkQUKmmwnM71m2U2GsmAs1oF0cqhK1hNQBt8ZAjxcOQpzjXRaEbcX7N8220M8Qd6x9KMFRlmNpVRIKhAEZZE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqZMuCt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06EAC113D0;
	Fri, 21 Nov 2025 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763724287;
	bh=jdJtsYuqXaicdXVMWm0tMN7CbHJmNW9uyT/z2e52K9A=;
	h=From:To:Cc:Subject:Date:From;
	b=eqZMuCt32a7QZcHGcPht9J7OwEn7F+vWIWM1O5mls7C8jmIGhmIEsGkcBUqkG3U2P
	 ZpPowEuh+eI4FvIINX4Fi0WaIuYiL2ImTF+7RzXvVIRQreMAxsJ1JpN1ocJQKPDh1o
	 24RXagSvQah4pNH1KAwXKcGjzY10qJrXhqOpHhOQA3U0KsfzHsPCQSqAmFr7Oi3eT5
	 7O9cdWcZw/rdDfzrkP6fZk+OxWmgUTHj/TNNgVW/SwVarbid560GhjxPYeL6NxDyoZ
	 gcis7khhLq62uflwoQYlIlNcFG55QvpumWePXPXpsn+dk2sThOoeBQHMy9yrr/d4oi
	 bq8U9AG5vQRZA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vMPFw-000000008Rv-0Pgw;
	Fri, 21 Nov 2025 12:24:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] drm/tegra: fix device leak on probe()
Date: Fri, 21 Nov 2025 12:24:32 +0100
Message-ID: <20251121112432.32456-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken when looking up the companion
device during probe().

Note that holding a reference to a device does not prevent its driver
data from going away so there is no point in keeping the reference.

Fixes: f68ba6912bd2 ("drm/tegra: dc: Link DC1 to DC0 on Tegra20")
Cc: stable@vger.kernel.org	# 4.16
Cc: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/tegra/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 59d5c1ba145a..7a6b30df6a89 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -3148,6 +3148,8 @@ static int tegra_dc_couple(struct tegra_dc *dc)
 		dc->client.parent = &parent->client;
 
 		dev_dbg(dc->dev, "coupled to %s\n", dev_name(companion));
+
+		put_device(companion);
 	}
 
 	return 0;
-- 
2.51.2


