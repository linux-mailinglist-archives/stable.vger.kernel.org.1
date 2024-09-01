Return-Path: <stable+bounces-71835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5388C9677F6
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4CD2809B2
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABD4143894;
	Sun,  1 Sep 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uwlW3/Wa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378C944C97;
	Sun,  1 Sep 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207973; cv=none; b=HbNLLrueCHt+NxASsxLYQ/Vvzc2fLoww5yONRp0v83eajywu6+L6+I7EW0naP9r8eGSIFCyi3pkXZshTckP4TwhJCYusnIACf00nS7462nIjyTAtS9fx1kH0Otol1NcoWkByms/TiYO2D5ckAC2oBaI8MQYIx7RFGJEGxed+lY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207973; c=relaxed/simple;
	bh=k7iLQ1mPTlXxMrHggeiPNw1qfWsc6OTAjJfJRxAmohg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xu+yfDoAvxJFdW3bHA4d5FFVtLk+ipE3HaDTVPwDW78hMSjOV0wj5UPmF8S76SlQLVr2lrdoRuptE0TTXUX0Jec77PhdoRY4r/2gNBnp8h9ZpCtOlXYhVfNQJxRQhChUyswy46zzsTNSAL9T6wLWIfoCWeMlOrnSrl2pgx7RfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uwlW3/Wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6EEC4CEC3;
	Sun,  1 Sep 2024 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725207973;
	bh=k7iLQ1mPTlXxMrHggeiPNw1qfWsc6OTAjJfJRxAmohg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwlW3/WaVXlKhcaI/rQvgzbsPeegQzfn9Z2kO12RrSdzpC3mU8QFCHed4vrl+4bmX
	 aBbRVtks86BGEzX16s20gjsTGbh/zZX3H9jmM5SKL/vs31+LttkVA7T6J6JM9CsG8W
	 i2HgnWF1zBa1at+sVOnOtG8gQhZz6hZ1g7mnkodo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 6.6 09/93] wifi: wfx: repair open network AP mode
Date: Sun,  1 Sep 2024 18:15:56 +0200
Message-ID: <20240901160807.707886223@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160807.346406833@linuxfoundation.org>
References: <20240901160807.346406833@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

commit 6d30bb88f623526197c0e18a366e68a4254a2c83 upstream.

RSN IE missing in beacon is normal in open networks.
Avoid returning -EINVAL in this case.

Steps to reproduce:

$ cat /etc/wpa_supplicant.conf
network={
	ssid="testNet"
	mode=2
	key_mgmt=NONE
}

$ wpa_supplicant -iwlan0 -c /etc/wpa_supplicant.conf
nl80211: Beacon set failed: -22 (Invalid argument)
Failed to set beacon parameters
Interface initialization failed
wlan0: interface state UNINITIALIZED->DISABLED
wlan0: AP-DISABLED
wlan0: Unable to setup interface.
Failed to initialize AP interface

After the change:

$ wpa_supplicant -iwlan0 -c /etc/wpa_supplicant.conf
Successfully initialized wpa_supplicant
wlan0: interface state UNINITIALIZED->ENABLED
wlan0: AP-ENABLED

Cc: stable@vger.kernel.org
Fixes: fe0a7776d4d1 ("wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20240823131521.3309073-1-alexander.sverdlin@siemens.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/silabs/wfx/sta.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -370,8 +370,11 @@ static int wfx_set_mfp_ap(struct wfx_vif
 
 	ptr = (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->data + ieoffset,
 				      skb->len - ieoffset);
-	if (unlikely(!ptr))
+	if (!ptr) {
+		/* No RSN IE is fine in open networks */
+		ret = 0;
 		goto free_skb;
+	}
 
 	ptr += pairwise_cipher_suite_count_offset;
 	if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))



