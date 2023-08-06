Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ADF77172B
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 00:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjHFWKm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 6 Aug 2023 18:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFWKm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 6 Aug 2023 18:10:42 -0400
Received: from mail.vast.vn (mail.vast.vn [210.86.230.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B433171E
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 15:10:41 -0700 (PDT)
Received: from mail.vast.vn ([10.18.2.60])
        by mailgw.vast.vn  with ESMTP id 376M6fDm003977-376M6fDo003977
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 7 Aug 2023 05:06:41 +0700
Received: from localhost (localhost [127.0.0.1])
        by mail.vast.vn (Postfix) with ESMTP id 44A9EC1E20DDF;
        Mon,  7 Aug 2023 05:03:34 +0700 (+07)
X-Virus-Scanned: amavis at mail.vast.vn
Received: from mail.vast.vn ([127.0.0.1])
 by localhost (mail.vast.vn [127.0.0.1]) (amavis, port 10026) with ESMTP
 id Ya99MnbyOpfr; Mon,  7 Aug 2023 05:03:34 +0700 (+07)
Received: from mail.vast.vn (mail.vast.vn [10.18.2.60])
        by mail.vast.vn (Postfix) with ESMTP id 4B0E6C1E20DC1;
        Mon,  7 Aug 2023 05:03:32 +0700 (+07)
Date:   Mon, 7 Aug 2023 05:03:32 +0700 (ICT)
From:   Michele Brad <nguyenmanhtuan@iams.vast.vn>
Reply-To: michelebrad11@gmail.com
Message-ID: <546883243.15497.1691359412220.JavaMail.zimbra@iams.vast.vn>
Subject: Re
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.2.60]
X-Mailer: Zimbra 8.8.15_GA_4562 (zclient/8.8.15_GA_4562)
Thread-Index: 6eJZ37AxQEMdwPo3L+HGhCcurIyabg==
Thread-Topic: Re
X-FE-Policy-ID: 2:1:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=iams.vast.vn; s=iams.vast.vn; c=relaxed/relaxed;
 h=date:from:reply-to:message-id:subject:mime-version:content-type;
 bh=Cq/jvZcI6xPOVFUZ5iOxk6fWie0GRBH2UJ1yLyM4Tpk=;
 b=T1T451u1V8UxG/cudaIeu7sEOuJ46mOgu0DFOajYK8LKpSh7zXUHJKJ2Slo7F7amVHbvo8gvjH4s
        D6vEXN9HNzBXsE2hPvOQwx+4nNhFSujU5MH1l96H753KBGzXRmxvO1E5Bu7CKjyAV51ifHQszcNe
        d2xxI0QjOKIkcb0cFIOIKxeqOyGZdXeK2unXhUM826O75om+UQkwt62ybL4Nbywok8iG/Jyiq3ZL
        XwlwaEKgi1UpruQlRIpk1I7+nT2ikT7aUHq3v09MyMxht7CO/kYgf/WBkos8ptXxNvIvjXotojs2
        vPvPz7R/Qi1Qkhvw1LlKferVvTwqjLItMmik7w==
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,
        REPLYTO_WITHOUT_TO_CC,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [210.86.230.123 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michelebrad11[at]gmail.com]
        *  1.0 MISSING_HEADERS Missing To: header
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Did you get my previous mail
