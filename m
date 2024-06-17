Return-Path: <stable+bounces-52370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7FA90AB11
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 12:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFB4281EA5
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF9C194AC9;
	Mon, 17 Jun 2024 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNrjMyKs"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B73E194A42
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620165; cv=none; b=onWxK8Icb+tp93g5qjFGIhh6GFuvvnsTSDl+DbLgHGaJNch7vVvytx5hbUxseOHRtokDt66CqGIRbXt3I7DymutJH5rriMnb0m7l24mK9YCgpKIXAgdsnTlIgONozsWjCB2cXsscETGwY3U1Zb24Ml/HJcORwo1v6bQBOszNQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620165; c=relaxed/simple;
	bh=f7swwUMUk17vjjx+uev+yMPnjzGgCHtMLFMwUcUfkr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Or8BF5dC4EziYP4OhiJnlVACBHvqRcjt1dOuRam9WcoEWKLRhfgtivUA8vf9IGdRNPufms2WOMigpjebH6ET5YuLBLU7efna4ETe4EWWm+IQ1j9asqCYtBYsX2p7jzRQEWAhcHzdJ9zS2Wjcpa/TNy/ueDtSjId/iv+QPI1EJPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNrjMyKs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718620162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1FUyctF7pqaFU0497LUN/9JXL84PlJqzX/VUt5AsG98=;
	b=JNrjMyKsqNIQIxqltMKf2IbnKHk9vWB4zEERU6jx0qGd+4IMH1zimsRghbHa3IgU1HRMYp
	0tIjkmySpj/+Y/lLOa8TKi2/jWPNopZ4fZsJiDQ9Jo92xC8ut3eZrdLuUEffyqe1L1WRva
	RotHqSoGb2jEEkWXoa+IDyjyPLQ4H3o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318--OKZ7eSUPl6bQ8KmEPZVQg-1; Mon,
 17 Jun 2024 06:29:17 -0400
X-MC-Unique: -OKZ7eSUPl6bQ8KmEPZVQg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 284731955DDF;
	Mon, 17 Jun 2024 10:29:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.164])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED1DC19560AE;
	Mon, 17 Jun 2024 10:29:08 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jtornosm@redhat.com,
	stable@vger.kernel.org,
	Yongqin Liu <yongqin.liu@linaro.org>,
	=?UTF-8?q?Antje=20Miederh=C3=B6fer?= <a.miederhoefer@gmx.de>,
	Arne Fitzenreiter <arne_f@ipfire.org>
Subject: [PATCH] net: usb: ax88179_178a: improve reset check
Date: Mon, 17 Jun 2024 12:28:21 +0200
Message-ID: <20240617102839.654316-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

After ecf848eb934b ("net: usb: ax88179_178a: fix link status when link is
set to down/up") to not reset from usbnet_open after the reset from
usbnet_probe at initialization stage to speed up this, some issues have
been reported.

It seems to happen that if the initialization is slower, and some time
passes between the probe operation and the open operation, the second reset
from open is necessary too to have the device working. The reason is that
if there is no activity with the phy, this is "disconnected".

In order to improve this, the solution is to detect when the phy is
"disconnected", and we can use the phy status register for this. So we will
only reset the device from reset operation in this situation, that is, only
if necessary.

The same bahavior is happening when the device is stopped (link set to
down) and later is restarted (link set to up), so if the phy keeps working
we only need to enable the mac again, but if enough time passes between the
device stop and restart, reset is necessary, and we can detect the
situation checking the phy status register too.

cc: stable@vger.kernel.org # 6.6+
Fixes: ecf848eb934b ("net: usb: ax88179_178a: fix link status when link is set to down/up")
Reported-by: Yongqin Liu <yongqin.liu@linaro.org>
Reported-by: Antje Miederhöfer <a.miederhoefer@gmx.de>
Reported-by: Arne Fitzenreiter <arne_f@ipfire.org>
Tested-by: Yongqin Liu <yongqin.liu@linaro.org>
Tested-by: Antje Miederhöfer <a.miederhoefer@gmx.de>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/usb/ax88179_178a.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 51c295e1e823..c2fb736f78b2 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -174,7 +174,6 @@ struct ax88179_data {
 	u32 wol_supported;
 	u32 wolopts;
 	u8 disconnecting;
-	u8 initialized;
 };
 
 struct ax88179_int_data {
@@ -1678,12 +1677,21 @@ static int ax88179_reset(struct usbnet *dev)
 
 static int ax88179_net_reset(struct usbnet *dev)
 {
-	struct ax88179_data *ax179_data = dev->driver_priv;
+	u16 tmp16;
 
-	if (ax179_data->initialized)
+	ax88179_read_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID, GMII_PHY_PHYSR,
+			 2, &tmp16);
+	if (tmp16) {
+		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
+				 2, 2, &tmp16);
+		if (!(tmp16 & AX_MEDIUM_RECEIVE_EN)) {
+			tmp16 |= AX_MEDIUM_RECEIVE_EN;
+			ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
+					  2, 2, &tmp16);
+		}
+	} else {
 		ax88179_reset(dev);
-	else
-		ax179_data->initialized = 1;
+	}
 
 	return 0;
 }
-- 
2.45.1


