Return-Path: <stable+bounces-210579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCsoECLPb2mgMQAAu9opvQ
	(envelope-from <stable+bounces-210579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:53:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D553C49D5C
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 19:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 487B582DE10
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE99C3A0B17;
	Tue, 20 Jan 2026 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ7iEYlS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A643350A0E;
	Tue, 20 Jan 2026 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929539; cv=none; b=pMAtqsNqhsDpOIo0LfzLEVL8l64+FGbZwFTOPMnOtd51onRv8jpCsMCLZde2QgjEV9NwkZf6ruKoDq1wzWTQczZzBpzAu2dm0WTqcm3VTk/a0F9kaL4eYFJ/Hhg1kABAL7D3TivxnOU95foF/WXpNyE4upt8lnjamFjwti/L5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929539; c=relaxed/simple;
	bh=e9yDWRN6uIP000lPWKUP2Jt2rEV8HOUBMGOWaexDaRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuKVX/bqOIbcyObhez4L0wwYV2WLznWgYoVyfxiH9FkhXWy5run52pWoFeY30B62KIFHOax9dIQZ/dUIJEiHfGwux9ft5A7ayhXfl5jOeQLvTcqPaTdQ0z4s4dN04nPxn1FVeymH3mP7nKvDgPgpIl6qxxEVi9lV9gvMr2pY65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ7iEYlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9740FC16AAE;
	Tue, 20 Jan 2026 17:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768929538;
	bh=e9yDWRN6uIP000lPWKUP2Jt2rEV8HOUBMGOWaexDaRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQ7iEYlSGAjrbMLVkeK28+4oWOWdDi+lbkg9Ck4ICnuTVBzjuyeF1ncVNE2iszV94
	 n0DVAIaJp5/UMUMkwHPvdjoQ6g0XJZ1NG9GAQBExdm0SkU3/8y+ZOJu9qLYZ296gMt
	 LH6WTZmRr5mAsAG/u8GHO0Ffx9E2QIJVZIPIr4T+wNCXAyzKAsI46WPED02fwi8i4A
	 rzxk4UCW8kF7KyC6sh3n6Zo0xRqy2H7WVMy4LXA31vArDIejOeDYVQZf5SqJFKF2ZP
	 RKDZpr0Yqc9aVuFqAseqEoGWRLXrBJ8NMk/JchKrj1rtYYMGgD3Cugav3uJckoE/8z
	 SY6w+cibQWdYQ==
Date: Tue, 20 Jan 2026 17:18:53 +0000
From: Lee Jones <lee@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Pascal PAILLET-LME <p.paillet@st.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Sean Nyekjaer <sean@geanix.com>, kernel@dh-electronics.com
Subject: Re: [PATCH v2] mfd: stpmic1: Attempt system shutdown twice in case
 PMIC is confused
Message-ID: <20260120171853.GH1354723@google.com>
References: <20260115173943.85764-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260115173943.85764-1-marex@nabladev.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-210579-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,st.com:email,crapouillou.net:email,dh-electronics.com:email,geanix.com:email,nabladev.com:email]
X-Rspamd-Queue-Id: D553C49D5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 15 Jan 2026, Marek Vasut wrote:

> Attempt to shut down again, in case the first attempt failed.
> The STPMIC1 might get confused and the first regmap_update_bits()
> returns with -ETIMEDOUT / -110 . If that or similar transient
> failure occurs, try to shut down again. If the second attempt
> fails, there is some bigger problem, report it to user.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6e9df38f359a ("mfd: stpmic1: Add PMIC poweroff via sys-off handler")
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Lee Jones <lee@kernel.org>
> Cc: Pascal PAILLET-LME <p.paillet@st.com>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Sean Nyekjaer <sean@geanix.com>
> Cc: kernel@dh-electronics.com
> ---
> V2: - Use a retry loop
>     - Cc stable
> ---
>  drivers/mfd/stpmic1.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
> index 081827bc05961..9caf2b8740829 100644
> --- a/drivers/mfd/stpmic1.c
> +++ b/drivers/mfd/stpmic1.c
> @@ -121,9 +121,24 @@ static const struct regmap_irq_chip stpmic1_regmap_irq_chip = {
>  static int stpmic1_power_off(struct sys_off_data *data)
>  {
>  	struct stpmic1 *ddata = data->cb_data;
> -
> -	regmap_update_bits(ddata->regmap, MAIN_CR,
> -			   SOFTWARE_SWITCH_OFF, SOFTWARE_SWITCH_OFF);
> +	int i, ret;
> +
> +	for (i = 0; i < 2; i++) {

  for (int retries = 0; retries < MAX_RETIRES; retries++)

> +		ret = regmap_update_bits(ddata->regmap, MAIN_CR, SOFTWARE_SWITCH_OFF,
> +					 SOFTWARE_SWITCH_OFF);
> +		if (!ret)
> +			return NOTIFY_DONE;
> +
> +		/*
> +		 * Attempt to shut down again, in case the first attempt failed.
> +		 * The STPMIC1 might get confused and the first regmap_update_bits()
> +		 * returns with -ETIMEDOUT / -110 . If that or similar transient
> +		 * failure occurs, try to shut down again. If the second attempt
> +		 * fails, there is some bigger problem, report it to user.
> +		 */
> +		if (i)
> +			dev_err(ddata->dev, "Failed to access PMIC I2C bus (%d)\n", ret);

Users aren't going to care if this works on the first or second attempt.

I would only issue the error once we've given up.

No return error in the fail case?

  define NOTIFY_DONE             0x0000          /* Don't care */

Harsh!

> +	}
>  
>  	return NOTIFY_DONE;
>  }
> -- 
> 2.51.0
> 

-- 
Lee Jones [李琼斯]

