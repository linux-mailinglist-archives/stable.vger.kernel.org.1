Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09BB73FCFF
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 15:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjF0NkS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 27 Jun 2023 09:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0NkR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Jun 2023 09:40:17 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163C12D54
        for <stable@vger.kernel.org>; Tue, 27 Jun 2023 06:40:17 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40079620a83so267651cf.0
        for <stable@vger.kernel.org>; Tue, 27 Jun 2023 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687873216; x=1690465216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60sdZ0/W1BRmGu6AlZA3f3b1XPfOStvjGcXbJFjRxEw=;
        b=LPlHfy8cooHiNrwPDxEBAv8dW97XNWe6zYTx1dvItxzz5KxOo2mjJhREUqnO+60d/m
         3SCN2BDwX0CTvlmJBKTeGgqMapjeO0cU+tYU2OkTs3PrAEAZhug6yDdMXeqY6ogFnWk2
         ye4FmZPtyFQX0H1THD641fZ9A3nciqX/YGq7zeFHVCBf2OMvEEiGlIx+xfMHGhzo1+XR
         zrQGEnQ7zTddWpP/iZQZJsnD/mAxZ3s1b6TweApQkGBfUzdGkGmcqo3Qte/T59dfY7JX
         LuSHEqi4Emwz/yU0Ab+isEyO7ZIRUvDn98g+1apPw4+4w8vQNjzFQCoAsq6deyPee7Gs
         ujkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873216; x=1690465216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60sdZ0/W1BRmGu6AlZA3f3b1XPfOStvjGcXbJFjRxEw=;
        b=TJ6eQfdbU7u1OlMWxjTfD9h6R0hZ/evAATbfiyCr+ZjTbfJBp8i4bqn3eqHiy0LuWw
         yU0kWFSIn7AiZ1gke8c+PPt4xHMiWmf+9b8wd37L4J/ndlJ5k14HcbCY1VlUtXTg6AQi
         GZ+hk7iA4Sb409ay8K1/BxC2dCXUnMBfrmOzj+ku3Eij8YHyckFomqyO207lChz29m6K
         zgHbNkt9RYjD9FE4PdxANj/CEQgIGhmiSU+TTafTMwsX8T9eRHRx3z0SfPelgUEBariT
         LrDtEL2iaMuxUrVo0bMFcCwaNHPH0kVqFNhaUzfjw3YsHv92Xa/1dxiNai+8q264xADr
         m58A==
X-Gm-Message-State: AC+VfDyBm8b8pbUQqK6pS3mKVNhJ5vJvsgSmV+jYUmzlrMThNDYPcpfg
        qtIVlPpO1adYOX7DSFM6vUhMlDcEpB2C7nhn1IK6wA==
X-Google-Smtp-Source: ACHHUZ5RX8NhvP7wSDLlGP3QTsJ5bkWcPYFYot8aZjT7gCTVzb7MfhLej0NrJFTLFtduzg3q3TXCM4Hsn3cfIbhwyCI=
X-Received: by 2002:ac8:4e83:0:b0:3de:1aaa:42f5 with SMTP id
 3-20020ac84e83000000b003de1aaa42f5mr577703qtp.15.1687873215789; Tue, 27 Jun
 2023 06:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230627035000.1295254-1-moritzf@google.com> <ZJrc5xjeHp5vYtAO@boxer>
 <35db66a9-d478-4b15-ad30-bfc4cded0b5c@lunn.ch>
In-Reply-To: <35db66a9-d478-4b15-ad30-bfc4cded0b5c@lunn.ch>
From:   Moritz Fischer <moritzf@google.com>
Date:   Tue, 27 Jun 2023 15:40:04 +0200
Message-ID: <CAFyOScpRDOvVrCsrwdxFstoNf1tOEnGbPSt5XDM1PKhCDyUGaw@mail.gmail.com>
Subject: Re: [PATCH net v3] net: lan743x: Don't sleep in atomic context
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net,
        bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        mdf@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Andrew,

On Tue, Jun 27, 2023 at 3:07=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > +static int lan743x_csr_wait_for_bit_atomic(struct lan743x_adapter *a=
dapter,
> >
> > adapter is not used in readx_poll_timeout_atomic() call, right?
> > can be removed.
>
> I thought that when i first looked at an earlier version of this
> patch. But LAN743X_CSR_READ_OP is not what you think :-(

Yeah, it's not great / confusing. I tried to keep it the same as the
rest of the file when fixing the bug.

I can see if I can clean it up across the file in a follow up.
>
>        Andrew

Do you want me to send a v4 with an updated commit message?

Thanks,
Moritz
