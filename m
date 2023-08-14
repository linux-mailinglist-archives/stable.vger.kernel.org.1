Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE62977BD16
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 17:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjHNPbn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 11:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjHNPbZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 11:31:25 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A98710D5
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 08:31:24 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 2adb3069b0e04-4fe1e7440f1so1328788e87.0
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 08:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692027082; x=1692631882;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dzJV+0JSxdS2u11Q4yqe83pIxspCfYUwALmsLNdmIGc=;
        b=oBR0hDZA/JyTnPzQJGGo1j5wxhOkJ83HnofRwDy8wYoLLYahvLTL2t0oHVmjLzjjY6
         vhWAH80kTTHAozOLDhllGw7nV+M/NBqkCuCZo7X4WiT7eNe/mkxJd+3ZZikSsgM0KNTY
         zzZNRGKCYmUHz2sv1vO09zc/em9j4UgTb6Cv0valL/lm5vEioJ/7p8BLOU41wgFtFS8R
         72NLsOZi1uS/aLNwfCA0TshPR22olmLCT/VrvYxPExvmrUJ9itrnP3VIwsbOCfnDGDLj
         jnwWGPJetfxWD7Z1a/aPxPiog7DEdgGLGPevGKmaTjMxhRNrWENj6VaixHvLkEoQDngp
         8dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692027082; x=1692631882;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzJV+0JSxdS2u11Q4yqe83pIxspCfYUwALmsLNdmIGc=;
        b=AHf7/RifYwMb47WxR7Akx4usJj/FzalRC8VH547O0OjZpJ1YECb7BIkyLWGIP2XlmZ
         9GQFOcNJkX5LjK9lrHcoXLD1vCz5AvFrGqdjstsVKrPdQlqBzLeTfdR0Ejx7tKPFoNwM
         TscTfBa3dGHVK9U0ylFgbZ9/mlI31ibAfla3m4KwTuIn4VaEOJH9c/aqX9AT2iFp4EYs
         I9QMPAfvHgAu1f1BKaKwfzal6u78oVMm8uUecg8URZzqxeTOUIXf3C4kSXM+1W+XlJ/J
         Xhrki2rM+aUJiWzwu80KJCTBcBmGoQn5lZVQrCTjq96ZM7gkv95q2mwMqFnckSdkt+jF
         pxEQ==
X-Gm-Message-State: AOJu0Yxz5ncMmghbV1bM/xRNbxlrb0PAIeor7glAeSMgP7BrJYfFg1iv
        VgtV1FzacltQFIXj0tY0mq9WCIWXztLas8foiDs=
X-Google-Smtp-Source: AGHT+IHNfqkPFJhHHveai/Q1hVBnhL4gIkHpLZIZSZEkrzYGOX3voMEs9+Ra/ZGmSD5YWczuxfKdtLp/fcyQA18CYfk=
X-Received: by 2002:ac2:4892:0:b0:4fd:cbd8:17c0 with SMTP id
 x18-20020ac24892000000b004fdcbd817c0mr5335074lfc.3.1692027082151; Mon, 14 Aug
 2023 08:31:22 -0700 (PDT)
MIME-Version: 1.0
From:   Yenny Miller <attendeeslistzone@gmail.com>
Date:   Mon, 14 Aug 2023 10:31:04 -0500
Message-ID: <CANF5vERNpjaoWqzzCVK_it3TmL4UN9i=0hG8rSGfA7-2CsM-Jg@mail.gmail.com>
Subject: RE: AWS RE:INVENT ATTENDEES EMAIL LIST- 2023
To:     Yenny Miller <attendeeslistzone@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Would you be interested in acquiring AWS reinvent/ Amazon Web Services
Attendees Email List- 2023?

List contains: Company Name, Contact Name, Title, Address, Street,
City, Zip code, State, Country, Telephone, Email address and more,

Number of Attendees: 45,369
Attendees List Cost: $2,099

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Yenny Miller
Marketing Coordinator
