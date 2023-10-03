Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318F87B6E41
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 18:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbjJCQUq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjJCQUo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 12:20:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3CAD
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 09:20:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF38AC433B9;
        Tue,  3 Oct 2023 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696350041;
        bh=7vBpobL0gE9swS2gSEU3uHkjdghkdf5UvA5yS1Wq/DI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIEpH9ayRBLJsY8FWIsKg+OzlP02UZChJuFQtAzzVES7p07ldEX2TNssbG9oGCLrR
         hOfrcGXZqMiAitHvRTqYYrMAZIzsCR1KiOjoZTeO+qmtdzjJTJ943u/iPrGqR1m/Lo
         X6UopBDLgqNshfQVVJRI8aDDO16HaAkV3DUDYneQ5LUBrzdXEbiPylVqfNN4PqAJQE
         0RiwpjiSdItTVn5euSt1dXCququIMpHpeZXO2rAYD19SYhLITFOm0aHvqumq3ZBWut
         8bIMzcLRaKieUxY2p8FXWIJIEql21J3p0lt2/7sYM6hwkKtm9KIbJHNshYVlnkq6TP
         fQNWhSBygzlXQ==
Date:   Tue, 3 Oct 2023 12:20:40 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     stable@vger.kernel.org
Subject: Re: Backport commit dad651b2a44e ("nvme-pci: do not set the NUMA
 node of device if it has none")
Message-ID: <ZRw/WJmJYJTofxPS@sashalap>
References: <mafs0il7porz6.fsf@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <mafs0il7porz6.fsf@amazon.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 02, 2023 at 07:26:53PM +0200, Pratyush Yadav wrote:
>
>Hi,
>
>Please backport commit dad651b2a44e ("nvme-pci: do not set the NUMA node
>of device if it has none") to stable branches 6.1, 5.15, 5.10, 5.4,
>4.19, and 4.14. The commit fixes a4aea5623d4a ("NVMe: Convert to
>blk-mq") which was introduced in v3.19 but I forgot to add this when
>sending the patch.

Now backported, thanks!

-- 
Thanks,
Sasha
