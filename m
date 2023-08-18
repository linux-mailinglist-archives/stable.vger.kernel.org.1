Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EAE7814AE
	for <lists+stable@lfdr.de>; Fri, 18 Aug 2023 23:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbjHRVUm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 18 Aug 2023 17:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240749AbjHRVUd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 Aug 2023 17:20:33 -0400
X-Greylist: delayed 710 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 14:20:31 PDT
Received: from mail.iea.ras.ru (mail.iea.ras.ru [83.149.210.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1698426A4
        for <stable@vger.kernel.org>; Fri, 18 Aug 2023 14:20:31 -0700 (PDT)
Received: from mail.iea.ras.ru (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by mail.iea.ras.ru (Postfix) with ESMTPS id 669CB60468;
        Sat, 19 Aug 2023 00:08:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iea.ras.ru; s=mail;
        t=1692392913; bh=YdcvalcAXkTjutTxZb4urzHELA7/RlZirfsdlIaRVAU=;
        h=Date:From:To:Reply-To;
        b=fZA3AUlwgHqdq4Td87+ZAd6KQw2bVNAlPyuBNxYUrLQuTakHIeQA2don1+Mfqmn5f
         qxFnVk+pfw9/Vki1W0NTGwnCTaix8w1oveU+BdDXvSmjOCAZ9uEQWTdFbIPQrgLsPo
         Ktlqwt1waoPvk4Sd2fALz0LN3nv+FdsJzMmqjNT/ESt18stR9v626EIS8Y9Holsco0
         /qaaf9+CD/1TYCIxkyWehfGY5K5+a3gf7PmxI7dMExxrphAnRJ1HH1L9nxdqGJLXal
         BaehJSXQstYvQjQqHygaOhpWpxYsrWu+8FOk8TRFoNB2bp4B2vOWpkk7x1sr3ErS7D
         gLVxsa3PBMlqw==
MIME-Version: 1.0
Date:   Fri, 18 Aug 2023 22:08:32 +0100
From:   Michele Brad <info@iea.ras.ru>
To:     undisclosed-recipients:;
Reply-To: michelebrad11@gmail.com
Mail-Reply-To: michelebrad11@gmail.com
Message-ID: <9a1295a9487cfac16104d924c2dc1a1e@iea.ras.ru>
X-Sender: info@iea.ras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam: Yes
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_SUBJECT,ODD_FREEM_REPTO,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: ras.ru]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michelebrad11[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.5 ODD_FREEM_REPTO Has unusual reply-to header
        *  1.8 MISSING_SUBJECT Missing Subject: header
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Did you get my last mail
