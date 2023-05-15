Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C80A702C8E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 14:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbjEOMTi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 08:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241720AbjEOMTf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 08:19:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF0FE65
        for <stable@vger.kernel.org>; Mon, 15 May 2023 05:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE178616F1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 12:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A1FC433EF;
        Mon, 15 May 2023 12:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684153167;
        bh=3sTvE30ZXijou4Sp4owZIrzUSzAXpQHCepPCnCwXXp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LyP461EY6Ihcf3LXnaePLgN6ShpmshXJlv6TzQ0GSECmS1X5mlV4t4rVcIYJo4LHs
         +bt6Rd+o3g3STzeyNsM9StkCCmvhqkKKIjwrbmgV5REsTGl/ecV24Q0XRiDRzrUbPz
         YXE/s+DlNXs5z6A6pPJbbc49JN4pM8R84wqU6j38=
Date:   Mon, 15 May 2023 14:19:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-stable <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        TRINH-THAI Florent <florent.trinh-thai@csgroup.eu>
Subject: Re: v4.14 : Can you apply 78c855835478 ("perf bench: Share some
 global variables to fix build with gcc 10")
Message-ID: <2023051519-conducive-unfiled-661c@gregkh>
References: <bae53ad4-66e2-3ab4-dc40-54a82a1f6e2a@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bae53ad4-66e2-3ab4-dc40-54a82a1f6e2a@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, May 14, 2023 at 08:27:18AM +0000, Christophe Leroy wrote:
> Hi,
> 
> Could you please apply on v4.14 commit 78c855835478 ("perf bench: Share 
> some global variables to fix build with gcc 10") from v4.19.
> 
> Upstream commit is e4d9b04b973b ("perf bench: Share some global 
> variables to fix build with gcc 10")

Now queued up, thanks.

greg k-h
