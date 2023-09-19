Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75ED7A5C02
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 10:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjISIKU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 04:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjISIKT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 04:10:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574A7102
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 01:10:13 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c434c33ec0so28480745ad.3
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 01:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20230601.gappssmtp.com; s=20230601; t=1695111013; x=1695715813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDaVHG8otiJPEb7VvRQaEf7e+HpyXbPyMYQtyJhoTbE=;
        b=BqkDDc4hcdGymnRWmUOU0a2m1HV3yBwcwzzJN2GbUzGxMnMlDm44GSOTaMkJZdhrcg
         1M/dYgPpdz6hEsH1ydJqpDiZ4Madx5sOV99S2/TOpnyjDt2kN2yx8/XgC/UIosGJwTaU
         jDDLaaZaYB97IY2ANzd3EyxDLElBfBumlJ4UNz22mk/4TMTf9jIn56gVxCIwcCvurzIc
         bbpq/UL+wYPBx5Hcxu+suuSpr7Dqu05dF5uTtL0XWV7ifG4iAYypkbHhn5E1m0+y1f3F
         okDUw2Hcsn+PFmIihn4qpR7pspsqUIpKyPuTd2e3iGn3ECF85/Gj29ERKIHdm/tl24z8
         Ixsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695111013; x=1695715813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDaVHG8otiJPEb7VvRQaEf7e+HpyXbPyMYQtyJhoTbE=;
        b=K5xnTgCbuGzgcBlGl0JAIr3Ave8Zl3SmZPY0Scbdj9I+Ncqve6iOEpmE7Y+a2xDrAd
         dwex4zFPAdZxvOsUFoIt2NvDrilXlOdZqjiSFTw2Z02DUJjX3He6CqDEkKgzVZEwl2Xw
         hM0xMHnKhThu63GmCNhL5yWywwud+PqGbhV8lXGfs1jkVId33fODoh9usA6la3SGKGfl
         3rHe/DALyjLAe+NBg8zb0wVOQAOxX5ZRDRd9TwmdzEvm9uS6CYm+FerTJVaS7z9fd3wb
         4O5gVvhOGs2N/uc3hfz5Ve3zySbiJ6t2HtHKYnSdUE3+CD6R1Bd76ZbyILcF6iY1F6d1
         WG8g==
X-Gm-Message-State: AOJu0Yz59uB9T6H52/MJKY1MM9MNWkv4+SgtCV1tg+lcolWvgDlPgeLc
        hEaIZy+QOKlOSJ317HhGRZdFGQ==
X-Google-Smtp-Source: AGHT+IGVJowM4/9XEQHW4+PaTqlhWRPWK+4eWaInB4DrrZBm59Vtc7nXUAWRCf4YZwM6CZm0oVKf5g==
X-Received: by 2002:a17:902:d485:b0:1c3:9764:764f with SMTP id c5-20020a170902d48500b001c39764764fmr10700562plg.48.1695111012747;
        Tue, 19 Sep 2023 01:10:12 -0700 (PDT)
Received: from localhost ([172.103.222.8])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902b48a00b001bdc8a5e96csm9491983plr.169.2023.09.19.01.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:10:12 -0700 (PDT)
From:   Jade Lovelace <lists@jade.fyi>
To:     ricky_wu@realtek.com
Cc:     paul.grandperrin@gmail.com, regressions@lists.linux.dev,
        rogerable@realtek.com, stable@vger.kernel.org,
        wei_wang@realsil.com.cn
Subject: RE: Regression since 6.1.46 (commit 8ee39ec): rtsx_pci from drivers/misc/cardreader breaks NVME power state, preventing system boot
Date:   Tue, 19 Sep 2023 01:04:49 -0700
Message-ID: <20230919080447.2594902-3-lists@jade.fyi>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <c7bdd821686e496eb31e4298050dfb72@realtek.com>
References: <c7bdd821686e496eb31e4298050dfb72@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,=0D
=0D
> In the past if the BIOS(config space) not set L1-substate our driver will=
 keep drive low CLKREQ# when HOST want to enter power saving state that mak=
e whole system not enter the power saving state.=0D
> But this patch we release the CLKREQ# to HOST, make whole system can ente=
r power saving state success when the HOST want to enter the power saving s=
tate, but I don't  know why this system can not wake out success from power=
 saving state"=0D
> =0D
> This is a PCIE CLKREQ# design problem on those platform, the pcie spec al=
low device release the CLKREQ# to HOST, this patch only do this....=0D
=0D
I spent some time debugging today but I am not a PCIe expert. I think=0D
that the card reader is actually violating the PCIe spec by not forcing=0D
CLKREQ# low on systems that don't support ASPM, as appears to be done=0D
(accidentally?) by the regressing driver change.=0D
=0D
The kernel logs on the affected system states the following:=0D
[    0.142326] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it=0D
=0D
The PCIe 3.0 spec states (in the description of the Link Control=0D
Register), regarding enabling clock power management:=0D
> Enable Clock Power Management =E2=80=93 Applicable only for Upstream Port=
s and with form factors that support a =E2=80=9CClock Request=E2=80=9D (CLK=
REQ#) mechanism, this bit operates as follows: =0D
> 0b Clock power management is disabled and device must hold CLKREQ# signal=
 low. =0D
> 1b When this bit is Set, the device is permitted to use CLKREQ# signal to=
 power manage Link clock=0D
> according to protocol defined in appropriate form factor specification.=0D
=0D
My reading of this is that on this system which does not support ASPM=0D
and therefore also does not support clock PM, the driver must have the=0D
device hold the line low, but I may be wrong.=0D
=0D
It's still unclear to me based on studying the schematic of the laptop=0D
and the PCH datasheet why the one PCIe port is able to break the other=0D
one like it does. The CLKREQ# lines are simply connected directly to the=0D
SRCCLKREQ# lines of the PCH, plus a 10k pull-up to 3v3, which seems=0D
entirely reasonable; any breakage surely would be some software/firmware le=
vel=0D
misconfiguration.=0D
=0D
Jade=0D
