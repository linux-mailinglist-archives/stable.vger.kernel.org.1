Return-Path: <stable+bounces-109128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A873A12260
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 12:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB5A16A93E
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0A91E7C27;
	Wed, 15 Jan 2025 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="l4HCJsNt"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59C248BA4
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940059; cv=none; b=KDomz93I1kTZH/fGgRaLSRnfhrufp7VABGFZseXhpKTJ1AGJzwcgy/f2jC7RRaxhIXorgRa44Ire9opxpDsP7WcJtTzj/+5eOiDml2q2zz+J8U28XuQL2cBmqTFdtzNUBE1kgwqrtDbLRa2wxo1cur3bq3dCPsYRd2/CTKhvQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940059; c=relaxed/simple;
	bh=rV/e7tTFiS5l3l+P+Yoatvor7lHmI1Tlly63upaTiR4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ndRu2qc2R3lznv8mVYlbddWXTPnQU/fKcdR9LzI2xiFb2uLhlvaVSMzDsTXjvgz7/Ph/KIcnBaBVX4JV+Pl/8JR6FHBpiwSjKM0/ZIUqyZ4Y0EPxvXWE6LQkXj2rG9bfAXagjZLPHQGeNPgn5FpITpybQ1mql0gRCxFyAZvOtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=l4HCJsNt; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736940050; bh=NMinsTC3QldCmAAktAz6+DtG7g8CZInMB+0LwVc9UUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l4HCJsNtOuUYwZhhGtEnurYCJaY0g/l/h5a/uuEHsI62QPMrp72gVZON2oK2bblUS
	 pX8HIIfFrf4vlkOGigkCZwDzaln+fNuEmSYm2y5BJjaecl21N9CXgewfw/te0ke035
	 6J/YsIn7GnLgTnn26zlD7u3vzz0H/In7kEpufO1c=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.130])
	by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
	id 5263D2EB; Wed, 15 Jan 2025 19:20:38 +0800
X-QQ-mid: xmsmtpt1736940038td6y6kvwo
Message-ID: <tencent_72F5138E2C8C53C3392D4E4DF0C796A48006@qq.com>
X-QQ-XMAILINFO: Ntt/5q+SsafOXjC8ebRc5VHI0z3J9PZVpl9rfaX4zlnEUD7kgK9kag0mqfEHnv
	 f0qwJZ4vRRUoSmEmJX5GLn4zsEiNtz5nELvEk10x5hbKu3JqmCdUwmT9bU6anpNSwq6kNNnuyFOK
	 qPJDsNWjWJrbkiGWNtBYVnxNPMzjr0rPTPAuAJ3B3DN/2pQfXa+Ajv+uSCJMeqGAG0pbFKEmMBuT
	 YtFCInor2mREbEi68MgsE+ic3K2fsp/6Wn8gu2FhLelhMNQu91HJMwU4Dsz6+E8G6WVb9CheEKhh
	 k5LtEqQHwfwLWkPGvER1+wzo3FVvJ+SxDOUBGdGrXD3R1TY8jIBdVmNUvkzHKy8bNRM7HYbkT2R7
	 rwNcYjR/4WMkCzRlwHzogRcvAMz0rETAkLPY3BTumvEl/RvTLPMk3byDz285sZEkEZTrW0+YF0Tb
	 swpDcGM8AKX1tq97jgfHmlriADq1lliRdfXy4Myfwcva4r+YwL58g1nz4bXrlzpB9UuTSwKc6CUB
	 iZbLLkSfM5F/0F6AOgDNmPj+x/X7LUwlFfzKYpxM5QiakQDsri6uK6o2oUUE5J4uAyhpEAkoWwr2
	 48H4MfKTJjOvdKBlEMUBn1Nxq/14IZICJ/ZAu+ONG9tpv0QrHJXsyUkmDdLSwxNr5F7eNvTY6bFb
	 o6budQrPMXPiZcsCgUTvuB9jF6lE+gujhnWuDW0Rp3LtYEeMDkFbnG7wwCKz+L1REcq6WC86EBTN
	 vBtF55tw79q2rquhe/8RhScip1C4sR+hbIsOuZQf4kbCTd8I9IviVt+8gsQgsvFFpWEnWpVjvsqE
	 MbBjlN2YFQCgmtuJ2cv/SJGjf5BMWE3KgWYM8z6W6SfXujxK9JtrB+E3SECnT2GCZR++X1retND2
	 BVdlHMiui42p3vydKdXLMU/4YVMrux2Yfv8K4/SkCaMeVcFh/Tzr83RJ9q7sEA7aJL5olYrIhksX
	 FtRADj9Hdgoi3cKkppXVlAr4nO8stsDipX38EEanVGIalKULLLkRd9E35yvNCk2AAVG4prE58PPR
	 ttDxgATKAteUEG10fF
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: lanbincn@qq.com
To: stable@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bin Lan <lanbincn@qq.com>
Subject: [PATCH 5.15.y] iio: adc: rockchip_saradc: fix information leak in triggered buffer
Date: Wed, 15 Jan 2025 19:20:38 +0800
X-OQ-MSGID: <20250115112038.1958-1-lanbincn@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025011310-spider-motor-0ef7@gregkh>
References: <2025011310-spider-motor-0ef7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit 38724591364e1e3b278b4053f102b49ea06ee17c upstream.

The 'data' local struct is used to push data to user space from a
triggered buffer, but it does not set values for inactive channels, as
it only uses iio_for_each_active_channel() to assign new values.

Initialize the struct to zero before using it to avoid pushing
uninitialized information to userspace.

Cc: stable@vger.kernel.org
Fixes: 4e130dc7b413 ("iio: adc: rockchip_saradc: Add support iio buffers")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241125-iio_memset_scan_holes-v1-4-0cb6e98d895c@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit 38724591364e1e3b278b4053f102b49ea06ee17c)
Signed-off-by: Bin Lan <lanbincn@qq.com>
---
 drivers/iio/adc/rockchip_saradc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index a237fe469a30..3197fd2b3aad 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -270,6 +270,8 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
 	int ret;
 	int i, j = 0;
 
+	memset(&data, 0, sizeof(data));
+
 	mutex_lock(&i_dev->mlock);
 
 	for_each_set_bit(i, i_dev->active_scan_mask, i_dev->masklength) {
-- 
2.43.0


