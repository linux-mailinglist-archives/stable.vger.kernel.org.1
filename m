Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234107E2008
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 12:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjKFLbP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 06:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjKFLbO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 06:31:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3E7DB
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 03:31:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DBFC433C8;
        Mon,  6 Nov 2023 11:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699270271;
        bh=GXQmqRN/QrxJMm2jYTiQM4g8A6ZtMYJbhA1VqcY0maw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=or3IHmR/CJTrjHcYO+HqE4/ojuS0V7s6rQwLXBkcUUhfw0yDjPGyl0pgalWFqLuGh
         uP3BQccvBAmaR9ehPuWeBIFDgxW6Aw1mflwpYwqzm/TUryXtDwYJD77xupC3UpQbsy
         Vo1isMpmNpuyD9ce6wXMLJfyj3IZthSEtJXx6HqY=
Date:   Mon, 6 Nov 2023 12:31:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.1.y] x86: KVM: SVM: always update the x2avic msr
 interception
Message-ID: <2023110600-tightwad-campfire-6a66@gregkh>
References: <2023102017-human-marine-7125@gregkh>
 <20231102175815.128993-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102175815.128993-1-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Nov 02, 2023 at 05:58:15PM +0000, SeongJae Park wrote:
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
> 
> Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Tested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20230928173354.217464-2-mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> (cherry picked from commit b65235f6e102354ccafda601eaa1c5bef5284d21)
> Signed-off-by: SeongJae Park <sj@kernel.org>

Now queued up, thanks.

greg k-h
