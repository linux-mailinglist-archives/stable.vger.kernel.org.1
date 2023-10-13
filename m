Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B7D7C7B8B
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 04:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjJMCRn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 22:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMCRn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 22:17:43 -0400
Received: from correo1.cdmx.gob.mx (mtax.cdmx.gob.mx [189.240.235.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F04B7
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 19:17:41 -0700 (PDT)
Received: from cdmx.gob.mx ([10.250.108.150])
        by correo1.cdmx.gob.mx  with ESMTP id 39D2Gt4a012778-39D2Gt4c012778
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Oct 2023 20:16:55 -0600
Received: from cdmx.gob.mx (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTPS id 1C739247DA4;
        Thu, 12 Oct 2023 18:46:55 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 6E8A82464BF;
        Thu, 12 Oct 2023 18:46:54 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx 6E8A82464BF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=cdmx.gob.mx; s=DKIM1; c=relaxed/relaxed;
 h=content-type:mime-version:subject:to:from:date:reply-to:message-id;
 bh=qDfDDZEBk8M7MTFErO8hIV480dUucX8Ru99hbA2qSv0=;
 b=CFIhlcyGgcyQ+SE7R1CxVyLnm4W8Z80dxdIGPtg1onET+VcZJUDfPMIVe8LoRuPpXTVpbWxILAI1
        1h8TlY6Cq7CSTkbYT4XOcs306p+0fsLsnlSlUIIWkSpHDvUGZJNa8FHb+R4unjU1+aapSjx6Ygrl
        W4p1PszDGFtiBTKA2RJImAcZJTEFXf3lqir+6iMCqeju5fOMtMbkOj/9jV3k7MJ+ET7w7Cr6ZdKD
        mRXe340XaNSY6UUHU4ETszePFUSuPVK7oHPRcDiqrXak36fhp948PdmEayRM4DMj8TWUX+uUvQJc
        MLeteg5+ljbnNNCjNkCbQ66zCapbR085+MXnJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=2020J4N146MXCTY; t=1697154414;
        bh=tSvTWByvAH0bazU3z5EEvkaKQS/+3VfeAyOQsWsou9o=;
        h=Content-Type:MIME-Version:Subject:To:From:Date:Reply-To:
         Message-Id;
        b=dCAw8SRnye9vQvdJL34Cj/qZt9z1BgrLsffO6RGL1RjftK35fHp68TCBcVR3muNoX
         IrsF9mrVblUmJ8B+HPooWSgxDFtsdihm2o+FEExY+tkv0/F/a5tbaQKRXHFoDw/3Yq
         IHYOqYa7fWcEV9MgFMe+Mgr6CB+nX70O3yXpMu2s=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RokdeGY5sEbR; Thu, 12 Oct 2023 18:46:54 -0500 (CDT)
Received: from [192.168.8.123] (unknown [179.61.245.12])
        by cdmx.gob.mx (Postfix) with ESMTPSA id 84084247531;
        Thu, 12 Oct 2023 18:44:05 -0500 (CDT)
Content-Type: multipart/alternative; boundary="===============1125803073=="
MIME-Version: 1.0
Subject: $4.8 million dollars.
To:     Recipients <ctrinidad@cdmx.gob.mx>
From:   "Mr. Dennis Banfield" <ctrinidad@cdmx.gob.mx>
Date:   Thu, 12 Oct 2023 17:44:29 -0700
Reply-To: dbanfielddonation@gmail.com
Message-Id: <20231012234405.84084247531@cdmx.gob.mx>
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        HK_NAME_MR_MRS,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,SPF_HELO_NONE,
        SPF_PASS,SUBJ_DOLLARS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6063]
        *  0.1 SUBJ_DOLLARS Subject starts with dollar amount
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.0 HK_NAME_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.5 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

You will not see this in a MIME-aware mail reader.
--===============1125803073==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body

I have a donation of $4,800,000.00 dollars for you, I won the UK lottery Po=
werball jackpot and I donated a part of it to charities. kindly contact me =
for your donation via (dbanfielddonation@gmail.com) for your claim.
--===============1125803073==
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body

I have a donation of $4,800,000.00 dollars for you, I won the UK lottery =
Powerball jackpot and I donated a part of it to charities. kindly contact=
 me for your donation via (dbanfielddonation@gmail.com)) for your claim.

--===============1125803073==--
