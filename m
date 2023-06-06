Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F93723728
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 08:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjFFGHA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 02:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjFFGGy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 02:06:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77660E69
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 23:06:29 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 38308e7fff4ca-2b1af9ef7a9so50319621fa.1
        for <stable@vger.kernel.org>; Mon, 05 Jun 2023 23:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686031585; x=1688623585;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GNFLMd0Iz8yGL3nN0jEtpSwqGwiS9lh7x3FaKK1+PGw=;
        b=X0mMondjcTPozWuNXTuBNo/WGkw1fm4EIbhuMmjMj9cWMgeWeXem1rY4BBPNuU+B7m
         ++76lNkR/hUVKRMA6Rvnuuwv9a/Ku6LYQfr/M/zUrMS8BHr6kCPzO3c5iuVwTRqPKFtN
         y79h+LcIEXZ7EQw2s8cEJT9wWMTCzNBtBbz2Hdefh4D0Qa0OYE4hSAv74mJXc7/XPefb
         6eDum29hkuDwbGyCPy0mIol2Z+a37KQzbvd1ggnO4QTH/tWPubZbhqvASbLzDZSWl87q
         HtMWfeQoEIMBY3V6aAZfR6IOlZeLwjTulxH+yoeJh17g+OtcHeVld4VcArdxBvalBeaq
         hYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686031585; x=1688623585;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNFLMd0Iz8yGL3nN0jEtpSwqGwiS9lh7x3FaKK1+PGw=;
        b=KgPrdUlJV8P3XH4Pwm0PqtNJiix3FWw3UNGS7VSM1UToqf6RCSp4gBvgytTOzWeeZm
         l45otmMlM0J64RTZ8LmzdwxTr5tdFApe2ZvZODi2XdtHnTwiTzNpx/i4I2iM0Ci8ctKm
         W7xSzLLEgQ8oJAZd7L4hkYr/pqg3KlB8JzTgo4oDrgQwxz/z2wMzav82Hq9AUAxO4KzU
         aRJ546+Z1vgXN5WwGJ2ik0IsOQM0tvIQV2EKuXV4LYbN/BGFuT+5vWHont+m84AKuRB6
         qfmaoSLGpg9TVNev4b2UolaZdsTZe8kpqjDTNsQyNk0AswejSu9YiaHGdIHRbt9Nw8p4
         J06A==
X-Gm-Message-State: AC+VfDxO+udDvDFiwTxyaQY9iV45WZnUSLCV/sVl/9MK5prtklFN+QQq
        iaPZX7OTCjsN8ozYr1U/m9hntxojcD2QPdiydGE=
X-Google-Smtp-Source: ACHHUZ6VfkGchpfpUtduap5YdfMbfRL45Y7BiovYKhUn89NYJ0sHka4JvMx8xDgXh9BjPEI8q2luYkeb3hQuGxLgnGw=
X-Received: by 2002:a2e:b0db:0:b0:2af:c9d8:87b4 with SMTP id
 g27-20020a2eb0db000000b002afc9d887b4mr698763ljl.29.1686031584508; Mon, 05 Jun
 2023 23:06:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:978c:0:b0:2ad:b6dd:5a8c with HTTP; Mon, 5 Jun 2023
 23:06:24 -0700 (PDT)
From:   AGHD AWN <aghdawn99@gmail.com>
Date:   Tue, 6 Jun 2023 07:06:24 +0100
Message-ID: <CANQW-srTg3qo73XR0h0-zoenu5qZwuJ3RReZPROopjdzqRZUUA@mail.gmail.com>
Subject: YOUR SHIPMENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,MONEY_FORM_SHORT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

I am David Morris Head of Inspection Unit United Nations Inspection
Agency in Harts field-Jackson International Airport Atlanta, Georgia.
During our investigation, I discovered an abandoned shipment through a
Diplomat from United Kingdom which was transferred from JF Kennedy
Airport to our facility here in Atlanta, and when scanned it revealed
an undisclosed sum of money in 2 Metal Trunk Boxes weighing
approximately 110kg each.


The consignment was abandoned because the Content was not properly
declared by the consignee as money rather it was declared as personal
Effect/classified document to either avoid diversion by the Shipping
Agent or confiscation by the relevant authorities. The diplomat's
inability to pay For Non Inspection fees among other things are the
reason why the consignment is delayed and abandoned.


By my assessment, each of the boxes contains about $4M or more. They
are still left in the airport storage facility till today. The
Consignments like I said are two metal trunk boxes weighing about
110kg each (Internal dimension:  W61 x H156 x D73 (cm) effective
Capacity: 680 L) Approximately. The details of the consignment
including your name and email on the official document from United
Nations' office in London where the shipment was tagged as personal
effects/classified document is still available with us. As it stands
now, you have to reconfirm your, Full name, Phone Number, full address
so I can cross-check and see if it corresponds with the one on the
official documents. It is now left to you to decide if you still need
the consignment or allow us repatriate it back to UK (place of origin)
as we were instructed.


Like I did say again, the shipper abandoned it and ran away most
importantly because he gave a false declaration, he could not pay for
the yellow tag, he could not secure a valid non inspection document(s)
etc. I am ready to assist you in any way I can for you to get back
this packages provided you will also give me something out of it
(financial gratification). You can either come in person, or you
engage the services of a secure shipping/delivery Company/agent that
will provide the necessary security that is required to deliver the
package to your doorstep or the destination of your choice. I need the
entire guarantee that I can get from you before I can get involved in
this project.Email me (mmrdavid7@gmail.com).


Best Regards,Email me (mmrdavid7@gmail.com)
Phone Number(404 282 1551

David Morris

INSPECTION OFFICER
