Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7868774F8AE
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 22:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjGKUED (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 16:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGKUED (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 16:04:03 -0400
X-Greylist: delayed 45385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 13:03:28 PDT
Received: from out-51.mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B59170F
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 13:03:28 -0700 (PDT)
Date:   Tue, 11 Jul 2023 20:02:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689105771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j7wpPKSWBw5SPfNkCzcIKlvtgTa7z9041l05WeQlyP8=;
        b=p2knxbGe3yEElrh6ORsVsqD09+UwWkdlHYdv7AwamdXCHy7HAb9LoSpOMkPv6hVmc+gct3
        7ye/cwJk4MZUKJ2suXw/hq0Rv0vmOlvqLc2I3OKwkXsGyuGuTspq1eNqEUHG4kNOMMKI/q
        yGVOr4mOfyPNt0fsCTPvRWpGWfLFf58=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Eric Auger <eauger@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: timers: Use CNTHCTL_EL2 when setting
 non-CNTKCTL_EL1 bits
Message-ID: <ZK21Z5WB6+bTjWA0@linux.dev>
References: <20230627140557.544885-1-maz@kernel.org>
 <d49225cb-3240-ea8e-11e6-b8ed30ce2fc8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d49225cb-3240-ea8e-11e6-b8ed30ce2fc8@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 11, 2023 at 12:35:00PM +0200, Eric Auger wrote:
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks for reviewing this Eric. I addressed your comments and picked up
your R-b when applying Marc's patch.

-- 
Thanks,
Oliver
