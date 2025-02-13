Return-Path: <stable+bounces-115954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B413CA3472C
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DD03AE6B8
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F5E26B0BF;
	Thu, 13 Feb 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E41uhe6n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82626B0A5;
	Thu, 13 Feb 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459835; cv=none; b=Ta5h7lhSe3ol11yLOx+z13s0uCqccz+tahCqHZZjXFtE4fGXF5P746K8DsjNt/PGkrMThd3lFbQ0+8BHH+N3hlWExLRvCah10IrhLYlHyNGkLD0jb0XAjJPu/VkdtA9A1RRLgBqzV4rCa7Ve2c+nxpDdeQY0oYlb4BEqlXO1qf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459835; c=relaxed/simple;
	bh=GFtV5lYug9R6fue8oPsafpq3EFlJPs1RpGDAAy2cNzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsAONfpgHnVUDtch0y4Z4d56yHV6KFGO2nJRm6/LS0DL/SmZMMoaamwOq92WQQCZCrP0A5sUaFFMdGK+5gpNCNeylpZh+SPCUREcJDxxZLi2W5zSOgLLVPx7f6yQqpc4Zs3eAE6Ai56G7nnWIVqaQ8DwyA0cKLz9eeBXsOnh/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E41uhe6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E114C4CED1;
	Thu, 13 Feb 2025 15:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459835;
	bh=GFtV5lYug9R6fue8oPsafpq3EFlJPs1RpGDAAy2cNzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E41uhe6nhHmg6o2Eb9vBJwEB59okhN1MLZ+M7vk3LSmfeZxhv+i3cF6SxpIla+wEq
	 9VFciZRhXFzSZwDJOZw5hlXQ/G62YmuszCpXP/07oceTqETR9qxtqoeENScVKsx1JC
	 T6w9u8ZNqgzUSjI8gV9zbz8Tr9oPx8s+1MfcxZ1Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Angelo Dureghello <adureghello@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.13 346/443] iio: dac: ad3552r-hs: clear reset status flag
Date: Thu, 13 Feb 2025 15:28:31 +0100
Message-ID: <20250213142453.972671775@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Angelo Dureghello <adureghello@baylibre.com>

commit 012b8276f08a67b9f2e2fd0f35363ae4a75e5267 upstream.

Clear reset status flag, to keep error status register
clean after reset (ad3552r manual, rev B table 38).

Reset error flag was left to 1, so debugging registers, the
"Error Status Register" was dirty (0x01). It is important
to clear this bit, so if there is any reset event over normal
working mode, it is possible to detect it.

Fixes: 0b4d9fe58be8 ("iio: dac: ad3552r: add high-speed platform driver")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-2-2dac02f04638@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dac/ad3552r-hs.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -329,6 +329,12 @@ static int ad3552r_hs_setup(struct ad355
 		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
 			 AD3552R_ID, id);
 
+	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
+	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
+				      AD3552R_MASK_RESET_STATUS, 1);
+	if (ret)
+		return ret;
+
 	ret = st->data->bus_reg_write(st->back,
 				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
 				      0, 1);



