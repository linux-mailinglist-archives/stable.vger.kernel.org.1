Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3EA714810
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 12:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjE2Kli (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 06:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjE2Klh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 06:41:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E80FC2
        for <stable@vger.kernel.org>; Mon, 29 May 2023 03:41:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-970056276acso487591666b.2
        for <stable@vger.kernel.org>; Mon, 29 May 2023 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685356895; x=1687948895;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=Avbz3pqnuATJv6OlqAWSHDWbZ1YpEer1JpfX3BBybZvukZdT2VCCme395p2sxD9iJC
         2pMHkcTw/wtwSET6juBJQyMOLy/xbIjQu0C3XO2zoKGsMo7wDPwYKMUCKz3QLZauGEsA
         kMPmpqQToZpnus03Mt0kqtbfI/E/tXAPu2TX+fRljonS9ZGThmIMkvvCffRDi0+P2lqS
         l4iqCpROo2G/ZRcGSANmf6qbtHTxoYfCQt/FGMJ5Lp3GO9DAyAPJEnJbmxQAsIRithC6
         dIJphn8AkhZn5EjGyAU+w3mVablriC3AP76rsJcBxziZAX3YIv6mjAHSVC+9qFGVrGjj
         6Yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685356895; x=1687948895;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=iSLGS5+Sr5WEU3WkZABwd9HutCasIdJjaJVLQmm0gSDiGhq1DvGAxpBd5ClN6znBV4
         6tdCNVrFFZx3ltghbyIDlp4HI6JPS8Q858ATHamuTXUiJETKrMThtpdvf9nh3Lf69YOk
         tjPDAC9z8+TTUc8jcXXnYZF+p6H5wPnWPSCw6vBqopzQsSZhc2rHx2Y+pjEf2c+3uQRl
         ebGx4ARfrZfXyli5Zwc/VbjtmYwpEiCRVdLrU99kzY1uiLwZIEr4teiGtxNb+06D6epV
         oAbVSHpKHxDdTa5ZomzHAkbKOwFynZHRJwv7PcldfcAh1X0PMKugkikTIlmRkCZgzBVo
         Py+g==
X-Gm-Message-State: AC+VfDy6JwCtnF8Ey1iW6s6A9es4K/GaV8NoIHB1Pu6Qmm7A6UQnEN0z
        wIyxFlC9i8siKzF1wM2qkXpyucc84Ky8/YAcyG0=
X-Google-Smtp-Source: ACHHUZ7+Ry8+yTwjqmaDiT/UX44BzRHtoDE75Harh2rQGNhlfql0Nu43xsVaGs1TXl6nFTQmL1F9aArcVLgt6giPcnI=
X-Received: by 2002:a17:906:fe0b:b0:94f:6058:4983 with SMTP id
 wy11-20020a170906fe0b00b0094f60584983mr10579095ejb.76.1685356894838; Mon, 29
 May 2023 03:41:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:1caa:b0:96f:c9dc:13f2 with HTTP; Mon, 29 May 2023
 03:41:34 -0700 (PDT)
Reply-To: michellegoodman035@gmail.com
From:   Michelle Goodman <michellegoodman323@gmail.com>
Date:   Mon, 29 May 2023 10:41:34 +0000
Message-ID: <CAEJQfw=kE=_cVkMVOmocUo-sQ3sM+f0y_fWAjih3YS3kTKG6dg@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:633 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman035[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michellegoodman323[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michellegoodman323[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten

Vielen Dank.
Michelle
