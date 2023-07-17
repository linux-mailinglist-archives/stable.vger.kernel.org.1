Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A147755AD5
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 07:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGQFRu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 01:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGQFRt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 01:17:49 -0400
X-Greylist: delayed 1141 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Jul 2023 22:17:48 PDT
Received: from mail.vast.vn (mail.vast.vn [210.86.230.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680DA1AC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 22:17:48 -0700 (PDT)
Received: from mail.vast.vn ([10.18.2.60])
        by mailgw.vast.vn  with ESMTP id 36H4w6Mb016471-36H4w6Md016471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Jul 2023 11:58:06 +0700
Received: from localhost (localhost [127.0.0.1])
        by mail.vast.vn (Postfix) with ESMTP id DFAC0C1E20DD7;
        Mon, 17 Jul 2023 11:55:36 +0700 (+07)
X-Virus-Scanned: amavisd-new at mail.vast.vn
Received: from mail.vast.vn ([127.0.0.1])
        by localhost (mail.vast.vn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BJIqv3oDoavK; Mon, 17 Jul 2023 11:55:36 +0700 (+07)
Received: from mail.vast.vn (mail.vast.vn [10.18.2.60])
        by mail.vast.vn (Postfix) with ESMTP id 2FE04C1E20DC0;
        Mon, 17 Jul 2023 11:55:35 +0700 (+07)
Date:   Mon, 17 Jul 2023 11:55:35 +0700 (ICT)
From:   Michele <tdangthuan@ich.vast.vn>
Reply-To: michelebrad11@gmail.com
Message-ID: <250790781.33948.1689569735147.JavaMail.zimbra@ich.vast.vn>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.2.60]
X-Mailer: Zimbra 8.7.11_GA_3865 (zclient/8.7.11_GA_3865)
Thread-Index: zdVsoPD+y9RgudkarHLRFj8wbPBCiw==
Thread-Topic: 
X-FE-Policy-ID: 2:1:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=ich.vast.vn; s=ich.vast.vn; c=relaxed/relaxed;
 h=date:from:reply-to:message-id:subject:mime-version:content-type;
 bh=QJSCxFHt+v7NpbIDZnvqowDaxiDLDVDSUdXtd00JKyc=;
 b=a6dRfwzIYHWDMC+JNvnZKOBzOF88OkXKCR1NWtYmqsfS7tHj4D6IG4YAd5b2g6EChuYgpY0u4MlH
        O8tFRSl0hoE9DvyHgPZQMDOADUa9HRLYOGeC9jAS8dVBkd8vGkN4q/gWIuQulC2goOcO4oHxg0xM
        1wqeZbrELbYTc+uXy22zG8FK8ahc2/riamfB0l4EnOBVaz95wDeM4D59ZjKeoYuRglLzTbcGN9bR
        +31IbbwHCWnk/3kCSsnNQI81T6pHc4okSzcKjIP9Jl4Jk8MH95cKgl/8jtZanSiNoFktr9NyNnwb
        jmyB7mIPpjHdgoxglr7KP2n47ARs8IPEdmHdnQ==
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_HEADERS,REPLYTO_WITHOUT_TO_CC,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5010]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michelebrad11[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Do you get my last mail
