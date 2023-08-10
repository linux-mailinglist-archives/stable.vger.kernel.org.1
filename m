Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAD277752A
	for <lists+stable@lfdr.de>; Thu, 10 Aug 2023 11:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjHJJ7i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 10 Aug 2023 05:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbjHJJ7F (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 Aug 2023 05:59:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD0E10DC
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 02:59:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26837895fc8so427419a91.0
        for <stable@vger.kernel.org>; Thu, 10 Aug 2023 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691661545; x=1692266345;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CqJ2W9k72VS7u8tf5+RKoxDTrvxUG5N8rr7IlU0LReg=;
        b=nyuPG3vOaMd/12yE/W79781JbmHvHMYeLEMG0UPllZqfM5yAcvTSu3qy5xFwWzKDi8
         FyjpnrRdTvszq9A2HSNjIGquPFMJq3g5uKLqkVi9oE5jPfLPpb7lDcc7iAs8o3sRYPVN
         nyCUQrZQ6N5BxFMdV0qGULdLqnARAgb8M1P29yTW2nNGMAzL459Qsgz8sKROF7pntmgL
         PZQQ0NdFak0nuGk6ZkErqK+MbfzQflAeq8VUSeijAr7wPmnJ3qm+q0DeSxZ0jTYFLsXI
         5LcuaxIQ2cmAyeaV0ZpgNuJskfuv1KGrrz7iXarihY5DcdCOsq2cCfsX/S1ZQneb/mF1
         DH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661545; x=1692266345;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqJ2W9k72VS7u8tf5+RKoxDTrvxUG5N8rr7IlU0LReg=;
        b=gi7ouZF5wjKE76L0F8R6GqS83NaIqvgkdPAOBAwQz18C0/2+BfKJ6N6qhk+UqTKJX+
         uTIS5GjBcPPmclErCPv1e+ncRfMvj18ok420lE8VsPqsyF8C6fDHBBxjWYcPPJ1Bp3e9
         +ddG7DwjfFIBAHIPLNY3LzDsHNg4ZvvYIJpOYKiQbWYZ7a1HyWrI8sAWXX/7Vgn1ALwv
         eQ7/k1zEdpeeJ3itK/kPrV16FLGCfVhnc9Yp6A4VxQPVAU6Esl8lBblQljuz39paaRbd
         FY72yM5YM7byc3X5z1EOGOuPLNC/yyRqT+i6kwuSoQsQrgUo0ccGRcVlJ6r2GC10ZKhZ
         MzAg==
X-Gm-Message-State: AOJu0Yx07iEaEqD0KBrnL3GeKU5tKSsEACRWLSv0JAXJLxcHgfcbTAVn
        APFizwdJ4A9eV+0ofcNxNg0wIh1tYW4ZJ4o1kN5vFXrsmDs=
X-Google-Smtp-Source: AGHT+IFVPRxYgOKMpDtAFcCcLxaKxRQfZ8ROQUynUB1D7TVemYe6f27e2KeFto/oXTgdaRFk3Qx1CKFJ24lewJpbav0=
X-Received: by 2002:a17:90a:a102:b0:262:fba6:59b5 with SMTP id
 s2-20020a17090aa10200b00262fba659b5mr1273401pjp.24.1691661544705; Thu, 10 Aug
 2023 02:59:04 -0700 (PDT)
MIME-Version: 1.0
From:   RAJESH DASARI <raajeshdasari@gmail.com>
Date:   Thu, 10 Aug 2023 12:58:53 +0300
Message-ID: <CAPXMrf9Q7JGCwEnCKM8i0wi3oY9VH2V0fDYX_+6U9jfjzPeZ8Q@mail.gmail.com>
Subject: WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c in 5.4.252 kernel
To:     stable@vger.kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi ,

We are noticing the below warning in the latest 5.4.252 kernel bootup logs.

WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c:878
get_xsave_addr+0x83/0x90

and relevant call trace in the logs , after updating to kernel 5.4.252.

I see that issue is due to this commit
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.4.252&id=6e60443668978131a442df485db3deccb31d5651

This is seen in the qemu instance  which  is emulating the host cpu
and was deployed on Intel(R) Xeon(R) Gold 5218 processor.

I revert the commit and there is no WARNING and call trace in the logs
, Is this issue already reported and a fix is available? Could you
please provide your inputs.

Regards,
Rajesh.
