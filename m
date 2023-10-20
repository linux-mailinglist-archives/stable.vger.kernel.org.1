Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E307A7D12ED
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 17:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377657AbjJTPg4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 11:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377601AbjJTPgz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 11:36:55 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EADAB
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 08:36:53 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a822f96aedso10416127b3.2
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697816213; x=1698421013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tu6pyTUtGymaS2j2r9iQnDpyhQcaCvR7FSo8pcjNejA=;
        b=oQKM4VbKDW4+J9kxOY6nRHrICm/EV1SxdqzIfk4w1bEgsxkpurSIUowSF8tBl16jKk
         MEdoEKZbNrWrmh73jpaZyzNN+MdkEUYp4LqCngoLK52Z5XNWLLR0Lz/UbHvy5fid8Iaf
         cUoZu4I0OcX6DMVp2WZzc2k2zZilm/2iGAxqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697816213; x=1698421013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tu6pyTUtGymaS2j2r9iQnDpyhQcaCvR7FSo8pcjNejA=;
        b=nteyhOK4c1yu2vpUKv0P6XiQKnbd2XTB+yOtB1QvilWaCrmfKJOjxNvO8CZG7pqjwf
         7EiAmXLSMlt5Wmi8ZAnCy+UVVD2omHmkAhjFl24lCsQGF+ZkMs5sxq+kGR9AWPt6hUcH
         wjNRUgRLr49LfwkWGAaxUpWV99yd5+hkSGEEcixPEEpQnoWBEx5P0FkH0bIj8K5Yxy4F
         9vu+OWViuvJ9YiRzT+h5xmfTfp89tz/vpB8QDVSf2Oxi+Td59PQkPzSmYbaq7VZWgn31
         UnNwx+kexgoXvvIehdoJM7Px1U6AZpa6UBuVTfroM4DLAmPaVAHSX/F2sYMQJtvBrZ/M
         6GWA==
X-Gm-Message-State: AOJu0YyM25acm84+FoKckN/NYk8cByLvmtzh7vwrmQGLXWBDbNm2f9a4
        uBHab+m42phurb89MTTrdu6wmG1Ic+eYJQnLzy2w2w==
X-Google-Smtp-Source: AGHT+IFqUlPG6dlUmNyqyGkuC10+FI40s+GmD/Bn0XNtOkYk8p12lirTlbLaNaqGbzu5h56aM3HWjjPYZb8mY6Vee1A=
X-Received: by 2002:a81:7354:0:b0:5a8:1973:190a with SMTP id
 o81-20020a817354000000b005a81973190amr2633859ywc.8.1697816212688; Fri, 20 Oct
 2023 08:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231018235944.1860717-1-markhas@chromium.org>
 <7b08520e-8f36-45a1-9b7a-316a33c8e8c4@linux.intel.com> <CANg-bXDvZ00ZHEgbUf1NwDrOKfDF4vpBOxZ4hGEp-ohs6-pZpw@mail.gmail.com>
 <5bc82aca-04f2-463b-ba52-34bcae6724d5@linux.intel.com>
In-Reply-To: <5bc82aca-04f2-463b-ba52-34bcae6724d5@linux.intel.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Fri, 20 Oct 2023 09:36:40 -0600
Message-ID: <CANg-bXCaUOxSTfR1oXKrdnDozA9Hn-NL7mqg+zvLASLQyouChA@mail.gmail.com>
Subject: Re: [PATCH v1] ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Brady Norander <bradynorander@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> FWIW we use this other quirk:
> DMI_MATCH(DMI_PRODUCT_FAMILY, "Google"),

Unfortunately DMI_PRODUCT_FAMILY is empty on these particular devices.
The coreboot version field is the only entry that has "Google" in it.

> How many engineers does it take to identify a Chromebook, eh?

Ha! There has been some discussion about this: to come up with a
canonical way for Chromebook identification throughout the kernel. But
nothing has been settled on AFAIK.
