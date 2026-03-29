Return-Path: <stable+bounces-230944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI1tOdlGyWkAxAUAu9opvQ
	(envelope-from <stable+bounces-230944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:35:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5E0352A2E
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66418300B455
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D0C37646C;
	Sun, 29 Mar 2026 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKlaSMtr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C02AD00;
	Sun, 29 Mar 2026 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774798429; cv=none; b=CXtk0A3ZVTWvJW+GaeAd820hDr2/3Bb3Ct3YT5/2TX0HaG0DUazK2cuoZwWJ6w27YgfvR4TXVeTdCG/ahiRcNcyL6hWHbNbq3fdYiNwqTdhTAeUHRo7eFvpWUckr1WhKL1gvyWGzxyPznVxZ/lnLSgyHeKDmAZJgJnBqSYrUnsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774798429; c=relaxed/simple;
	bh=UQZPnV7y0W6fAjqQLaYQLOo7olw+e+13QhFuEevENgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJ5Li/5iz++GBYeaqvEXOlE/OrgU+Eu0sAisF5J8Qn9JtoIDhKIDkoHEWSU5OGyrQ5jQpd1GoZYrjq97eXoaqniVOsqkOh8TCELC9HwNqefiypF8l5+4WN2rK7SM9MCJqaXg+adKi+4GR9F5VwNaUBn6DeYqk63EOSmRNjBEBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKlaSMtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A57C116C6;
	Sun, 29 Mar 2026 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774798429;
	bh=UQZPnV7y0W6fAjqQLaYQLOo7olw+e+13QhFuEevENgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PKlaSMtraqBGZgzWHbvU99LPd9sjizXZe0IhKXcSdp1fbif3Si1gLR1s/HtZgkQXd
	 l30rRvOe7odaVZ7xKzGkprRRMsSc8D0sizhMjPmmy5gj2Nj7ifMf+spoDIoDmVRzoG
	 mJX8+WPxU3UsV0zlWpX42U2xcXYy/CkHMcx4x+wd7IH/1rWV7tWQ8kE/aizrrIRu5T
	 ZVfVvUulLdddbFk+VIMaqDa5EvPk9ktDhmjJyRSbTL14FtnNley89Ve+deB7O5JSCT
	 L8xWt/q4qdaLCCY3MHE1Yu6BXwnWi7/pfJZRJ7d0yO5HQyajtNA0PPS5YasnhVlVdZ
	 Mhy6YSWGHkqag==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [PATCH 0/2] mm/damon/core: validate damos_quota_goal->nid
Date: Sun, 29 Mar 2026 08:33:45 -0700
Message-ID: <20260329153346.46881-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329043902.46163-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230944-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A5E0352A2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260329043902.46163-1-sj@kernel.org

- [PATCH 1/2] mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp
  - status: Reviewed
  - review: ISSUES MAY FOUND
- [PATCH 2/2] mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp
  - status: Reviewed
  - review: ISSUES MAY FOUND

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260329043902.46163-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)

