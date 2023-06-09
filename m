Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D110172A2B3
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjFIS7G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 9 Jun 2023 14:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFIS7F (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Jun 2023 14:59:05 -0400
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Jun 2023 11:59:02 PDT
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BB535B3
        for <stable@vger.kernel.org>; Fri,  9 Jun 2023 11:59:02 -0700 (PDT)
Received: by sole.flsd.net (Postfix, from userid 1003)
        id 499A195DF71; Fri,  9 Jun 2023 21:51:50 +0300 (MSK)
Date:   Fri, 9 Jun 2023 21:51:50 +0300
From:   Your Name <you@example.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 076/124] tcp: convert elligible sysctls to u8
Message-ID: <20230609185150.kwpdc3fefcfeviny@sole.flsd.net>
References: <20230418120309.539243408@linuxfoundation.org>
 <20230418120312.629258550@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418120312.629258550@linuxfoundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greg,

On Tue, Apr 18, 2023 at 02:21:35PM +0200, Greg Kroah-Hartman wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 4ecc1baf362c5df2dcabe242511e38ee28486545 ]
> 
> Many tcp sysctls are either bools or small ints that can fit into u8.
> 
> Reducing space taken by sysctls can save few cache line misses
> when sending/receiving data while cpu caches are empty,
> for example after cpu idle period.
> 
> This is hard to measure with typical network performance tests,
> but after this patch, struct netns_ipv4 has shrunk
> by three cache lines.

This commit in 5.10 needs fix from d24f511b04b8 ("tcp: fix
tcp_min_tso_segs sysctl") which have incorrectly set commit id in Fixes
tag. (Perhaps, that's why it's missed.)

      Fixes: 47996b489bdc ("tcp: convert elligible sysctls to u8")

Thanks,

> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Stable-dep-of: dc5110c2d959 ("tcp: restrict net.ipv4.tcp_app_win")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/net/netns/ipv4.h   |  68 +++++++++----------
>  net/ipv4/sysctl_net_ipv4.c | 136 ++++++++++++++++++-------------------
>  2 files changed, 102 insertions(+), 102 deletions(-)
> 
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 92e3d8fe954ab..d8b320cf54ba0 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -114,11 +114,11 @@ struct netns_ipv4 {
>  	u8 sysctl_nexthop_compat_mode;
>  
>  	u8 sysctl_fwmark_reflect;
> -	int sysctl_tcp_fwmark_accept;
> +	u8 sysctl_tcp_fwmark_accept;
>  #ifdef CONFIG_NET_L3_MASTER_DEV
> -	int sysctl_tcp_l3mdev_accept;
> +	u8 sysctl_tcp_l3mdev_accept;
>  #endif
> -	int sysctl_tcp_mtu_probing;
> +	u8 sysctl_tcp_mtu_probing;
>  	int sysctl_tcp_mtu_probe_floor;
>  	int sysctl_tcp_base_mss;
>  	int sysctl_tcp_min_snd_mss;
> @@ -126,46 +126,47 @@ struct netns_ipv4 {
>  	u32 sysctl_tcp_probe_interval;
>  
>  	int sysctl_tcp_keepalive_time;
> -	int sysctl_tcp_keepalive_probes;
>  	int sysctl_tcp_keepalive_intvl;
> +	u8 sysctl_tcp_keepalive_probes;
>  
> -	int sysctl_tcp_syn_retries;
> -	int sysctl_tcp_synack_retries;
> -	int sysctl_tcp_syncookies;
> +	u8 sysctl_tcp_syn_retries;
> +	u8 sysctl_tcp_synack_retries;
> +	u8 sysctl_tcp_syncookies;
>  	int sysctl_tcp_reordering;
> -	int sysctl_tcp_retries1;
> -	int sysctl_tcp_retries2;
> -	int sysctl_tcp_orphan_retries;
> +	u8 sysctl_tcp_retries1;
> +	u8 sysctl_tcp_retries2;
> +	u8 sysctl_tcp_orphan_retries;
> +	u8 sysctl_tcp_tw_reuse;
>  	int sysctl_tcp_fin_timeout;
>  	unsigned int sysctl_tcp_notsent_lowat;
> -	int sysctl_tcp_tw_reuse;
> -	int sysctl_tcp_sack;
> -	int sysctl_tcp_window_scaling;
> -	int sysctl_tcp_timestamps;
> -	int sysctl_tcp_early_retrans;
> -	int sysctl_tcp_recovery;
> -	int sysctl_tcp_thin_linear_timeouts;
> -	int sysctl_tcp_slow_start_after_idle;
> -	int sysctl_tcp_retrans_collapse;
> -	int sysctl_tcp_stdurg;
> -	int sysctl_tcp_rfc1337;
> -	int sysctl_tcp_abort_on_overflow;
> -	int sysctl_tcp_fack;
> +	u8 sysctl_tcp_sack;
> +	u8 sysctl_tcp_window_scaling;
> +	u8 sysctl_tcp_timestamps;
> +	u8 sysctl_tcp_early_retrans;
> +	u8 sysctl_tcp_recovery;
> +	u8 sysctl_tcp_thin_linear_timeouts;
> +	u8 sysctl_tcp_slow_start_after_idle;
> +	u8 sysctl_tcp_retrans_collapse;
> +	u8 sysctl_tcp_stdurg;
> +	u8 sysctl_tcp_rfc1337;
> +	u8 sysctl_tcp_abort_on_overflow;
> +	u8 sysctl_tcp_fack; /* obsolete */
>  	int sysctl_tcp_max_reordering;
> -	int sysctl_tcp_dsack;
> -	int sysctl_tcp_app_win;
>  	int sysctl_tcp_adv_win_scale;
> -	int sysctl_tcp_frto;
> -	int sysctl_tcp_nometrics_save;
> -	int sysctl_tcp_no_ssthresh_metrics_save;
> -	int sysctl_tcp_moderate_rcvbuf;
> -	int sysctl_tcp_tso_win_divisor;
> -	int sysctl_tcp_workaround_signed_windows;
> +	u8 sysctl_tcp_dsack;
> +	u8 sysctl_tcp_app_win;
> +	u8 sysctl_tcp_frto;
> +	u8 sysctl_tcp_nometrics_save;
> +	u8 sysctl_tcp_no_ssthresh_metrics_save;
> +	u8 sysctl_tcp_moderate_rcvbuf;
> +	u8 sysctl_tcp_tso_win_divisor;
> +	u8 sysctl_tcp_workaround_signed_windows;
>  	int sysctl_tcp_limit_output_bytes;
>  	int sysctl_tcp_challenge_ack_limit;
> -	int sysctl_tcp_min_tso_segs;
>  	int sysctl_tcp_min_rtt_wlen;
> -	int sysctl_tcp_autocorking;
> +	u8 sysctl_tcp_min_tso_segs;
> +	u8 sysctl_tcp_autocorking;
> +	u8 sysctl_tcp_reflect_tos;
>  	int sysctl_tcp_invalid_ratelimit;
>  	int sysctl_tcp_pacing_ss_ratio;
>  	int sysctl_tcp_pacing_ca_ratio;
> @@ -183,7 +184,6 @@ struct netns_ipv4 {
>  	unsigned int sysctl_tcp_fastopen_blackhole_timeout;
>  	atomic_t tfo_active_disable_times;
>  	unsigned long tfo_active_disable_stamp;
> -	int sysctl_tcp_reflect_tos;
>  
>  	int sysctl_udp_wmem_min;
>  	int sysctl_udp_rmem_min;
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index cb587bdd683a6..1a2506f795d4e 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -720,17 +720,17 @@ static struct ctl_table ipv4_net_table[] = {
>  	{
>  		.procname	= "tcp_fwmark_accept",
>  		.data		= &init_net.ipv4.sysctl_tcp_fwmark_accept,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  #ifdef CONFIG_NET_L3_MASTER_DEV
>  	{
>  		.procname	= "tcp_l3mdev_accept",
>  		.data		= &init_net.ipv4.sysctl_tcp_l3mdev_accept,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_dou8vec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> @@ -738,9 +738,9 @@ static struct ctl_table ipv4_net_table[] = {
>  	{
>  		.procname	= "tcp_mtu_probing",
>  		.data		= &init_net.ipv4.sysctl_tcp_mtu_probing,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_base_mss",
> @@ -842,9 +842,9 @@ static struct ctl_table ipv4_net_table[] = {
>  	{
>  		.procname	= "tcp_keepalive_probes",
>  		.data		= &init_net.ipv4.sysctl_tcp_keepalive_probes,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_keepalive_intvl",
> @@ -856,26 +856,26 @@ static struct ctl_table ipv4_net_table[] = {
>  	{
>  		.procname	= "tcp_syn_retries",
>  		.data		= &init_net.ipv4.sysctl_tcp_syn_retries,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_dou8vec_minmax,
>  		.extra1		= &tcp_syn_retries_min,
>  		.extra2		= &tcp_syn_retries_max
>  	},
>  	{
>  		.procname	= "tcp_synack_retries",
>  		.data		= &init_net.ipv4.sysctl_tcp_synack_retries,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  #ifdef CONFIG_SYN_COOKIES
>  	{
>  		.procname	= "tcp_syncookies",
>  		.data		= &init_net.ipv4.sysctl_tcp_syncookies,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  #endif
>  	{
> @@ -888,24 +888,24 @@ static struct ctl_table ipv4_net_table[] = {
>  	{
>  		.procname	= "tcp_retries1",
>  		.data		= &init_net.ipv4.sysctl_tcp_retries1,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_dou8vec_minmax,
>  		.extra2		= &tcp_retr1_max
>  	},
>  	{
>  		.procname	= "tcp_retries2",
>  		.data		= &init_net.ipv4.sysctl_tcp_retries2,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_orphan_retries",
>  		.data		= &init_net.ipv4.sysctl_tcp_orphan_retries,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_fin_timeout",
> @@ -924,9 +924,9 @@ static struct ctl_table ipv4_net_table[] = {
>  	{
>  		.procname	= "tcp_tw_reuse",
>  		.data		= &init_net.ipv4.sysctl_tcp_tw_reuse,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_dou8vec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= &two,
>  	},
> @@ -1012,88 +1012,88 @@ static struct ctl_table ipv4_net_table[] = {
>  	{
>  		.procname	= "tcp_sack",
>  		.data		= &init_net.ipv4.sysctl_tcp_sack,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_window_scaling",
>  		.data		= &init_net.ipv4.sysctl_tcp_window_scaling,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_timestamps",
>  		.data		= &init_net.ipv4.sysctl_tcp_timestamps,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_early_retrans",
>  		.data		= &init_net.ipv4.sysctl_tcp_early_retrans,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_dou8vec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= &four,
>  	},
>  	{
>  		.procname	= "tcp_recovery",
>  		.data		= &init_net.ipv4.sysctl_tcp_recovery,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname       = "tcp_thin_linear_timeouts",
>  		.data           = &init_net.ipv4.sysctl_tcp_thin_linear_timeouts,
> -		.maxlen         = sizeof(int),
> +		.maxlen         = sizeof(u8),
>  		.mode           = 0644,
> -		.proc_handler   = proc_dointvec
> +		.proc_handler   = proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_slow_start_after_idle",
>  		.data		= &init_net.ipv4.sysctl_tcp_slow_start_after_idle,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_retrans_collapse",
>  		.data		= &init_net.ipv4.sysctl_tcp_retrans_collapse,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_stdurg",
>  		.data		= &init_net.ipv4.sysctl_tcp_stdurg,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_rfc1337",
>  		.data		= &init_net.ipv4.sysctl_tcp_rfc1337,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_abort_on_overflow",
>  		.data		= &init_net.ipv4.sysctl_tcp_abort_on_overflow,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_fack",
>  		.data		= &init_net.ipv4.sysctl_tcp_fack,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_max_reordering",
> @@ -1105,16 +1105,16 @@ static struct ctl_table ipv4_net_table[] = {
>  	{
>  		.procname	= "tcp_dsack",
>  		.data		= &init_net.ipv4.sysctl_tcp_dsack,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_app_win",
>  		.data		= &init_net.ipv4.sysctl_tcp_app_win,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_adv_win_scale",
> @@ -1128,46 +1128,46 @@ static struct ctl_table ipv4_net_table[] = {
>  	{
>  		.procname	= "tcp_frto",
>  		.data		= &init_net.ipv4.sysctl_tcp_frto,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_no_metrics_save",
>  		.data		= &init_net.ipv4.sysctl_tcp_nometrics_save,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_no_ssthresh_metrics_save",
>  		.data		= &init_net.ipv4.sysctl_tcp_no_ssthresh_metrics_save,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_dou8vec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
>  	{
>  		.procname	= "tcp_moderate_rcvbuf",
>  		.data		= &init_net.ipv4.sysctl_tcp_moderate_rcvbuf,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_tso_win_divisor",
>  		.data		= &init_net.ipv4.sysctl_tcp_tso_win_divisor,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_workaround_signed_windows",
>  		.data		= &init_net.ipv4.sysctl_tcp_workaround_signed_windows,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec
> +		.proc_handler	= proc_dou8vec_minmax,
>  	},
>  	{
>  		.procname	= "tcp_limit_output_bytes",
> @@ -1186,9 +1186,9 @@ static struct ctl_table ipv4_net_table[] = {
>  	{
>  		.procname	= "tcp_min_tso_segs",
>  		.data		= &init_net.ipv4.sysctl_tcp_min_tso_segs,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_dou8vec_minmax,
>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= &gso_max_segs,
>  	},
> @@ -1204,9 +1204,9 @@ static struct ctl_table ipv4_net_table[] = {
>  	{
>  		.procname	= "tcp_autocorking",
>  		.data		= &init_net.ipv4.sysctl_tcp_autocorking,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(u8),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> +		.proc_handler	= proc_dou8vec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> @@ -1277,9 +1277,9 @@ static struct ctl_table ipv4_net_table[] = {
>  	{
>  		.procname       = "tcp_reflect_tos",
>  		.data           = &init_net.ipv4.sysctl_tcp_reflect_tos,
> -		.maxlen         = sizeof(int),
> +		.maxlen         = sizeof(u8),
>  		.mode           = 0644,
> -		.proc_handler   = proc_dointvec_minmax,
> +		.proc_handler   = proc_dou8vec_minmax,
>  		.extra1         = SYSCTL_ZERO,
>  		.extra2         = SYSCTL_ONE,
>  	},
> -- 
> 2.39.2
> 
> 
> 
