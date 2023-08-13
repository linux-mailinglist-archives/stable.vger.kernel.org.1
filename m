Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34F377AB2E
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 22:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjHMU04 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 16:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHMU0z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 16:26:55 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EF3113
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 13:26:57 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-790f831c6fbso174542639f.2
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691958416; x=1692563216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/MXjXeloGTA8ELAcXglO6rfFop6c2jjTE5eeqZv+Gg=;
        b=iHXOLtWY9mkaz1rTXhajDUaRU1WFjk57PVAzhgJKOQrz/KoirO0RQt+DqZdrKsD1Rt
         cViXGLgX7mymhTlMiPsNkMv4EhfSf5tK8v31tHBEXpf28u6TIodUy/4dAZs0F5YKTZRQ
         UfPtfZ8QxTwEAgMRVLsnHKKIlIRaZGq3XtIq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691958416; x=1692563216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/MXjXeloGTA8ELAcXglO6rfFop6c2jjTE5eeqZv+Gg=;
        b=CA7eM6fByGimc/u8fiikslQLVvH8SwteV5bSSq9HoqFqeYwvAxtb7q5COo4IP5W6Qk
         P5S51DlKbVpM2zfWbTCkJB+74XGjq3IdcTG/+PwMYVfGNx9b/MchGcVbjzGef4cK+I9f
         0ELlMmN1QiY+Fiez3DHfO7DPVPIA6YIe6OLPqfw2IT5dsuwPIIeRdGcrM5oBcU+X8fJp
         Tn23vku6ozQVcFR7anZgHqE9Ebigt5SaPCcwWssibV4vab1070JSC7qK/fSxHJ1JEDE6
         KPiO8MqGOsdtPxaJyHxODj9dOFxiRk42Mq/5W/ZOPfnZH1oOSAW4Y0CEAQ0aZOra8SqF
         m0Aw==
X-Gm-Message-State: AOJu0YwEAzQP4faufBA09R9BZylPDs3FMseL/n/9vYLv2zBOc0tY7SiR
        jvSOtmSiUxG6UzgztvtsF8rImkVzmhVtdkICIog=
X-Google-Smtp-Source: AGHT+IFUYkqhXsiVzGqbFtulrHCSDvzACly5k9KkOs9cX9TO49OPczeEwry/cKDvSpeMGeC4rYW4tA==
X-Received: by 2002:a6b:fd0b:0:b0:786:25cf:421f with SMTP id c11-20020a6bfd0b000000b0078625cf421fmr10675302ioi.19.1691958416062;
        Sun, 13 Aug 2023 13:26:56 -0700 (PDT)
Received: from localhost (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id n3-20020a02cc03000000b0042b08954dc3sm2429232jap.33.2023.08.13.13.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 13:26:55 -0700 (PDT)
Date:   Sun, 13 Aug 2023 20:26:55 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5.15 2/3] timers/nohz: Switch to ONESHOT_STOPPED in the
 low-res handler when the tick is stopped
Message-ID: <20230813202655.GB675119@google.com>
References: <20230813031620.2218302-1-joel@joelfernandes.org>
 <20230813031620.2218302-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813031620.2218302-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Aug 13, 2023 at 03:16:19AM +0000, Joel Fernandes (Google) wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> [ Upstream commit 5417ddc1cf1f5c8cba31ab217cf57ada7ab6ea88 ]

I have the wrong SHA here, it should be: 62c1256d544747b38e77ca9b5bfe3a26f9592576

If you don't mind correcting it, please go ahead. Or I can resend the patch
in the future.

thanks,

 - Joel



> 
> When tick_nohz_stop_tick() stops the tick and high resolution timers are
> disabled, then the clock event device is not put into ONESHOT_STOPPED
> mode. This can lead to spurious timer interrupts with some clock event
> device drivers that don't shut down entirely after firing.
> 
> Eliminate these by putting the device into ONESHOT_STOPPED mode at points
> where it is not being reprogrammed. When there are no timers active, then
> tick_program_event() with KTIME_MAX can be used to stop the device. When
> there is a timer active, the device can be stopped at the next tick (any
> new timer added by timers will reprogram the tick).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20220422141446.915024-1-npiggin@gmail.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/time/tick-sched.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 7701c720dc1f..5786e2794ae1 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -950,6 +950,8 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  	if (unlikely(expires == KTIME_MAX)) {
>  		if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
>  			hrtimer_cancel(&ts->sched_timer);
> +		else
> +			tick_program_event(KTIME_MAX, 1);
>  		return;
>  	}
>  
> @@ -1356,9 +1358,15 @@ static void tick_nohz_handler(struct clock_event_device *dev)
>  	tick_sched_do_timer(ts, now);
>  	tick_sched_handle(ts, regs);
>  
> -	/* No need to reprogram if we are running tickless  */
> -	if (unlikely(ts->tick_stopped))
> +	if (unlikely(ts->tick_stopped)) {
> +		/*
> +		 * The clockevent device is not reprogrammed, so change the
> +		 * clock event device to ONESHOT_STOPPED to avoid spurious
> +		 * interrupts on devices which might not be truly one shot.
> +		 */
> +		tick_program_event(KTIME_MAX, 1);
>  		return;
> +	}
>  
>  	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
>  	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
> -- 
> 2.41.0.640.ga95def55d0-goog
> 
