Return-Path: <stable+bounces-200647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1EFCB2472
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 08:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E52D3041F7D
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 07:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB79303CB0;
	Wed, 10 Dec 2025 07:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GjbMuF7k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE38302CCD;
	Wed, 10 Dec 2025 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765352123; cv=none; b=IbaB+i5TMxFeL8GKb4sSQ/vcMjd3R2Azn4Rc1hS/XmZ04xIdEDJmWEVbGoW38uHRAncyuhimIrlMM+wAEL1iC208gPsELsigDL9xWnNDuTgXVjY3YOHr6yOrpJYzIf9pvJeUVLv2HdyI2+dsItarYxq55TjkUFJ7C72xfBDi6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765352123; c=relaxed/simple;
	bh=MBQN3zAPEJOslfYtb7P3sJ0dcCHSCcBKZ1DkBPjUNjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZsffEKkWYUED1uOcCPt6KNz57OQJVIHwfdnk8FwV8lkcg5QZAC8kJwiC7eCIiITjinMsuDHmlxe98A3yJjRypjkI8s/v17Owmf0bjokLeoIzzQV3XSY6QfbERLVWFIQVVsn6Sd0eeEnTdEiVn47qkH+YLMrannyPcgyfSsQaqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GjbMuF7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A1CC4CEF1;
	Wed, 10 Dec 2025 07:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765352122;
	bh=MBQN3zAPEJOslfYtb7P3sJ0dcCHSCcBKZ1DkBPjUNjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjbMuF7kz6DVJHTJw/Q8ExjMt1YWgMPUCFEZk/C5l0Xb6cUNaN+3AF0sN26whZLi5
	 gfSbl7l46neoP57yzUwHvQ6XPaVzJlgcJlVe/Zyam3dSmQ36Ww0XmudnfGwjBpF0Lh
	 f1MXCyC7vCCneLBwYhQXOKn59/ElIPsLKa1EsWB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Navaneeth K <knavaneeth786@gmail.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.17 59/60] staging: rtl8723bs: fix stack buffer overflow in OnAssocReq IE parsing
Date: Wed, 10 Dec 2025 16:30:29 +0900
Message-ID: <20251210072949.334782839@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210072947.850479903@linuxfoundation.org>
References: <20251210072947.850479903@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Navaneeth K <knavaneeth786@gmail.com>

commit 6ef0e1c10455927867cac8f0ed6b49f328f8cf95 upstream.

The Supported Rates IE length from an incoming Association Request frame
was used directly as the memcpy() length when copying into a fixed-size
16-byte stack buffer (supportRate). A malicious station can advertise an
IE length larger than 16 bytes, causing a stack buffer overflow.

Clamp ie_len to the buffer size before copying the Supported Rates IE,
and correct the bounds check when merging Extended Supported Rates to
prevent a second potential overflow.

This prevents kernel stack corruption triggered by malformed association
requests.

Signed-off-by: Navaneeth K <knavaneeth786@gmail.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1033,6 +1033,9 @@ unsigned int OnAssocReq(struct adapter *
 		status = WLAN_STATUS_CHALLENGE_FAIL;
 		goto OnAssocReqFail;
 	} else {
+		if (ie_len > sizeof(supportRate))
+			ie_len = sizeof(supportRate);
+
 		memcpy(supportRate, p+2, ie_len);
 		supportRateNum = ie_len;
 
@@ -1040,7 +1043,7 @@ unsigned int OnAssocReq(struct adapter *
 				pkt_len - WLAN_HDR_A3_LEN - ie_offset);
 		if (p) {
 
-			if (supportRateNum <= sizeof(supportRate)) {
+			if (supportRateNum + ie_len <= sizeof(supportRate)) {
 				memcpy(supportRate+supportRateNum, p+2, ie_len);
 				supportRateNum += ie_len;
 			}



