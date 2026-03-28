Return-Path: <stable+bounces-230803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG3oMYYRyGnDggUAu9opvQ
	(envelope-from <stable+bounces-230803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 18:36:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF534F667
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 18:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF4E6304D25E
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB7C3A5457;
	Sat, 28 Mar 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/oMVVgn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713F73A452C;
	Sat, 28 Mar 2026 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774719268; cv=none; b=d+tvRFQ/TeS17sqowqBMc7jtpaKkrO7t7tGCD1Ld+Di86GGt/TTLDd3djMs7U4S+YpoqzQGeD3/cH3N0yyVIZXtjmphNLk87zBy73Zad2baujpNMfPjFTzHvrTZaLuYHZz8saNW0/JvieGMyxInmuI62asUe2W99LRRDGnMWOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774719268; c=relaxed/simple;
	bh=fOA5Uccu62gNiQq1drddmXA4wHftfEy+C4gnJ9Tes1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCDU1dsivXfKUTQwJ5zqCM0SwmUjZJtX+sm9nt+jz9mT6fLrdFFI0vxfO7ZBqKSIJMVJ3bZjFCaifjCl6TYCc4VsB4QroFbvGW08a14tj/GuM1d6EzqLq+kRPUljP7W70VlysAOQSeTLPAPrETkr8Kx9WWHP7qa0mGs+eqxZ+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/oMVVgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C859C2BC87;
	Sat, 28 Mar 2026 17:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774719268;
	bh=fOA5Uccu62gNiQq1drddmXA4wHftfEy+C4gnJ9Tes1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/oMVVgnOa+nVGaWZBR5fpmlzGs25Q+kUaxddBMl9zcA5kKYdNuTVr3WHzXn/7UrG
	 gPmMPyqIJx97iyit9NdCplbHlLptwBHGUkO0vR6zq3Swb6yTQK0S5sNZrX2xgp31Hy
	 VdzeAcY9j/kxg8ANEYVh1QPNyqd1VVpsFplaoi6x6zh7rdeMqycK/h/OH9860+cxBE
	 2jQpbw0L+aV7MSH3H98g//Nz80KH1/kzVi6eur/XgG988L64rpbIWWS7zNxZjdrvi7
	 FFMMUdZTXgiLovI+DKsSQbgC7wN+sh85I9Z8e1FxzBaHcJBf0K4pUP2HBHauZaKVMi
	 QxVB3M56fohpw==
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
Subject: Re: (sashiko status) [RFC PATCH 0/2] Docs/admin-guide/mm/damon: warn commit_inputs vs other params race
Date: Sat, 28 Mar 2026 10:34:25 -0700
Message-ID: <20260328173426.52911-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328172415.49940-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230803-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6FFF534F667
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260328172415.49940-1-sj@kernel.org

- [RFC PATCH 1/2] Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race
  - status: Reviewed
  - review: ISSUES MAY FOUND
- [RFC PATCH 2/2] Docs/admin-guide/mm/damon/lru_sort: warn commit_inputs vs param updates race
  - status: Reviewed
  - review: ISSUES MAY FOUND

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260328172415.49940-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)

