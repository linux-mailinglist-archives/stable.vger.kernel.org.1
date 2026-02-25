Return-Path: <stable+bounces-219433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBd7L2ignmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:10:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC9E1930DB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDF4330E495B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6D3313E32;
	Wed, 25 Feb 2026 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JJq2cmBa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE79313E18;
	Wed, 25 Feb 2026 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002712; cv=none; b=tJLNykv9XWG+XayTXzXUzrslX/ZUoZW64QwJuvfQs4O//OInDKvX0H5gyVf+Lnz9RIhlmT3Xk+vPcVxyKGjvwkhCngLDhoWxrAxDQJbpYE2UdJg+lDCbKZtRwUGAk/g7w1ev+owjU7tM/cUFMxPqMA62rWHjEuePy9UyYpElvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002712; c=relaxed/simple;
	bh=GrHa4FtpSvgMmIYiXDnko9k7XdM2b7mcrjjF6Qt23ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+eoJwushvdliy1Jves+HvK2eH7rvU551/O3rpdRhv2AeTFwUdghnM7U0wGNvcK1pK6Z+kD77zRBaVwBW4WFTOswAINOTLShpt2LgoqdAY4kdPZrEn4P0x1fvc/5AnTZRWFMhlNl0e8ljx21Qv8FU319G/XqyERPHE5YosZSTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JJq2cmBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B24C116D0;
	Wed, 25 Feb 2026 06:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002712;
	bh=GrHa4FtpSvgMmIYiXDnko9k7XdM2b7mcrjjF6Qt23ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJq2cmBa8n9KxpZnkRs91HuSq/V17/wwyBhqB28Lme5377bY8aVtbJKvZpNfX8033
	 uhm07zhETV5PYsy8Nl28mPmpqwrUo2CJAe0Uviyk1B6WPxA7v/u0VXuV6nRdv83wDC
	 ZEJ1ulqPuKi6p5BTdgl/g8jdJam23O4D3TUvmcpo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 464/641] gpib: Fix error code in ni_usb_write_registers()
Date: Tue, 24 Feb 2026 17:23:10 -0800
Message-ID: <20260225012359.758863631@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219433-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,msgid.link:url,linaro.org:email]
X-Rspamd-Queue-Id: EAC9E1930DB
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 484e62252212c5b5fc62eaee5e4977143cb159c6 ]

If ni_usb_receive_bulk_msg() succeeds but without reading 16 bytes, then
the error code needs to be set.  The current code returns success.

Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/aSlMpbE4IrQuBGFS@stanley.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 1f8412de9fa32..fdcaa6c00bfea 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -566,7 +566,7 @@ static int ni_usb_write_registers(struct ni_usb_priv *ni_priv,
 			retval, bytes_read);
 		ni_usb_dump_raw_block(in_data, bytes_read);
 		kfree(in_data);
-		return retval;
+		return retval ?: -EINVAL;
 	}
 
 	mutex_unlock(&ni_priv->addressed_transfer_lock);
-- 
2.51.0




