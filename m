Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A22F7015C3
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 11:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjEMJcY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238138AbjEMJcX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 05:32:23 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C381720
        for <stable@vger.kernel.org>; Sat, 13 May 2023 02:32:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DE8725C00EB;
        Sat, 13 May 2023 05:32:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 13 May 2023 05:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1683970325; x=1684056725; bh=++
        yClSm5vQnbLMIwEtH31nSHFtOpy8hEz6u0pwJv8Fs=; b=r7ZX9XSMslGcyw0Wiq
        jf15IeXuom/UAl7Tb7JkGYm+Z0wzvssuK+jrOp+aYO6Q6L/AmnG4StEPTpNixOvu
        i+Rd92z5LudsGXIjAb+jmO8qadWjLs/VIzRFDgUSXjp8l/3EgvIoLRPKQDigWBfx
        IuDggeZhy4PRqigqfWA/w7gXKrd8VSDmPP54OPD+DaqLdpB1m2USMlT6w0KqpWkB
        NNduUt+Ha6hzOiWxz26H+8ERx4p/GKrABouhSXgmrHPhs9K0WZRY7Hf1XgI5xvRs
        WjVZmlVmqRXBgyBc37UERcy1PVAgpXgxVHOipYrcE0to13GG1C9BS3oUyDYbhHd7
        awHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1683970325; x=1684056725; bh=++yClSm5vQnbL
        MIwEtH31nSHFtOpy8hEz6u0pwJv8Fs=; b=gFJ03z5/pc/ZRh/P8yYneYnBmctoW
        JrXg1Fk3cztrYC1LcpOBhCMLbvbg8KkRRR//OD/6KEooPYviHMBu0Wbfkq47rLiz
        fU3M1xgWDBpyJFAXDTglbxklj/vSudUsdoaMWypGrs/JFHHiHWKkMI7JZsHsgKqR
        pkIbOSiqHuYJoCPqMwshNMicgvAOm1Ve1S+F+VveDVFiikfA0Z94kfdNVuwuHZPM
        F9aUKE2E+OZ5Si2nrr3a0+cte5ZIGvWkK0lIy2iDpg1NG+SCwQsuAuqx0LaDogg2
        tbMkgeJuoCI6Oiqyv0p39X1gU1ZlLQTPzYKYpObYK6cWp3bDc3VL2cQJg==
X-ME-Sender: <xms:FVlfZElkiRiJjD-rnn5Ift5t1tcJVKGzr-XuPnr_fG6c02FSLsKfMA>
    <xme:FVlfZD1l2-tRuuQsynVRqJnCmaarPb3keYlhh00azyY5hbqeKQClY_-0O3i5GQFfi
    6Yp9ou8XMtd3g>
X-ME-Received: <xmr:FVlfZCpB-7ohCGO0o8DDtydFJviwAb9q1sij3bCS1SPZg8I-0-7ql2ws_s0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeffte
    ejleejgfeugeeggedvvddtueetteehteffffdvudevudetteehhfelheejnecuffhomhgr
    ihhnpegthhhrohhmihhumhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:FVlfZAnnIR3LRmq2W6NNzYMfoehYz1uV3qV6heZmmJD-IBKjMGuvHg>
    <xmx:FVlfZC05keOqwLZtCNNrWYfPemRq1Mmg1TVL4EfxgaW1NqE1C4rDOw>
    <xmx:FVlfZHtilpqtmj8Tu1ANdxOFSXA56nti6bC_d1iGVTxzT7yfci6LiA>
    <xmx:FVlfZMptLMr8Tf1NmxPrNEFqfJXHwXwQTnDlLQQJ17o8BlHY3ZNSRw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 May 2023 05:32:04 -0400 (EDT)
Date:   Sat, 13 May 2023 18:29:53 +0900
From:   Greg KH <greg@kroah.com>
To:     ovidiu.panait@windriver.com
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 5.10 1/1] KVM: x86: do not report a vCPU as preempted
 outside instruction boundaries
Message-ID: <2023051347-supervise-curve-e084@gregkh>
References: <20230509133330.2638333-1-ovidiu.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509133330.2638333-1-ovidiu.panait@windriver.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 09, 2023 at 04:33:30PM +0300, ovidiu.panait@windriver.com wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> commit 6cd88243c7e03845a450795e134b488fc2afb736 upstream.
> 
> If a vCPU is outside guest mode and is scheduled out, it might be in the
> process of making a memory access.  A problem occurs if another vCPU uses
> the PV TLB flush feature during the period when the vCPU is scheduled
> out, and a virtual address has already been translated but has not yet
> been accessed, because this is equivalent to using a stale TLB entry.
> 
> To avoid this, only report a vCPU as preempted if sure that the guest
> is at an instruction boundary.  A rescheduling request will be delivered
> to the host physical CPU as an external interrupt, so for simplicity
> consider any vmexit *not* instruction boundary except for external
> interrupts.
> 
> It would in principle be okay to report the vCPU as preempted also
> if it is sleeping in kvm_vcpu_block(): a TLB flush IPI will incur the
> vmentry/vmexit overhead unnecessarily, and optimistic spinning is
> also unlikely to succeed.  However, leave it for later because right
> now kvm_vcpu_check_block() is doing memory accesses.  Even
> though the TLB flush issue only applies to virtual memory address,
> it's very much preferrable to be conservative.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [OP: use VCPU_STAT() for debugfs entries]
> Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
> ---
> 5.10 backport of CVE-2022-39189 fix:
> https://bugs.chromium.org/p/project-zero/issues/detail?id=2309
> 

Now queued up, thanks.

greg k-h
