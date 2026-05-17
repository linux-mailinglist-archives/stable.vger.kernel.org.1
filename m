Return-Path: <stable+bounces-249135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QELZCFwACmoOwAQAu9opvQ
	(envelope-from <stable+bounces-249135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:52:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F72C562C89
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 966BD30087BA
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D73C584B;
	Sun, 17 May 2026 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIXT3IN1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3D130AABE;
	Sun, 17 May 2026 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040342; cv=none; b=q5/Q6W8PW8KmwKRicMioMkUjLFcI7Yt15ij/pNc7siNBRbl+8wDU3PKZIEI/Jq6NPBWHGdW3UsPHAGnR7FQBRBPopZGARR5ABW+4CBIPvBbcVCSWGgHBrlUP8IKOiGoeG5F0i7+m4sxJdr4ymkqke/ijSidmBOmCOpmv8ZPHcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040342; c=relaxed/simple;
	bh=AcuclMGPrrOW6Za7tUM4Up1CwRxD1Fm9/Uh9lY+5/3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcrDT4okHy3aZtPTSrbD8mkPvivvq4le3/CzCFDAgj/2Yl5UeJV9iSbBCwKrM52NCowGtcxh4ocpADQhVIXsbqEBDhj9lWIyxt/HkjPd7iMQVKEKRvAvTLSq955QwlmoOpXhp3X7LRC3Zf/UruDIsezgTpIHg1cmOaVfmaltoqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIXT3IN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA28C2BCB0;
	Sun, 17 May 2026 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779040342;
	bh=AcuclMGPrrOW6Za7tUM4Up1CwRxD1Fm9/Uh9lY+5/3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIXT3IN1LvSWc2kCiJwSKg5zgzy4OE9mn+0aPXI/kO25/LVsh3U+BzDgHDAsRraw+
	 reJ9tgcy0bOkepViNnGLjONy6ujSISAp66gT1J3b/K7laoB4jcLBM1PSS2alfhIDKY
	 89gT2bGzQir9LPwwFXktzT32STfi0cRgQ8u9payWBQNqe3IAZcxu38QZDJexaZdeRs
	 a3/e5F1Ixbbwf2bT/NUT/mfVIwZW7U5GVTwfltTpzbUPM2UdCig0teGjNRpkgThX/A
	 7xPPQJYYG1ZYK6xiVVpDiIL0knUom1eajpcUuQ/Yu0FkZTecvxzQF5plMZOKL1mPd+
	 DapYS2s72ut0w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 2 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2] mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
Date: Sun, 17 May 2026 10:52:17 -0700
Message-ID: <20260517175218.2272-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260517172624.888-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F72C562C89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249135-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On Sun, 17 May 2026 10:26:21 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON sysfs maintains the DAMOS tried region directory objects via a
> linked list.  When the user requests refresh of the directories, DAMON
> sysfs removes all the region directories first, and then generate
> updated regions directory on the empty space.  The removal function
> (damon_sysfs_scheme_regions_rm_dirs()) only puts the kobj objects.
> Deletion of the container region object from the linked list is done
> inside the kobj release callback function.
> 
> If somehow the callback invocation is delayed, the list will contain
> regions list that gonna be freed.  If the updated region directories
> creation is started in this situation, the list can be corrupted and
> use-after-free can happen.
> 
> Because the kobj objects are managed by only DAMON sysfs, the issue
> cannot happen in normal situation.  But, such delays can be made on
> kernels that built with CONFIG_DEBUG_KOBJECT_RELEASE.  On the kernel,
> the issue can indeed be reproduced like below.
> 
>     # damo start --damos_action stat
>     # cd /sys/kernel/mm/damon/admin/kdamonds/0/
>     # for i in {1..10}; do echo update_schemes_tried_regions > state; done
>     # dmesg | grep underflow
>     [   89.296152] refcount_t: underflow; use-after-free.
> 
> Fix the issue by removing the region object from the list when
> decrementing the reference count.
> 
> Also update damos_sysfs_populate_region_dir() to add the region object
> to the list only after the kobject_init_and_add() is success, so that
> fail of kobject_init_and_add() is not leaving the deallocated object on
> the list.
> 
> The issue was discovered [1] by Sashiko.
> 
> [1] https://lore.kernel.org/20260513011920.119183-1-sj@kernel.org

Sashiko failed reviewing [1] this, due to the not-yet-updsated mm-new tree
baseline problem [2].  I will rebase this to mm-stable and repost.

[1] https://sashiko.dev/#/patchset/20260517172624.888-1-sj%40kernel.org
[2] https://lore.kernel.org/20260514205555.51653-1-sj@kernel.org/


Thanks,
SJ

[...]

