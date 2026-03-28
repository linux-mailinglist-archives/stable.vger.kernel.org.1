Return-Path: <stable+bounces-230805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMGKMVERyGnDggUAu9opvQ
	(envelope-from <stable+bounces-230805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 18:35:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C1F34F649
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 18:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D65073020850
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAA1378830;
	Sat, 28 Mar 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOGGzvOo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD061F8691;
	Sat, 28 Mar 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774719306; cv=none; b=l+4s2p45zO/b/58t/Af8sChJ2D6eke40se5MLdPUct5GtilarSHl+mvInf/QeCOLzm578p7DX+zq0LvtDTnwza4l2hP3y/Bi8qzhpDJ4MOeDCRUTn9I5CPnWfcV80chfwlso8dchGLXG4Y2MLoccNt+twoRRP3lLKSZhJKVGkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774719306; c=relaxed/simple;
	bh=biVWiq4oiHUokf5prmGi2zOm6O46A0l0CX4IkwN2tRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUfi2wABOBpll0UEcDVxssvoLBz7Mf/Iii6lhtpSQVsKEyU+VFUfH6nW0ECDT+vY0G6shqCLMWubV1sVE7mRFno1dOK75Jp3Jc+Aa4D3IyBoF+5w3QFw/rKq2wGxOwL0nRTbCzZfOT2nuLmWAbD5dkezdUhbPlB4n4ju74I8/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOGGzvOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A52C4CEF7;
	Sat, 28 Mar 2026 17:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774719306;
	bh=biVWiq4oiHUokf5prmGi2zOm6O46A0l0CX4IkwN2tRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOGGzvOo8hbG6EbtYhDMaVUFzGmyJ6JWXrCoc3aaQOQFqf9X9qHT6HgXFG/VNAsaT
	 1DvUIsGr1Z+d+S883n6XOxsp1EkeSXiqNt9X13Qf2fHHxD2fzDAoJFaxkCXAG9taNT
	 CIBGwDULN+McIOhrhfzQ4lcnsRMecirlhxJOwnYgBgfRPLpVsfSRNc8MjC3PeNxTrY
	 HbZqzTlUm43lsUuJyeg9wdgKQTAkbizl78h+OsPD2THijoHZZc3s/EKT7Wi6opVNJB
	 FnTCf3Z7hbA7Qbu1/zLspDkVkY8rl1YOnmMmxYuxsmkPLnQp+N62RjpSLAa1DoIEzH
	 xr3KrbbxZ7uCw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 6 . 0 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: (sashiko review) [RFC PATCH 2/2] Docs/admin-guide/mm/damon/lru_sort: warn commit_inputs vs param updates race
Date: Sat, 28 Mar 2026 10:35:04 -0700
Message-ID: <20260328173504.53129-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328172415.49940-3-sj@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230805-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 45C1F34F649
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260328172415.49940-3-sj@kernel.org
# start of sashiko.dev inline review
commit 0a9a055d4225a92c337c76fef97bfcdca5d9508f
Author: SeongJae Park <sj@kernel.org>
Docs/admin-guide/mm/damon/lru_sort: warn commit_inputs vs param updates race

This patch adds documentation warning users about a data race in DAMON_LRU_SORT
when modifying module parameters while the kdamond thread is reading them. It
states that violating this rule can cause undefined behavior in the kernel.

Link: https://lore.kernel.org/20260319161620.189392-2-objecting@objecting.org

> diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
> index a7dea7c75a9b..3eaa3786c8ab 100644
> --- a/Documentation/admin-guide/mm/damon/lru_sort.rst
> +++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
> @@ -79,6 +79,10 @@ of parametrs except ``enabled`` again.  Once the re-reading is done, this
>  parameter is set as ``N``.  If invalid parameters are found while the
>  re-reading, DAMON_LRU_SORT will be disabled.
>  
> +Once ``Y`` is written to this parametr, the user must not write to any
                                  ^^^^^^^^

This isn't a bug, but there is a typo here (parametr).

> +parameters until reading ``commit_inputs`` again returns ``N``.  If users
> +violate this rule, the kernel can do undefined behaviors.
                                        ^^^^^^^^^^^^^^^^^^^

Should this data race be fixed in the kernel code itself rather than just
documented?

The kernel generally should not exhibit undefined behavior, memory corruption,
or crashes due to concurrent sysfs or module parameter writes, even if those
writes are restricted to root users. Could the underlying code be updated
with proper synchronization to safely handle concurrent updates instead?

> +
>  active_mem_bp
>  -------------
>  


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260328172415.49940-3-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260328172415.49940-3-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)

