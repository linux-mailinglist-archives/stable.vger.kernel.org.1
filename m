Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA83F72E64F
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 16:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbjFMOwO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 10:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242778AbjFMOwM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 10:52:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628D519B4;
        Tue, 13 Jun 2023 07:52:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q95NH-0003cx-GU; Tue, 13 Jun 2023 16:51:59 +0200
Message-ID: <977dae31-7963-d3f5-7612-6f7761b03507@leemhuis.info>
Date:   Tue, 13 Jun 2023 16:51:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] usb: typec: ucsi: Fix command cancellation
Content-Language: en-US, de-DE
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, Stephan Bolten <stephan.bolten@gmx.net>,
        stable@vger.kernel.org
References: <20230606115802.79339-1-heikki.krogerus@linux.intel.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230606115802.79339-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686667927;be62bf67;
X-HE-SMSGID: 1q95NH-0003cx-GU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 06.06.23 13:58, Heikki Krogerus wrote:
> The Cancel command was passed to the write callback as the
> offset instead of as the actual command which caused NULL
> pointer dereference.
> 
> Reported-by: Stephan Bolten <stephan.bolten@gmx.net>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217517
> Fixes: 094902bc6a3c ("usb: typec: ucsi: Always cancel the command if PPM reports BUSY condition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Gentle reminder that this made no progress for a week now. Or was there
and I just missed it? Then apologies in advance.

I'm asking, as it afaics would be nice to have this (or some other fix
for the regression linked above) mainlined before the next -rc. That
would be ideal, as then it can get at least one week of testing before
the final is released.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

>  drivers/usb/typec/ucsi/ucsi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 2b472ec01dc42..b664ecbb798be 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -132,10 +132,8 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
>  	if (ret)
>  		return ret;
>  
> -	if (cci & UCSI_CCI_BUSY) {
> -		ucsi->ops->async_write(ucsi, UCSI_CANCEL, NULL, 0);
> -		return -EBUSY;
> -	}
> +	if (cmd != UCSI_CANCEL && cci & UCSI_CCI_BUSY)
> +		return ucsi_exec_command(ucsi, UCSI_CANCEL);
>  
>  	if (!(cci & UCSI_CCI_COMMAND_COMPLETE))
>  		return -EIO;
> @@ -149,6 +147,11 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
>  		return ucsi_read_error(ucsi);
>  	}
>  
> +	if (cmd == UCSI_CANCEL && cci & UCSI_CCI_CANCEL_COMPLETE) {
> +		ret = ucsi_acknowledge_command(ucsi);
> +		return ret ? ret : -EBUSY;
> +	}
> +
>  	return UCSI_CCI_LENGTH(cci);
>  }
>  
