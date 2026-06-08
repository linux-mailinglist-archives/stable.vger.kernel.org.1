Return-Path: <stable+bounces-262112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 12ddJ7EdJ2p/sAIAu9opvQ
	(envelope-from <stable+bounces-262112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:53:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E08BD65A2C9
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:53:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=tnsemSRA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262112-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262112-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3D22303FA84
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 19:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96873E7BB1;
	Mon,  8 Jun 2026 19:48:24 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2E1D6BB
	for <Stable@vger.kernel.org>; Mon,  8 Jun 2026 19:48:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948104; cv=none; b=izZ/s+jnJAh22fjpxA2rpEpMfEhg30lVh9CoFURrTue/VE6hervlj80UnSZZMkyn0UumhsHgzUsPFh3gSCYDHkTUsxDKJEQGQmEBMCnZJIvS+8pYjCLBHjyH7dOLSco8Yqle8YRzae1xVt3T6FeuP+EJMIIe3S+BgDe/dzXC4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948104; c=relaxed/simple;
	bh=uiVMbVrmJne0X7y1jwJ2/IpPpAWksJ+2dqvDpf/KiwQ=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=JCDwgIB8X071c4vjQYzkb+804b7gt7AY0k5rccHrt/udxyt/qOnq0MuNJCeoyV4zUiwlZxrNl0vIqbLY9ud3JR0AzivDaC0Ryja8rJfYEF2Coq96guq0/TXnINV9pqVRQWJA3M3u/hRfGjfICNXYO6EwYtvV60wGe37aH6uz+dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tnsemSRA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8AA1F00898;
	Mon,  8 Jun 2026 19:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780948103;
	bh=jcHFsUxhEhW77Id4PsHPfqhb/tpxwxsl7UvY3Q1gqrU=;
	h=Subject:To:From:Date;
	b=tnsemSRAlYBjctU78iZvUGtsTHLXKtz9PO5G8k/3epV+Rj3yt8k3zJ75d3VTrVlk+
	 rdWqcdcajAwn+gy7Raa+sCJdORtFAtbwvfo+AgXU8lGlYW4M8UCsrJ2OZDRPz8HDwL
	 tOm0ZvYjDJxpiAv+VXapGV2MsTfelrTSk9CxxPs4=
Subject: patch "iio: temperature: ltc2983: Fix n_wires default bypassing rotation" added to char-misc-testing
To: liviu.stan@analog.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jun 2026 21:31:06 +0200
Message-ID: <2026060806-revolt-football-2f60@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262112-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:liviu.stan@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E08BD65A2C9


This is a note to let you know that I've just added the patch titled

    iio: temperature: ltc2983: Fix n_wires default bypassing rotation

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 434c150752675f44dc52c384a7fa22e5176bc35a Mon Sep 17 00:00:00 2001
From: Liviu Stan <liviu.stan@analog.com>
Date: Mon, 25 May 2026 19:39:28 +0300
Subject: iio: temperature: ltc2983: Fix n_wires default bypassing rotation
 check

When adi,number-of-wires is absent, n_wires is left at 0. The binding
documents a default of 2 wires, matching the hardware default. However
the current-rotate validation checks n_wires == 2 || n_wires == 3, so
with n_wires = 0 the guard is bypassed and adi,current-rotate is accepted
for a 2-wire RTD.

Initialize n_wires = 2 to match the binding default and ensure the
rotation check fires correctly when the property is absent.

Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
Signed-off-by: Liviu Stan <liviu.stan@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/temperature/ltc2983.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 38e6f8dfd3b8..1f835e326b93 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -741,7 +741,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	struct ltc2983_rtd *rtd;
 	int ret = 0;
 	struct device *dev = &st->spi->dev;
-	u32 excitation_current = 0, n_wires = 0;
+	u32 excitation_current = 0, n_wires = 2;
 
 	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
 	if (!rtd)
-- 
2.54.0



