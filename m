Return-Path: <stable+bounces-75925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6A7975EBE
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 04:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBCA1F239D2
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 02:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DD52BB0D;
	Thu, 12 Sep 2024 02:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NVMuGZ4R"
X-Original-To: Stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71936124;
	Thu, 12 Sep 2024 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726106803; cv=none; b=ldDXZrICGzzuMzXNQRUNV2xUB1kPAcMFlEe9MU5K/wCq22IenK6ifEr0UFDxg/xja1kazVS+LoF7vzXn8AYG6SVj1ycIqghON4VAiOSg5HLPvj+FGXU/QkKZ8KIj02VPJkGVEhBRTE5HzRBcl9Sq4DreYsMLxjqJg/X7NiO7KHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726106803; c=relaxed/simple;
	bh=lcTGTwTw5cn/lT3/O97HzKGFL1apdMiIttef1zFzkro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1iwegQgDEycZxVyH0dtLZ3rMHk8QwJCfKs5TFET1Bgn/XCyNOcbA8/vZ54VGnBYxZAf8ckzPigP9wPcNr0l3NWGd2nq50IKazhEj458q/fhn22VS20EGBZb9krzAab4+QlAYGa8GB33Z6gW+EWpEBDP/aWtaQuaVgMkROhAoBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NVMuGZ4R; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726106696;
	bh=BupfmPkbDZp4lpA1mX4IYy1smh7LbZ8XKFhc9xdT49o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NVMuGZ4Rc1jNtmWhg3zq6ZdMri0W45DIlLApfKpSPPK34+xZ1rLeBu3LzH1pB7RZt
	 5xg4TNWcbedyFZao1X6LrY4/RE9i/+KpdEoaZyrx0C6r572EwhRGNER7vnpRwQNhTT
	 bZuG5Ho+vhERTY5s/X1MfH4KsxOJtOPR65aHFp2I=
X-QQ-mid: bizesmtpsz5t1726106692tc37vzo
X-QQ-Originating-IP: EGKS6n79cKGacf3XYCwZw+6RXYSIdqYWMMNg6um0sQE=
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Sep 2024 10:04:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11355534066005636115
From: He Lugang <helugang@uniontech.com>
To: stable@vger.kernel.org
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	He Lugang <helugang@uniontech.com>
Subject: [PATCH 6.6.y RESEND 2/2] iio: adc: ad7124: fix DT configuration parsing
Date: Thu, 12 Sep 2024 10:04:39 +0800
Message-ID: <26EE05022C8AFE3E+20240912020439.127704-2-helugang@uniontech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912020439.127704-1-helugang@uniontech.com>
References: <2024090914-province-underdone-1eea@gregkh>
 <20240912020439.127704-1-helugang@uniontech.com>
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

commit 61cbfb5368dd50ed0d65ce21d305aa923581db2b upstream

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


