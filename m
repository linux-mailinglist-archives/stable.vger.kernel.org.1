Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AE17B6BB9
	for <lists+stable@lfdr.de>; Tue,  3 Oct 2023 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbjJCOev (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 3 Oct 2023 10:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjJCOev (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Oct 2023 10:34:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33496B0
        for <stable@vger.kernel.org>; Tue,  3 Oct 2023 07:34:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A95C433C8;
        Tue,  3 Oct 2023 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696343687;
        bh=D3JHpbuUCsOPCV2/Kb8gL0Xp3qFkbADEWPSvE7cDcFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CsN5Yq+OBWTY57OCo7MXg9a79vV07FR0Zcnz/xaLUM/UwZNKIkQY1q1j9+Fy4j59R
         xWkkVeb5CuVkZZ+1hltxiCElnEXtUonqGJcsLb4zbnekw3nAaR2Eiu+k03P5Ib38/t
         SiAPoFF3f+snBIefeoy9fKh8LpcpKHENGsAYRxdinjp73fWPwzbmUelbceDtkuVAXc
         8eS8eqtIWszZYyc5/ZXkXxLU7eXtM5y9lRHzVH8hpwybchZCpnWUxF3661v0TDY8Q+
         tu01g1zFJ0nxXihMD8oknPEutZTC07dm4qIoIlQsaQMkbbyxwfItG/i7yAdqtOCoHh
         8o4Im3mWwqgDQ==
Date:   Tue, 3 Oct 2023 16:34:44 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v1] ice: fix over-shifted variable
Message-ID: <ZRwmhINftLVQ8EnU@kernel.org>
References: <20231003053110.3872424-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003053110.3872424-1-jesse.brandeburg@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 02, 2023 at 10:31:10PM -0700, Jesse Brandeburg wrote:
> Since the introduction of the ice driver the code has been
> double-shifting the RSS enabling field, because the define already has
> shifts in it and can't have the regular pattern of "a << shiftval &
> mask" applied.
> 
> Most places in the code got it right, but one line was still wrong. Fix
> this one location for easy backports to stable. An in-progress patch
> fixes the defines to "standard" and will be applied as part of the
> regular -next process sometime after this one.
> 
> Fixes: d76a60ba7afb ("ice: Add support for VLANs and offloads")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> CC: stable@vger.kernel.org
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

