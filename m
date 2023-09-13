Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267EF79E1AD
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 10:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbjIMILM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 04:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbjIMILF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 04:11:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374C219A7
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 01:11:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FC5C433C9;
        Wed, 13 Sep 2023 08:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694592660;
        bh=cg+WWG8RtF6KxSWA1DTAzKeZhIuV4osQy0b+PdMiuj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2E58EBr7G5LbBu3shdoNq2V5XECpErF2Mdrb1R23Ku4OBYCKVh41vf/0CAXAJ3OOT
         /gjxW/bp/cbGckoyx238vWvCmICQPm2G741r2ONZvy3wbaoyDrPPjYfIbb6xbdzAw8
         9wy5WfrJ4+I+s44nhzmNzqatPLe1jbY7/+6bLCd8=
Date:   Wed, 13 Sep 2023 10:10:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Quan Tian <qtian@vmware.com>
Cc:     stable@vger.kernel.org
Subject: Re: IPv6 traffic distribution problem with OVS group on 6.5
Message-ID: <2023091347-aspirin-lilac-6536@gregkh>
References: <20230913065407.GA510095@bm02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913065407.GA510095@bm02>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 13, 2023 at 06:54:07AM +0000, Quan Tian wrote:
> Hi,
> 
> We found that OVS group always selected the same bucket for different L4
> flows between two given IPv6 addresses on 6.5. It was because commit
> e069ba07e6c7 ("net: openvswitch: add support for l4 symmetric hashing")
> introduced support for symmetric hashing and used the flow dissector,
> which had a problem that it didn't incorporate transport ports when
> flow label is present in IPv6 header. The bug is fixed by this commit:
> 
> a5e2151ff9d5 ("net/ipv6: SKB symmetric hash should incorporate transport ports")
> 
> Could you please backport it to 6.5.y?
> 
> Issue: https://github.com/antrea-io/antrea/issues/5457

Sure, now queued up.

greg k-h
