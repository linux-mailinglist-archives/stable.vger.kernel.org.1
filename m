Return-Path: <stable+bounces-234626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOKJBwWg1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:35:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DD83C108B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85061301370A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD4335CB6F;
	Wed,  8 Apr 2026 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BK4Elb6+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5068228C87C;
	Wed,  8 Apr 2026 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673346; cv=none; b=DyIWhuWbzRvrVPCKAqqtevS+MNdyRTpqN6o5i3YXf/lwOlp6KNAoYRgGPeccJx09bsB7zPV+ipJW385MRODvWRKkpXCLApkACsa8r+cMcnQcrzOmZv5KAACk4h9UrD/ALovKZQJFagxBxklm3yE17jYiCnu5pz0GNTnlN46nCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673346; c=relaxed/simple;
	bh=S71i804vrW49FZUAB4QP43k7sslYHOC0CauljVVs5ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7nGu00XXyghA4vEwKB7NfrnHmVXCsTOJRjrcR3lYU75p+NH+ibaan35PzjGM/q9TecYXqm8QkUZOwlVM340HMNzGtM653m54IbzRPPLJ9ZarDoWqC8vFVU308xwLya5SuWAO0qvhVgzrjiRh+yw+XDyaRAKy6EXU238HOHRFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BK4Elb6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCB0C19421;
	Wed,  8 Apr 2026 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673346;
	bh=S71i804vrW49FZUAB4QP43k7sslYHOC0CauljVVs5ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BK4Elb6+pMiXUmCPcXRtvHN1WyxXH0a41z8axBd6IojVWubyf4Zo9qbSHtCUpXaqe
	 S7nDlc7XJIPDM2PKlWpH7rNXGElvjpcF2F+J2IRXBZbgFb32CHMgpggI0F+a0jZOW0
	 knry3+S8iGr3q5rkihkm5WO6MKjUY8AK5T36A/XQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miao Li <limiao@kylinos.cn>,
	stable <stable@kernel.org>
Subject: [PATCH 6.18 197/277] usb: quirks: add DELAY_INIT quirk for another Silicon Motion flash drive
Date: Wed,  8 Apr 2026 20:03:02 +0200
Message-ID: <20260408175941.221465752@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234626-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94DD83C108B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -402,6 +402,7 @@ static const struct usb_device_id usb_qu
 
 	/* Silicon Motion Flash Drive */
 	{ USB_DEVICE(0x090c, 0x1000), .driver_info = USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x090c, 0x2000), .driver_info = USB_QUIRK_DELAY_INIT },
 
 	/* Sound Devices USBPre2 */
 	{ USB_DEVICE(0x0926, 0x0202), .driver_info =



