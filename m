Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B57E776B46
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 23:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjHIVxp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 17:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHIVxp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 17:53:45 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A58F1FD2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 14:53:44 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso4770801fa.0
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 14:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691618022; x=1692222822;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=Ym2ISE5DpO5ytxEO+6zuDuMUh0DfuQpXig18Yg89e1of7V5LlB0QgDAWzV0eTYUmED
         BdllGxNjo6i0zeTcvpKHwj6qTRyx/AbebB82rJKJYux/MxD2qNd9Yz5TQwrf+Opg2R+O
         oAke8Cv6CiaINQ6y67KDfUk24wy+BYNIEfIuUIFKfaW+sUiRCgJS8Wyjum9HG9waJ0MU
         2X2ZvJ6qwvHOad+Iz7g4IepX3vrJfxSF+6rhuZCNTRx7VpJfUebfimrRWg8pp0PNfOMw
         P3HUKbWOuGSvghtMgymhcIrU4WoxkBrJNA2Wo9cuRUt3aFZSzKfXF3pfe9s+JB2Y6+rJ
         6uLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691618022; x=1692222822;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=dOjyxN0C/C8qAnuFoOtoVCqMXc2VVCMfp3GCUagLQIsUGFpJty+E5aIGNzjk9sII5Y
         EFwZ8oP4tpWjItv3y3ansxzc2StldKOswlJ0HpCKlV4O/rPWiYoMJdDcuKys3JrtrA6w
         deKNXWsgo9TWb4tvAH39rgZaNwffxUSGIHJt/iE4H/DxqFTpJ8s3DMX6CidpfW1Cvhwd
         Ar1jpme6pJjhyG/CS0GdwXQyzWWi2pwp2hQDCSdlkYJRzpJwY0qneS90gbzH8BcwZyno
         TRpY/7kLbnY1OdDmKKipPDuNTmvpmGnrqBe9rByynMmWfPLOzXFbcWFur80oPkRKVCfT
         pJuQ==
X-Gm-Message-State: AOJu0YwdWtPptUWavtB0YEHKk7jtVvH2aWLHpyHSLWu+hyrpbUC4LSIU
        YcyAtgJ1dx0M7TIBxVrUD6MMSD/DFXFjVyX4qmM=
X-Google-Smtp-Source: AGHT+IG9AP+M2/eueSFhhF15UQif4dZSZ0PkAA9pQg/r0aV6rWzye3W5g+vVO1JKZTg8RnRwVesQb3P6WxNqkkWl+UA=
X-Received: by 2002:a2e:9790:0:b0:2b9:412a:111d with SMTP id
 y16-20020a2e9790000000b002b9412a111dmr394225lji.42.1691618022019; Wed, 09 Aug
 2023 14:53:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6022:a11f:b0:42:765f:e5b8 with HTTP; Wed, 9 Aug 2023
 14:53:41 -0700 (PDT)
Reply-To: davidbenjamn2022@gmail.com
From:   davidbenjamn <akokon27@gmail.com>
Date:   Wed, 9 Aug 2023 22:53:41 +0100
Message-ID: <CAOXzkJpQMkU1O7oSWttegi2r3t8w4rTmtYDwCqdObupreEvUtA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Every time I retest your email, it tells me to check with my ISP or
Log onto incoming mail server (POP3): Your e-mail server rejected .
Kindly verify if your email is still valid for us to talk.
