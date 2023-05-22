Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FC270D478
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 09:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjEWHA4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 03:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjEWHAh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 03:00:37 -0400
Received: from puskom.unisbablitar.ac.id (unknown [36.66.216.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87621A7
        for <stable@vger.kernel.org>; Tue, 23 May 2023 00:00:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by puskom.unisbablitar.ac.id (Postfix) with ESMTP id E70B22E4949;
        Mon, 22 May 2023 17:38:38 +0700 (WIB)
Received: from puskom.unisbablitar.ac.id ([127.0.0.1])
        by localhost (puskom.unisbablitar.ac.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wmlB_lpW6Z0E; Mon, 22 May 2023 17:38:35 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
        by puskom.unisbablitar.ac.id (Postfix) with ESMTP id D8A8C2E18A2;
        Mon, 22 May 2023 17:25:00 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 puskom.unisbablitar.ac.id D8A8C2E18A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisbablitar.ac.id;
        s=65594E22-FAEF-11E9-AC00-7BF9109A8870; t=1684751101;
        bh=txycSiCzWMZdBftZ6p+Hlkov2Ks8VQ2zsXx/qxMWAYI=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=Nf3rZtC2tNSQEhXFFLjVhodZUw32R2RglCY8dltw7UcYB71YJTG3Y2bWmyJ5ZhEHi
         ss9oUAnDnvQESym2e6tRn2Jggmdae4cOL7tuD7pw2vhhjxNZiBVprWVigB8cIQ8ysJ
         1UVPEQ6ht6CnIa/+OvRBrxuCH+lYlz/44xvUn1Ki8G6fjF0zvzGBXHx6zag7vtzxKu
         ML5VpiierpJtlC2MBEIDcMWYMvp57o9NUg0sGZEDweecE6qvw4jDeoK/YQP+Zk9ZvW
         +azo/7N+dG7WlgH4kpkYEjyBqMtv6xrDanpr9a6W4FR1KH3wjipaWyZAb/yV4oQzQS
         Xtawa1kmu5lJQ==
X-Virus-Scanned: amavisd-new at unisbablitar.ac.id
Received: from puskom.unisbablitar.ac.id ([127.0.0.1])
        by localhost (puskom.unisbablitar.ac.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ategCug3Bw_7; Mon, 22 May 2023 17:25:00 +0700 (WIB)
Received: from [192.168.88.20] (unknown [181.215.182.160])
        by puskom.unisbablitar.ac.id (Postfix) with ESMTPSA id 3AB3A18AE50;
        Mon, 22 May 2023 17:15:12 +0700 (WIB)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re:
To:     Recipients <deddysetyawan@unisbablitar.ac.id>
From:   "Cristy Davis" <deddysetyawan@unisbablitar.ac.id>
Date:   Mon, 22 May 2023 11:14:59 +0100
Reply-To: owenthomas3244@gmail.com
Message-Id: <20230522101513.3AB3A18AE50@puskom.unisbablitar.ac.id>
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        MONEY_FROM_MISSP,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: powerball.com]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [owenthomas3244[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FROM_MISSP Lots of money and misspaced From
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  1.8 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
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
