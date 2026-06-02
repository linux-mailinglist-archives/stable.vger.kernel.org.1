Return-Path: <stable+bounces-259828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HE0JNOLbHmq1WQAAu9opvQ
	(envelope-from <stable+bounces-259828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 15:34:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0703B62E889
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 15:34:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MSO0Uo1f;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259828-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259828-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D01C63025F4C
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2EC3E92B1;
	Tue,  2 Jun 2026 13:29:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998263E63A6;
	Tue,  2 Jun 2026 13:29:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406943; cv=none; b=aBcyuM4n9NmqDbCsOvwVlICeb9rBHo9XKShoewRvg2h316njVrN7l1GpOkuBLGrhdc1J1S7sJr55tmCpyKtgrrcfOkAhzXcY6VaYaJHoLo8XjVofi9aRIUJEKrM8QJY5m+yMPoa6D7y88dATNRfSzlEaDn2atm7R8Bq4DLqkl8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406943; c=relaxed/simple;
	bh=YPbIXm+JSBimFwt0xBV5hfH5fdtSlFueddvGrzKCAd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOkVcok/hyKCmT8ttnjRtIzBxSr7TicpkbFLp2OH42l+MH9PUbWCu0nZeaMtVJYEhv1F/8O1ZTYHL6QLV6zA3nZgecKztyKgoFzYoP75bmTreAfvq6dgTVHcvMhLk26ko2T+8yPsJ062T5YXjVd2nBHiUkRBLiSxtlgL6mvJGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSO0Uo1f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D117C1F00893;
	Tue,  2 Jun 2026 13:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406942;
	bh=oYMOrxgRJMWSL8TQv7hQo8EwvU2bnk7SM1kv7Y62O6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MSO0Uo1f004DvILS7nrFuA1dvjTlttKNR0UToOdSXhXOSmB+Jl99Tvn4lapxBXglM
	 BfUklN3KwDgq3FmBnr3GjPRzSx72L+eyiNfMW3sreUIJiN8lp+bun9e1DuD5yn8ZiV
	 LYXzJySaEOhHOQdoVcL8NjT4Au9ssXA/xfNUXrzF1m2bFm60QLtCRXVXBKsbxZMCzg
	 sDxB7L99LjpfEaXGq/TychYjP+OAUcPYJIy1Ob/OTBmWKmRV1/aBtnAK/M70r+MEup
	 6S3R/U2xiXM4bthVfM3k4NgAxwIo8ZnJGPrGv2jGqSk3k4w8LUYi5ZGNpnVLYCNj3B
	 18ORIoRy9WzWg==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 08/17] i3c: renesas: Clean DATBAS register on detach
Date: Tue,  2 Jun 2026 16:28:15 +0300
Message-ID: <20260602132824.3541151-9-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
References: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-259828-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[claudiu.beznea@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:wsa+renesas@sang-engineering.com,m:tommaso.merciai.xr@bp.renesas.com,m:alexandre.belloni@bootlin.com,m:Frank.Li@nxp.com,m:p.zabel@pengutronix.de,m:claudiu.beznea@kernel.org,m:claudiu.beznea@tuxon.dev,m:linux-i3c@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:stable@vger.kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0703B62E889

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The controller uses DATBAS registers on TX/RX logic. Clean the DATBAS
register for the detached I3C device to avoid issues.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/i3c/master/renesas-i3c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index de09f0cadb72..7167ca12a328 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -964,6 +964,8 @@ static void renesas_i3c_detach_i3c_dev(struct i3c_dev_desc *dev)
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c = to_renesas_i3c(m);
 
+	renesas_writel(i3c->regs, DATBAS(data->index), 0);
+
 	i3c_dev_set_master_data(dev, NULL);
 	i3c->addrs[data->index].addr = 0;
 	i3c->free_pos |= BIT(data->index);
-- 
2.43.0


