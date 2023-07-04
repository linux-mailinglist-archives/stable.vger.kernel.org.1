Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E5A747782
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGDRJS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 13:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjGDRJR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 13:09:17 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E00DE7A
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 10:09:16 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-635dccdf17dso42035776d6.3
        for <stable@vger.kernel.org>; Tue, 04 Jul 2023 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688490555; x=1691082555;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rSo2MED2dTm6RY30lyoWG5ywhIBWHYf7KBjiWayVK+A=;
        b=WsoPz9mfnX2QeQ9QkXSzR+gjtE/uSADqW2tFgYruv5SSf6QQXHSNJyifRE0soiFwvZ
         Nw7obbT0hu1pOq8aFjV0rWVypH1AZiGlFc2NCRwa9xEd/yaRKmoQvipG5mN4McIDNRpZ
         vn+zqBsflnM7NK6qT9mEfhw8NWH5z6AOALM1EraEhlpOXCm4kbH9lyJjKj50zHpIn+Lm
         2K1OFL4WHp5WaVkwLPiI7mtNgcXSgE7e8vwYFIG/3tyMsX1LN8DFD+sMMOVei2qGq00/
         oO9gR6woUkmY2q+PZw2B9ZNoELnp/BNevDQwxafSWj621584IcQ8X4ye2mR0Ln7JRiZs
         1+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688490555; x=1691082555;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSo2MED2dTm6RY30lyoWG5ywhIBWHYf7KBjiWayVK+A=;
        b=BskAGrtfee9Gfweeu4BMJldu91MNjOUdcudSA4dRpkS9WwrJZqgw+RonxOaOfy3I9a
         zy7YhgHYzNdW19E9Fo7w3uAw9aBxlRD1FM4/ggcEaHe5xUWJmg2LTK2ZjOOoibb1oNFM
         75CFgrhUcrWpI256mHFampnOU6sjA9fctyxnjYjraxYDxwahfHFPYlbPc4PzPcrol/Ij
         MF+BkfsCdI/4+mWsPHdx6RA+u1E6UkmnJUL2/vjY6UZYCRKQRtlJdQ2zoUihE2vJgJeP
         dTFtjnYPQPfcMm6ukywdtdy9HY23Kus7w3kmShQ95gWVndZQo8dvgNUHgCxv4sx9tF5a
         0kgg==
X-Gm-Message-State: ABy/qLZYSY2RmNZR785fKCM4U0sUCVBxSh2GgADPXltqOMD7VSPShFTi
        DS6HUSR5IHMkicX+rEDePUQJ7cnXbjkwYUANZyU=
X-Google-Smtp-Source: APBJJlFPMCSNmHXk6tXG7yLQoKni0yXe9KdLKIv8YBzvVskuceHP9Eolof3Yu6lH8UtiqTowmE0PTKmheZFNB96accg=
X-Received: by 2002:a05:6214:27c4:b0:62d:f515:9320 with SMTP id
 ge4-20020a05621427c400b0062df5159320mr14515706qvb.28.1688490555147; Tue, 04
 Jul 2023 10:09:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:b40d:0:b0:632:aed:434e with HTTP; Tue, 4 Jul 2023
 10:09:14 -0700 (PDT)
Reply-To: kmrs41786@gmail.com
From:   Johnson <pg023374@gmail.com>
Date:   Tue, 4 Jul 2023 18:09:14 +0100
Message-ID: <CAHLkZpUD8NUifgcxWevOhfZHj8rw85Vyk=OmE74buGLPHkRu-g@mail.gmail.com>
Subject: Hallow und wie geht es dir heute?
To:     kmrs41786@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hallow und wie geht es dir heute?

Ich m=C3=B6chte, dass Ihre Partnerschaft Sie als Subunternehmer
pr=C3=A4sentiert, damit Sie in meinem Namen 8,6 Mio.
=C3=9Cberrechnungsvertragsfonds erhalten k=C3=B6nnen, die wir zu 65 % und 3=
5 %
aufteilen k=C3=B6nnen.

Diese Transaktion ist 100 % risikofrei; Du brauchst keine Angst zu haben.

Bitte senden Sie mir eine E-Mail an (kmrs41786@gmail.com), um
ausf=C3=BChrliche Informationen zu erhalten und bei Interesse zu erfahren,
wie wir dies gemeinsam bew=C3=A4ltigen k=C3=B6nnen.

Sie m=C3=BCssen es mir also weiterleiten
Ihr vollst=C3=A4ndiger Name.........................
Telefon.............

Mit freundlichen Gr=C3=BC=C3=9Fe,
Herr Jimoh Oyebisi.

Hallow and how are you today?

I seek for your partnership to present  you as a sub-contractor so
that you can receive 8.6M Over-Invoice contract fund on my behalf and
we can split it 65% 35%.

This transaction is 100% risk -free; you need not to be afraid.

Please email me at ( kmrs41786@gmail.com ) for comprehensive details
and how we can handle this together if interested.

So I need you to forward it to me
your full name.........................
Telephone.............

Kind Regards,
Mr. Jimoh Oyebisi.
