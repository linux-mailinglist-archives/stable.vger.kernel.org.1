Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A71C705B50
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 01:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjEPXZM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 19:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjEPXZL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 19:25:11 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748BE4C1A
        for <stable@vger.kernel.org>; Tue, 16 May 2023 16:25:09 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3357ea1681fso55135ab.1
        for <stable@vger.kernel.org>; Tue, 16 May 2023 16:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684279508; x=1686871508;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXxE6USYVk6uXnYi37bxfqx1RAttAHyWpYayRJo5350=;
        b=dxwgue4WbLtAlCu1yp9mKlyHfOxrnv72OmgpER1CVn2p0DvRzJ0HblxhEMPzcvKR6X
         zfSJA22zyxmQfIrQqsOLpeLyQ3qIYfAX83+GkIjiHTVP+um3OGHFqboqiVmsYi1/YCJI
         raeDDmFp6IcpabE3hU64AdJKElOuJZcKcfgxrT6eDDXleLj8Xbsc+u496Sx3FEf+LwL7
         cCgGAsPSEP9YRDaWsK830isCQbl2pBR5G5NJcnlPfIiCiFoLPJhljCDQvbio+UejOMEZ
         Nas/+wPcW7ahyb+9fCD3S55yJe9DKXRo1w8ImG0ugYa/6f2+eKvo68GVrl8op4KEdWVx
         ceyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684279508; x=1686871508;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXxE6USYVk6uXnYi37bxfqx1RAttAHyWpYayRJo5350=;
        b=X5anMQhcJZ3OhF68R4VCYiKkXeqHvoYPYjOQb5UKUAamRmHzfwIgkOBbueJ/VUgkZf
         UmQZK16lnRKiEYceLDmFcGNNQgtjk2GSOFDeXYUnrO6XPJzcO23i+ooGyxoIl2dljWSP
         mlKBea4eP4zJ0QDMDgYbZQFLXreiuU6yV4ZHzA8XcAaEbc4AL+xDUCiSGeJe7HzzWSSS
         +NpPOyYUWfdg56jaM3VB0NqylSa5JUAhPub5+NeN8wRFyUgm5KkD3KTEkMYigDJ1XrcD
         ArhE9rzBWL2PKXoO6bX71pzVDGfgKZGgeB7X+QLDKRVgn0wT0Iipc96ADPz32UNgSVYl
         2rWg==
X-Gm-Message-State: AC+VfDyMuXbNYZYU4NjyxRd+OWC28AwyCZFmTPA30hhQk8dNrpmdZ7L9
        O54YbvdGSle1VcHtQe/uEWmtDNqXw2O9drow9GmZGZjE
X-Google-Smtp-Source: ACHHUZ6h/bUggdjFClThBQrBCPwluMwvs+P5Ht1M6Uk1Y4VQo76YIu5YdyBgaCXHbFfjWEzAf8i5UYvrna/nbMwRGTA=
X-Received: by 2002:a05:6602:1653:b0:76c:7342:dde6 with SMTP id
 y19-20020a056602165300b0076c7342dde6mr515766iow.0.1684279508530; Tue, 16 May
 2023 16:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220928204929.56157-1-ping.cheng@wacom.com>
In-Reply-To: <20220928204929.56157-1-ping.cheng@wacom.com>
From:   Ping Cheng <pinglinux@gmail.com>
Date:   Tue, 16 May 2023 16:22:01 -0700
Message-ID: <CAF8JNhL1QRrR7yieQzrKR2NHif1ffnfE2eCCoqeEzc3Gz-vOLg@mail.gmail.com>
Subject: [PATCH] HID: wacom: add three styli to wacom_intuos_get_tool_type
To:     "stable # v4 . 10" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch, ID bfdc750c4cb2f3461b9b00a2755e2145ac195c9a, can be
applied to stable kernels 5.4 to 5.15, AS IS.

The patch has been merged to stable 6.1 and later. Thank you for your support!

Cheers,
Ping
