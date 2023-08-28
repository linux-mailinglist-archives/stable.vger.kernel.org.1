Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E7978A98A
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjH1KCl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjH1KC3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:02:29 -0400
X-Greylist: delayed 459 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 03:02:26 PDT
Received: from sv8486.xserver.jp (sv8486.xserver.jp [183.181.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCC591
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:02:26 -0700 (PDT)
X-Virus-Status: clean(F-Secure/fsigk_smtp/521/virusgw12006.xserver.jp)
Received: from webmail.xserver.ne.jp (webmail.xserver.ne.jp [202.226.37.183])
        by sv8486.xserver.jp (Postfix) with ESMTPA id 29FDB184219A37;
        Mon, 28 Aug 2023 18:54:43 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glory-web.com;
        s=default; t=1693216483;
        bh=rpUHn7kU1/Dak590j/h+MEmTMT+2DOsDjLv+q7c6B2A=;
        h=Date:From:To:Subject:Reply-To:From;
        b=iVXzIxwbDfmlTQmpzu+v3Jkd/dGNvUTEvghhMLW4sRYl8dE4tOHAkQ0O6fOtFIOhx
         8qOUCwb3Cj1WTc3a3rezRsXEIzMxJffReUDa5VLWBFWtmS+0lrx9DQtllwvs9AArIK
         /EURE3KHo71YhDoCK5Nd2pGjyekI0bx6ULwGuwuvy8pr3dd3XdxucClwa1tcMFl+1I
         T+h56nPZsqU3ssR3IgZqpULw4KQHb41lLKdLeN82Ewz92kp9gSJLuwXCCOqGYWqiqA
         d8JKjC2BFFxwqncRlCHOwKttJHkQi7Uho5BoPR3jemj3t2T4FgmyfZK62dgQx91re4
         8YMBFgf+JJXeg==
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 28 Aug 2023 02:54:43 -0700
From:   Law Chung <glory002@glory-web.com>
To:     undisclosed-recipients:;
Subject: New Business Proposal
Organization: Law Chung
Reply-To: lawkokchung487@gmail.com
Mail-Reply-To: lawkokchung487@gmail.com
Message-ID: <79fef4873b4adf2477d6915abac46f65@glory-web.com>
X-Sender: glory002@glory-web.com
User-Agent: Roundcube Webmail/1.2.0
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,ODD_FREEM_REPTO,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [183.181.84.7 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lawkokchung487[at]gmail.com]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  1.0 ODD_FREEM_REPTO Has unusual reply-to header
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



-- 
My name is Dr.Law Kok Chung, I have very important information that I 
would like to pass to you but I was wondering if you are still using 
this email ID or not. Please if I reach you on this email as I am 
hopeful, Please endeavor to confirm to me so I can pass the detailed 
information to you.

I will be waiting for your feedback.

Thanks

Dr.Law Kok Chung
Research Assistant
CV Industrial laboratory Ltd
