Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F2B6F8EB5
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 07:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjEFFkX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 01:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFFkW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 01:40:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B4A7D9E
        for <stable@vger.kernel.org>; Fri,  5 May 2023 22:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dFEzHDIu+qBSXPc+L1/bWITnShE9xROgVs7GLl3cwXg=; b=YsrPgbIv0vhEzPJpUgMbE8rLHn
        zof3DFrUiQ8t+yBWtUo1RrJFFsA7HPTmkMO40nAh0WTvt1AM/QhD1+l60qNDsi/ilppjntazIhG64
        XwVvQjzVeRBVcW9g7eoV4fl0agOEcrIiMpMu+GFNt0f6NcnS6b3DoBczqe2PBR+BoPyqlKVEsHqex
        tjtZpbpSMDFxzOjldcmzMdRHF5+FlERSgFJTE4iykR5fu2B7OumKVzbz52WWwi6WrR7S7tR/t3mYx
        OIwnEKuxfdE6mKpcr+ddNIhrSkoYTMamaBN3Q18NdSoSnNP7Rbr61+MxY5AJZLj4wP2C+17QXDM47
        O9q+hSXw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pvAeU-00CbC9-26;
        Sat, 06 May 2023 05:40:14 +0000
Message-ID: <36efe6f3-009c-e849-f9d7-6a643edad8e0@infradead.org>
Date:   Fri, 5 May 2023 22:40:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        kernel test robot <lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: patch for 5.10.stable (sound/oss/dmasound)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Please apply

commit 9dd7c46346ca
Author: Randy Dunlap <rdunlap@infradead.org>
Date:   Tue Apr 5 16:41:18 2022 -0700

    sound/oss/dmasound: fix build when drivers are mixed =y/=m

to the 5.10 stable tree. The kernel test robot <lkp@intel.com> reported a build
error on 5.10.y and this patch fixes the build error.

-- 
~Randy
