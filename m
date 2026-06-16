Return-Path: <stable+bounces-264456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i4TeLbR3MWpVkAUAu9opvQ
	(envelope-from <stable+bounces-264456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:20:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 244D7691F2E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:20:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=LFTVhceG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264456-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264456-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A194D31390A3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073EF4534A3;
	Tue, 16 Jun 2026 16:06:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59C3A8746;
	Tue, 16 Jun 2026 16:06:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625978; cv=none; b=pfLs+/Ty0MF7D6diloTALyxcAOktzrjKEW5LLjpRpBEcFXMAtC6llMhxT1oMqx5ZgGoj93nB8f5Iq2ucDrlJg0/I1NBFpdg4Ve9BnOTfjHeu90JwlV+Z6SbZB7H1iIUxpouerpdtnxY1+WA10mXB6bMC1L+ne6sK9Fg67CKmGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625978; c=relaxed/simple;
	bh=l8JtK+Vh4nA6iZmdVGLVk5VpmMV+1PmlqyNGWdSl+MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUN0D38kBvyhCPSCMepCKBSamIBImjOHHZb8+tk0BMmqT2JkgOJKv83w44tRT/vAgvz10O9Ons9F41OZR3T3Klv+1GnojuPG9yM45eZZ80wplBRlYlrwx3Y9YxMtYW32fZ3WYWpRgyhGgHOpMNEI/DzbrnvItUZs72gHSedFC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LFTVhceG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CBA1F000E9;
	Tue, 16 Jun 2026 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625977;
	bh=HP28VuTh/8g3/+YOnOafCWbyGINi6vCv5WnFncDhBCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LFTVhceGwVvwDlL9LnPK/geW4gdNXAKKB7H9YIeeWmWaIT9CSlmOM5hs6iUzVakMt
	 MW+XNWw3e2Fdp3PfnjOel8/YvBu01o/kNaNP8mbqXa4N9F/n40RLSfbBuV/yXQt+yM
	 9FpCeCawJnYiKlNB6j5gdR9Eyq7x9Gu2PZ+oVcxM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 242/325] net: sfp: initialize i2c_block_size at adapter configure time
Date: Tue, 16 Jun 2026 20:30:38 +0530
Message-ID: <20260616145110.519650388@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264456-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jelonek.jonas@gmail.com,m:kuba@kernel.org,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 244D7691F2E

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Jelonek <jelonek.jonas@gmail.com>

commit 56d0885514491e5ed8f7593400879ab77c52504c upstream.

sfp->i2c_block_size is only assigned in sfp_sm_mod_probe(), which runs
from the state machine timer after SFP_F_PRESENT has been set. Between
those two points, sfp_module_eeprom() (the ethtool -m callback) gates
only on SFP_F_PRESENT and can be entered with i2c_block_size still at
its kzalloc'd value of 0.

On a pure-I2C adapter, sfp_i2c_read() then issues an i2c_transfer()
with msgs[1].len = 0 inside a loop that subtracts this_len from len
each iteration; on adapters that succeed a zero-length read the loop
never advances, spinning while holding rtnl_lock.

This was previously addressed by initializing i2c_block_size in
sfp_alloc() (commit 813c2dd78618), but the initialization was dropped
when i2c_block_size was split from i2c_max_block_size.

Initialize sfp->i2c_block_size from sfp->i2c_max_block_size in
sfp_i2c_configure(), so the field is valid as soon as the adapter is
known. sfp_sm_mod_probe() still reassigns it on each module insertion
to recover from a per-module clamp to 1 (sfp_id_needs_byte_io).

Fixes: 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Link: https://patch.msgid.link/20260528205242.971410-2-jelonek.jonas@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -820,6 +820,7 @@ static int sfp_i2c_configure(struct sfp
 		return -EINVAL;
 	}
 
+	sfp->i2c_block_size = sfp->i2c_max_block_size;
 	return 0;
 }
 



