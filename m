Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E987267FC
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 20:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjFGSKE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 14:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFGSKD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 14:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E7910EA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 11:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA0B9639B7
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 18:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E369C433EF;
        Wed,  7 Jun 2023 18:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686161401;
        bh=ZUqFxmEXUYn3eqTyeIL/Q06URXbUeFvH+H9PnC+fYF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BRTVSmlqRfua+TJro2x+onBMw56jsBNsYpkg1EEj9P2aF1ieOSbemeFJeDfhJe5Yw
         qxYWyKdwhMqDx6zynfDsK8xNhzOF3xUx17LGTfQo8W/yO9jmelHKpYtSyB0c2ts3Ke
         BJjD+Zc9cnXeyf3Wzj40+rbsJ3oxI6UkRH1yhDRo=
Date:   Wed, 7 Jun 2023 20:09:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     stable@vger.kernel.org, holger.philipps@siemens.com,
        wagner.dominik@siemens.com,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Matt Roper <matthew.d.roper@intel.com>,
        Clinton Taylor <Clinton.A.Taylor@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 5.10 1/2] drm/i915/dg1: Wait for pcode/uncore handshake
 at startup
Message-ID: <2023060719-seminar-patrol-68d8@gregkh>
References: <20230602160507.2057-1-henning.schild@siemens.com>
 <20230602160507.2057-2-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230602160507.2057-2-henning.schild@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 02, 2023 at 06:05:06PM +0200, Henning Schild wrote:
> From: Matt Roper <matthew.d.roper@intel.com>
> 
> From: Matt Roper <matthew.d.roper@intel.com>

Twice?

> 
> [ Upstream commit f9c730ede7d3f40900cb493890d94d868ff2f00f ]
> 
> DG1 does some additional pcode/uncore handshaking at
> boot time; this handshaking must complete before various other pcode
> commands are effective and before general work is submitted to the GPU.
> We need to poll a new pcode mailbox during startup until it reports that
> this handshaking is complete.
> 
> The bspec doesn't give guidance on how long we may need to wait for this
> handshaking to complete.  For now, let's just set a really long timeout;
> if we still don't get a completion status by the end of that timeout,
> we'll just continue on and hope for the best.
> 
> v2 (Lucas): Rename macros to make clear the relation between command and
>    result (requested by José)
> 
> Bspec: 52065
> Cc: Clinton Taylor <Clinton.A.Taylor@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
> Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20201001063917.3133475-2-lucas.demarchi@intel.com

You also need to sign-off on a patch you submit for inclusion anywhere,
right?

Please resend this series with that added so that we can queue them up.

thanks,

greg k-h
