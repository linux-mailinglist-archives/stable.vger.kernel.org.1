Return-Path: <stable+bounces-114546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D6EA2ED58
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92673A4DA6
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2781BBBDD;
	Mon, 10 Feb 2025 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rO3qsl2x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07F17557
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193361; cv=none; b=cj/xXe5aRmgMLlCgWOc0qiSqenMIa/hUzfIPozdAgRAVNeO/plN78VMCVHnvuPi9VFzGFkCFU/lmJZk14N1IpVt3Cl+e6ij/e3RpnubDRZ7YUauPi3lwKlYLpHsYFSiFerIMbPgHhYZ8hCNTS1zkvAgoOBK0hwqQwUoJ1c8MJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193361; c=relaxed/simple;
	bh=U2D/5kBHrUsl7Jl9W3HOdhJITHGWI3lqvHv4QOgxdRo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tfFDPDT0BhvdKLBCmmmVXhk90nNST9QTF83rKz//bw2XVbPOhfMBYWila4Aa9WQZoniVr69V1Rkk+qjCiuaSw0kMfcoqOrjr0MBq31aXRt+BSMRozfzqd+y9joqN/tMCvgfFzh3xsfQm/dTvH+8ISuBrt1OlxJzqlTrH+FoUH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rO3qsl2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F7EC4CED1;
	Mon, 10 Feb 2025 13:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739193360;
	bh=U2D/5kBHrUsl7Jl9W3HOdhJITHGWI3lqvHv4QOgxdRo=;
	h=Subject:To:Cc:From:Date:From;
	b=rO3qsl2xRUARwWO4sX6runSZ3PvSLJh8AlUBaYt7yxKmDlOi4k+OZWOOPCWSAKbyx
	 UZwOUCH+jRxZKUYpaukYU1k4rzNePpI0qRq91ZjYdVsa9fYAbsVuIzTBHeneEr2ZD7
	 w0hHZpX8oAqT+VKXVogij53HU233s+zVZMbcux2w=
Subject: FAILED: patch "[PATCH] Bluetooth: qca: Fix poor RF performance for WCN6855" failed to apply to 6.12-stable tree
To: quic_zijuhu@quicinc.com,johan+linaro@kernel.org,luiz.von.dentz@intel.com,steev@kali.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:15:49 +0100
Message-ID: <2025021049-unrated-entering-7761@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a2fad248947d702ed3dcb52b8377c1a3ae201e44
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021049-unrated-entering-7761@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2fad248947d702ed3dcb52b8377c1a3ae201e44 Mon Sep 17 00:00:00 2001
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Mon, 13 Jan 2025 22:43:23 +0800
Subject: [PATCH] Bluetooth: qca: Fix poor RF performance for WCN6855

For WCN6855, board ID specific NVM needs to be downloaded once board ID
is available, but the default NVM is always downloaded currently.

The wrong NVM causes poor RF performance, and effects user experience
for several types of laptop with WCN6855 on the market.

Fix by downloading board ID specific NVM if board ID is available.

Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
Cc: stable@vger.kernel.org # 6.4
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Steev Klimaszewski <steev@kali.org> #Thinkpad X13s
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index a6b53d1f23db..cdf09d9a9ad2 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -909,8 +909,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 				 "qca/msnv%02x.bin", rom_ver);
 			break;
 		case QCA_WCN6855:
-			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/hpnv%02x.bin", rom_ver);
+			qca_read_fw_board_id(hdev, &boardid);
+			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
+						  "hpnv", soc_type, ver, rom_ver, boardid);
 			break;
 		case QCA_WCN7850:
 			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),


