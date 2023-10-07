Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE17BC688
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 11:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjJGJth (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 05:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjJGJtg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 05:49:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC27B9
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 02:49:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8E7C433C8;
        Sat,  7 Oct 2023 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696672176;
        bh=GJnSZJfZx7gWWj7RAGg1zKgT9oXk9Ew05QaNj1CzEhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWfhInmqHEsUTPBDQmOxzEXpfZU9rmzM8nNdcr9aXUprfl0vE1DEQm+rGlhvdWOyv
         1Vni88RSMaQlgPS8SAdf2PY0Pqk5OxftzzD7shDR9D4oIfdU6XxnSN1b7eVCOcP1Ha
         Hz219SbTZIKyoU1+2SW8TVGxXZ9Gz4B2UdbNU/bk=
Date:   Sat, 7 Oct 2023 11:49:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     stable@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6.1.y] arm64: cpufeature: Fix CLRBHB and BC detection
Message-ID: <2023100725-exterior-childless-425b@gregkh>
References: <2023100424-cheer-freeness-471f@gregkh>
 <20231006154953.3853617-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006154953.3853617-1-kristina.martsenko@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 06, 2023 at 04:49:53PM +0100, Kristina Martsenko wrote:
> [ Upstream commit 479965a2b7ec481737df0cadf553331063b9c343 ]

Now queued up, thanks.

greg k-h
