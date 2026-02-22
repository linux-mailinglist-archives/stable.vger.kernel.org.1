Return-Path: <stable+bounces-217665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMTuL+oDm2n5pwMAu9opvQ
	(envelope-from <stable+bounces-217665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 14:26:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DADE16F39B
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 14:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33AC3300C02B
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89622331A70;
	Sun, 22 Feb 2026 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYnYMlxu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E3331A4B;
	Sun, 22 Feb 2026 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771766756; cv=none; b=j3AZhfokXZz2RL85Y3rpdCZ10VydydkL73MeZT0d6xqu6fxuLYhStirFUQxUa+imhF8TQs6++FjthCXaqocSlUiBoZesWbkjxj7k7+OFnbERoFyTJHCF9GD1hbNO/jYTGjc3C296SNhhTVZ8HUnmXNSTYkPI93EoQAd7xKQoQ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771766756; c=relaxed/simple;
	bh=MvZPMoyGaIgVmDQJdwrZgE47Hm5SuVzFeNLAh5sPhZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkkyjAd69wUl/+QxiVA3SKuRlaftqZWzAYYO9WdMy9w2YD+5YsxxEetN/5Wp/OlbK73N8tDiNLWmFm+zmFHd0DTbEMJS3Th4xNDRQjWH7iuDWOlmppQbigviipdouwAkH7W74WuULkmKoieyMWPz6Mreu70L7dk7Seevxg62eAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYnYMlxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B76C116D0;
	Sun, 22 Feb 2026 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771766755;
	bh=MvZPMoyGaIgVmDQJdwrZgE47Hm5SuVzFeNLAh5sPhZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PYnYMlxu4vOH1JTqm+SLUmV44cdK3vhgg15zsOKfXkVanSpoQBhjKclp0Qd/n2VG5
	 GttKU+E/9te25bqR/9tYMMuAci1072Uc4kJxXEwKYzTObQA7zDCAqZlO6ErADZCrEl
	 PCaBen7nHwZg/d2yBS7EaaElnhhdZiEPqe70zR8ZBq7+GNN5tObNpY4O30Hi/Mnich
	 gkGk+zsQklPSheDn7Q3fj+pqTQ10RZn8jObJxHceG2IpdNbb/lyNJkU7u58DAEUNLI
	 Db5VhAT8Ljni1VBF/yO9GxXuTlvPO5Fv17zf67gP75qdWhDAMkSFhMLyMDlgtw7m5C
	 cdAlZQSlNv1AA==
Date: Sun, 22 Feb 2026 13:25:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Remi Buisson <remi.buisson@tdk.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_icm45600: fix regulator put warning
 when probe fails
Message-ID: <20260222132547.34d4134e@jic23-huawei>
In-Reply-To: <20260217-inv-icm45600-fix-regulator-put-warning-v2-1-08ad62b1dcdb@tdk.com>
References: <20260217-inv-icm45600-fix-regulator-put-warning-v2-1-08ad62b1dcdb@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217665-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,jean-baptiste.maneyrol.tdk.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tdk.com:email]
X-Rspamd-Queue-Id: 2DADE16F39B
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 11:44:50 +0100
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> When the driver probe fails we encounter a regulator put warning
> because vddio regulator is not stopped before release. The issue
> comes from pm_runtime not already setup when core probe fails and
> the vddio regulator disable callback is called.
> 
> Fix the issue by setting pm_runtime active early before vddio
> regulator resource cleanup. This requires to cut pm_runtime
> set_active and enable in 2 function calls.
> 
> Fixes: 7ff021a3faca ("iio: imu: inv_icm45600: add new inv_icm45600 driver")
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Cc: stable@vger.kernel.org
Applied to the fixes-togreg branch of iio.git.
Note I'll rebase that on rc1 once available and then spin a pull request.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Rework patch to move pm_runtime set active early.
> - Requires to cut pm_runtime set active and enable in 2 functions.
> - Link to v1: https://lore.kernel.org/r/20260205-inv-icm45600-fix-regulator-put-warning-v1-1-314ec12512cb@tdk.com
> ---
>  drivers/iio/imu/inv_icm45600/inv_icm45600_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> index ab1cb7b9dba435a3280e50ab77cd16e903c7816c..811ff80a2e626b4c2bb7b718899abe77488c7745 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> @@ -744,6 +744,11 @@ int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chi
>  	 */
>  	fsleep(5 * USEC_PER_MSEC);
>  
> +	/* set pm_runtime active early for disable vddio resource cleanup */
> +	ret = pm_runtime_set_active(dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = inv_icm45600_enable_regulator_vddio(st);
>  	if (ret)
>  		return ret;
> @@ -776,7 +781,7 @@ int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chi
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_pm_runtime_set_active_enabled(dev);
> +	ret = devm_pm_runtime_enable(dev);
>  	if (ret)
>  		return ret;
>  
> 
> ---
> base-commit: d820183f371d9aa8517a1cd21fe6edacf0f94b7f
> change-id: 20260205-inv-icm45600-fix-regulator-put-warning-7c45a49c4c53
> 
> Best regards,


