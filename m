Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643E97E6C69
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 15:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjKIO2e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 09:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjKIO2d (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 09:28:33 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91825184
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 06:28:31 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a90d6ab962so11106557b3.2
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 06:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699540111; x=1700144911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OiBm5sPw96SiR0IGoxFNn3RBFbgfNC/bWK202lBgfEU=;
        b=U3q2Dkg6Pv9Dp5wlJDo0T/7BOsQ48MH+8pfHJXAUPDYAMSaaFT6SFA88V4qHUHAvyW
         x2/CJ5hhLuj/u5iIJnnqqcQ0VH3Se8UdOOKFZuT7OvAiZ0vMjgvNdwWJswW/5ZFUh/fT
         i5sxut7hhzsp95y7jkd5OSUD1FPOGvLtj8GF/gh+JPrtMSQ7VZ+70IjPIE1+KgS/5ls6
         0LtvfzjtJOFNsy+6rtQomS4QQTUJ1FytJEwetTrRliClt057QpTVnt+msCGZ9ICU+rNP
         9anl0zmT8qFcvqKj/JsY8y/e1SatZlOzgAW6crT+Lu4qmJvmPKfX96firCU6RBse6hER
         shUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699540111; x=1700144911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiBm5sPw96SiR0IGoxFNn3RBFbgfNC/bWK202lBgfEU=;
        b=vbyeZJhSko+sgPiPyU+apA5PgwEf5eGwZbqaR4p4r8LBuHzDaBhcbBQLF3AdOypmof
         GOBpwJ0td6jU+7cLDh+rqVCyG/Vpb2pnrkPDTT9b2axSs3iEzEIHuN2eZmXsJKdjPpuz
         9Q9XUvNfzaYOGMYNldrIvo7/Tud77vKFPLdKWkkr4SDecLQXJq3s/0+bF382LhmWLDrG
         RRvrfvVnx3LAuVwOm6L32mz6t7io9YqPer2zgO889LBKExJ1KTJQOOyeNHrIjsazXxz1
         wzlWn8P+WytI8ASk4ONptNfSNbLsiUjTeAaC8muV6Ri0KF+pvscaNWrkF28XRd9ekn6R
         8N7Q==
X-Gm-Message-State: AOJu0YzNrEAnHV4ouK/ea0YLV/Wlv8HU60PRmVvXBNzG6m9GVtYX638r
        hjYV6RP+v5DNWkb0NK96g8zE8fgRKpRzdq+Ic39Jug==
X-Google-Smtp-Source: AGHT+IHjHrbh0/nqFgWusFIU7pH6Xcx7ZGhZvYC7PoVRBLlGmpMQi61cINEisGMWZuPi4JdaAzan8N4NV0ogrYpHwPw=
X-Received: by 2002:a81:9242:0:b0:5a1:d398:2e with SMTP id j63-20020a819242000000b005a1d398002emr5540050ywg.37.1699540110602;
 Thu, 09 Nov 2023 06:28:30 -0800 (PST)
MIME-Version: 1.0
References: <20231109093100.19971-1-johan+linaro@kernel.org>
 <0edf26f9-46c8-4c9b-a68e-a92a78b5684e@linaro.org> <ZUzjFFUc1dOE8C54@hovoldconsulting.com>
In-Reply-To: <ZUzjFFUc1dOE8C54@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 9 Nov 2023 16:28:19 +0200
Message-ID: <CAA8EJpoAwFaush7GQgp=LSmd7OyfBLFw+fLRanqY3wD8p8KZKQ@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: pmic_glink_altmode: fix port sanity check
To:     Johan Hovold <johan@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 9 Nov 2023 at 15:47, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Nov 09, 2023 at 02:28:59PM +0100, Konrad Dybcio wrote:
> > On 11/9/23 10:31, Johan Hovold wrote:
>
> > > -   if (!altmode->ports[port].altmode) {
> > > +   if (port >= ARRAY_SIZE(altmode->ports) || !altmode->ports[port].altmode) {
>
> > I'd personally use PMIC_GLINK_MAX_PORTS directly but it's the same
>
> That's what I'd generally do as well, but here I followed the style of
> this driver (and using ARRAY_SIZE() is arguable more safe).

I'd prefer ARRAY_SIZE here too.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Thanks for reviewing.
>
> Johan
>


-- 
With best wishes
Dmitry
