Return-Path: <stable+bounces-271885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id riZxFnBqSGojqAAAu9opvQ
	(envelope-from <stable+bounces-271885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:05:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 488BE7066AD
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:05:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FbURZTtX;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271885-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271885-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C5A9300C3B7
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA64921638D;
	Sat,  4 Jul 2026 02:05:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ADD433E84;
	Sat,  4 Jul 2026 02:05:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130729; cv=none; b=nz59R6vGdoLFy/sJkkPDObR6flzuK+bhkbL54DGnJ0+1Y+z5XwSbUMDhzpyaaC+KReVD2hdUFzmJpoI/jFquWO2SnFksq21QItkeLUJ9duuacgqXrSxZI/qZkbo5U5e7wd1EXc7WwRlEOKE5q4eUsdQ2dSFsQcnG68SjvjE2Mbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130729; c=relaxed/simple;
	bh=b9Eq2HkDjvdZwP+PG/EXhTApS/R76hFjc0OXy9Mo6n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UigA1+h90n/3UcM8xtkdatFEQvGw6v5N1c1DmebXQjtkNkOmbR8oaNhYOCuNPTCjNfYIAg1VwaOcFLqkYm8FXypjZs5MHne6kba+A0WPq8p5w+yrwUYp8ZHJep9LzgkOSC8oBXtbWW3n30SjlelF0Hlhpu+ha1Cu08BNwoSOY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbURZTtX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0681F000E9;
	Sat,  4 Jul 2026 02:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130728;
	bh=Oy9QO9LmW9JkyXSyS5R5t8f98QdLOmBIOlFsvp3RayY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FbURZTtX7hZIZJVDjHL+DUL0jmpSUbzpwxuTbmzQxlSXbSqoFtwkwjvd5bkHHsIPL
	 /fqkYh2s2v5ovR/F7I9sH5GCW2ssPgyIwkNSy5YvEEVkFqDMluRDRWQ+rRafcoOu3a
	 su9xxrgUWRP0ehCTZgnESASS8+2p7Olp0Qv1XWOpMITa32SCQsGA8FwSB3PxAGpmNa
	 NQnc4Yk4edgHp3VqvmuqXgyAQBrvnBphgfSCY0rtm4QXrkqINTV99up6wCMqfHm9xE
	 DR3vb5GnvWE3cL98QX1V9St2R9Raljy7P0djPtiFJWDtUG4RjGewMChQBzSXqNxDVg
	 Zb7kTJj6+CmvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-ext4@vger.kernel.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Theodore Ts'o <tytso@mit.edu>,
	Yoann Congal <yoann.congal@smile.fr>,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [PATCH 6.6.y] ext4: get rid of ppath in get_ext_path()
Date: Fri,  3 Jul 2026 22:04:56 -0400
Message-ID: <2026070315-stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154810.3435236-1-yoann.congal@smile.fr>
References: <20260702154810.3435236-1-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271885-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-ext4@vger.kernel.org,m:adilger.kernel@dilger.ca,m:tytso@mit.edu,m:yoann.congal@smile.fr,m:libaokun1@huawei.com,m:jack@suse.cz,m:ojaswin@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 488BE7066AD

On Thu, Jul 02, 2026 at 05:48:10PM +0200, Yoann Congal wrote:
> From: Baokun Li <libaokun1@huawei.com>
>
> [ Upstream commit 6b854d552711aa33f59eda334e6d94a00d8825bb ]
>
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
>
> After getting rid of ppath in get_ext_path(), its caller may pass an error
> pointer to ext4_free_ext_path(), so it needs to teach ext4_free_ext_path()
> and ext4_ext_drop_refs() to skip the error pointer. No functional changes.

Queued for 6.6.y, thanks!

-- 
Thanks,
Sasha

