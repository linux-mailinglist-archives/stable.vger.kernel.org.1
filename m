Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492977B9F88
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 16:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjJEOZZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 10:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbjJEOXe (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 10:23:34 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D457872B6
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 00:09:01 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <othacehe@gnu.org>)
        id 1qoITg-0000nt-9U; Thu, 05 Oct 2023 03:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:In-Reply-To:Date:References:Subject:To:
        From; bh=UUC64N097MJfnR+lCTJttIUWSXlBARthl8jYpHO7RvE=; b=fcyIqWILndOAUUmqPu6F
        0zEYjihd1tHCSeP/YrWyOK93qfuCJ3QUmbk1/zC2iTIo38W6r8X9AKTMkAWi3inENBjTUFTbyYGlB
        WtWMCkr6h6H1xzAN++H/eg6BopEqAxcvXN8xVcXy1CwigMJHk6RxrOHEmfOQtoMySoHeFTYkR7DUP
        bJNX05jtwECp/xBaXzX2tzF/xX3SndZCNGH17VQcPMA41KMPUj9zeJLiNe2hdR/keNuGNNxZEoroJ
        agy+Yz6Z7e0hWHa2VGIXu0Vg0aX2uXZLp0REM0k3ZvrQNxYGolvvlDx61fEDIbs6idyuaq/amAa1p
        NgMdyID5E6o9KQ==;
From:   Mathieu Othacehe <othacehe@gnu.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, jack@suse.cz,
        Marcus Hoffmann <marcus.hoffmann@othermo.de>, tytso@mit.edu,
        famzah@icdsoft.com, gregkh@linuxfoundation.org,
        anton.reding@landisgyr.com
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
References: <871qeau3sd.fsf@gnu.org> <ZR06COwVo7bEfP/5@sashalap>
Date:   Thu, 05 Oct 2023 09:08:50 +0200
In-Reply-To: <ZR06COwVo7bEfP/5@sashalap> (Sasha Levin's message of "Wed, 4 Oct
        2023 06:10:16 -0400")
Message-ID: <87wmw1v94t.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


Hello,

> Backporting the series would be ideal. Is this only for the 5.15 kernel?

OK. I spotted it on a 5.15 but as far as I understand, this affects all
stables with 5c48a7df9149, i.e all stables. Is that correct Jan?

Mathieu
