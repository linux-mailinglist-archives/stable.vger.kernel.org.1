Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABDD7DCD7A
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 14:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344400AbjJaNA4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 09:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344448AbjJaNAu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 09:00:50 -0400
X-Greylist: delayed 2399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 06:00:46 PDT
Received: from 14.mo583.mail-out.ovh.net (14.mo583.mail-out.ovh.net [188.165.51.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FF8DB
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 06:00:45 -0700 (PDT)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.108.4.136])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id E27EA286DD
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 11:42:18 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-rsqbf (unknown [10.110.103.49])
        by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 03A651FEB0;
        Tue, 31 Oct 2023 11:42:17 +0000 (UTC)
Received: from RCM-web9.webmail.mail.ovh.net ([151.80.29.21])
        by ghost-submission-6684bf9d7b-rsqbf with ESMTPSA
        id xNv7ORnoQGUrvQAA/A58uA
        (envelope-from <jose.pekkarinen@foxhound.fi>); Tue, 31 Oct 2023 11:42:17 +0000
MIME-Version: 1.0
Date:   Tue, 31 Oct 2023 13:42:17 +0200
From:   =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, skhan@linuxfoundation.org,
        dillon.varone@amd.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, samson.tam@amd.com,
        SyedSaaem.Rizvi@amd.com, aurabindo.pillai@amd.com,
        stable@vger.kernel.org, daniel@ffwll.ch, george.shen@amd.com,
        alexander.deucher@amd.com, Jun.Lei@amd.com, airlied@gmail.com,
        christian.koenig@amd.com
Subject: Re: [PATCH] drm/amd/display: remove redundant check
In-Reply-To: <2023103115-obstruct-smudgy-6cc6@gregkh>
References: <20231030171748.35482-1-jose.pekkarinen@foxhound.fi>
 <2023103115-obstruct-smudgy-6cc6@gregkh>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <3ab58c1e48447798d7525e7d2f42f1a2@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 185.220.101.158
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16724680167312303623
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddtvddgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihoihgtgfesthekjhdttderjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeetveejleefudduueehfedvjeekteevhefhtdffkedvffegieejgeettdeuueeiteenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucfkphepuddvjedrtddrtddruddpudekhedrvddvtddruddtuddrudehkedpudehuddrkedtrddvledrvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeefpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023-10-31 07:48, Greg KH wrote:
> On Mon, Oct 30, 2023 at 07:17:48PM +0200, José Pekkarinen wrote:
>> This patch addresses the following warning spotted by
>> using coccinelle where the case checked does the same
>> than the else case.
>> 
>> drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c:4664:8-10: 
>> WARNING: possible condition with no effect (if == else)
>> 
>> Fixes: 974ce181 ("drm/amd/display: Add check for PState change in 
>> DCN32")
>> 
>> Cc: stable@vger.kernel.org
> 
> Why is this relevant for stable?

     Hi,

     I was asked to send it for stable because this code
looks different in amd-staging-drm-next, see here.

https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c#L4661

     Feel free to let me know if this is wrong, or if I
need to review some other guidelines I may have missed.

     Thanks!

     José.
