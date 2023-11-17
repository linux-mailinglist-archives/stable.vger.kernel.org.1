Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAADC7EF2F2
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 13:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbjKQMtI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 07:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjKQMtH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 07:49:07 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83469D57
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 04:49:03 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7dd65052aso22002707b3.0
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 04:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700225342; x=1700830142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qsLyIAWXgTfFV5o66fNwdmuvFE8TfiDt0QFJ94wxiKQ=;
        b=n+KxpGXcsMw1NAwqeOnVXxBsPJ1gSWBy+0F4o9ZWxsDM9AwZDxyob2UV5C5HB28yoQ
         UwSOqc29fCes4cmIsg/wd6UxH+TgO1AR4vbw7XGOFeO8G7Y2bTYBDkHbi8RX8kS8lAqc
         cLaR+PeeTNSL+Tgn4xTDwYvg/KyEviHgbPbCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700225342; x=1700830142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsLyIAWXgTfFV5o66fNwdmuvFE8TfiDt0QFJ94wxiKQ=;
        b=E36RN2T+toJIPGpI17gy9H0TWQRfOBRhtPjHLo4CMVSkh/sbCybltQEjW5PxOLIzEa
         2p7yFlvgWxXjwbnwOIefdLwUQP/yDk+qJuh0wqcmfZ9CNEqY5idPNh1SZhbc8JQCLAmh
         x4kTz47Njzw5WEZcHqifWbnRoI4+64P00CngoJ/0bw64xuF6ASG4hNEoUUSpaT/nbTaf
         /V5wW30OCpsI+ng3udXyJAM8sbxaWUVt1+1My+Mp8Be0watef1E+FA3v8Tpe+CHkFsVw
         tEg6Y++ZzIQKCiVO62CyRfCuwUoxBF0XXlbhHgfdrERXr9hnMvtu2W7o6CZREbBe40r+
         Pw9A==
X-Gm-Message-State: AOJu0YxqnaDyj9W1qczdKODRinkRr33iHFse6RYMDdqW2zSGnuhwVeKX
        g7uKlJuQUbgVQt7gOE9eSZPy1aYfj3ExJ1XsyX6u6Q==
X-Google-Smtp-Source: AGHT+IFr2JX4jMQDh3SdiflGxjh1Wzfw20oaR0CBhOgfoMKEEx9/3Yux/0rUy+lA67uKge2ibnaRRg==
X-Received: by 2002:a81:8ac3:0:b0:59b:eb8:c38a with SMTP id a186-20020a818ac3000000b0059b0eb8c38amr19991517ywg.30.1700225342402;
        Fri, 17 Nov 2023 04:49:02 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id w67-20020a816246000000b005a7aef2c1c3sm465762ywb.132.2023.11.17.04.49.00
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 04:49:01 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a7dd65052aso22002227b3.0
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 04:49:00 -0800 (PST)
X-Received: by 2002:a81:8002:0:b0:5ae:a8ac:ed6a with SMTP id
 q2-20020a818002000000b005aea8aced6amr20030337ywf.2.1700225340427; Fri, 17 Nov
 2023 04:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20231026-dwc3-v2-1-1d4fd5c3e067@chromium.org> <20231031232227.xkk4ju3hxifj3vee@synopsys.com>
 <CANiDSCvEyjHFT3KQbsbURjUadpQYEfQ=M8esdcHnpWe9VsK=2w@mail.gmail.com> <20231110225507.cl6w6vkyb4dvj3uh@synopsys.com>
In-Reply-To: <20231110225507.cl6w6vkyb4dvj3uh@synopsys.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 17 Nov 2023 13:48:47 +0100
X-Gmail-Original-Message-ID: <CANiDSCu1WdKu+2Erkj9iEnp21Cuk84MC_ow+8o-qETqJH1qMNg@mail.gmail.com>
Message-ID: <CANiDSCu1WdKu+2Erkj9iEnp21Cuk84MC_ow+8o-qETqJH1qMNg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: set the dma max_seg_size
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Zubin Mithra <zsm@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greg: Friendly ping, just want to make sure that the patch did not
fell into the cracks

thanks!

On Fri, 10 Nov 2023 at 23:56, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>
> On Fri, Nov 10, 2023, Ricardo Ribalda wrote:
> > > Probably better to have the Closes: tag with the link to the reported
> > > issue. Regardless,
> >
> > It was reported internally, so I have no link to share.
> >
>
> I see.
>
> Thanks,
> Thinh



-- 
Ricardo Ribalda
