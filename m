Return-Path: <stable+bounces-74150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E02C972CFF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88C41F2288A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF29F18787C;
	Tue, 10 Sep 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YKziGTvp"
X-Original-To: Stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C98187876;
	Tue, 10 Sep 2024 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959350; cv=none; b=CljzdKxTdbWbuh5Ugg4o6tFpAauPyrYGvBzJFSxl9OW3H8r6gPiEt/QFcTPPDTgCkjZ2R0zj9//m6NshAxRUks0Ewpefzrg65zQeXL7bT+AXw8zgWfHFSNWHx3u/0ikagPjhZnOAURjdACXKOv00TfnomQI6rdMeGQWCNRJGLxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959350; c=relaxed/simple;
	bh=nYyw/YN6EZAyj09lZKPT/wv+ocYh0Ku+GoSFMEwn2nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTkKQb4c5x6M+GkF52LEpzVxEFE7nrNpVWpqgEw6TkNHRHod1cOwUNKz9PB/7Ks9AVbp7yxWNpI+jIVsfmupE2TcHUAGg6PXhefaP/xGePHECj47zeZAP4PgREdQU1Clg53UPJSlgAJzg8Bn6oSF0PWaGYJSu5qZii4PuYbIGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YKziGTvp; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725959316;
	bh=QAR165oxzgmTxEyTDTIMWCB15VlrYJMEOz66RlBsthk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=YKziGTvpY01VxjnzZ5cvc8D4t3IG/zR35YYhv4kNUfiP2jCuBC5RENvm+tQOuFb1n
	 QW1XqoQsDwTanmW0DsrAgrG80pALhzuRMfUMEYH5f3UhjJ3dFGoJP2DCBlG+xYwmCt
	 NOncOqJvERCNhHcoCHctI2FW+pNL3d4Va40IRkCU=
X-QQ-mid: bizesmtpsz3t1725959311tprc3bx
X-QQ-Originating-IP: wLDPazBA2HEMIHbGBqbDNO4SwBEKT8zaRXg2JPvC404=
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Sep 2024 17:08:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1841444363657464560
From: He Lugang <helugang@uniontech.com>
To: stable@vger.kernel.org
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	He Lugang <helugang@uniontech.com>
Subject: [PATCH 6.6.y 2/2] iio: adc: ad7124: fix DT configuration parsing
Date: Tue, 10 Sep 2024 17:07:57 +0800
Message-ID: <0ACF46DADA3C2900+20240910090757.649865-2-helugang@uniontech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910090757.649865-1-helugang@uniontech.com>
References: <2024090914-province-underdone-1eea@gregkh>
 <20240910090757.649865-1-helugang@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0

From: Dumitru Ceclan <mitrutzceclan@gmail.com>

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

[ Upstream commit 61cbfb5368dd50ed0d65ce21d305aa923581db2b ]

The cfg pointer is set before reading the channel number that the
configuration should point to. This causes configurations to be shifted
by one channel.
For example setting bipolar to the first channel defined in the DT will
cause bipolar mode to be active on the second defined channel.

Fix by moving the cfg pointer setting after reading the channel number.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://patch.msgid.link/20240806085133.114547-1-dumitru.ceclan@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: He Lugang <helugang@uniontech.com>
---
 drivers/iio/adc/ad7124.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index e7b1d517d3de..089398a7664a 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -837,8 +837,6 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 	st->channels = channels;
 
 	device_for_each_child_node_scoped(dev, child) {
-		cfg = &st->channels[channel].cfg;
-
 		ret = fwnode_property_read_u32(child, "reg", &channel);
 		if (ret)
 			return ret;
@@ -856,6 +854,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
 
+		cfg = &st->channels[channel].cfg;
 		cfg->bipolar = fwnode_property_read_bool(child, "bipolar");
 
 		ret = fwnode_property_read_u32(child, "adi,reference-select", &tmp);
-- 
2.45.2


