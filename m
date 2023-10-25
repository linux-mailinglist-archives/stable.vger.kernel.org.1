Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846E67D7397
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 20:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJYSwa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJYSw3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 14:52:29 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3A4111
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 11:52:26 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id AFE56240029
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 20:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1698259944; bh=ItgiJHIVx2mBskg0NAe/jPDHFLXrZa6DQMucl9pTiNI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:
         Content-Transfer-Encoding:From;
        b=A5qYt9rrvozXiD3b5+hW91vMDFAMQlw6/xBbnLG5nCg+xcmTZLEXIPBUhhkVqEsVC
         5chXN4aLuN/mGEIWLaGjFc6bHVuaF3mSJqgDRsQ3vx8b96U0f+rRTtG/Icx/UIGqaq
         SPZHKfFFrGgVCm/uq0gLdeXbWIQ1yB8qMm+nRcSpGJokOUGMqq7AwyMv4HAhdPUkVq
         kiY2bguy6PNrkWT5yEIyaja2hCCSL8XNHne6DwvJ1TBPwty9UICn81/ebA7B8mymTt
         O3gjLaV0la7iUK7QwQbu6pVT2m6omH8QW5gtpNTB+D9qpKzUtF2bfsAp0hnfdOZJZi
         ZSKsLOGH8CWEg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SFyj33b2Hz6tw1;
        Wed, 25 Oct 2023 20:52:23 +0200 (CEST)
Message-ID: <06af7e06-6e8b-4d00-9512-57a2ae52ef56@posteo.net>
Date:   Wed, 25 Oct 2023 18:52:14 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 6.1 043/131] can: isotp: isotp_sendmsg(): fix TX state
 detection and wait behavior
Content-Language: en-US
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     patches@lists.linux.dev,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        Michal Sojka <michal.sojka@cvut.cz>
References: <20231016084000.050926073@linuxfoundation.org>
 <20231016084001.142952122@linuxfoundation.org>
 <b4a1bdc2-54f8-428a-a82a-0308a4bc7f92@hartkopp.net>
From:   Lukas Magel <lukas.magel@posteo.net>
In-Reply-To: <b4a1bdc2-54f8-428a-a82a-0308a4bc7f92@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 24.10.23 20:34, Oliver Hartkopp wrote:
> Hello Lukas, hello Greg,
>
> this patch fixed the issue introduced with
>
> 79e19fa79cb5 ("can: isotp: isotp_ops: fix poll() to not report false 
> EPOLLOUT events")
>
> for Linux 6.1 and Linux 6.5 which is fine.
>
> Unfortunately the problematic patch has also been applied to 5.15 and 
> 5.10 (referencing another upstream commit as it needed a backport).
>
> @Lukas: The 5.x code is much more similar to the latest code, so would 
> it probably fix the issue to remove the "wq_has_sleeper(&so->wait)" 
> condition?

Yes, the condition is causing the culprit. With the poll patch you mentioned
above, the queue now contains all pollers, even if they're only interested
in reading. So it's not a valid indication of send readiness anymore.

> @Greg: I double checked the changes and fixes from the latest 6.6 kernel 
> compared to the 5.10 when isotp.c was introduced in the mainline kernel.
> Would it be ok, to "backport" the latest 6.6 code to the 5.x LTS trees?
> It really is the same isotp code but only some kernel API functions and 
> names have been changed.
>
> Best regards,
> Oliver
>
> On 16.10.23 10:40, Greg Kroah-Hartman wrote:
>> 6.1-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Lukas Magel <lukas.magel@posteo.net>
>>
>> [ Upstream commit d9c2ba65e651467de739324d978b04ed8729f483 ]
>>
>> With patch [1], isotp_poll was updated to also queue the poller in the
>> so->wait queue, which is used for send state changes. Since the queue
>> now also contains polling tasks that are not interested in sending, the
>> queue fill state can no longer be used as an indication of send
>> readiness. As a consequence, nonblocking writes can lead to a race and
>> lock-up of the socket if there is a second task polling the socket in
>> parallel.
>>
>> With this patch, isotp_sendmsg does not consult wq_has_sleepers but
>> instead tries to atomically set so->tx.state and waits on so->wait if it
>> is unable to do so. This behavior is in alignment with isotp_poll, which
>> also checks so->tx.state to determine send readiness.
>>
>> V2:
>> - Revert direct exit to goto err_event_drop
>>
>> [1] https://lore.kernel.org/all/20230331125511.372783-1-michal.sojka@cvut.cz
>>
>> Reported-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>
>> Closes: https://lore.kernel.org/linux-can/11328958-453f-447f-9af8-3b5824dfb041@munic.io/
>> Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
>> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Fixes: 79e19fa79cb5 ("can: isotp: isotp_ops: fix poll() to not report false EPOLLOUT events")
>> Link: https://github.com/pylessard/python-udsoncan/issues/178#issuecomment-1743786590
>> Link: https://lore.kernel.org/all/20230827092205.7908-1-lukas.magel@posteo.net
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>   net/can/isotp.c | 19 ++++++++-----------
>>   1 file changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 8c97f4061ffd7..545889935d39c 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -925,21 +925,18 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
>>   		return -EADDRNOTAVAIL;
>>   
>> -wait_free_buffer:
>> -	/* we do not support multiple buffers - for now */
>> -	if (wq_has_sleeper(&so->wait) && (msg->msg_flags & MSG_DONTWAIT))
>> -		return -EAGAIN;
>> +	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
>> +		/* we do not support multiple buffers - for now */
>> +		if (msg->msg_flags & MSG_DONTWAIT)
>> +			return -EAGAIN;
>>   
>> -	/* wait for complete transmission of current pdu */
>> -	err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
>> -	if (err)
>> -		goto err_event_drop;
>> -
>> -	if (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) != ISOTP_IDLE) {
>>   		if (so->tx.state == ISOTP_SHUTDOWN)
>>   			return -EADDRNOTAVAIL;
>>   
>> -		goto wait_free_buffer;
>> +		/* wait for complete transmission of current pdu */
>> +		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
>> +		if (err)
>> +			goto err_event_drop;
>>   	}
>>   
>>   	if (!size || size > MAX_MSG_LENGTH) {
