Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3D3788897
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 15:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbjHYN3j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 25 Aug 2023 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245180AbjHYN3G (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 25 Aug 2023 09:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD46A1FDF
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692970097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CqE2XZ8vAAjA28aCjN6vUrQeXq80ioUn58FygUj89Nk=;
        b=Zzx3vGCdE5VQASLCNBxVzq6vlszfWcDWdpRL4qc44hvPbIuR8RJv2/ZhXyTeNKfZspbrbo
        LbqtAOn7xDbLEZSygl/B6NKaQpYSsTwSfvDcN2tfT1h/7/ciEcaeEqzNwDQtYolewchVPO
        5W7wCGqcT2aP7YXHGO+O6l7ZfZIYg2U=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-989uEdnUPjqdWWD56Q4Peg-1; Fri, 25 Aug 2023 09:28:15 -0400
X-MC-Unique: 989uEdnUPjqdWWD56Q4Peg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4ff9b3ead6fso978014e87.2
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 06:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692970093; x=1693574893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqE2XZ8vAAjA28aCjN6vUrQeXq80ioUn58FygUj89Nk=;
        b=fJJtceD4MVlVp0fUMlw07+fnEYMMWKq+uj5nK7PnyaX6s4Rv7mQ1q1XDpgQi4YForz
         lkVROoo779fq1g0ue3kdCvjwAFkUZNTdMHMXh0cxfQJ+D8K1lfsfXJhbTyjqfDiokJiK
         oTu+xn3OuxKSiGNHP5VE/VwU4Uq91FfQIPiqFB4AmD4Oh5inoWENXs2hKyu1AAYe1uxF
         gJqRFHJnJAuOXr47AcVN/ZaF3wmcpvnRUf2yiadDgf8mRYRJSq19G4Ntg2RKIM+t15ZO
         KTNerO9cE74dbVQI6K6dwlhgIl8qLvJv5SWKipJWPI72tQe3HTZddHlpwQGFeQTFxEAJ
         pY/g==
X-Gm-Message-State: AOJu0YywcuJP1WFf4uWSBmnn4jkALsPnKlP7QHFEOv3Frf3Bnrz3q/Mw
        KEMc3KL+QRr1VALnPdyzpcOBwe+QZL7A8U7yV5/UQA2o1DUVOtJFdkpjWgJ6eWkf7eFrpiriS8Y
        lL8FBpQ4jwe1BuU74kkjiS3z7Y+2wQGv8O1lSmOBt
X-Received: by 2002:ac2:5597:0:b0:500:a397:d4f0 with SMTP id v23-20020ac25597000000b00500a397d4f0mr2241620lfg.31.1692970093094;
        Fri, 25 Aug 2023 06:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ67vk3QxZ6sISoOnE3BVszGLL2jnGfU1MzHum7/pIdlRGhX0gCXDE1iJ2KeJ7zFMyuqWIkkAF0+pNC4hXrVA=
X-Received: by 2002:ac2:5597:0:b0:500:a397:d4f0 with SMTP id
 v23-20020ac25597000000b00500a397d4f0mr2241607lfg.31.1692970092728; Fri, 25
 Aug 2023 06:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230824205142.2732984-1-aahringo@redhat.com> <CAK-6q+iUe1=68LFv=BVd4MxVhtPf=jGPRFfXXNopEB2J+gjWqg@mail.gmail.com>
In-Reply-To: <CAK-6q+iUe1=68LFv=BVd4MxVhtPf=jGPRFfXXNopEB2J+gjWqg@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 25 Aug 2023 09:28:01 -0400
Message-ID: <CAK-6q+j=i176L=sC-xAXC6+rSrUhuSeTxWMrpwExeHTpDGKrGw@mail.gmail.com>
Subject: Re: [PATCH dlm/next] dlm: fix plock lookup when using multiple lockspaces
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, stable@vger.kernel.org,
        bmarson@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Thu, Aug 24, 2023 at 7:22=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
...
>
> The reason why I probably never saw it is because those fields in my
> tests are always the same and we simply don't compare all fields on
> the sanity check.

I need to correct some things here... the patch works, but the commit
message related to some locking issues is wrong. It works to make the
lookup on a per lockspace basis because dlm_controld has a per
lockspace corosync handle. Corosync keeps plock_op and results in
order which is necessary for the lookup mechanism here. So this
mechanism is on a per lockspace basis in order, if dlm_controld would
have a global corosync handle it would work on a global basis.

The issue I saw with putting more sanity checks for start/end fields
does not work because DLM_PLOCK_OP_GET will manipulate fields and they
can't be compared between original request and result. I ran into this
issue a couple times...

- Alex

