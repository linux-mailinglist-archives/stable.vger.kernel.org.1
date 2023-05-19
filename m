Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4F70A139
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjESVIB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 17:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESVIA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 17:08:00 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE80C1B0
        for <stable@vger.kernel.org>; Fri, 19 May 2023 14:07:59 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f507edcaaaso37586821cf.2
        for <stable@vger.kernel.org>; Fri, 19 May 2023 14:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684530479; x=1687122479;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE40mJuVkISt0zg8IVAmmNvtPq9ArtEbvKSLEgCOttk=;
        b=YLv28DaB4+dqAiQ475lDBls92HfEKIDuqr0PrJOUd2+RjY2XDNnT8dSU6GmOZpShnb
         WwiTghsx8FU/tpLA/rKk0O+q1egz3lR1RG/PXaY+GIKSnCz3pZlPfzbnPboiwdYQqLBn
         r+yD0+I1juRr5JgEeA00kliZzzlwGbqYK+vAoiVxBS2H/K+jlNGzYYIkmQg6bPNohzs5
         gFYtbGDY5frFX7KpjJv4ILw5t48xgM4XQyPzxKLv6Ugvz8ZGpKabc64L8cOhy4q3KZSZ
         7pxtEzO24QU2YA2xSXHibVQjgtQbUs8dwgh8EzvgoR22+9AQNRp3MUMjnPBzbJC1dbd+
         gPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684530479; x=1687122479;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vE40mJuVkISt0zg8IVAmmNvtPq9ArtEbvKSLEgCOttk=;
        b=LaGCYFb3LQn0WSDU9Okl7zlVgs4mpmmreqCy1V42AbUyAT2+C2I1o7C00mz2XpFFtD
         NILLE340Pgm8yTpxcfU1vtTwO8qguIwbTAachmtSDfDHyjJkK081L/Cv7UE2Nr9yNsje
         prH/yn35hghJJq9tTfk8O9L/De5ooylRh3M3MO2/aIb3ioMW6fRs05nKWU+b5hHJGvUf
         XUKouaJ35B4RM1XSxXrCFyatdsWY3H5E5NQqgvm6NvSMegfWUq4JbY9KqylwJEaE4aTa
         uNiXRFfLZymIuaVJsYZ5zYJs58z/TmUptit1ZcUU/r0IOxsEB7gVZI62oi4r63SEdwgY
         KfvQ==
X-Gm-Message-State: AC+VfDws53VVX9UlD20sPzsr2a6AWEttjO18RtkvCFL5LEAzgzvrd+jv
        /NVVs6uH52D509Xc027k0sWmlAgP2kEfvtqCy1U=
X-Google-Smtp-Source: ACHHUZ6pxiXWxIpZcbu408pdh1xgo6CzCMMGRh9AeRaeEgtj6ertozTXgWfigy2n+/ObxLei/imPaMi1GnQ0lR6TbvU=
X-Received: by 2002:a05:622a:2c1:b0:3d9:45a4:e7b9 with SMTP id
 a1-20020a05622a02c100b003d945a4e7b9mr5792763qtx.45.1684530478990; Fri, 19 May
 2023 14:07:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:54a:b0:3f6:87fc:79dd with HTTP; Fri, 19 May 2023
 14:07:58 -0700 (PDT)
Reply-To: lassounadage563@gmail.com
From:   Ms Nadage Lassou <c.auglalassss@gmail.com>
Date:   Fri, 19 May 2023 22:07:58 +0100
Message-ID: <CAPQxt+7Esd=Nn3ZZ3qT4uF-9H8qWH1oJD871hOBY2h1EMM0ytw@mail.gmail.com>
Subject: REPLY BACK FOR DETAILS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:82f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4974]
        *  0.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  0.0 HK_RANDOM_FROM From username looks random
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [c.auglalassss[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lassounadage563[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greetings.

I am Ms Nadage Lassou,I have something important to discuss with you.
i will send you the details once i hear from you.
Thanks,
Ms Nadage Lassou
