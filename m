Return-Path: <stable+bounces-215013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFNzCVvviWn4EQAAu9opvQ
	(envelope-from <stable+bounces-215013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:29:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C60F5110562
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D30330078BD
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E783137B3E9;
	Mon,  9 Feb 2026 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bKD6X8h7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3AA37AA7E;
	Mon,  9 Feb 2026 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647381; cv=none; b=rCMjxmiylO8tI/LSUuuNuPgUbdvsLOuHHMDYxYHPW4UgFLP8o6eGEUwpNXN4FQqbBjOdJAqDV8mRIOvZeaVKxt6j9RLZRyPhwSt5NHcaRG8sEnzzy5i5ENmItSgQ21ZUWYU5c7lXDF18tZKnwun2EYREpwGRZ7NEQshcb9RbVPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647381; c=relaxed/simple;
	bh=lDmXonZFeq1cifyPxROLkNZiT/yJ5rCZ7qcE77hYO0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjuvlovSW/bDW7pHiLGZMLXeR987cyfZEisJmjCwYJRwaxMkaXsVq747UcMbdlFhWgh8S/2lm77C02FnLRUSyUqFFf24Pnvl2PaFC3O9idkjyyJxCtWofYEyTK3N6UlJfJIRI68+Jd4FmqVzcRuwpB63SDMSFTD0LPyIIJxKD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bKD6X8h7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D95C116C6;
	Mon,  9 Feb 2026 14:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647381;
	bh=lDmXonZFeq1cifyPxROLkNZiT/yJ5rCZ7qcE77hYO0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKD6X8h7aZ0Te788K7u8+ACA18zzQHb5d73fnmHfKYSz9opNNdltD03Ekjqbdh38o
	 oL/Hown7oejHm13CqLdC9T79rGyTaV9NXd7kVWqUCfEBcNQTpyOck+Vmg6p46Znfr/
	 mEuAcnJkMmP7FOUnccG2HKre/ENiSKOaSuf29GGY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dennis Marttinen <twelho@welho.tech>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 082/175] HID: logitech: add HID++ support for Logitech MX Anywhere 3S
Date: Mon,  9 Feb 2026 15:22:35 +0100
Message-ID: <20260209142323.390421013@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215013-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,welho.tech:email]
X-Rspamd-Queue-Id: C60F5110562
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dennis Marttinen <twelho@welho.tech>

[ Upstream commit d7f6629bffdcb962d383ef8c9a30afef81e997fe ]

I've acquired a Logitech MX Anywhere 3S mouse, which supports HID++ over
Bluetooth. Adding its PID 0xb037 to the allowlist enables the additional
features, such as high-resolution scrolling. Tested working across multiple
machines, with a mix of Intel and Mediatek Bluetooth chips.

[jkosina@suse.com: standardize shortlog]
Signed-off-by: Dennis Marttinen <twelho@welho.tech>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index a88f2e5f791c6..9b612f62d0fba 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4661,6 +4661,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb025) },
 	{ /* MX Master 3S mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb034) },
+	{ /* MX Anywhere 3S mouse over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb037) },
 	{ /* MX Anywhere 3SB mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb038) },
 	{}
-- 
2.51.0




