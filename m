Return-Path: <stable+bounces-240336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E0nL1ze6GlDRAIAu9opvQ
	(envelope-from <stable+bounces-240336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:42:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66724447620
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0D823013BB0
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC083ED5DE;
	Wed, 22 Apr 2026 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uje//+Uo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F93ED109;
	Wed, 22 Apr 2026 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868877; cv=none; b=EmRZw6UiXDsbVx3MNZeahL9c2x50Srly2tyI6EWO774W+pi53ptY6RQLTaDGEjzWy5VVg8QnjRKnhRdr+SMJZyI0LHipbUTKhhd3sPwIs+xHkLJaggWRTAJyIlzTXk8Wl0lUum+qwnjWkvvJT1VHnO3qXgC7GNzJDBxvcGppBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868877; c=relaxed/simple;
	bh=dPh+28e9o3rFcTZ19LGrpIKOeKqHRgIxt9m1cNTW0OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riRbT4BiG37q+0QJEdA4ZBJGHUuMZTpa6TG9FZM8In+s01SCqoXQJ4oGEaU7UWLEHs8L9CYZ+gl3FDqt4gvCUwm8aYP54W7CySQ/uqPEV2JR59c9pqRbDKgkue5bGDsboaai9r7WFmXoonda1cqOtmG6HFYiewhZsKm/774C0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uje//+Uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4D0C19425;
	Wed, 22 Apr 2026 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776868876;
	bh=dPh+28e9o3rFcTZ19LGrpIKOeKqHRgIxt9m1cNTW0OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uje//+UoTKmRJ5EoGDyItpPUxlbew9QtwD5e5jcyMBDhgk5QI6JF5kJG/fdtkc32F
	 Vva5ikvKVmSmlKRS8JSCBlRVI0DuNKbeneEvZyXp3OrTg2oVeAZ0um3pFGZuPIgvXe
	 uYxLOIRnwk2IqagrOgdEoAn3nLknWU+aov5+Y3dFoWx/fFTMQFGMl69p9Is/r6zAGR
	 Fj6lufcUj7ONPb/Jd2qUvGcxFQkKCVWfWY9ZODGbzszJzOQHt6zv2v9P4c1zSi4CIb
	 9YeHwGQKivViLtoodqTQy5EpcQh/9FbHDcMTU497CxLTtBlIKgqLWEkFd5aGL4tC6O
	 vihd6xExMyVHQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Junxi Qian <qjx1298677004@gmail.com>
Subject: Re: [RFC PATCH 0/2] mm/damon/sysfs-schemes: fix use-after-free for [memcg_]path
Date: Wed, 22 Apr 2026 07:40:59 -0700
Message-ID: <20260422144059.72000-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422143503.71357-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,lists.linux.dev,kvack.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240336-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66724447620
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 07:34:59 -0700 SeongJae Park <sj@kernel.org> wrote:

> Reads of 'path' and 'memcg_path' files in DAMON sysfs interface could
> race with their writes, results in use-after-free.  Fix those.

Forgot adding change log, sorry.

Changes from v2
- v2: https://lore.kernel.org/20260420125405.362137-1-qjx1298677004@gmail.com
- Split patch for individual fixes commits.
- Hand-off authorship to SJ, give Co-developed-by: to Junxi.
- Use mutex_trylock() instead of mutex_lock().
- Add RFC tag for Sashiko review round.
- Wordsmith commit messages.
Changes from v1
- v1: https://lore.kernel.org/20260420085332.178473-1-qjx1298677004@gmail.com
- Protect not only user-writes but also user-reads.


Thanks,
SJ

> 
> SeongJae Park (2):
>   mm/damon/sysfs-schemes: protect memcg_path kfree() with
>     damon_sysfs_lock
>   mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock
> 
>  mm/damon/sysfs-schemes.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 0d45806f3a75bf53e59475b0e56be324f650ab09
> -- 
> 2.47.3

Sent using hkml (https://github.com/sjp38/hackermail)

