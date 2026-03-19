Return-Path: <stable+bounces-227398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOpPFrGAvGnfzQIAu9opvQ
	(envelope-from <stable+bounces-227398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 00:03:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7EA2D3F47
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 00:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7FE930952DB
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 23:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1B43BA243;
	Thu, 19 Mar 2026 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzVVW9G5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36393AEF46;
	Thu, 19 Mar 2026 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961386; cv=none; b=CnbwhXq4zl/1GkOieg/QuajPAMDXHy+Udvrqt9QZZ4xjJNkqcAcKKwWTH79Co9NL+8rhhSXcqxC117VX4uzd4Mri0rJpr37es52dd85Mtt4qsMUKdy+QrTKEa51/E8D2NWDrdKqQahzlX+PXfRSf7aND4yFo5bEMNMv9GIdgR4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961386; c=relaxed/simple;
	bh=4z7FT567dS5vlr7HalD/BlGQW0hDW6XnMyUGAseCIis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHMNGhPsicnzodK7BjYKS03WYl7p+56k7Hkg7dLJLDQvf7f1sNBhebNh/C6AklLD0TJ85O4lN1/GjKj7LXr5VMRPiAFRt03zkaiVZB9qQqPtw2cpowuAencv6NsNstuYePb/wR7eu8/pVY2fcyFeclMQJ7xLw0YAOMjZWRst9c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzVVW9G5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C437C19424;
	Thu, 19 Mar 2026 23:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773961385;
	bh=4z7FT567dS5vlr7HalD/BlGQW0hDW6XnMyUGAseCIis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YzVVW9G5ffgHdcvppH8RWNQj0rnk/0/dDS/ycv+oUzbF33vjp5Ac70gA1J9WCatoA
	 uxXcAK/NHguxV116k7TbmnqlaAuuB5P5O7XERe3Kr/O3vUIlbEd6UJL1gc9eFRrh3i
	 UZP2cUJ8p7SXX3Dgnvswi1koS+utB8gX4tJRwVLI9Hl9q+2xHbxVuxyayC2gqRjpP5
	 RntrFej53D87UdPGUCrqrrJEug6CQhbvpgLRe2HRsAPcFU5bcdbxyxziwxbXrMqwPB
	 jtmDHxQ5MX6+LGwmSy3+BRzAEVm8rM7TCyeyIeMcn1kAd/XK/CzYhfwsnSC8vARFoA
	 YzmsQOEt7q4/g==
Date: Fri, 20 Mar 2026 00:03:00 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Wolfram Sang <wsa@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Hanna Hawa <hhhawa@amazon.com>, 
	Robert Marko <robert.marko@sartura.hr>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>, stable@vger.kernel.org, 
	Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [PATCH v4 0/2] i2c: pxa: fix I2C communication on Armada 3700
Message-ID: <abyAI0ANDdxYO3uD@zenone.zhora.eu>
References: <20260226-i2c-pxa-fix-i2c-communication-v4-0-797a091dae87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-i2c-pxa-fix-i2c-communication-v4-0-797a091dae87@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227398-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,renesas,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zenone.zhora.eu:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA7EA2D3F47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Gabor,

> Gabor Juhos (2):
>       i2c: pxa: defer reset on Armada 3700 when recovery is used

I merged this in i2c/i2c-host-fixes.

>       i2c: pxa: handle 'Early Bus Busy' condition on Armada 3700

This one can't really be considered as a fix and I removed the
"Cc: stable" tag from the commit log.

As of now I merged it in my i2c/i2c-host-next, which is my
testing branch. Once the fix will be taken, I will move it to the
i2c/i2c-host for the next merge window.

Thanks,
Andi

