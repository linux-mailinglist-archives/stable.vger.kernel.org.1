Return-Path: <stable+bounces-254270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI2rHHNWFWqmUQcAu9opvQ
	(envelope-from <stable+bounces-254270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:14:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2585D24CD
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCA2E3018A3F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB53CEB84;
	Tue, 26 May 2026 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="qFizvqVz"
X-Original-To: stable@vger.kernel.org
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C962820C6;
	Tue, 26 May 2026 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783149; cv=none; b=CPzD6KBHqYs637ZSbpwkrY45jmApYAfXhnPo+rfTmA4OKu4fdZ00o9vkSKbc1iYSdH6+Rlr/BMZQQteB3IOQiQnUV90FAbJAig5TeQnHX1b3laCfs8PzY7vFC5PGKYigMfZxYxPjTlmx7urU3FNzJFRVEXmRNA20uilOelhpCzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783149; c=relaxed/simple;
	bh=+DPMC/KrZCk4rVtESWROJTmVz5LPk9WoNgb7oufpbx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn/0amnYwq4dwQ6m+/3Te+cyBsizXnMRXSarKZR9ziNc91LTkf66AymgcHBJkYFttkX3S+xL7H4LfGcCaRm+oLLeuhCsADT416o8+mokEqDHTY32T1Z2rOMzQYAxyTtW0apK4TMKOCYrYLlmm65l/6C+tGAoDpmCf065Z2svFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=qFizvqVz; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from L30177.local (unknown [213.36.132.10])
	(Authenticated sender: vjardin@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 10920B005A2;
	Tue, 26 May 2026 10:12:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1779783145;
	bh=+DPMC/KrZCk4rVtESWROJTmVz5LPk9WoNgb7oufpbx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFizvqVzYPKNFYIcW3si0zGbaZtRe8WyeohMEQ6KWPMEMBq/MocoVLpqRC6Cld4sL
	 USUACjmgBlTdomdUylNmtcmyq0tGBlB6rjcEPYTpyv/e6vZ9kXGsYSUligCr92tMfl
	 vcEMJYOsILPJx60NnYxCCesCjQ3BHx6vb1VirelHgsiPSL6ePrfmkc830smzcjUvVu
	 mV732C72lPZq4i22KrXVwT/bWXStPBwXqG4GN0GDbTbhMHzoYE+kMk+f7Y4SySaI61
	 X6JSGFBHQpZPfik4TVaT1yvFurhWWGEZVkZ84EFn2CNfkdBjcLoX+GCdXYwy6e3ilQ
	 0tHla7hwu5eLA==
Date: Tue, 26 May 2026 10:12:05 +0200
From: Vincent Jardin <vjardin@free.fr>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>, Frank Li <frank.li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Wolfram Sang <wsa@kernel.org>,
	Kaushal Butala <kaushalkernelmailinglist@gmail.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] i2c: imx: fix SMBus block-read of 0 locking the
 bus
Message-ID: <ahVV1X_cdhHDmRwc@L30177.local>
References: <20260525-for-upstream-i2c-lx2160-fix-v1-v1-0-f30ab53dd97c@free.fr>
 <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
 <AM0PR04MB6802B906706F0CDE5BA73696E80B2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB6802B906706F0CDE5BA73696E80B2@AM0PR04MB6802.eurprd04.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[free.fr,quarantine];
	R_DKIM_ALLOW(-0.20)[free.fr:s=smtp-20201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com,freescale.com,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-254270-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[free.fr:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[free.fr];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vjardin@free.fr,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8A2585D24CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Carlos,

> Thanks for working on this fix, this looks good to me.

thanks for checking it. It took some times to isolate this issue and
then find a fix.

> SMBus block reads with a length of 0 seem quite uncommon in practice.
> Was this triggered by a specific device behavior, or mainly found
> during boundary / compliance testing?

It is trigger by the usage of a mpq8785 on the i2c bus: when the kernel attaches
on it using its pmsbus/hwmon framework, then the i2c bus get locked on lx2160 !

> Regarding the handling of len == 0,
> I see that the patch sets:
> 
>     msg->buf[0] = 0;
>     msg->len = 2;
> 
> It relies on the last-byte STOP handling together with TXAK. It will help I2C-IMX generate NACK + STOP and
> release the bus, right?

Yes, exactly. Reading I2DR for the length byte has already armed the
next byte, so we set TXAK to NACK it and extend msg->len to 2.
Next then i2c_imx_isr_read_continue() at msg_buf_idx == msg->len - 1,
ie the normal last-byte path, which clears MSTA to emit STOP. So NACK + STOP,
and THEN the bus is released. I do not see any other means to handle it.

> len = 0 is a legal behavior, So it go into a successful path.

Yes. count == 0 is legal (SMBus 3.1 6.5.7), so the transfer reaches
STATE_DONE and returns success.

> But len > I2C_SMBUS_BLOCK_MAX is abnormal behavior. So it go into a fail path.

Correct, and it is a protocol error, so it needs to end up with a -EPROTO while
a count of 0 is an ok case.

> Do I understand it right?

yes. I do not see any other means to handle it.

> Also, if possible could you briefly describe how you validated this change
> (e.g. test setup or steps, with and without the fix)?

On a lx2160a board, on its i2c, bind a mpq8785, and enable the Kernel pmbus/hwmon
framework, then the i2c bus becomes un-useable. Using a scope, we can confirm that
the lx21260a i2c cannot recover.

Best regards,
  Vincent 

