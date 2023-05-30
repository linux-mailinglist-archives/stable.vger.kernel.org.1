Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B93E71584E
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 10:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjE3IWi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 04:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjE3IWW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 04:22:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52081187
        for <stable@vger.kernel.org>; Tue, 30 May 2023 01:22:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6094cb2d2so43213005e9.2
        for <stable@vger.kernel.org>; Tue, 30 May 2023 01:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685434935; x=1688026935;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2bdH5RxHWWWiPn0bvQ3AF7KrvtHQTTjAV/94K4dTh4=;
        b=qYNx+fcrpJp4mUihhZT3OJ1tJtnFCEO2XeJK37he25P0MLWUVdguppwafo4wT9mPdW
         ihhKRiMJp1K3SJtvqRzcQWwtkU0VCYMcGRPQCBMH0MRFv2rssoypAJ1Y0BUT+S/UM/aJ
         Ds9RBYTgrGD8ORXJTAG/0/Iy4K4KZM4jlrUbUiH2BS12sdun3WcLIWfKfNnrNEGljF+2
         8uQHqYg4ZmXuqOx3qddLVQPVqyo6csr3J1jRmMm4JiGsSmUZSs29fohF9qtt6N9FQcwM
         9UxGBizLTg1O59hw0qgNoBHZCXrR3BY/hhj/ZUYyJkGOZEBgy5Q1kg2oWxNWzcbkgrO0
         SSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434935; x=1688026935;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2bdH5RxHWWWiPn0bvQ3AF7KrvtHQTTjAV/94K4dTh4=;
        b=eXm/xFZ2oBfY2wx1804gpbaUUVbFo6LHlppi7mO2YcN5RceEYj+DXniMaC4few4FKi
         Zl292LEQfZDDlKZcMgagUDdQLOWLYwSEMkmaxNg8bOs1N7gWBUBOXE5ZI1zNkI/5Ap6J
         R8Awhc5kxqrtzxwsornFnC+A9qQXO6yk9enNMJessU/9Vo1SWan4HOXhQsoaOzC9fpqH
         L0cR+6IfEMvkhyLRnO5uS7Q4dRdloe2XH/NpsdCjvKEz5OMipogC8PbAgRFHW9e7y5u/
         2DpNWGVGWmBgzstzlohpQm/IawnnTPVkJYjZ2j5KAWQbni0/G5tk7NkkMvN4p754hGo7
         Ew7Q==
X-Gm-Message-State: AC+VfDxN3sb62PCLgCVonMWnuH8nEtWWz7bgTTVeHCW7aQXaMcviKZhD
        FXo5ejlgShCNwJ8+YqX01yyo9FaSBO4l2N2nYqs=
X-Google-Smtp-Source: ACHHUZ4wMSaHbPkjhQZtINzB8Lyxl+aXj4YgUr6kPVilCVoVH0N7w+3jsDHV/vqdydjwbxFAfouIgQ==
X-Received: by 2002:a05:600c:2304:b0:3f5:6e5:1688 with SMTP id 4-20020a05600c230400b003f506e51688mr964840wmo.2.1685434934868;
        Tue, 30 May 2023 01:22:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h8-20020a1ccc08000000b003f709a7e46bsm2617309wmb.46.2023.05.30.01.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:22:13 -0700 (PDT)
Date:   Tue, 30 May 2023 11:22:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: randconfig fixes for 5.10.y
Message-ID: <b59d1bfe-15b1-4318-a12f-a38143ba35bd@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

I did some randconfig testing on 5.10.y and the following patches are
required.

d7a7d721064c5 ("media: ti-vpe: cal: avoid FIELD_GET assertion")
42d95d1b3a9c6 ("drm/rcar: stop using 'imply' for dependencies")

The first patch is only required on 5.10.y.
The second "drm/rcar" commit is required in 5.15.y as well.

I'm going to be doing regular randconfig testing on stable so let me
know if you have any advice.

regards,
dan carpenter
