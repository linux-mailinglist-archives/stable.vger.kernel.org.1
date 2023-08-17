Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D405577F762
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 15:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349998AbjHQNMS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 09:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351371AbjHQNL6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 09:11:58 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FD530F1
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 06:11:20 -0700 (PDT)
Received: from [192.168.1.152] (unknown [222.129.36.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 754EC3F161;
        Thu, 17 Aug 2023 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692277808;
        bh=ZOFc641//xjZbzZJp1nLBtreufTaSDvxCbK9eKVutvg=;
        h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
         In-Reply-To:Content-Type;
        b=WBwk4JIIulgpRZzERpVDR36OcOC7HqYgqAI61kNL0arckTYXzn+nX6sd4FTAqYaca
         UhxdtU75bS7ugAWZD8eqOYX05kuhGDz21V3iYu/WBKA5EYc2hxWZgM/nIHcLPsBE8q
         9iT7YqxhNhY3OrYRw3qEoLFBbT38jPRAhkdv83Pyvl2x7JSi3Mrjn1eAFDFeBEmjjd
         nsF9aA9M734/OYvFNMlavD6RDfIsC4iH9WPZIShwFsvn2BFYK1e0w/2Hn1rYNyPGYo
         s9JGE96Md+fIxkJnyUTyoLO82f9bSnwDKJBt9VuJOTC/Gr7m3fB9g6m4om+sIgkZRX
         4dMcgO1WUYSuQ==
Message-ID: <838aac7d-dbbd-5a04-7c25-344d8e0512b5@canonical.com>
Date:   Thu, 17 Aug 2023 21:10:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     anshuman.gupta@intel.com
Cc:     intel-gfx@lists.freedesktop.org, jianshui.yu@intel.com,
        lidong.wang@intel.com, rodrigo.vivi@intel.com,
        stable@vger.kernel.org
References: <20230816125216.1722002-1-anshuman.gupta@intel.com>
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915/dgfx: Enable d3cold at s2idle
Content-Language: en-US
From:   Aaron Ma <aaron.ma@canonical.com>
In-Reply-To: <20230816125216.1722002-1-anshuman.gupta@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Tested-by: Aaron Ma <aaron.ma@canonical.com>
