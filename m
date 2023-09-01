Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547A878FF6D
	for <lists+stable@lfdr.de>; Fri,  1 Sep 2023 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbjIAOqE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 1 Sep 2023 10:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjIAOqD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 1 Sep 2023 10:46:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658C618C
        for <stable@vger.kernel.org>; Fri,  1 Sep 2023 07:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7232FCE223A
        for <stable@vger.kernel.org>; Fri,  1 Sep 2023 14:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A259C433C7;
        Fri,  1 Sep 2023 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693579556;
        bh=fHjow/WvUbfNkCkvz2bMa0XT3GQibJuyW+vSz+Li4fY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFbMIu5gdrCnPboulPiG7l8r7tCTP5eBWyhSQ83+gMW6pQJMWB/pdFVZDgLvgtvii
         PSS+5EOaWAFSEgK2qMCURXqDAf0B8G0Ac+7UXXoBg0Su/XXWDtoLIT+LO7/S/qQiRS
         IZA7U7upKJS6v3yUKp/AyYXgBX8Y6Agv8MR+BH+OASGNE2+mKivpMnonQ/wjYcGT33
         FSIp5BtbJ4w6esUdhSYWYOCkUGF00q9FXfBoc/TFTbA0+X1ZwjF/UgKAvM5pG8WgwP
         1yuNO5twePVxt1r+vVVBIbJg0kWGLyp5dZhbyqxAJVinz1SNI7k26Vpi8CMsNf5IKp
         cTpyyPmUc5fqQ==
Date:   Fri, 1 Sep 2023 10:45:50 -0400
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v2 1/2] nvme: fix memory corruption for passthrough
 metadata
Message-ID: <ZPH5Hjsqntn7tBCh@kbusch-mbp>
References: <20230814070213.161033-1-joshi.k@samsung.com>
 <CGME20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9@epcas5p3.samsung.com>
 <20230814070213.161033-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814070213.161033-2-joshi.k@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Aug 14, 2023 at 12:32:12PM +0530, Kanchan Joshi wrote:
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

What if the user doesn't specify metadata or length for a command that
uses it? The driver won't set MPTR in that case, causing the device to
access NULL.

And similiar to this problem, what if the metadata is extended rather
than separate, and the user's buffer is too short? That will lead to the
same type of problem you're trying to fix here?

My main concern, though, is forward and backward compatibility. Even
when metadata is enabled, there are IO commands that don't touch it, so
some tool that erroneously requested it will stop working. Or perhaps
some other future opcode will have some other metadata use that doesn't
match up exactly with how read/write/compare/append use it. As much as
I'd like to avoid bad user commands from crashing, these kinds of checks
can become problematic for maintenance. I realize we already do similiar
sanity checks in nvme_submit_io(), but that one is confined to only 3
opcodes where this interface you're changing is much more flexible.
