Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1B78DAF6
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 20:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjH3SiK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 14:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344201AbjH3S0y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 14:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CF31A1
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693419965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=536hEdeJYk89mYwQhbVybpmlRd6HjhERfF4XbjkRN4c=;
        b=ebEIlwjeZrnZBTFpL5Y1+z3MIlIWw9FlunwVbmsak9Idh73zwsMAWmwZZgdpayvbbBc6TE
        Kf/Fqq8+gNg0DogIw5eYuUr6RJVX7Rb3TcAwT+4T0rsi3i1zlIZat8vqMuOoq03aldrABs
        SH7YPr/arKbBsx2GO7ErpDh7SYZgkUA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-DMqXXmOoOuyum_nwSGZpEw-1; Wed, 30 Aug 2023 14:26:01 -0400
X-MC-Unique: DMqXXmOoOuyum_nwSGZpEw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-271cf74f2a2so38938a91.2
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 11:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693419959; x=1694024759;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=536hEdeJYk89mYwQhbVybpmlRd6HjhERfF4XbjkRN4c=;
        b=ef2BXqi13W3RePWB5e7QrZWj3/jMFtLCfVQiWmxHhx3XYgr4FEJDKrr1/8/bmk9lvP
         ObUCPhYAT/rJKHV91e4yzo595df9Vuq63rzFWjMNrTHVF4DWsH18Ew77718ul4+AsjFi
         B9OkTcfCN5LS1KNrLU2WLrK2m74qgoY5fJJo36AZohtxmAlyi639+lPHFRI7HaXtTl1z
         Ji5+FjkMsbAYr9RvsG2zRTkYSMQpjKjkmQHjTz+uQ+XoDbpXtmUK1thEek9GuA7Z0j7g
         xIDbKNN/nZtpNqsdrDLYi3GyG8CYQKWiB1MgcUBUWQnJDivqm6jayru1DTNlBgVBqj9O
         BCNw==
X-Gm-Message-State: AOJu0YyKIIs/J7xU671HgWzAZnH/adX0cuK0LD51bTXg7HRugO/IOPmW
        rH4rgIO42Nw4xEGt44UHEywr/gIMmf2xbpgHCaAjmcK5BocpzVRSRWEhViX+NLmEuSYUxi+Hs4E
        ZK7dVHjqKSFA9F5kNv9ZJbnh7gkiUPdq0FMpdB82OXF6WWmW9DI3PFR+XSXLgdL8S8HSFjLOQ67
        Ht
X-Received: by 2002:a17:902:ea0f:b0:1b8:a88c:4dc6 with SMTP id s15-20020a170902ea0f00b001b8a88c4dc6mr3373232plg.45.1693419958964;
        Wed, 30 Aug 2023 11:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJpuzkMKCcUxXuBwzDEAWKKYDzm/197FeA+Z+f1IJBUSeHVr2tKRuQSsaHopYrWCL9mnbIjA==
X-Received: by 2002:a17:902:ea0f:b0:1b8:a88c:4dc6 with SMTP id s15-20020a170902ea0f00b001b8a88c4dc6mr3373207plg.45.1693419958613;
        Wed, 30 Aug 2023 11:25:58 -0700 (PDT)
Received: from smtpclient.apple ([2600:1011:b15c:d1ac:a90e:1171:fe6:7d04])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001bbaf09ce15sm11357005plb.152.2023.08.30.11.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 11:25:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jerry Snitselaar <jsnitsel@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] tpm: Enable hwrng only for Pluton on AMD CPUs
Date:   Wed, 30 Aug 2023 11:25:45 -0700
Message-Id: <446E94FC-C47A-453F-9A0E-CBE5049582ED@redhat.com>
References: <zlywbvfgkkygcpvmj5rd4thuhbdacit2meg2fj6eyua5qpwyoc@beyiattrr7o6>
Cc:     linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <zlywbvfgkkygcpvmj5rd4thuhbdacit2meg2fj6eyua5qpwyoc@beyiattrr7o6>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: iPhone Mail (20G75)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



> On Aug 29, 2023, at 12:03 PM, Jerry Snitselaar <jsnitsel@redhat.com> wrote=
:
>=20
> =EF=BB=BFOn Wed, Aug 23, 2023 at 02:15:10AM +0300, Jarkko Sakkinen wrote:
>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for=

>> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the=

>> reported systems the TPM doesn't reply at bootup and returns back the
>> command code. This makes the TPM fail probe.
>>=20
>> Since only Microsoft Pluton is the only known combination of AMD CPU and
>> fTPM from other vendor, disable hwrng otherwise. In order to make sysadmi=
n
>> aware of this, print also info message to the klog.
>>=20
>> Cc: stable@vger.kernel.org
>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
>> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217804
>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>> v3:
>> * Forgot to amend config flags.
>> v2:
>> * CONFIG_X86
>> * Removed "Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>"
>> * Removed "Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>"
>> ---
>> drivers/char/tpm/tpm_crb.c | 33 ++++++++-------------------------
>> 1 file changed, 8 insertions(+), 25 deletions(-)
>>=20
>=20
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


It looks like the Fedora folks are getting more reports of the issue.=

