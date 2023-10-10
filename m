Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FCD7C01B0
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 18:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjJJQcl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjJJQci (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 12:32:38 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BE5D8E
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 09:32:36 -0700 (PDT)
Received: from [172.20.10.67] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9E37020B74C0;
        Tue, 10 Oct 2023 09:32:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E37020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696955554;
        bh=ak819Mnp0LXwVVtdJibReh2JqnIo0FCAS0vVJl+zwZU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bGQD8GN5Q/PA53u6vbre1QaBOYR/hyFkO0aLsOXI3xDjj2eDRh0OXvxr4549dIZdF
         +L43/KuF8H47yhGcfi095TeJ64zc0VFarjlOBwb8nsQRTpXS0XCEbJb+KR8sP4Psdb
         lsyOgb75QVeGh+kchVXtoYt1sg0/mpdn8E1OePBQ=
Message-ID: <edf2c4fd-985c-48aa-9476-e6248ca8aba3@linux.microsoft.com>
Date:   Tue, 10 Oct 2023 09:32:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5] iommu/arm-smmu-v3: Avoid constructing invalid range
 commands
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Rui Zhu <zhurui3@huawei.com>, Will Deacon <will@kernel.org>
References: <20231005193425.656925-1-eahariha@linux.microsoft.com>
 <ZSARLoAx_mPkrG8f@sashalap>
Content-Language: en-US
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <ZSARLoAx_mPkrG8f@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/6/23 06:52, Sasha Levin wrote:
<snip>
> Queued this and the ones for older kernels. In general, if it's just a
> cherrypick, please just list commit ids as it makes our lives much
> easier :)
> 

Will do for next time. :)

-- 
Thanks,
Easwar

