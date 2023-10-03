Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F037B67EF
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 13:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbjJCLcL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 07:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJCLcL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 07:32:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21E9AC
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 04:32:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629D4C433C7;
        Tue,  3 Oct 2023 11:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696332727;
        bh=OGwq27LTj7Oy+cBhVN/1WZEZWRZCxDDQD5PcEN14QIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kLebFgzGrTr4/8aTdNh/KleJe9RjblfKXL5L6HmI/CXE+7zGaEB1MOqEli2tMqDgP
         2g9gJY2zpaVavQe5FXigUiW2ZxlcZbArj+drh7rcJ+jtg8NC/xRCcXSeB5MLxDFXIt
         cIVvh35b9SNYJxfeJ9f7mQ895sq9EC0TivpibPsPaqC3OIECv441yDpXE9/F0XGT7W
         9l4dGVGd+SkHfr51DHcf9++gQBimt05ahXmOh/bUhPSy/bHvTqDW/GxohhzdXz9Rit
         +9/ssryFnclBnhZAU6cuWypXGC+DuRoLOoli89bSJFMsczvj5Irwlft2SzwSo7NBZp
         JSZKX23vKVONA==
Date:   Tue, 3 Oct 2023 07:32:05 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     ovidiu.panait@windriver.com
Cc:     stable@vger.kernel.org, qyousef@layalina.io
Subject: Re: [PATCH 5.10 0/4] cgroup: Fix suspicious rcu_dereference_check()
 warning
Message-ID: <ZRv7tW8/+g3JTOnS@sashalap>
References: <20230929131418.821640-1-ovidiu.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230929131418.821640-1-ovidiu.panait@windriver.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 29, 2023 at 04:14:14PM +0300, ovidiu.panait@windriver.com wrote:
>Backport commit f2aa197e4794 ("cgroup: Fix suspicious rcu_dereference_check()
>usage warning") and its dependencies to get rid of this warning.
>
>Andrey Ryabinin (1):
>  sched/cpuacct: Fix user/system in shown cpuacct.usage*
>
>Chengming Zhou (3):
>  sched/cpuacct: Fix charge percpu cpuusage
>  sched/cpuacct: Optimize away RCU read lock
>  cgroup: Fix suspicious rcu_dereference_check() usage warning

I've queued up this and the 5.15 fix, thanks!

-- 
Thanks,
Sasha
