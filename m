Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF270814B
	for <lists+stable@lfdr.de>; Thu, 18 May 2023 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjERMay (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 18 May 2023 08:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjERMax (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 18 May 2023 08:30:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32B210D0
        for <stable@vger.kernel.org>; Thu, 18 May 2023 05:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D12460B68
        for <stable@vger.kernel.org>; Thu, 18 May 2023 12:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE368C433EF
        for <stable@vger.kernel.org>; Thu, 18 May 2023 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684413051;
        bh=wFZGbq7OkH+mhGViOztT6o8lTQjaAM8KNRmbuUhl7wI=;
        h=From:Date:Subject:To:From;
        b=Tn+Rv++h6FGHdMYzTYjEpCF/4Ym7tmU7AN9jBMKyN3gjvDZWbOKh6lq1m/Vm0DIAG
         IX1Vlgvz27mwRnQmOsg0g2mxzZeYE0Zg3iIuNaMu7pM0qfXuWZShiQGX4YaJm0PRHV
         R9U5loLxZJ13xV8XfIcjqYNUHaD2O5KH4FseWXpk99gbO8TaxTVLgztjLOPVA9Wepc
         YQ8+DY85Zns8lPT5qga3vBwMudW+CHBLSTCbBal27VVf+7rlc+g1a3FqfOgmCBepA2
         VNYNO51xvmCaqate3jRsTsdfSBD2L7UxLHQx4TGwZ1P0YSicx0wGkwg/5+RG9t/oyB
         IzOWzuaJcMGnw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ac78bb48eeso20589671fa.1
        for <stable@vger.kernel.org>; Thu, 18 May 2023 05:30:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDz1hONpy+oW+rb+Pksc90Op2PPZMdQmpflhEziFC0DyAhahYGP3
        A3LbXQDpWUpAZed5UtgtiuBIzIxP+Uhh4T9+hSo=
X-Google-Smtp-Source: ACHHUZ5bv7jHu/XQdM5kShG/qKGoUeUlY7fHSV7fai331DqSskYaHigDbwH+TJPeuXeN5LPjJyE2vCUt+GPRvvDnt/8=
X-Received: by 2002:a2e:9c8c:0:b0:2a8:c42f:6913 with SMTP id
 x12-20020a2e9c8c000000b002a8c42f6913mr11204267lji.36.1684413049863; Thu, 18
 May 2023 05:30:49 -0700 (PDT)
MIME-Version: 1.0
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 18 May 2023 14:30:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEJSzkEMuHvzuS1y9SJ=HaAi7z=LgB_0vJHr8H8EeQUVg@mail.gmail.com>
Message-ID: <CAMj1kXEJSzkEMuHvzuS1y9SJ=HaAi7z=LgB_0vJHr8H8EeQUVg@mail.gmail.com>
Subject: v6.3 backport request
To:     "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Please backport

c76c6c4ecbec0deb ARM: 9294/2: vfp: Fix broken softirq handling with
instrumentation enabled
2b951b0efbaa6c80 ARM: 9297/1: vfp: avoid unbalanced stack on 'success'
return path

to v6.3.

Thanks,
Ard.
