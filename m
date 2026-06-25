Return-Path: <stable+bounces-268495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kJ/uAy4pPWrnyAgAu9opvQ
	(envelope-from <stable+bounces-268495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:12:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6850E6C6024
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:12:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=EusIQ3o7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268495-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268495-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C30CE30683F5
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C72874F5;
	Thu, 25 Jun 2026 13:10:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818326FD9B;
	Thu, 25 Jun 2026 13:10:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393042; cv=none; b=VeYwkvOtL++4ev5SbcYTBlCSxHGn6mQ8rcWIgDTtqCxLs3tckwAiyQGy+9VX3bgjZ6T+72JfMvGQwtK9mQ1PettJJrx61joVFETQZ9jISsf8J2dXdU4rHUnxlSr475XIHvRh6KhwuaUlzA1MCpQGKM/3fkJOc5sBbALeHfDv+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393042; c=relaxed/simple;
	bh=q3rvcvO49zKEAduwEqvG/v+ZAAptUFH6NoGIgeFXiJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emsPMnP7OvPqib+bsVXUDPtjPnIs2M/SEQYFwLedgyaL8XuTjit/FowxBOkAI46PGudAaMeuL0P/KAesoo/vciBr3XKs7zj9zgA8BX52Qx039gWDjdJGSNa+5nR/mB86bjQphCT4pv6uPK7h8ehy+ypLoZXRTy6IgZt3yhOWI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EusIQ3o7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC711F000E9;
	Thu, 25 Jun 2026 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782393041;
	bh=a3nshOad5VLjaNUQbjuBqIh76hWkIgelB167FJ4FYj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EusIQ3o7pyoNPCcBrbRELXpQi/c+9ZWdOooVPpCP3z7lRBECdArtiXMMmDuW/vLxX
	 Hzwok+OPC4U70SQPOsjLxwb3rGa6hyL6U/WnDaK1uh3jM4Y75D8Bp76ebiEJiShyWK
	 Qsecub4XFKZIajXLAca/TOMrmb1+zRttprSk8Y2Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: [PATCH 7.0 24/49] rose: disconnect orphaned STATE_2 sockets when device is gone
Date: Thu, 25 Jun 2026 14:03:36 +0100
Message-ID: <20260625125640.909268242@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625125637.527552689@linuxfoundation.org>
References: <20260625125637.527552689@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268495-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:bernard.f6bvp@gmail.com,m:bernardf6bvp@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6850E6C6024

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bernard Pidoux <bernard.f6bvp@gmail.com>

commit d4f4cf9f09a3f5fafa8f09110a7c1b5d10f2f261 upstream.

When ax25stop brings down ROSE interfaces, sockets in ROSE_STATE_2
(awaiting CLEAR CONFIRM) whose device pointer is already NULL are not
reached by rose_kill_by_device() and wait for T3 (up to 180s) before
self-cleaning via rose_timer_expiry().  This keeps the rose module
usecount at 1, blocking rmmod for the full T3 duration.

In rose_heartbeat_expiry(), detect ROSE_STATE_2 sockets with no device,
cancel T3, release the neighbour reference, and call rose_disconnect()
+ sock_set_flag(SOCK_DESTROY).  The next heartbeat tick (<=5s) then
destroys the socket via the existing ROSE_STATE_0/SOCK_DESTROY path,
allowing clean module unload within 10s instead of up to 180s.

Signed-off-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rose/rose_timer.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/net/rose/rose_timer.c
+++ b/net/rose/rose_timer.c
@@ -139,6 +139,20 @@ static void rose_heartbeat_expiry(struct
 		}
 		break;
 
+	case ROSE_STATE_2:
+		/* Device gone before CLEAR CONFIRM arrived: stop waiting for T3
+		 * and disconnect now instead of blocking rmmod for up to 180s. */
+		if (!rose->device) {
+			rose_stop_timer(sk);
+			if (rose->neighbour) {
+				rose_neigh_put(rose->neighbour);
+				rose->neighbour = NULL;
+			}
+			rose_disconnect(sk, ENETDOWN, -1, -1);
+			sock_set_flag(sk, SOCK_DESTROY);
+		}
+		break;
+
 	case ROSE_STATE_3:
 		/*
 		 * Check for the state of the receive buffer.



