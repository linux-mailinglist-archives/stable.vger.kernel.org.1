Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768D471523A
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 01:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjE2XJE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 19:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2XJD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 19:09:03 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06792B2
        for <stable@vger.kernel.org>; Mon, 29 May 2023 16:09:03 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-565e6beb7aaso30891227b3.2
        for <stable@vger.kernel.org>; Mon, 29 May 2023 16:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685401742; x=1687993742;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yOffsc9mr2um2UamKzLnljoHLNL6UMnVExGJ1RSfWqA=;
        b=ZTq1wM+bqUy/Ecl1bC2OrhezV11nyn506IKeBLK8xTuI+swfQkTKycXojzoGZxslrF
         3tGuTT/GqnGjZlETTOEmZhBfup26TPjs+SjNkb33jTf5JvChjExBj5h6u3mma3tBrcOi
         0c94IRXX7f5knXUUtd3OBK6ANsAE/shD9NJYsOft+tkWssZb0zcXev82UkEr6oHexkle
         uKS9Z5Eo+lGcO9ag6rTzfQPARUSuG1RzGbtlE+Hw9GWsY4/s6kv/nKk5b6HUA3KZsBSl
         4wSwiKZ/gX8LsqrbBLzwRpnw2kXoKjm1d2jfsVG0J5ar6UP1VxL5t7i7LTNWiBe+1DR+
         7kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685401742; x=1687993742;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOffsc9mr2um2UamKzLnljoHLNL6UMnVExGJ1RSfWqA=;
        b=a1nKhdqppDmh8dbFpAg6koJsGhTmDKU5L5W2SJnaAGCgHlnY3jl8R/LVm/w0yVDZKB
         +s9vNpejAGV4Yeecia3UAZM/9MLm6dArAfxVNw596MDDym1eOxL94jzNDkQBh+UCOdVG
         U7cRdu22JPjV6FU2lounRjk7WwHOQqrd0CCzuIw9b8qQU1o4ikZbkW3UPIMQN5ocZ2nz
         svsaBBij1xQX8ZH4hQjd4+8GFRBbHI5cRLjD6p81R0em38MAZgIjTZmE/7srztNVKiUI
         8frZvUipAlfAIO9pAwhgvSM59ty/BPqj9zlUhE4LKlak30c74WZD0KgbDMYI9cpaf8dg
         r6Dw==
X-Gm-Message-State: AC+VfDwAzAjBoagTfToyPRQ4GXAdESDPhYi+pOTtG0ogn2O58yxD/uiw
        xTsI8dWc0NUdn5Nwbl/WQguT+d99w5tnCrGBixE=
X-Google-Smtp-Source: ACHHUZ4++2FypUhk8HPqhVT6f5sz/Lh/gi5Gc/wXF12QGxweOLRiNpiQvKlHmldqwN8kDtajiD5AUgOzR+oWJGCYRks=
X-Received: by 2002:a0d:eb83:0:b0:561:3fb7:1333 with SMTP id
 u125-20020a0deb83000000b005613fb71333mr340821ywe.43.1685401742097; Mon, 29
 May 2023 16:09:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:5281:b0:4d4:d51e:42b2 with HTTP; Mon, 29 May 2023
 16:09:01 -0700 (PDT)
Reply-To: headofficedirectorwu3@gmail.com
From:   "headofficedirectorwu3@gmail.com" <abrahammmorrison02@gmail.com>
Date:   Mon, 29 May 2023 23:09:01 +0000
Message-ID: <CAKUdRLNv52VmZLKEL_+AO4xF6TYRM-+WbeV-00yLhg2694Lq_Q@mail.gmail.com>
Subject: Hello
To:     bankdirectr1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,NAME_EMAIL_DIFF,
        POSSIBLE_GMAIL_PHISHER,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [headofficedirectorwu3[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [abrahammmorrison02[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [abrahammmorrison02[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 NAME_EMAIL_DIFF Sender NAME is an unrelated email address
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.2 POSSIBLE_GMAIL_PHISHER Apparent phishing email sent from a
        *      gmail account
        *  1.6 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--=20
 Irod=C3=A1nk el=C3=A9rhet=C5=91s=C3=A9ge: 2554 Road Of Kpalime Face Pharma=
cy Bet, Gulf Lome Togo

=C3=89n vagyok a bank igazgat=C3=B3ja, =C3=A9rtes=C3=ADtem, hogy IMF-kompen=
z=C3=A1ci=C3=B3nk 850
000,00 doll=C3=A1rt tesz ki, mert az =C3=96n e-mail c=C3=ADm=C3=A9t megtal=
=C3=A1lt=C3=A1k a csal=C3=A1s
=C3=A1ldozatainak list=C3=A1j=C3=A1n. Hajland=C3=B3 vagy venni ezt az alapo=
t vagy sem?
Meg=C3=A1llapodtunk, hogy megkezdj=C3=BCk az 5 000 USD =C3=A1tutal=C3=A1s=
=C3=A1t naponta, am=C3=ADg
a teljes 850 000 USD =C3=B6sszeget teljesen =C3=A1t nem utaljuk =C3=96nnek.

nem tudjuk egyed=C3=BCl az =C3=96n e-mail c=C3=ADm=C3=A9vel elk=C3=BCldeni =
a fizet=C3=A9st, ez=C3=A9rt
sz=C3=BCks=C3=A9g=C3=BCnk van az =C3=96n inform=C3=A1ci=C3=B3ira, hogy hova=
 k=C3=BCldj=C3=BCk az =C3=B6sszeget, pl.
A fogadott n=C3=A9v, a fogad=C3=B3 orsz=C3=A1g, a telefonsz=C3=A1m, az =C3=
=BAtlev=C3=A9lm=C3=A1solat, a
Whatsapp sz=C3=A1m

Tisztelettel
Tony Albert
bankigazgat=C3=B3
Whatsapp, +22870248258
