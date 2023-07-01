Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F36744B06
	for <lists+stable@lfdr.de>; Sat,  1 Jul 2023 22:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGAUUJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 1 Jul 2023 16:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGAUUI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 1 Jul 2023 16:20:08 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336621999
        for <stable@vger.kernel.org>; Sat,  1 Jul 2023 13:20:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-51d9a925e9aso3587797a12.0
        for <stable@vger.kernel.org>; Sat, 01 Jul 2023 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688242805; x=1690834805;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=On9FXbz/4p6uZeLAq7sP25Q5Nd8OJiKjb1ZpXex+CRI=;
        b=CJhUaHyKEh6POc+9rYHcw5kow4gHN8dIT/tpXWcFAWe2EMQBvolX6dlrxNn3+KnIz0
         Fq+CWlkGoKkJX8EJP/rO85kEzyXM3K3Qaw5Od/jo4SlhG4jOBakbvMW8Ey4veD1zCalo
         6+M1oUo/3Cif+SaZU64qpw9BD/JVg0GxBmg5kgwIXi/eClXoAF39tCGOePxcydSVoMGN
         JoPJnWzSGCfxlovH4QTnO0LC9AWi3WnjhUsDe5yoQuJLlWkF/Bu8YGaz6d8OaxWLHyDc
         o9zdDDxpwAjxJAYMhhUJ150Xl2fIMovAc+RYsMAfNZg4auiaUq8GmR1c+yU5J+VuwHvW
         iyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688242805; x=1690834805;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=On9FXbz/4p6uZeLAq7sP25Q5Nd8OJiKjb1ZpXex+CRI=;
        b=HpyKRiQ9pjATYfM1WBBkE2CfzsVI3TO1JQZ35gxwVMH+5FG3E/Etb+EKMOqtybImN8
         VE54XfpQYG+lL0tH62z7Bg1QusueEpBwgKJphaRLv6MoCuDVYXqrmnM8t3NOI2TgsIz2
         fFLuqAF8jpintdLo7MTFTAQ8539XURuPBXdPPWTOW2txFzTGlpHEh17IRvMxzLgeYlY6
         pbFnSPebidGVl/EhupMklySAHE3WCH4jWjZetBK1IYsSA0F4nNY4UQBXBlFcYw/YAhM0
         CXvuZpitT++67bLMXV1Slh3yOc8BCKMALpnUsv5FBhYHYeFQL+lLYQXOMCo4GsFQiFov
         b6Vg==
X-Gm-Message-State: ABy/qLaKFe9U9AzTcWUGqmvpLpRsD3seiy2jQtRlFKu7ReqYrAfJDSP4
        3IFEgT4WNatS1+9Opvjd8fumhk3vrjiIVgxXAA==
X-Google-Smtp-Source: APBJJlGEipRnrxC78mvBwRGnFXSkVvqb2bwae4lWU0bG6xIU91I50zp25cv4ZvHUFfTP75tuX6yENVl+fjX3+yDP7gw=
X-Received: by 2002:aa7:dac9:0:b0:51d:d1a6:c507 with SMTP id
 x9-20020aa7dac9000000b0051dd1a6c507mr4274761eds.31.1688242805395; Sat, 01 Jul
 2023 13:20:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:640c:250b:b0:1cf:2c36:29bf with HTTP; Sat, 1 Jul 2023
 13:20:04 -0700 (PDT)
Reply-To: osbornemichel438@gmail.com
From:   John T <jnd187152@gmail.com>
Date:   Sat, 1 Jul 2023 21:20:04 +0100
Message-ID: <CAM0pHQ4_rFvct+ebt+iA4gTb3zvTHJF=-m8Zx5zhZTGiOvCm1A@mail.gmail.com>
Subject: Hallow und wie geht es dir heute?
To:     osbornemichel438@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FORM_SHORT,
        MONEY_FRAUD_3,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hallow und wie geht es dir heute?

Ich m=C3=B6chte, dass Ihre Partnerschaft Sie als Subunternehmer
pr=C3=A4sentiert, damit Sie in meinem Namen 8,6 Millionen US-Dollar aus
=C3=9Cberrechnungsvertr=C3=A4gen erhalten k=C3=B6nnen, die wir zu 65 % und =
35 %
aufteilen k=C3=B6nnen.

Diese Transaktion ist 100 % risikofrei; Du brauchst keine Angst zu haben.

Bitte senden Sie mir eine E-Mail an (osbornemichel438@gmail.com), um
ausf=C3=BChrliche Informationen zu erhalten und bei Interesse zu erfahren,
wie wir dies gemeinsam bew=C3=A4ltigen k=C3=B6nnen.

Sie m=C3=BCssen es mir also weiterleiten
Ihr vollst=C3=A4ndiger Name.........................
Telefon.............
Geburtsdatum .........................
Staatsangeh=C3=B6rigkeit .................................

Mit freundlichen Gr=C3=BC=C3=9Fe,
Osborne Michel.

Hallow and how are you today?

I seek for your partnership to present  you as a sub-contractor so
that you can receive 8.6M Over-Invoice contract fund on my behalf and
we can split it 65% 35%.

This transaction is 100% risk -free; you need not to be afraid.

Please email me at ( osbornemichel438@gmail.com ) for comprehensive
details and how we can handle this together if interested.

So I need you to forward it to me
your full name.........................
Telephone.............
Date of  Birth .........................
Nationality .................................

Kind Regards,
Osborne Michel.
