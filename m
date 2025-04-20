Return-Path: <stable+bounces-134754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934BFA94963
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 21:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB587A2CE0
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 19:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F82D2111;
	Sun, 20 Apr 2025 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="R+wSSeDf";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="a2sGeBcx"
X-Original-To: stable@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F9101E6
	for <stable@vger.kernel.org>; Sun, 20 Apr 2025 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745177614; cv=none; b=kdp0Dja/9C6ijXsA3u1UzD+LvWpzhak47LGgh+YZOillGfCm7z1bxsnJXNWvGpsZXL3+zfAg3xZAjQNL2i4r26yBwvoRXtQuiRPF+Fvp4Nm4OOJnlH9u64mXY9xuNx1JPg0arvXeJyU98YiDL6vWRqS3dDH7MoWhGxxt4j3E0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745177614; c=relaxed/simple;
	bh=SrcpbIuPIHLtZ/p32r1nSx8T2SXqBbgctacm7iOQyxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alMOaURrqsLE+94RwgWPXwa+brD3lkvAQwRwGkVU1C6WH7J+yeNTbHGJ33b+PBxnIJEmvhGuwD4TJLNgTGcMZuAJ8pK2MRA74dJgqdwyUmjJK1tYf4drRG43YhTD0IrXXPvg8cwvSakhZ7H30N0pOBpyQbHeg1XQHasOebFYxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=R+wSSeDf reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=a2sGeBcx; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1745178510; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=BLoFHndqA7Mq6M6UfuredYFZJF1243XVXteTNcqKKns=; b=R+wSSeDf22/moVw0gqxYck/Thj
	A7yocYlKOqCwV0AbXJrb4ayunOPFbIHjmoGLbbODpIdjU+grokV4G4hAu+Pf4LJRhbGJPk10H+B7N
	YyTF3huMeudLQ7Tby7AOO2pM6odZws2bTEf3sfKeOui6udmGuJiIw0DFZpn3gFtcVM0UuhQ5yE4zc
	iYAbRtXbfaAoCggCzJ5fSTiTrHfohFEl3I3t6wSrtHATFQoMxKa8k1viSzn9ldKt0PtZwq47gUio9
	LGnNP24yiFEjRFhDuU8xhEGOgbcYJcaCcRhIObpXN8w3OboSwAze4cQdmvG48UV+0G7eCGc3lcSrE
	RQqzVdkQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1745177610; h=from : subject
 : to : message-id : date;
 bh=BLoFHndqA7Mq6M6UfuredYFZJF1243XVXteTNcqKKns=;
 b=a2sGeBcx+XdxhZsv+jnAqUTcaj7QqLMnSIiYngijDRxoKdz+CUjZGO0WejG8jWt73vNoG
 yTEjmMmNh2h2JIeJNzfVIFnlbDF+SbS7t/PckNGhJMzVl8xuHo0q+7koP+NjIYNhVMC01Or
 sE5FR3mj3ncS6196iOLMl36ulXB8td6FBaWYM7fmrofVry6EuLQpQlk/4qhRn40J/bPe1NC
 2DU0MGxcKtPolgnP1IUTAsgv1ACVyKgfC+eaFyDmtNJgxWT/7teNUOXRV2fl2XSGRL+sOxQ
 oG+1mn8lZfqKKhvoj0DB9YC2aO5UrdTqmXZqoiStQ0LknY1h0y5rUp/vmtAA==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1u6aN2-TRjzCu-AW; Sun, 20 Apr 2025 19:30:28 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1u6aN2-4o5NDgrrx3x-ojl3; Sun, 20 Apr 2025 19:30:28 +0000
Date: Sun, 20 Apr 2025 21:23:36 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Patch "wifi: mac80211: Update skb's control block key in
 ieee80211_tx_dequeue()" has been added to the 6.14-stable tree
Message-ID: <aAVJuPUEZrTDy7L1@pilgrim>
References: <20250420150053.1781606-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420150053.1781606-1-sashal@kernel.org>
X-Smtpcorp-Track: gmIFN_U8a2OG.cTHaCfnsLXNY.2GYz_gMM8ub
Feedback-ID: 510616m:510616apGKSTK:510616sacQ9326wR
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Hello,

On Sun, Apr 20, 2025 at 11:00:53AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()
> 
> to the 6.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      wifi-mac80211-update-skb-s-control-block-key-in-ieee.patch
> and it can be found in the queue-6.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Not sure this patch should go to stable. @Johannes haven't you revert
it in your tree ?

Thanks,

-- 
Remi

> 
> 
> commit 9209089b629b7c29ae393cded89e77c169f18dfb
> Author: Remi Pommarel <repk@triplefau.lt>
> Date:   Mon Mar 24 17:28:20 2025 +0100
> 
>     wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()
>     
>     [ Upstream commit a104042e2bf6528199adb6ca901efe7b60c2c27f ]
>     
>     The ieee80211 skb control block key (set when skb was queued) could have
>     been removed before ieee80211_tx_dequeue() call. ieee80211_tx_dequeue()
>     already called ieee80211_tx_h_select_key() to get the current key, but
>     the latter do not update the key in skb control block in case it is
>     NULL. Because some drivers actually use this key in their TX callbacks
>     (e.g. ath1{1,2}k_mac_op_tx()) this could lead to the use after free
>     below:
>     
>       BUG: KASAN: slab-use-after-free in ath11k_mac_op_tx+0x590/0x61c
>       Read of size 4 at addr ffffff803083c248 by task kworker/u16:4/1440
>     
>       CPU: 3 UID: 0 PID: 1440 Comm: kworker/u16:4 Not tainted 6.13.0-ge128f627f404 #2
>       Hardware name: HW (DT)
>       Workqueue: bat_events batadv_send_outstanding_bcast_packet
>       Call trace:
>        show_stack+0x14/0x1c (C)
>        dump_stack_lvl+0x58/0x74
>        print_report+0x164/0x4c0
>        kasan_report+0xac/0xe8
>        __asan_report_load4_noabort+0x1c/0x24
>        ath11k_mac_op_tx+0x590/0x61c
>        ieee80211_handle_wake_tx_queue+0x12c/0x1c8
>        ieee80211_queue_skb+0xdcc/0x1b4c
>        ieee80211_tx+0x1ec/0x2bc
>        ieee80211_xmit+0x224/0x324
>        __ieee80211_subif_start_xmit+0x85c/0xcf8
>        ieee80211_subif_start_xmit+0xc0/0xec4
>        dev_hard_start_xmit+0xf4/0x28c
>        __dev_queue_xmit+0x6ac/0x318c
>        batadv_send_skb_packet+0x38c/0x4b0
>        batadv_send_outstanding_bcast_packet+0x110/0x328
>        process_one_work+0x578/0xc10
>        worker_thread+0x4bc/0xc7c
>        kthread+0x2f8/0x380
>        ret_from_fork+0x10/0x20
>     
>       Allocated by task 1906:
>        kasan_save_stack+0x28/0x4c
>        kasan_save_track+0x1c/0x40
>        kasan_save_alloc_info+0x3c/0x4c
>        __kasan_kmalloc+0xac/0xb0
>        __kmalloc_noprof+0x1b4/0x380
>        ieee80211_key_alloc+0x3c/0xb64
>        ieee80211_add_key+0x1b4/0x71c
>        nl80211_new_key+0x2b4/0x5d8
>        genl_family_rcv_msg_doit+0x198/0x240
>       <...>
>     
>       Freed by task 1494:
>        kasan_save_stack+0x28/0x4c
>        kasan_save_track+0x1c/0x40
>        kasan_save_free_info+0x48/0x94
>        __kasan_slab_free+0x48/0x60
>        kfree+0xc8/0x31c
>        kfree_sensitive+0x70/0x80
>        ieee80211_key_free_common+0x10c/0x174
>        ieee80211_free_keys+0x188/0x46c
>        ieee80211_stop_mesh+0x70/0x2cc
>        ieee80211_leave_mesh+0x1c/0x60
>        cfg80211_leave_mesh+0xe0/0x280
>        cfg80211_leave+0x1e0/0x244
>       <...>
>     
>     Reset SKB control block key before calling ieee80211_tx_h_select_key()
>     to avoid that.
>     
>     Fixes: bb42f2d13ffc ("mac80211: Move reorder-sensitive TX handlers to after TXQ dequeue")
>     Signed-off-by: Remi Pommarel <repk@triplefau.lt>
>     Link: https://patch.msgid.link/06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt
>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index a24636bda6793..0c6214f12ea39 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3893,6 +3893,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>  	 * The key can be removed while the packet was queued, so need to call
>  	 * this here to get the current key.
>  	 */
> +	info->control.hw_key = NULL;
>  	r = ieee80211_tx_h_select_key(&tx);
>  	if (r != TX_CONTINUE) {
>  		ieee80211_free_txskb(&local->hw, skb);

