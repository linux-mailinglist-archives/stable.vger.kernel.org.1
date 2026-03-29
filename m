Return-Path: <stable+bounces-230950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QtGiEOtJyWntxAUAu9opvQ
	(envelope-from <stable+bounces-230950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:48:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE30D352AD8
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70DCC300F1B9
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2472D1F7B;
	Sun, 29 Mar 2026 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHSN4DXX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BCF262A6;
	Sun, 29 Mar 2026 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774799336; cv=none; b=XIoW9zSKW6G3aEimd1ueRwBRguqbWttwL7c0zWNUAOWB9wc+bEvrk2b2G/B/8Z4IDA+p6qWM1U81xOXfCMgB4xXb+bAOsJpDU4Z9Y7NemZ9XiGoKUk6yMNgYJe+5c039yqtgx/sC+yaUwYjqSXLS8fLHg6UZJ7JQDPTMuVt4zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774799336; c=relaxed/simple;
	bh=uFlnHGPshtBX5FJk/XUTu+B080pyjwAI0haVlLOs8bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFKGo6IEfcmbzVY90cq68g4OGOzEPDH+G2PL5EpBIO9LY179JPqTnLVjYz3m/ZswpVRZT5J/TY6WnURP+zyuWeICCp9b1e4Rwmg6nnEr9KxZzoqg/fLePFZm10Q0qc97gzuhCM8pHpOkaflWQaX8D6oMVd1R04tHAAytt6qYFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHSN4DXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C242C116C6;
	Sun, 29 Mar 2026 15:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774799335;
	bh=uFlnHGPshtBX5FJk/XUTu+B080pyjwAI0haVlLOs8bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JHSN4DXX1Ydb153rJVr5YkooYmk3omfxJ38GMHeu1nGuFR+PKTrjKGUR0PJCXb9pq
	 9aI13xBG9NHGk5FhU7ki1+sAKCC5ZYaKcBE+v0ZbrGRyxGxiXGf1sft73TN2CM5IlX
	 bnUwkiby6AXiz4HYnKYh2bb2JbU70rfqlkKfjQUAwYjv2SlwEG8wfjKDQixV7ZJLW+
	 OkLJp/JRs1UNnQngFV2UIpGRSExFdSKn4TSwfFs4Mh+QMeXI82zDToHqJmouaLKWv2
	 +SuGk28kRSV4BMph7m2AxhKzbsY9SY4KQaKFtatSTWSorOaGfJlpa7w5l+8p/EZXe9
	 IIHxVl+tt9bCw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [PATCH] mm/damon/core: use time_in_range_open() for damos quota window start
Date: Sun, 29 Mar 2026 08:48:53 -0700
Message-ID: <20260329154854.47490-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329152306.45796-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230950-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: AE30D352AD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260329152306.45796-1-sj@kernel.org

- [PATCH] mm/damon/core: use time_in_range_open() for damos quota window start
  - status: Reviewed
  - review: No issues found.

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260329152306.45796-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)

