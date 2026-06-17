Return-Path: <stable+bounces-266603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V/dvJUf1MWpVtAUAu9opvQ
	(envelope-from <stable+bounces-266603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 03:15:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF996695EDF
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 03:15:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XtVHyrcM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266603-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266603-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 707223130133
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 01:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC514A4CC;
	Wed, 17 Jun 2026 01:15:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C31DA23;
	Wed, 17 Jun 2026 01:15:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658930; cv=none; b=Fs7y7OeHz2TUDo6W5CFVLJt8KuRlawZqgZkNU4jH3iyGE6FXoUJ98XnBw3YpR025BthIYH5t9ol/ROKx0ez1Jc2FEDa9vYo+ygb8FABAlD7eap5r6teDcN8S4fGr+hP4rlu39F0oUL1cXGVoyypbKmH+9PzGO2kelNhdyOv9bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658930; c=relaxed/simple;
	bh=TeaJbrTcCkVXCa67T1iKXQjBnSyzcdQ/W2DnWwjeazo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxXBO38iZJBnIkZ6V1xc/8x2p3+zsW50W6BW5hxwdzNOF6+UDAbebynn3IaL9Z8sjn51eDppLXBgd81cfm+5QtEYQH25gsobL+BRPonBbBTG81tizyEAhUKacfxi012PmBib1VHOWTki74sPp2vNioc7ckRNprXkAoKiRYEnD/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtVHyrcM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404FE1F000E9;
	Wed, 17 Jun 2026 01:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781658929;
	bh=dM1CD/FOWTDMsQkMO4cV3iGVzS5NiXgDEdXuvMc7UEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XtVHyrcMIk5txVuolLmpB3cqHQ/dh64rbWqHqU9ALakHzhiZL+AyEpxmcxBg35Dlf
	 H2Pzi1mToJGu+iHz/eQkvko8dIdLzkIVRen1S1oR4kW9vtiY0ELYbM5IQKxZGkaCuG
	 Ign6lvUdpkJhuXmUyaoh3QY7W79MtmWTR8AyqZGauCG+ddX+FHjKv09bLrMijc9nCA
	 XPVgUZm6CPJRoTfX2r+HIq8MjcS8fqgdyKHmKsWbGZOMmxokiAUzpywKaFsNIoo/In
	 +FokXb7bOJNaJk4NnQaF5Al8jAlZwjw6wA1IjfNvyG+0ytsDMsyXtdq+7UR8JFBAlX
	 ZjGxHFzo3QB4g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/9] mm/damon/sysfs: kobject_del() directories that users can create/remove
Date: Tue, 16 Jun 2026 18:15:18 -0700
Message-ID: <20260617011519.97550-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616150844.88305-1-sj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-266603-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: EF996695EDF

On Tue, 16 Jun 2026 08:08:34 -0700 SeongJae Park <sj@kernel.org> wrote:

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
> This doesn't cause catastrophic issues like kernel panics or memory
> corruptions.  Users can work around by removing all directories first
> (write 0 to the nr_* files) and then create new directories after
> confirming the old directories are gone.  But, this is definitely a bug
> that causes a bad user experience.
> 
> Fix the issues by calling kobject_del() before creating new directories.

Sashiko found existence of similar issues in error handling paths.  I will fix
those in the next revision.

Sashiko also found more issues of different classes that can cause memory leaks
and uninitialized memory dereference.  The errors are unlikely (too small to
fail?) but better to fix asap, and apparently deserves different patches.  I
will prioritize fix of those.


Thanks,
SJ

[...]

