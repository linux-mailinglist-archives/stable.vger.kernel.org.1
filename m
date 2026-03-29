Return-Path: <stable+bounces-230953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOjQKu5KyWntxAUAu9opvQ
	(envelope-from <stable+bounces-230953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:53:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE6C352B5C
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42BB53044166
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AAD3750DC;
	Sun, 29 Mar 2026 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rccDmTva"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AE23002DF;
	Sun, 29 Mar 2026 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774799397; cv=none; b=C+0oW6cmblFViZRousiihFktxFOKW5Ezxa1p7/CXJZAwKD9qGzPhOB63BIoD5sE4wvZ0KVJyI8uxhjeZLUWXs+cX5+ueWF2Qps251V9ClWHnUsy7r8gAcJprK8o8wvIbGxjhN29B/EOy/Nwn26x+IYVHamc0qro5HMC863j0X6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774799397; c=relaxed/simple;
	bh=iE1Cap7oN+cp6nkIZohrvPTbgBqghi/30U/wEpUeb2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIYMnSiINxV3AAUpTUXesEkhijnkM6Umlyc5eXv+gI5tj91yDAS2DRUcxV4hpo7zDR0vS8ULLst8YPEXgSRqc/AAPAMZYvaaRreH8wUU9AchPcG5RuSpDwvl90jd5jfx79ThebjyS8uijoiEVGq33eRXcVM/DgYqGkP8vFaipwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rccDmTva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23B5C116C6;
	Sun, 29 Mar 2026 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774799397;
	bh=iE1Cap7oN+cp6nkIZohrvPTbgBqghi/30U/wEpUeb2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rccDmTvaNBFtG9O+4KtDSMXF6lJD4aeHtHbnhdOu9vkiC7eSwr9SvG/jFYNbZNc6g
	 JN+OX3Hr2QjdpnVuQvJb1sP2J341QhyVxuUZSXP7gH5k+LpF2yNH32nZCmSzQaZ4c2
	 fwDx+1W9h5Rlffzx2ysJkKIAvndzh54p+HfJguh/edCJFyTxzeTUWob8Hbpcb7CLSu
	 fDz7G7LvlieYNbfcQslHnSSsG3DmcNdDYBzNcr2IT5cBrFv650AtxtAfZAJsFMJepO
	 e5S0oYofBVoqC4N7U/lHOE9maIIgdhrzT0uM+XZBWBF3Hb6MSIXMeh4nuGohvpUoHr
	 w3FkpWiHDbqkQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 6 . 0 . x" <stable@vger.kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH 2/2] Docs/admin-guide/mm/damon/lru_sort: warn commit_inputs vs param updates race
Date: Sun, 29 Mar 2026 08:49:54 -0700
Message-ID: <20260329154955.47813-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329153052.46657-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230953-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EE6C352B5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260329153052.46657-3-sj@kernel.org
# start of sashiko.dev inline review
commit 7f5e14b7be3b4aea36d62a6c529ef25dde22e973
Author: SeongJae Park <sj@kernel.org>

Docs/admin-guide/mm/damon/lru_sort: warn commit_inputs vs param updates race

This commit updates the DAMON LRU_SORT documentation to warn users against
modifying module parameters while the kdamond thread is processing a
commit_inputs request. It states that violating this rule can cause races
and undefined behavior in the kernel.

Link: https://lore.kernel.org/20260319161620.189392-2-objecting@objecting.org

> diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
> index a7dea7c75a9b..14cc6b2db897 100644
> --- a/Documentation/admin-guide/mm/damon/lru_sort.rst
> +++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
> @@ -79,6 +79,10 @@ of parametrs except ``enabled`` again.  Once the re-reading is done, this
>  parameter is set as ``N``.  If invalid parameters are found while the
>  re-reading, DAMON_LRU_SORT will be disabled.
>  
> +Once ``Y`` is written to this parameter, the user must not write to any
> +parameters until reading ``commit_inputs`` again returns ``N``.  If users
> +violate this rule, the kernel may exhibit undefined behavior.

Is it safe to rely on userspace following documentation to prevent kernel
data races?

The kernel is generally expected to be robust against concurrent or unexpected
userspace inputs. Does addressing a data race with a documentation warning
leave the kernel vulnerable to crashes or instability if a user ignores this
rule?

Could this underlying race condition be resolved with proper synchronization,
such as locks or mutexes, rather than documenting the undefined behavior?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260329153052.46657-3-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260329153052.46657-3-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)

