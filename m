Return-Path: <stable+bounces-176312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FA1B36D03
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55583585747
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5FD35FC34;
	Tue, 26 Aug 2025 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tlolKGt2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C435FC31;
	Tue, 26 Aug 2025 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219331; cv=none; b=nfwTH7l67Gh0tVA1JCGj1KSepkHhlckTdFG/VkJYWUnxePl1KG6ciIDbzTVt8Wi6lmb5o6JeqhZ8FqHDdrV15uHL+UqBMZH9mgE0JInCAf5ipQWU4YVKx0r8T0Rlzshfz9nQ2DSA5xuVuitLOyHOV90TlTT7lnhB5tN0vG5GAWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219331; c=relaxed/simple;
	bh=cwp4w3lBxG0JTMhkQpmaDsRl3TrXS1QWypZ2UBc6S0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfQiUR/v8O/qAktghp65/YOlkMlMZmgi0lIKAxIUTQRP5zQ+Oe4dsHNO+3BwF4+yoIG798f2ikul9MIbajGNNnQMpLSBejSBLywHQf1HKtYxWNqgtzfFMU6xgCypUKNcf4kJFPWGorYngn8a1UsTQH/AshMZOdd2/EjumiZA8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tlolKGt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D113FC113CF;
	Tue, 26 Aug 2025 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219331;
	bh=cwp4w3lBxG0JTMhkQpmaDsRl3TrXS1QWypZ2UBc6S0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tlolKGt2/pM3YiRMEoMqKbEEvE/kULIUKqbVogDqSNRllf0czKzqc0deWjgAV1mLL
	 BrUHGpgQzLHkP1E08WZt1RzdpmHvqlaWeVF3A402glDUQYrqBKCWVyRhAzk95A3Kch
	 FYUlgWuprJ50zmL5nAEl09S2qJFy7DKJhs3UgXYs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 340/403] iio: hid-sensor-prox: Fix incorrect OFFSET calculation
Date: Tue, 26 Aug 2025 13:11:06 +0200
Message-ID: <20250826110916.251339479@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Lixu <lixu.zhang@intel.com>

[ Upstream commit 79dabbd505210e41c88060806c92c052496dd61c ]

The OFFSET calculation in the prox_read_raw() was incorrectly using the
unit exponent, which is intended for SCALE calculations.

Remove the incorrect OFFSET calculation and set it to a fixed value of 0.

Cc: stable@vger.kernel.org
Fixes: 39a3a0138f61 ("iio: hid-sensors: Added Proximity Sensor Driver")
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20250331055022.1149736-4-lixu.zhang@intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ adapted prox_attr array access to single structure member access ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/hid-sensor-prox.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -103,8 +103,7 @@ static int prox_read_raw(struct iio_dev
 		ret_type = prox_state->scale_precision;
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = hid_sensor_convert_exponent(
-				prox_state->prox_attr.unit_expo);
+		*val = 0;
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:



