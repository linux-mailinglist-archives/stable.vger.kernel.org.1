Return-Path: <stable+bounces-230749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GASIw0kx2lATgUAu9opvQ
	(envelope-from <stable+bounces-230749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 01:42:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 221E534CC56
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 01:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04C42304F21D
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 00:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0659C1F37D3;
	Sat, 28 Mar 2026 00:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIQtZgA2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8670AD5A;
	Sat, 28 Mar 2026 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774658570; cv=none; b=cmpOJBvW4dj+o0YQcq4uzQnzd1heBGMaVzOEUbnCVMLj0Gdj2QPXRJCGXgpyxx9yVcUeVSqeECEq1XkCdYEilqpuLGzVeFef3sCWs1ZFBveCBoV2SNRMPnXZNEHRdG6X8BGeCbepl+aoBOW3S+E+3BuxJ0AmgdpppHg81eR+XjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774658570; c=relaxed/simple;
	bh=tHes9tujM299r1urFSferkNbsuKXc5jy+H3o7lTRdJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7gQ1kZfh/CRsQbM2X4NyZEG956gPaK29qzuGMWSJyWflHj++JFMFTyLsRcVpBuF7FhWvuIq7YyDpH4Fdym56DeFtVfSwCrgoF26wS2HFAWIUiFidHUQNsYXZ1dke9EKWbOQXpnC2SLZ8r00wiHHdA+IDSHb9LsTqMuUPp1yc0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIQtZgA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596C3C19423;
	Sat, 28 Mar 2026 00:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774658570;
	bh=tHes9tujM299r1urFSferkNbsuKXc5jy+H3o7lTRdJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIQtZgA2OfkDInqDspKtfTq6oZwEBuFw1b2Bb3qBuqJEzI+9tRXVNkRd59vntaQvb
	 +t304fg1jVcAGb/hg5iIWKI0P13043WPWATwdg/LbXMpnEi6mQq5CAcult9oNJg9fQ
	 S1nxOHCKtQEKW62Hz6PDfUMLGVefT4kF93T7fp9e7OdCo47Dlfs3xDTmSvcwkq2B/1
	 TuwPpUrUsHItrlTe0Iw4FEibeCEqLK3Qa9ka+yv2P8IibElytBJ8UrPe8g7ZpGkQAg
	 OF/Cy5Y0Mal1pyCKx4OPAHI04Psdk1VP61gxd/V6GDQxrH9K1LY7Wtrnaos+1aPn3A
	 PU29NlSAoHOLQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [PATCH 0/2] mm/damon/core: fix damon_call()/damos_walk() vs kdmond exit race
Date: Fri, 27 Mar 2026 17:42:48 -0700
Message-ID: <20260328004249.7135-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327233319.3528-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230749-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 221E534CC56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260327233319.3528-1-sj@kernel.org

- [PATCH 1/2] mm/damon/core: fix damon_call() vs kdamond_fn() exit race
  - status: Reviewed
  - review: ISSUES MAY FOUND
- [PATCH 2/2] mm/damon/core: fix damos_walk() vs kdamond_fn() exit race
  - status: Reviewed
  - review: No issues found.

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260327233319.3528-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)

