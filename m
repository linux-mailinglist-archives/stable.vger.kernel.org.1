Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331357419F2
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 22:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjF1U70 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 16:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjF1U7Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 16:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C72F19B0
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 13:59:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4B5061467
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 20:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5E3C433C8;
        Wed, 28 Jun 2023 20:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687985964;
        bh=268wM+miOtbHzesFJqGulFJ5OyYug6qB6rPqiW9YoLU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kPPPe1cfJMGqhi/vyBh+K0owLAs735YaFlrv2pmMJj480m12deFoOlsE5Z5kAgYbd
         P9nXH4jOjxE+NW3MWnCVLJMyAIo98BC1tiIsBcf4hHahgGYsT61YJ0PolVTScUQUWC
         EO6heteS4+3oYi3JL2/4UMKYtDp/vWMTS8K+3oiapIVtJyAckoFyGgE9SHnSa0lUgv
         THHAgg3drNPqYmbx8+UeqXgz/nU/+ThoUfR0ImyfTLZR2kbEmS0OT2Of5KmESvLBjv
         z8XomYvTpfEA0aelk1XOALPv2HU9mqzGoE1hMh4H8oUHFtaewvW3x+IyDTNCzyX8S5
         xCo+sN9fewowQ==
Date:   Wed, 28 Jun 2023 13:59:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Louis Peens <louis.peens@corigine.com>
Cc:     David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Yinjun Zhang <yinjun.zhang@corigine.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        oss-drivers@corigine.com
Subject: Re: [PATCH net] nfp: clean mc addresses in application firmware
 when driver exits
Message-ID: <20230628135922.2e01db94@kernel.org>
In-Reply-To: <20230628093228.12388-1-louis.peens@corigine.com>
References: <20230628093228.12388-1-louis.peens@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 28 Jun 2023 11:32:28 +0200 Louis Peens wrote:
> The configured mc addresses are not removed from application firmware
> when driver exits. This will cause resource leak when repeatedly
> creating and destroying VFs.

I think the justification is somewhat questionable, too.
VF is by definition not trusted. Does FLR not clean up the resources?
