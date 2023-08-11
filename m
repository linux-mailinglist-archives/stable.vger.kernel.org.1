Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F0877955F
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 18:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbjHKQ5m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 12:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbjHKQ5k (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 12:57:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72A530CA
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 09:57:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B3696113A
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 16:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AC7C433C7;
        Fri, 11 Aug 2023 16:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773058;
        bh=h9uqWymXuU3DRYBhWzUCgG2mYSZvxOo3nA+b+2GK+h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FYnzX0Ibz5WpuqMhmcjUJCFlEACcaZ880I6AWS/7Cf4cVjqsUoo4vPCTp/7XEas7D
         M/zsyBsn0//cjeWuOJzy50Pdi16xG7IX42NI2DeGNVLW8CBBr3Xayzh8zAKCWpzhLK
         ukPfr9GnNFnaPc4w8EZnqlcxAK9kR/b6Bp5J7vqB74dFVssHIsI5A3jP3GCPpPVLYm
         fSlRvntEZiGTLHXV8yenkVLfqO80RVS8zyUGhJu19C39qPtiP4r5qUeJT/HOOLYWpj
         zvfkUAZBQnhKLH7pNgZThh3vQhWWXptgBSULAP1mp6Oyr42d0e6gSBhU6ujW1pTsGF
         MqSl6+rL3OlYw==
Date:   Fri, 11 Aug 2023 10:57:36 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH 1/2] nvme: fix memory corruption for passthrough metadata
Message-ID: <ZNZogPZtHsxi1S10@kbusch-mbp.dhcp.thefacebook.com>
References: <20230811155906.15883-1-joshi.k@samsung.com>
 <CGME20230811160454epcas5p2635d208557749a2431b99c27b30a727f@epcas5p2.samsung.com>
 <20230811155906.15883-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811155906.15883-2-joshi.k@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 11, 2023 at 09:29:05PM +0530, Kanchan Joshi wrote:
> +static bool nvme_validate_passthru_meta(struct nvme_ctrl *ctrl,
> +					struct nvme_ns *ns,
> +					struct nvme_command *c,
> +					__u64 meta, __u32 meta_len)
> +{
> +	/*
> +	 * User may specify smaller meta-buffer with a larger data-buffer.
> +	 * Driver allocated meta buffer will also be small.
> +	 * Device can do larger dma into that, overwriting unrelated kernel
> +	 * memory.
> +	 */
> +	if (ns && (meta_len || meta)) {
> +		u16 nlb = lower_16_bits(le32_to_cpu(c->common.cdw12));
> +
> +		if (meta_len != (nlb + 1) * ns->ms) {
> +			dev_err(ctrl->device,
> +			"%s: metadata length does not match!\n", current->comm);
> +			return false;
> +		}

Don't you need to check the command PRINFO PRACT bit to know if metadata
length is striped/generated on the controller side?
