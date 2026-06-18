Return-Path: <stable+bounces-266960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PzUfK39AM2rL+gUAu9opvQ
	(envelope-from <stable+bounces-266960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:49:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C47969CED2
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:49:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="FOW/0VTy";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266960-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266960-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE932303661F
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 00:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708C227EA4;
	Thu, 18 Jun 2026 00:49:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447D15E8B;
	Thu, 18 Jun 2026 00:48:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781743739; cv=none; b=oUXG3qC6562n+ETdeD4ER/9ALFE+uqDZbJEFcZPz33qhnNODoofIojrejXqG3NF+J70dtPm/XaHeqijDIwMFjYq/ezE2OOwsRzm1fJl0u/rBKlDsh3lRrLhqBDorEwny3EUhjrI8xuObznyWqwQqXPjk/8Tj8ah+qz6LaHAoRcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781743739; c=relaxed/simple;
	bh=ctgUvoya/JNIQ05AFyQIJUtDLEPSiHQDqGdoz5JUQGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmRyIRBqm3Pq+tT6XrNKwaPGabmPQ5LG3sBJQMfVUk2JU6x6hTBpezTW1DqPFJRmrPFkgFVY3HOlNlLeofvPaY/2UPKXhSI7SlDTCC2jeZjWaWY5FGHqDsLYt/iC5UNdfUrSyzJM4XT01i8BesHBRy6xHXh6zCmTAFQzeZJ5Yrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOW/0VTy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA121F000E9;
	Thu, 18 Jun 2026 00:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781743738;
	bh=e2siXldkd8gt9W8aNqIsv9pczU/rHdB6+j/Y0wX3poc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FOW/0VTy7qryoePanimvF1XJH9LkSYN+89HzcEmjF8nDZxY8jCKJlK7z+qIuQDjhV
	 QfSMAFvXi0bAObRLAiuHuxGLue7nKOWO3DAkgmA+YKHNj+CjYr0F2DzF5MMoeW0fpL
	 9+P75al+e5kCL/U81sPPcA4+ejsRVICHaBOZkFa9kT+1lCPvTmyyj5Ml4BTkgsi6un
	 D7M90+VjWELVvcuEo6klNUWbEgbi3qdqvwFSrhGDELX4gYg2pRkoVBTzG2kKHU0VJE
	 LddkFMVqblXVGZFm2Z5ptLwFekRC51C43blCJgHqmWqrUf5foDR4EHqfQBbH0YOyHQ
	 zm9WHxYkyaRig==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1.1 00/11] mm/damon/sysfs: kobject_del() directories that users can create/remove
Date: Wed, 17 Jun 2026 17:48:49 -0700
Message-ID: <20260618004850.82407-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617144807.91441-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:jiapeng.chong@linux.alibaba.com,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266960-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C47969CED2

On Wed, 17 Jun 2026 07:47:54 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON sysfs interface allows users to create and remove arbitrary number
> of directories on sysfs, using a few files having 'nr_' prefix.  For
> example, 'nr_kdamonds'.  When the user writes a number 'N' to the files,
> directories having name starting from '0' to 'N - 1' are created in the
> same directory.  The pre-existing number-named directories are removed
> before creating the new directories.
> 
> For the removal of the existing directories, DAMON sysfs interface use
> only kobject_put().  Because DAMON sysfs interface is the only kernel
> component that manages the directories, there is no problem in normal
> situations.  However, if CONFIG_DEBUG_KOBJECT_RELEASE is enabled, the
> removal of dirs are delayed.  Let's suppose a user writes a non-zero
> number to the 'nr_*' files while there are pre-existing number-named
> directories, on the config enabled kernel.  DAMON sysfs interface
> decreases the reference counts of the existing directories and
> immediately creates new directories.  Because the removal of the sysfs
> directories is delayed, it shows some pre-existing directories of the
> same names when it tries to create the new directories, and fails.
> 
> For example, the issue can be triggered like below:
> 
>     # grep DEBUG_KOBJECT_RELEASE /boot/config-$(uname -r)
>     CONFIG_DEBUG_KOBJECT_RELEASE=y
>     # ls
>     nr_kdamonds
>     # echo 1 > nr_kdamonds
>     # echo 1 > nr_kdamonds
>     bash: echo: write error: File exists
>     # dmesg
>     [...]
>     [  300.880458] kobject: kobject_add_internal failed for 0 with -EEXIST, don't try to register things with the same name in the same directory.
>     [...]
> 
> Some of the error handling paths of the directories also lack the
> kobject_del() call.  If the user uses nr_* file right after the errors,
> similar issues can happen.

Sashiko found [1] one more issue of the same class in
damon_sysfs_schemes_add_dirs().  I will fix it in the next spin.

[1] https://lore.kernel.org/20260618004428.82261-1-sj@kernel.org


Thanks,
SJ

[...]

