Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B1B71778A
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 09:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjEaHIC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 03:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjEaHIB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 03:08:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F102EE
        for <stable@vger.kernel.org>; Wed, 31 May 2023 00:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F2C76145F
        for <stable@vger.kernel.org>; Wed, 31 May 2023 07:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F330EC433D2;
        Wed, 31 May 2023 07:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685516880;
        bh=t8zPr94u10649fhILBA5TlwSf5Khh+PaylXzXjpH1RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUydpLMfzA+EhDeG1n7tMTKVU1KDnGDjTOd8GKURH0SHFLBQEBsP3QbaH0ixl4YWZ
         IFMC/yrc/lQs46wxlM3iRAq7Tka9A3ZRqpHfkj3yerQCqxO6hTnBv8Z0zgSe3mlx5Q
         ACfWMP2+Be2LrhM0ieIBPZJULO2oSGE9lewUkhSMbfANktiHK/VOveOUyq9YkEhqQD
         YglT5x3ZKTaMbzZxZyi+xzhm+Z4/bTY6/TyZe74qcvhDQXkMhP1/ILeA+wEf0BvmDm
         dNlz18vjDihUuT8QduW8pPxnjQsEPnfYITiCxdkHayFH6+ynHwSnT6sgfavdLJ3lQ8
         rTQQSfwPgXNDg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1q4Fw5-001XWS-PK;
        Wed, 31 May 2023 08:07:57 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, Yu Zhao <yuzhao@google.com>,
        Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Drop last page ref in kvm_pgtable_stage2_free_removed()
Date:   Wed, 31 May 2023 08:07:54 +0100
Message-Id: <168551686716.427043.12115690146514888299.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530193213.1663411-1-oliver.upton@linux.dev>
References: <20230530193213.1663411-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oliver.upton@linux.dev, kvmarm@lists.linux.dev, suzuki.poulose@arm.com, yuzenghui@huawei.com, yuzhao@google.com, tabba@google.com, james.morse@arm.com, will@kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 30 May 2023 19:32:13 +0000, Oliver Upton wrote:
> The reference count on page table allocations is increased for every
> 'counted' PTE (valid or donated) in the table in addition to the initial
> reference from ->zalloc_page(). kvm_pgtable_stage2_free_removed() fails
> to drop the last reference on the root of the table walk, meaning we
> leak memory.
> 
> Fix it by dropping the last reference after the free walker returns,
> at which point all references for 'counted' PTEs have been released.

Applied to fixes, thanks!

[1/1] KVM: arm64: Drop last page ref in kvm_pgtable_stage2_free_removed()
      commit: f6a27d6dc51b288106adaf053cff9c9b9cc12c4e

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


