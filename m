Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CEA78E40C
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 02:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243897AbjHaAmi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 20:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjHaAmi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 20:42:38 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7828BCD2
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 17:42:35 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1c504386374so117818fac.3
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 17:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693442554; x=1694047354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlcuc28wNXxkp3oqXdY8kbbgG+AHVoBzRLKl6J2yon4=;
        b=eyKoNb9miinD3fqPA/1xWZsgNTZ2no3IsutWMuR5JNLBWiA+4l3M8dtz7JOyQSXmJU
         +/71vQfQzS/+XrtDKWsx18NggfR5WGhaM1bMlkxxRR9lz10zNClEP2FJ0hWWsSG78MlN
         4L01cdROx2vK1BTX68fUGNzX2B2gwaGhTBe/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693442554; x=1694047354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dlcuc28wNXxkp3oqXdY8kbbgG+AHVoBzRLKl6J2yon4=;
        b=R2Pioc57Lzoi6XFo6w9ua3ZLGhX4qQjXU8Q0UrVV/4N+mnJl0+V3echU5MK0jwVlLW
         bKeTkEcBuTrxC31/w5ecxfkeUJJAzKLcClkTHOxX4hNTskCH/PbTkcOj2EOj6kN4F/zo
         ClGm4Tv9zDJ71hGxMIJEndrVVhIjf7AoXu/xK71ZiMRrS2ZCvPFd7UtH0Wcvgmd2fRdF
         woAoPd/4zBQcuZNVg/YcSmjbKWP/NVXmiQhE6XzZIg+FrTfMnAx4bMZGHcGF+RNjF09k
         DH6Dtp18B3nnkbBluluixR5NpdPUAgw4wtSk4UucFfzIBuZxFrJKAHwR1jo+ymFQlrEM
         iK/g==
X-Gm-Message-State: AOJu0YzD6UjMVaDIBHi5LrgsZkF7No6i1Eq0/PifAhiGkgGExjuLobFn
        6xLu8zQCpcMESY7T4Sru6d0cXJeEiJfzyJls5Tqfkg==
X-Google-Smtp-Source: AGHT+IFdt+d3mQ5CEdRbz2IFVyH9djoyQRRp5qFBQpfUZVOvZBYJ9SHfV/cmVQO3wDX3fTDpUS6B+wVXcH/37kJVvus=
X-Received: by 2002:a05:6870:5596:b0:1bb:509a:824f with SMTP id
 n22-20020a056870559600b001bb509a824fmr4560826oao.55.1693442554700; Wed, 30
 Aug 2023 17:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
 <20230828100313.3051403-1-benchuanggli@gmail.com> <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
 <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com>
 <CAG-rBihBkTeZR6yMSF+5zg-h1U1pxGuN-nv=Y7DXLvxV435hDw@mail.gmail.com>
 <CACT4zj_84eCYOq56zdqaydaEGqyqBrXDrsTkDRyCntvVF78-0A@mail.gmail.com>
 <CAG-rBigLPfJ6u5LQZ4FwMMm_h3b5fQiRYFkwNjFHm4cDCN1VRw@mail.gmail.com> <CACT4zj_fVyz2oCw6aw7TLmyfZ04WcPeZmwSr79TdWsSP435xoQ@mail.gmail.com>
In-Reply-To: <CACT4zj_fVyz2oCw6aw7TLmyfZ04WcPeZmwSr79TdWsSP435xoQ@mail.gmail.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Wed, 30 Aug 2023 20:42:23 -0400
Message-ID: <CAG-rBiikaMaMbaOgQ9LH4x0LK8T6+m+8p_9ZSyYiRxHUTxn75Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        skardach@google.com, adrian.hunter@intel.com,
        SeanHY.chen@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, reniuschengl@gmail.com,
        stable@vger.kernel.org, ulf.hansson@linaro.org,
        victor.shih@genesyslogic.com.tw, victorshihgli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 30, 2023 at 8:34=E2=80=AFPM Ben Chuang <benchuanggli@gmail.com>=
 wrote:
>
> Understood, I accept your suggestion.
>

Thanks so much for the detailed review, much appreciated !
I shall be posting a v3 later this week. I look forward to Genesys's
review and/or Acked-by.
