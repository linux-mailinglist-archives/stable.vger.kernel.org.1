Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9DF71371E
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 00:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjE0W4z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 27 May 2023 18:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE0W4y (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 27 May 2023 18:56:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148A5D2
        for <stable@vger.kernel.org>; Sat, 27 May 2023 15:56:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30ad458f085so1309984f8f.0
        for <stable@vger.kernel.org>; Sat, 27 May 2023 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685228211; x=1687820211;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE40mJuVkISt0zg8IVAmmNvtPq9ArtEbvKSLEgCOttk=;
        b=nHa55/m61MavhDxPSUhco7Ne4+Td6EIDzakyMNgpkjtdDUoQdNdi+Kea3YnqdYc3Io
         GrKDavyNo2OQqqtSsS506PIhBFSWpjtVUsnzL6dSUTr0ZavnbtAHE9kIcPy9rAOtIgN7
         Rl9GJfD7OnmCBJw8SxpXx7I6ntAQAT56rWqY6ZtrzwwBmd59lyJcHeg1sL7t0RVdB1dJ
         9ncwKRXi+hGT7rcOTSLh5a+J7ZrXwbCw19MHLRSxF5EjZ3WP6WuvMtv3zPBcL/dvdLDs
         rFAkOlCty0n1nMzcCeKTgtpwgt1VYPEb0q2T2rfntDPWhEeg20sfsciKdKNdb+/kB0/T
         fczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685228211; x=1687820211;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vE40mJuVkISt0zg8IVAmmNvtPq9ArtEbvKSLEgCOttk=;
        b=gokh0QN18jqaQZAi22IKS9o0vxGOSCk2ksayj3MU22VEq4xqXKfbtuqIdY64AaELl2
         NCvN3tvORkmm5O+zCnApR2y/jP7geg/V+2YTVsY25ByZ99UpXd4/2LFkSmAd/H+YBZr6
         zLcbf18JU2WCy74W4qzNgLOsd0f34PuilpHbO7/5D3FVfSyvp4qAsqoWJ3sqbbDXPnOc
         bAdNIZr5tMeJ3+57nxN4mXtocHfCZXRT2bOPSjJCFEQODdXEzxxterk/sLE2iC7LaVA9
         Tb6LTguo1Er22KOm/gl9L/415CitSPZHKP6isUPsyFbVyUQThBL5ke6WakPnOzGc8TzP
         nq4A==
X-Gm-Message-State: AC+VfDwrhmqQCNsXPKd2ybKUmeljp1TyOsjAsqvM++Geu7KJiTHJYdCP
        xgZqSdz6T3q+fHJKPlB8zObQ+DN9WVgo6ZKxQxE=
X-Google-Smtp-Source: ACHHUZ5PxfoGJGwfeqz/UNV4g78w3bzg0bzDVO1G1/4Dn8I+xM3ajkQyahuYThMuCHnmHEJvmGAV06YWC87dhuFq5NE=
X-Received: by 2002:a5d:688b:0:b0:30a:e63b:950 with SMTP id
 h11-20020a5d688b000000b0030ae63b0950mr1104676wru.31.1685228211234; Sat, 27
 May 2023 15:56:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f687:0:b0:30a:e162:c818 with HTTP; Sat, 27 May 2023
 15:56:50 -0700 (PDT)
Reply-To: ab8111977@gmail.com
From:   Ms Nadage Lassou <info.anitakossi@gmail.com>
Date:   Sat, 27 May 2023 23:56:50 +0100
Message-ID: <CAJFTDKTCbOBBngSdbw8Vo+mB05B1ont0Q7+MVhs_8XmLL=E-bw@mail.gmail.com>
Subject: REPLY BACK FOR DETAILS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [info.anitakossi[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ab8111977[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42a listed in]
        [list.dnswl.org]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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
