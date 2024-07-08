Return-Path: <stable+bounces-58234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18EC92A371
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 15:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDD31F224FA
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCAA136653;
	Mon,  8 Jul 2024 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="cHZdbewp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R/gEt/IL"
X-Original-To: stable@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8761A3FB94
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443972; cv=none; b=ig7OHzLxoBdfpjxb22onpBYOzIaLZcDiNociPAqITrcYvK+IRK02xaqQuNTVrQFpkhI7c+GIWkT1NHYZpbBZ5QCTdggRziGEx0mOEgGu+xDUMXVqwJcbb6wl0+wrsL5I9xswns0zv4tE4ml6FIwZVIusHs5Ps8XtFmjglf74vSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443972; c=relaxed/simple;
	bh=wmlQlEjfvU0upTUltYjtMZhhx4tjODYQEOWVs4pNx7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOsV7IWsuA6JBZBjcRoprNHIk5XuzCzp4rVwi0d+hhLDK/wiBg3T4iCXw6YGzBcAOtgbEfzEVofj15+lqxKaBGLavKl/ghtd5sdJJNtxmdjH36HKCkUh4SaaJH8VRKC8QfNIRx+cWnqN67nnzcKx2SDbi3u+AQNidKfAR2uqqkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=cHZdbewp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R/gEt/IL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 716781140094;
	Mon,  8 Jul 2024 09:06:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Jul 2024 09:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720443969; x=1720530369; bh=0SdS1gVeus
	EW5yio1Y8gYWXdzaFHasJ/BlKtWZGx4kI=; b=cHZdbewpg+ViuSQAtycyE5h5Jo
	c21qzFKSX61u/208aYlY2t8BMXOooj2UONpgyGTsqZSyyXtQp6mZBJt0SsH5BHJ+
	JR5hlUqEJn4HbmmpBFcaS7vEsGoBtG3XvBaaoJpCx8aBVJYicMHTt8D+6Gg9PMPY
	nIFUV59IlXZuG1YllMunLWhk7S8yhcCjVsbWnywlHrB6OsfU+czoYjTLh9ao/M7X
	MNjfV0eybFH85NWpGjAf+3kjISkX3I9ybA/VgrFEdMRFMTM5aba5ThtZzPjsQTem
	hkNDpfXS2Gwe8gc50AwGBa93HYSeea2/D5oncKeAk3xxO0K9li98rRcJaU+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720443969; x=1720530369; bh=0SdS1gVeusEW5yio1Y8gYWXdzaFH
	asJ/BlKtWZGx4kI=; b=R/gEt/ILT2PDanPuenJaiEvRh12JcAjEJMdN85lZZIcG
	TaRErGIDx0Qd4+E3wpF5ZhxpidVoJ6E6mFm6PGl68KECngGVjaDNUojFHsE8+faw
	1XiwH2mXCmCQJgVSX7JZXLHzCbVfVXEXlaNGhMbYujXmN3OvF9Nu5omm8q3y/12B
	JUDZj8v35XfaUxFpjoIY/1kS0ofRGqteG5sSN10cHs+7KeX3gGMM6uI73bVJUB/e
	S+APa742tHUnZdLwSXWsWcbzYVioxqXRTaJc0c9rRfitSpoXA4lGEwD3s8OHQgL7
	6HSCPASfp9w+qjh+OHwr9zfdrXaiUSQ2UXTH1xBh9Q==
X-ME-Sender: <xms:P-SLZsrZgjYrLRlmOAZRShUUh_x2n6IOF2X56qyICg-jiMJE73mPow>
    <xme:P-SLZipTkP924wWGqLy_7VEmraLuYkdCSBK5IDVthEa-iVZtAIFSPWdRHOVBAGDQp
    UAVS_cp-IOqVg>
X-ME-Received: <xmr:P-SLZhN9Q4lnqGyOtW6y2Z3-ZxKu3pjbrN5y-MUhTndHaEYYvMH3UIj0hhZmJnIHdamv5stE1kibkCv1BaaYjwhxk8P3BqHTJZln5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:P-SLZj6_giCJIvXRuXJrRZt_UzW2Pm0Y1HCQ63q1P2y2aUUsjbaj5g>
    <xmx:P-SLZr7l6Jy6j8vGGJ8xEx9W8gybR81JbAw1qojyLyoGjD_fguA_Mw>
    <xmx:P-SLZjgioR2C8V7mO-uqZv8G0K62aqgBWUj1Gx9zqDc2gm4aJNXEaw>
    <xmx:P-SLZl5zl_Cfo9JkaFlreyW-ED_Agj4QCDlg_mlLNVAsp91xFFkj7w>
    <xmx:QeSLZvrKl5CxC_3mCwMuS0pAYOtn8ayW_V9I-OVdVkMPvwcTKlY7bGCY>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jul 2024 09:06:06 -0400 (EDT)
Date: Mon, 8 Jul 2024 15:06:01 +0200
From: Greg KH <greg@kroah.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: stable@vger.kernel.org, zohar@linux.ibm.com,
	GUO Zihua <guozihua@huawei.com>,
	John Johansen <john.johansen@canonical.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Paul Moore <paul@paul-moore.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH] ima: Avoid blocking in RCU read-side critical section
Message-ID: <2024070852-kelp-cuddly-1f0c@gregkh>
References: <20240704104303.3330331-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704104303.3330331-1-roberto.sassu@huaweicloud.com>

On Thu, Jul 04, 2024 at 12:43:03PM +0200, Roberto Sassu wrote:
> From: GUO Zihua <guozihua@huawei.com>
> 
> A panic happens in ima_match_policy:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
> PGD 42f873067 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 5 PID: 1286325 Comm: kubeletmonit.sh
> Kdump: loaded Tainted: P
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>                BIOS 0.0.0 02/06/2015
> RIP: 0010:ima_match_policy+0x84/0x450
> Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39
>       7b 18 74 26 41 83 ff 05 74 20 48 8b 1b 48 3b 1d
>       f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73 10 74 ea
>       44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
> RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
> RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
> R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
> R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
> FS:  00007f5195b51740(0000)
> GS:ff3e278b12d40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ima_get_action+0x22/0x30
>  process_measurement+0xb0/0x830
>  ? page_add_file_rmap+0x15/0x170
>  ? alloc_set_pte+0x269/0x4c0
>  ? prep_new_page+0x81/0x140
>  ? simple_xattr_get+0x75/0xa0
>  ? selinux_file_open+0x9d/0xf0
>  ima_file_check+0x64/0x90
>  path_openat+0x571/0x1720
>  do_filp_open+0x9b/0x110
>  ? page_counter_try_charge+0x57/0xc0
>  ? files_cgroup_alloc_fd+0x38/0x60
>  ? __alloc_fd+0xd4/0x250
>  ? do_sys_open+0x1bd/0x250
>  do_sys_open+0x1bd/0x250
>  do_syscall_64+0x5d/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
> 
> Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within a
> RCU read-side critical section which contains kmalloc with GFP_KERNEL.
> This implies a possible sleep and violates limitations of RCU read-side
> critical sections on non-PREEMPT systems.
> 
> Sleeping within RCU read-side critical section might cause
> synchronize_rcu() returning early and break RCU protection, allowing a
> UAF to happen.
> 
> The root cause of this issue could be described as follows:
> |	Thread A	|	Thread B	|
> |			|ima_match_policy	|
> |			|  rcu_read_lock	|
> |ima_lsm_update_rule	|			|
> |  synchronize_rcu	|			|
> |			|    kmalloc(GFP_KERNEL)|
> |			|      sleep		|
> ==> synchronize_rcu returns early
> |  kfree(entry)		|			|
> |			|    entry = entry->next|
> ==> UAF happens and entry now becomes NULL (or could be anything).
> |			|    entry->action	|
> ==> Accessing entry might cause panic.
> 
> To fix this issue, we are converting all kmalloc that is called within
> RCU read-side critical section to use GFP_ATOMIC.
> 
> Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
> Cc: stable@vger.kernel.org
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> Acked-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> [PM: fixed missing comment, long lines, !CONFIG_IMA_LSM_RULES case]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> (cherry picked from commit 9a95c5bfbf02a0a7f5983280fe284a0ff0836c34)
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
> Backporting notes:
> - Remove security_audit_rule_init() documentation changes
> - Add default return value parameter to call_int_hook()
>   in security_audit_rule_init()
> - Can be backported to 6.1.x, 5.15.x, 5.10.x

Now queued up, thanks.

greg k-h

