Return-Path: <stable+bounces-194748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B82C5A56D
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04BEC4E7E52
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EF3280CFC;
	Thu, 13 Nov 2025 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dhiNDOWt"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085462DEA83
	for <Stable@vger.kernel.org>; Thu, 13 Nov 2025 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073304; cv=none; b=iBbUedZRALCmVyEbBk2k8oGynsPSqqNMrmLZnZqyD1OouzjvPxce5Wd++9/7bSL8jtuNg4USlvbRSTjq+ZZi3C47mWBYmBrmSlovTQa3G2zZ4rU07xdOumEMdusHETA5WSbzMLWO+rRZYnsGSmEiKFmzkEiN6PqjUp5biDDKd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073304; c=relaxed/simple;
	bh=3EEtBFSW4Y2HzbUcE7REKN7fpjFWFWqFEFvTJmphGyI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=GAEimwxVizk57ZBXgiw/vkEEJPPjipEYJZQyFTr37ZXADPbMwWHtQaCO+2a1RN9baqGmRqIQsFUkDtpvXIP8IBHqgD96TIKWgWhNsZ4fAsuHygFsbhI1EtSdTYFdFOl0cCssvQMvoxpA1+dGUtXQN3AORPCC0aLsvpozMUKBlJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dhiNDOWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461B5C19421;
	Thu, 13 Nov 2025 22:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763073303;
	bh=3EEtBFSW4Y2HzbUcE7REKN7fpjFWFWqFEFvTJmphGyI=;
	h=Subject:To:From:Date:From;
	b=dhiNDOWt5NF1MuB2KCCb+d6fhyDtAax5UJeOOzyIarh+N12b0o7dqzE7lYfzsectC
	 dn5o1C+vrEQ8e8nBoReOgq6wUhmg5/nOe+Y/Zb+wZyxANM/Si4GwxnO8yTtTN1lyb4
	 5czeDQKPEa5nSbkVqSHKArHygTt4bWhuUm4XHunc=
Subject: patch "iio:common:ssp_sensors: Fix an error handling path ssp_probe()" added to char-misc-linus
To: christophe.jaillet@wanadoo.fr,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Nov 2025 17:34:52 -0500
Message-ID: <2025111352-scarring-tabasco-73ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio:common:ssp_sensors: Fix an error handling path ssp_probe()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 21553258b94861a73d7f2cf15469d69240e1170d Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Fri, 10 Oct 2025 20:58:48 +0200
Subject: iio:common:ssp_sensors: Fix an error handling path ssp_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If an error occurs after a successful mfd_add_devices() call, it should be
undone by a corresponding mfd_remove_devices() call, as already done in the
remove function.

Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 1e167dc673ca..da09c9f3ceb6 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -503,7 +503,7 @@ static int ssp_probe(struct spi_device *spi)
 	ret = spi_setup(spi);
 	if (ret < 0) {
 		dev_err(&spi->dev, "Failed to setup spi\n");
-		return ret;
+		goto err_setup_spi;
 	}
 
 	data->fw_dl_state = SSP_FW_DL_STATE_NONE;
@@ -568,6 +568,8 @@ static int ssp_probe(struct spi_device *spi)
 err_setup_irq:
 	mutex_destroy(&data->pending_lock);
 	mutex_destroy(&data->comm_lock);
+err_setup_spi:
+	mfd_remove_devices(&spi->dev);
 
 	dev_err(&spi->dev, "Probe failed!\n");
 
-- 
2.51.2



