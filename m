Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E19754379
	for <lists+stable@lfdr.de>; Fri, 14 Jul 2023 21:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjGNTye (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 15:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGNTyc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 15:54:32 -0400
Received: from imsantv23.netvigator.com (imsantv23.netvigator.com [210.87.247.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D342D57
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 12:54:29 -0700 (PDT)
Received: from ybironout4a.netvigator.com (ybironout4a.netvigator.com [210.87.250.9])
        by imsantv23.netvigator.com (8.14.4/8.14.4) with ESMTP id 36EHWn3N027046;
        Sat, 15 Jul 2023 01:32:52 +0800
X-IPAS-Result: =?us-ascii?q?A0D//wCHhbFk/5JCtUFaGgEBAQEBPAEBAQECAgEBAQECA?=
 =?us-ascii?q?QEBAQMBAQEBFQmBPwIBAQEBAwEXAQEBgS4CAQEBTQEBAQEDAQITMR1aCRIuE?=
 =?us-ascii?q?h2Ee4QCg2sxAYcYgWwDAYRfhzyLSIZGgX0PAQEBERIBLAECBAEBgUSDOAEtL?=
 =?us-ascii?q?QEBARWFQQEUETwCDQECBAEBAQEDAgMBAQEBAQEDAQEFAwIBBwSBChOFTieBX?=
 =?us-ascii?q?QEBAQM1DAEBg1EBAQECAwEBAQEQAQEZFR8BLAIIAhENAgUTDgIWAQQaDTgCA?=
 =?us-ascii?q?QIDASMBAQEBAx+BTgICCEtEAQEBgWABNAMFnXOCNIUWh1aBMhoCZTuEJBiPU?=
 =?us-ascii?q?J9BgQeBFSsCAQEBAQFvhwwBih0bgg2BWIIwiRUWI4IuBIsZDgyCaII3kQiEU?=
 =?us-ascii?q?GeBVwINGYFviD4LCYEygUh5gX8XgWQ/g3NUgxyEYwyCRwQxgRxNAwkDBwUbE?=
 =?us-ascii?q?SILJwwLGA0UNxEsNQgtAgE/B0odFxcygR99pjyCP4l7iwyDdIxtY6AwCwoGh?=
 =?us-ascii?q?AWBWAefWBeDbpNRA5EzZLwMhmkOgVlwFYFZCYFBPxIZjgUBAQGUITdsAgcLA?=
 =?us-ascii?q?QEDCYVEAQEBAYNMgjQB?=
IronPort-Data: A9a23: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
 AuOw0U=
IronPort-HdrOrdr: A9a23:B96kNqGRKFnCracjpLqE48eALOsnbusQ8zAXPidKKSC9E/b4qy
 nAppsmPHPP5Qr5O0tPpTnjAsK9qBrnnPZICO8qV4tKNzOLhILTFvAB0WKb+UyEJ8SjzJ846U
 4aSdkcNOHN
X-Talos-CUID: 9a23:3nN/mmNUL6GqUu5DYDZK1B8rQJ8fUSfT0zDtKlOjM0J3R+jA
X-Talos-MUID: 9a23:X6S2pAU76ch83e/q/Dj1vWpiF9lj2YeNFUYvmI5B6s2aMQUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,206,1684771200"; 
   d="scan'208";a="323775817"
Received: from unknown (HELO singnet.com.sg) ([65.181.66.146])
  by ybironout4v2.netvigator.com with SMTP; 15 Jul 2023 01:32:39 +0800
Message-ID: <A1A412414A9EB023FFFAB30F8B065BC9@netvigator.com>
Reply-To: "Taras Volodymyr" <rifaataboud@cheapnet.it>
From:   "Taras Volodymyr" <wongcphk@netvigator.com>
Subject: I wish for a prompt response
Date:   Sat, 15 Jul 2023 01:32:37 +0800
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RCVD_IN_SBL,
        REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,STOX_REPLY_TYPE,
        STOX_REPLY_TYPE_WITHOUT_QUOTES,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [210.87.247.11 listed in zen.spamhaus.org]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [210.87.247.11 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.4 STOX_REPLY_TYPE No description available.
        *  0.0 RCVD_IN_MSPIKE_L3 RBL: Low reputation (-3)
        *      [210.87.247.11 listed in bl.mailspike.net]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 T_SPF_PERMERROR SPF: test of record failed (permerror)
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blocklisted
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.8 STOX_REPLY_TYPE_WITHOUT_QUOTES No description available.
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

D e a r Sir,

I am M r. Taras Volodymyr from U k r a i n e but lived in Russia for many years, I am a successful business?m a n here in Russia as I have been involved oil serving business.

Based on what is going here I found you very capable of handling this h u g e business magnitude, there is a genuine need for an investment of a substantial amount in your country. If you are willing to p a r t n e r with me I will advise you to get back to me for proceedings-details on the way forward.

I wish for a prompt response from you regarding my letter.

Warm regards,

Mr. Taras Volodymyr
