Return-Path: <stable+bounces-142123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7FEAAE92A
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674BF7B7B6B
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D6728DF5F;
	Wed,  7 May 2025 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bIGpDf7o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB8628DF45;
	Wed,  7 May 2025 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643288; cv=none; b=nqwC/eOuoUm/sMtvzfOkcWpIVsR+36D6XSzIFnRMeT0nS0aqo3xS0a5tomCQiuf7kca6XMpowX923lYQDtVjFP/JJMeGXZLOfzhN9zDVNF5Dk6aXRUhbxAduHng0ELIqDSsPa7OsVg8DEHZRTpRlRfGd02/mdYLDXTDQfXoAR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643288; c=relaxed/simple;
	bh=5c2sqvYnbqTKW6JpEWfZj8SjNl60nn+2iuq383huVwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPhdF8MOV1WA5wz4gX7Maxlm+3KnpkyWtly5wxpCFCZvyN/F0d+u7ZR3GP/q8vai0q/aCipXmm3qtJcimRdU9+k9zYQLlGWYykOlyLsfplizxpotlUTBkxWURdavrU4aoYfqbHKI25SooPw7qrK2VpzomzKRnMbqRG+QocHZjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bIGpDf7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC628C4CEE2;
	Wed,  7 May 2025 18:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643288;
	bh=5c2sqvYnbqTKW6JpEWfZj8SjNl60nn+2iuq383huVwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIGpDf7oeiH8RWlAk/BqniNnuhTVsT7YAOzCifJHDy5a4pHamblyurnqOWjNL4Fo/
	 o2GUviAzlshsqMfhUmUiamXCWhPDJsXxXVTfjM31rhFYyhTN5CrIq1Ky6nOgsObyl0
	 +nw3ZB6bouBgIewAY4peE28SkEOqMXLlcm78r27A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.15 10/55] wifi: brcm80211: fmac: Add error handling for brcmf_usb_dl_writeimage()
Date: Wed,  7 May 2025 20:39:11 +0200
Message-ID: <20250507183759.466542047@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183759.048732653@linuxfoundation.org>
References: <20250507183759.048732653@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

commit 8e089e7b585d95122c8122d732d1d5ef8f879396 upstream.

The function brcmf_usb_dl_writeimage() calls the function
brcmf_usb_dl_cmd() but dose not check its return value. The
'state.state' and the 'state.bytes' are uninitialized if the
function brcmf_usb_dl_cmd() fails. It is dangerous to use
uninitialized variables in the conditions.

Add error handling for brcmf_usb_dl_cmd() to jump to error
handling path if the brcmf_usb_dl_cmd() fails and the
'state.state' and the 'state.bytes' are uninitialized.

Improve the error message to report more detailed error
information.

Fixes: 71bb244ba2fd ("brcm80211: fmac: add USB support for bcm43235/6/8 chipsets")
Cc: stable@vger.kernel.org # v3.4+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20250422042203.2259-1-vulab@iscas.ac.cn
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -903,14 +903,16 @@ brcmf_usb_dl_writeimage(struct brcmf_usb
 	}
 
 	/* 1) Prepare USB boot loader for runtime image */
-	brcmf_usb_dl_cmd(devinfo, DL_START, &state, sizeof(state));
+	err = brcmf_usb_dl_cmd(devinfo, DL_START, &state, sizeof(state));
+	if (err)
+		goto fail;
 
 	rdlstate = le32_to_cpu(state.state);
 	rdlbytes = le32_to_cpu(state.bytes);
 
 	/* 2) Check we are in the Waiting state */
 	if (rdlstate != DL_WAITING) {
-		brcmf_err("Failed to DL_START\n");
+		brcmf_err("Invalid DL state: %u\n", rdlstate);
 		err = -EINVAL;
 		goto fail;
 	}



