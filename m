Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DE57356BF
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 14:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjFSMYN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 08:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjFSMYK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 08:24:10 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF4910FF
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 05:23:18 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1a994308bc6so3071404fac.3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 05:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1687177386; x=1689769386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UkQqZRyyBhQpAoqZ1L8EBmb33zpnEFe5K5vBzlnLf+o=;
        b=XX/hMb+oBv1s6gdE/bu5v23UP4j59P/WzyQTI3/JLkc7nZsM44oj4QUXxXRLKC4vpC
         aqczKhgYQYDyyR2qhdpW2wpNBsm3oP2GOxfdJD97uj4aTuTZMkpLkyC0fZTyYBdUNxsb
         diZ0z/oxUa1S2k8NFIv1NucXkmXCgyg3jdKvjP1bOcNS5+KnKVoUiSQWKAwGcOEkFnci
         4pjuMW83OdQLiGgOFwm/ZNn3SzuoKqVkN9rSho+xu/IGFZi1andKr4CqAfejXJ1Y0Dcf
         eQVBEBF7fqmzM2ta5ooyEUIk8LNPjn15VBKWS0TqHJw528H9ZkYouCII6ZJlIxdvFE+r
         U+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687177386; x=1689769386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkQqZRyyBhQpAoqZ1L8EBmb33zpnEFe5K5vBzlnLf+o=;
        b=fXQIKSd2V8iRvvT2JdCCp67ggzWuahvjKHy/u5QIBOHhlR8hpgcq59d7TKvlgFZ7Hv
         VNt+d1SUHY6CP7LhWk/wdsv1s3XSxWVU4w7pAc6Lo5A0sRg+rkFl4bfF3+1vhHUFlMiX
         CDlCYuaesmX1PcJfeyxwBs7QqL7OA4mPX7m7h6IXX++hTLsvfn6VWSB5ueWpvQ5217p1
         wcMP5HZDkyjdq/7WM05RQQid58V7wpxXvLaXj9gT78kzFQUcMJGYfj1ghdFUUcl1H9Bd
         mobxHckrkMZUBCzjKNmkMR1Agzzh7ylTVhP0xjk6CJMEEXII4/WFdUq7O3DH576lZ6Bu
         YTzA==
X-Gm-Message-State: AC+VfDxyz9tQNr0O8rQfcVOcgu3oyRWMUyUpVK2gbsBBZuhITDXRGUqk
        fCW69dwwRNeClgRoLf2x7mOXQaKlfpjhb5dRJic=
X-Google-Smtp-Source: ACHHUZ457KvapYW7r4k12aUtgeM3KkLsBFRhqmwe00jrSwr7ilt9zJhP8TjJFwOoLCmngUw9K/nyAQ==
X-Received: by 2002:a05:6870:c342:b0:1aa:25d0:1a84 with SMTP id e2-20020a056870c34200b001aa25d01a84mr1734862oak.57.1687177385739;
        Mon, 19 Jun 2023 05:23:05 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:52f8:9134:8ce7:1f0d? ([2804:14d:5c5e:44fb:52f8:9134:8ce7:1f0d])
        by smtp.gmail.com with ESMTPSA id e1-20020a9d63c1000000b006aafe381a12sm10330909otl.48.2023.06.19.05.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 05:23:05 -0700 (PDT)
Message-ID: <ecd5cd8c-66f8-0775-d509-32313bb4e70e@mojatatu.com>
Date:   Mon, 19 Jun 2023 09:23:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Patch "net/sched: act_api: move TCA_EXT_WARN_MSG to the correct
 hierarchy" has been added to the 6.1-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, davem@davemloft.net, jhs@mojatatu.com,
        simon.horman@corigine.com
Cc:     stable@vger.kernel.org
References: <2023061951-existing-canned-81a5@gregkh>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <2023061951-existing-canned-81a5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 19/06/2023 03:52, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>      net/sched: act_api: move TCA_EXT_WARN_MSG to the correct hierarchy
> 
> to the 6.1-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       net-sched-act_api-move-tca_ext_warn_msg-to-the-correct-hierarchy.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
>  From 923b2e30dc9cd05931da0f64e2e23d040865c035 Mon Sep 17 00:00:00 2001
> From: Pedro Tammela <pctammela@mojatatu.com>
> Date: Fri, 24 Feb 2023 14:56:01 -0300
> Subject: net/sched: act_api: move TCA_EXT_WARN_MSG to the correct hierarchy
> 
> From: Pedro Tammela <pctammela@mojatatu.com>
> 
> commit 923b2e30dc9cd05931da0f64e2e23d040865c035 upstream.
> 
> TCA_EXT_WARN_MSG is currently sitting outside of the expected hierarchy
> for the tc actions code. It should sit within TCA_ACT_TAB.
> 
> Fixes: 0349b8779cc9 ("sched: add new attr TCA_EXT_WARN_MSG to report tc extact message")
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   net/sched/act_api.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1603,12 +1603,12 @@ static int tca_get_fill(struct sk_buff *
>   	if (tcf_action_dump(skb, actions, bind, ref, false) < 0)
>   		goto out_nlmsg_trim;
>   
> -	nla_nest_end(skb, nest);
> -
>   	if (extack && extack->_msg &&
>   	    nla_put_string(skb, TCA_EXT_WARN_MSG, extack->_msg))
>   		goto out_nlmsg_trim;
>   
> +	nla_nest_end(skb, nest);
> +
>   	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
>   
>   	return skb->len;
> 

Hi!
This commit is bogus. The correct one to pull is:
2f59823fe696 ("net/sched: act_api: add specific EXT_WARN_MSG for tc action")
If it's already in the queue then just removing this one is enough.

Thanks,
Pedro

