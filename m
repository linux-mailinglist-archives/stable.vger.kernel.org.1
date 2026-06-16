Return-Path: <stable+bounces-266401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3BFuL5ecMWrCoAUAu9opvQ
	(envelope-from <stable+bounces-266401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:57:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0B96949A8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:57:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=UCrg+9o8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266401-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266401-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 057A4300601A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431B23EB0F5;
	Tue, 16 Jun 2026 18:57:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06B450902;
	Tue, 16 Jun 2026 18:57:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636233; cv=none; b=ZrbIVQFNs0LQs3yqCdcfB9RAGlu1ylXZUlxTqbyBzVZGK/ocv74Wl4/mNYOacZ+q+ViqZYGwXzY01mxi178qPqoNGdVr/Ug4xY5mGm4dUkS5l0pD5Em2DRcUSmO0cQJVNVamnJN+DZtrAuu5+v8e1noIQmoCF9BP6Y21bvLMvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636233; c=relaxed/simple;
	bh=QZyGmONEVFMbKw4kthrUB2yQdm7x7b3MQdHQ5JizD5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqy5No/GZJ/bj9akA+xtOEOL6cYXIfczCrLv+YeqagRoK1X6IIbBYVF6Sm10DElBIIBnxPPSfF5EbL1HQwbfXKJ91NKiqkcaY63hcpLChdbbAwZnKX3WKxs1LbGoLHvcCvFzut3g6JMDo8kx3g6dXVRMCd0ZwE5vnESoDU7Gduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UCrg+9o8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C851F000E9;
	Tue, 16 Jun 2026 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636232;
	bh=bV0DqxLF5V9L9Iw5CjK/GQFkehHFKG1at0rnp//1FcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UCrg+9o8UYv0E2YwXuDKu3fUpfFlCa7EuqEe17XZyZA4DFyS+mvOKq20izKRzAffd
	 OI2Zh2QKvhv3T7VtsIl4V7N3MgozD38LbpyGZIkgadax/PwgUK2G6jiVV0R/Y/AYmI
	 l1MJ4SIZxO4Qhn8LltXrsjUJbzUjYSacOsmnTbLE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ZhaoJinming <zhaojinming@uniontech.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10 200/342] net: bonding: fix NULL pointer dereference in bond_do_ioctl()
Date: Tue, 16 Jun 2026 20:28:16 +0530
Message-ID: <20260616145057.514128808@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266401-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:zhaojinming@uniontech.com,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E0B96949A8

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4018,11 +4018,11 @@ static int bond_do_ioctl(struct net_devi
 
 	slave_dev = __dev_get_by_name(net, ifr->ifr_slave);
 
-	slave_dbg(bond_dev, slave_dev, "slave_dev=%p:\n", slave_dev);
-
 	if (!slave_dev)
 		return -ENODEV;
 
+	slave_dbg(bond_dev, slave_dev, "slave_dev=%p:\n", slave_dev);
+
 	switch (cmd) {
 	case BOND_ENSLAVE_OLD:
 	case SIOCBONDENSLAVE:



