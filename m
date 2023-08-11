Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCEA779871
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 22:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjHKUTp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 16:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjHKUTo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 16:19:44 -0400
Received: from abi149hd127.arn1.oracleemaildelivery.com (abi149hd127.arn1.oracleemaildelivery.com [129.149.84.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C14D3
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=UYee5eYiAK39Q1z3nNQNBRUkESDlag9nZFyEI55xUb4=;
 b=PX+CzZOP3TYoeq/XPPc4KeU/taJiCtEtliip0vS4MaZryizYEnEp5yJEv68I8r1FbRV7hVO1l3N3
   6H+lmrST4xSxhep31t7zZZJh1Mv1riwNewos1mTsEYhpMVVzIC3gA3LGgNFBzj3AYPkSwX61QQy5
   QTMjgpBG4GMsz79/GzBSDhJbz9ctqJoohcGg7tdd+ZuFerCVL+ddGkt4dM0QeNRAvwHdyUecJefa
   L5TJ6VNclbRdaar704a0U6RluBUn6nvZtPyZbtzQ2Los7f13BvCTyMqhKFWohiKHmfFvl4ODlsw4
   3/g7f/OLajuueRYYzhf4eTND/Y+udqlvJlbdYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=UYee5eYiAK39Q1z3nNQNBRUkESDlag9nZFyEI55xUb4=;
 b=W+3rx2WSYISvmXfUUCd1AylM3T0PMXsoyIBlxYHyZUlYbIsLuh57hR5/woSLh1Ph1kQh44en+LOR
   RihA1cLXP8kF0n7aZeMwYMev/XpXTen96ukmgqOLXOFRIfxRkPJye9IKQwf3R2WMCs6i93SDrFzk
   fG7GdFO8oDvmH8JkugqbDyVERNGoscQBnx6MWsdhKtqiP5G3ixQxpbTtirdj1d04b5C4EtbNQOi8
   qNYvLTMKjDuDXe4R78OqvSYa7MRiZUWQ+nWV2z03a+JV8RTHoWQPj6EAAntlz+IbCcJFoEduCaDN
   votXaqcBN0dnx+7H/B2PFzniWjzssSFjstTKRg==
Received: by omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230707 64bit (built Jul  7
 2023))
 with ESMTPS id <0RZ80042PTSQFN40@omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for stable@vger.kernel.org; Fri, 11 Aug 2023 20:19:38 +0000 (GMT)
Message-id: <0f422dbe-2e3f-4401-be87-2963cbbc1234@augustwikerfors.se>
Date:   Fri, 11 Aug 2023 22:19:35 +0200
MIME-version: 1.0
From:   August Wikerfors <git@augustwikerfors.se>
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
To:     stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        nilskruse97@gmail.com, David.Chang@amd.com
References: <20230731185103.18436-1-mario.limonciello@amd.com>
 <ZMgHE2wu4T4OfrTR@kbusch-mbp>
 <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
 <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com> <20230731201047.GA14034@lst.de>
 <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com> <20230801112403.GA3972@lst.de>
 <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
 <ZMlrGNw5OMW3yxId@kbusch-mbp.dhcp.thefacebook.com>
 <b2e741b3-b581-40fe-2c28-e4660f52003d@amd.com>
Content-language: en-US
In-reply-to: <b2e741b3-b581-40fe-2c28-e4660f52003d@amd.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAE8DGuEMYrf45lHTdh54TgMaNY8+iRJQTe9hY+5T0LFf3+29Cv+oDRjYT9Xx6Yl
 nrJvLuvW/4wHxW/x225L0uH+OgeGKGJw2N7fIIzJ6UrAKTvXTq8oqNSb5ephTORm
 gqok+QMQVFWexLo0GnibyzN6oFK/z60vHfIIRIe2/qJiZHMbKl1Hj/W/kUMewVvc
 P5JrAz61Kd9rfQa9AHbPmryIwcz8VjgGqlMrJfrRdGODoW2Yxx4KWem+V15kz5FW
 Cf/CCv6d/vNQv/ZtCQMMWAxeXNFKGQMcnoynubaQlGxhLsnZ4mtwsUBPC8kjKp/+
 oEiEhrFOks/bZIpmTWxhLt4emr0Hc58Eqdbh9m5CuZpY8UmJSj0HKJ+Kc0o4mXCm
 mv7WtDF9HwRnXbzeBkqzGNEn3iy/UFxUDzzC0wZuVNzx7hK+QR5o0AuwrpO2sQQE neY=
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023-08-01 22:34, Mario Limonciello wrote:
> If you can still change it before sending out can you add a stable tag 
> as well?

This didn't get added in time, so, stable team, please backport:

688b419c57c1 ("nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G")

Regards,
August Wikerfors
