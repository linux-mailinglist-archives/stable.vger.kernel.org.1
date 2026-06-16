Return-Path: <stable+bounces-264736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lZeCGr99MWr2kgUAu9opvQ
	(envelope-from <stable+bounces-264736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:45:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8FF6926E9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:45:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=msHsv0sh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264736-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264736-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43067300D550
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D8A477995;
	Tue, 16 Jun 2026 16:33:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC674779B0;
	Tue, 16 Jun 2026 16:33:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627612; cv=none; b=uWkgFdDb7jO3Viq6hxMF3sGA+u3TR4oaewkRh9veG12CpJwv1ICNW14d9WirPxZkyFXRsFcpweYOKdgZFU275qwmzD09x9nOvpjVuiTUdyn6BXWaF0SgMUUxnGtV5R0Gofyttf7LcnI/0EbSA1YNMciCv3Kc+0bsegiAfe4UU+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627612; c=relaxed/simple;
	bh=7AMSz26Y42kF5Kgqf+lCcXBYFZdg7KSxkYHsp6wwQeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSPVAs8lV/yJHiSWJdTcutTEJo1sWZABbzO2L11/Sk/ky5W8lIqB7V4cMvNZkRjHYtkK/AKC52Qdg1nSA2Hp2iB+Y5VJLiSxsJzKGL+5bjLVMJtB1gbaEQF6dTKoeh2OeFaAvBWUD4a3YBP1agSQOF/2d+3W8V9a+ogiZ5rmcPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=msHsv0sh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B431F00A3A;
	Tue, 16 Jun 2026 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627611;
	bh=20B4jh9kT1UXCKxjWhUwZm0TYanlwY7d+6TzwG6txJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=msHsv0sh31cUzjtSbOjaZp0NuGIlNovgkacY3ofJ6LzuwR3mQttnSG2casAXF1lxc
	 4ZFOBPKBSt5R5fmOf7dsuanZkP1nb+63QaADkFO7u0/Wrd7qwJ69llVGvFScf5NGTh
	 LLDP48ut41OgQ3CZEE9pDHDAqOp5f3nbrhXczfW0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Lai <justinlai0215@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 198/261] rtase: Avoid sleeping in get_stats64()
Date: Tue, 16 Jun 2026 20:30:36 +0530
Message-ID: <20260616145054.233121376@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264736-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:justinlai0215@realtek.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,realtek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D8FF6926E9

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1548,8 +1548,9 @@ static void rtase_dump_tally_counter(con
 	rtase_w32(tp, RTASE_DTCCR0, cmd);
 	rtase_w32(tp, RTASE_DTCCR0, cmd | RTASE_COUNTER_DUMP);
 
-	err = read_poll_timeout(rtase_r32, val, !(val & RTASE_COUNTER_DUMP),
-				10, 250, false, tp, RTASE_DTCCR0);
+	err = read_poll_timeout_atomic(rtase_r32, val,
+				       !(val & RTASE_COUNTER_DUMP),
+				       10, 250, false, tp, RTASE_DTCCR0);
 
 	if (err == -ETIMEDOUT)
 		netdev_err(tp->dev, "error occurred in dump tally counter\n");



