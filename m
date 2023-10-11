Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF37C4A7B
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 08:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344357AbjJKGYg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 02:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344210AbjJKGYf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 02:24:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B18E93
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 23:24:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255B6C433C7;
        Wed, 11 Oct 2023 06:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697005473;
        bh=2T6r6qpJcF0cqjXxOmrf8eKHVmrObSQHPiYsA1oCCMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBNO1xa7qa6/vbkQyCz4q7lR6HnMIol0IA1SUUUM4rI9Hef25dTXJ4QRhD19uzA3M
         jyS5ZfXtQ4nx2dAR+3+36sSw/xZJNnzSxGjXSzZ8cjXHFcfnrgYCSa17R7PQaWllGQ
         zJ0tghqcZdKSkIVDZJnWseYOfwZlQzKGMgMGXcX8=
Date:   Wed, 11 Oct 2023 08:24:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        gfs2@lists.linux.dev, christophe.jaillet@wanadoo.fr,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND 2/8] fs: dlm: Fix the size of a buffer in
 dlm_create_debug_file()
Message-ID: <2023101124-overlying-gating-62c8@gregkh>
References: <20231010220448.2978176-1-aahringo@redhat.com>
 <20231010220448.2978176-2-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010220448.2978176-2-aahringo@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 10, 2023 at 06:04:42PM -0400, Alexander Aring wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> 8 is not the maximum size of the suffix used when creating debugfs files.
> 
> Let the compiler compute the correct size, and only give a hint about the
> longest possible string that is used.
> 
> When building with W=1, this fixes the following warnings:
> 
>   fs/dlm/debug_fs.c: In function ‘dlm_create_debug_file’:
>   fs/dlm/debug_fs.c:1020:58: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
>    1020 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls->ls_name);
>         |                                                          ^
>   fs/dlm/debug_fs.c:1020:9: note: ‘snprintf’ output between 9 and 73 bytes into a destination of size 72
>    1020 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_waiters", ls->ls_name);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   fs/dlm/debug_fs.c:1031:50: error: ‘_queued_asts’ directive output may be truncated writing 12 bytes into a region of size between 8 and 72 [-Werror=format-truncation=]
>    1031 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts", ls->ls_name);
>         |                                                  ^~~~~~~~~~~~
>   fs/dlm/debug_fs.c:1031:9: note: ‘snprintf’ output between 13 and 77 bytes into a destination of size 72
>    1031 |         snprintf(name, DLM_LOCKSPACE_LEN + 8, "%s_queued_asts", ls->ls_name);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 541adb0d4d10b ("fs: dlm: debugfs for queued callbacks")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/dlm/debug_fs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
> index e9726c6cbdf2..c93359ceaae6 100644
> --- a/fs/dlm/debug_fs.c
> +++ b/fs/dlm/debug_fs.c
> @@ -973,7 +973,8 @@ void dlm_delete_debug_comms_file(void *ctx)
>  
>  void dlm_create_debug_file(struct dlm_ls *ls)
>  {
> -	char name[DLM_LOCKSPACE_LEN + 8];
> +	/* Reserve enough space for the longest file name */
> +	char name[DLM_LOCKSPACE_LEN + sizeof("_queued_asts")];
>  
>  	/* format 1 */
>  
> -- 
> 2.39.3
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
