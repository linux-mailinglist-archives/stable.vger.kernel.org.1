Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36B797717
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbjIGQVW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241872AbjIGQVE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 12:21:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96416A55
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 09:17:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C7AC4AF6C;
        Thu,  7 Sep 2023 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694098805;
        bh=rVx1j7Ld77a2/avNN0CXdbhj3VFJHwTNAUWNhlgg0xY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXunPGnPAO1DIAgy5L8TPbDhK83LE0HLOQ4EJ4Cjs6bV+iMIsC62RBr9dbhCzZ0Yu
         8JdgAgR4FVn8bwoxkLIw14IGkqviesZRqmSDK9ietbRPKDkEz0zC03NVr5i0Udm3Ml
         pHB6lLd70mn78dHedJajwpTnzpWKG5dsKKyZDY5Q=
Date:   Thu, 7 Sep 2023 16:00:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vladislav Efanov <VEfanov@ispras.ru>
Cc:     stable@vger.kernel.org, Jan Kara <jack@suse.com>,
        lvc-project@linuxtesting.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 5.10/5.15/6.1 1/1] udf: Check consistency of Space Bitmap
 Descriptor
Message-ID: <2023090755-gloomy-amnesty-1951@gregkh>
References: <20230905120837.836080-1-VEfanov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905120837.836080-1-VEfanov@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 05, 2023 at 03:08:36PM +0300, Vladislav Efanov wrote:
> From: Vladislav Efanov <VEfanov@ispras.ru>
> 
> commit 1e0d4adf17e7ef03281d7b16555e7c1508c8ed2d upstream

All now queued up, thanks.

greg k-h
