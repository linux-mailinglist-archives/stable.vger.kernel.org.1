Return-Path: <stable+bounces-160206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F16AF9588
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 16:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529963A1BC1
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4ED1B532F;
	Fri,  4 Jul 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O7GuKtMz"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D83119F115
	for <Stable@vger.kernel.org>; Fri,  4 Jul 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751639483; cv=none; b=ZDl0f040O281Ucwl5ug5DzgBc9N/vSheDJT9xZIXHjEo232MmG9TXrW0npzK0iiVgz4oe8d9IylYNUc/VjE+lUDb2cKfgY/pnsQYVHlIiOgBgKO+5ke8fszgKupjqt1OXZ8nDs+k3bo/wmnK7AGw+/jDJyeFDm+wXmCkFXc71t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751639483; c=relaxed/simple;
	bh=kC1/TDZuSv9b5lF4s9dUfsLymHH6kBcQPukbDFNPC8U=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Y9bjS/rrVPIQNJalYRaV0HWGAM7dikoBGgSr6R4qDjU+CJHj9biO7KYQ3Pma4bbk65VA+uJUbLz0vcB6je1naEjrdRaFnjVkqbU3DtfOkTV1CT1fmZfSrw3iI71G19fjpcKtpKD/0XkcvAwM7MXHewln8xpGoPy6V1KwXjLn9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O7GuKtMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B41C4CEE3;
	Fri,  4 Jul 2025 14:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751639483;
	bh=kC1/TDZuSv9b5lF4s9dUfsLymHH6kBcQPukbDFNPC8U=;
	h=Subject:To:From:Date:From;
	b=O7GuKtMzLUN63Ykq5AKpCEMlxyeiWGkY4JqQqX5hf6IYhptHNdWrSJFe7I5iMzDZH
	 OJu3B9h9pfGfz/dg6T6w8IJvP1sgtacLyh6rshk7mo64mP+BRQe0QVCeZ80+2b0IHt
	 8FaowNbjboM2qFTDMTd5aWnfBscxLKSgQ63Smf6M=
Subject: patch "iio: adc: ad7380: fix adi,gain-milli property parsing" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Jul 2025 16:30:51 +0200
Message-ID: <2025070451-automaker-unrevised-32d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7380: fix adi,gain-milli property parsing

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 24fa69894ea3f76ecb13d7160692ee574a912803 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Jun 2025 10:24:22 -0500
Subject: iio: adc: ad7380: fix adi,gain-milli property parsing

Change the data type of the "adi,gain-milli" property from u32 to u16.
The devicetree binding specifies it as uint16, so we need to read it as
such to avoid an -EOVERFLOW error when parsing the property.

Fixes: c904e6dcf402 ("iio: adc: ad7380: add support for adaq4370-4 and adaq4380-4")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250619-iio-adc-ad7380-fix-adi-gain-milli-parsing-v1-1-4c27fb426860@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7380.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index d96bd12dfea6..cabf5511d116 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1953,8 +1953,9 @@ static int ad7380_probe(struct spi_device *spi)
 
 	if (st->chip_info->has_hardware_gain) {
 		device_for_each_child_node_scoped(dev, node) {
-			unsigned int channel, gain;
+			unsigned int channel;
 			int gain_idx;
+			u16 gain;
 
 			ret = fwnode_property_read_u32(node, "reg", &channel);
 			if (ret)
@@ -1966,7 +1967,7 @@ static int ad7380_probe(struct spi_device *spi)
 						     "Invalid channel number %i\n",
 						     channel);
 
-			ret = fwnode_property_read_u32(node, "adi,gain-milli",
+			ret = fwnode_property_read_u16(node, "adi,gain-milli",
 						       &gain);
 			if (ret && ret != -EINVAL)
 				return dev_err_probe(dev, ret,
-- 
2.50.0



