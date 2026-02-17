Return-Path: <stable+bounces-216792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Xcb6JX9hlGlfDQIAu9opvQ
	(envelope-from <stable+bounces-216792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:39:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA24614C05C
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25970301E3CD
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5610E334690;
	Tue, 17 Feb 2026 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pvwT95at"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A0628D8DB
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331963; cv=none; b=bO8icW4RBuNWf9QFuzQJj6VUupGm0g2qjEP/lZ4QkL02i234g76BvHAJpKlqIWVj9/vRnj1+7LCcqtpjkx0Kkfi0a/jdystY/SCz9NVj5GLJ7nm0VWzp0cUxFJ35I5bLcOSyPls1uynxjynY1MMcjQ6Q2RBtfSDA1bBOaI0L0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331963; c=relaxed/simple;
	bh=7Vs+aErqDwtaCtelkuTGmnWy0icMUgL7TUI1mhKH084=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dREa6HqMxc80NxtXhU9TfAeBqdVpwk/udkrpucyIhrpTDCOm7CZn1eZuvzCmWX/uf2mmF2pj+xRNvCMgS3GTyqKv8eE+Fqq7Qh61q8uD0Fo9TgPGmr/IOIOUyd9KrYWe8dx6fULR6074Ej4E4A1FpL6gamWvE0gzGn2jBeSTsEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pvwT95at; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31631C4CEF7;
	Tue, 17 Feb 2026 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771331962;
	bh=7Vs+aErqDwtaCtelkuTGmnWy0icMUgL7TUI1mhKH084=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvwT95atA4z4MovyyQfh+Wq0K9gcYT6uI/hkRhRUKee8g6+vgSLfm3abfOnG0tiPE
	 fv8zOF/yZvJXn6S+bDI7XLClt3vQCcjNHgb5wud+ijdUBgr+daApsHXmSh3U6J8O0z
	 Hzlllob2cpWZZM1pjALdNGNxs7h5GbfvrUfBzRVw=
Date: Tue, 17 Feb 2026 13:39:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH stable] cpuset: Fix missing adaptation for
 cpuset_is_populated
Message-ID: <2026021759-plaza-commode-1fdb@gregkh>
References: <2026011258-raving-unlovable-5059@gregkh>
 <20260114015129.1156361-1-chenridong@huaweicloud.com>
 <bb71a754-ed2e-4535-aa20-c8d0a9ec4be1@huaweicloud.com>
 <2026011510-untouched-widen-8f33@gregkh>
 <24d50280-3cbc-473a-90e9-d749d25f40f6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24d50280-3cbc-473a-90e9-d749d25f40f6@huaweicloud.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216792-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: AA24614C05C
X-Rspamd-Action: no action

On Fri, Jan 16, 2026 at 08:57:40AM +0800, Chen Ridong wrote:
> 
> 
> On 2026/1/15 22:54, Greg KH wrote:
> > On Wed, Jan 14, 2026 at 10:13:16AM +0800, Chen Ridong wrote:
> >>
> >>
> >> On 2026/1/14 9:51, Chen Ridong wrote:
> >>> From: Chen Ridong <chenridong@huawei.com>
> >>>
> >>> Commit b1bcaed1e39a ("cpuset: Treat cpusets in attaching as populated")
> >>> was backported to the long‑term support (LTS) branches. However, because
> >>> commit d5cf4d34a333 ("cgroup/cpuset: Don't track # of local child
> >>> partitions") was not backported, a corresponding adaptation to the
> >>> backported code is still required.
> >>>
> >>> To ensure correct behavior, replace cgroup_is_populated with
> >>> cpuset_is_populated in the partition_is_populated function.
> >>>
> >>> Cc: stable@vger.kernel.org	# 6.1+
> >>> Fixes: b1bcaed1e39a ("cpuset: Treat cpusets in attaching as populated")
> >>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> >>> ---
> >>>  kernel/cgroup/cpuset.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> >>> index f61dde0497f3..3c466e742751 100644
> >>> --- a/kernel/cgroup/cpuset.c
> >>> +++ b/kernel/cgroup/cpuset.c
> >>> @@ -486,7 +486,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
> >>>  	    cs->attach_in_progress)
> >>>  		return true;
> >>>  	if (!excluded_child && !cs->nr_subparts_cpus)
> >>> -		return cgroup_is_populated(cs->css.cgroup);
> >>> +		return cpuset_is_populated(cs);
> >>>  
> >>>  	rcu_read_lock();
> >>>  	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
> >>
> >> Hi Greg,
> >>
> >> Is this patch suitable for applying?
> >> It needs approval from the maintainers of this file.
> > 
> 
> Hi, Longman,
> 
> I appreciate you could have a review.
> 
> >> Note:  Because the corresponding commit varies between LTS branches,, the Fixes tag points to a
> >> mainline commit.
> > 
> > As this is only for 6.1.y, why not point it at the commit there?
> > 
> 
> This fix (commit b1bcaed1e39a "cpuset: Treat cpusets in attaching as populated") was backported to
> the stable branches v6.1 and later. The latest LTS(v6.18) has this issue, so it should be v6.1+.
> 
> Cc: stable@vger.kernel.org # v6.1+

Ok, makes sense.  I've applied this, with manual fixups for 6.18.y and
6.12.y, to the relevent trees.

greg k-h

