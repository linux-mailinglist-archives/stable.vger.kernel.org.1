Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2458073DB2E
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 11:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFZJVK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 05:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjFZJUr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 05:20:47 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C056EE6
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 02:18:12 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40152377912so2130161cf.1
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 02:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687771092; x=1690363092;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ba3gj8+xBPQLJTahTfzW6RbWQ/XPgESxkCi2B66PSQg=;
        b=lDmh8cuPRhIceYnvDfpTDapZOBjlOGPQl3nWb1RFlcYWCZAU4y2ucaKqvMba1krzDx
         Hu65GtkEvcHH38FANOMuNFe4LXubScyej8GF+bv4DNmmAaTK2510PHZP0ksHbHEJav4I
         SF5XjeAEr4mE0OOW3mq+ETfCuBzE+Leaq4b2RbCCICO5dkuTcG5mTNiFIsnUKJtTwVpr
         lw3Dql3R3CU0JxgWvjfhMDx6G2KZ5SpAiiN3hrFY6cJDgiL/xLlWNTKYz8FEIu+ZEEbx
         WOWzv7U5n9/pAe++w1oofnxCy6LhbzlM8QdAm0cAGUAqcOcMOSJE5PjlGocShYWZTX1f
         HG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687771092; x=1690363092;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba3gj8+xBPQLJTahTfzW6RbWQ/XPgESxkCi2B66PSQg=;
        b=ICS4paE2zsZ9UtcgnUYVEpq0YJfK5YzYwcZNcmCMsyE0fe1ey0kvzbTsZc2cav1Es8
         mEY+Y8YXV+YBjhWUA9BkwRBSjJY5nRhoHUhEurckXkUy3WBUQxhOXlGOWZtlGOCjRWHO
         mpxRWcu/ZOriQFLjFEdnWES6iftmvJu4a0pRaFH1iQFt5oY8gOA5TggUCO46ZQOTGeG3
         XHZxOfDZate7mRQfNuoJXRP4XmpoLEE1CaVKLfRdsoZRRKE0NO4fMsFM9rv+BCBln51/
         NE1d89UL6pKCDcyfW7cI0QTf+IfAw282B8XYwQu2wnkBqh/RI0K02+0Y9jcyV6zapBNz
         E80g==
X-Gm-Message-State: AC+VfDxT3oaEqjupiETxdR9bqBbFLS+gBPdtMtSgJeZXfE2H7Yjomnj4
        mjw7//QPwv7vIfzvr3mH47ssQeNCvJ0glatFU4w=
X-Google-Smtp-Source: ACHHUZ7VvG+VH5TSBrauvIyEZCkX8uHPLffZbTjz1ijLwG0eE39LReA4g2CievpZKd+Z4xc/JUNBq7u19F2XsePogvU=
X-Received: by 2002:a05:6214:f29:b0:623:883a:3137 with SMTP id
 iw9-20020a0562140f2900b00623883a3137mr35510899qvb.51.1687771091814; Mon, 26
 Jun 2023 02:18:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:9381:b0:4e1:c1e7:9a3c with HTTP; Mon, 26 Jun 2023
 02:18:11 -0700 (PDT)
Reply-To: helenwilson142@gmail.com
From:   Helen Wilson <dlisa1780@gmail.com>
Date:   Mon, 26 Jun 2023 09:18:11 +0000
Message-ID: <CAHGCEsvfvrsmDePJs-ZrbR+J-r0b+rbciZ2LHAbn4LctFToT3g@mail.gmail.com>
Subject: 
To:     info@adriaservis.hr
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello
