Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220E07085B7
	for <lists+stable@lfdr.de>; Thu, 18 May 2023 18:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjERQNA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 18 May 2023 12:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjERQM6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 18 May 2023 12:12:58 -0400
X-Greylist: delayed 12472 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 May 2023 09:12:53 PDT
Received: from puskom.unisbablitar.ac.id (unknown [36.66.216.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF7AE68
        for <stable@vger.kernel.org>; Thu, 18 May 2023 09:12:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by puskom.unisbablitar.ac.id (Postfix) with ESMTP id 3BDBF2C5365;
        Thu, 18 May 2023 03:10:09 +0700 (WIB)
Received: from puskom.unisbablitar.ac.id ([127.0.0.1])
        by localhost (puskom.unisbablitar.ac.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sa0SAY63iq6U; Thu, 18 May 2023 03:10:01 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
        by puskom.unisbablitar.ac.id (Postfix) with ESMTP id 756E82C50EA;
        Thu, 18 May 2023 03:09:46 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 puskom.unisbablitar.ac.id 756E82C50EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisbablitar.ac.id;
        s=65594E22-FAEF-11E9-AC00-7BF9109A8870; t=1684354186;
        bh=txycSiCzWMZdBftZ6p+Hlkov2Ks8VQ2zsXx/qxMWAYI=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=k5+kMubtTwCw4iplV4ghTvqHA2+aZ7WiaLBTLXIQmRL/o64PDj2Cv7tPEjcIxJ4xf
         W3gl4nBgNrdMp0ot0/1pDoDPiQlg+ZAktjtgwb/clc1Gly9OQemj6rH+OOcVsBrv2N
         IKkFMDcxvuGSTntQaE78qhbFZNoKkRxwtsd/08U6skTf4Q3COCsP1/H775hodXYkGF
         neUBoUzUYXgCPsKnO5mBA7CnRZcaVCZXg7rm1VT34z9YuGlLsUa1JRjVhCGOLcZ+9S
         CTOybaj/hMZCCiaha/1mdee1piC/Hb9b73YS61XwW30RQb2tQXGw0e5cvoEeIitqeI
         DsGRYgazEogDg==
X-Virus-Scanned: amavisd-new at unisbablitar.ac.id
Received: from puskom.unisbablitar.ac.id ([127.0.0.1])
        by localhost (puskom.unisbablitar.ac.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F8TqhdQXqw-r; Thu, 18 May 2023 03:09:46 +0700 (WIB)
Received: from [192.168.88.20] (unknown [181.214.93.85])
        by puskom.unisbablitar.ac.id (Postfix) with ESMTPSA id ACE9E2C53B5;
        Thu, 18 May 2023 03:09:27 +0700 (WIB)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re:
To:     Recipients <deddysetyawan@unisbablitar.ac.id>
From:   "Cristy Davis" <deddysetyawan@unisbablitar.ac.id>
Date:   Wed, 17 May 2023 21:09:08 +0100
Reply-To: owenthomas3244@gmail.com
Message-Id: <20230517200927.ACE9E2C53B5@puskom.unisbablitar.ac.id>
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        MONEY_FROM_MISSP,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [owenthomas3244[at]gmail.com]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FROM_MISSP Lots of money and misspaced From
        *  2.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Good day to you, my name is Cristy Davis, winner of $70 million Powerball j=
ackpot held in February 12, 2020. Based on the Epidemic corona-virus diseas=
e (COVID-19) which is befall the whole wild world, I and my family have dec=
ided to donate $850,000 U.S. Dollars to charity to help you and the poor in=
 your community and to enable you and your family to stay safe and stay in =
a good height . Please email my assistant Thomas Owen for more information =
to guide you to receive my donation. via Email (owenthomas3244@gmail.com) a=
nd below is the link for reconfirmation of my winning.

https://powerball.com/winner-story/mi-lottery-waterford-woman-wins-70-milli=
on-powerball-jackpot

Friendly greetings,

Regards
Mrs. Cristy Davis
