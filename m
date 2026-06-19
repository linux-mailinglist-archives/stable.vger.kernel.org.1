Return-Path: <stable+bounces-267292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MxSXANONNGqtbAYAu9opvQ
	(envelope-from <stable+bounces-267292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 02:31:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF086A338F
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 02:31:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="hwDu/gQF";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267292-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267292-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0689A303C7FF
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 00:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7081A0BF3;
	Fri, 19 Jun 2026 00:31:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A319CC0C;
	Fri, 19 Jun 2026 00:31:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829069; cv=none; b=u1ttx0capbgXDA1Y6zluLlfO7JUWRKCFDEo20pvknfCTrLyHUQTLGnIuhasplyKb+OkRTvPidPzMY2OYQHkNjcT97Pd/mUxF6Ys5DpFHIC13yazPjsAXQxyswbg31xd3IuoCmwvNzBxt/cBDlOnHQfCPUApDJcASwZQcyCWaiuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829069; c=relaxed/simple;
	bh=c8cySrTxQXTlU6I4M4atQIMWwqZGZI3eqI5uHorHSQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uzodq3LnwHiMQyidF7BnLWiMBDuOgoaq2guEy9VYfQCepRN9mvVE1mI9M/h5cJk03uwCJqZz2TiBEVQ2zxUZD6KIdwOOValpwROtAgcQ1ZxUWniWSFDYoLzCQjaBc7Mt8SjEHOHyG8VRx5hpdCTX2zyPVAbYHydX7SwXmWmTOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwDu/gQF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0971F000E9;
	Fri, 19 Jun 2026 00:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781829068;
	bh=utvfSl21aCDRZRwyVcgp4w+0VdsKPaEHtWbnJKfr1i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hwDu/gQFRInZmm6OJPBU8nh54p18ZN3ioLtEZGDM4y2ytDQn3DWa8gVZTMlip/oAy
	 NwcgaI9Pa1QgH+6cZzqjeqtXqAaeR6pBC3q3zBNjw4tM/Akd4eWdQn/jpTqP2qvz1l
	 bunT1YVMuUvOtloFUgbgjaCkaTXiV1tINTKMDdrxeawgURjHfirnxJDj8ZrI8cF09r
	 ppeTJb1TbGVMtjg7LAvogO/rqZLPF9LuPq0mqblkz+5qPgNh2LyI4dfGoFp8Vgu+DR
	 yhHtkmqa39TGkeR08YVQMyf5+B3Yt056jKnMkd1KsaJk3CimY3J7znMFmBXU9Nj7CQ
	 ECJnKySwaU7hg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1.2 00/11] mm/damon/sysfs: kobject_del() directories that users can create/remove
Date: Thu, 18 Jun 2026 17:30:57 -0700
Message-ID: <20260619003058.8801-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618151517.5366-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:jiapeng.chong@linux.alibaba.com,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267292-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DF086A338F

On Thu, 18 Jun 2026 08:15:04 -0700 SeongJae Park <sj@kernel.org> wrote:
[...]
> 
> This doesn't cause catastrophic issues like kernel panics or memory
> corruptions.  Users can work around by removing all directories first
> (write 0 to the nr_* files) and then create new directories after
> confirming the old directories are gone.  But, this is definitely a bug
> that causes a bad user experience.
> 
> Fix the issues by calling kobject_del() before creating new directories.

Sashiko found no real issue from this patch, or pre-existing ones that better
to be fixed together with this series.  I will drop RFC tag in the next
revision.

I consider this series as hotfixes, and therefore Cc-ed stable@.  But, because
the impact is minor, I will post the next revision after I believe all MM pull
requests for this merge windoow are completed.


Thanks,
SJ

