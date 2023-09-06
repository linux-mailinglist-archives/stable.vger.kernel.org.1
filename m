Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8527937AC
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 11:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjIFJF3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 05:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjIFJF3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 05:05:29 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A64E61;
        Wed,  6 Sep 2023 02:05:23 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qdoTI-00BH6H-GC; Wed, 06 Sep 2023 17:05:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 06 Sep 2023 17:05:14 +0800
Date:   Wed, 6 Sep 2023 17:05:14 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Bug in rsa-pkcs1pad in 6.1 and 5.15
Message-ID: <ZPhAyty1r8ASyr+F@gondor.apana.org.au>
References: <ZPcFyp4jdE3uSeqW@gcabiddu-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPcFyp4jdE3uSeqW@gcabiddu-mobl1.ger.corp.intel.com>
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [167.179.156.38 listed in zen.spamhaus.org]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [167.179.156.38 listed in list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.0 RDNS_DYNAMIC Delivered to internal network by host with
        *      dynamic-looking rDNS
        *  3.6 HELO_DYNAMIC_IPADDR2 Relay HELO'd using suspicious hostname (IP
        *       addr 2)
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 05, 2023 at 11:41:14AM +0100, Giovanni Cabiddu wrote:
>
> Options:
>   1. Cherry-pick 5b11d1a360ea ("crypto: rsa-pkcs1pad - Use helper to set
>      reqsize") to both 6.1.x and 5.15.x trees.
>   2. Revert upstream commit 80e62ad58db0 ("crypto: qat - Use helper
>      to set reqsize").
>      In 6.1 revert da1729e6619c414f34ce679247721603ebb957dc
>      In 5.15 revert 3894f5880f968f81c6f3ed37d96bdea01441a8b7
> 
> Option #1 is preferred as the same problem might be impacting other
> akcipher implementations besides QAT. Option #2 is just specific to the
> QAT driver.
> 
> @Herbert, can you have a quick look in case I missed something? I tried
> both options in 6.1.51 and they appear to resolve the problem.

Yes I think backporting the rsa-pkcs1pad would be the best way
forward.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
