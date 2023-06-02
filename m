Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E057208C0
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 20:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbjFBSDj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 14:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbjFBSDi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 14:03:38 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6867AA3
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 11:03:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso3494218a12.0
        for <stable@vger.kernel.org>; Fri, 02 Jun 2023 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685729015; x=1688321015;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rJ7KGRkSjfrW3o2ovQOUnSAv/55k6jXIbw1yHmYF3m4=;
        b=xVg4g6xlSyTKzMyZJ3xJJf6uON5LE8yHps2P0cyS9B4DImDBUE+mZW5NsKMZV9Icz5
         i2Qv7ZKSl6LN88LElijg5Z/IIxsnpi1THMVYnpdhOa6dlt2xYVLlh3nTsa3wbQVvX1w6
         ZsLaCPfR/uL4wAOE9uMQYfNbY7T8YcKwP6nZHa7cbCjb6OsBY3+f3eQcceNTc9RbwUK6
         ELa0JflNOTj2YSIN+InWHXlxG28gqljtPrMNqNOJs+/Q9fNbPfOzdTDlxsJljWahNaDx
         BLicDBBVXBT9MUo+Itanuvs5bK/VEHgz7bAUP7lHJAf5+IU0yM9UJeI5aBOjYs0GHAjc
         so2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685729015; x=1688321015;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJ7KGRkSjfrW3o2ovQOUnSAv/55k6jXIbw1yHmYF3m4=;
        b=GkaVzQBolJNQrifMSjxdq36Gu9jMWQOi/9ycx3IqdaC5IuZIisxqUhAcwmTf4k6sdr
         c5KS69Yzihw7aK+LztNwnim0WAH9LdTkwTOKIM4UISTtVLnNn6D4RuKyU7n9PD/oLd24
         Sww52Hpv8/0H8qLfe2kRuxb87QrSX+laQCAq2FG+xYfLa5hYZh4OsngYOoQn4RQcSHQ0
         Ukwfvt1PFmSStEFsYE+VTCwDcQNMFh9J1vo7nBR9BxP3eY3+DP46+IK0SX059azFLGZs
         S26zB6BD2ILpveFNMuWZlEd6VAWaqexMd2h40fGCnNegTLtd8R3s6D8A6eg7PFDt4Mkw
         avOg==
X-Gm-Message-State: AC+VfDyf2XV30D3REVQNaftG0SMVeqZNZRnIagnv7cqgO0Ped7OrLRq8
        XHCGwFICb5fBrtdXAt8pEPxfx7Gw+TMY+PFxFVehHvmYfa6uWj3Momgn3g==
X-Google-Smtp-Source: ACHHUZ76CACkTBk71DRJtcZLizyuphsgTufPFem8oIRwb9CJTKqFXw6MVj2p3Hdq93RAcEF8yp1Rqhe8gRFiymjYe+w=
X-Received: by 2002:a17:907:d89:b0:973:dd61:d420 with SMTP id
 go9-20020a1709070d8900b00973dd61d420mr11712675ejc.74.1685729015128; Fri, 02
 Jun 2023 11:03:35 -0700 (PDT)
MIME-Version: 1.0
From:   Jim Wylder <jwylder@google.com>
Date:   Fri, 2 Jun 2023 13:03:24 -0500
Message-ID: <CAEP57O8D-73=CS_6=s=2pvVjt=sQEv_60TpuppxwnxyN6v4pQg@mail.gmail.com>
Subject: regmap: Account for register length when chunking
To:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Requesting that this regmap fix be cherry picked into the active
stable releases 5.15 and later (5.15 being the earliest I was able
to test).

Commit 3981514180c987a79ea98f0ae06a7cbf58a9ac0f fixes a error in
_regmap_raw_write() when chunking a transmission larger than the
maximum write size for the bus and when bus writes the address
and any padding along with the data.

Jim

The original commit message is:

------
commit 3981514180c987a79ea98f0ae06a7cbf58a9ac0f
Author: Jim Wylder <jwylder@google.com>
Date:   Wed May 17 10:20:11 2023 -0500

    regmap: Account for register length when chunking

    Currently, when regmap_raw_write() splits the data, it uses the
    max_raw_write value defined for the bus.  For any bus that includes
    the target register address in the max_raw_write value, the chunked
    transmission will always exceed the maximum transmission length.
    To avoid this problem, subtract the length of the register and the
    padding from the maximum transmission.

    Signed-off-by: Jim Wylder <jwylder@google.com
    Link: https://lore.kernel.org/r/20230517152444.3690870-2-jwylder@google.com
    Signed-off-by: Mark Brown <broonie@kernel.org
------
