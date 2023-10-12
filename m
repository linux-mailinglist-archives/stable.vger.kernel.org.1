Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FBC7C73B5
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 19:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347342AbjJLRFo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 13:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344085AbjJLRFn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 13:05:43 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3E8C6
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 10:05:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B1E95C0568;
        Thu, 12 Oct 2023 13:05:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 12 Oct 2023 13:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697130337; x=1697216737; bh=T0
        cNJO9y4aD0Wfuj21yg9IouNWFGqoSJF7uMfFGaZa4=; b=IbuA8ynpXiEl968hRa
        3KjCdMpQTIChm/b+qYe7V0EaP/di7Z7UP+wD6oIxcFuRl7gWiUjv20CH+AiZEubB
        MbV6MRnJckiIAA1E+Wi68R31QjHy6SLD2Y6ThWTGb5rhT5Lu55G/+B4yo5eg1DAE
        FnHauEXEWwJv3T03lBf2jk5oQdMwqsb244NpScJ1Jmg3T4GF1NYFbpphrKH9dajx
        0hDekrQYaV0KA9SiuHf6AzvfzHcuHOnkEQztt30L3EFn8imtQ4HZgduPDuV4jgXX
        tfTvXzJDD+bAOkaP8ALqq1sh7ymTtc8HCCjXBMOnVb9rkYbG/TG4G+wYfNymyx8Q
        J+vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697130337; x=1697216737; bh=T0cNJO9y4aD0W
        fuj21yg9IouNWFGqoSJF7uMfFGaZa4=; b=RaqRAm9i3yJh3q/zPCbkvBwWpWii7
        91Vqfp8XOONX/YzXQy2Ewi72TILzfLpelF9cFgO+UDUMG7lsiePd0yHVyp3xuJwK
        htxTq3lS5ZQDHyjpaemL/aZgf7JYf6wRcbrQTr2jyGDssE1jV9ckCg+FUZbVh1OG
        A1/8IMBQwB8PHn4uN9kZkaSuwtqef0ugEJzK5pUu947Mss02/YHZ+wGzqzoCpHwo
        RXt5i1cvRu+idbx/BCerKWx9JiMKcJgZNd3pliOztUbbm90tKffKU1JPSKdYorod
        K10LAyh3Bu5NWtqbuYweu7ib+7v648VEqy1nVej5sYBJfAnJsBgCH1/qg==
X-ME-Sender: <xms:YScoZZ5fxLBDdpYhX5IwkzqBn-3eYMKEQ2bqJUXZHRIUZMTSBYdGnw>
    <xme:YScoZW7GIiNU8QjXKMvxoHXVqD9Xc3HJnfSukFL5K9oAMTF10KL3_-vu74MzWuesI
    XdHFvkCKejn7w>
X-ME-Received: <xmr:YScoZQep3Xy42MOhICk2q4jSfX7gmVmOtu2PIWDRB5Pa41ONMGkdqG07AtLKAPPqCS3YU_n-nCklifDS4a0nkxQuh2-NEImJV97gDhPbGIU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedtgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:YScoZSKulHn919ewL9B7WVzV2HCQWf2gejMuRV-vUp7KQrEA4C7J-w>
    <xmx:YScoZdJ0XJih-RmUH6LdEH0fZ8ht5e-jLj_1ncHvlqNgxG0zay33wA>
    <xmx:YScoZbwF0T7CpQn-XSLQIEwI0Kep9RqRDp-LmriMDt-lfq2LL0VP9g>
    <xmx:YScoZU_hdN6EPIxBubW1xnHL3q3Vo8JB-YBaH9jX_E5vopN8zoDK2g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Oct 2023 13:05:36 -0400 (EDT)
Date:   Thu, 12 Oct 2023 19:05:35 +0200
From:   Greg KH <greg@kroah.com>
To:     Zbigniew Lukwinski <zbigniew.lukwinski@linux.intel.com>
Cc:     zbigelpl@gmail.com, Jan Kara <jack@suse.cz>,
        Eric Whitney <enwlinux@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] quota: Fix slow quotaoff
Message-ID: <2023101209-slick-washday-15cc@gregkh>
References: <20231012122740.1281902-1-zbigniew.lukwinski@linux.intel.com>
 <20231012122740.1281902-2-zbigniew.lukwinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012122740.1281902-2-zbigniew.lukwinski@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 12, 2023 at 02:27:40PM +0200, Zbigniew Lukwinski wrote:
> From: Jan Kara <jack@suse.cz>
> 
> Eric has reported that commit dabc8b207566 ("quota: fix dqput() to
> follow the guarantees dquot_srcu should provide") heavily increases
> runtime of generic/270 xfstest for ext4 in nojournal mode. The reason
> for this is that ext4 in nojournal mode leaves dquots dirty until the last
> dqput() and thus the cleanup done in quota_release_workfn() has to write
> them all. Due to the way quota_release_workfn() is written this results
> in synchronize_srcu() call for each dirty dquot which makes the dquot
> cleanup when turning quotas off extremely slow.
> 
> To be able to avoid synchronize_srcu() for each dirty dquot we need to
> rework how we track dquots to be cleaned up. Instead of keeping the last
> dquot reference while it is on releasing_dquots list, we drop it right
> away and mark the dquot with new DQ_RELEASING_B bit instead. This way we
> can we can remove dquot from releasing_dquots list when new reference to
> it is acquired and thus there's no need to call synchronize_srcu() each
> time we drop dq_list_lock.
> 
> References: https://lore.kernel.org/all/ZRytn6CxFK2oECUt@debian-BULLSEYE-live-builder-AMD64
> Reported-by: Eric Whitney <enwlinux@gmail.com>
> Fixes: dabc8b207566 ("quota: fix dqput() to follow the guarantees dquot_srcu should provide")
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/quota/dquot.c         | 66 ++++++++++++++++++++++++----------------
>  include/linux/quota.h    |  4 ++-
>  include/linux/quotaops.h |  2 +-
>  3 files changed, 43 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 9e72bfe8bbad..31e897ad5e6a 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -233,19 +233,18 @@ static void put_quota_format(struct quota_format_type *fmt)
>   * All dquots are placed to the end of inuse_list when first created, and this
>   * list is used for invalidate operation, which must look at every dquot.
>   *
> - * When the last reference of a dquot will be dropped, the dquot will be
> - * added to releasing_dquots. We'd then queue work item which would call
> + * When the last reference of a dquot is dropped, the dquot is added to
> + * releasing_dquots. We'll then queue work item which will call
>   * synchronize_srcu() and after that perform the final cleanup of all the
> - * dquots on the list. Both releasing_dquots and free_dquots use the
> - * dq_free list_head in the dquot struct. When a dquot is removed from
> - * releasing_dquots, a reference count is always subtracted, and if
> - * dq_count == 0 at that point, the dquot will be added to the free_dquots.
> + * dquots on the list. Each cleaned up dquot is moved to free_dquots list.
> + * Both releasing_dquots and free_dquots use the dq_free list_head in the dquot
> + * struct.
>   *
> - * Unused dquots (dq_count == 0) are added to the free_dquots list when freed,
> - * and this list is searched whenever we need an available dquot.  Dquots are
> - * removed from the list as soon as they are used again, and
> - * dqstats.free_dquots gives the number of dquots on the list. When
> - * dquot is invalidated it's completely released from memory.
> + * Unused and cleaned up dquots are in the free_dquots list and this list is
> + * searched whenever we need an available dquot. Dquots are removed from the
> + * list as soon as they are used again and dqstats.free_dquots gives the number
> + * of dquots on the list. When dquot is invalidated it's completely released
> + * from memory.
>   *
>   * Dirty dquots are added to the dqi_dirty_list of quota_info when mark
>   * dirtied, and this list is searched when writing dirty dquots back to
> @@ -321,6 +320,7 @@ static inline void put_dquot_last(struct dquot *dquot)
>  static inline void put_releasing_dquots(struct dquot *dquot)
>  {
>  	list_add_tail(&dquot->dq_free, &releasing_dquots);
> +	set_bit(DQ_RELEASING_B, &dquot->dq_flags);
>  }
>  
>  static inline void remove_free_dquot(struct dquot *dquot)
> @@ -328,8 +328,10 @@ static inline void remove_free_dquot(struct dquot *dquot)
>  	if (list_empty(&dquot->dq_free))
>  		return;
>  	list_del_init(&dquot->dq_free);
> -	if (!atomic_read(&dquot->dq_count))
> +	if (!test_bit(DQ_RELEASING_B, &dquot->dq_flags))
>  		dqstats_dec(DQST_FREE_DQUOTS);
> +	else
> +		clear_bit(DQ_RELEASING_B, &dquot->dq_flags);
>  }
>  
>  static inline void put_inuse(struct dquot *dquot)
> @@ -581,12 +583,6 @@ static void invalidate_dquots(struct super_block *sb, int type)
>  			continue;
>  		/* Wait for dquot users */
>  		if (atomic_read(&dquot->dq_count)) {
> -			/* dquot in releasing_dquots, flush and retry */
> -			if (!list_empty(&dquot->dq_free)) {
> -				spin_unlock(&dq_list_lock);
> -				goto restart;
> -			}
> -
>  			atomic_inc(&dquot->dq_count);
>  			spin_unlock(&dq_list_lock);
>  			/*
> @@ -605,6 +601,15 @@ static void invalidate_dquots(struct super_block *sb, int type)
>  			 * restart. */
>  			goto restart;
>  		}
> +		/*
> +		 * The last user already dropped its reference but dquot didn't
> +		 * get fully cleaned up yet. Restart the scan which flushes the
> +		 * work cleaning up released dquots.
> +		 */
> +		if (test_bit(DQ_RELEASING_B, &dquot->dq_flags)) {
> +			spin_unlock(&dq_list_lock);
> +			goto restart;
> +		}
>  		/*
>  		 * Quota now has no users and it has been written on last
>  		 * dqput()
> @@ -696,6 +701,13 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
>  						 dq_dirty);
>  
>  			WARN_ON(!dquot_active(dquot));
> +			/* If the dquot is releasing we should not touch it */
> +			if (test_bit(DQ_RELEASING_B, &dquot->dq_flags)) {
> +				spin_unlock(&dq_list_lock);
> +				flush_delayed_work(&quota_release_work);
> +				spin_lock(&dq_list_lock);
> +				continue;
> +			}
>  
>  			/* Now we have active dquot from which someone is
>   			 * holding reference so we can safely just increase
> @@ -809,18 +821,18 @@ static void quota_release_workfn(struct work_struct *work)
>  	/* Exchange the list head to avoid livelock. */
>  	list_replace_init(&releasing_dquots, &rls_head);
>  	spin_unlock(&dq_list_lock);
> +	synchronize_srcu(&dquot_srcu);
>  
>  restart:
> -	synchronize_srcu(&dquot_srcu);
>  	spin_lock(&dq_list_lock);
>  	while (!list_empty(&rls_head)) {
>  		dquot = list_first_entry(&rls_head, struct dquot, dq_free);
> -		/* Dquot got used again? */
> -		if (atomic_read(&dquot->dq_count) > 1) {
> -			remove_free_dquot(dquot);
> -			atomic_dec(&dquot->dq_count);
> -			continue;
> -		}
> +		WARN_ON_ONCE(atomic_read(&dquot->dq_count));
> +		/*
> +		 * Note that DQ_RELEASING_B protects us from racing with
> +		 * invalidate_dquots() calls so we are safe to work with the
> +		 * dquot even after we drop dq_list_lock.
> +		 */
>  		if (dquot_dirty(dquot)) {
>  			spin_unlock(&dq_list_lock);
>  			/* Commit dquot before releasing */
> @@ -834,7 +846,6 @@ static void quota_release_workfn(struct work_struct *work)
>  		}
>  		/* Dquot is inactive and clean, now move it to free list */
>  		remove_free_dquot(dquot);
> -		atomic_dec(&dquot->dq_count);
>  		put_dquot_last(dquot);
>  	}
>  	spin_unlock(&dq_list_lock);
> @@ -875,6 +886,7 @@ void dqput(struct dquot *dquot)
>  	BUG_ON(!list_empty(&dquot->dq_free));
>  #endif
>  	put_releasing_dquots(dquot);
> +	atomic_dec(&dquot->dq_count);
>  	spin_unlock(&dq_list_lock);
>  	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
>  }
> @@ -963,7 +975,7 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
>  		dqstats_inc(DQST_LOOKUPS);
>  	}
>  	/* Wait for dq_lock - after this we know that either dquot_release() is
> -	 * already finished or it will be canceled due to dq_count > 1 test */
> +	 * already finished or it will be canceled due to dq_count > 0 test */
>  	wait_on_dquot(dquot);
>  	/* Read the dquot / allocate space in quota file */
>  	if (!dquot_active(dquot)) {
> diff --git a/include/linux/quota.h b/include/linux/quota.h
> index fd692b4a41d5..07071e64abf3 100644
> --- a/include/linux/quota.h
> +++ b/include/linux/quota.h
> @@ -285,7 +285,9 @@ static inline void dqstats_dec(unsigned int type)
>  #define DQ_FAKE_B	3	/* no limits only usage */
>  #define DQ_READ_B	4	/* dquot was read into memory */
>  #define DQ_ACTIVE_B	5	/* dquot is active (dquot_release not called) */
> -#define DQ_LASTSET_B	6	/* Following 6 bits (see QIF_) are reserved\
> +#define DQ_RELEASING_B	6	/* dquot is in releasing_dquots list waiting
> +				 * to be cleaned up */
> +#define DQ_LASTSET_B	7	/* Following 6 bits (see QIF_) are reserved\
>  				 * for the mask of entries set via SETQUOTA\
>  				 * quotactl. They are set under dq_data_lock\
>  				 * and the quota format handling dquot can\
> diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
> index 11a4becff3a9..4fa4ef0a173a 100644
> --- a/include/linux/quotaops.h
> +++ b/include/linux/quotaops.h
> @@ -57,7 +57,7 @@ static inline bool dquot_is_busy(struct dquot *dquot)
>  {
>  	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
>  		return true;
> -	if (atomic_read(&dquot->dq_count) > 1)
> +	if (atomic_read(&dquot->dq_count) > 0)
>  		return true;
>  	return false;
>  }
> -- 
> 2.34.1
> 

What is the git commit id of this change in Linus's tree?  What stable
kernel(s) are you wanting this applied to?

thanks,

greg k-h
