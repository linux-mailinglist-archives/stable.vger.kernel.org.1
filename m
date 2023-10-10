Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA2B7BFFCE
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 16:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjJJOy7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 10:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjJJOy6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 10:54:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704A9AC
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 07:54:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EB7C433C7;
        Tue, 10 Oct 2023 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696949697;
        bh=+dWa28SUL71+6q+6idT3MEKxjdPxnsJMhxPykvCZZio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OR103+WJ/uGhVTp2h4dwLDSw+Mu5Lomxu7bXBteZP0jbEMFruivcUGRawLomiWzn7
         HZHreBS6PbnNvxyHOnx7K6sP55+rBRwViIun5mcP/ZUW0nBHpz/E3eO+34D2pA9OpX
         jRqro4D1sgX2Qc4pOV/NbciPuqIVP91kBiZQR6/w=
Date:   Tue, 10 Oct 2023 16:54:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?546L5b6B?= <zyytlz.wz@163.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 407/600] media: mtk-jpeg: Fix use after free bug due
 to uncanceled work
Message-ID: <2023101047-pumice-diligent-a08d@gregkh>
References: <20230911134633.619970489@linuxfoundation.org>
 <20230911134645.689607572@linuxfoundation.org>
 <5f19d638.6fa5.18b19f1d4fd.Coremail.zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f19d638.6fa5.18b19f1d4fd.Coremail.zyytlz.wz@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 10, 2023 at 10:16:01PM +0800, 王征 wrote:
> 
> Hi,
> 
> Sorry to bother you for I didn't know how to submit patch to a specific branch.
> Could you please push this patch to 5.10 branch? The chrome-os is affcted by this issue.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
