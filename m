Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0837C9ECE
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 07:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjJPFcu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 01:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjJPFcu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 01:32:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD21DE0
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 22:32:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C2C36732A; Mon, 16 Oct 2023 07:32:43 +0200 (CEST)
Date:   Mon, 16 Oct 2023 07:32:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] nvme: remove unprivileged passthrough support
Message-ID: <20231016053242.GA25813@lst.de>
References: <CGME20231014090724epcas5p443807b5d724c97645a8a85fc627bf1ad@epcas5p4.samsung.com> <20231014090108.128809-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014090108.128809-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(with the Fixes tag fixes up as per the comment from Greg)
