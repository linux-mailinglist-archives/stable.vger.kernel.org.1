Return-Path: <stable+bounces-230804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IcFFcQRyGnDggUAu9opvQ
	(envelope-from <stable+bounces-230804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 18:37:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B4D34F686
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 18:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A49E302E785
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539921F5858;
	Sat, 28 Mar 2026 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnSb9kG1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B0F21CC4F;
	Sat, 28 Mar 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774719288; cv=none; b=L342LMVCAbmzKtm8E6CmlgVVYvmN6UCR586Q1CVKw6FTB4Dy4ZR78XoDPW1E2fUHS4F2tz7LwFXcTyX6BGZxEYS/ov+xMC7fT+BJYBCthngy1GxZRlykZBrTknIUZfuRVzJchMketBaoVRL3WwExHubtC60uZV3tWsrtnhI2HFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774719288; c=relaxed/simple;
	bh=aQ3MMdx7p7PT0107c2kdHBgzcaOXQ1T/12rvaMrKp9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJL9mEBZ5hyJ/hQmRvbJcIPPBOA4UovDjIBfZydI4csCXGt/gr0xtfgf0m1A+BFcDcm+xPKBCP7ZgvG6tMPTHxIOyaMx3T/tIk2s3emzoo5UueckFeB70U/EALwH+sppVzOZp4J2KAbLA+ABr45fKnakYn8RZ7nEEylSCRSeenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnSb9kG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E668C4CEF7;
	Sat, 28 Mar 2026 17:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774719287;
	bh=aQ3MMdx7p7PT0107c2kdHBgzcaOXQ1T/12rvaMrKp9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OnSb9kG1bYqnldIcBcKk2EvB36oYLB60sQIZih0Af2UU8DMKt7bgMPnsEFQM47lkQ
	 cZWyXz8t+BI7uVKPROxL0ivzwEmhHHcPWXpS3GSMwq4K3aIfRF31AIU6GlPO4DkTnI
	 hMBHdDenxqEIi33zgMeU5iOUnneJE/0rBUR6LLnDR0vGj6TPbUFm3gxJlzzSd5U4cv
	 gGYLc2BrXV9idYvXWmpvHdCrOtmBEp+xOMO//YTrkr1yPkT9YzUt3RR21ODF7zxX7Z
	 XS9WjI3qk56saHh+3E6+PUjpvVb3NezznMTlVlDQ9fKITzPBy7rQdI0MCoTHFOBLnN
	 HXxObClhzgAvw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
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
Subject: Re: (sashiko review) [RFC PATCH 1/2] Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race
Date: Sat, 28 Mar 2026 10:34:45 -0700
Message-ID: <20260328173446.53021-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328172415.49940-2-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230804-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 00B4D34F686
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260328172415.49940-2-sj@kernel.org
# start of sashiko.dev inline review
commit 8b189801fc104c5ecc412454a3d8db6a3faf27d6
Author: SeongJae Park <sj@kernel.org>
    
Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race

This commit adds documentation warning users not to write to module
parameters while commit_inputs is in progress. This warning is intended to
help users avoid a race condition that can cause undefined kernel behavior.

Link: https://lore.kernel.org/20260319161620.189392-3-objecting@objecting.org

> diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> @@ -71,6 +71,10 @@ of parametrs except ``enabled`` again.  Once the re-reading is done, this
>  parameter is set as ``N``.  If invalid parameters are found while the
>  re-reading, DAMON_RECLAIM will be disabled.
>  
> +Once ``Y`` is written to this parametr, the user must not write to any

This isn't a bug, but there is a typo ("parametr") in this line.

> +parameters until reading ``commit_inputs`` again returns ``N``.  If users
> +violate this rule, the kernel can do undefined behaviors.

Is it acceptable to document a race condition that leads to undefined
behavior instead of fixing it?

Even if the module parameter interface is restricted to root, user space
shouldn't be able to trigger kernel undefined behavior (which could lead to
memory corruption or crashes) simply by writing to module parameters
concurrently.

Should the underlying race condition in DAMON_RECLAIM be fixed with proper
synchronization rather than relying on userspace adherence to a documentation
warning?

This isn't a bug, but the phrasing "can do undefined behaviors" is slightly
awkward. Rephrasing to "may exhibit undefined behavior" might be more natural.


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260328172415.49940-2-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260328172415.49940-2-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)

