Return-Path: <stable+bounces-103553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798EB9EF87B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E346B177953
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF5223C43;
	Thu, 12 Dec 2024 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sBP10s1k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D522333B;
	Thu, 12 Dec 2024 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024912; cv=none; b=m7KSkgTvJWVsZH1HO+RLZcITjh8Gve27DpZ9xwN9AsDyFkNw9f5gTrXf803ydheoOs9c2ykXp5qbaajga+YzrdAcZzPKZvZ49CNAOpHVDc3pfVHyxbinEeDB4SxI1sJMEZ169D/Ic2lQY8Ti1DvN2pFAGJWFSIXscdoeEKhRlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024912; c=relaxed/simple;
	bh=i/ucm41pU6s0SQG82hRWFsedrfXL1nXOPacte19WcOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJ488MxldA5ppjOxpkJPagFl6Yov4RAW2FvHZgsw2QZlj5QEPtYiYtSXsJSPrBRwQp0Ro4GbPzOhr1wzyhr7bF5WfJIP7KU8tKaCbKQqkWpUu9PB4mPUV3V3D9jDoP+ZFl1AaT8rlCmXyp3x9tgbdVtv3dF/vtCSYfat+Abqyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sBP10s1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A87C4CECE;
	Thu, 12 Dec 2024 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024912;
	bh=i/ucm41pU6s0SQG82hRWFsedrfXL1nXOPacte19WcOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBP10s1kgbybUD0tUXqT8/U1rFNecn07NIbKd8DZApJIHuDTQKYrLVp7Sm6eLnp1z
	 grUtUhX5ix2yMO9D6OUvXP5pXliviLn8wnym7wxjzwi03nTdZiCLlmuwBYtTenkg90
	 oUE4qnC6BcVk8YJ10mWVnnYmMPSqL+oDRcAo8hL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <damien.lemoal@wdc.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.10 454/459] scsi: sd: Fix sd_do_mode_sense() buffer length handling
Date: Thu, 12 Dec 2024 16:03:12 +0100
Message-ID: <20241212144311.705021393@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

From: Damien Le Moal <damien.lemoal@wdc.com>

commit c749301ebee82eb5e97dec14b6ab31a4aabe37a6 upstream.

For devices that explicitly asked for MODE SENSE(10) use, make sure that
scsi_mode_sense() is called with a buffer of at least 8 bytes so that the
sense header fits.

Link: https://lore.kernel.org/r/20210820070255.682775-4-damien.lemoal@wdc.com
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sd.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2649,6 +2649,13 @@ sd_do_mode_sense(struct scsi_disk *sdkp,
 		 unsigned char *buffer, int len, struct scsi_mode_data *data,
 		 struct scsi_sense_hdr *sshdr)
 {
+	/*
+	 * If we must use MODE SENSE(10), make sure that the buffer length
+	 * is at least 8 bytes so that the mode sense header fits.
+	 */
+	if (sdkp->device->use_10_for_ms && len < 8)
+		len = 8;
+
 	return scsi_mode_sense(sdkp->device, dbd, modepage, buffer, len,
 			       SD_TIMEOUT, sdkp->max_retries, data,
 			       sshdr);



