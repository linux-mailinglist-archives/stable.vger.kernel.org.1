Return-Path: <stable+bounces-254553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHrrKMvRFmowsgcAu9opvQ
	(envelope-from <stable+bounces-254553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:13:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA5F5E334B
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5078C3022685
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 11:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9895A3F2113;
	Wed, 27 May 2026 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y68ft7eF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457F3EA942;
	Wed, 27 May 2026 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880331; cv=none; b=WB1aspvbHG6q0fcLvT1Z8ygrRPUAmFE0XD71oxYZbtrlIWrOO0J8OYOvN+1up47slrO9zBdDxNiJf68nTQigtrMOfgBbygFWjVCujcO7kLEmQlnHF+RwP1Pj1tQkyZXzjsYFV1wDL2E5Q10jU1qDJwQs1+da4mohfOEpuSQcbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880331; c=relaxed/simple;
	bh=/0Yl9DBWSv2OSjUohiMto+Cg+AKLFW9utAbxd47+i78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQg7sQSYLry0Gzb/ASa7RHFqHLvOncueHG1xc/ghDpXsmypsTheVkgrYWiPa8NLDWPkNFumdC1KprRpN4NWhYmEcC8ZcO/8WhcR3ZjaVkU4d/3p09DhAY1hcOdyLz3v1iBAeB1/EUp1nt/Idvv7l8ms6TAvKQw/LcqFST0YOzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y68ft7eF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D57E1F000E9;
	Wed, 27 May 2026 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779880329;
	bh=GYKx4trkZ+FNFeHudAQLkbpLbOCapm8PqcKEgE/jfFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y68ft7eFcOramM7PwfTWO/xzjCEmewk3L0kRh4CFBNU+ZHYWr3h3rnFyAf7cIBp1w
	 8O22qOXbCc1/X84sDCx6cop2RadQA4k2zCBXYeLSPV6xj8xIcEkCvncHV6oVChf+gj
	 srVOU8kAwxtE7wV4L8cDHP5rjRTh6wcVFr3UcxCjaG1m3z1VCCX+zxq2R7hzN91ZVc
	 aCFaw73O42ijzCD+ptc33xTIPakxh+DiMASWwe2/fG1wuTCAnFmHboLIgk4DD3DrN9
	 0WeDt27EUU2IbJtHCzBBnQHf3WaW8Zsel0JOCMs7PwmhzUtYFNrbm9ODLyiAgnxSRI
	 Y9LRNgZ7qJC/Q==
Date: Wed, 27 May 2026 12:11:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jiri Valek - 2N <valek@2n.cz>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: opt3001: fix missing state reset on timeout
Message-ID: <20260527121159.4a4f94bc@jic23-huawei>
In-Reply-To: <20260526-fix-early-return-v1-1-c70e886329f3@gmail.com>
References: <20260526-fix-early-return-v1-1-c70e886329f3@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254553-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,baylibre.com,analog.com,kernel.org,2n.cz,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,joshua.crofts1.gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4DA5F5E334B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 13:15:29 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Currently in the function opt3001_get_processed(), there is a check
> that directly returns -ETIMEDOUT if the conversion IRQ times out,
> completely bypassing the err label, leaving ok_to_ignore_lock
> permanently true, potentially breaking the device's falling threshold
> interrupt detection.
> 
> Assign -ETIMEDOUT to the return variable and jump to the error label
> to ensure ok_to_ignore_lock is properly reset.
> 
> Fixes: 26d90b559057 ("iio: light: opt3001: Fixed timeout error when 0 lux")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260525-opt3001-cleanup-v4-0-65b36a174f78%40gmail.com?part=1
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
The flow in this function is horrendous.  IF you have time would you mind
doing a follow up patch that just breaks it in two. Then have
if (opt->use_irq)
	opt3001_get_processed_irq();
else
	opt3001_get_processed_noirq();

Maybe there is some code at the end that is worth sharing - you'll have to have
a play to see if that is worth doing.

(If this was in your other patch set already then I'll blame lack of coffee!)

Applied this to the fixes-togreg branch of iio.git and marked for stable.

Jonathan



> ---
>  drivers/iio/light/opt3001.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 03c7a87b4a8eef13bbdcf48dcaf969781aa76bd1..0743e16f2a8fa0f07acd19c7dd6b54bec9e5c7b2 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -366,8 +366,10 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
>  		ret = wait_event_timeout(opt->result_ready_queue,
>  				opt->result_ready,
>  				msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
> -		if (ret == 0)
> -			return -ETIMEDOUT;
> +		if (ret == 0) {
> +			ret = -ETIMEDOUT;
> +			goto err;
> +		}
>  	} else {
>  		/* Sleep for result ready time */
>  		timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
> 
> ---
> base-commit: 0e7dbde323808f28c5220295bfc1c5bc6f08c3f4
> change-id: 20260526-fix-early-return-e2f1d3662180
> 
> Best regards,


