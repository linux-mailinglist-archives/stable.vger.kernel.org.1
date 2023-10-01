Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C917B4574
	for <lists+stable@lfdr.de>; Sun,  1 Oct 2023 07:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjJAFsJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 1 Oct 2023 01:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjJAFsI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 1 Oct 2023 01:48:08 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C865FD8
        for <stable@vger.kernel.org>; Sat, 30 Sep 2023 22:48:05 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d7f0a60a159so17015428276.0
        for <stable@vger.kernel.org>; Sat, 30 Sep 2023 22:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696139285; x=1696744085; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+1fmPe6WMvk3im7q7AOd7CniGXDE59np7BKG5YTRWzY=;
        b=BcFU32nsfFoSBgccjMjDz7YmvFr1+k/d0McjANV5iiqgaug4W/z5WDW5M1XnadHxKw
         73SI+xJq//fyg0nKSQVDysGxMOqczIUSIg1lOFVucenKEuJ0gC1OwicTUk1/g/aXO8U3
         lKYDBuhoqSiGuOC7ZGO2oBCxWIL6u9UKmLGQIzSvtJSBoN1Vrsn4yMh22nQZEo0ca70s
         0SiyyRLEsG8d5KD2TurU9SwobR48wUeapc9jtMI9e+qv2O2QqjSzMCUF8QJ/Avz18Wg7
         lT4SOeh12EQJN1p6F76bGW1Hg64V3JBBY8KN3oEj000P6NmOSIHJLhiHopY95ktb8QUC
         iaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696139285; x=1696744085;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1fmPe6WMvk3im7q7AOd7CniGXDE59np7BKG5YTRWzY=;
        b=LmczJGwkq5JzNB0OaNFAl7AdNs4nT7xecwq94pEvwyT5voIFCaZbwOh5IXCuhE6Nsn
         GoWzP78ZzDKob8FEYCgL0TiGcuibpuAAw+BtpDxrWEGj+hKqtb5vY6Cb7xphOjo+B0/6
         l8YcbrZtanhl/2GuM71iDKsVFDotht7Sv81dlPgnU8i+71AZSyYv/VLGipv51fX7GQ+w
         wCtVOMQX8rxK/js/0GEzKO5qeXEBP81CQQeOuaz7lYmncLYLFakKML34bXM3R/+yRnoW
         rpub0K+ZEBxXx9VS22fUeSrpQwjjNHScupOGuoHu+KZSDpGAiBzyYiTc8EDBcDlxdNej
         s/NQ==
X-Gm-Message-State: AOJu0Yy79/q9vPR627BXAzoB2GIsUlnYda33GX/Jfdvnh7MApDY04w/V
        N4z+zMuiGtZ3LuCrn4dHWeD1srSJMvQwVF3+qfLyRdU5vEk=
X-Google-Smtp-Source: AGHT+IHraowkFc6hku+Kg7tM4N5Ez2BpI0V9WoKKnESAX8eM7M/HGUoqMBgaxgbh2iorEr0zXqXUfucmd69uJdrEz1Q=
X-Received: by 2002:a25:db02:0:b0:d85:d280:cafb with SMTP id
 g2-20020a25db02000000b00d85d280cafbmr7485261ybf.56.1696139284960; Sat, 30 Sep
 2023 22:48:04 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Erik_Dob=C3=A1k?= <erik.dobak@gmail.com>
Date:   Sun, 1 Oct 2023 07:47:54 +0200
Message-ID: <CAH7-e5sb+kT_LRb1_y-c5JaFN0=KrrRT97otUPKzTCgzGsVdrQ@mail.gmail.com>
Subject: bluetooth issues since kernel 6.4 - not discovering other bt devices
 - /linux/drivers/bluetooth/btusb.c
To:     stable@vger.kernel.org
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

Hello!

I bought a new laptop fujitsu life book and everything is going fine
on artix just the bt makes trouble:

/var/log/error.log
Sep 30 18:43:48 nexus bluetoothd[2266]:
src/adapter.c:reset_adv_monitors_complete() Failed to reset Adv
Monitors: Failed (0x03)
Sep 30 18:43:48 nexus bluetoothd[2266]: Failed to clear UUIDs: Failed (0x03)
Sep 30 18:43:48 nexus bluetoothd[2266]: Failed to add UUID: Failed (0x03)
Sep 30 18:43:48 nexus bluetoothd[2266]: Failed to add UUID: Failed (0x03)

i searched a bit the webs and found a new commit at kernel org that
does do the trouble:
https://bugs.archlinux.org/task/78980

follow the linkeys inside the commits there or read this one:

---------------before------------------------------------
/* interface numbers are hardcoded in the spec */
        if (intf->cur_altsetting->desc.bInterfaceNumber != 0) {
                if (!(id->driver_info & BTUSB_IFNUM_2))
                        return -ENODEV;
                if (intf->cur_altsetting->desc.bInterfaceNumber != 2)
                        return -ENODEV;
        }
-----------after----------------------------------------------------
if ((id->driver_info & BTUSB_IFNUM_2) &&
    (intf->cur_altsetting->desc.bInterfaceNumber != 0) &&
    (intf->cur_altsetting->desc.bInterfaceNumber != 2))
return -ENODEV;
--------------------------------------------------------

the dude just hooked up 3 conditions in a row with && where before it
was 2 conditions in 1 condition. + the comment was removed.


please reconsider this commit.

Yours

E
