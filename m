Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6B7DCB7E
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjJaLLb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjJaLL3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:11:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BED10F6
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:10:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40859c464daso43333955e9.1
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698750656; x=1699355456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vNOi5JlhvmPgexOpe6e7sYP0SS0+wpx4espISANvQAc=;
        b=Wdf828L1ZHsZY87Psp9MHmrjc3zYsoU0s7FsjgRunXFRtYUSC3PdbYe+T55mJoDJKP
         24oAdxpGwtz79k+Kn7Id26+KMbpWryao7HVA1CvpgzAcSbrx1vPq0SG5myVepumcp1xQ
         FkGDi7jIklPv3BiZJllVwkVHINHECKiNWrQFz8A4f03nTl7MeOmFKWbGjOeP8eYCRgew
         0biFcj1gKuKp0vhg/ejwz0CvXXN6k3bp78IFUa/7YH3Y4WFTQp0dVAH6LW3NwkMD4Zgu
         LbKqwhVqQCi7yOHjpldWbBeNHyN9D7pMxv1Uz28rLt4Sfuh25mVbQbdS4aZFWoD8/ElP
         8iEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698750656; x=1699355456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNOi5JlhvmPgexOpe6e7sYP0SS0+wpx4espISANvQAc=;
        b=P/5YR+OPM355YkBzGraM0ge9KfnbhD04jeg6wTXbrHFPKBhs6ycrNYBKiEtOUrU97w
         5PxqC2xWLbzBAgrAkgNqiTGBep1uwpxKKWXBHOVZzBx+2SmTVysqi2OQiPPectAtssVj
         WlkN/ffN/9LOUn5K1xgTdlHMr1FdnX6DJW9kaNWmup9uE3Y4EW93to22alhd/VWmtRu6
         +yUy87Ign6gKAvWvPyP/AJPZBhkeH4UvJJ5Qk6qrRExs/ACLgjzFabG9Z/caB86G8rvy
         iQWuHDu2y+iBc0X9ByTay4cAGQimXFml3qT/BxmLtoLaI9X2JupJPl69+M0dgw9LFvGb
         toqg==
X-Gm-Message-State: AOJu0YzKScsZBbiy/JJc1i88RqOT29Xm6uLfncZ0NIHuv400vZIGtUYf
        mFEIQOZ40QR1N2IpoEWAI++EIDFyM9n/KA==
X-Google-Smtp-Source: AGHT+IHNNeTA9uOpkkwR/e9I56YV7XxF9ZDj1XX6IvDgbrAxYc4BeV1HpAnYAeKauIsESQ/t73fiRg==
X-Received: by 2002:a05:600c:4594:b0:405:3d04:5f52 with SMTP id r20-20020a05600c459400b004053d045f52mr9901035wmo.24.1698750656272;
        Tue, 31 Oct 2023 04:10:56 -0700 (PDT)
Received: from localhost ([2001:171b:c9bb:4130:c056:27ff:fec4:81cb])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d6412000000b00327cd5e5ac1sm1286557wru.1.2023.10.31.04.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 04:10:55 -0700 (PDT)
Received: from localhost (localhost [local])
        by localhost (OpenSMTPD) with ESMTPA id 425e5057;
        Tue, 31 Oct 2023 11:10:55 +0000 (UTC)
Date:   Tue, 31 Oct 2023 12:10:55 +0100
From:   David Lazar <dlazar@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.5.y] platform/x86: Add s2idle quirk for more Lenovo
 laptops
Message-ID: <ZUDgv5ZyhvyLh5JD@localhost>
References: <ZUAcTIClmzL2admd@localhost>
 <f10297db-3a65-4e61-8f59-3f029e69dbb0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f10297db-3a65-4e61-8f59-3f029e69dbb0@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 30 Oct 2023 16:30, Mario Limonciello wrote:
> In this case are there modifications or is a clean cherry-pick?  If it's not
> a clean cherry pick, why?

This wasn't a clean cherry pick because the code has been moved
from  drivers/platform/x86/amd/pmc-quirks.c      in 6.5.y
to    drivers/platform/x86/amd/pmc/pmc-quirks.c  in 6.6.y.


> If it's just missing another system in the quirk list it's cleaner to
> backport that missing system and then have a clean pick.

In this case (the 6.5 patch) there was no missing system in the quirks
list.  However, in the 6.1 version, the HP system *is* missing from
the list (it looks like the patch that added that system wasn't
backported to 6.1).  But even adding that system wouldn't result in a
clean cherry pick, given that the code had been moved once before
from  drivers/platform/x86/thinkpad_acpi.c   in 6.1.y
to    drivers/platform/x86/amd/pmc-quirks.c  in 6.5.y.

I had refrained from adding the missing system also in order to stay
close to the upstream patch.

In any case, I see Sasha and Greg are already working on these patches,
so I'll leave them alone for now, to not generate more work for them.

Thanks for your help, everyone, and please let me know if there's
anything else I should do.

-=[david]=-
