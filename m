Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFB0705F2E
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 07:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjEQFXc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 01:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjEQFXc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 01:23:32 -0400
Received: from ya.lv (ya.lv [138.201.201.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395433C0C
        for <stable@vger.kernel.org>; Tue, 16 May 2023 22:23:29 -0700 (PDT)
Received: by ya.lv (Postfix, from userid 5002)
        id AF6359226F7; Wed, 17 May 2023 08:23:26 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ya.lv AF6359226F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.lv; s=default;
        t=1684301006; bh=LXIFG7ThwtsIlMQqkRnVjpb44hg5fDbovpAu19v6BoA=;
        h=Date:From:Subject:From;
        b=Js0l9QoW1O7YB3zaLqa9kI3BiQmEMd7B7rWOM/mulpBLjZYsKdvCulBVo2IksShR/
         auhrapfp6x2qfSqMs56rsxAJTxU1My0PUBiSCb/IxNlmuUVfAw2AHPstnBJ5aiP8zG
         XAsLZmS2WEfJY5JcpgUDRNRRnblpXTDKB4E8bdeI=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_40,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
Received: from dummy.faircode.eu (unknown [31.12.94.42])
        by ya.lv (Postfix) with ESMTPSA id 37F549226EB;
        Wed, 17 May 2023 08:23:19 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ya.lv 37F549226EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.lv; s=default;
        t=1684301005; bh=LXIFG7ThwtsIlMQqkRnVjpb44hg5fDbovpAu19v6BoA=;
        h=Date:From:Subject:From;
        b=a2Wfvn4UW+038PL8vqBSZ5g9BnIEc+14bbzcEq0bb8R2r/NfWqO0l9IHgFz7fAA3Z
         LTSkbPLh0HXeilJoBzKxzypCiCUCR4ukwizUXcQoCytGvXv3x2UJyrDOpSoB/G2+3p
         P2zkgUxfGjk82idWogU81bxNUkxm4PA4DsOyZgjE=
Date:   Tue, 16 May 2023 09:45:17 +0000 (UTC)
From:   TRANSPARENCY <TRANSPARENCY@YA.LV>
Message-ID: <c6b43d04-771e-479b-bcc6-4fe3dcc41247@YA.LV>
Subject: Sel4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <c6b43d04-771e-479b-bcc6-4fe3dcc41247@YA.LV>
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: ya.lv]
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2537]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [31.12.94.42 listed in zen.spamhaus.org]
        *  1.0 MISSING_HEADERS Missing To: header
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.0 DATE_IN_PAST_12_24 Date: is 12 to 24 hours before Received:
        *      date
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 TVD_SPACE_RATIO No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

https://privatebin.net/?9d5908aef3630cab#5XZMAUpCjLBQBkufJcTBmHSBwceMydWQ4Ek61E8pBAoG
