Return-Path: <stable+bounces-72817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E54969A71
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2261F1C23505
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC71E1B9855;
	Tue,  3 Sep 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c3KeOBXD"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895A41B9851
	for <Stable@vger.kernel.org>; Tue,  3 Sep 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360129; cv=none; b=tSvJdSdtT28Zj+8MA9WTbYB5sXQQJ0/ezqf/rsvpx3QqmoI5WMKGdh//G70uoXu1qcDfQgppxX6ZjflYJ/5uugnwDJmZX1Kf/wWGGX8N3KPh5z8WP1Z9ygBthlCsRDesxx4B4vu0HGGBdkv3/COVOO3vQHA5c52kjNH6uQ4P0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360129; c=relaxed/simple;
	bh=ypnEIOP2ka04bAMZjhk7rL9gWEOKQBXVjTZ8bOSg2ks=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=m7ykkGmdbz3I3Rz/k9G+C30qS16aYJii7u6LY7cimNVQjfC1b29dAMtjBh7l9+84g2/X+3R6ztLyVpSWqCnPrHRCb/ctA1uvJKwp/ABsa5bgNxbaYtdTPKAWsHWLgc41eY1h0O0UGMkS00ywH17sPIfvmG831mJX49QRiA48m6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c3KeOBXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961FBC4CEC4;
	Tue,  3 Sep 2024 10:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360129;
	bh=ypnEIOP2ka04bAMZjhk7rL9gWEOKQBXVjTZ8bOSg2ks=;
	h=Subject:To:From:Date:From;
	b=c3KeOBXDMms2uKx8OK8YM2Hp6ie4G3d19AwNWfCC5HZiHVDQstvO4zGoJlXoMddGV
	 vto+6FJtRMK2fFG4zZ6GuBIdOMzUIpWo2/o7VLxgUouDzAM0uJZszg5sefRXTWjJ+h
	 fNs8lUBsRY8MWqziXp+AmmssXxHzb1OtlHCmEFzE=
Subject: patch "iio: adc: ad7124: fix DT configuration parsing" added to char-misc-linus
To: mitrutzceclan@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dumitru.ceclan@analog.com,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Sep 2024 12:18:06 +0200
Message-ID: <2024090306-acts-capture-77d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7124: fix DT configuration parsing

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 61cbfb5368dd50ed0d65ce21d305aa923581db2b Mon Sep 17 00:00:00 2001
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
Date: Tue, 6 Aug 2024 11:51:33 +0300
Subject: iio: adc: ad7124: fix DT configuration parsing

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
---
 drivers/iio/adc/ad7124.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index afb5f4d741e6..108e9ccab1ef 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -844,8 +844,6 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 	st->channels = channels;
 
 	device_for_each_child_node_scoped(dev, child) {
-		cfg = &st->channels[channel].cfg;
-
 		ret = fwnode_property_read_u32(child, "reg", &channel);
 		if (ret)
 			return ret;
@@ -863,6 +861,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
 
+		cfg = &st->channels[channel].cfg;
 		cfg->bipolar = fwnode_property_read_bool(child, "bipolar");
 
 		ret = fwnode_property_read_u32(child, "adi,reference-select", &tmp);
-- 
2.46.0



