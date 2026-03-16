Return-Path: <stable+bounces-225629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF0+IMA6uGmpagEAu9opvQ
	(envelope-from <stable+bounces-225629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:15:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F6D29DF2E
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02520304E7D3
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16873D1712;
	Mon, 16 Mar 2026 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="FcStwyyZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2386D3D16ED
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681211; cv=none; b=lxfn2e1SdEFzpJNT6+FU4ZoxM6eixis1NrvvSlPTtx82nO9SaNHbD7Ps62yT6ss6ggKUaW69ci6WnEn4wk6+Mk+by6SzEh4eH0TUrBDWb0Jf9vgs4Qoda7likENkCQA6esSh4DaTzTGbQKhqiK0DEinxQsSakYC0eqY8gPnZXpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681211; c=relaxed/simple;
	bh=b0j9oNMdJdMNOAdm/nemFGVAa/OM2F5Qihg0k+VobB4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PvUCvjTiyxzBEszCm8h6LZ3MsdRCmRKHstaBkGd464xGD3SjuhVGJdl+QJfCYLMiLgeOtM5a5f54teZVpLDm0/dN2HD53Ma+oz/CnkGHL1TLMY7RIHOjH9mzq59x9jjTtNrJnSRbZyxJOoHtPgsVN3sO/8jb045j2yNllBKFgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=FcStwyyZ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89c4468686dso23980146d6.3
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1773681209; x=1774286009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KKNAuzsfMofCUgk72CAOSiu5PG9m6z3uwFl0PtKhug=;
        b=FcStwyyZ8gyclUrfQjU/lMyplpfjh3DO6tv0bzAzIuz5J52bmArgYiAjNJVJ8zGrxC
         hpFFOq+CQ5tPMhmXYG0I217C4VKSSK4z84+Km1n11moJPyTq/fORMwbo0bGuz4Z6r5zz
         WK6V9uiz5keZg+FtLfLyOuELIjQ1WiGZflW1JcoXKRXCEvnaAWjWaG9RMINThxjOZxbP
         sntcvUt2dlUvE1Iqit3wuShGnZWS30DbGF6O8mocLKrmVQyJUN5lQfsozIpTAdpmDi1C
         0sC3L0QnUvTGLZovq89e17WYx4/3huofjKteYhvSj3ApWiaduQWtqcKkMoVzuC7lSBmG
         0DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681209; x=1774286009;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KKNAuzsfMofCUgk72CAOSiu5PG9m6z3uwFl0PtKhug=;
        b=Y21LAehtVNr0Cul0Y79RdSdlYmoltsH2/6zlBSX9zFqUclaPINqQbntjvpPFMiROnu
         7t3tDWc/d4YcFqhYJK5ZnCUcIFCgE8UJsumoTM3ZDAS0H9bSoLQKqjxEb/R15GgMvMcT
         mv0xwF122xx9lZ6SJn3J7xvdOXQ3k7l22wDHzzKvF81JoohEnnDipRK/KOQal9VdAyAe
         AuEFFhi/uOZ+LyQck7BcD4q9URgo0mmJdaPPmSyZK5QEm3beWFIi5wWC//IUkV//UHkw
         39lcg0xBr/SPCHQIYUNhr/odoXP9gQHgBiPMtNleBsYQJXdKJgYIPaG7KhD3q0vytanM
         0qUw==
X-Forwarded-Encrypted: i=1; AJvYcCXNsfvP9LJ8S32fSjSUlaIMRWeZ7pKP+iFbxxGiTeAfaNu4u3xmG4+rm0FGcwTsrwkoZ91SVLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuikAwIpyYHDF1A47kkg98O6NzQxzPlxSmyDRBBLr2H8CgqZUE
	3Vo5MgLjifjryiBO5jnxVpJ78nL1YQS01LyWgZqfIW9ixCNd2Ro+SrnUpLsWIdaqB6A=
X-Gm-Gg: ATEYQzyrCDUTQqOjusSDrZvIJsQOrL89vJv0bhKhFTL7dLQc01k0Vf7J8exrv5hzw9a
	qIL2Oi9hDGqIeHp2P7+65eJsHRnB6n+DObVPZ85P7VDXopyiJbEf40UxhQ/37MqTueENATbF5i6
	g7EDqzGMfB6HrwwaIS9STwUEHehKo4txn75ZeUyyhxFg6CenE77o4RYFwJ3GSaslYkHLHGZShEL
	4VHH+cvdAiKYprwZK3ptsJbMRHuEJ/xI9y9188xBxbVnWWG1CjTPuywxFPHO7MiTxt75BQhhQcG
	0DXKc4v1vAUmZe28E6F1sdKsJJBXypbn4zvJymMV0BxNt4403YSmRrg6BSTKR+T8dSKtMMV7ObV
	Cu8JJ/6dyY3gOGSpnxQF7USbUT2QA7/2+fxvmKFVmT3Uj45kwns67tfduruUFHBxCSKVSw2RQ1M
	Hghw98rnkQEnNwQsfI5sr7+f2vA/ucttZniHSFWZmEHp7Z/A+bt4Yzu+T5vub8noMBIGKOSQ5Ux
	CJ4uGv2
X-Received: by 2002:a05:6214:2aa4:b0:89c:505e:a96d with SMTP id 6a1803df08f44-89c505ec595mr73090966d6.3.1773681209073;
        Mon, 16 Mar 2026 10:13:29 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c440d4594sm48468046d6.5.2026.03.16.10.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 10:13:28 -0700 (PDT)
Subject: Re: [PATCH v1] spi: geni-qcom: Fix CPHA and CPOL mode change
 detection
To: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>,
 Mark Brown <broonie@kernel.org>, konrad.dybcio@oss.qualcomm.com
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 bjorande@quicinc.com, mukesh.savaliya@oss.qualcomm.com,
 praveen.talari@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260316-spi-geni-cpha-cpol-fix-v1-1-4cb44c176b79@oss.qualcomm.com>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <4a7d89ef-0f63-a7c3-e996-ff9fc476a04e@marek.ca>
Date: Mon, 16 Mar 2026 13:13:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260316-spi-geni-cpha-cpol-fix-v1-1-4cb44c176b79@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marek.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-225629-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[marek.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marek.ca:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan@marek.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marek.ca:dkim,marek.ca:email,marek.ca:mid]
X-Rspamd-Queue-Id: C0F6D29DF2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Jonathan Marek <jonathan@marek.ca>

at least it doesn't look like this stupid mistake breaks anything 
upstream (no spi-cpha/spi-cpol in any qcom dts)

On 3/16/26 9:23 AM, Maramaina Naresh wrote:
> setup_fifo_params computes mode_changed from spi->mode flags but tests
> it against SE_SPI_CPHA and SE_SPI_CPOL, which are register offsets,
> not SPI mode bits. This causes CPHA and CPOL updates to be skipped
> on mode switches, leaving the controller with stale clock phase
> and polarity settings.
> 
> Fix this by using SPI_CPHA and SPI_CPOL to detect mode changes before
> updating the corresponding registers.
> 
> Fixes: 781c3e71c94c ("spi: spi-geni-qcom: rework setup_fifo_params")
> Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
> ---
> This patch fixes SPI mode change detection in the spi-geni-qcom driver.
> 
> setup_fifo_params compared spi->mode against SE_SPI_CPHA/SE_SPI_CPOL,
> which are register offsets instead of SPI_CPHA/SPI_CPOL mode bits.
> This could skip CPHA/CPOL updates on mode switches and leave stale
> clock configuration.
> 
> This is a single-patch series.
> ---
>   drivers/spi/spi-geni-qcom.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 43ce47f2454c..772b7148ba5f 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -359,9 +359,9 @@ static int setup_fifo_params(struct spi_device *spi_slv,
>   		writel((spi_slv->mode & SPI_LOOP) ? LOOPBACK_ENABLE : 0, se->base + SE_SPI_LOOPBACK);
>   	if (cs_changed)
>   		writel(chipselect, se->base + SE_SPI_DEMUX_SEL);
> -	if (mode_changed & SE_SPI_CPHA)
> +	if (mode_changed & SPI_CPHA)
>   		writel((spi_slv->mode & SPI_CPHA) ? CPHA : 0, se->base + SE_SPI_CPHA);
> -	if (mode_changed & SE_SPI_CPOL)
> +	if (mode_changed & SPI_CPOL)
>   		writel((spi_slv->mode & SPI_CPOL) ? CPOL : 0, se->base + SE_SPI_CPOL);
>   	if ((mode_changed & SPI_CS_HIGH) || (cs_changed && (spi_slv->mode & SPI_CS_HIGH)))
>   		writel((spi_slv->mode & SPI_CS_HIGH) ? BIT(chipselect) : 0, se->base + SE_SPI_DEMUX_OUTPUT_INV);
> 
> ---
> base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8
> change-id: 20260316-spi-geni-cpha-cpol-fix-89126ed55325
> 
> Best regards,
> 

