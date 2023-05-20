Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB0C70AA9D
	for <lists+stable@lfdr.de>; Sat, 20 May 2023 21:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjETTHr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 20 May 2023 15:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjETTHr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 20 May 2023 15:07:47 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BBFFB
        for <stable@vger.kernel.org>; Sat, 20 May 2023 12:07:46 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-510d1972d5aso6557895a12.0
        for <stable@vger.kernel.org>; Sat, 20 May 2023 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684609664; x=1687201664;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cIuacTUe55V68yxCoo7ary9vLzT4+1nPwynRvBBZauw=;
        b=a0waQjhy6xEt8PQ9Uc4/uQRzb4dLsPP3P6zclGSDsPLn6+HPr8dQMP7F9BmvJpVlfq
         2OwwI7VYETzyS7NM+Ab4OkcKkF67HvhK+UHeCuStwJPROgX+gbTrAujs1ikJzgRV1p4L
         KKBzlkOjAJzmQ2q9HG/JVArxjTF9ZtJm0gJKDL9Deu49KuFujDqIUnOKgxBbxmEvNn74
         zWXFxiDK0vQVGqxnGE7zqvQHkd22bi/B3h/3NG5rQlHiX9n05+fbBOnw0r/nakZ6QrY8
         FxmK7SRO/Fso8s4s7BhOMcozX2k6gWQzjDl+wjH+LExjUaSRnFNS1GWHnXGG6rFwCSpC
         QAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684609664; x=1687201664;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIuacTUe55V68yxCoo7ary9vLzT4+1nPwynRvBBZauw=;
        b=j937Iu7UxBv1So+OjHGtSzZ6Lbs7GlgDJxVeprhGsNVmeRq3A8W2CZRTadVUFd7psM
         nNwDqZDc8S9lj7nAsTdCohBsRIMvByZVWrvzilcsLrM49sccTyMf0UVhQuJXOdbPd/AN
         ALkrcqx7ijSbUmwSW8/AiuvHYjWnjOJHzLHkURGeIs5Ubtd53tpgS8xY6NKsBhgPhw5y
         rplkwIX3yZu2J1XOpgghY5ZslZdwI080KbrZOv6HL0HGaFegGFMTXI3QHlTP4FmVkPao
         MBZMFc1KBcChztNpFz4kUlDUO073pxg+TTNcCATZQ9gY/UT6mbVCywAwaEvE49jkCu80
         t2Cg==
X-Gm-Message-State: AC+VfDxoMZQ9gqsvKS1jTPVVyQoWNX1HqVyStMKeux9/0iPgifFviW/h
        UsedNuQK+aqsc98ZhUNtC4NqeN+7kGk8hLve5KE=
X-Google-Smtp-Source: ACHHUZ6U3ngg0z9G3MUa5zw9PhiXJLFyUaxii4SzslfPMeu7nI4VHLtKddwBBPawXQQIdDwkvve3jSdgWzwDvwI98dU=
X-Received: by 2002:aa7:da0a:0:b0:50d:d98a:dd15 with SMTP id
 r10-20020aa7da0a000000b0050dd98add15mr4305472eds.38.1684609664473; Sat, 20
 May 2023 12:07:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:2e82:0:b0:211:a898:1fe5 with HTTP; Sat, 20 May 2023
 12:07:43 -0700 (PDT)
Reply-To: sharharshalom@gmail.com
From:   Shahar shalom <anwarialima4@gmail.com>
Date:   Sat, 20 May 2023 19:07:43 +0000
Message-ID: <CAJQzuVfz-KE2Z23ko7AsPe5whWDy7n7V=13z59YqiiTdAAkuzw@mail.gmail.com>
Subject: =?UTF-8?B?5YaN5Lya?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

LS0gDQrkuIrlkajmn5DkuKrml7blgJnlr4TkuobkuIDlsIHpgq7ku7bnu5nkvaDvvIzmnJ/mnJsN
CuaUtuWIsOS9oOeahOWbnuS/oe+8jOS9huS7pOaIkeaDiuiutueahOaYr+S9oOS7juadpeayoeac
iei0ueW/g+WbnuWkjeOAgg0K6K+35Zue5aSN6L+b5LiA5q2l55qE6Kej6YeK44CCDQoNCuiCg+eE
tu+8jA0K5rKZ5ZOI5bCU5bmz5a6JDQo=
