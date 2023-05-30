Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C0671673A
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 17:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjE3PiK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 11:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjE3PiJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 11:38:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD405103
        for <stable@vger.kernel.org>; Tue, 30 May 2023 08:38:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f606a80d34so32477055e9.0
        for <stable@vger.kernel.org>; Tue, 30 May 2023 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685461085; x=1688053085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C8yReErFfAbplzo/WnzhLAhYDmtlkikNQ7fEo6PzlKI=;
        b=A0GiymYh8p08gavwfh+8QiEKk1TkzS0x+UQMD8LFSXJTY6rsJ7hkzu20Jxfpdhw0lw
         8UXzvmZeUtRt2KUBylQTc1+6RD3heQjNdAwv65cbb4z7V8GR2RPaEREOdRrdRZzuqeMJ
         vx77UZ+woIiFIRl5qu1t8QtyhZ1CnUkYozFJdg7deABatFuSbKDhgxljgVCoyOZwA4+r
         +Gcnc1fR0tFnR6dw2cCnoFAH35ADioRZH2FJcmMB53VhSroghCYpKmopIhfLnMcNQVHz
         y9toM6Vw+AUkcR2K4j8IUFWeh4yfN242/E+jIZ8vZ2Ydtu3INPY/RlcnHBCDeWR4SyZD
         6i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685461085; x=1688053085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8yReErFfAbplzo/WnzhLAhYDmtlkikNQ7fEo6PzlKI=;
        b=ck5uDmLcTfObLzv3+iCu/vG9ZbVs4grXoTNN8VuwdUT/AGrJmM9hUSlSguAzYuckA3
         sPXplxI2Tb+je/QxVVOH3JQg6lO2B1lqiraR4pj/aIWOYAqSALrweQsp8puaaBS+mQrU
         eR8XXS1GQgGKKr4R3L6tCefSFJcFtCshK0mXD8mgOzJWmzIlQKvqViBQBx1yerG/ruyU
         CxiNFNNZsCLejslUP9DW7KKIeCa+msf3ZyKLID9cV+hPFi5sNa54vkYYLYZX304pG9uI
         DiYfCfofZlF7qffXj3jDVzCad/za+I4D6X1p8o4z569vH+4h7QW+GTT4N6FwK5SMKmtR
         Ja+g==
X-Gm-Message-State: AC+VfDx/xi0YrKi07W9PTSQLPGD9hr7a48wg+Y+uHP85YVIeqdaLmR9o
        PVCSPAX5wV6o6rinaC46y/vBNw==
X-Google-Smtp-Source: ACHHUZ4oVaUjRtTX4i5IWVr+ILI4EROTqLigq4sYtHqghrJvLA7X+53wRZP/xwnWlA3656yJWgiC7A==
X-Received: by 2002:a7b:c016:0:b0:3f6:72ec:5fbe with SMTP id c22-20020a7bc016000000b003f672ec5fbemr1855670wmb.15.1685461085135;
        Tue, 30 May 2023 08:38:05 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c025000b003f605814850sm21406530wmj.37.2023.05.30.08.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:38:03 -0700 (PDT)
Date:   Tue, 30 May 2023 18:38:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org,
        "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: randconfig fixes for 5.10.y
Message-ID: <6b1a0ee6-c78b-4873-bfd5-89798fce9899@kili.mountain>
References: <b59d1bfe-15b1-4318-a12f-a38143ba35bd@kili.mountain>
 <4716f9fd-0e09-4e69-a802-09ddecff2733@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4716f9fd-0e09-4e69-a802-09ddecff2733@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 30, 2023 at 10:53:55AM +0200, Arnd Bergmann wrote:
> On Tue, May 30, 2023, at 10:22, Dan Carpenter wrote:
> >
> > I'm going to be doing regular randconfig testing on stable so let me
> > know if you have any advice.
> 
> Just one thing: In my spot for random projects, I occasionally
> publish my latest "randconfig-*" branch, which may help you figure
> out if I have seen a particular build failure before:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/refs/heads
> 
> This tree should build without any warnings or errors on arm, arm64
> and x86, so if you run into something that you can't immediately
> see if it as a fix already, you can try bisecting against the
> latest branch there to see how I addressed it locally or upstream.
> 
> It's a mix of patches that I submitted already but were not picked
> up yet, that might need a minor rework based on comments, or that
> are not acceptable for one reason or another.

Ah, yeah.  Thanks.  Scripting to automatically bisect would be useful.
Btw, I reported one that isn't fixed on randconfig-6.4.

https://lore.kernel.org/all/1770d098-8dc7-4906-bed2-1addf8a6794d@kili.mountain/

  CC [M]  crypto/twofish_common.o
crypto/twofish_common.c: In function ‘__twofish_setkey’:
crypto/twofish_common.c:683:1: warning: the frame size of 2064 bytes is larger than 2048 bytes [-Wframe-larger-than=]
  683 | }
      | ^
  CHECK   crypto/twofish_common.c

regards,
dan carpenter

