Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AB4783CB2
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 11:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbjHVJQu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 05:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjHVJQt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 05:16:49 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1622113
        for <stable@vger.kernel.org>; Tue, 22 Aug 2023 02:16:47 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M993u5022738;
        Tue, 22 Aug 2023 09:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=jAyLrHF6vs2d1Ddi0Winqzp33ecLTcfer0rpG1LAek4=;
 b=o5Tt0IadoUDFe/LRLcgYiLrCXlMOWSEPBOapuxOYugKe44eeqeU9QqHEaz+D9U5zT/nU
 d9c6qhyiTXtm1FcU6OMo0k3FmKlETOmUr7dKLptL4AUsJCtQ9snA4LLGv5DR1yo/ENk9
 CXBVu+bWwkWqCs2Any27duPvfWan8lL0+Zm+p3SDrxdpsMEl+2DeI6SmAeEnqdwIPUCY
 oC5rNg3NIEBktGMth39QBhZnFwELHBoYmYxXOJaunc370d8QVenIfMeRLcucIqavJMrr
 f+JGFFk3sfqNliFoYBCJBSzG6dyFwGSzie16/rPvIMAwbTANZQXOLDnyQ5mwsHjc6XeR 3Q== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3smscxh3cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 09:16:44 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37M7Y44I007870;
        Tue, 22 Aug 2023 09:16:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3smb2h5w1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 09:16:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37M9GgZT19923524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 09:16:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7EFA2004D;
        Tue, 22 Aug 2023 09:16:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0D492004B;
        Tue, 22 Aug 2023 09:16:40 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 22 Aug 2023 09:16:40 +0000 (GMT)
Date:   Tue, 22 Aug 2023 14:46:38 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     gregkh@linuxfoundation.org
Cc:     tytso@mit.edu, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ext4: fix off by one issue in" failed to
 apply to 6.4-stable tree
Message-ID: <ZOR89j3sqHdhxc31@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <2023072456-starting-gauging-768c@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023072456-starting-gauging-768c@gregkh>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mmZmclwS51YRttaX9_4Awud6Ilb_VkdF
X-Proofpoint-ORIG-GUID: mmZmclwS51YRttaX9_4Awud6Ilb_VkdF
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_08,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 24, 2023 at 08:17:57AM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x 5d5460fa7932bed3a9082a6a8852cfbdb46acbe8
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072456-starting-gauging-768c@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h


Hi Greg, Ted,

Sorry for being late on this, I was off for a good part of this month.

So i got multiple such FAILUREs from different stable trees for this
particular patch (linked at end), but seems like these trees don't even
have the patch pointed by Fixes tag.

Although we can safely ignore backporting this, I just wanted to check
why did I get these false failures so I can avoid it in the future.
I was thinking that we would automatically check the fixes tag to see
which trees need the backport? Is that not the case?

Other similar failures on older stable trees:

https://lore.kernel.org/stable/?q=s%3AFAILED+AND+s%3A%22ext4%3A+fix+off+by+one%22+AND+t%3Aojaswin

Regards,
ojaswin


> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 5d5460fa7932bed3a9082a6a8852cfbdb46acbe8 Mon Sep 17 00:00:00 2001
> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Date: Fri, 9 Jun 2023 16:04:03 +0530
> Subject: [PATCH] ext4: fix off by one issue in
>  ext4_mb_choose_next_group_best_avail()
> 
> In ext4_mb_choose_next_group_best_avail(), we want the start order to be
> 1 less than goal length and the min_order to be, at max, 1 more than the
> original length. This commit fixes an off by one issue that arose due to
> the fact that 1 << fls(n) > (n).
> 
> After all the processing:
> 
> order = 1 order below goal len
> min_order = maximum of the three:-
>              - order - trim_order
>              - 1 order below B2C(s_stripe)
>              - 1 order above original len
> 
> Cc: stable@kernel.org
> Fixes: 33122aa930 ("ext4: Add allocation criteria 1.5 (CR1_5)")
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Link: https://lore.kernel.org/r/20230609103403.112807-1-ojaswin@linux.ibm.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a2475b8c9fb5..456150ef6111 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1006,14 +1006,11 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
>  	 * fls() instead since we need to know the actual length while modifying
>  	 * goal length.
>  	 */
> -	order = fls(ac->ac_g_ex.fe_len);
> +	order = fls(ac->ac_g_ex.fe_len) - 1;
>  	min_order = order - sbi->s_mb_best_avail_max_trim_order;
>  	if (min_order < 0)
>  		min_order = 0;
>  
> -	if (1 << min_order < ac->ac_o_ex.fe_len)
> -		min_order = fls(ac->ac_o_ex.fe_len) + 1;
> -
>  	if (sbi->s_stripe > 0) {
>  		/*
>  		 * We are assuming that stripe size is always a multiple of
> @@ -1021,9 +1018,16 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
>  		 */
>  		num_stripe_clusters = EXT4_NUM_B2C(sbi, sbi->s_stripe);
>  		if (1 << min_order < num_stripe_clusters)
> -			min_order = fls(num_stripe_clusters);
> +			/*
> +			 * We consider 1 order less because later we round
> +			 * up the goal len to num_stripe_clusters
> +			 */
> +			min_order = fls(num_stripe_clusters) - 1;
>  	}
>  
> +	if (1 << min_order < ac->ac_o_ex.fe_len)
> +		min_order = fls(ac->ac_o_ex.fe_len);
> +
>  	for (i = order; i >= min_order; i--) {
>  		int frag_order;
>  		/*
> 
