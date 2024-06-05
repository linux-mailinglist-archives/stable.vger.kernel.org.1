Return-Path: <stable+bounces-48247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C09F8FD7AA
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 22:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD17E1F2293F
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 20:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6CA15EFD2;
	Wed,  5 Jun 2024 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="WxF2pQrt"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5B115ECCE
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619962; cv=none; b=CP1NUaApByNx8stSX/UJay4+deECfmbCEoQ20qXJhBHPCCzk9MXD4zxDCFXO5QPtCCol3mqtELzZkUrYseHhg7jbqvC3Kr+MRk/OXjxi1gkbYXUHORG2Aq0E/uOsHbfXnF4U0QS5She8Fr/fiDVZvdXgMRJ46AidH4sv7NJyyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619962; c=relaxed/simple;
	bh=233oG5xUK7SuJpEz5bpfFqT88xSxywiU7rud3W8ItHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYOJxCK8osxbqCcg5Ol2de/ey5fytbcwVg8PiCoioLRWHpGmEbbPECN6wsXf+/ZG/sb8zQQ++uuRyWBmvlW313VLj9MA7rnxKQp6XsaUcixqGH1h0hfnTmK+DX9qeC+wUx7rR6JVbsmUWaZZswOUyHxOQCPbPTxrHCGoEdBLST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=WxF2pQrt; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240605203909bdff20e02193659703
        for <stable@vger.kernel.org>;
        Wed, 05 Jun 2024 22:39:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=36a9haa92rcYKejOFZkkfO6S9F0ysy3Ksd61cqJUYo4=;
 b=WxF2pQrtzkG6CruCQuSMqaG5i15RmDfkQ24UER8x4exZRODJIqy5zfRlF5PWKWa1fCPOCt
 ySh7hwE3AJ5Cix767fRZ2rP2FDv6X19qIMJLm5Pp+jhADwHJTOopf5DUDbhGKGSMsaxMv+qf
 7/d0FQgqJsW2noX48ZkWkkWUlXpiE=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-iio@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: accel: fxls8962af: select IIO_BUFFER & IIO_KFIFO_BUF
Date: Wed,  5 Jun 2024 22:38:06 +0200
Message-ID: <20240605203810.2908980-2-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Provide missing symbols to the module:
ERROR: modpost: iio_push_to_buffers [drivers/iio/accel/fxls8962af-core.ko] undefined!
ERROR: modpost: devm_iio_kfifo_buffer_setup_ext [drivers/iio/accel/fxls8962af-core.ko] undefined!

Cc: stable@vger.kernel.org
Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/iio/accel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index c2da5066e9a7b..80b57d3ee3a72 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -330,6 +330,8 @@ config DMARD10
 config FXLS8962AF
 	tristate
 	depends on I2C || !I2C # cannot be built-in for modular I2C
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 
 config FXLS8962AF_I2C
 	tristate "NXP FXLS8962AF/FXLS8964AF Accelerometer I2C Driver"
-- 
2.45.2


