Return-Path: <stable+bounces-213496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAteEWpcg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:49:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DA7E765D
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8152B30069A4
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B0628B7EA;
	Wed,  4 Feb 2026 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gcZNLg8F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0527FD56;
	Wed,  4 Feb 2026 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216534; cv=none; b=jsnHMFUixkYnUmf4TqlqtWrTgWWXONFWhCb5e0hNg+PK9ZQyVc4lxQGC6BA/rjRLS3O2W2hA3NqCYKhH92JUYTFfDW8GlwUv5CgtCUYY9pGvdmrC0dxXZyGYWETCQ45cBh5Fbsc+24o8RtMFv5qXygmjAZigsoG51SvBbEnFcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216534; c=relaxed/simple;
	bh=0ZnJXAikCcrumcTx3R3ZpZmK/VWnVyax+SlnkWPXHU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3Y19SlqUU8AT+BKj9Z0ZTGmcjZlKfnT5/vOfjhAR3d0TSHaEALdgAuKMR0/alr7Ntq/lmrWXFjzmoimDQ2yXf+BVfRS37f4NMPHroeuya+N/IIuiwSoRxfxfTH4kLljxNT8ikeOfYOp7DWtsSWC3F0ewUn9oUfYk3iYd7V9wiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gcZNLg8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DDBC19423;
	Wed,  4 Feb 2026 14:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216534;
	bh=0ZnJXAikCcrumcTx3R3ZpZmK/VWnVyax+SlnkWPXHU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gcZNLg8FRvdK42ncc1mJOXHPFwDIoHhNUF2boObs8MBEWSIqcJD7LNAX2wehRidxd
	 ZyDxWOYYMB0h4PG4MquDsnHehQ99dHfhpd8KaHLv8pgyyFnXJPZWc9dCtWOlHZnEE+
	 mrm6Rv5OgUz5myFjYD2tmQUUrhDgd8VpuOjPNAFw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.10 099/161] slimbus: core: fix runtime PM imbalance on report present
Date: Wed,  4 Feb 2026 15:39:22 +0100
Message-ID: <20260204143855.306881896@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213496-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 99DA7E765D
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 0eb4ff6596114aabba1070a66afa2c2f5593739f upstream.

Make sure to balance the runtime PM usage count in case slimbus device
or address allocation fails on report present, which would otherwise
prevent the controller from suspending.

Fixes: 4b14e62ad3c9 ("slimbus: Add support for 'clock-pause' feature")
Cc: stable@vger.kernel.org	# 4.16
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251126145329.5022-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/slimbus/core.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -498,21 +498,23 @@ int slim_device_report_present(struct sl
 	if (ctrl->sched.clk_state != SLIM_CLK_ACTIVE) {
 		dev_err(ctrl->dev, "slim ctrl not active,state:%d, ret:%d\n",
 				    ctrl->sched.clk_state, ret);
-		goto slimbus_not_active;
+		goto out_put_rpm;
 	}
 
 	sbdev = slim_get_device(ctrl, e_addr);
-	if (IS_ERR(sbdev))
-		return -ENODEV;
+	if (IS_ERR(sbdev)) {
+		ret = -ENODEV;
+		goto out_put_rpm;
+	}
 
 	if (sbdev->is_laddr_valid) {
 		*laddr = sbdev->laddr;
-		return 0;
+		ret = 0;
+	} else {
+		ret = slim_device_alloc_laddr(sbdev, true);
 	}
 
-	ret = slim_device_alloc_laddr(sbdev, true);
-
-slimbus_not_active:
+out_put_rpm:
 	pm_runtime_mark_last_busy(ctrl->dev);
 	pm_runtime_put_autosuspend(ctrl->dev);
 	return ret;



