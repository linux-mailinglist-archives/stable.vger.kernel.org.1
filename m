Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61957BB9D2
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjJFNzJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 09:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjJFNzJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 09:55:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD95D83
        for <stable@vger.kernel.org>; Fri,  6 Oct 2023 06:55:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35307C433C8;
        Fri,  6 Oct 2023 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696600508;
        bh=vnyWRKmmQuJbi1kCAUfP/uEng106aaLJHidrgE3TiYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXYR7l1PY1di0oKsHfIbcK5ZC7isUuF27YYiDxhxblc9znWn/k99heekEwvUZ+5wZ
         8MPSKw6NMthgrDjbpcY9O9pn1OF7yHx2BLLdqMlaQ2bjWLf/byMMQiRGl9umFXPfqY
         IveLkwfjIYlq6p6oPpu/Ih7AeWaZA014XidiPUCQINPVvQel8t0MVWw9pGH+f4QmLd
         f47svOa1BhU3fEQraKvO5rt6jG/idxuodgTGWkO09XgdJJ6oEeyuw06NXbqflYWnz/
         8YStRBireZDMA7kBKG0v1BoBGhXi1jCLQ+pxbbfa0q9yyfnEfYopBIYdGdhGqZ/kPS
         YEL2JN5w6/tMA==
Date:   Fri, 6 Oct 2023 09:55:07 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [PATCH for 5.10-6.1 0/4] rbd: fix a deadlock around header_rwsem
 and lock_rwsem
Message-ID: <ZSARu1_1Wy0YY4n8@sashalap>
References: <20231005095937.317188-1-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231005095937.317188-1-idryomov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 05, 2023 at 11:59:31AM +0200, Ilya Dryomov wrote:
>Hello,
>
>Patch 1/4 needed a trivial adjustment, the rest were taken verbatim and
>included here just for convenience.

Queued up, thanks!

-- 
Thanks,
Sasha
