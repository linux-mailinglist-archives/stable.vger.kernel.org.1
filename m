Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C3B72914B
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 09:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjFIHhL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 03:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbjFIHhD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 03:37:03 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79653193
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 00:37:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so5368044a12.1
        for <stable@vger.kernel.org>; Fri, 09 Jun 2023 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686296221; x=1688888221;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F9T1iesAxfJV3eaqgIrsWxCzDVw8BboIkXedOQd+1zw=;
        b=D7TjawBBuLDxZtnw1WCW6cOn9Ri4wrfxLEdGUQc64yVvvQqUKbOHDBvX1bKiI1BKtt
         n6PFgD67JFCjsYjt7z1KIn7/3SViVzqYs9rc4seBFaP9KfgfFYUva0ixUxlpXaNh/F04
         ybPe+io1bSHC/HzK5m6pDQVHwtQ8RgKiEzbVXhqrTXMIL1maPHybKVnpZILMjJaNRbai
         Xyk4qchMSLBZ2GLkqHtmudUiM2PE1hvsTHerOxh+ShO10oFoMP9Mb5mBS0FFF1INbITb
         txMl3BAtIwWoJO+IyTad0hfz2nTtlgvlTDZsTS3+PJ3JTIRKjg7UH9Inbw9jV2F01LUb
         6+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686296221; x=1688888221;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9T1iesAxfJV3eaqgIrsWxCzDVw8BboIkXedOQd+1zw=;
        b=KlN3LQU3YjFKzJQBxRMIeCnnLRPwaslzgvumTGdac/ue2neMWcao2GdcPHyXwj4Dfq
         wLtw8c7O7KBmuvH+JoaCm2qtwMExI6y7Hl0uQoYg3NPQnre372GE3E8CcL2eu3EAKplK
         ZThY/5B+Qhla1Gs9QLaI7DnHVcA2XNJeD3Kcs2STrvmrXAqPGq+GgNDGbs2Vla86dhlG
         JbTlX7bIhzZP3L+bmgBIAJWJq5SYibGYmYJq73meeB+PTAeAZJkDThrVmS89vORH39Pq
         6bwEvJX2JKEbmaOtek6LZzigycU2ZpPXP1G8Zlf6bUBMOzUCNP4cd7Wgl31r2mdMkX0f
         ncBw==
X-Gm-Message-State: AC+VfDy8M5dlSoiVrLoFe1jlYxFE2IorOMXrdTmTXFI4FNC1GDil2uRK
        YhksTmriPfXoCI1zVFyXDrjsZ9cZtGdwBZp2s/M=
X-Google-Smtp-Source: ACHHUZ6hu6JSlgvOsJ2SDpphZZDFxHAz2F5aw1DTumSE3joGanCbkHRdbO38QWOwvwHdA+sdkrQqOey7SYbzxKYx0iM=
X-Received: by 2002:a17:907:16a2:b0:978:73af:1bec with SMTP id
 hc34-20020a17090716a200b0097873af1becmr1326821ejc.33.1686296220552; Fri, 09
 Jun 2023 00:37:00 -0700 (PDT)
MIME-Version: 1.0
Reply-To: edwincastro0042@gmail.com
Sender: veiahy90@gmail.com
Received: by 2002:a05:7208:404a:b0:6c:424b:bc3f with HTTP; Fri, 9 Jun 2023
 00:36:59 -0700 (PDT)
From:   Edwin Castro <dy106k@gmail.com>
Date:   Fri, 9 Jun 2023 10:36:59 +0300
X-Google-Sender-Auth: yOKEDsMpSb8XrXkv4WW_2_Ni3Ro
Message-ID: <CAF7iCp8ZHtHRcoMS=Q=BEd_eDKRRg6KpJoJ8fgpPCGg1TTC4Hw@mail.gmail.com>
Subject: Mr. Edwin Castro
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dy106k[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [edwincastro0042[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [veiahy90[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Peace be with you,


My heartiest congratulations to you, I am Edwin Castro. you
have a donation of$2.000.000,00 usd. I won the  $2.04bn million Power
ball lottery on November 2022, I decided to donate part of it to five
lucky people and Ten
Charity organizations. Your email came out victorious. Contact me
urgently for claims.

Regards
Edwin Castro
