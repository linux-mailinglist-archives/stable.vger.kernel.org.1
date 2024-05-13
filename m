Return-Path: <stable+bounces-43731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761138C4458
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF452811FE
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26BF57CBD;
	Mon, 13 May 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BdleJebb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F9557CA2
	for <stable@vger.kernel.org>; Mon, 13 May 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614523; cv=none; b=DKnmiBt3jzgDCjy/NONaD4KLBhd2f6WaX+gPvfmJSU8ARDveob8nvBQ5rVZOMmWySK2Zty906LjXGI8k9h95/rDnNnp6pYSXgacN180vWbAJkYAtSOHGp5Ghy2iuIGFFMCIS1AjeoRe0URGV1d8Y7W5WFUktsfcsdl0hX3ohIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614523; c=relaxed/simple;
	bh=Oxh0iL+4r/aqMO6tcpWrvr7vD/NSbFQgnNvaCpG3QsU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TF1tfXBtqdVs2BFGKY8SZM1q804btqgfiaQDrDh9oAuYxoY/a825qe+r8xyVXAdgNsVJMmUDge2glI+Ip/sn3OMSmy7jsdZbXRqrBuMfyUqw720KCZiYeLsaMTIK+gK4m3WP2nrP7sA6wZRZbvCUz1m7/5KDMaFPt1ttFrqm1FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BdleJebb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B3BC2BD11;
	Mon, 13 May 2024 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715614523;
	bh=Oxh0iL+4r/aqMO6tcpWrvr7vD/NSbFQgnNvaCpG3QsU=;
	h=Subject:To:Cc:From:Date:From;
	b=BdleJebbBW3vbeI07SKf5TH2SnAfQmuIwikZNbWGzndXKYxSB/nT/mdM2uX7JgFXz
	 t2OSl9GGg3T0p3nqlDAaIFBoqD0l1oZhFe9VsRMcpMaY0e7rg1kT9iZhHQGjWv5sE+
	 CJVaktuRwPDM2KXwPfyn3rqOAtOY1GHDAtJW4Ews=
Subject: FAILED: patch "[PATCH] Bluetooth: qca: fix firmware check error path" failed to apply to 5.10-stable tree
To: johan+linaro@kernel.org,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 17:35:20 +0200
Message-ID: <2024051320-majority-visiting-2bf1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 40d442f969fb1e871da6fca73d3f8aef1f888558
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051320-majority-visiting-2bf1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

40d442f969fb ("Bluetooth: qca: fix firmware check error path")
2e4edfa1e2bd ("Bluetooth: qca: add missing firmware sanity checks")
ecf6b2d95666 ("Bluetooth: btqca: Add support for firmware image with mbn type for WCN6750")
d8f97da1b92d ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750")
b43ca511178e ("Bluetooth: btqca: Don't modify firmware contents in-place")
c1a74160eaf1 ("Bluetooth: hci_qca: Add device_may_wakeup support")
eaf19b0c47d1 ("Bluetooth: btqca: Enable MSFT extension for Qualcomm WCN399x")
c0187b0bd3e9 ("Bluetooth: btqca: Add support to read FW build version for WCN3991 BTSoC")
99719449a4a6 ("Bluetooth: hci_qca: resolve various warnings")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40d442f969fb1e871da6fca73d3f8aef1f888558 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 1 May 2024 08:37:40 +0200
Subject: [PATCH] Bluetooth: qca: fix firmware check error path

A recent commit fixed the code that parses the firmware files before
downloading them to the controller but introduced a memory leak in case
the sanity checks ever fail.

Make sure to free the firmware buffer before returning on errors.

Fixes: f905ae0be4b7 ("Bluetooth: qca: add missing firmware sanity checks")
Cc: stable@vger.kernel.org      # 4.19
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 8d8a664620a3..638074992c82 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -605,7 +605,7 @@ static int qca_download_firmware(struct hci_dev *hdev,
 
 	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
 	if (ret)
-		return ret;
+		goto out;
 
 	segment = data;
 	remain = size;


