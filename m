Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2127A710A00
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 12:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjEYKXE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 06:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240537AbjEYKXE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 06:23:04 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8696B97
        for <stable@vger.kernel.org>; Thu, 25 May 2023 03:23:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 38308e7fff4ca-2af278ca45eso4041091fa.1
        for <stable@vger.kernel.org>; Thu, 25 May 2023 03:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685010181; x=1687602181;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KMB0bTLuuJrsur5HwaoZSoNyxlyt4JLgpsXnjRW2ODU=;
        b=rVagyD3GdLchYenHS+7KrtAtO/+v3L/lPTIkh9mCJnSgD+bWUt8Gfjdfcse3KAh1t1
         aw63ASsEoSlAl2Wrx99pqKIh2m0/OX6TbRqiiTNukLzbyAPOqrnVIeA70UkvslW63P1P
         ab3+uoTzv9fgdVvqfGouzZ93GzbgHIgp/nVjlNjrrWC7joWG4P2wiUKJkiYrO+mnLZFu
         KoPk14d/9QJb3IhmbMeU4BDSvCjjoiaWWA+SEf8Y8Y77PvH6Xv+TA1vOZe/NkK6IX2N5
         CNJU9ojlrP5MVAAoKD06A8bWIJDW+lPQ/HHrNpN1Epn5qQ0wG2vFcDk48XhN36Su951c
         WxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685010181; x=1687602181;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMB0bTLuuJrsur5HwaoZSoNyxlyt4JLgpsXnjRW2ODU=;
        b=LDWXG+05k2F78zYpXrvVzUI0dDB4BcVfZg8OfEasPEcVOHzPdszqD7sWoTlWTj58wh
         MIASAcSQoTggaEZUdubuyFSCfcuwTzEsjhL0qzwkGbo5aWCQxq75eYZfgBHnuR7/wnc3
         yyE2txPazdawjmveM/Tsb5zv2Ag0BVHJlW4bYxs6pnX1Q5X9SvhjtcYZFr/fjWnOFBts
         PTfXfP8OKTToBfP4TBT2WxZfMmlGWRH4HgxPgPV2pD0WBk6575+bEChUwIrm8fjNY34u
         mI6NhHSv/qMkoHxCX2hjhpfKoOdatwDdP9wRw5u3MAsDoJrKrxw1tElII+OUERwirWRk
         Os/w==
X-Gm-Message-State: AC+VfDz0JkdfC25W4zFzBP5xsFBt4iERu17aCC/3k9GV0BjA3JCIzWkH
        AIVVnJG6RMxJYx4ARx7r2mOqF/6A5K6eqs7W8kM=
X-Google-Smtp-Source: ACHHUZ7UdiLC4rnfTkxMOF7/ZhQMiq1uYmbN5YwgI7hrar0YE46/OyCLVYfkIuxfx6+Qk0lURMeIMltf8pvgiOukpSM=
X-Received: by 2002:a2e:9f55:0:b0:2af:1262:e917 with SMTP id
 v21-20020a2e9f55000000b002af1262e917mr870505ljk.25.1685010180457; Thu, 25 May
 2023 03:23:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:515:b0:265:2782:6da1 with HTTP; Thu, 25 May 2023
 03:22:59 -0700 (PDT)
Reply-To: paulsonjessca399@gmail.com
From:   Jessica Paulson <drlizzyscott859@gmail.com>
Date:   Thu, 25 May 2023 10:22:59 +0000
Message-ID: <CALHUKKtUvbJv1qJ9VjfJp4_0Y6AA=rZmG8mSrXt9sE-RRRPJvQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

44GT44KT44Gr44Gh44Gv44CB56eB44Gv44Ki44Oh44Oq44Kr5Ye66Lqr44Gu44K444Kn44K344Kr
44Gn44GZ44CCIOOCouOCpOODh+OCouOCkuWFseacieOBl+OBn+OBhOOBp+OBmeOAgg0K
