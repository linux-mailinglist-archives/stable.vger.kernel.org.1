Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E8735D2B
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjFSRxP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 13:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjFSRxO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 13:53:14 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3216B7
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:53:13 -0700 (PDT)
Received: from [192.168.1.10] (c-71-231-176-209.hsd1.wa.comcast.net [71.231.176.209])
        by linux.microsoft.com (Postfix) with ESMTPSA id F34B5210DD9F;
        Mon, 19 Jun 2023 10:53:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F34B5210DD9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687197193;
        bh=bTtXuXFas6dkXf443EZvX7LsPdVkWX72i3pwxkkNJcM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=anP/crFupYCAOVM6YvvuiTjC9eDLEwVgE7SH+PXi6qWxPPU9f6ZJaMW3knG2GYon5
         bD5kSimTO16DKjpXH7w+8gZ1/ytqi+hUPPIxt168JzutV4GCTs31RJJqaP2naPfUnB
         H3tImxx9fvPF83ZJbXmEbf70WXjdjy7z561xs85g=
Message-ID: <1f8ce040-ce1e-f8f3-9a52-4f9c0f61e726@linux.microsoft.com>
Date:   Mon, 19 Jun 2023 10:53:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: backport d8e45bf1aed2 (selftests/mount_setattr: fix redefine
 struct mount_attr build error)
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, code@tyhicks.com
References: <5f49c8bc-1eb7-be99-a1a8-7d7e0e87ad1b@linux.microsoft.com>
 <2023061929-landfill-speculate-1885@gregkh>
From:   Hardik Garg <hargar@linux.microsoft.com>
In-Reply-To: <2023061929-landfill-speculate-1885@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

I apologize for the mistake. I'm not getting this error with v6.3
Please backport it to v6.1 and v5.15


Thanks,
Hardik

On 6/18/2023 11:24 PM, Greg KH wrote:
> On Wed, Jun 14, 2023 at 01:28:25PM -0700, Hardik Garg wrote:
>> commit d8e45bf1aed2 upstream.
>> (selftests/mount_setattr: fix redefine struct mount_attr build error)
>> Backport this commit from v6.2.0-rc5 to v6.3, v6.1, and v5.15 to resolve
>> the struct redefinition error:
> 6.3 obviously already has this commit in it, so how are you seeing an
> error there?
>
> confused,
>
> greg k-h


