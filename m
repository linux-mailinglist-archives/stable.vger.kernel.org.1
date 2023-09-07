Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357EA796E8F
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 03:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjIGBd4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 21:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjIGBdw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 21:33:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2083D1998
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 18:33:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso482913a12.2
        for <stable@vger.kernel.org>; Wed, 06 Sep 2023 18:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694050427; x=1694655227; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Seh8DwUDC5EfchPTrndwndgIDdlBz6PKJ666NyQOTvY=;
        b=Org8KKKi6OV0euXcnI5ZatxtMxbFn2PLv5VXYkenqfks0HjXTc0efWLIA8aha0pgT9
         LovdsD4zpN7+pI5VqR5xoG6NkdTXtbKY2ADiDpUqFOZNf+g9ytQFTKu+YzPwUe/Di9NP
         zYVTtOqZsaPNeCiLb1wHwaDM6k20dwQUmYDy3i0ZpncnisyiXj7eOtye7TqI7brIQZ9j
         Y0EPoF+cwXkkgeWQxsUbIx4upoKSIgaZ8tkLwj+U40OPCfxif5Bw8e8Ng7fjtbIg49v9
         nwC2iSa1e11KPIlP6m/GjB6x+5LRqMZOLORxRQpHS3Q7ZNxoD+xTZiOf1c3BKHeA9s1F
         GVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694050427; x=1694655227;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Seh8DwUDC5EfchPTrndwndgIDdlBz6PKJ666NyQOTvY=;
        b=EIxyil3ggAPFXj3vqdn0G/5oKfjUUjb7rs9Hlsu0r0Akx1PNMPJs9AKRio5LrlgcKt
         Ybl9yXqu//MQDDK+YxwsqUPOcWtMutJ/+DQYnTC8QPWYp9H/3emQ4QA/cFyrTraWwCjr
         143VuLCYybyqPVV3sYpXs2leDV5BUfx4dHWLAOaeRCOtelnx9Dkn6yS064FWnmZfr0Dv
         xYSJ3svzL5GYcj37+KCdrs3t5VvBl8aZWF/JcWRzJ1CZIJx/DdSIECfEPQDNI3EqVrMD
         G+hfp3VTU0fFiSk8HL6uP+uax101vWEreIHG93vVHsLy+EFXYkh0M/OGZu3jRghEM8fM
         +abw==
X-Gm-Message-State: AOJu0Ywym+VovwzzGAquUdZcnAylYo3zzZIbfwB6hrK3TKTbESyzTa76
        83xFJ4OjrNJCOIAl6kL87Iy84w3Dx9fCbxOprUU=
X-Google-Smtp-Source: AGHT+IHvz9or4AQl0JA8o23vlWp1p/sZJw3im/XI9mfvbTX2Sw3SBzYmoh07yKIU1DWs92Km9st8QY9TXtnT+PoMUNM=
X-Received: by 2002:a50:fb98:0:b0:52b:daff:f702 with SMTP id
 e24-20020a50fb98000000b0052bdafff702mr3798743edq.16.1694050427430; Wed, 06
 Sep 2023 18:33:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:50c3:b0:6e:7afd:b939 with HTTP; Wed, 6 Sep 2023
 18:33:46 -0700 (PDT)
Reply-To: jmartinsesq090@gmail.com
From:   Johnson Martins <ekechika3@gmail.com>
Date:   Wed, 6 Sep 2023 18:33:46 -0700
Message-ID: <CAKQG+rUbKz_59C3570LpT2YL0oz3dWLX-_3SqOF4gxiEOjhh-Q@mail.gmail.com>
Subject: GET BACK TO ME
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5013]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2a00:1450:4864:20:0:0:0:52c listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jmartinsesq090[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ekechika3[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ekechika3[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greetings,

I saw your profile and decided that you could cooperate with me in this
proposition. My client Mr. William who died as a result of a heart-related
condition. I contacted you to assist in getting the fund left behind as the
next-of-kin

Kindly indicate your interest.

Best Regards,
Johnson Martins.
