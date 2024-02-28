Return-Path: <stable+bounces-25383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B255886B343
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 16:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3EC71C20F59
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2354A15CD6A;
	Wed, 28 Feb 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUKVQzDh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D115D5A7
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134631; cv=none; b=qPcXNjGenKRa6lz0rh/IwDflMJcNWJiBhMxqjn91Ttm1Dbsnz2SG/+cSAp1Dpvwa3HQWfoKU3tQVS3+bTEteHG6FwaEzweU1fORnLiMO0e1lDbSjI03blm2//7u5gAtjPSJpidEHKMvbCGvkPh5/3r+U6XWkmNJ7mMxXLkERY5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134631; c=relaxed/simple;
	bh=zGa+IyFAz8kwIE7x38Wl0fe/t7lkIR01+L6mE1MqudM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKxKF1b3teml8ZcnJ9Jcv8X82Cs7TGouVHcr1H0ZRBeTUeLJL7B0ESt4HG+rB5+rXNKIzEDzVfgO9HYyWNx7/vEdTUT3Bo+M3Hsaqn09pH69I4Y3Z5Y3m+lsGKyI/O/klI50UBl6zS9RzkqTYSZF22/diI84LIA69Mz6cHr5Ye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TUKVQzDh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7268773a12.0
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 07:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709134628; x=1709739428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8dVCImcIlLLiITmfEBgBjhdVxqWWMzlc8Dv1nyWSOGo=;
        b=TUKVQzDhnvGkhODw3ShNo58Wb7gAODf+QVCs7R7LbdhcBr0/Mw1AVlyMs3ZoulFJWd
         YggH7IsV3h8mzUYvY/4FsOxcxyqgYf71gNNkrxYJyNgjfEVNdRuopE/r1wFjYv9KyeSz
         Vv7c2kZV7sprdNuc3FMsYw4t9LCjc7eBrV4kjpSsoC2gzwJ/6s519UyKuvKZmn27Lqe8
         c7bOhv8h7DGN3iXo6jbjgncU3aIVkfSexCEzRCjc2aFTpNuSmoF8dpnEnZqf1Bk0jxsu
         gCAW9KpiwyjWQl0d4YHCV6Pky+PqMn/TgEQ3pZhJfUFKHSygIRYIWjafunFdbpAroape
         TYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709134628; x=1709739428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dVCImcIlLLiITmfEBgBjhdVxqWWMzlc8Dv1nyWSOGo=;
        b=YY+ukwbiFwco9faaCDzR9jM7g6XZTae2Ll44iJuYJcsckW0PTUSaDSvmqCdJAmIMH1
         VMr3SwBLbqpxYTR0zEKT7qVEc+zrdKi/nv08rrWgOy3el9iX8I1BRXEx13C4n+U5QyZ1
         WPK/FB46qesrR77rsLFVLxi0YqN44s5XayIiFAyTRWRCsyBzxveqTNXXdkTJD5su1kzw
         whh8sW7wYGOGJsFZbgZWWcpCyhFpZsrWnVRjbtBXyYsvPwq+pADOt/SCZd3k48OVk8Xc
         DQnDmTTogq19YvwHDIKlGrWhvjO9DDha4dBkv+JoUkCvG2bZBIPyhaemfePQ6NvEYFx0
         rXZA==
X-Forwarded-Encrypted: i=1; AJvYcCUEzBOsjcALwHwH90+TLDAbdpvM7/aQZyYb8jBbiEQZ46uSshhIob2fkYGAV2uqdg9NkZhJhcgYk8WoYxFooAzG+GxBeT/Q
X-Gm-Message-State: AOJu0YwNr3sljzRQNA5cuE98wJrfCmSdqmS+uTdLyI0zW3v2IsRx5Ari
	2bFoJ0UMf42VXJbnGopgF0gjl5bBgFBnlf3Jegu7uqPNrUAZa6BsJfO7opSpK9qraq21TMvmrxk
	LpZyFVwUjIHeRgdjNI68YaOCz3lfOHqi3Jw40eg==
X-Google-Smtp-Source: AGHT+IEQVtJyu0GYHAWdmf+6eoRlVi/P3F2RUBvk49c7M8VZVlNSEYmKA5V/4aGFP0UZhJeY+ePLjPp6XOoBzr5CUX0=
X-Received: by 2002:aa7:d982:0:b0:565:fb4c:7707 with SMTP id
 u2-20020aa7d982000000b00565fb4c7707mr5488857eds.26.1709134628391; Wed, 28 Feb
 2024 07:37:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com>
In-Reply-To: <20240226-rpmhpd-enable-corner-fix-v1-1-68c004cec48c@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 16:36:30 +0100
Message-ID: <CAPDyKFodDx7evDGiJChDohv8qK+9QMpwp6+Z6DrJUWOtMhYfsA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation
To: quic_bjorande@quicinc.com
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Stephen Boyd <swboyd@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 02:45, Bjorn Andersson via B4 Relay
<devnull+quic_bjorande.quicinc.com@kernel.org> wrote:
>
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> Commit 'e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable
> the domain")' aimed to make sure that a power-domain that is being
> enabled without any particular performance-state requested will at least
> turn the rail on, to avoid filling DeviceTree with otherwise unnecessary
> required-opps properties.
>
> But in the event that aggregation happens on a disabled power-domain, with
> an enabled peer without performance-state, both the local and peer
> corner are 0. The peer's enabled_corner is not considered, with the
> result that the underlying (shared) resource is disabled.
>
> One case where this can be observed is when the display stack keeps mmcx
> enabled (but without a particular performance-state vote) in order to
> access registers and sync_state happens in the rpmhpd driver. As mmcx_ao
> is flushed the state of the peer (mmcx) is not considered and mmcx_ao
> ends up turning off "mmcx.lvl" underneath mmcx. This has been observed
> several times, but has been painted over in DeviceTree by adding an
> explicit vote for the lowest non-disabled performance-state.
>
> Fixes: e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the domain")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZdMwZa98L23mu3u6@hovoldconsulting.com/
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> This issue is the root cause of a display regression on SC8280XP boards,
> resulting in the system often resetting during boot. It was exposed by
> the refactoring of the DisplayPort driver in v6.8-rc1.
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> index 3078896b1300..47df910645f6 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -692,6 +692,7 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
>         unsigned int active_corner, sleep_corner;
>         unsigned int this_active_corner = 0, this_sleep_corner = 0;
>         unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
> +       unsigned int peer_enabled_corner;
>
>         if (pd->state_synced) {
>                 to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
> @@ -701,9 +702,11 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
>                 this_sleep_corner = pd->level_count - 1;
>         }
>
> -       if (peer && peer->enabled)
> -               to_active_sleep(peer, peer->corner, &peer_active_corner,
> +       if (peer && peer->enabled) {
> +               peer_enabled_corner = max(peer->corner, peer->enable_corner);
> +               to_active_sleep(peer, peer_enabled_corner, &peer_active_corner,
>                                 &peer_sleep_corner);
> +       }
>
>         active_corner = max(this_active_corner, peer_active_corner);
>
>
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20240226-rpmhpd-enable-corner-fix-c5e07fe7b986
>
> Best regards,
> --
> Bjorn Andersson <quic_bjorande@quicinc.com>
>

