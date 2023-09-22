Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68E57AB1FA
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjIVMR0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 08:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjIVMRY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 08:17:24 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C59719D
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 05:17:13 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-1dc9c2b2b79so696310fac.0
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 05:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=apdes.edu.ar; s=google; t=1695385033; x=1695989833; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+CWpFlZXIkpo6bXA93ooNG8lle0HG5mT8Jesqwk8T08=;
        b=uv+O9hw8PjxgjW5fwqWtkL/Pmyda4HizU0ELL3M1PdJyy8n3tLPJVSmsLWl61TfOm3
         QCzAD4LyohXwLrp0vddLT2y1puxwngUKLJo3oVmY3uLrixNf5qpb2Vy8yWD1UrxeqZp8
         jUKVTAf3LBNbRFT3kfIH6TAp6ow5LT9BbcHphKrFwhr5BuHwT7lSj331oDXuMGs1wfZU
         yhx44sJspQKwEJoHfFnvunpQIwW4LCuwgHxhvPjTJxGfXHzKAScBAEadt6ZNcc8c/QRX
         2XumuT173mEtBRwwuCbHA/bCLLmceAl9YVFvaJZrf7Cd6PR7tScjon/Uabu8ebSD0+G0
         PhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695385033; x=1695989833;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CWpFlZXIkpo6bXA93ooNG8lle0HG5mT8Jesqwk8T08=;
        b=FrrA15mPH3K2AiNd+apAthhlHezWndoo2ryOslaCbTvHhl6Z/1pwDx/U4h0OlHYrbS
         A4ntIFLgiDrZKHDJfMcs3OdCQs+LpaChMvaoW0MaHQuiPaXws+yxYJrgItOwkPPseleo
         YyBTiiimaM8tBQ7jlajVajYQ+gEERYEDW6RAJZrhNV8rW+VAKXOWPuuCdLDLVCxZPdLj
         /wP1yTXN9gKeSKMyRCrsotc8x8xvoKMTbaQw4QzDmRsd9OKVywhHyrjt3HyGcnLhC4M1
         lj6uin4wcGCWMRY/GEoANIq20R5OJCjILQ9nn5atuXetDpwuwR9XHbBMTwHp4tZSRLjZ
         4znw==
X-Gm-Message-State: AOJu0YzAhWVdjRk0c7o1lfcUeS1MHnMG7VKCSSK7L2VJXmeCyxv38gse
        RPJT4Eb+4AUcYceHHViaoh665CnMPyvFxd7sWOc17Q==
X-Google-Smtp-Source: AGHT+IFRkLm9sQ7e6PzTqnMw0317csiYVfn3xWxSa6Tfb4KuMEGLiIRG1oeBEu03neJ1Pd6cScRJmGA+lL2kCjK/TtM=
X-Received: by 2002:a05:6870:4724:b0:1bf:54b9:800 with SMTP id
 b36-20020a056870472400b001bf54b90800mr9113275oaq.59.1695385032504; Fri, 22
 Sep 2023 05:17:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:94a6:b0:13a:831:903 with HTTP; Fri, 22 Sep 2023
 05:17:12 -0700 (PDT)
Reply-To: mrslovethkonnia5@gmail.com
From:   Lucas Santiago Copertari Ramonda 
        <cr.lcopertariramonda@apdes.edu.ar>
Date:   Fri, 22 Sep 2023 12:17:12 +0000
Message-ID: <CAFWrDfUG6Cq9Vr3PWy7yQLBZ7jBcX2n08jGVFrDE7n13FELpwg@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Ol=C3=A1, querido, Em duas ocasi=C3=B5es, enviei-lhe um e-mail ao qual voc=
=C3=AA n=C3=A3o
respondeu. Voc=C3=AA consegue encontrar tempo para me responder agora?
.......................................
Hi Dear,On two occasions, I have sent an email to you which you have
not responded to.Can you find time to respond to me now?
