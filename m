Return-Path: <stable+bounces-90800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003909BEB1E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5491F26958
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FF51F585B;
	Wed,  6 Nov 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r4gJQ0xG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544971E0491;
	Wed,  6 Nov 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896851; cv=none; b=nuktgwFZNnLCpyjpYRWQwdNwkHx7rJ0+aKbYDv0cyvHOs4VaG1GDYmFieapjgtG+TVWHX5BZu82Y5ibMe+v4wj9ZdD8WlrC53O36EJ0BvyyYkYDll28p7/NAsSZbl0iHfkn5zoXlTuAQCPdhkCKgVIV8I8GihKcp7lu76GKxOL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896851; c=relaxed/simple;
	bh=GRD3gGfxiiwfIIISTpVxijrvZ5NfVgs56gQt8ChSdGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry7shMUhufjpFFuY3OGxOIwdj/zJxv/WaU/e0iIYrtv25uJzPQzKEbGhJUBKRKF/y4DnQeoHcOQqgAsAe1/9W/DuFq//WVQeLmWpFhIPXzlhKkKb4Ca9mFbyzCq84nXFTYD9MT7GDOD2K3p5qlRLPtMExwQLJvP1LxQ5wxFPcHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r4gJQ0xG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D633C4CECD;
	Wed,  6 Nov 2024 12:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896850;
	bh=GRD3gGfxiiwfIIISTpVxijrvZ5NfVgs56gQt8ChSdGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4gJQ0xGS+9gitPJbzvOu1R592SVAFvwVcngtvS9dKywd6z1BCgrQ5dTwZaF2XpTI
	 Z4ggTd8tz2dQ2WPqixzAGdUpnZjl2xpn7vlLFZEhqN+Dkjna4k8bg3jt2kfPVxTlgR
	 ciiYT589vddlTIJLGc52agnfLUVCoiSJka0EyLZk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zicheng Qu <quzicheng@huawei.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10 093/110] staging: iio: frequency: ad9832: fix division by zero in ad9832_calc_freqreg()
Date: Wed,  6 Nov 2024 13:04:59 +0100
Message-ID: <20241106120305.754433644@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120303.135636370@linuxfoundation.org>
References: <20241106120303.135636370@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zicheng Qu <quzicheng@huawei.com>

commit 6bd301819f8f69331a55ae2336c8b111fc933f3d upstream.

In the ad9832_write_frequency() function, clk_get_rate() might return 0.
This can lead to a division by zero when calling ad9832_calc_freqreg().
The check if (fout > (clk_get_rate(st->mclk) / 2)) does not protect
against the case when fout is 0. The ad9832_write_frequency() function
is called from ad9832_write(), and fout is derived from a text buffer,
which can contain any value.

Link: https://lore.kernel.org/all/2024100904-CVE-2024-47663-9bdc@gregkh/
Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/20241022134354.574614-1-quzicheng@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/iio/frequency/ad9832.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -129,12 +129,15 @@ static unsigned long ad9832_calc_freqreg
 static int ad9832_write_frequency(struct ad9832_state *st,
 				  unsigned int addr, unsigned long fout)
 {
+	unsigned long clk_freq;
 	unsigned long regval;
 
-	if (fout > (clk_get_rate(st->mclk) / 2))
+	clk_freq = clk_get_rate(st->mclk);
+
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
-	regval = ad9832_calc_freqreg(clk_get_rate(st->mclk), fout);
+	regval = ad9832_calc_freqreg(clk_freq, fout);
 
 	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
 					(addr << ADD_SHIFT) |



