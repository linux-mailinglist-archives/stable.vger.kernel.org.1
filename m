Return-Path: <stable+bounces-264112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BKXHEfJuMWrcjAUAu9opvQ
	(envelope-from <stable+bounces-264112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:42:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ACB69150C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:42:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=bZf1OkJQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264112-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264112-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 154A0306C9EF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0E444CF44;
	Tue, 16 Jun 2026 15:36:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652C44BC94;
	Tue, 16 Jun 2026 15:36:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624189; cv=none; b=AjAdnm1w9ckqIHCwQcYF819zb++j82b3mafNjn9FYl1Dl8VaSJGUuWR4b0nx9FcOmpFkjfL58l7KMrs+KMbHTU5z4ILgzYMMGyLdaKHnbgMmJS1/89SxITaxGIZCoWnKKBPxU0BSN/j34wLZrPYzPHQ/HJfCLimCoPdlYuL+ydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624189; c=relaxed/simple;
	bh=4L2Ddj8ahQfV383xng7AWjOwfoO0wrVCRM0u+vxqJ9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfdwOsTX+IViPvcjX6I835SXLpxLv3Ks5h8vn6ZamdEN9ryUhKGqKEzWiynjOJ12Yy/L6akelXX64rb0Bm15r8KP2C6CjDwRI8stTFKwJC5pNhuqiq3JPO4O7APzGeXGFPUobg3B00AZZEvsZFuUGg1RghRk4jEexjIY3TmgEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZf1OkJQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B981F000E9;
	Tue, 16 Jun 2026 15:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624188;
	bh=z3zG0kiWKZ26c/7M4gTfsFbzn8YaysA32OO+zEGtXac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZf1OkJQbUsoubos/yo6tLv8QnT6ePQITlHkL3KZyhXxQ59jEy4nkLRrsuTngwbWW
	 uGj+AOFPMktUuNeCHYY+97oREHy3JatogSY9CmKcfCZ0LUiXwfkGgiaDb5xD4SBQ2C
	 wCD/6OnGCDQIpKVuUbERBzmGErcc7gfvKG8ZBQwU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ZhaoJinming <zhaojinming@uniontech.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 7.0 289/378] net: bonding: fix NULL pointer dereference in bond_do_ioctl()
Date: Tue, 16 Jun 2026 20:28:40 +0530
Message-ID: <20260616145125.292309133@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264112-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:zhaojinming@uniontech.com,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,uniontech.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05ACB69150C

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ZhaoJinming <zhaojinming@uniontech.com>

commit a764b0e8317a863006e05732e1aefe821b9d8c2d upstream.

In bond_do_ioctl(), slave_dev is obtained via __dev_get_by_name() which
can return NULL if the requested interface name does not exist. However,
the subsequent slave_dbg() call is placed before the NULL check:

    slave_dev = __dev_get_by_name(net, ifr->ifr_slave);
    slave_dbg(bond_dev, slave_dev, "slave_dev=%p:\n", slave_dev); //here
    if (!slave_dev)
        return -ENODEV;

The slave_dbg() macro expands to netdev_dbg(bond_dev, "(slave %s): " fmt,
(slave_dev)->name, ...) which unconditionally dereferences slave_dev->name
before the NULL check is performed. This results in a NULL pointer
dereference kernel oops when a user calls bonding ioctl (e.g.
SIOCBONDENSLAVE, SIOCBONDRELEASE, etc.) with a non-existent slave
interface name.

This is reachable from userspace via the bonding ioctl interface with
CAP_NET_ADMIN capability, making it a potential local denial-of-service
vector.

Fix by moving the slave_dbg() call after the NULL check.

Fixes: e2a7420df2e0 ("bonding/main: convert to using slave printk macros")
Cc: stable@vger.kernel.org # v5.2+
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
Link: https://patch.msgid.link/20260601085649.4029067-1-zhaojinming@uniontech.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4623,11 +4623,11 @@ static int bond_do_ioctl(struct net_devi
 
 	slave_dev = __dev_get_by_name(net, ifr->ifr_slave);
 
-	slave_dbg(bond_dev, slave_dev, "slave_dev=%p:\n", slave_dev);
-
 	if (!slave_dev)
 		return -ENODEV;
 
+	slave_dbg(bond_dev, slave_dev, "slave_dev=%p:\n", slave_dev);
+
 	switch (cmd) {
 	case SIOCBONDENSLAVE:
 		res = bond_enslave(bond_dev, slave_dev, NULL);



