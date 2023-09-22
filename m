Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D7C7AB936
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjIVSeO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 14:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjIVSeO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 14:34:14 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825C7AF;
        Fri, 22 Sep 2023 11:34:08 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d7ec71ad608so518120276.0;
        Fri, 22 Sep 2023 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695407647; x=1696012447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gKtn9+rFdpk3ajP5WBvOmlCpZp5eroyqsozE3t3DMsY=;
        b=OJQQzW4egoeQgwgj6Lj0npgMyhA1hD1GaLRo9ytUWgnSSgMtKlrgq8Vh/NtRYoi+Ta
         uVo5eyjFxRi59L11+Ltxovf61WJ9lfbbay337GE/U1CcdHzsW0RAelODdlu5jSkyHkmr
         MAno5WZ11h6eLQXF9AfOTyxqbhr3buDfRC44rie1uqMXfbrcKfglAQRIzXnYx54Gtfvf
         56H+0c15qIgTdUOg3Y614o+OhcnRhIc6CbdyUmi2q/L1KI1C0yCi52oKqMyZ7b42P4xZ
         gAUvP0W4FEVxZQuBMFVgYratG7An2i2pelQ2/a92OgxMVgI9T3ipU2VFnnAdqDFAJXUC
         AJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695407647; x=1696012447;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKtn9+rFdpk3ajP5WBvOmlCpZp5eroyqsozE3t3DMsY=;
        b=YfiZo5K4KKx7ak1+o79nHUg7MbPx+2zG96cCdgMig/n8JwYX1oqByeMT/eumCzotfx
         rb7ozMt9OIT2xepDF1/nMO1xLr3dYAKifnZT0vbpCAs8wpWFHlqRtZxJcUlUY2tt8/+x
         zJoHlknbHuHeWLEAQSQFMb3wm4GXL/SWHAm/ve+tgfM31+IF8vrL7g8QcjC+i2x4U3sS
         yluRKPTfzhj6Noq+BP3D8b8YN+o185OGhdgBOMCVyY80GdeeS4WilNO6sOh0bWAW7hgf
         eSigsMPp9WwmNPkeTaaA3vb7GVJmyCDdtwn638fFmspAa3OnOUIm4n6FwRpTR9pEPrKv
         Yahg==
X-Gm-Message-State: AOJu0YzzQce5hNBpNZcvic2MmGI8ESF3kUkitqFhSmajs0/0txXMuXLj
        duWrJecuvhDRrH8VCYluKLjO2644m8bUCIjKwkdACLaZe6k=
X-Google-Smtp-Source: AGHT+IHcCtoygHnTfPFy4wDc/Wm1ZfJeXGc6LBWIErZ07MdlDrPTRK0Df/bUbZMSm6r/ppd24nwv5Wup+3Jrj/CQWgQ=
X-Received: by 2002:a25:ac46:0:b0:d7a:bdfa:57b1 with SMTP id
 r6-20020a25ac46000000b00d7abdfa57b1mr91981ybd.2.1695407647359; Fri, 22 Sep
 2023 11:34:07 -0700 (PDT)
MIME-Version: 1.0
From:   Aleksandr Mezin <mezin.alexander@gmail.com>
Date:   Fri, 22 Sep 2023 21:33:56 +0300
Message-ID: <CADnvcfJn--J-51tjOVe2Z55Y8CxnXePXmP9V_j9HkVOt-RH4LA@mail.gmail.com>
Subject: hwmon: (nzxt-smart2) backport device ids to v6.1
To:     stable@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Please pick the following commits:

- e247510e1baad04e9b7b8ed7190dbb00989387b9 hwmon: (nzxt-smart2) Add device id
- 4a148e9b1ee04e608263fa9536a96214d5561220 hwmon: (nzxt-smart2) add
another USB ID

into v6.1 stable kernel. They add device ids for nzxt-smart2 hwmon
driver, and they don't require any other code changes. This will
synchronize the driver code with v6.3.
