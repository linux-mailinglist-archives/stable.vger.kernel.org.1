Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F30797747
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 18:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjIGQYI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 12:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242886AbjIGQWz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 12:22:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5B59EC1
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 09:20:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D75C116D4;
        Thu,  7 Sep 2023 11:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694086037;
        bh=e+9qa6M/dTtZ1dNCdvp+v5IEGyPLkIJIM5U5qWZ1C5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BWC/i64rvdTg/rBaQS/hSkh501w42vQQQosmo/zwIDVxs9YWRnDbH1yZASgCX8/vO
         FWQgGW7pq9ktKdCY2/xeDoyG9ulKVHkrpilb2XfcnAI1Jw6oK8yYBIzmfRS6DZZoNt
         zAYZw4S4smUlGPdI6+9DJLup9nF7DTxCbQbBQfbE=
Date:   Thu, 7 Sep 2023 12:27:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jordan Rife <jrife@google.com>
Cc:     stable@vger.kernel.org, dborkman@kernel.org
Subject: Re: [PATCH] net: Avoid address overwrite in kernel_connect
Message-ID: <2023090743-cheek-zebra-a175@gregkh>
References: <20230905235846.142217-1-jrife@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905235846.142217-1-jrife@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 05, 2023 at 06:58:46PM -0500, Jordan Rife wrote:
> commit 0bdf399 upstream.

Nit, next time use more sha1 characters, the kernel documentation shows
how many we usually rely on.

> This fix applies to all stable kernel versions 4.19+.

Why not also 4.14?

Anyway, now queued up, thanks.

greg k-h
