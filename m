Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35D07DF494
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 15:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376719AbjKBOGv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376748AbjKBOGu (ORCPT
        <rfc822;Stable@vger.kernel.org>); Thu, 2 Nov 2023 10:06:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B68313A
        for <Stable@vger.kernel.org>; Thu,  2 Nov 2023 07:06:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so971061a91.3
        for <Stable@vger.kernel.org>; Thu, 02 Nov 2023 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698934005; x=1699538805; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JNLytVSJlr1D0ot2ygWKsJu12BdCJtoL17C9W5FT6eY=;
        b=j3mMtyhH/CiFK19YiPD7DLvi2MYguM3OJ/o0zjk4N+6SF8wReJLHXTknvGeLOFXSxS
         XPk/6nZCqDT7pHC+PGWZAs2jYP9eBTBBoJ29185GQ7NptnePyrmi9qe0Z+0VfQnjDk1r
         oaMG1MkHWdKEB1/4r9dnscqfM+0XgJ6himdnPJkSMsFpfAcXrB5DITzAPZg0kqOKapNu
         +sSMIPXegvAY4AMwIBvlxLTsX1hFg6HWOON6Wq9Jjd2jrJhZOtHbaCyvSLeBkCZh2gnx
         sgWuTsIoLcZFt+gR+Q4IEdNetEBqjqycZnOSs1KXR7PxdxQ/Ry0PG5lSAFfsNwPhvlK/
         wlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934005; x=1699538805;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNLytVSJlr1D0ot2ygWKsJu12BdCJtoL17C9W5FT6eY=;
        b=I15KFCAVVF12P7ELzXw8UM7skSXAdhO3BNBk1Q6EDUh2UdGY9O7IIV2ay/N/afzla2
         OPZiEPeJhOS0ruv7fIMBZhEU/SSafIQ0wldrffYM806XvZ/uhmPXAzepsZwPjlTaJIKW
         I0cliDMMrVKF2nbmEdRVCBk64rRQhlXnL7D5LZ8xLnqEWMrlrTMED//6IB2lM17q5xTb
         72G5Ih3mBRmctXa35GV7DQyZZiJ5YOjqsKBK94AjvNWH2ZGwojSZusHMYKFsMJ0tCbCd
         Hw4gVxy3tmWFk9CoP9295eeFz0pPbFV4IowWYj11M0xdl4Xc2KiMGysWYThvbieRjWbJ
         dbbg==
X-Gm-Message-State: AOJu0YwtujLFBuPmMyfhI6xs94jGN7RFgHUj1eLZHGodVOcha9YfRojy
        z31BVSDUq3R2yw9BQPmGA5Ot+9ADxLGhD3BvypE=
X-Google-Smtp-Source: AGHT+IF+sUr0KtQDK6xtJAKDIxNQeE7UufGnzcbkyy3S+cLw4aQGa5lTDrROMEP3WtB8JidQ4BjAlpgKTY9vkSrMLvA=
X-Received: by 2002:a17:90a:f2d4:b0:27c:f845:3e3f with SMTP id
 gt20-20020a17090af2d400b0027cf8453e3fmr18304005pjb.1.1698934004450; Thu, 02
 Nov 2023 07:06:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:d45:b0:68:63da:b8e1 with HTTP; Thu, 2 Nov 2023
 07:06:43 -0700 (PDT)
Reply-To: oj616414@gmail.com
From:   johnson pattaego <lenle.goungbiamam@gmail.com>
Date:   Thu, 2 Nov 2023 14:06:43 +0000
Message-ID: <CAL454wBVS5iMsiW3Y756V2GMP=62spQr5Q+Ckp7QwssfOND5Yw@mail.gmail.com>
Subject: Re///
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

=C3=9Cdv=C3=B6zl=C3=B6m, van egy v=C3=A1llalkoz=C3=A1som, amelyre =C3=BAgy =
hivatkoztam r=C3=A1d, mint
neked   ugyanaz a vezet=C3=A9kn=C3=A9v, mint a n=C3=A9hai =C3=BCgyfelem, de=
 a r=C3=A9szletek az
al=C3=A1bbiak lesznek =C3=A9rtes=C3=ADtj=C3=BCk =C3=96nt, amikor meger=C5=
=91s=C3=ADti ennek az e-mailnek
a k=C3=A9zhezv=C3=A9tel=C3=A9t. =C3=9Cdv=C3=B6zlettel
