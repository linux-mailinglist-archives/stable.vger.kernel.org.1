Return-Path: <stable+bounces-268484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 03uvGrEoPWqoyAgAu9opvQ
	(envelope-from <stable+bounces-268484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:10:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D6D6C5F80
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:10:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=usCoZ6Yk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268484-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268484-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC487300C024
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315E28725B;
	Thu, 25 Jun 2026 13:10:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD922253EE;
	Thu, 25 Jun 2026 13:10:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393006; cv=none; b=o2as64hhrD8FVrBgdBZEq5GIb6+FTZc8hC+3Hso3guuMLzfMVBjx39Kti68eD0bpuYa9KpWcd9TSAmWJTeIFZYAL5EbnZZ/HeBXbIoXWBO02lEl5G7+7NhoidCB/pj/Zd0RVh1niXtQPdGtuiBVFbriBfXgElXojvX8Y1lelpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393006; c=relaxed/simple;
	bh=wedskd2z1h9qz6lMNjBoh1ZcAV2+I7l4l4ONKBHs/Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPZVompW/zH7VgQhHDOPt40OQWZxhyTwA0jJqFwETiD2hqBK+xzOLpCL7lKuTf3LyeUi1uiVtdO5jJC+cgLsioVaJF8VbbatTGoJJZzeDkL0X4sZ/meukXbgNfpiay/qYFwQfDOoUr/QN2EcjLh3qj1ONSaDHoxHEG78qJTT78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=usCoZ6Yk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AAF1F000E9;
	Thu, 25 Jun 2026 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782393004;
	bh=B75b0xem9CKJ1Bjb3MaVcXa1zrfrT0iCP9R0Cq3eNS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=usCoZ6Yk0LGDo+THWtgAdO6IdCtYTDcph9bF+UWIIPSvbJlt8RpccXVh83IlWtmuv
	 MJE48sw/DHJKczDCVKlwqXLT/zUNCR5kG+OBpB0XuXucy+Bz3ccQ2o39P+hxj+t6IL
	 +qqt8MKNONvNr67QUFb8na9+5v67EQhv5THdmu4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: [PATCH 7.0 28/49] rose: cancel neighbour timers in rose_neigh_put() before freeing
Date: Thu, 25 Jun 2026 14:03:40 +0100
Message-ID: <20260625125641.474020187@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268484-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38D6D6C5F80

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bernard Pidoux <bernard.f6bvp@gmail.com>

commit 9b222cb1d23ff210975e9df5ebab7b011acb6fad upstream.

rose_neigh_put() kfree()s the neighbour but never cancels its ftimer and
t0timer. Until now every caller that dropped the final reference first
called rose_remove_neigh(), which deletes those timers. The socket
heartbeat reaping path drops the last reference directly, so a neighbour
could be freed with t0timer still armed -- it re-arms itself in
rose_t0timer_expiry() -- leading to a use-after-free write in
enqueue_timer().

Cancel both timers with timer_delete_sync() (the synchronous variant, to
wait out a concurrently running, self-rearming handler) in the
refcount-zero branch of rose_neigh_put().

Signed-off-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/rose.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/include/net/rose.h
+++ b/include/net/rose.h
@@ -160,6 +160,18 @@ static inline void rose_neigh_hold(struc
 static inline void rose_neigh_put(struct rose_neigh *rose_neigh)
 {
 	if (refcount_dec_and_test(&rose_neigh->use)) {
+		/* We are dropping the last reference, so we are about to free the
+		 * neighbour.  Its timers may still be armed -- t0timer in particular
+		 * re-arms itself in rose_t0timer_expiry().  rose_remove_neigh()
+		 * cancels them before its own put, but callers that drop the final
+		 * reference without first calling rose_remove_neigh() (the socket
+		 * heartbeat reaping path) would otherwise kfree() a neighbour with a
+		 * live timer -> use-after-free.  timer_delete_sync() (not the async
+		 * variant) is required: it waits out a concurrently running handler
+		 * and loops until the self-rearming timer stays stopped.
+		 */
+		timer_delete_sync(&rose_neigh->ftimer);
+		timer_delete_sync(&rose_neigh->t0timer);
 		if (rose_neigh->ax25)
 			ax25_cb_put(rose_neigh->ax25);
 		kfree(rose_neigh->digipeat);



