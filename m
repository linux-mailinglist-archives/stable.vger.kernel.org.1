Return-Path: <stable+bounces-270056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D9KFMuBBRGoOrgoAu9opvQ
	(envelope-from <stable+bounces-270056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 00:23:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2AE6E8604
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 00:23:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EcY7mt7O;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270056-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270056-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C84B13042D57
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 22:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DB6320CD1;
	Tue, 30 Jun 2026 22:23:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59225322C77;
	Tue, 30 Jun 2026 22:23:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858200; cv=none; b=FkaZXXAsxHvt3HT6sUXvTbYc1pvh+uXdNci19NGwX3ooCHUGOysEaUCAVF73QKB+cK2mdemWT+Q4W18MRY713Rm9wSCF6ABenpjqrgfF8+ehmSBwqJf7oLG1CLfruleX8IFGdKmvHTCuI9Aaz2ghVq3BeP1EHLwuYgj7v7zo1ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858200; c=relaxed/simple;
	bh=dyWlc/2eR8m+sQqMtQbUYiFpV2uOHxIlz/9dViFfAPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGgWvl7X1MwbcnorHO575SIkUfRVyZrmQRmw7EuNrTPPLC3tEQJWgL/DZslogyl2wDvbcZ6Klj+sVB63ii+8sd48kJPQNh250995MwuCt2Joo4U2NLsC/ZHvNaUERjVoYWVfWHFVwurVljUX0fS2MTYg2F2XdXwYTVBus38bQQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcY7mt7O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DEA1F000E9;
	Tue, 30 Jun 2026 22:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782858197;
	bh=n7o6b+pDfbXkoCXWqOQ4sT4HKnVIGfNIQENiExzPoRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EcY7mt7O6KCpNEL2GMPDeHKUgyQU5wwnwOEnBqqzrsOMOMFWZLCEAvSePCw9TprYw
	 j/VVLbikigx1l8ACtyx1WH0ZCl84x7w17ugdybddB9GoUqwKlb7/zpLKuE1O7nXyjp
	 zu2biYTGaZbRW6DiUbOyyzwxMNBRkAz0jjAMKg7j6OjQlWXOKUkPijO89/BJqzixqn
	 9DIKzc/sVL+qTR/tBq/RGgemLjw0mI30EQRPwo+449yh3o6QZOcDNKGahq+w4Dzuo2
	 kArX2KM1bXApwlBRuFC67clHyCFBwbsrCWL0wwjz+AKsfzOOfI8ID96vSgRreTcIrz
	 6Y9kSDP1KDk6A==
From: Sasha Levin <sashal@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	amir73il@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	gregkh@linuxfoundation.org,
	bboscaccy@linux.microsoft.com,
	caixinchen1@huawei.com
Cc: Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	lujialin4@huawei.com
Subject: Re: [PATCH v3 stable/linux-6.12.y 0/3] Backport Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Tue, 30 Jun 2026 18:23:09 -0400
Message-ID: <stable-reply-item001-overlayfs-612-20260630181642@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629070338.578858-1-caixinchen1@huawei.com>
References: <20260629070338.578858-1-caixinchen1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-270056-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,paul-moore.com,namei.org,hallyn.com,redhat.com,linuxfoundation.org,linux.microsoft.com,huawei.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:miklos@szeredi.hu,m:amir73il@gmail.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:gregkh@linuxfoundation.org,m:bboscaccy@linux.microsoft.com,m:caixinchen1@huawei.com,m:sashal@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:bpf@vger.kernel.org,m:stable@vger.kernel.org,m:lujialin4@huawei.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C2AE6E8604

> Backport the patch series
> "Fix incorrect overlayfs mmap() and mprotect() LSM access controls" [1]
> to 6.12 lts
>
> Amir Goldstein (1):
>   fs: constify file ptr in backing_file accessor helpers
>
> Paul Moore (2):
>   lsm: add backing_file LSM hooks
>   selinux: fix overlayfs mmap() and mprotect() access checks

All three patches are queued for 6.12, thanks.

--
Thanks,
Sasha

