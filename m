Return-Path: <stable+bounces-235286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEAyNi3U1mkoJAgAu9opvQ
	(envelope-from <stable+bounces-235286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 00:18:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 550CC3C46A9
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 00:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40AC5301A164
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 22:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F229637268B;
	Wed,  8 Apr 2026 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jm1gn60K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7330FF37;
	Wed,  8 Apr 2026 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686625; cv=none; b=Bs7AMPn4HZARWVJS1P8JrtBmd+AU1Y8U1Vxy2YgiFqFj/sSZedcaQvqWpFAASlb6fGpusfYic2CCCOOMvrJTq9PLjD8fm3XwkxuLVMp4DArUdNHTJk1A8gSI0BEttU6Czup16ua8/WBLmxAIdmHECNBKtlrSVyiPZmHJgBicyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686625; c=relaxed/simple;
	bh=0zwrX7pa0jwbcT4OZHTYIOAU1feJTygK2uDc3qm/dOg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Q5VYgWG3V43/jsF775z1kYKS66vetdlebwcaqalxuTqX+kUNTMjpN57InDGTIGOQf3At8oQOaIRdJZ66/cYe9YB/UKUF+NdnSxu79K3FjHFpUE9K8hkZvYGwb5nKk7p81XK4crIPdiaAJiNvD3407Y2AoVq6D4VSuNW1iqo4YSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jm1gn60K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D542BC19421;
	Wed,  8 Apr 2026 22:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775686625;
	bh=0zwrX7pa0jwbcT4OZHTYIOAU1feJTygK2uDc3qm/dOg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Jm1gn60Kxc+Z2dEyqU3hZhhDwABgQ8j/cYX+8W0lt//Mpira07jNHSqIdQOom8v3Q
	 dqP1et5Zeh6O8OWZzkFSKuE0CywJuPN86hNRKp6Ymi6WhI8eC3hNCwe5xgU0e8Rd5D
	 UUqhjG2FMxksqTsBRR8RbomKTdPyxY8X7PqujJe9e/aqoG3b4YVQUbk6zJLdHUSF26
	 qodwahUGfzScgxemFGQtTLqX0PGo9Gf7BotK4UF/ej4nQt0F9qdx0baY35Q54PdR4w
	 zBxnqNt5HT6fHNCEcIljYDzUXZnOxHbLqCdkhee4odvURo37p1TM0ULhQ7CmNcUQ/M
	 BY+yVdIx3ZoMg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Apr 2026 00:17:02 +0200
Message-Id: <DHO4DGWHA4YN.6GO7VVFS7CXU@kernel.org>
Subject: Re: [PATCH] sysfs: attribute_group: Respect is_visible_const() when
 changing owner
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Michael Kelley"
 <mhklinux@outlook.com>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260403-sysfs-is_visible_const-fix-v1-1-f87f26071d2c@weissschuh.net>
In-Reply-To: <20260403-sysfs-is_visible_const-fix-v1-1-f87f26071d2c@weissschuh.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,outlook.com];
	TAGGED_FROM(0.00)[bounces-235286-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,outlook.com:email]
X-Rspamd-Queue-Id: 550CC3C46A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri Apr 3, 2026 at 6:31 PM CEST, Thomas Wei=C3=9Fschuh wrote:
> The call to grp->is_visible in sysfs_group_attrs_change_owner() was
> missed when support for is_visible_const() was added.
>
> Check for both is_visible variants there too.
>
> Fixes: 7dd9fdb4939b ("sysfs: attribute_group: enable const variants of is=
_visible()")
> Cc: stable@vger.kernel.org
> Reported-by: Michael Kelley <mhklinux@outlook.com>
> Closes: https://lore.kernel.org/lkml/SN6PR02MB4157D5F04608E4E3C21AB56ED45=
EA@SN6PR02MB4157.namprd02.prod.outlook.com/
> Link: https://sashiko.dev/#/patchset/20260403-sysfs-const-hv-v2-0-8932ab8=
d41db%40weissschuh.net
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Applied to driver-core-testing, thanks!

