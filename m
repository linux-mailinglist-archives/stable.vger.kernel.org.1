Return-Path: <stable+bounces-224727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD5mHVShsWn4EAAAu9opvQ
	(envelope-from <stable+bounces-224727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:07:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3342267C35
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99126305DD2D
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4533E316D;
	Wed, 11 Mar 2026 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AoStovJ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436EE3E3162;
	Wed, 11 Mar 2026 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248808; cv=none; b=pgEl9xg8ZkuVCxzGc2DFilVLvV0NnCf+F2edBo9NPOEfiH+QDL6TBT8zbQR5USvDMygZLUD18ZM/Ur8vO2qeXqXjx+8XoMb7YGpEw73F5ZKleStI4f6246NbaURJJq77l6V+hwo0UhdqTXsMEAwQvaz90/D6KpNLaNxPmxIk0TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248808; c=relaxed/simple;
	bh=hE25WlnOxQU0cBaWomirABIDR684TjKmZbtgEL2N6cI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aQa3o7URaYgr9fsWkcb1HS+TCHh0j2CtBii/zHiELsdutJskTPE0XCY1gas5eNO736opUnED65G50hYpIwYhme/tmSOzV2bvG9kNV5fDyCw5f7G6+TRLvjulNsYEWEM4v9RGY8HqVdcPTwImJ1Mi4W/oZYi3pvqxRk7VF8TVGco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AoStovJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B7DC4CEF7;
	Wed, 11 Mar 2026 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773248807;
	bh=hE25WlnOxQU0cBaWomirABIDR684TjKmZbtgEL2N6cI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AoStovJ4cknTH9yf8FlPd44wCfgOrCKQtmFMEE4onuK4oRTUFWr8GrtMyQ73KdzR2
	 mk3N4PL/RhY8478yGUAJhBf5Xs8yReJMjtQOnmwL4Snre+Nlrre4BozPBHMnNC10+A
	 73/wiNs2fJsliWTx77SIUXaMKOrgPJkSo+U9qf0M=
Date: Wed, 11 Mar 2026 10:06:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: alexghiti@kernel.org, kernel-team@meta.com, akinobu.mita@gmail.com,
 david@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 gourry@gourry.net, apopple@nvidia.com, byungchul@sk.com,
 joshua.hahnjy@gmail.com, matthew.brost@intel.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Bing Jiao <bingjiao@google.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: Fix demotion gfp by clearing GFP_RECLAIM after
 setting GFP_TRANSHUGE
Message-Id: <20260311100646.81819c0f02eec5d3f1dcaa70@linux-foundation.org>
In-Reply-To: <20260311110314.237315-4-alex@ghiti.fr>
References: <20260311110314.237315-1-alex@ghiti.fr>
	<20260311110314.237315-4-alex@ghiti.fr>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224727-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,meta.com,gmail.com,oracle.com,google.com,suse.com,cmpxchg.org,bytedance.com,linux.dev,gourry.net,nvidia.com,sk.com,intel.com,linux.alibaba.com,kvack.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:mid,ghiti.fr:email]
X-Rspamd-Queue-Id: E3342267C35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 12:02:42 +0100 Alexandre Ghiti <alex@ghiti.fr> wrote:

> Fixes: 9933a0c8a539 ("mm/migrate: clear __GFP_RECLAIM to make the migration callback consistent with regular THP allocations")
> Cc: stable@vger.kernel.org

Please let's have the cc:stable fixes separated out from the cleanups,
and prepared against current -linus mainline.

Also, when proposing backportable fixes please ensure that the
changelogs carefully describe the userspace-visible runtime effects of
the bug.

Thanks.

