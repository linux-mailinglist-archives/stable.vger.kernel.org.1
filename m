Return-Path: <stable+bounces-186604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44597BE9A2D
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC6A2581B88
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA510212575;
	Fri, 17 Oct 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LFtmFIPu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C93370FB;
	Fri, 17 Oct 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713712; cv=none; b=kZ3DpKgX0e++l3SSKl6CWlxbxBp9tZVIzkZTFxaNNUHxX8DlQUyHe4Lw0VYdVTlle0JgWq4IdSA0ECZVcdbGulg6K/wDVGaYEmqpWlaDPXu3YGvRd3EM0jljbxfLu0uH9gG/OekHlxWq0PFOlWl5eXxWEpFRU8r2Y1ol5ETnqGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713712; c=relaxed/simple;
	bh=Pm5DbpF/UTRBqXttc2b5WEGcXle3uHoelaLrtfUYyzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDTpNTq9l+12wl1Otmh4XakVNZhk0bTUFj1VNhI4YAlJOk9Xu8D5YlDMi5gnFD5s6q56E3MJQ5FRwREehNOxLnTRjNM/QAUQLU8ylUCm5oVPot2Vy8PcAAHyR7ZYXHwL5ls6xXVrgz22Gfz2O5CqwVnK1RKDmDSBJPZF+wg2NMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LFtmFIPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C789BC4CEE7;
	Fri, 17 Oct 2025 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713712;
	bh=Pm5DbpF/UTRBqXttc2b5WEGcXle3uHoelaLrtfUYyzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFtmFIPu2gxEE7Rs0LycXLGCHLelo9KkzENLUi8oVunx9CnbVTIwTlRdEw9MQlySi
	 ugx9QvLpMWbuQvW+V1UfRwdOLhO0aSdG5VqX9B3Q4JlVQeJQ+XhLYvY6wYJhDH3VC1
	 xkqWwiIuwN/hHvZZfM2/i6FWr/QHTLBEJwKi/b0g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Anderson <sean.anderson@linux.dev>,
	"OGriofa, Conall" <conall.ogriofa@amd.com>,
	"Erim, Salih" <Salih.Erim@amd.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6 094/201] iio: xilinx-ams: Fix AMS_ALARM_THR_DIRECT_MASK
Date: Fri, 17 Oct 2025 16:52:35 +0200
Message-ID: <20251017145138.204663459@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
References: <20251017145134.710337454@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Anderson <sean.anderson@linux.dev>

commit 1315cc2dbd5034f566e20ddce4d675cb9e6d4ddd upstream.

AMS_ALARM_THR_DIRECT_MASK should be bit 0, not bit 1. This would cause
hysteresis to be enabled with a lower threshold of -28C. The temperature
alarm would never deassert even if the temperature dropped below the
upper threshold.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: O'Griofa, Conall <conall.ogriofa@amd.com>
Tested-by: Erim, Salih <Salih.Erim@amd.com>
Acked-by: Erim, Salih <Salih.Erim@amd.com>
Link: https://patch.msgid.link/20250715003058.2035656-1-sean.anderson@linux.dev
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/xilinx-ams.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -118,7 +118,7 @@
 #define AMS_ALARM_THRESHOLD_OFF_10	0x10
 #define AMS_ALARM_THRESHOLD_OFF_20	0x20
 
-#define AMS_ALARM_THR_DIRECT_MASK	BIT(1)
+#define AMS_ALARM_THR_DIRECT_MASK	BIT(0)
 #define AMS_ALARM_THR_MIN		0x0000
 #define AMS_ALARM_THR_MAX		(BIT(16) - 1)
 



