Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC3978019C
	for <lists+stable@lfdr.de>; Fri, 18 Aug 2023 01:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356040AbjHQXVE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 19:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356078AbjHQXUq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 19:20:46 -0400
X-Greylist: delayed 730 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 16:20:41 PDT
Received: from mx.iao.ru (mx.iao.ru [84.237.1.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122EA35B5
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 16:20:40 -0700 (PDT)
Received: from mail.iao.ru (web.iao.ru [84.237.1.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vpsh)
        by mx.iao.ru (Postfix) with ESMTPSA id DBAEB6105D;
        Fri, 18 Aug 2023 06:08:01 +0700 (+07)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iao.ru; s=dkim;
        t=1692313682;
        h=from:from:reply-to:reply-to:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YdcvalcAXkTjutTxZb4urzHELA7/RlZirfsdlIaRVAU=;
        b=InmRJoun7gVdjkMWzM6a5AXNIxMPBG9XmrcpbdkxggvN3BPuoVLcuvFZYBlXq+HHLRC0s4
        uaqrm1vLp74J1RwrQTAntkLaElMZIaOzAUMjrLGCVgqhMmu8RRaAQRZi/pQQrNzMCnRj/a
        rb9qkn/3C1Ggp/Xxwu3/r+Pp/ULCoWKQPGAAPIEpOKG1KsP2rIwdOKF0gqQVy/CBJ76GWW
        xJyXZ6AiGEhWoopGUENzBVsmhrxe0mb3fNz8YTTxYSvIkFswg8qiQJmkqdUvVjqDf3EXQw
        LNnx4J0DwP/zR5zmybMqrt4Yk4UfOuP1B8sjraPsKTllY7dHOZ/U3IKjLNqaeA==
MIME-Version: 1.0
Date:   Fri, 18 Aug 2023 00:07:55 +0100
From:   Michele Brad <vpsh@iao.ru>
To:     undisclosed-recipients:;
Reply-To: michelebrad71@gmail.com
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <12c92ae628bbfcde997fc6cf96ece211@iao.ru>
X-Sender: vpsh@iao.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_SUBJECT,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Did you get my last mail
