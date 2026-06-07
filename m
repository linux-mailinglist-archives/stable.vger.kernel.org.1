Return-Path: <stable+bounces-261668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gQYCIClPJWrwGgIAu9opvQ
	(envelope-from <stable+bounces-261668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:59:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4E2650336
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:59:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=09F+r71y;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261668-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261668-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C320030960E4
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD6E308F38;
	Sun,  7 Jun 2026 10:50:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBDE2DFF04;
	Sun,  7 Jun 2026 10:50:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829411; cv=none; b=l3NNkPvx24u+k5VAGT2eIgOcz9cJmewGBd8PcTtbNRn9ECu7JMP+LBA2XmWW/ZQXx2G9NEETZJG5JKn417DaMueWuT6FapXBLtwVNfkM+IRILgK6vohqWi3YCtN1CqjVasiGtog4PAKAyJthXD3Ofq4hMG8296FyfljXw6qEbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829411; c=relaxed/simple;
	bh=YtAy+6NdKRViANMKoXgCXDTAYq8sWi/za+2TisVo604=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4ZBCNUhx/oSYWOn6CWCzdgA+vHYZ7xHaArbjJev7YHt3HESeqSSrdKJtpFuGwP1voAnBa79fsjtAA7yawhBp4dMrrlSVDlk/k7Dph69cQhQbAUzve5xTeMFCB7KqI/+gjfRDL+pRYJ7pvSo5kS8mK4mc353PURjTIrd5xoRo6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=09F+r71y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39341F00893;
	Sun,  7 Jun 2026 10:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829410;
	bh=HJUOtFVhNC4M91iIRUcQepZubS6A3uP/O7hGzqhYi8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=09F+r71yNhRsClWC9stVEHn5mK4HUg5v2oath7c3PKnjdqQIXeG7lLVle61IDZSVP
	 B3icu+KivUZ79ouM0VGw0fewQR3Vs5JKc/CjjPl2FnvF/TXRMeA9kVtAV+bc7rNLTX
	 yRzcnPaP8B+sQCrJEY3UMVx4rHYxt7fe6NvP4vKA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Seungjin Bae <eeodqql09@gmail.com>
Subject: [PATCH 6.18 245/315] usb: gadget: dummy_hcd: Reject hub port requests for non-existent ports
Date: Sun,  7 Jun 2026 12:00:32 +0200
Message-ID: <20260607095736.561017919@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261668-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:stern@rowland.harvard.edu,m:eeodqql09@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,rowland.harvard.edu,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,harvard.edu:email,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD4E2650336

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Seungjin Bae <eeodqql09@gmail.com>

commit 7d9633528dd40e33964d2dc74a5abbf5c4d116ce upstream.

The `dummy_hub_control()` function handles USB hub class requests
to the virtual root hub. The `GetPortStatus` case returns -EPIPE for
requests with `wIndex != 1`, since the virtual root hub has only a
single port. However, the `ClearPortFeature` and `SetPortFeature`
cases lack the same check.

Fix this by extending the `wIndex != 1` rejection to both cases,
matching the existing behavior of `GetPortStatus`.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@kernel.org>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260518234314.1889396-1-eeodqql09@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/dummy_hcd.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -2134,6 +2134,8 @@ static int dummy_hub_control(
 	case ClearHubFeature:
 		break;
 	case ClearPortFeature:
+		if (wIndex != 1)
+			goto error;
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (hcd->speed == HCD_USB3) {
@@ -2248,6 +2250,8 @@ static int dummy_hub_control(
 		retval = -EPIPE;
 		break;
 	case SetPortFeature:
+		if (wIndex != 1)
+			goto error;
 		switch (wValue) {
 		case USB_PORT_FEAT_LINK_STATE:
 			if (hcd->speed != HCD_USB3) {



