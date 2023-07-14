Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CFF753221
	for <lists+stable@lfdr.de>; Fri, 14 Jul 2023 08:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjGNGjd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 02:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjGNGj3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 02:39:29 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8102D68
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 23:39:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b703c900e3so23285161fa.1
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 23:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689316762; x=1691908762;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl1mgJBvD1dRtLRtZXjvAUQQ/WlYEUC3Y2oJLE2/HFY=;
        b=BLiJdnQmlB4yVCiJBnFJclWebwbbqhpTBT1coNY8j27fRsT6LbxVOVJqZ/xKW4t1s3
         2vCAyX0LDNbfkVUwSZ4mr/TUFFKlK/dcNSznxtwsRJYZcisEFmpeT0iMXjV+03nb0/eY
         Nwf26TpYiwPn0J+bXJU7pnyChVowy9kQVhmhH215StYGgl24AzgTKluURHIuso9rrpZ5
         zquYXm7yhJq545LTgIzRMYWA+lt1PgMBR2VK69rMdHWA91bcZ2+brrvP3jM2dnwwcPwW
         ajhir6wYowAqiPmpdWQsWK99k02a9TErXUCMyxza2jfjlp3sJwWiA2LixFa99AD31FSP
         hOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689316762; x=1691908762;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nl1mgJBvD1dRtLRtZXjvAUQQ/WlYEUC3Y2oJLE2/HFY=;
        b=AtWX0ircIJyfmjxhWkRyCMOuSfAzFB4aijh+LZqNzMGz3AKYvmo9Xa0V+zknw2XGJS
         L8rELslixwPd5vYKEO8YovAKa0qbBvat0TwWc+igXQXCEny5IwQTe2qobdx6hDBfG7sb
         dDQhkQDMdZrslMvm/6DjnAjvU2NA/mOt9H8QBTFG3mP2AtO/1bnVvL+2hcARCamCnkMk
         y6k8cq5Y6jroz7z8slop9LWmMppnCusXeET/QPi6/kqbVtf6xCFsvx55pmmVT8vFm2Fw
         0mNmHKl4ylUVAQrHKLrcUG9V2ufsDcF1cj0oj3a9i4ViEP2ojX31XxW+GJS4TQs76nNY
         sNnA==
X-Gm-Message-State: ABy/qLYfNeeriumv4CucQevDdFdLZS3b+bRlzM8/nX6uOEQnbZQQRMOf
        z5/XZEDbbdKqWOJS5pQL3KpQ0tusklSI7h5W70chU51SPSyNvg==
X-Google-Smtp-Source: APBJJlHKc+xlWpaOO5BPXcNSh9rnSak3zkDENuyO0KC6kC57dvhGfIj0mbas8Hq/QXIdBf52dF1QT3EKoAkiWtZ4AUs=
X-Received: by 2002:a2e:874d:0:b0:2b6:9f1e:12bf with SMTP id
 q13-20020a2e874d000000b002b69f1e12bfmr3476274ljj.1.1689316762205; Thu, 13 Jul
 2023 23:39:22 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Fri, 14 Jul 2023 08:39:11 +0200
Message-ID: <CACna6rw7xEUEOgsXTC2GJmmG56kpTN07nnRJDDnNHAi7-9cabA@mail.gmail.com>
Subject: linux-6.1.y: request for picking 085679b15b5a ("mtd: parsers: refer
 to ARCH_BCMBCA instead of ARCH_BCM4908")
To:     Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

In linux-6.1.y we don't have ARCH_BCM4908 symbol anymore (see commit
dd5c672d7ca9 ("arm64: bcmbca: Merge ARCH_BCM4908 to ARCH_BCMBCA") but
drivers/mtd/parsers/Kconfig still references it.

Please kindly cherry-pick a fix for that: commit 085679b15b5a ("mtd:
parsers: refer to ARCH_BCMBCA instead of ARCH_BCM4908") - it's part of
v6.2.

--=20
Rafa=C5=82
