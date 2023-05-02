Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8766F3CCC
	for <lists+stable@lfdr.de>; Tue,  2 May 2023 06:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjEBEpr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 2 May 2023 00:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjEBEpq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 2 May 2023 00:45:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E824273F
        for <stable@vger.kernel.org>; Mon,  1 May 2023 21:45:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a42c22300so32345517b3.2
        for <stable@vger.kernel.org>; Mon, 01 May 2023 21:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683002744; x=1685594744;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dFUV0L1R63Jk4VAOkU6+F6CH+X9il2e6eJhacXiMldA=;
        b=NpD2EWYmcT6CM0UnjaWI/D46b9gJB47xRV5wXxvMxYKSG7jYGnjucujNRuLdJ5sWnn
         gQOnRCNa8O5DLwsLfprGbPt2wGSDdGBiYFRRjTXSFw6esqqLLApVC/IY2fQPZ/cz8umG
         jzYVP/OImHlMiYc/auUZ24ZV0RyeIHRBfcvJkil1krUAHZZAdGGYT+Sh3pTn9fPh19v1
         X37MEgrKNdOqCn7q5FDndomXVYwyBRJFkgtXZsTXjveL5nmJ5QbgXOg8sfiptkBfI7Z7
         fkERDb3JaRFzbqV8micu4vtCvXAj3dzUHd3rliGyjLvJL9oDGzWD4p/N2AW/2jHIPtvT
         5jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683002744; x=1685594744;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dFUV0L1R63Jk4VAOkU6+F6CH+X9il2e6eJhacXiMldA=;
        b=Fxm8VW+TriYYC6fqUv4J/HbiNIUtp4NhD+lEbN97blJttKyTLxrQl7LFSTE6PZUHvj
         /Txp6rP4ZdDldflzrhBPLsqmn0ZhZwAl7x9XOu3EgLudCzYoys5LYWfm4DOgq3fRMKn8
         ODs3xt4E5d/nAeFxLcLeJWIDDE19bv+67nZ9vOzBzHZmhS8OO0upV2+BKlBlHJUAfsSm
         ArMRNBOPLDMc99EwBrrG6HS/k67z4I0XSqVML+qnpHUHWU3v0Hfw65mOELXOhDcs2VWd
         /MWFyjzt+r8q/1I2m5yBlcU9yV6VYDvoM/zrdoh+o6MtUHyZ329W4NmhEC1ca4q7m1Or
         OLSw==
X-Gm-Message-State: AC+VfDzoZQoPtDD9Pvm5hhrMxJhKvNtEwTMAnCWOG+McR5nrtjjf55jE
        QDbfuHZvf5aMta3FjRQ46lReyb7GVOrI3eYUPSjW2Ida8E3KLGPnmXjtkijpHKKnk6rgIKr22J+
        flpMssgR0u8YDJyu89yY2swiD1eWsPpfU8i7ZiONLOb7gqEiY31yaeQDmsUcg5ixwiMuMOhP/Dt
        ebnwoNFio=
X-Google-Smtp-Source: ACHHUZ52OpWbnc+9UmLnHDuNg4ndfTDy413n96pGuyNy1cGgk4wnJ5xYd5c4kzDWQZJSsiXIJ5C8G2VAXbORS8iFAWIt6w==
X-Received: from meenashanmugamspl.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2707])
 (user=meenashanmugam job=sendgmr) by 2002:a05:690c:723:b0:54f:68a1:b406 with
 SMTP id bt3-20020a05690c072300b0054f68a1b406mr9151814ywb.2.1683002744157;
 Mon, 01 May 2023 21:45:44 -0700 (PDT)
Date:   Tue,  2 May 2023 04:45:26 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502044527.3062564-1-meenashanmugam@google.com>
Subject: [PATCH 5.15 0/1] Request to cherry-pick 026d0d27c488 to 5.15.y
From:   Meena Shanmugam <meenashanmugam@google.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, sashal@kernel.org, tytso@mit.edu,
        okiselev@amazon.com, Meena Shanmugam <meenashanmugam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The commit 026d0d27c488 (ext4: reduce computation of overhead during
resize) reduces the time taken to resize large bigalloc
filesystems(reduces 3+ hours to milliseconds for a 64TB FS). This is a
good candidate to cherry-pick to stable releases.

Kiselev, Oleg (1):
  ext4: reduce computation of overhead during resize

 fs/ext4/resize.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog

