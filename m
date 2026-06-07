Return-Path: <stable+bounces-261338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 230pBxBIJWrKFwIAu9opvQ
	(envelope-from <stable+bounces-261338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:29:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA34764FB47
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:29:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=lHmgIVd2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261338-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261338-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6ADCA3003618
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08432EEE76;
	Sun,  7 Jun 2026 10:29:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9D128CF4A;
	Sun,  7 Jun 2026 10:29:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828166; cv=none; b=t67RtSaAP/xDNE+kmVIPJ31m7HiMV7fWWpmJ6lVF6dsoFA3i+MKQUJVP5GdmCIIcBt6yqLNQcDqH51zWUpOa452ndIYVa+Bw6k65TldBdGaD/0yc9FI6LsqzAII6DGyRMtBn1k8GAYLX0szbmAqcTcOloMKhgzK6xg+hFQ/okkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828166; c=relaxed/simple;
	bh=zzLUH10kcP/WdMQay1VeBSd1o23MYCU6v6MX6e3C3go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyZ78gebhuXSb5POm6jcyjFm7wG9REGtp8alECzMz6Y8DBfk/PZHcfmY8nBAP5kl3ozbQXGBnPPn9dbddSwGBWfBkv61KxAfQZW3vElVwQB2VQmgMXeoaGd1qpBU6FFnLNqd29ZtAIBETA3RP2XaF6AXHOyXujtltalHHb4OjtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lHmgIVd2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898291F00893;
	Sun,  7 Jun 2026 10:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828165;
	bh=L20ZWwgrpgTMLNzmsLA3D6PEewJvVlMf03H8cIqmxUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lHmgIVd2iQz/LpnanaFik2sp2MjGrevk5rdro3fyovfZx+OsQLyL4SWcTPCekxCnX
	 JJKZ1JeyPoIEtOwwmH8Ui6v633YG9IFU0Um+9pWI6ShR2lm/3wdGD0ndWl1vf0Ka9Z
	 F/sVlGJ521MQDey90c6tiTv7LkLZjJKs1F8ilCGw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavitra Jha <jhapavitra98@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.18 133/315] Bluetooth: hci_conn: Fix memory leak in hci_le_big_terminate()
Date: Sun,  7 Jun 2026 11:58:40 +0200
Message-ID: <20260607095732.497533524@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261338-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jhapavitra98@gmail.com,m:luiz.von.dentz@intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA34764FB47

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavitra Jha <jhapavitra98@gmail.com>

commit bfa9d28960ed677d556bdf097073bc3129686229 upstream.

hci_le_big_terminate() allocates iso_list_data via kzalloc_obj but
returns 0 without freeing it when neither pa_sync_term nor big_sync_term
flags are set after evaluating the PA and BIG sync connection state.

This early-return path was introduced when hci_le_big_terminate() was
refactored to take struct hci_conn instead of raw u8 parameters, adding
PA/BIG flag evaluation logic. The existing kfree() on hci_cmd_sync_queue
failure does not cover this path.

Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_conn.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -803,8 +803,10 @@ static int hci_le_big_terminate(struct h
 			d->big_sync_term = true;
 	}
 
-	if (!d->pa_sync_term && !d->big_sync_term)
+	if (!d->pa_sync_term && !d->big_sync_term) {
+		kfree(d);
 		return 0;
+	}
 
 	ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
 				 terminate_big_destroy);



