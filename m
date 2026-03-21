Return-Path: <stable+bounces-227790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHT+MNL5vmmxnAMAu9opvQ
	(envelope-from <stable+bounces-227790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 21:04:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA0D2E7195
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 21:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15C92301386A
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 20:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1E3491C8;
	Sat, 21 Mar 2026 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql64Gy3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9E2AD00;
	Sat, 21 Mar 2026 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123471; cv=none; b=Tvux7hyFgkBE9E8it3acl6S6OrlnBJRAotH7SprkfOpkPbWDYQbPqI1DErb8ZAruGZDhHIUUnKjGyYGA1aYK+J9eyuiHlmOZxU7GGVFwugPtvAe48j8G8yWJm4f2iNJtHWmoQAOpNpBgqQm2gmA+yrJXuvrWYMZew/wBLbt5Two=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123471; c=relaxed/simple;
	bh=fr4AW+FIvrg9qZ2BWoFT8YfqJnfX24S5Bi94dTj4oAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFrbXPbVvXWSnhncjgISR9JSpTvTl6nGk2F98dlwzJnpXBcvfgFeyisedu/+kW2ntPZCMZw5JW+BqwL8+49TTmedW0XUxIONXT9x9ZRBpCUs/3tkNiIebBgdLTtwEG1OyDEOEiRzLOtLaOvekiDnqbtKPFPAagOJ76DrPA4oFUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql64Gy3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084AFC19421;
	Sat, 21 Mar 2026 20:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774123471;
	bh=fr4AW+FIvrg9qZ2BWoFT8YfqJnfX24S5Bi94dTj4oAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ql64Gy3nJI5rno891UT38jj+j5m6B1xazDxJIHtl1KbyKMYmU0J8Lds4xFCuCLfPb
	 yEUCFvE8Zv6pei+l0xdJcWWf/9xaxkiHA5zda5YRi8kbj+VjzPVeF2zD+AI1Og93K1
	 /1z30ioGxDRhqfqPEFDo4rPMJFSzybt8VdO80I7AKcOpE6twadRjmlnQBjXfamcgjg
	 Zahp08RiaxlkY6jywrwILGvh+if/lnYNkvivkkxtdTZE+/ZwURzhX2h/eIUa+fRKkG
	 oFNAFqRaIGOEz3AujWDXLV4yMwiUlbLeSNNemWXQ2S7ohefAWPHXkpoq05cnf5ZTkW
	 HwCJ1B5k3jfnQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review status) [PATCH v3 0/3] mm/damon/sysfs: fix memory leak and NULL dereference issues
Date: Sat, 21 Mar 2026 13:04:21 -0700
Message-ID: <20260321200422.95288-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321175427.86000-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227790-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 3CA0D2E7195
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260321175427.86000-1-sj@kernel.org

- [PATCH v3 1/3] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
  - status: Reviewed
  - review: No issues found.
- [PATCH v3 2/3] mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
  - status: Reviewed
  - review: No issues found.
- [PATCH v3 3/3] mm/damon/sysfs: check contexts->nr in repeat_call_fn
  - status: Reviewed

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260321175427.86000-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail


Thanks,
SJ

