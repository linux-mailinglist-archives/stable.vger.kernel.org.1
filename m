Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D31A730591
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 18:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjFNQ7L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 12:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFNQ7G (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 12:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0412126B7
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 09:58:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D14760E8D
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 16:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBC3C433C8;
        Wed, 14 Jun 2023 16:58:52 +0000 (UTC)
Date:   Wed, 14 Jun 2023 17:58:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Darren Hart <darren@os.amperecomputing.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: errata: Mitigate Ampere1 erratum AC03_CPU_38
 at stage-2
Message-ID: <ZInxyiDsyJRo2K9D@arm.com>
References: <20230609220104.1836988-1-oliver.upton@linux.dev>
 <20230609220104.1836988-2-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609220104.1836988-2-oliver.upton@linux.dev>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 09, 2023 at 10:01:02PM +0000, Oliver Upton wrote:
> AmpereOne has an erratum in its implementation of FEAT_HAFDBS that
> required disabling the feature on the design. This was done by reporting
> the feature as not implemented in the ID register, although the
> corresponding control bits were not actually RES0. This does not align
> well with the requirements of the architecture, which mandates these
> bits be RES0 if HAFDBS isn't implemented.
> 
> The kernel's use of stage-1 is unaffected, as the HA and HD bits are
> only set if HAFDBS is detected in the ID register. KVM, on the other
> hand, relies on the RES0 behavior at stage-2 to use the same value for
> VTCR_EL2 on any cpu in the system. Mitigate the non-RES0 behavior by
> leaving VTCR_EL2.HA clear on affected systems.
> 
> Cc: stable@vger.kernel.org
> Cc: D Scott Phillips <scott@os.amperecomputing.com>
> Cc: Darren Hart <darren@os.amperecomputing.com>
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

For the non-KVM bits in here:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
