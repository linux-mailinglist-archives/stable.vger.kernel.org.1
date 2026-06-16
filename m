Return-Path: <stable+bounces-264476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /hwaAFh4MWqZkAUAu9opvQ
	(envelope-from <stable+bounces-264476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:22:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB30691FFB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:22:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=MVJT0Mzd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264476-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264476-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 499A530A0129
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55F544103A;
	Tue, 16 Jun 2026 16:08:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913514534A3;
	Tue, 16 Jun 2026 16:08:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626094; cv=none; b=LshNz2cqX9GSnCx6GfTLOjB2S/pLA21jgyRIbVSFA2WZZ+AqIxmA8sedbj0fUQbFpKvB3pCDVspSGyHCQtOIGHuFNQQrm21CzhPfbCRJ/GVZUVapDgKQYNQAGfSBjPkdTeMqUtf8my7mEfXAi/m6/+Wtvmo1EWgS+KPLGvtpQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626094; c=relaxed/simple;
	bh=E9+KP37NnGUMPnf6Y00nxRf5guDEHbVqX3c3IEd5X6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQJoV5sHmNlNM9iuJAuhh7Pr8sjzWQU0ZJY+ZtXlUM3CxZ7JdyvE3IrCT+1ryexG2bpFG3MAju4IyeBfB7/fCxF6ZdakQ2mtYYV0YnHOY3LCFJgKZs8mGnz8+4aMvRGSf/zNgu0bI0vWFyIjOBG2YPen1sozxkG8mpHOCuPF6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MVJT0Mzd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902FA1F000E9;
	Tue, 16 Jun 2026 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626093;
	bh=CanB+2k4BofoweGGGFsz679FvH+kNiql/sKNjUwnXlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MVJT0MzdI0QeAT7GM8lF5KdechM4ry/TD6qTmzAyNqLjrtQf1RQfAs6ojYEFnlxlG
	 6m2EpgK8UnwS7b4/v0MJ0/dT7Shp0+wL6lF18T9g5xcAC9XjfsE/8uJQTOmfGlrttz
	 VMo5IZBI4qEee/536EWlbzYsqaRo9miAELA6PqSs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Lai <justinlai0215@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 264/325] rtase: Avoid sleeping in get_stats64()
Date: Tue, 16 Jun 2026 20:31:00 +0530
Message-ID: <20260616145111.777072980@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264476-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:justinlai0215@realtek.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,realtek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CB30691FFB

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Lai <justinlai0215@realtek.com>

commit 9fc237f8d49f06d05f0f8e80361047b718894e81 upstream.

The .ndo_get_stats64 callback must not sleep because it can be
called when reading /proc/net/dev.

rtase_get_stats64() calls rtase_dump_tally_counter(), which polls
the tally counter dump bit with read_poll_timeout(). This may
sleep while waiting for the hardware counter dump to complete.

Use read_poll_timeout_atomic() instead to avoid sleeping in the
get_stats64() path.

Fixes: 079600489960 ("rtase: Implement net_device_ops")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
Link: https://patch.msgid.link/20260603061816.31356-1-justinlai0215@realtek.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1563,8 +1563,9 @@ static void rtase_dump_tally_counter(con
 	rtase_w32(tp, RTASE_DTCCR0, cmd);
 	rtase_w32(tp, RTASE_DTCCR0, cmd | RTASE_COUNTER_DUMP);
 
-	err = read_poll_timeout(rtase_r32, val, !(val & RTASE_COUNTER_DUMP),
-				10, 250, false, tp, RTASE_DTCCR0);
+	err = read_poll_timeout_atomic(rtase_r32, val,
+				       !(val & RTASE_COUNTER_DUMP),
+				       10, 250, false, tp, RTASE_DTCCR0);
 
 	if (err == -ETIMEDOUT)
 		netdev_err(tp->dev, "error occurred in dump tally counter\n");



