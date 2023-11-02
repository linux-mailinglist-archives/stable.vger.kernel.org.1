Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587F97DF938
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 18:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjKBRyj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 13:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjKBRyj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 13:54:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4864012D
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 10:54:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7309BC433C9;
        Thu,  2 Nov 2023 17:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698947676;
        bh=MW9//3xkq8EDcYq0B8BGw5SXQVYenl8PJ9LBnivynVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h0MQduGOkQqm95w5Lh3DqtD5XXIbwBojWKI/vsHrCxI6Ghv9JuGRDZ+Pt4nX0Uewl
         FaHyyiEj8EjA4wXjloS494pNJDMBBsEQx7uzU9xukDbVHDsGYKWHU6RpK3tcI+ipxa
         9xzCdakw1vado89FweiRY5Im5Gz71XTTTd4r6aC8PTT7dzixrY9h2JWXi2xihkmh2k
         O2Ym/S3Y9BrnR0CUrmxBO5UewA3Tr4gNZyA3891PMZdcEWn8dJRnjfdNw0v9L4F+D5
         bW17qQHOukP24pEV05QEBE730jkQu6MUYY17jowfKyhROa6Bkeg7Fs8ZPcId0kgGFC
         mfKwN752JogfA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.1.y] x86: KVM: SVM: always update the x2avic msr interception
Date:   Thu,  2 Nov 2023 17:54:34 +0000
Message-Id: <20231102175434.128737-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173311.128654-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Please ignore this patch.  I mistakenly sent this wrong one.  Sorry for making
noise.


Thanks,
SJ

On Thu, 2 Nov 2023 17:33:11 +0000 SeongJae Park <sj@kernel.org> wrote:

> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> The following problem exists since x2avic was enabled in the KVM:
> 
> svm_set_x2apic_msr_interception is called to enable the interception of
> the x2apic msrs.
> 
> In particular it is called at the moment the guest resets its apic.
> 
> Assuming that the guest's apic was in x2apic mode, the reset will bring
> it back to the xapic mode.
> 
> The svm_set_x2apic_msr_interception however has an erroneous check for
> '!apic_x2apic_mode()' which prevents it from doing anything in this case.
> 
> As a result of this, all x2apic msrs are left unintercepted, and that
> exposes the bare metal x2apic (if enabled) to the guest.
> Oops.
> 
> Remove the erroneous '!apic_x2apic_mode()' check to fix that.
> 
> This fixes CVE-2023-5090
