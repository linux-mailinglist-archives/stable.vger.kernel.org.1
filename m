Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0C770A419
	for <lists+stable@lfdr.de>; Sat, 20 May 2023 02:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjETAub (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 20:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjETAub (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 20:50:31 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2BC19A
        for <stable@vger.kernel.org>; Fri, 19 May 2023 17:50:30 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-76c64ddee11so14687939f.2
        for <stable@vger.kernel.org>; Fri, 19 May 2023 17:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684543830; x=1687135830;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7HlAEARWXacHZe2CUvQqsqGHJ815Kco+WM8X5uUNNY=;
        b=JuOAe0knbk36WqRRMH1G1J4HBIv0HMYJUJ46crEPVw9kDBTOq/wR+coj1+ItM9d0s+
         /GDhEEzc+liohyK8zfIcUn4An1DSb2vFayfnXEdVXu5tivapkbctLe7nhmwdd+Pw81kR
         rFv54V3JsMcmrbPmyIPrBUdtvrXl9ccGdGPJ/I0jiaTNDpldYr4blO9sH5/XZvU3zTBB
         3Mp9sJ6zmN0/1iFuEh+OBj16xgeyfB+AzUBnJxYRXRDHXyGWdIRpfIL/EC4xct365Mjc
         WD/3Xs6xwcvKhS0U+NXWoTxEO/zIpCySfma4a+i+CGsJHJNLviH2w0nPNtO1tDZAnsuO
         2TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684543830; x=1687135830;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7HlAEARWXacHZe2CUvQqsqGHJ815Kco+WM8X5uUNNY=;
        b=M0kIbwCqJu2jYdfICmj338WzJyyWYpFRYb9Ki6SmSf7Xxt77Mvy64s12bEgv7rCKmz
         9GTB53GhfI45KHGXEiDBLp9v4vcowDg7IeX1svJBkEIp6UN24XEekrz+xVr2bwtzVlHx
         QhoXMd/BFobOoRA4UJGyZQBZ21aMfiSunBCDOf0HR4vpLr/+WtsmamfzkS8xjJz0YUVW
         3R3ApOGDeNf/x1uy3dDbxML+hpqojMsBLXvNWGpfuic4izAHbKYLJqZAf3q9JLl1XRpb
         0xjNz9MClaQZJlBYPZcL1J0KLT8a9od88Qxh3BQ7aJpxB0CxX2Ycus5B9JlhcYSGhmMZ
         YHkA==
X-Gm-Message-State: AC+VfDyGtJXJmyNWTMI+TnniBI3qgcV1bWUKbCkpJC2j9GII1oED4hDo
        G4oct5gw07OHlUGblDrZPrAXhB2Vfgs6D68vkrQ=
X-Google-Smtp-Source: ACHHUZ7HLFjTMMHHfoTW6y1oZBsuBM/8F16XR6re1Lyx/IIJHG+SYRX6iJFXMJz66FccvPFYBS2FvBj+rSEIIZd99BQ=
X-Received: by 2002:a5d:930a:0:b0:76c:8674:81e7 with SMTP id
 l10-20020a5d930a000000b0076c867481e7mr2339770ion.21.1684543829949; Fri, 19
 May 2023 17:50:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:140a:b0:40b:bd58:65fe with HTTP; Fri, 19 May 2023
 17:50:29 -0700 (PDT)
Reply-To: americabnkcapitalloan@outlook.com
From:   Amadeo Giannini <nschc97@gmail.com>
Date:   Sat, 20 May 2023 01:50:29 +0100
Message-ID: <CAB1PbNw=j5yCjGHrxoyf=ORa7SJ2F0QiCw54iHVsOzygcEp_aA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Looking for a loan? How much do you need and the time to pay it back?
Contact us now! Amadeo Giannini.
