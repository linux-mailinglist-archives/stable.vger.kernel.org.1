Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B606C6F289E
	for <lists+stable@lfdr.de>; Sun, 30 Apr 2023 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjD3LjZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 30 Apr 2023 07:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjD3LjY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 30 Apr 2023 07:39:24 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F61826BF
        for <stable@vger.kernel.org>; Sun, 30 Apr 2023 04:39:23 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id ca18e2360f4ac-768d75b2369so135931239f.0
        for <stable@vger.kernel.org>; Sun, 30 Apr 2023 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682854762; x=1685446762;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=73O5EFj5gxy534mQnnj78ry1z2di6a/7xsyuHuh+e+w=;
        b=mBcUuvTK/Uft+zvVQKhEJGyLBHV0uYjHfETS+tOGlPBNH0vmz8j5Ytgx+Jq4Rsisph
         ttUzlTZ77cGquIrA1js3OgBChDtVnz2q3zmYRm5LJT/rnUbTgKnnU1h7FYGmaBr+Rioy
         i9uoa2TJs3Dkn3Yw12qHGx+OVhnvmbNap2s/nctOwuVi08xfheyomtyalOyvnpX3MJQ5
         bILt291quiAGm2Db1e/uyBUcmXww7JkvshpIbBh/l3Kpe8Bss4Q23xJqJ2AeHwmf5Rdd
         TYTHHGQ6xT3uKIy/IcF5Kyov/lcwv+2devSssJS2PZCVpVkOBPCPc3FEMyxC4T4G8xMW
         A+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682854762; x=1685446762;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73O5EFj5gxy534mQnnj78ry1z2di6a/7xsyuHuh+e+w=;
        b=gP6F7g1DekTiKd83+w8DfN6lAReCoXCVcCwkMaLzaQYuctRGORrrzL3FoqKb2nu9GK
         sgjpyhM5AfFjB/sThuqxAVsnzsI08pxICNzXmb767hy4Q9th6QxQDmma2SCDDqKxUQNH
         DXsc8emmxZTSJuLFyqaoE5WDD2lmPyu4cSgx0CY52oPiYs4CMpb7T8Q0fPWcG/Hr+0Pn
         SmcI9gxZye+MCRnQL7d/lrXP1VFiY5/kRFVCV6X4lp23J+BuckOwuCp+HdiXmSS/PaUB
         mU/JepKWNzYwIdNtsCKPK1F3BKRhcCKkUXQXWNbQ6JiELXUJLwcW/DzCckd2DIqsTNJh
         aNwA==
X-Gm-Message-State: AC+VfDzhMHZGAezttKikVeliLDcucUCDc3NFnFqfjzTMjBfqMWlnxnrW
        pn86mZJvDeKDNc+pY7lSH8aFsKEfhsxjjFfU1Hk=
X-Google-Smtp-Source: ACHHUZ7pRb2ZpG9OUIGRTtpMA9Jc2fgo/RMZDe7XPnKyBRKSOUv4kbg5sOIb1IaTbxtwUukOLquzRNGcl2yO1YMR0cs=
X-Received: by 2002:a92:3205:0:b0:32b:13ad:3e48 with SMTP id
 z5-20020a923205000000b0032b13ad3e48mr6165042ile.14.1682854762543; Sun, 30 Apr
 2023 04:39:22 -0700 (PDT)
MIME-Version: 1.0
Sender: zjefftwilliams1@gmail.com
Received: by 2002:a92:cc51:0:b0:325:df6f:aaea with HTTP; Sun, 30 Apr 2023
 04:39:22 -0700 (PDT)
From:   Pavillion Tchi <tchi.pavillion@gmail.com>
Date:   Sun, 30 Apr 2023 11:39:22 +0000
X-Google-Sender-Auth: DvAaUI-RHonT9-X2dnD9LV9Ix1o
Message-ID: <CAHfYO7rHWyg=P0jvBXrXCQF8vdH+MeaRE-vFgU6uU8X+6wrPEw@mail.gmail.com>
Subject: =?UTF-8?B?16nXnNeV150=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

LS0gDQrXqdec15XXnQ0K15TXkNedINen15nXkdec16og15DXqiDXlNeQ15nXnteZ15nXnCDXlNeQ
15fXqNeV158g16nXnNeZPw0K
