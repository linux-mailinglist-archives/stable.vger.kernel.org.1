Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7F6741804
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 20:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjF1Sa3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 14:30:29 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:34600 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjF1Sa1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 14:30:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A96F361423
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 18:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3F5C433C8;
        Wed, 28 Jun 2023 18:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687977026;
        bh=PmtejHBVnsfKbfKOpRegpS/0lrIXPAcjAXYUgPxOXCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHE2hIRaL4PxVWCgHPpbKDQVJMjxIerbjmZVGjS09c9S9WsaVJ+Vz08CtatFrb6Hk
         z6uA+XbHdMQM0/RosA7Lg+ZKIxW0eayf7uacAsM6nh0qqGfnC1uLx0z2FoxvtxVyq6
         zczZHJLHM+vXEGU6R63jLZDxZhKXDswNZYc86q3Y=
Date:   Wed, 28 Jun 2023 20:30:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     stable@vger.kernel.org, tony.luck@intel.com,
        dan.j.williams@intel.com, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, glider@google.com
Subject: Re: [5.15/6.1-stable PATCH] Copy-on-write hwpoison recovery
Message-ID: <2023062803-expulsion-shrubs-4b49@gregkh>
References: <20230626230221.3064291-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626230221.3064291-1-jane.chu@oracle.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 26, 2023 at 05:02:17PM -0600, Jane Chu wrote:
> I was able to reproduce crash on 5.15.y kernel during COW, and
> when the grandchild process attempts a write to a private page
> inherited from the child process and the private page contains
> a memory uncorrectable error. The way to reproduce is described
> in Tony's patch, using his ras-tools/einj_mem_uc.
> And the patch series fixed the panic issue in 5.15.y.
> 
> Followed here is the backport of Tony patch series to stable 5.15
> and stable 6.1. Both backport have encountered trivial conflicts
> due to missing dependencies, details are provided in each patch.
> 
> Please let me know whether the backport is acceptable.

Looks good to me, all now queued up, thanks!

greg k-h
