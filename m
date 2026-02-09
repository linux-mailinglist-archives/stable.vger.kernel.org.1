Return-Path: <stable+bounces-215247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBSIEqT1iWkaFAAAu9opvQ
	(envelope-from <stable+bounces-215247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:56:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB221113C0
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5695D30713F9
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28573783A1;
	Mon,  9 Feb 2026 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0OCaP9e1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974662222B2;
	Mon,  9 Feb 2026 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648166; cv=none; b=VVKLVd3uLlg0+qB4xoi7hSQwVueKvTiNvrOa4+IFHTWkJe0Dnz0oz2CZAQy/zFAgxzPnO7erGlrkG84AuJOfvhr16b7hxfPJ9JQOwqfUnh+GOgCp6B/bc5NwULAFuHHNtRrkZYy3niYJPRr8VQpYldgLre+EweUeSZ13U9UjRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648166; c=relaxed/simple;
	bh=rr5J27TqnRz1m/EfGslYlh187WFQzd7AT1Fz17e68Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMU+H+M8LcIw9LATW05ZgU9vk5zjNdACaqQb7kK+pUNPqb7zHlOsdbNt7mMnrwEEu2p+wZkszhmjyi8547m0zkA9OL+W3TUzdi6JSjGHeKeGcdyumTEqfKgr08HN5UsM9x9vGO2EWrt8LA9fkAo/Qu1DeiIPHcV3g48rWk1qMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0OCaP9e1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08103C116C6;
	Mon,  9 Feb 2026 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648166;
	bh=rr5J27TqnRz1m/EfGslYlh187WFQzd7AT1Fz17e68Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0OCaP9e1Lvc+AzFfKZIv3m4rQbrfqgJg8KgCgtxjNkciEnors9n/4ZPE+0iKBSDIE
	 UDpAneCU2pNeZnMkck7kJ7pC3MJtS/7CzVbC3gn6AOSJWjs/ZjFMIycBrsPB3oWNWM
	 LZzSGAss0Drntc92LJkCMRU8FI32bVN7wos8ZnQI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	DaytonCL <artem749507@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 26/69] HID: multitouch: add MT_QUIRK_STICKY_FINGERS to MT_CLS_VTL
Date: Mon,  9 Feb 2026 15:23:54 +0100
Message-ID: <20260209142302.868157356@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.913348974@linuxfoundation.org>
References: <20260209142301.913348974@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215247-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: ECB221113C0
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: DaytonCL <artem749507@gmail.com>

[ Upstream commit ff3f234ff1dcd6d626a989151db067a1b7f0f215 ]

Some VTL-class touchpads (e.g. TOPS0102:00 35CC:0104) intermittently
fail to release a finger contact. A previous slot remains logically
active, accompanied by stale BTN_TOOL_DOUBLETAP state, causing
gestures to stay latched and resulting in stuck two-finger
scrolling and false right-clicks.

Apply MT_QUIRK_STICKY_FINGERS to handle the unreleased contact correctly.

Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/1225
Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Tested-by: DaytonCL <artem749507@gmail.com>
Signed-off-by: DaytonCL <artem749507@gmail.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index b9e67b408a4b9..6d9a85c5fc409 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -379,6 +379,7 @@ static const struct mt_class mt_classes[] = {
 	{ .name = MT_CLS_VTL,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_STICKY_FINGERS |
 			MT_QUIRK_FORCE_GET_FEATURE,
 	},
 	{ .name = MT_CLS_GOOGLE,
-- 
2.51.0




