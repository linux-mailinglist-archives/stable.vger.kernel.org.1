Return-Path: <stable+bounces-83336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8113B99843B
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 12:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C0BB240A8
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C281C1C1AD2;
	Thu, 10 Oct 2024 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXQPah5z"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9631C0DCC
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557725; cv=none; b=FPBBQyyHfRc2gduTGb/IlVPaaF6h3im3IL75nXofD9UGjpePG7A5J2UOm3VYB8t1LJ9QIfvtFxRq2j46sgHDs2zDtOCe3esU16yOFmTyNg3bLIr4Bhzbz9X3AP4ldnkTMlBNV2RY4De1321jx/4E3m4jbaTs/QvElHugQU/zFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557725; c=relaxed/simple;
	bh=WwiIGmhyGOdZon8LAJcoEDUYGTqw+cL2/HmhFVSNbQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C31n0RiSG1MURebAywuu8PTjagfrOhYyQh9DYuGhT9oqM+PiuPfMMF77o2chKLTrYb9io8MsBJHOHypXx/11Cu3me4Yb3NK8Auk+BUMQofJQ+ddpDQfx/kR7dp4Zeih7v14ajtD5GvxwWhLk8App/bvvu8WAimc+jGNkgiCev98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xXQPah5z; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6dbb24ee2ebso9129777b3.1
        for <stable@vger.kernel.org>; Thu, 10 Oct 2024 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728557722; x=1729162522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7VGs/fU4SpegpQzbG2AYNWcbAGbbD3orYU7SBex+GqM=;
        b=xXQPah5zkZ3pXMjl1jQjwPztSHx6T/n0fnHKw3PEHMU2/uREicaX8QP99Z9vczKgiC
         CmZxMVVZEAMQqQ9jWOZ18X8q9+MGrh/Tax/NdrWjF/aHoFralMo6V7Qbd9PW6LVO5y2x
         RjeZSg7DikOCLKuqginmSrXOSkD/e9q4s4Bgya7889BdyjBJoO6EGaCigkyEErKmFsvV
         CKQZd6e0QfQN+OQbBRgE6mRNNPiElJVYGmZO/7+J5O1cpn6iozzDsUn5PUB2v1go5wtT
         +Eya94CbMX8TxpsojZo2atXjVUo2Dh0AcW+9zhGf4ZGpv+DHAfwcoYI8hFiRGHxLTK+W
         QE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728557722; x=1729162522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VGs/fU4SpegpQzbG2AYNWcbAGbbD3orYU7SBex+GqM=;
        b=p95FJgGVk3aoXS5iXa/x+ZgXO6oYm/+nO/M58EQceoFkjYtvMxgnoMCjPorVj3uWDY
         6Kp1PIW7nReware8oluDcOypEHjUnJTR9KOh+deTX2wbFkDXGryUYM8qZdFqyuKQfAkx
         x6KpMm7TffUKLcJw8I0LWBtSVhOOKpNt3Cq2wmUKRddEyqltxvMfnkAW8OIvyvBbVzv3
         XdneQ7oam48oxOYSBzyA8fNFAoVSsa8BQIe2DlsICs6/nqg1tTH/L6TohPLIOwuEwm1Z
         8XN/I2DAagNTDb7MhJjbwu7Yjh0CVKk6dFIFxoXzFSdRyexDJ1WgJXwjhTCUAXdGZrkq
         v73w==
X-Forwarded-Encrypted: i=1; AJvYcCXkb6ye9t546KJ31avwVJRqnps8y+je6vDAqd8iGP5CwYvgs/pcF13WpgMoL71lLAfi7lOs9Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjqbPpriCFOUF8FDHQY5BQ0Y/tG/A6aELoDJ2VB0Jr6Q3vJYX
	f1UBl78h8A4TAWOWlMsKvirB9H7C/r6dj8N4N8xJ6BcPxZoAYgfkl3M4oDkr4gA1MM2KnUxDjI3
	UDoHd2bfnRfXXCZwkQSsJUW2h/nHfUaeqmGQexA==
X-Google-Smtp-Source: AGHT+IG1+R1ihC/1zJ5/CzYx7qkYB8pOlHdDW4xPGn5q3The6Ty0NU52LviZm5BHoiKxIMgoBbp/st/dwycsc6TdX98=
X-Received: by 2002:a05:690c:298:b0:6e3:36fd:d985 with SMTP id
 00721157ae682-6e336fdd9eamr4919897b3.23.1728557722397; Thu, 10 Oct 2024
 03:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010074246.15725-1-johan+linaro@kernel.org>
 <CAA8EJpoiu2hwKWGMTeA=Kr+ZaPL=JJFq1qQOJhUnYz6-uTmHWw@mail.gmail.com> <ZweoZwz73GaVlnLB@hovoldconsulting.com>
In-Reply-To: <ZweoZwz73GaVlnLB@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 10 Oct 2024 13:55:11 +0300
Message-ID: <CAA8EJprg0ip=ejFOzBe3iisKHX14w0BnAQUDPqzuPRX6d8fvRA@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: mark pd-mapper as broken
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Chris Lew <quic_clew@quicinc.com>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 13:11, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Oct 10, 2024 at 12:55:48PM +0300, Dmitry Baryshkov wrote:
> > On Thu, 10 Oct 2024 at 10:44, Johan Hovold <johan+linaro@kernel.org> wrote:
> > >
> > > When using the in-kernel pd-mapper on x1e80100, client drivers often
> > > fail to communicate with the firmware during boot, which specifically
> > > breaks battery and USB-C altmode notifications. This has been observed
> > > to happen on almost every second boot (41%) but likely depends on probe
> > > order:
> > >
> > >     pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to send altmode request: 0x10 (-125)
> > >     pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to request altmode notifications: -125
> > >
> > >     ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI read request: -125
> > >
> > >     qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: failed to request power notifications
> > >
> > > In the same setup audio also fails to probe albeit much more rarely:
> > >
> > >     PDR: avs/audio get domain list txn wait failed: -110
> > >     PDR: service lookup for avs/audio failed: -110
> > >
> > > Chris Lew has provided an analysis and is working on a fix for the
> > > ECANCELED (125) errors, but it is not yet clear whether this will also
> > > address the audio regression.
> > >
> > > Even if this was first observed on x1e80100 there is currently no reason
> > > to believe that these issues are specific to that platform.
> > >
> > > Disable the in-kernel pd-mapper for now, and make sure to backport this
> > > to stable to prevent users and distros from migrating away from the
> > > user-space service.
> > >
> > > Fixes: 1ebcde047c54 ("soc: qcom: add pd-mapper implementation")
> > > Cc: stable@vger.kernel.org      # 6.11
> > > Link: https://lore.kernel.org/lkml/Zqet8iInnDhnxkT9@hovoldconsulting.com/
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >
> > Please don't break what is working. pd_mapper is working on all
> > previous platforms. I suggest reverting commit bd6db1f1486e ("soc:
> > qcom: pd_mapper: Add X1E80100") instead.
>
> As I tried to explain in the commit message, there is currently nothing
> indicating that these issues are specific to x1e80100 (even if you may
> not hit them in your setup depending on things like probe order).

I have the understanding that the issues are related to the ADSP
switching the firmware on the fly, which is only used on X1E8.

>
> Let's disable it until the underlying bugs have been addressed.
>
> Johan



-- 
With best wishes
Dmitry

