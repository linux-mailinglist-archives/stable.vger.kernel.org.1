Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B48715D34
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 13:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjE3L24 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 30 May 2023 07:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjE3L2x (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 30 May 2023 07:28:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E24113
        for <stable@vger.kernel.org>; Tue, 30 May 2023 04:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLaiQPAfwo5rMZFxoelxDLlt7tcFnLg+WD9gHGcCFQnimlLuUvfpF0tcHGPvwu9eoy6KlW15aYIUPOXHHob5kQsEsD6rI5D6xQ7SFzV8QssCI248mTXFQbq2o2irv7Jyw1RqGM9KG2sFjb/UTO1MYP0xOxcFPtwmJnOgHEvKarCJiwrGa2EQffo0vpRdBTmyI1ML9sI9AoQkAFBM4cIDF08F1lbU0tP1QEAlZJRP54u3huIub7TrMkepaxn6JrZzasaVO8rIKAYKTUTFrmTwGQbDiz3oDPqJLvTHDu15O4833cb/6KTKoBHeiZ6V+51kim4WWqN3SSPNJsZ7+d4G8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sZhjDXu6o7kjrwKGONr3yZ0k1Gh7Nz4KMXx9moFpTE=;
 b=fIUJmrPQq7M3HDJsd1Vp8BT+NeUKW3DyTaYYhlZcPh+m4QsNDLOnWWVpZp6HcdDSJ10h+uBm15eoPkjRZU5YaDH3v7wkLUTreGDnHUenS+6eiybHIVLshCbXazIA65Q/C3py5RP2M98J7cXKHAKSHguwGnPU9N79XiuMvtPS0PGm5ibnYab/2hUPk229iXdbDvKGSgJkh3Kfz4zB3VP4HoBi6w4Ub8oEmvnJibPVvetXSXQL2etst+fYhdFQGhWm0QVoD6znDBr7HIkr6bMedfAdMA1hllIhlMV1DuCYNUtYuP8yvlGJhz0wjGCWmOLzkC7Qv2EizDGK9lfHWYbRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sZhjDXu6o7kjrwKGONr3yZ0k1Gh7Nz4KMXx9moFpTE=;
 b=4L3lO8sODkCqFpABAWaLMSa9SADuEv4nbczxNYSpMRyYPunt5QUD4BF0jIhDcfP/ngrJH7e6ARqZ/sLLe3GuodAqc80H/T7a7HO/VYf5tgWP1mZmV2+ZRyDhbyoFdFL1AufgmYiFF1fDRVmSHLYJGwn0ORJOeqk1ec9ueLkwrF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by CH0PR12MB5282.namprd12.prod.outlook.com (2603:10b6:610:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:28:44 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::aeb:7ad3:2f4a:f218%4]) with mapi id 15.20.6455.020; Tue, 30 May 2023
 11:28:44 +0000
Date:   Tue, 30 May 2023 16:58:32 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     stable@vger.kernel.org
Cc:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 6.3.y] cpufreq: amd-pstate: Add ->fast_switch() callback
Message-ID: <ZHXd4NcHZA/7AfUX@BLR-5CG13462PL.amd.com>
References: <2023052834-enlighten-vacate-bfd6@gregkh>
 <20230530111653.3593-1-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530111653.3593-1-wyes.karny@amd.com>
X-ClientProxiedBy: PN2PR01CA0233.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::12) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|CH0PR12MB5282:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f74f434-8ecb-4ae1-02d6-08db610106b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bIjhScaEqOS7/EgFx4PsF0sZ94udffco9dZSq0kG7izUDWIa83nx2tc/D+KMEsC1tDMeYvCE1svY70xVR+24t0r9jBon5l7Oa6BYq4cuRU/pIqYFdqzknHivk/61pFfYUAECbCGh4LlIcR88hRIiSPPNHZiP4e27XMIEMS53+NW3E3oBGIQibFSmRurAX/sO0TpTB/4AJvuOtXY+mZnSzIfNQX0nBkBH8hc+ESGmkJoDOIEFwWADWfB5LubT1xWvVS79uPnQLpcw50vxEIaJKt/LvhjN2zAJB45wvxgP21oaIU+sH5DHGJM06Qt+lw9l+QhLWMn401P7z5h43OD3h8qX+j2V2Fuh4Kep28oMXI0qva8lC9WCkxLJNFb6MtcxjJotxwf7Wp63RBc9gNp1nDpWw3wdzCFssMlkGUij0jg7Phqb7wimnPAkS+Rcl6DxbNCS/y3fBn349y8zbloC+3bo6pBCjGhoaEhSpweh3wtACRcVdEVm9w3WUHR4pJizHOyR9MWNVwuvfxCEsyRaFnr+3cgLbfj3NMq6LLhKZnE7pGWxibde1CrTQ3kcBgN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(478600001)(54906003)(8676002)(8936002)(66556008)(5660300002)(44832011)(2906002)(86362001)(66476007)(66946007)(6916009)(4326008)(316002)(38100700002)(41300700001)(186003)(6506007)(6512007)(26005)(6486002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SZPLN4Zq7tOOhCgDf7RRWhmuXV0vLCea20Bu7Id5MmtVYrd4SqczU28+bpuK?=
 =?us-ascii?Q?j0/VU61tGgZFy2Bd1codClfh1S5rWiOV2jiF3ojuHga1yqHsVAqPpsssywMc?=
 =?us-ascii?Q?JP9VCUzPnOf8bZbmlrbuPsSMWqA+GIgglVaUgzR6LUa6dZ53yN4RywzJX0/n?=
 =?us-ascii?Q?RUjpvOTCJLxbwvyEjcuPQQT/sZhO0POgCJcwApw0GZlMoYcVd+NKxsvAVEen?=
 =?us-ascii?Q?BxHLlC4ObWd9I9fDD6sWSjicD7tYq8mh8wRB/z/Snx3vPQOxLwHRySGqCj/j?=
 =?us-ascii?Q?YTRvJGZmLURb+OySkXmemfPBf4X90i+T2NFoKIgf3xPdvzWXUaBb0yaujqrA?=
 =?us-ascii?Q?AzHJ0XtOE3k4FYajl1QsGNE5sMH6T7GE8bavV2GFazqEqYzQ+YyxAPg9eMj7?=
 =?us-ascii?Q?mz1OiCPGwGJefIg0jG+S3hVw0TnjOlAFTJ01jZgGlbiivGy37zBjapXWZdJj?=
 =?us-ascii?Q?wTzdftJeX4iqHRXbkVYJTTo563K1L7meGF8U5RGx2IeuU3WPwz0AXJPDA8vU?=
 =?us-ascii?Q?Kb8lCzD5p03v5eh982C7+jtM1oT2o9y8F1gPewZ6x3HqP6/AhwCnoD/ShD+N?=
 =?us-ascii?Q?ESZRZfS+0h9UwwPn/xpcQzMYi6qb4CHZh2MgefbTMUT64JqItJ+Xd/icaxz+?=
 =?us-ascii?Q?cKTtDbuYFpXhlR1mTX3kUZfcW+dXSiNSUotFl0myizvr1z+fOLOdLFQrC3rN?=
 =?us-ascii?Q?vdHJmY5Fa8vzsaAeWT6pwFEx1aIvQgtdgSXokiyITUzZyHhegA72G+qwVGhS?=
 =?us-ascii?Q?KTKRAwnrW1anYXoG+e18GBuGo2eGAZGPVgzM7IyvrEiPITO3udKAR0ADYNY3?=
 =?us-ascii?Q?r1mnMHMZmrIEboEFAFhZ0cHQaFvdfBzbQys7ZlC+5BfFhH6aT0OGs2Xqy/Ia?=
 =?us-ascii?Q?9TUoB7Tn/OPCaDtbA0/PqjbGF0AUcucd0rV1eIVob6ALYuwQF1fXDEz6+ydI?=
 =?us-ascii?Q?BZDth5Gef9rHKiz/3hnbcD9k+sjXB46h4s4QoIP28hjfsjt+l7lnUffJqqfw?=
 =?us-ascii?Q?lpefrXzh6BbckvFppGkTb5JNZ6wXazoCnK6ocPNb1caBpLG35v/i22UTb+Cs?=
 =?us-ascii?Q?M7gF372lYBIC3tGw7AJUaL+PW0y3Rm85ee60zXhJQuAPEgbrSj9xgTxSEmoT?=
 =?us-ascii?Q?6WpZ+yCemUYRHjrMHs3dcPUlSYpoWHqwitkqhjMCuQ0OZW7/bSRht5MpOW6o?=
 =?us-ascii?Q?LBDJbpe1QpF+Wu4IkvLsikCletXdE7HxkrKkIBWpzil6fgRoSbY1ZQRWaRKU?=
 =?us-ascii?Q?sJsK6azfFG8WP5MHZC7rljR8GDmrzoP2YxIFKftNgcBbUcXcR2iREJM0Puqc?=
 =?us-ascii?Q?RYImgaZVkX8Gf2B5LBnRvXzTAV30WfpbO5Q4XwJmyA5drGzu4Sn6v1+hyei7?=
 =?us-ascii?Q?EcylgGnYT4o+yS/uxSLqjhQDewVdwYvqzPmfV3lFpa5ArkI8tT9eO68i+VCH?=
 =?us-ascii?Q?DKd6Nw4q8MyqVgRPnJWaq29LNSMuHjfwqzlH0UFt7KK2lr3G3HbfVr9ga04e?=
 =?us-ascii?Q?PGWK2Xwgmx2zbRkETHIzUIsobSU1x17SUxub7+KjFjNzpJLSEEGASHCjzgBl?=
 =?us-ascii?Q?ex8y5GZxaJw/QoSxqxhgDQ6K5G20Ui0N4qr/qf1l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f74f434-8ecb-4ae1-02d6-08db610106b1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 11:28:44.1957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jv0yaixXwigqGyEGnWpHEtcPmkxVN0+jka8jWizFNySp77rwlkz1aS8tZfS01ezc4gITP+guuu1PMRLL0uLMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 30 May 11:16, Wyes Karny wrote:
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
> 
> [ Upstream commit 3bf8c6307bad5c0cc09cde982e146d847859b651 ]
> 
> Schedutil normally calls the adjust_perf callback for drivers with
> adjust_perf callback available and fast_switch_possible flag set.
> However, when frequency invariance is disabled and schedutil tries to
> invoke fast_switch. So, there is a chance of kernel crash if this
> function pointer is not set. To protect against this scenario add
> fast_switch callback to amd_pstate driver.
> 
> Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> (cherry picked from commit 4badf2eb1e986bdbf34dd2f5d4c979553a86fe54)
> ---
>  drivers/cpufreq/amd-pstate.c | 37 +++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8dd46fad151e..7cce90d16b8d 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -422,9 +422,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
>  	return 0;
>  }
>  
> -static int amd_pstate_target(struct cpufreq_policy *policy,
> -			     unsigned int target_freq,
> -			     unsigned int relation)
> +static int amd_pstate_update_freq(struct cpufreq_policy *policy,
> +				  unsigned int target_freq, bool fast_switch)
>  {
>  	struct cpufreq_freqs freqs;
>  	struct amd_cpudata *cpudata = policy->driver_data;
> @@ -443,14 +442,36 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>  	des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
>  				     cpudata->max_freq);
>  
> -	cpufreq_freq_transition_begin(policy, &freqs);
> -	amd_pstate_update(cpudata, min_perf, des_perf,
> -			  max_perf, false);
> -	cpufreq_freq_transition_end(policy, &freqs, false);
> +	WARN_ON(fast_switch && !policy->fast_switch_enabled);
> +	/*
> +	 * If fast_switch is desired, then there aren't any registered
> +	 * transition notifiers. See comment for
> +	 * cpufreq_enable_fast_switch().
> +	 */
> +	if (!fast_switch)
> +		cpufreq_freq_transition_begin(policy, &freqs);
> +
> +	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, fast_switch);
> +
> +	if (!fast_switch)
> +		cpufreq_freq_transition_end(policy, &freqs, false);
>  
>  	return 0;
>  }
>  
> +static int amd_pstate_target(struct cpufreq_policy *policy,
> +			     unsigned int target_freq,
> +			     unsigned int relation)
> +{
> +	return amd_pstate_update_freq(policy, target_freq, false);
> +}
> +
> +static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
> +				  unsigned int target_freq)
> +{
> +	return amd_pstate_update_freq(policy, target_freq, true);
> +}
> +
>  static void amd_pstate_adjust_perf(unsigned int cpu,
>  				   unsigned long _min_perf,
>  				   unsigned long target_perf,
> @@ -692,6 +713,7 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  
>  	freq_qos_remove_request(&cpudata->req[1]);
>  	freq_qos_remove_request(&cpudata->req[0]);
> +	policy->fast_switch_possible = false;
>  	kfree(cpudata);
>  
>  	return 0;
> @@ -1226,6 +1248,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>  	.verify		= amd_pstate_verify,
>  	.target		= amd_pstate_target,
> +	.fast_switch    = amd_pstate_fast_switch,
>  	.init		= amd_pstate_cpu_init,
>  	.exit		= amd_pstate_cpu_exit,
>  	.suspend	= amd_pstate_cpu_suspend,

Please ignore this. Wrong patch.
Sorry for inconvenience.

Thanks,
Wyes

> -- 
> 2.34.1
> 
