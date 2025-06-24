Return-Path: <stable+bounces-157984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFC0AE5658
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649FA7AC33E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F8E223708;
	Mon, 23 Jun 2025 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dD3DsyB9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F821F6667;
	Mon, 23 Jun 2025 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717200; cv=none; b=ndF1HZxC86wAaowp2lzvAiC7MCPQR9rbo49uhw5KH+4mQKZ0MfeJN3pI7r0BfMjQKGcbsISYRBrCWSCll+R3SUJr/8AUd6OaDUW4IktfeG6YxayMpvl5Jq8qk+yNcX70ghr3cPea0k6pGRJYwjNQLY+1Y1laZovUjQQ+CbhsffY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717200; c=relaxed/simple;
	bh=gyIv5MOXVrGvmqdMSsBX8fIA4rEu6mZ1u1OBQ13CR/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEdj8U5RYIw9g3g9VIvesAop6GjWibdK1D++jnIlp3nSwLMxDyF2zi9ps5GOGDDiJR/eQb+jHJzyqV6CpRvF1gBJGznq4acXZcjyyQTDoMcMfo/4HwJ3TylvRCXFT1xugpp4/O1vNDk/kq9h8bcQNTU07zpmXSik1fMUTvjd3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dD3DsyB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AF4C4CEEF;
	Mon, 23 Jun 2025 22:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717199;
	bh=gyIv5MOXVrGvmqdMSsBX8fIA4rEu6mZ1u1OBQ13CR/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dD3DsyB9NjCJeUiaF1bJ6UQ/k0dmjqLCrG8BbsZ8+rytBVpnbulfY1oWnCfA/2lXb
	 09cJLcj/uu5ZNPXr5Altde5/sJH2uy0qyJA1uPNANSjnsy0mSPynRMZ4siq7vxoUwb
	 r4nLSuIBk+3fc2FKxgTFQg1RX5VpmEBDsULtefCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 337/414] iio: accel: fxls8962af: Fix temperature calculation
Date: Mon, 23 Jun 2025 15:07:54 +0200
Message-ID: <20250623130650.409119429@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Nyekjaer <sean@geanix.com>

commit 16038474e3a0263572f36326ef85057aaf341814 upstream.

According to spec temperature should be returned in milli degrees Celsius.
Add in_temp_scale to calculate from Celsius to milli Celsius.

Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
Cc: stable@vger.kernel.org
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20250505-fxls-v4-1-a38652e21738@geanix.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/fxls8962af-core.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -22,6 +22,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -436,8 +437,16 @@ static int fxls8962af_read_raw(struct ii
 		*val = FXLS8962AF_TEMP_CENTER_VAL;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		return fxls8962af_read_full_scale(data, val2);
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = MILLIDEGREE_PER_DEGREE;
+			return IIO_VAL_INT;
+		case IIO_ACCEL:
+			*val = 0;
+			return fxls8962af_read_full_scale(data, val2);
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return fxls8962af_read_samp_freq(data, val, val2);
 	default:
@@ -736,6 +745,7 @@ static const struct iio_event_spec fxls8
 	.type = IIO_TEMP, \
 	.address = FXLS8962AF_TEMP_OUT, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
 			      BIT(IIO_CHAN_INFO_OFFSET),\
 	.scan_index = -1, \
 	.scan_type = { \



