Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F496F5875
	for <lists+stable@lfdr.de>; Wed,  3 May 2023 15:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjECNBz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 3 May 2023 09:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjECNBy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 3 May 2023 09:01:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9C91A5
        for <stable@vger.kernel.org>; Wed,  3 May 2023 06:01:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-95678d891d6so1035261966b.1
        for <stable@vger.kernel.org>; Wed, 03 May 2023 06:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683118912; x=1685710912;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdzKHorPK5xtqwPjAGsyKbOGBds2Po5X1ePhL1M1TdU=;
        b=e8lN/fJDa4YSMfQ7Bg29Vcc7eVQpT3t1HBNzIdvENOqns6o2MixLaTwQ5ssMGM+FXj
         QMFcmQKs+VHd6pkyyEYz+dxrryEaY+4ZjJm8PrRw89qQXKaTdCO9GivWuWUAQWZiUQxu
         dQBmegLRmXfR5qIchjmSHcXUYh/jSAP0zXLdz3qlzHP/ZBK6cXeFZ3JuN4IYsMB0mOa4
         cdz9ycmMLRzIYhGdvyWPYjOGzk1A7F5VxT+by09y3YFoHZlY0BRykkRBlyyfUD9WarHk
         9ZHsGRYDswHQs7w5s24e05bMa4MEgWbhTRTbxIJq3m4ScTH1lYfb/MiMO45XOHp1OleO
         feBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683118912; x=1685710912;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdzKHorPK5xtqwPjAGsyKbOGBds2Po5X1ePhL1M1TdU=;
        b=Ab7NNfjpq2iZhHovXxNrMKxcIpN/iB4X2FALXnqQ6rSh28wL5KK8esC5vHiG4P2Ez0
         OfbMBGAFRryZCmpJW9jK7RfEy6A642aytfGDnCymOdVnP8YjL705MWEkV1LgDW9OFbqx
         9CIIZhufb/WfrZTB+OPvqplsS5ypi1pLdFp4LtYtpsbBfHA5F7XG+O+IucTP+Nd38mJ8
         JeNIbAl5zWZxi2IEjZ7gomh7uyokOpbzLfTZN2BinBE6J2cgGyTqlCW3pTD/DbVIzc2L
         Wg1MbJllxIW5kpi81sy5vydVPs7mYfqOyEvpSy1CHm51LfRCoyhJBoKNze6k93w3AiJz
         p4/w==
X-Gm-Message-State: AC+VfDzJpWRukYZwe64I1jAjIY2EbfPQvnWz6Uf46xw7wcgjuw4t0bYJ
        vIDZ5bEROWq2fEC7Mmi3fpXO0k0euVHhqykHiME=
X-Google-Smtp-Source: ACHHUZ4y5wCBaE5weQnGH2qnxa6fG2tJT/1AuwnTNKvDyMKQXQ5yE+tRBEwptl2FvKVZYuPIBOR81UAPwT3o/njcfzM=
X-Received: by 2002:a17:907:7f13:b0:94f:161d:e927 with SMTP id
 qf19-20020a1709077f1300b0094f161de927mr2802923ejc.41.1683118911649; Wed, 03
 May 2023 06:01:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:1629:b0:94f:6a60:5d28 with HTTP; Wed, 3 May 2023
 06:01:51 -0700 (PDT)
Reply-To: RichardAlido1929@gmail.com
From:   Richard Alido <khalidlucas88870@gmail.com>
Date:   Wed, 3 May 2023 06:01:51 -0700
Message-ID: <CANCZJQwwOdaizW+V58ZJ3CYdvfYRxx4Mh6ND1bVdBZ7kPq1tPQ@mail.gmail.com>
Subject: Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [khalidlucas88870[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [khalidlucas88870[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [richardalido1929[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello how are you doing please i have a busiess proposal that will
favor both of us i will be happy if you will be interested to handie
it with me.
