Return-Path: <stable+bounces-237497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNePL2Al3WlcaQkAu9opvQ
	(envelope-from <stable+bounces-237497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:18:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C00143F1241
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11D5030FA00A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A63339870;
	Mon, 13 Apr 2026 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NZazHnzk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C933859A;
	Mon, 13 Apr 2026 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099607; cv=none; b=AGRPNz94sDSO6NwR5uC1hEEsmJSeMxQGyhJk9T+ZIYPkPnxzEt5Bns6yFjvudu30bJCVv3Lohihc0mRg0GoT+tMTKOg1AZly84DxmWh2vxkz1soawQKI3ILICr30lI50jrWMkmhLfWOkeRshCw3/oB/SxfDgsiRVoIrHlfYICJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099607; c=relaxed/simple;
	bh=I1KFD4FI8tSq7D5IeiN7QMWmvzWID2CorzVkEhUtlsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miT/XH0f5UI8Z8pl3D3VTJf417YhPRqFdsslFFnvQ5gRQaerG2V2dBtEiosGEISgBwEPIN9p+MlQ4ha1c1U1fiwI8Azm+LAAymY2XbLc1eblVOWiU7pv/tnW/lmUs4bi/8dYmxmSFA8O++McbUqKheWZ1tLPl+9xriZKQMPtfHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NZazHnzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4ACC2BCAF;
	Mon, 13 Apr 2026 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099607;
	bh=I1KFD4FI8tSq7D5IeiN7QMWmvzWID2CorzVkEhUtlsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZazHnzk8o8zNzRSYXvoSb/RgtbHdpwsGIuvhsPc2fFXH4Xb4QV7/WjahrJll+OFU
	 Y+EBKUfK0NcSE6I7mArtLVWsMhqfT82TiWJZTFC57eJoDGtXX7E8sY19jrkJpcpmR6
	 ENi8HxfV5gBT/MVRmAOtKs35QlCqNUGLeSgdJPm0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5.10 405/491] thunderbolt: Fix property read in nhi_wake_supported()
Date: Mon, 13 Apr 2026 18:00:50 +0200
Message-ID: <20260413155834.194371536@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237497-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,qualcomm.com:email]
X-Rspamd-Queue-Id: C00143F1241
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

commit 73a505dc48144ec72e25874e2b2a72487b02d3bc upstream.

device_property_read_foo() returns 0 on success and only then modifies
'val'. Currently, val is left uninitialized if the aforementioned
function returns non-zero, making nhi_wake_supported() return true
almost always (random != 0) if the property is not present in device
firmware.

Invert the check to make it make sense.

Fixes: 3cdb9446a117 ("thunderbolt: Add support for Intel Ice Lake")
Cc: stable@vger.kernel.org
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/nhi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -899,7 +899,7 @@ static bool nhi_wake_supported(struct pc
 	 * If power rails are sustainable for wakeup from S4 this
 	 * property is set by the BIOS.
 	 */
-	if (device_property_read_u8(&pdev->dev, "WAKE_SUPPORTED", &val))
+	if (!device_property_read_u8(&pdev->dev, "WAKE_SUPPORTED", &val))
 		return !!val;
 
 	return true;



