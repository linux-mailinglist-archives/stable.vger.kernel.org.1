Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF10570C46A
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 19:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjEVRev (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 13:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjEVRei (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 13:34:38 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E9FA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 10:34:37 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5CE3B5C0125;
        Mon, 22 May 2023 13:34:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 22 May 2023 13:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684776874; x=1684863274; bh=q8
        FlZ7zvl+iXN2+NykVQ1nq5xPmIDGNjDQFtihr7ZAM=; b=STjwx/lStfX/ecYLkC
        uZP5n+DDnOfVgsdHR5L3cmcjwhnJqOdFbxIXpNWu7K14nAgJsyKUyPaCshirG05R
        /itMG72UCMUVjoAVOFqWmDdFa8O8k87E6N8eI6g17TK/BzVaRs7r5adnbKOslF4D
        nMY7iRWm+v756EHRJPv1tSOZAN+rfDW4NMM5XwKTioTOFP4qnA/MH8U6FcOE5wAV
        SFKXJp/4AOb4mIcyW7mICr2uRNjIakTWqCVOppaCKdXKd3ZZZ6+KlmDarimgzwpV
        K6NjiSu/MTmAFJF28ouUR5xqZJZVlXVG3qvOgyjqSaQdgwJzYKK4SrK3nfPQAJP1
        WAiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684776874; x=1684863274; bh=q8FlZ7zvl+iXN
        2+NykVQ1nq5xPmIDGNjDQFtihr7ZAM=; b=CgjQ8vKy1FhwmgaDrEi3gSILJ6423
        nj3datgwvdcwdP5pKbq9qcp4uwZ/vk67TK7RSjcNTt/pZuMqZUodasbD2jzD+alj
        YOAk63YcxkDeKRp/ltWIURPGA6dVpoT3dCTFUGmD2qT0mODet+l+ko5Q4s9qpKkb
        ieLDobmKNlc6TcuxrFDVlFs5zCNT1Jc8SgqMAP5qlWplrILq4bvMaBD1j461LVkg
        wypA+E5oySiXGfTdeVI+sOfEsoHrZwcPN8h+VY6lYBtE+CU6TTudG2nx/Teo9mPv
        vvtK0DYLAHoFaAd7mtF4KHR9eS1Dcy/ZgqOMEhGILzGulkMKAmRik9U/A==
X-ME-Sender: <xms:qqdrZL8dXFwbdRpQ1lrFq2lF5E4F6h4AhMndYMHbXnIH4VWnC6cgRg>
    <xme:qqdrZHtg_Gs0JksLI3ZML5jWTDXtiN4mwAEJ2bOynsvh-1B06FniQrLwp9sWmE1b6
    gRVC2e52CHzhQ>
X-ME-Received: <xmr:qqdrZJDu50tixL5G-mtAsQ9sl7RDVFvuWTmB6-ChgMimmynf97q6uKOGnYqqmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:qqdrZHdfucOL_rFiPf-AjqtD1yZgxvhybHN1ov_0E2CDuolpCBHq3Q>
    <xmx:qqdrZANUqlFqb1VM1W9F3aF1Oht4DhzztWYHLfpOV_Jxh_N9WnS16A>
    <xmx:qqdrZJkTq1r3kXzJjdLHArqDsTt3OGd1cB3ubWFNvKPTH2298uPUtg>
    <xmx:qqdrZMBwmPGSdTo7e0w-H_4p1LBpb0LBeeIwMdsVoAFP6xoHw0Q5pg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 May 2023 13:34:33 -0400 (EDT)
Date:   Mon, 22 May 2023 18:34:31 +0100
From:   Greg KH <greg@kroah.com>
To:     ovidiu.panait@windriver.com
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 5.4 1/1] KVM: x86: do not report a vCPU as preempted
 outside instruction boundaries
Message-ID: <2023052224-hexagon-scoundrel-f320@gregkh>
References: <20230519144351.2527664-1-ovidiu.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519144351.2527664-1-ovidiu.panait@windriver.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, May 19, 2023 at 05:43:51PM +0300, ovidiu.panait@windriver.com wrote:
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

Now queued up, thanks.

greg k-h
