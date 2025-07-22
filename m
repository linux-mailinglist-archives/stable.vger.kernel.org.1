Return-Path: <stable+bounces-163838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2529B0DBF1
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA563A6CBF
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0022EA47E;
	Tue, 22 Jul 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gnt5OQw/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF192E4271;
	Tue, 22 Jul 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192376; cv=none; b=rfg+zpe8uurxXDCuJcb6MAWq+SpuVVk5cpoaHNzaz64HHpbX0Bth4aSsarYl5Sa76Po9TPZPMsj9fSmSshWEDBauJzE6oZMesT7sseAPDhlk8W9ceC4YIZ7603uBNQkQB2+R3zenvYGRdUpTSKdHvheIANZQNR/hng5eXfg+aZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192376; c=relaxed/simple;
	bh=pCnadmpT9+dF3wIQBOCcP3CfdWJh4joZ6hSJA68QsVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQvTZ05y57/FI/67YueSTDwq2NQLNvyxMel9odZXVKkW8EbONZZmmoeZ/kSWxI1cxvIqkPrOsx6pAhASUzDjbOLrbA10Ixxof9NsUqaTsLy1CKQur5CKdTkJcGpQ1i/Qv7BHYz53o1H+LtQcIkwggFpFmML1QkbA/KxS5wv1ekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gnt5OQw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD639C4CEEB;
	Tue, 22 Jul 2025 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753192376;
	bh=pCnadmpT9+dF3wIQBOCcP3CfdWJh4joZ6hSJA68QsVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gnt5OQw/zQO7VfHX1nqDOKy4X+w8uUw2p67k5hINBsGpAxsBAG3LuM65QzGZUGOM/
	 kov7IWPlY/QCORPnLRR8BzVOYYmkWxOQm0YQJgTpj6nnmCFEXGrxiILrD7e8muRgVh
	 ptFad1aYpDy7h0mcpn2sCq8NPDoyRCp1j44nCzqA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6 048/111] iio: adc: max1363: Fix MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
Date: Tue, 22 Jul 2025 15:44:23 +0200
Message-ID: <20250722134335.178483568@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
References: <20250722134333.375479548@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <festevam@denx.de>

commit 6d21f2c2dd843bceefd9455f2919f6bb526797f0 upstream.

Since commit 2718f15403fb ("iio: sanity check available_scan_masks array"),
booting a board populated with a MAX11601 results in a flood of warnings:

max1363 1-0064: available_scan_mask 8 subset of 0. Never used
max1363 1-0064: available_scan_mask 9 subset of 0. Never used
max1363 1-0064: available_scan_mask 10 subset of 0. Never used
max1363 1-0064: available_scan_mask 11 subset of 0. Never used
max1363 1-0064: available_scan_mask 12 subset of 0. Never used
max1363 1-0064: available_scan_mask 13 subset of 0. Never used
...

These warnings are caused by incorrect offsets used for differential
channels in the MAX1363_4X_CHANS() and MAX1363_8X_CHANS() macros.

The max1363_mode_table[] defines the differential channel mappings as
follows:

MAX1363_MODE_DIFF_SINGLE(0, 1, 1 << 12),
MAX1363_MODE_DIFF_SINGLE(2, 3, 1 << 13),
MAX1363_MODE_DIFF_SINGLE(4, 5, 1 << 14),
MAX1363_MODE_DIFF_SINGLE(6, 7, 1 << 15),
MAX1363_MODE_DIFF_SINGLE(8, 9, 1 << 16),
MAX1363_MODE_DIFF_SINGLE(10, 11, 1 << 17),
MAX1363_MODE_DIFF_SINGLE(1, 0, 1 << 18),
MAX1363_MODE_DIFF_SINGLE(3, 2, 1 << 19),
MAX1363_MODE_DIFF_SINGLE(5, 4, 1 << 20),
MAX1363_MODE_DIFF_SINGLE(7, 6, 1 << 21),
MAX1363_MODE_DIFF_SINGLE(9, 8, 1 << 22),
MAX1363_MODE_DIFF_SINGLE(11, 10, 1 << 23),

Update the macros to follow this same pattern, ensuring that the scan masks
are valid and preventing the warnings.

Cc: stable@vger.kernel.org
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Link: https://patch.msgid.link/20250516173900.677821-1-festevam@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/max1363.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -510,10 +510,10 @@ static const struct iio_event_spec max13
 	MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),		\
 	MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),		\
 	MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),		\
-	MAX1363_CHAN_B(0, 1, d0m1, 4, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 5, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 6, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 7, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 18, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 19, bits, ev_spec, num_ev_spec),	\
 	IIO_CHAN_SOFT_TIMESTAMP(8)					\
 	}
 
@@ -608,14 +608,14 @@ static const enum max1363_modes max11608
 	MAX1363_CHAN_U(5, _s5, 5, bits, NULL, 0),	\
 	MAX1363_CHAN_U(6, _s6, 6, bits, NULL, 0),	\
 	MAX1363_CHAN_U(7, _s7, 7, bits, NULL, 0),	\
-	MAX1363_CHAN_B(0, 1, d0m1, 8, bits, NULL, 0),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 9, bits, NULL, 0),	\
-	MAX1363_CHAN_B(4, 5, d4m5, 10, bits, NULL, 0),	\
-	MAX1363_CHAN_B(6, 7, d6m7, 11, bits, NULL, 0),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 12, bits, NULL, 0),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 13, bits, NULL, 0),	\
-	MAX1363_CHAN_B(5, 4, d5m4, 14, bits, NULL, 0),	\
-	MAX1363_CHAN_B(7, 6, d7m6, 15, bits, NULL, 0),	\
+	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, NULL, 0),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, NULL, 0),	\
+	MAX1363_CHAN_B(4, 5, d4m5, 14, bits, NULL, 0),	\
+	MAX1363_CHAN_B(6, 7, d6m7, 15, bits, NULL, 0),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 18, bits, NULL, 0),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 19, bits, NULL, 0),	\
+	MAX1363_CHAN_B(5, 4, d5m4, 20, bits, NULL, 0),	\
+	MAX1363_CHAN_B(7, 6, d7m6, 21, bits, NULL, 0),	\
 	IIO_CHAN_SOFT_TIMESTAMP(16)			\
 }
 static const struct iio_chan_spec max11602_channels[] = MAX1363_8X_CHANS(8);



