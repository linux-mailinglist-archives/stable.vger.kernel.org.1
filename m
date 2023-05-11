Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF0E6FFBBC
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 23:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbjEKVPg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 17:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbjEKVPf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 17:15:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0271FFF
        for <stable@vger.kernel.org>; Thu, 11 May 2023 14:15:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba6f530c9c7so499098276.3
        for <stable@vger.kernel.org>; Thu, 11 May 2023 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683839733; x=1686431733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYt/rFt4ATArTlkw2U5UMFdKJHBmWLe43VjEXYy+lio=;
        b=lYv4EGgeOaaTWEyU/KcDRMofS3MH1008jKthME3mqsgtNK0qF3xIcEO3PIPE5PhVo2
         6dNniCNbu6/CAxK+XIGlEwhCncsGpJwxBry3PUM5tJRHfRbmPLxF+b7GbTwCUG59eBOO
         Y4WUaFxv9PiIl/fDq2mOpAXWI4/HMucX55WmwsRxWS8Em3Uo1OnDl3B91J5A5xuUTjTQ
         MBF6bvZwNkQpRFdOwoXxPg0PU6AjSOo9OIHj2XVkm/PjASbiliUJ0yzFn0W1EFAtgEtC
         90KSpYIEkSxWdJA7O/RhAtLlLuV+RHJuko8iSVx7OBrTJjKp067mjikten/jCUHBtoKM
         ujHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839733; x=1686431733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYt/rFt4ATArTlkw2U5UMFdKJHBmWLe43VjEXYy+lio=;
        b=isiCQaBXclTtwfDxG1KzAAmf6Qsb38aqyCqA1F3nragOPs4xQa1ARvyXNnSuHH5Xoj
         EnQMMAhLWcBV0+tOana1yqwapjdh4DqRVcquH8c2pOKbUizSeVgxym4trVUYS4rYDS/3
         e+Bv3ytHH2pcWDt8Ct5OAcCk8cZpdB1VmIrxTgcfZlAF4zsa6rPR7gDcivHbOOCZJ9/u
         S0U4vUd1ukhCdxZXCMgYZDOPU3sWeXQ1us4xZhwalcg7MCdbZN6Z1a+659BuXTa51+5e
         BB8m7kJ6iP5fxY8AU27pXwyrhebS5S+EIUuKGicjwP95mXH9ev8YGN+rUNf27dGaKdLA
         TfBQ==
X-Gm-Message-State: AC+VfDzQvejMhjJSDBl9fAOb8gStYHpFEgNyqOB8C+M7ZXvamTVCPo9X
        ktfNR23urZBPW1fetf6usoO0cYjpTEo=
X-Google-Smtp-Source: ACHHUZ5IhR7PpbWupkdM3XbIo6vUvgVmG4Gxs9rkF8nEzxgMk7qZZC8AI71C9esWqCKNDDxGbZEiFlirgco=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:114e:b0:b4a:3896:bc17 with SMTP id
 p14-20020a056902114e00b00b4a3896bc17mr10141981ybu.0.1683839733419; Thu, 11
 May 2023 14:15:33 -0700 (PDT)
Date:   Thu, 11 May 2023 14:15:31 -0700
In-Reply-To: <20230508154709.30043-1-minipli@grsecurity.net>
Mime-Version: 1.0
References: <20230508154709.30043-1-minipli@grsecurity.net>
Message-ID: <ZF1a8xIGLwcdJDVZ@google.com>
Subject: Re: [PATCH 5.15 0/8] KVM CR0.WP series backport
From:   Sean Christopherson <seanjc@google.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 08, 2023, Mathias Krause wrote:
> This is a backport of the CR0.WP KVM series[1] to Linux v5.15. It
> differs from the v6.1 backport as in needing additional prerequisite
> patches from Lai Jiangshan (and fixes for those) to ensure the
> assumption it's safe to let CR0.WP be a guest owned bit still stand.

NAK.

The CR0.WP changes also very subtly rely on commit 2ba676774dfc ("KVM: x86/mmu:
cleanup computation of MMU roles for two-dimensional paging"), which hardcodes
WP=1 in the mmu role.  Without that, KVM will end up in a weird state when
reinitializing the MMU context without reloading the root, as KVM will effectively
change the role of an active root.  E.g. child pages in the legacy MMU will have
a mix of WP=0 and WP=1 in their role.

The inconsistency may or may not cause functional problems (I honestly don't know),
but this missed dependency is exactly the type of problem that I am/was worried
about with respect to backporting these changes all the way to 5.15.  I'm simply
not comfortable backporting these changes due to the number of modifications and
enhancements that we've made to the TDP MMU, and to KVM's MMU handling in general,
between 5.15 and 6.1.
