Return-Path: <stable+bounces-83639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1890A99BA08
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 17:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C3F1F21774
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64013146A83;
	Sun, 13 Oct 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DMcV1Khs"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA9146A63
	for <Stable@vger.kernel.org>; Sun, 13 Oct 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728833224; cv=none; b=qzUUIdX3OWZ018GqeoYbS2bKxKZ7qPLQD+u1q5y9cct35IF/1Qex8DpboietGIGuolBlL/j12IBCiQFs9XkclAT/4vP3WoMNU0u2IxIIg1N/4TJorQCMBXwHnP5Ah1kcpWgui6tn4qMjcef6u1r4TWCDM7wOWZUq+wuWjynZ4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728833224; c=relaxed/simple;
	bh=AE/syUmKoopWkxTsdjvGjQYAcTnKENqrMQ6BY8GNqfs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=VEGxQQ9H0qVW7xB8DOs4VDevxG3i39zcfnHx8TDYwPXazRjblePjQb65R7aL0no8cahde1Bwl9SxGbXOdRigNLv/LOOLnv5tryTmy8kkYfr+2NC7BHMpQ53Ujh3BKWMnLvPCxp8vxzG3gHDkaXxHc4mB3+hEJzHQi3iIpqgiwCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DMcV1Khs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9574CC4CEC5;
	Sun, 13 Oct 2024 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728833224;
	bh=AE/syUmKoopWkxTsdjvGjQYAcTnKENqrMQ6BY8GNqfs=;
	h=Subject:To:From:Date:From;
	b=DMcV1KhsZebkBuaMK8ixG7JP51WGe6V1H0eQ/vqkfWRsLe9OViNDcV+DMnk5l4NQZ
	 CI6JdONZQPgt5Ct5v10eNgLao14qivNvG8El7GovbKwncL/qCC2WQ/NtnUjPn5Dhgt
	 oWRsjGP5NHdyYcIQfp60OnII2PH1uK1dXo+AIwwU=
Subject: patch "iio: pressure: bm1390: add missing select IIO_(TRIGGERED_)BUFFER in" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,mazziesaccount@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Oct 2024 17:26:03 +0200
Message-ID: <2024101302-reappear-clothes-03ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: pressure: bm1390: add missing select IIO_(TRIGGERED_)BUFFER in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 3f7b25f6ad0925b9ae9b70656a49abb5af111483 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 3 Oct 2024 23:04:58 +0200
Subject: iio: pressure: bm1390: add missing select IIO_(TRIGGERED_)BUFFER in
 Kconfig

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Note the original driver patch had wrong part number hence the odd fixes
entry.

Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Link: https://patch.msgid.link/20241003-iio-select-v1-12-67c0385197cd@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index df65438c771e..d2cb8c871f6a 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -19,6 +19,9 @@ config ABP060MG
 config ROHM_BM1390
 	tristate "ROHM BM1390GLV-Z pressure sensor driver"
 	depends on I2C
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z
 	  can measure pressures ranging from 300 hPa to 1300 hPa with
-- 
2.47.0



