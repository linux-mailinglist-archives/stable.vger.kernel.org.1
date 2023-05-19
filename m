Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13B2709775
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjESMpN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 08:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjESMpM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 08:45:12 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD6510D
        for <stable@vger.kernel.org>; Fri, 19 May 2023 05:45:09 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 3f1490d57ef6-ba89d797197so2404469276.3
        for <stable@vger.kernel.org>; Fri, 19 May 2023 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684500308; x=1687092308;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmlwvXEoimVTfsyyyYai0GQlqo3zzXGhdH5Gfvmx5TY=;
        b=FR4t7uxhceSQP9jeciZvKYbWDckLmzJnOmPkg16j+qp1ontVbIGavU5i7OIhdkdEqM
         e8qUM9xowfSHaNJDCULFILHZ+lgGNO9yOpGcgRbav4iP7HSH8L7aoEt5NFzj6PpDsxgy
         AQJOcUWhtTibWDdEghicHPNLhV+03Lofe3ZErW77eLD5v7ImqaXso2kNEJ84mLE2HHDK
         /ApE43alg/vrOFWNqp21dCQUKahRz7ELyiPeyPmKeVKkfIz5JGDISzfrkGUJWAw/uYwB
         P3G2cZ4FFmVuMdagt8dVchV9eqX71svdV/JJZPxhNui/Nd+F19DvRSaDPl7oDeejUtfJ
         qFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684500308; x=1687092308;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmlwvXEoimVTfsyyyYai0GQlqo3zzXGhdH5Gfvmx5TY=;
        b=bz6v2WRMsK+8mX2NXJvTq3heRI3wcg+u5noPURHWaFWSROQ+zw/pw9LoXl06TBpCqX
         tXBKYB5gwmTNfTLW0HW46uyu9nRRauXHXOn+BcXIGpFKMpviyFvzWzJYot9tEu3ewCAO
         zrqKUNZ2+hBiwJTLqxoXxr5GqwZ5favCeyn1yPk6flGYQjjR2lEbpbYUI+zLPYLs6JBW
         30Hc9I36Cq0k+GGU8eA8eYajMquy/MH9TqaO4KbjF6fXDXH2n4KZUEUeYRsYlcOGNF3t
         iMaTFA3xXSt/PGIBpWu/DwdjmiEtWdSnz6PRPHIELYRoGNzP9HFcNHzFzCFyPStmFP40
         bNaQ==
X-Gm-Message-State: AC+VfDzk4tcHQCApKgq7EgRUdk9CMtaRXYDjhzUFSzHxisy0JDfyNHF3
        pDNIXsFXEHYZju0rwecdyLoQc0G69TYeLOkGL04=
X-Google-Smtp-Source: ACHHUZ65K0PaApc8h6xOmBcFmJzWAJsbbioM1ZrCf6WJS5fAhDTxfPfkiZCE1YbU7WOTu4daiZ23abN34w2ly9cLerE=
X-Received: by 2002:a81:a112:0:b0:561:df0f:bb79 with SMTP id
 y18-20020a81a112000000b00561df0fbb79mr1572625ywg.23.1684500308504; Fri, 19
 May 2023 05:45:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:4587:b0:349:f63e:5b3b with HTTP; Fri, 19 May 2023
 05:45:07 -0700 (PDT)
Reply-To: ninacoulibaly04@hotmail.com
From:   nina coulibaly <coulibalynina15@gmail.com>
Date:   Fri, 19 May 2023 05:45:07 -0700
Message-ID: <CA+8Vp3XWFTyk2x-kUYhwEsBDNcMhF-Y9UGn85sP+SwxqXp8UNg@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear,

Please grant me the permission to share important discussion with you.
I am looking forward to hearing from you at your earliest convenience.

Best Regards.

Mrs. Nina Coulibaly
