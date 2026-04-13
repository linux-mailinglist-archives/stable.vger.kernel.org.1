Return-Path: <stable+bounces-237511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOv5NOkm3WlcaQkAu9opvQ
	(envelope-from <stable+bounces-237511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:24:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E8B3F1587
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2949A310EE7B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0692930BF68;
	Mon, 13 Apr 2026 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2kE5z70Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD226330B3A;
	Mon, 13 Apr 2026 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099645; cv=none; b=DBDPtME/LyxoglthdTSaRt5q2LVu/eRA+O2/EHgx3wUpFizQeTmScsuxFGJQ62dq7gvusnONdO8b7/RJaXAXq3k4v8MbE5igGkPIupCnlMXNbBEXOMMuzRmqY1NnXw+4wiveaZN0RPRrVqGmpAAH8oqmG/UCRjxwi5xK0ukDFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099645; c=relaxed/simple;
	bh=yQoBdHN4cvLvNsakiO+K+JTsf2n0/gwJFeNhsYO0IA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLe5/GcNwmBB3zyWYjektBel1EVwsBV+wUx8q3kesuZz+MhH4ST6ZbMOmhLOzEV1ODlH071zpQYFBNXShCajldHFD4kPpV/AY6kTh1oV9pgFs7m9rkhex9fGOFR9ikK/rXWlFI0sSFhf3U6RopkZYW+EsVjbNZr2ATA0zAQgvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2kE5z70Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4C2C2BCAF;
	Mon, 13 Apr 2026 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099645;
	bh=yQoBdHN4cvLvNsakiO+K+JTsf2n0/gwJFeNhsYO0IA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2kE5z70QMXgjtr2pb+OaDoC5e0AclBLfL1WHV86NcyH7KStqcJvdyBujszi47gZCu
	 WHpTUcsbt55sah5GyKUknyXK/ZcRw+vSWO1QSDlHK49RPxiGWCAz5ApIIVBNfACjfz
	 gsigSPSbUl/edDQInaIXHW+n6iwsj74Hva53s/Bo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miao Li <limiao@kylinos.cn>,
	stable <stable@kernel.org>
Subject: [PATCH 5.10 387/491] usb: quirks: add DELAY_INIT quirk for another Silicon Motion flash drive
Date: Mon, 13 Apr 2026 18:00:32 +0200
Message-ID: <20260413155833.523826419@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-237511-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 32E8B3F1587
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miao Li <limiao@kylinos.cn>

commit dd36014ec6042f424ef51b923e607772f7502ee7 upstream.

Another Silicon Motion flash drive also randomly work incorrectly
(lsusb does not list the device) on Huawei hisi platforms during
500 reboot cycles, and the DELAY_INIT quirk fixes this issue.

Signed-off-by: Miao Li <limiao@kylinos.cn>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/20260319053927.264840-1-limiao870622@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -394,6 +394,7 @@ static const struct usb_device_id usb_qu
 
 	/* Silicon Motion Flash Drive */
 	{ USB_DEVICE(0x090c, 0x1000), .driver_info = USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x090c, 0x2000), .driver_info = USB_QUIRK_DELAY_INIT },
 
 	/* Sound Devices USBPre2 */
 	{ USB_DEVICE(0x0926, 0x0202), .driver_info =



