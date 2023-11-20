Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12457F18A9
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 17:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjKTQcy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Mon, 20 Nov 2023 11:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKTQcx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 11:32:53 -0500
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C65B92;
        Mon, 20 Nov 2023 08:32:50 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6cba45eeaf6so280354b3a.1;
        Mon, 20 Nov 2023 08:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700497970; x=1701102770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzvBTPYKPNLAAYJofhHBHs2zDNnqaax2JRpt9QsB7iM=;
        b=bJX2IgX1np0Q8nTF8Ot46C5leG3f+Y84L9hcCkxSS+JN619L7hiILk7gNYl53OX7ma
         sx4buvE7NgutxXTecCSMNA8Y4lPchuIV5J8dhnEsPr8llkIooXZYSxZWeE3XiMdCeMDX
         wde4VtWzz1+ZWftBBJOTuW30h+l25A58i0WIBZAxlIV9Sewmks/HKDZ0TQPgFnoJYRgI
         MoZTtzzKgYKzVXok/AQsLgTp7Nkd+acgrka3rFGSGRin5vNTKC0zjnRuLJ789s+UDU4Q
         9+xT/dG0Ra8h5pYXNJEqL7cg0Tyr5yJmLOx6lLT34MmHYKpCzoGqyxP6latvQTn0IqQE
         E0xw==
X-Gm-Message-State: AOJu0YxLyjRz9uiXbaNhT/osgwG0FCb0Rqisp4cIv1ixzDiUnLTtxY1z
        hNJjEX1+xf2lOTw9PB+YXLcTKID+Y8D+lfBptBk=
X-Google-Smtp-Source: AGHT+IG2GolmAdfAAuerHd0wALYMQdXf2/E3bw0YDO4MyZrjW1wcH0BbupD91hhw+nZdxBAYZ+YEzNE4jRh1rw7GIz0=
X-Received: by 2002:aa7:93b0:0:b0:6cb:8347:c8b1 with SMTP id
 x16-20020aa793b0000000b006cb8347c8b1mr5083391pff.1.1700497969892; Mon, 20 Nov
 2023 08:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20231112203627.34059-1-hdegoede@redhat.com>
In-Reply-To: <20231112203627.34059-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Nov 2023 17:32:37 +0100
Message-ID: <CAJZ5v0g6AHiGCB4vNLAXvH4TJRxMYpnD8LyNNnX0qEaTqr9o+Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: video: Use acpi_device_fix_up_power_children()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Owen T . Heisler" <writer@owenh.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Hans,

On Sun, Nov 12, 2023 at 9:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> This series fixes a regression reported in 6.6:
>
> https://lore.kernel.org/regressions/9f36fb06-64c4-4264-aaeb-4e1289e764c4@owenh.net/
> https://gitlab.freedesktop.org/drm/nouveau/-/issues/273
> https://bugzilla.kernel.org/show_bug.cgi?id=218124
>
> The reporter has confirmed that this series fixes things and
> Kai-Heng has confirmed that backlight control still works on
> the HP ZBook Fury 16 G10 for which the original
> acpi_device_fix_up_power_extended() call this replaces was added.
>
> Assuming you agree with this series, can you get it on its way
> to Linus so that it can be backported to 6.6 please ?

Both patches applied as 6.7-rc material, thanks!
