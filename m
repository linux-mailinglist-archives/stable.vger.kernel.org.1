Return-Path: <stable+bounces-26784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12F871EC4
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 13:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C66B23475
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 12:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2B15A4E5;
	Tue,  5 Mar 2024 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlXlibw3"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA87A5A10F
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640911; cv=none; b=EA8uKD569FQe+lc6eBasNXTntCIaiVPIom5bGmHbiWeQmTm5O0L41ttzg7VLBqB1Ai9eCHrmUF8hGXnoqZm/6VqDHQVJF9GRDP8zbtGsuKa1ZXTqBBOFRh1G6VbKrxC1D3Ei0EEGSPBHUjnTj0tJQ5jym0/mMn1nYv8KmPtM6+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640911; c=relaxed/simple;
	bh=RCaP4GDWT87Zd9IUZzQQpBKEXe+s1x2lF2pIn4GuNXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzSLCwHUfaYxwT4wrUewS+CxMaRP6z6Gebnle085z1Z9Ello+rHS6ASU0cQSkntLKAtY1rDBulm0VpQhCyRebWGzjdKv5fxTijWznNruYHRUKR+1WPbkrm/c49wix2F9cmWcplbUlhOU8CqvWygSkIyEpUvjxphDgyowy2+k+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UlXlibw3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-608a21f1cbcso4780557b3.0
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 04:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709640908; x=1710245708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVW/PXVs5nzy5Gr+BEyjbP8Shu9TAluG0kZZRSGaf1s=;
        b=UlXlibw3caQYA57kMfjNtfV6yf5J+oylhS9K4ZXt73FtLQhoSMTyKVWUDyiZYM9FlO
         EpBnaNdd20YdCCHFYLDfAnnK92S9dPpJ2Y9GVPA05wQI9IcIc2O1F8zGjuqEbuf3blQA
         Xj9Fvt86ML6cxLIoamGCj1otdU1z5qe1RbQvrj8ausuGUyRf1TBAKvzTjczJAhCmix1s
         qTtYnakLOvJnfliFe+S++misrWDWyrDGTwvbUAKHi7KiM62Jz34pKCbGwLnoWqAzuB2h
         cHAWIhmJRSiprowLH6F341m3oIAjgIg4nZXuKHrW/AA6Caed9MyL3loyZrer3w39SvHg
         fi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640908; x=1710245708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVW/PXVs5nzy5Gr+BEyjbP8Shu9TAluG0kZZRSGaf1s=;
        b=dG9A3KMzbG3Fe8PpKUxM0J5c0kwUY1bmqM901T0q3NsdynqVbG4HM2UsAQgpgXOzEs
         2u4fCUhUwqLq7mUFqmDHjux1eDYXTeo7THE4nVDs3iAh5gadGI1iOX2sVlDDWE1zYPi+
         PK9KGvaNqjU82kt7ECo8ZbV3QeBxA9Wvt1se3P2bbkUEmQcfqSBBlgdgsIIT59GIMfON
         wvnRPqEwjpHWQ5ly/qoVbvg4kaLCbLHpHyPDuHl/p6xJeIMkZ3C49GmSvrgZ/jm6HFwW
         dqRBTBRldMfh09KdM04b3fDpeO3rPAudbs6bBAZ1zbWqu3GgUeqV9nGsuxdt5Hv/9E7Y
         28Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUhLQbbLmeft6GqTYurXebS22bKCu/6aM2dQTxCDkkPAruZvWw5R+B3kaEdk+1pJQWV1MKwmX/goEnXml5vSdLMrhwqTqTS
X-Gm-Message-State: AOJu0YxzMmjwhZGn7mJMVuH0KaHVYlydjHf3ezH+6R9Wh3E6ifw53iHE
	nIdSdvUXBN6KlmchSCELtDaV2QnZSWdC2DMh8U+Sv7Ho8Vkh5BFhXdllrwP2ILm4tWuLPdiEJ4P
	R1aF7sXX+QxEkde+Vo5iNJrsXrugnNt9km97woA==
X-Google-Smtp-Source: AGHT+IE2Y4cAajm9+l0CPilDWB96P4S9WhAwezHUZMdrZBUawlG/ZjtdnYQewd1l4phaxcPiQSTerAEAXTI4XU4tz+w=
X-Received: by 2002:a25:660c:0:b0:dd0:c2a:26f9 with SMTP id
 a12-20020a25660c000000b00dd00c2a26f9mr6859439ybc.27.1709640907662; Tue, 05
 Mar 2024 04:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305104423.3177-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240305104423.3177-2-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Mar 2024 13:14:31 +0100
Message-ID: <CAPDyKFryGhRju5CohRipXk9E_G3kob2g8=VztjtPBZ_i6D9Ugw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: tmio: avoid concurrent runs of mmc_request_done()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, 
	stable@vger.kernel.org, Chris Ball <cjb@laptop.org>, 
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 11:44, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> With the to-be-fixed commit, the reset_work handler cleared 'host->mrq'
> outside of the spinlock protected critical section. That leaves a small
> race window during execution of 'tmio_mmc_reset()' where the done_work
> handler could grab a pointer to the now invalid 'host->mrq'. Both would
> use it to call mmc_request_done() causing problems (see link below).
>
> However, 'host->mrq' cannot simply be cleared earlier inside the
> critical section. That would allow new mrqs to come in asynchronously
> while the actual reset of the controller still needs to be done. So,
> like 'tmio_mmc_set_ios()', an ERR_PTR is used to prevent new mrqs from
> coming in but still avoiding concurrency between work handlers.
>
> Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
> Closes: https://lore.kernel.org/all/20240220061356.3001761-1-dirk.behme@de.bosch.com/
> Fixes: df3ef2d3c92c ("mmc: protect the tmio_mmc driver against a theoretical race")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>
> Cc: stable@vger.kernel.org # 3.0+

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> Change since v1/RFT: added Dirk's tags and stable tag
>
> @Ulf: this is nasty, subtle stuff. Would be awesome to have it in 6.8
> already!
>
>  drivers/mmc/host/tmio_mmc_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index be7f18fd4836..c253d176db69 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -259,6 +259,8 @@ static void tmio_mmc_reset_work(struct work_struct *work)
>         else
>                 mrq->cmd->error = -ETIMEDOUT;
>
> +       /* No new calls yet, but disallow concurrent tmio_mmc_done_work() */
> +       host->mrq = ERR_PTR(-EBUSY);
>         host->cmd = NULL;
>         host->data = NULL;
>
> --
> 2.43.0
>

