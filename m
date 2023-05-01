Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5108C6F3A91
	for <lists+stable@lfdr.de>; Tue,  2 May 2023 00:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjEAWi7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 1 May 2023 18:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEAWi6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 1 May 2023 18:38:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669A310FD
        for <stable@vger.kernel.org>; Mon,  1 May 2023 15:38:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-24e16918323so671117a91.2
        for <stable@vger.kernel.org>; Mon, 01 May 2023 15:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682980737; x=1685572737;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8YlDrAMfNDxgNIs+pskPKPQe/QAIeun21T3Dh6xrOE=;
        b=TZhbZ8rvoEYm126a9D7TZtaKxijob1rhyvB5P6ByuSWkADOaC551KZ7LHgWbr7hPGF
         pT4Rplnb3Q/0y+3aWnwJ00fgzplDJpkMnRS8QuEhASAFzH8q76snYIzivZIkFrSogExO
         v0hIAFmCShtoGi71FsJvmLyZZG08S/4H2KIJOmD3CO7QoleMNp9lx8EAb2RE8mLrKNc4
         YZ7znYWvdqKHLCzMP73AFdFtbaDeVTZQxIHq5/P1eIIIGljfFDEuRuLwCZg7Tv1GTvHI
         RWmLapQJko+h+rLf61AzVNyK1VuyFqsLxQmoGGy75ekx3JDYGDSpmpiH3YrNv10tJIWv
         MIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682980737; x=1685572737;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8YlDrAMfNDxgNIs+pskPKPQe/QAIeun21T3Dh6xrOE=;
        b=GlXeSafFaWPaoTbLK2jvavrgMkyMQcJLwvwVppzG/g9ulUOzLkL7ipQf0rdOERsyQH
         uy0wD/XJH3v0OUyP0ZnDK2jk0YwrikR97PuJ9Y/yPW5SScNAI226EWagYXLgEY/39s30
         fiAr2p/tGJAERJKYw9a5Oagjiu82pR152SvXEFAFzzNlGawLdDQBRjyZ7pYrvVZa2PZQ
         oX2fYTFZMsNMq7DlU5hw7u8nvHLkSQMbwgml2iBPna3905TpRzmED1TD+LcjPJqYKWc5
         CSCL0s8GukEXosMhtrBG2Yv+ACU5VAi2+rskkMpvDOsHfNUNwXq0Ph8rCoMjaMpUpj7X
         1NgA==
X-Gm-Message-State: AC+VfDzCoj+DPip5k+jHpZxsXljOO+EjyteLfwFaDtCJ8dksnRW0SjZt
        QB23OOJhAzZfb6sy+TlQWC5DSEtBurPHyjo9PYw=
X-Google-Smtp-Source: ACHHUZ5u6gJ8yq1QGjL4Tuf5bbmerE+9CB/LrKMX7K1c2ZphZfbCJadmy3SSrmp8WcSi6g4o5z0euTb0OGpU49fxXtA=
X-Received: by 2002:a17:90b:3e8e:b0:247:2152:6391 with SMTP id
 rj14-20020a17090b3e8e00b0024721526391mr14489172pjb.17.1682980736846; Mon, 01
 May 2023 15:38:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:2d82:b0:606:e54e:616b with HTTP; Mon, 1 May 2023
 15:38:56 -0700 (PDT)
Reply-To: illuminatiinitiationcenter0@gmail.com
From:   Garry Lee <kizzacharles463@gmail.com>
Date:   Mon, 1 May 2023 15:38:56 -0700
Message-ID: <CAK6cLtdNE79qLXMt0gj6MN0RRg6q-UFRH+arnihC-apsKWDRJQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_40,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

-- 

DO YOU WANT TO BE RICH AND FAMOUS? JOIN THE GREAT ILLUMINATI ORDER OF
RICHES, POWER/FAME NOW AND ACHIEVE ALL YOUR DREAMS? IF YES SEND DOWN
YOUR FULL NAME: YOUR PHONE NUMBER: COUNTRY: All reply should be copied
and sent to: illuminatiinitiationcenter0@gmail.com
