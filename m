Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9BA74BEA3
	for <lists+stable@lfdr.de>; Sat,  8 Jul 2023 19:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGHRnK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 8 Jul 2023 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGHRnK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 8 Jul 2023 13:43:10 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD42E6E
        for <stable@vger.kernel.org>; Sat,  8 Jul 2023 10:43:09 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b73b839025so2950438a34.1
        for <stable@vger.kernel.org>; Sat, 08 Jul 2023 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688838188; x=1691430188;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXHfTcs3P5Fsseh664xmWJ1EXvRq6tj78Ud9EIOJA0I=;
        b=b2VWOriCapsFkN3kSMUfIUwCkjx4Wlacb6iDNqc98tpp9I2JbuIkwdA4kWzvEARVpZ
         Ju/Zkq2ExF6DViX3UZ8meFlqWAQNUr9xjjiX4D3AaOqteIsc7vDOMwcz1Er7WO6Uny93
         ZnZOBn8mkH9qujDhk5iZ0iQuXEKy4NvMfsWx6eVXufZYAKsTX/KBHFLkqjFC03vFdPw2
         D+MPg5IOZjTSxoCFJNuejzuw5fVRj03mvhkpeQGft2yC9zG6EQMN7k+uZUyQ7wVoWp0R
         IHPL+cSuGS7Qnt3VeIF/IEFscBUg8ozJDjsBLe2hd3/M7QFze4tDMdn/NP5BrHDHS+O6
         qbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688838188; x=1691430188;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXHfTcs3P5Fsseh664xmWJ1EXvRq6tj78Ud9EIOJA0I=;
        b=PvQ3kGUI0crbd2t4yFyhMOhlemweElxjqBI+ue48FWx6miVxMWixdfWrrKqkGhOVmf
         cCt/rz5rlMIBi36v0oCyeI3Y7GP0fDkgOVprL9tw5mDJF/dtenY8aHTTJAd8X1FXByLq
         yuwPMCqIjpY8i3h1BBFCf7fmV/ZeS9YAESHBPv6hlrypO2iIhkp+Y/nbXCzCvvC5jqpB
         3v2QRM7dHcDFgaop7XIBmzfj/1uplKDSgIwsyN+IQkQZ03JSngZLA927YTIJaLYLZdxZ
         yVi9rKTOmswqeE+/bQ7oyiGe6RJhJZ8+Ns5ojHiWuRxyMx4W12AOFuc9K4YZEjLe0arv
         tdGA==
X-Gm-Message-State: ABy/qLbwaa81MbndXJTRsAITSYlHPqtpQufD4MKdwRZnfyJ4HvjsJG2/
        ljkwiQY+ti0/J5GhSnmIcT2y1Zndi4XL5JNkIJsmseT2b3c=
X-Google-Smtp-Source: APBJJlESKfgQHvYWjX1wzPc3ZIDjTiqVFpmeqQ7ZCCIwm7mGbQtBN9fu+8+ZzWLfYJhxY8J8h8eCET+KhMVVXXUDTwg=
X-Received: by 2002:a05:6808:1413:b0:3a3:a262:14d2 with SMTP id
 w19-20020a056808141300b003a3a26214d2mr12434637oiv.8.1688838188372; Sat, 08
 Jul 2023 10:43:08 -0700 (PDT)
MIME-Version: 1.0
Reply-To: gb2985@gmail.com
From:   zxuiji <gb2985@gmail.com>
Date:   Sat, 8 Jul 2023 18:42:57 +0100
Message-ID: <CAOZ3c1paOYY4mXuF_MMcb+12e7d4_1cXb8RxPDG5B3ty3fiwfA@mail.gmail.com>
Subject: Suggestion for extending SIGWINCH
To:     stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Currently it only indicates a change in window size, I expect the
si_code value is also 0 for this signal. The extension will be for
mouse input and the difference will be indicated by si_code being 1,
to avoid issues with x11 vs wayland vs etc a custom structure should
be pointed to in the si_addr parameter. I think the custom structure
should look something like this:

struct ttymouse
{
    uint button_mask;
    int x, y, wheel;
};
