Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3516B6F28A4
	for <lists+stable@lfdr.de>; Sun, 30 Apr 2023 13:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjD3Lr3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 30 Apr 2023 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjD3Lr2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 30 Apr 2023 07:47:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1390E7A
        for <stable@vger.kernel.org>; Sun, 30 Apr 2023 04:47:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f00d3f98deso18194269e87.0
        for <stable@vger.kernel.org>; Sun, 30 Apr 2023 04:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682855246; x=1685447246;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vx1dtfCg5LdAW7Qp5E1vgS8Xq+Rma2uSPIHiasEwQVc=;
        b=EdtgGzQdw79FX1AkLLYb7NV141OKO9U2mQ6Im+nKTQVkBLwn1QKiMpt5DagDPpn/6W
         uipMsnI4yA8MikxVpu/g8EE8REA/6EnifF35u1Nhp8+CcsqgbPaf+oNx6Bbh56G2icaU
         ly8s31X9SrKwFEBWcGFD5XQMTmXgxRFFcyul/kq4IXWbbMS+OiMGHPV8xCvxq5etexQ/
         rLPRWGAypcMf1thJECYoSbfslZBXJ/6PnrqfV73wQRSFDmNVL+uF3ytFY1YM7Xqd+yf8
         FAdbrKYl2oyq10k3p59olOOSyYdNk59wKlkIcGMtUQGBpv3iJyugXFF4Wq86M4knxTKo
         Lq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682855246; x=1685447246;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx1dtfCg5LdAW7Qp5E1vgS8Xq+Rma2uSPIHiasEwQVc=;
        b=PlYpLeWJZoD4lb3Kebdau0u2TOpRnMrGHOSwfa/u/2ftUw+gdRbQ8WcFr5x1gU0EYW
         A4QQsb2dEjTNWVpUVTIsYMyZfzhwGzu9dWOPXrQbDT57kmeGInhdpjUaRvsr/hOjpPGM
         p9XJSGTJGmthTIC6SJQqIBjH7YwSQuUXyb5DdkcO9Oq9a580RPaqfZshJ7TMSQKnSqrs
         b6BRRIyeco1+KJbRAqXgZxN2pPjObXVYxHzh1cYu78SpVCm4BSxp6FGZBHh136iRLMX3
         T0DqURChG3CybmVIwkiov5YJiBpv6YNOn/KipuXuOrSrfgi66m55/jrhpISp/YUFjCEq
         MdUQ==
X-Gm-Message-State: AC+VfDzhueaZF0U4RCL8/IHfeq/bCT2ixRkAGWB5PAl/L9J5qfIpNJzY
        IQOT/qf4Jvjl7imPf0gUoJJ9oMxIbUD7/qu+xAM=
X-Google-Smtp-Source: ACHHUZ4Y/WMPOx38h3cjRqhjLr2QpcJOEg63wwSSKKD83euTVJZz3KwwjAYCTjPPIotIIbK32l30Pgg4wleHd2xa6w4=
X-Received: by 2002:a2e:9b56:0:b0:2aa:e7cd:69f8 with SMTP id
 o22-20020a2e9b56000000b002aae7cd69f8mr3599040ljj.9.1682855245508; Sun, 30 Apr
 2023 04:47:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:1083:b0:25b:7e95:d4d1 with HTTP; Sun, 30 Apr 2023
 04:47:24 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   wormer Amos <rolsbaraye@gmail.com>
Date:   Sun, 30 Apr 2023 12:47:24 +0100
Message-ID: <CAGkCXQit51KFpGTA9hteKiDjJJ=ryRiSSjc4mQMDtL-DU6WFFg@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Sir/Ma'm. please kindly want to know if you're capable for business investment
project in
your country because i
need a serious partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email below.

Thanks and awaiting for your quick response,

Amos!!
