Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201D57E4B2A
	for <lists+stable@lfdr.de>; Tue,  7 Nov 2023 22:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbjKGVwi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 7 Nov 2023 16:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjKGVwh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 7 Nov 2023 16:52:37 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6199010D0
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 13:52:35 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6ce2de8da87so3952812a34.1
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699393954; x=1699998754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr6OJPuRPVCp0RXxF4a/PiIEDPuvoDXkbrySHNg/Fqs=;
        b=hNBB6Oh5W8ZmqZz8Sgm6mDA2SFueIXnArQke0wAHRA3cKzPvRGcNE3TtlgAA0iNNpQ
         CdyfZT2vaTJHyMd1HuC2indTXWY2zyVzU7MJJE7g5spfwcPpDYnJmuKGXEajbJeLE1kI
         uGFWzVV2T5vHpD0zessEYcr5CXunKna4JVxG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393954; x=1699998754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr6OJPuRPVCp0RXxF4a/PiIEDPuvoDXkbrySHNg/Fqs=;
        b=jtWRHvD7n7htBPTc48Bs1G+lNJV/lhrJS+KQCPyTOVg51gWXvc8ktO44fDkc+cf3Ee
         m03/L92X8v66fWVBqpNQE7booe0ALiUH24m1kF6GJ398JPsTBOAED+cNjqu696+jd1/N
         84pIIWq0rPcW7IrHSlaI28PpYQGSGqEqJyc0iigX4lA4TpbtjBfXzupnIKCTGBW1ahw8
         R9SQvyiCp22eTJKKHAn8a4U1lvRl05KctiFWWrCASTO4TahIgv3uW2YxYx1zDvcIKsg/
         1AbCcqUrNH7ubVLMWcJdj0YRSYimm+tVz/1d7Vh4cBj6DSaSQsSdX8+DATSRxAqx0zui
         xzTg==
X-Gm-Message-State: AOJu0Yzj733+o0dqGNkpEWqU/9iczo8bJmqS/hHBfvnNMje3+C/2r2yz
        deqDN0sM9T1Zgm3SKO8Rd8XvLEMFGDqvTATpZD6H9w==
X-Google-Smtp-Source: AGHT+IHWdfR3bifkBdaoItNqZgulqc9J+gktiX1J+gjiJGeRkyvmNQ2VXl6l87uKMgSgtxr3xR3fX2EtFYyzpaToq3g=
X-Received: by 2002:a9d:7e91:0:b0:6d2:e1fd:9f5e with SMTP id
 m17-20020a9d7e91000000b006d2e1fd9f5emr127321otp.6.1699393954786; Tue, 07 Nov
 2023 13:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20231107204611.3082200-1-hsinyi@chromium.org> <20231107204611.3082200-4-hsinyi@chromium.org>
 <2023110739-parmesan-exposure-8225@gregkh>
In-Reply-To: <2023110739-parmesan-exposure-8225@gregkh>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 7 Nov 2023 13:52:08 -0800
Message-ID: <CAJMQK-g-hSN_dY5EjhuvAU4sAL0dMR7s=3murQm8E_GubS1+pw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] drm/panel-edp: drm/panel-edp: Add several generic
 edp panels
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Nov 7, 2023 at 12:57=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Nov 07, 2023 at 12:41:53PM -0800, Hsin-Yi Wang wrote:
> > Add a few generic edp panels used by mt8186 chromebooks.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > no change.
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 51 +++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
Sorry for confusion, only patch 1 & 2 need to be picked to stable. 3~5 don'=
t.

> </formletter>
