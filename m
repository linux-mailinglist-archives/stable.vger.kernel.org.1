Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30767BC71F
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjJGLbo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 07:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjJGLbn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 07:31:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8423FB6
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 04:31:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7707C433C8;
        Sat,  7 Oct 2023 11:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696678302;
        bh=4XG/Jk5F5eQTuTEMbx16/JO24WDdsumuVcBOxLnFDXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozKhFJMLXT68tWpHyAf4UWo0hsbR7Y/Db2doMRa/KD58kfxcVGKSbyNHNdlrLYVL7
         dd/RPfqYc5fRRuIYgGDdnazTFPFvP/y6tvdrkduHXsO4ZeQRJBn1Z/r4uDkkjBt+gD
         J37PzSzn1eDJZDpmW8I9HeDkTE5q1x/vRQxc/ypU=
Date:   Sat, 7 Oct 2023 13:31:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     stable@vger.kernel.org, Pedro Falcato <pedro.falcato@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.5.y 1/3] maple_tree: add mas_is_active() to detect
 in-tree walks
Message-ID: <2023100728-anything-shorts-1f39@gregkh>
References: <2023100439-obtuse-unchain-b580@gregkh>
 <20231005195900.252077-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005195900.252077-1-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 05, 2023 at 03:58:58PM -0400, Liam R. Howlett wrote:
> Patch series "maple_tree: Fix mas_prev() state regression".

All now queued up, thanks.

greg k-h
