Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EB3724F18
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 23:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjFFV7Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 17:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjFFV7X (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 17:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A57139
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686088716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bEvLWAMI2HrDdFDMly243IsfR1f9K5j9sqCGWCbWAGM=;
        b=YTqlDOHYfG0tNfNDZU+2CrW2PxRfj6G84nXJH5Jt/kijgFOEgyv8hj2Cj2qv3wBKO8+FWL
        qWX6m4yB15kuEzm1HHgEZL5IAnghS+gjx9Md3P4JGQtFUWkPkpbEbIow+6OwPLmLGPAl2+
        3eeyhAyoDozFCIuBs77wlzkASR3jjgU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-2nCZ9V7kNP-tMUYF9j5Zpg-1; Tue, 06 Jun 2023 17:58:35 -0400
X-MC-Unique: 2nCZ9V7kNP-tMUYF9j5Zpg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-977c516686aso381479766b.1
        for <stable@vger.kernel.org>; Tue, 06 Jun 2023 14:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686088714; x=1688680714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEvLWAMI2HrDdFDMly243IsfR1f9K5j9sqCGWCbWAGM=;
        b=TpGolujI4wTKVLeHxDPCOCAT9zS0vc/3BVl7jO0vaQlHmBrHiIWsCCO4WdhiQnIsLC
         lnbjuBTPWll6MJGMeHta3RxhKGgHWZU9gGIuoPqTl+LKkCKNmzjXnOdTci6pLCVU4y6m
         6nm8L/0+15psbq/A7vztCxWfZqI8bBtvbalwbqDJBlHGTu45AQ1wsMFfQMpRf92k8/Ey
         nGCMTW8UUfzJ9VIXcML7M2yJQIvCjGi95z8GKrPB+uQY6qtN9cu/li2TiX5W+m3gkzg8
         SqDihyw/VY4DYMXeONqHzI95cJ9aCJ+20ZWFCS/etSTrxdkixVJEqqKrhyNHiprV6T+I
         paXA==
X-Gm-Message-State: AC+VfDw3Gv5EdhsI02ZO0WiIxeX05YAfzp2rwAtnNl5woMUD7YcPuEqV
        rJ5tsIDXeZrOECB/6/llbhXkNbHowPAA8BVzwxORz0E5PWCsaixD1GHqGQyEBg7+Smqy/3Ffh5Z
        aVm5rZe1t00oNLar35C3biu3gGMVXst2G
X-Received: by 2002:a17:906:5d05:b0:977:ab43:731f with SMTP id g5-20020a1709065d0500b00977ab43731fmr4124452ejt.66.1686088714476;
        Tue, 06 Jun 2023 14:58:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6mAneljtJaJVoIl3T0+tmLxOSnJuYYjjRfAXA8ZeBiqS39RwPtiZMSEsnKb8ZpJXlNlhu5zYVFrqwj+rpbEWk=
X-Received: by 2002:a17:906:5d05:b0:977:ab43:731f with SMTP id
 g5-20020a1709065d0500b00977ab43731fmr4124441ejt.66.1686088714247; Tue, 06 Jun
 2023 14:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230606215626.327239-1-aahringo@redhat.com>
In-Reply-To: <20230606215626.327239-1-aahringo@redhat.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 6 Jun 2023 17:58:23 -0400
Message-ID: <CAK-6q+jad=WOEoKapcktJe+mxOS9GWdhkmRq=vUBLLuAGhY6RA@mail.gmail.com>
Subject: Re: [PATCH dlm/next] fs: dlm: fix nfs async lock callback handling
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Tue, Jun 6, 2023 at 5:56=E2=80=AFPM Alexander Aring <aahringo@redhat.com=
> wrote:
>
> This patch is fixing the current the callback handling if it's a nfs
> async lock request signaled if fl_lmops is set.
>
> When using `stress-ng --fcntl 32` on the kernel log there are several
> messages like:
>
> [11185.123533] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000=
002dd10f4d fl 000000007d13afae
> [11185.127135] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000=
002dd10f4d fl 00000000a6046fa0
> [11185.142668] dlm: dlm_plock_callback: vfs lock error 5d5127 file 000000=
002dd10f4d fl 000000001d13dfa5
>
> The commit 40595cdc93ed ("nfs: block notification on fs with its
> own ->lock") using only trylocks in an asynchronous polling behaviour. Th=
e
> behaviour before was however differently by evaluating F_SETLKW or F_SETL=
K
> and evaluating FL_SLEEP which was the case before commit 40595cdc93ed
> ("nfs: block notification on fs with its own ->lock"). This behaviour
> seems to be broken before. This patch will fix the behaviour for the
> special nfs case before commit 40595cdc93ed ("nfs: block notification on
> fs with its own ->lock").
>
> There is still a TODO of solving the case when an nfs locking request
> got interrupted.
>

sorry, I will rephrase that.

- Alex

