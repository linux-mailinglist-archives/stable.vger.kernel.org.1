Return-Path: <stable+bounces-249623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G3vFtF9DGoSiQUAu9opvQ
	(envelope-from <stable+bounces-249623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:12:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9E85812C1
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 778E53096C0E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4C93AFD04;
	Tue, 19 May 2026 15:03:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08833AFCF1
	for <stable@vger.kernel.org>; Tue, 19 May 2026 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202986; cv=none; b=a+DwNc2OxJulLs6pOI9piYVVu/pkKXUKJyuTiDJEYfObCCq+QYDQ+iRXfkmoJkj4VRVJZ2n4SOMQcePEQokUrCkTAqymgaL7gapCBcWwYOTn/KXTpdESMNbMv+mkwov5FYGVxZ684c5G/XqNvGbNxL3OWYD61xmhFRgb1tiaMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202986; c=relaxed/simple;
	bh=N3J5yJ0Zotw4PPYFWO/1Ns5cR2/Km24ndwRaewx+ep0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miUfd7wTYdZbX7XTlFP4forVgIXcHzHwkJOsgJ8RKsB/d+7iDuPhvJhxnKFNhsPp1R2lUpEYNX7X7YPYtth1vzkWopQhpjQxZgABke7f0xKBPFe4KM27DggRo8o7deiMR8g+1NVm9Da8LYLnhHKSVUJIpgsKkLDxYfhO3XYjb+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wPLy6-0000c0-N8; Tue, 19 May 2026 17:02:50 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wPLy3-000mP2-1C;
	Tue, 19 May 2026 17:02:47 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wPLy3-0000000HKwM-3UFP;
	Tue, 19 May 2026 17:02:47 +0200
Date: Tue, 19 May 2026 17:02:47 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: pse-pd: fix sign on -ENOENT check in
 of_load_pse_pis()
Message-ID: <agx7l5W6cjAvf6g5@pengutronix.de>
References: <20260515143103.1721888-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515143103.1721888-1-jelonek.jonas@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249623-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0D9E85812C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 02:31:03PM +0000, Jonas Jelonek wrote:
> of_count_phandle_with_args() returns the count on success and a negative
> errno on failure, including -ENOENT when the "pairsets" property is
> absent. The existing comparison in of_load_pse_pis() checks against
> ENOENT (positive 2) instead of -ENOENT, so the branch is taken for any
> error return: legitimate DTs that omit "pairsets" trigger a spurious
> "wrong number of pairsets" error and probe fails with -EINVAL.
> 
> Compare against -ENOENT so a missing "pairsets" property is correctly
> treated as "this PI has no pairsets, continue".
> 
> Fixes: 9be9567a7c59 ("net: pse-pd: Add support for PSE PIs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
 
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

