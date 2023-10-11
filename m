Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9176F7C4A78
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 08:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344315AbjJKGYP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 02:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345684AbjJKGYG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 02:24:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA19E93
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 23:24:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF239C433C8;
        Wed, 11 Oct 2023 06:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697005444;
        bh=fEPjuTq/5LdPMhqJydoRTXlWKJlEVMfLdjKxcfvI2o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=La3F8Cne7HJchBfHsMGiXqkBo+TTL2HRBxwqG6++DJkMfinCEJyIEMWdjykl/9JY0
         6eDOtEwEsEWYiBH6eSovRo0VD/FiN14fVLJgBTgUkKQnzkFS8uMacYekwnBse7gZH/
         f7bvtYVtKnqMJsa5I+BjuaOFJqp6EhaVFs7GOxBQ=
Date:   Wed, 11 Oct 2023 08:24:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        gfs2@lists.linux.dev, christophe.jaillet@wanadoo.fr,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND 1/8] fs: dlm: Simplify buffer size computation in
 dlm_create_debug_file()
Message-ID: <2023101151-culminate-guidance-8823@gregkh>
References: <20231010220448.2978176-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010220448.2978176-1-aahringo@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 10, 2023 at 06:04:41PM -0400, Alexander Aring wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Use sizeof(name) instead of the equivalent, but hard coded,
> DLM_LOCKSPACE_LEN + 8.
> 
> This is less verbose and more future proof.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/debug_fs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
