Return-Path: <stable+bounces-269605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nTs7CJOpQWrftAkAu9opvQ
	(envelope-from <stable+bounces-269605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 01:09:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B0D6D53B4
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 01:09:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PHqGHSQJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269605-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269605-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 371453009555
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 23:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CA536F903;
	Sun, 28 Jun 2026 23:09:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A11DC985;
	Sun, 28 Jun 2026 23:09:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782688143; cv=none; b=UOVyrD7fLWBdB76oXjDGfHn4Arl6axlfMi4f7KDnnQMPw/AyeOyiOJH1SGIcAaC87K69+n3Ynsfk7qA8YEai2aG8NcILuAHU6G99AccGc1B2J0tDDNa4Fwh8og+w1io64Ju8l31d+BVuvxWkzFR0/iS7wNZ5uolMZoM3Ud7OU/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782688143; c=relaxed/simple;
	bh=vpucwcrz0yIGGuQhtNz1MkSTqCKSrrRzNcxGO3GUZNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aC4LgVmH6dExSya7spOAtbEMlknEBVDsq1LCz9uy+s2W/IdyXzHaLPyRQ2IZAeVApZLiNWK+vMvSZxL9YFH350lK1JUVgExjcRBwuOEMA+VEzZIsQJDVdHjiFc6PhvmC7JZl4PZ0GjUc4rvCQ23l7NG+VBr7nong6KiqMTGsKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHqGHSQJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DF61F000E9;
	Sun, 28 Jun 2026 23:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782688142;
	bh=6HB9ne7se5fKQqWKCBXbtR4ksGRhmshThDdr3tHubv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PHqGHSQJUOicbB9Y8qgSNQEcnFjEJKhhpQHRU1OSf4mEYgTCK84lYOpouCNoGLiTl
	 U9LhlZRlKby1JP9U3wX6w6BZt9TphvEXql6SkwiQkfuAu0NmTX/GMJCSxoe/JBJJtQ
	 gQDao7wRAEX8aF9jtmiNadOSC22b9bhDrn4IpcxgBrKSnWoSdRhkJVC67cfc2XbWv1
	 i119bKVoPTC4JlIg8/+6H24kno1559p3zTC8ROmTvY8rEPIGPzrsjJYmBrF80aLF6G
	 i4ZXK5Is19EAhSfBiau5kJB5PknmXdAZBuik1RflEcVEIV5LoCxQtlXiQLqD9JkzX4
	 +Bz+Ne05j1u6w==
From: Danilo Krummrich <dakr@kernel.org>
To: Chun-Yi Lee <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Chun-Yi Lee <jlee@suse.com>,
	David Howells <dhowells@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] debugfs: Fix lockdown check for mmap_prepare
Date: Mon, 29 Jun 2026 01:08:56 +0200
Message-ID: <20260628230856.2700057-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615104750.1000-1-jlee@suse.com>
References: <20260615104750.1000-1-jlee@suse.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joeyli.kernel@gmail.com,m:rafael@kernel.org,m:jlee@suse.com,m:dhowells@redhat.com,m:ljs@kernel.org,m:andy.shevchenko@gmail.com,m:tglx@linutronix.de,m:mjg59@srcf.ucam.org,m:gregkh@linuxfoundation.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:joeylikernel@gmail.com,m:andyshevchenko@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269605-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,redhat.com,gmail.com,linutronix.de,srcf.ucam.org,linuxfoundation.org,lists.linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73B0D6D53B4

On Mon, 15 Jun 2026 18:47:50 +0800, Chun-Yi Lee wrote:
> [PATCH v2] debugfs: Fix lockdown check for mmap_prepare

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] debugfs: Fix lockdown check for mmap_prepare
      commit: f81808de3733

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.

