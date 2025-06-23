Return-Path: <stable+bounces-156854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC253AE516C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73301172912
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8E61DDC04;
	Mon, 23 Jun 2025 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mq1jgUcT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1221F5820;
	Mon, 23 Jun 2025 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714429; cv=none; b=c7pH6ZkAr7qC2hACx1TeNMdcj8uHVDFHaM5bLLPbQPzqb7+yiTikHvharXdo2IGRv+8MMjNwYAYH0tivzYuFmv+P4ugM+h3RHrl4cT2OpOaInnb98Ed5jQFDJpfhuddM1rgbc+D4wG+GyjBuqT76By+WD7LjW45vKEGu+x7FoKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714429; c=relaxed/simple;
	bh=R+HlP0MT9CreJHyM7e2vMC5lO7yg3XPToAdvedw+Kqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+9CfH4J0S5l7xpBWxkz6mLYWtAvtsTngTZ3KV2G1Pl0lz1Fkrl3lQcL8usru2eLidLeIuIPZi2MHsSE/pjiZqXecoWwI5XyAk8l1mMEyxpq6q75yd8FFnfxYn6rHH8XC+SHpyaJXcMaQ/aZl724OzvqnzV/8U3WOS5rWyFJrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mq1jgUcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A793C4CEEA;
	Mon, 23 Jun 2025 21:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714428;
	bh=R+HlP0MT9CreJHyM7e2vMC5lO7yg3XPToAdvedw+Kqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mq1jgUcTXLhNJgZkKaeXy1jHDVLY5nuyLm2ucTcfTxg6u4mG5GvcCaoQbZhiw2u1i
	 LgAeOMHbs4NPKWarZS+S3AS6mVt+5QgMKgr+Bl8mkAqZQ8vfUe4kPya12QsgjiGBMP
	 NNQaAw041XpzZlLiDN4nHeT+vv2w0vvwedDByDp8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gui-Dong Han <hanguidong02@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.12 102/414] hwmon: (ftsteutates) Fix TOCTOU race in fts_read()
Date: Mon, 23 Jun 2025 15:03:59 +0200
Message-ID: <20250623130644.653781862@linuxfoundation.org>
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

From: Gui-Dong Han <hanguidong02@gmail.com>

commit 14c9ede9ca4cd078ad76a6ab9617b81074eb58bf upstream.

In the fts_read() function, when handling hwmon_pwm_auto_channels_temp,
the code accesses the shared variable data->fan_source[channel] twice
without holding any locks. It is first checked against
FTS_FAN_SOURCE_INVALID, and if the check passes, it is read again
when used as an argument to the BIT() macro.

This creates a Time-of-Check to Time-of-Use (TOCTOU) race condition.
Another thread executing fts_update_device() can modify the value of
data->fan_source[channel] between the check and its use. If the value
is changed to FTS_FAN_SOURCE_INVALID (0xff) during this window, the
BIT() macro will be called with a large shift value (BIT(255)).
A bit shift by a value greater than or equal to the type width is
undefined behavior and can lead to a crash or incorrect values being
returned to userspace.

Fix this by reading data->fan_source[channel] into a local variable
once, eliminating the race condition. Additionally, add a bounds check
to ensure the value is less than BITS_PER_LONG before passing it to
the BIT() macro, making the code more robust against undefined behavior.

This possible bug was found by an experimental static analysis tool
developed by our team.

Fixes: 1c5759d8ce05 ("hwmon: (ftsteutates) Replace fanX_source with pwmX_auto_channels_temp")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Link: https://lore.kernel.org/r/20250606071640.501262-1-hanguidong02@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/ftsteutates.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/hwmon/ftsteutates.c
+++ b/drivers/hwmon/ftsteutates.c
@@ -423,13 +423,16 @@ static int fts_read(struct device *dev,
 		break;
 	case hwmon_pwm:
 		switch (attr) {
-		case hwmon_pwm_auto_channels_temp:
-			if (data->fan_source[channel] == FTS_FAN_SOURCE_INVALID)
+		case hwmon_pwm_auto_channels_temp: {
+			u8 fan_source = data->fan_source[channel];
+
+			if (fan_source == FTS_FAN_SOURCE_INVALID || fan_source >= BITS_PER_LONG)
 				*val = 0;
 			else
-				*val = BIT(data->fan_source[channel]);
+				*val = BIT(fan_source);
 
 			return 0;
+		}
 		default:
 			break;
 		}



