Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC957937D3
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 11:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjIFJOe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 05:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbjIFJOe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 05:14:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9B81AB;
        Wed,  6 Sep 2023 02:14:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c1d03e124so482822966b.2;
        Wed, 06 Sep 2023 02:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693991666; x=1694596466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H/i9Rx6cJePLlrXqQQE3rJ8pHiKqveK77lqYog72tc4=;
        b=VUsH8kdpgDGA58taeHDc9QrB+SJh2NhOV16uTZ1P5zHlLg0y92x9V4LHv3MPoIP4Hz
         O+5RpxNmTiUOHNTUWEQETE5cLAPqievlcbXL17DbrZqIvL0F8hwyChZ32gxY9XNEAZ3i
         Q59F6VcoIVqDzXK42o/NyoeHrSS6Cih2M5OZOAaGJYFWZnl5n4b1YieM+Z3JsCnx7ul+
         sj+wMapYlQJ7HZNoEd5YhV/JyED53slKr5WFzxUMKdco+jgeeAgRGEAZFNW31lhlYWRg
         zz45/NPNP6043iYrzZhbWytbnbJjAJ496cXFHoKhUDBababs0cP8x+8G+OKxKPshqLK+
         y/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693991666; x=1694596466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/i9Rx6cJePLlrXqQQE3rJ8pHiKqveK77lqYog72tc4=;
        b=XdNCNaltqwC8V60v8B7Ohqi9h4gVJGjvgH7VQvCJRoZFWKjmFy/LXdiQD6j5F8hISS
         fvbN/6XURszmvQNff0XkeQBgIU44KX66x5lA+M9pyVJvzOlJH7duZ8cWfADGfIQvVad6
         3rLbLwKgkM7/Fa7ViF8chSul/1dsvwBw9IrWpsdbjW/BHBDrWxrPbS4y2tQR0kx+6Qpe
         4fOsfoWJUTRwSxtNNwQU3OKyEP1ZBwkwWkCbTaIBhkYa3j7A4IBbNwEDMer9tEo5XdVm
         iwtfGMeQ4EN64FeDGyVE4V2nCGw9yTh5CHWaV+sOQif2Q04O5nOE4BuMuL+0WDQ46aIV
         TWOA==
X-Gm-Message-State: AOJu0YytzHlIqdy+Cf1avWRjRqhvAjC8o8WXZ8ylYiYcsVivi/wYx/D3
        6QuUGP13XRiURS8QbKIL9/ixYysVvjSMSyYEmMPcBjOH7aI=
X-Google-Smtp-Source: AGHT+IHoJKKd/cmbZPfgEY/YExtF4EVPHtK38KTRdm0zAE4+KN5GgQiRXE7NO6CnE5tz1JCfDh147sB1Cs1cmmCMzeY=
X-Received: by 2002:a17:907:d1c:b0:9a1:e58d:73b8 with SMTP id
 gn28-20020a1709070d1c00b009a1e58d73b8mr2147910ejc.72.1693991665979; Wed, 06
 Sep 2023 02:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230905073724.52272-1-fabio.porcedda@gmail.com>
In-Reply-To: <20230905073724.52272-1-fabio.porcedda@gmail.com>
From:   Daniele Palmas <dnlplm@gmail.com>
Date:   Wed, 6 Sep 2023 11:02:22 +0200
Message-ID: <CAGRyCJEzKn13gbBYfoF9H5XKJ_OSXJh0+h3U6SMa6c5S6kAVtQ@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: option: add Telit LE910C4-WWX 0x1035 composition
To:     Fabio Porcedda <fabio.porcedda@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Il giorno mar 5 set 2023 alle ore 09:37 Fabio Porcedda
<fabio.porcedda@gmail.com> ha scritto:
>
> Add support for the following Telit LE910C4-WWX composition:
>
> 0x1035: TTY, TTY, ECM
>
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Daniele Palmas <dnlplm@gmail.com>
