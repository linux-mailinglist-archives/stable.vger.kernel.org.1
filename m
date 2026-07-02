Return-Path: <stable+bounces-271291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WN+bDt2kRmqNawsAu9opvQ
	(envelope-from <stable+bounces-271291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:50:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 530F86FBA9C
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:50:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=jaD7xbfE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271291-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271291-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD37532670C2
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C733B975;
	Thu,  2 Jul 2026 16:52:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBEE30C37A;
	Thu,  2 Jul 2026 16:52:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011164; cv=none; b=hhvyO7Zpw3jDlceuLXz2QE6gIhC5LHh+WcROYH795yt/mhWjPPDcIvFhmtzQBWoD7VDZa2zQdXCWHB8sh6X2i8Gt0d0Pe8DfaJOP04gVDS9JGH1jSvldf/1VCO8tRYd8L9nnie6IQpjdzV1p25KtEcazLC4NUjgu6MUNK/AQGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011164; c=relaxed/simple;
	bh=ENa7VouvXNpByyQ+L4hJSI0Mh7jky13HM456+2ZXqFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJG6h6umTIxz8k4e8m71kAfoHf4nKC1BvfLZvhe6As+xebCCIgUjpCPq6wT3YpI91dpB/mmg7VIz9VjGNzTz9bd9vJabijq/MxEuwcX/D4P+G8YNfKS5tsF2y1aTQLoW2cgEzYgLaYZaZEr6voK9ebchiQLaTg8J1S3G9eHnGhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jaD7xbfE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D3B1F000E9;
	Thu,  2 Jul 2026 16:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011162;
	bh=kH/njiNASe3KYmgRpjR5gW0s/+0enUZBF4Q5JoK0/7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jaD7xbfEGHlVY7tR96NzMP/lZdE0apGblC4oN0WcBtC/1+K9e64kCJtexcio1+Zbo
	 yYQbG61l3Wuzu2NgKd/bjT8lyePsqMy/PwYYrEIiUvTo1+xnenf0unpHPGPrKYFimK
	 9cZiBGoMELExzViVmYC8d4jZwoydh9BNQDcmQ5vs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fan Wu <fanwu01@zju.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 146/175] hdlc_ppp: sync per-proto timers before freeing hdlc state
Date: Thu,  2 Jul 2026 18:20:47 +0200
Message-ID: <20260702155118.881522668@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271291-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:fanwu01@zju.edu.cn,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 530F86FBA9C

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fan Wu <fanwu01@zju.edu.cn>

commit c78a4e41ab5ead6193ad8a2dd92e8906bae659fa upstream.

Each PPP control protocol (LCP/IPCP/IPV6CP) embedded in struct ppp
registers a timer via timer_setup(). That struct ppp is the
hdlc->state allocation, which detach_hdlc_protocol() frees with kfree()
in both teardown paths: unregister_hdlc_device() and the re-attach inside
attach_hdlc_protocol().

The ppp proto never registered a .detach callback, so
detach_hdlc_protocol() performs no timer synchronization before the
kfree(). The only cancel, timer_delete(&proto->timer) in ppp_cp_event(),
is partial (it does not wait for a running callback) and only runs on the
->CLOSED transition; ppp_stop()/ppp_close() do not sync either. A
ppp_timer callback already executing (blocked on ppp->lock) survives the
kfree and then dereferences proto->state / ppp->lock in freed memory,
leading to a use-after-free.

Fix this by adding a .detach helper that calls timer_shutdown_sync() on
every per-proto timer. detach_hdlc_protocol() invokes proto->detach(dev)
before kfree(hdlc->state), so timer_shutdown_sync()
now runs on both free paths.
timer_shutdown_sync() is used instead of timer_delete_sync() because the
keepalive path re-arms the timer through add_timer()/mod_timer() and
shutdown blocks any re-activation during teardown.

Initialize the per-protocol timers in ppp_ioctl() when the protocol is
attached, and remove the now-redundant timer_setup() from ppp_start(), so
that the timers are initialized exactly once at attach time and
ppp_timer_release() never operates on uninitialized timer_list
structures. attach_hdlc_protocol() uses kmalloc() (not kzalloc), so
struct ppp's protos[i].timer is uninitialized garbage until the first
timer_setup(); without this init-at-attach, attaching the PPP protocol
without ever bringing the device up would leave timer_shutdown_sync()
operating on uninitialized memory in .detach. Moving the init out of
ppp_start() (which only runs on NETDEV_UP) into the attach path makes the
initialization unconditional and avoids initializing the same timer_list
twice.

This bug was found by static analysis.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260617020518.116319-1-fanwu01@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wan/hdlc_ppp.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/net/wan/hdlc_ppp.c
+++ b/drivers/net/wan/hdlc_ppp.c
@@ -621,7 +621,6 @@ static void ppp_start(struct net_device
 		struct proto *proto = &ppp->protos[i];
 
 		proto->dev = dev;
-		timer_setup(&proto->timer, ppp_timer, 0);
 		proto->state = CLOSED;
 	}
 	ppp->protos[IDX_LCP].pid = PID_LCP;
@@ -641,6 +640,15 @@ static void ppp_close(struct net_device
 	ppp_tx_flush();
 }
 
+static void ppp_timer_release(struct net_device *dev)
+{
+	struct ppp *ppp = get_ppp(dev);
+	int i;
+
+	for (i = 0; i < IDX_COUNT; i++)
+		timer_shutdown_sync(&ppp->protos[i].timer);
+}
+
 static struct hdlc_proto proto = {
 	.start		= ppp_start,
 	.stop		= ppp_stop,
@@ -649,6 +657,7 @@ static struct hdlc_proto proto = {
 	.ioctl		= ppp_ioctl,
 	.netif_rx	= ppp_rx,
 	.module		= THIS_MODULE,
+	.detach		= ppp_timer_release,
 };
 
 static const struct header_ops ppp_header_ops = {
@@ -659,7 +668,7 @@ static int ppp_ioctl(struct net_device *
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	struct ppp *ppp;
-	int result;
+	int i, result;
 
 	switch (ifs->type) {
 	case IF_GET_PROTO:
@@ -687,6 +696,8 @@ static int ppp_ioctl(struct net_device *
 			return result;
 
 		ppp = get_ppp(dev);
+		for (i = 0; i < IDX_COUNT; i++)
+			timer_setup(&ppp->protos[i].timer, ppp_timer, 0);
 		spin_lock_init(&ppp->lock);
 		ppp->req_timeout = 2;
 		ppp->cr_retries = 10;



