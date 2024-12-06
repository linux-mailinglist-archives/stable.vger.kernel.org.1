Return-Path: <stable+bounces-99728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E79E7319
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A951D1887D97
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2C17C208;
	Fri,  6 Dec 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="URMNaM1n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8A3B2BB;
	Fri,  6 Dec 2024 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498154; cv=none; b=qj2S9rlCJD4OIB4mCcC8TuLL5FIDhGa68MdWiIGJyyVx5AKtZz5K0r7qFoMy+c4txSMMRibFWv9d4r8P4lsH+QNlyF1flQ4pNxEtlmbQnR9WL58oDp4/3GbMI/kBoHxFAmlOl2ot6Z12WupT8DrCCdcU//mUa2w2eCE8CSRXgiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498154; c=relaxed/simple;
	bh=lwzp7zQWfPIz3TjQW+sgHuW5Rre6JVj0Xyboe7Rxe3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKQzo7/ZkzYNt14VAF0CZDG4sOhQndgbVsRaytbaTGLkdN5e9cb6qSw4iQtSTnAHODVTp3OqhOcb/7Kz+MuA4rcrb1J1DoTA0gFuAPbGrY4vY01i/HyshmF/O6nuua8XCPGuU22wcq6hS9Zhss31GBAYSih4cLpba3P0EEOnRZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=URMNaM1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55443C4CED1;
	Fri,  6 Dec 2024 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733498153;
	bh=lwzp7zQWfPIz3TjQW+sgHuW5Rre6JVj0Xyboe7Rxe3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URMNaM1nqXLOTMwYgja/XeS4GxsDc1vHR3cdwMgHGZFsuwYoy073DWFHIt+/BYaC1
	 iDWrrXIxH8hMnt1lBXSWyiJJUPUtQnlRHgXsGekcumRmSmoLM7YLGwYxZj9HB1U2dA
	 Ddm2w/twac3cth/1m4U45gb6vhBkZQ7Y0h1OMAa8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 6.6 501/676] wifi: brcmfmac: release root node in all execution paths
Date: Fri,  6 Dec 2024 15:35:20 +0100
Message-ID: <20241206143712.926270288@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit 2e19a3b590ebf2e351fc9d0e7c323430e65b6b6d upstream.

The fixed patch introduced an additional condition to enter the scope
where the 'root' device_node is released (!settings->board_type,
currently 'err'), which avoid decrementing the refcount with a call to
of_node_put() if that second condition is not satisfied.

Move the call to of_node_put() to the point where 'root' is no longer
required to avoid leaking the resource if err is not zero.

Cc: stable@vger.kernel.org
Fixes: 7682de8b3351 ("wifi: brcmfmac: of: Fetch Apple properties")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20241030-brcmfmac-of-cleanup-v1-1-0b90eefb4279@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -109,9 +109,8 @@ void brcmf_of_probe(struct device *dev,
 		}
 		strreplace(board_type, '/', '-');
 		settings->board_type = board_type;
-
-		of_node_put(root);
 	}
+	of_node_put(root);
 
 	if (!np || !of_device_is_compatible(np, "brcm,bcm4329-fmac"))
 		return;



