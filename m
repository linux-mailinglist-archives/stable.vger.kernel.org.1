Return-Path: <stable+bounces-220466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMtuCVA4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A16421C6429
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5794530BFD75
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A13BF4C2;
	Sat, 28 Feb 2026 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPjJfcjv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEBA3BE2E0;
	Sat, 28 Feb 2026 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300353; cv=none; b=F99WRpIntTRZjTparsknEpGgNoy65vTzBFhJW3ApxZktGP6RsxWXnIFws6y4dOoEdeSaWN88CV0ifk/sIDO1zRV1fwdJdHD8t/sU4vlVjhlSv/Q/sB1J6XGXJX0wLNBvq1EjZKbaCX+co0iOn9QEG1aCyc7uYp01BsquEv0efXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300353; c=relaxed/simple;
	bh=uB02P82FG2llshEYJ+80qIcj8UQiobQ13+TnUgGKNNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYwPp9F/pEN2Kg64//j+VIsWuZ9x+0kizfMDzOX4uiSBnMSUSgeLR8vN5y50kibcnlYO1K6lOYOW6D0d6CxGdoMo//mYDMsg4UF9Sl3Qgm+Tx0vUJ4pvlGNefgyhLA6MgZBFYyEEprboxUE7UEngSpqCoNPXs3z4Ksrq/u37Uss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPjJfcjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB12C19423;
	Sat, 28 Feb 2026 17:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300353;
	bh=uB02P82FG2llshEYJ+80qIcj8UQiobQ13+TnUgGKNNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPjJfcjvmCfRWS8MPuZOdnJ3hjjf2clFJ4Yjd2GOqXf71B2WwXoOg2KRYsZiTtjy8
	 NEXJSMX7YUMIo7Tm2QreG9WmWJ5GI7/a71YZck+UC0MMGIA6Fpm6N/qH8lESgFyxNS
	 cyg1Qn8nWt5hfr85PbN3oNaIW+946Jw0bjtdk64LOjJMXX7QoyBKHpFMmmybp//AYv
	 qvUowy9g3Ryuow6LbySxNnoEIivuL5+X4tJyHxU1CLGf5zwCRTtoiKx9zvI03rMI64
	 IkYSXkJ3jOIRCIxhh/87AzwGQfujtDcYnxLAYdcvTWQS1X1LMpKdEgrrF7j6VpRsN0
	 lSP1hhOoVzieQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Peter <mario.peter@leica-geosystems.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 387/844] usb: chipidea: udc: fix DMA and SG cleanup in _ep_nuke()
Date: Sat, 28 Feb 2026 12:25:00 -0500
Message-ID: <20260228173244.1509663-388-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220466-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A16421C6429
X-Rspamd-Action: no action

From: Mario Peter <mario.peter@leica-geosystems.com>

[ Upstream commit cea2a1257a3b5ea3e769a445b34af13e6aa5a123 ]

The ChipIdea UDC driver can encounter "not page aligned sg buffer"
errors when a USB device is reconnected after being disconnected
during an active transfer. This occurs because _ep_nuke() returns
requests to the gadget layer without properly unmapping DMA buffers
or cleaning up scatter-gather bounce buffers.

Root cause:
When a disconnect happens during a multi-segment DMA transfer, the
request's num_mapped_sgs field and sgt.sgl pointer remain set with
stale values. The request is returned to the gadget driver with status
-ESHUTDOWN but still has active DMA state. If the gadget driver reuses
this request on reconnect without reinitializing it, the stale DMA
state causes _hardware_enqueue() to skip DMA mapping (seeing non-zero
num_mapped_sgs) and attempt to use freed/invalid DMA addresses,
leading to alignment errors and potential memory corruption.

The normal completion path via _hardware_dequeue() properly calls
usb_gadget_unmap_request_by_dev() and sglist_do_debounce() before
returning the request. The _ep_nuke() path must do the same cleanup
to ensure requests are returned in a clean, reusable state.

Fix:
Add DMA unmapping and bounce buffer cleanup to _ep_nuke() to mirror
the cleanup sequence in _hardware_dequeue():
- Call usb_gadget_unmap_request_by_dev() if num_mapped_sgs is set
- Call sglist_do_debounce() with copy=false if bounce buffer exists

This ensures that when requests are returned due to endpoint shutdown,
they don't retain stale DMA mappings. The 'false' parameter to
sglist_do_debounce() prevents copying data back (appropriate for
shutdown path where transfer was aborted).

Signed-off-by: Mario Peter <mario.peter@leica-geosystems.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://patch.msgid.link/20260108165902.795354-1-mario.peter@leica-geosystems.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/udc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 64a421ae0f05b..c8d931d9d4330 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -931,6 +931,13 @@ __acquires(hwep->lock)
 		list_del_init(&hwreq->queue);
 		hwreq->req.status = -ESHUTDOWN;
 
+		/* Unmap DMA and clean up bounce buffers before giving back */
+		usb_gadget_unmap_request_by_dev(hwep->ci->dev->parent,
+					&hwreq->req, hwep->dir);
+
+		if (hwreq->sgt.sgl)
+			sglist_do_debounce(hwreq, false);
+
 		if (hwreq->req.complete != NULL) {
 			spin_unlock(hwep->lock);
 			usb_gadget_giveback_request(&hwep->ep, &hwreq->req);
-- 
2.51.0


