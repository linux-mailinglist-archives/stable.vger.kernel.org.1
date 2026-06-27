Return-Path: <stable+bounces-269406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PPkxB/j7P2r2awkAu9opvQ
	(envelope-from <stable+bounces-269406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:36:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D2C6D24A4
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:36:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=k6zRHu6Y;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269406-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269406-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09BF1300B530
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 16:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C9031A07B;
	Sat, 27 Jun 2026 16:35:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69A3101A7;
	Sat, 27 Jun 2026 16:35:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578147; cv=none; b=gQSClxPucmxjED1b8UuIRmFNDL0d0457i9Wyqih5dkf47NQFJzdU/6GuwRBYbFqG0xahYZqY7alI9goThzxN1qczrGP6RWx6QGlAYtHF+sTHgxkp/eHewRzvRWjcOC9sQ5sqVipSFBPBf0DEi0snQlm01SX7ob3WITt0IEWcmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578147; c=relaxed/simple;
	bh=LSeX5dTmVKAwuvtjDBS38OMI7aoRkeOidKLUTvkoiwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNv6j3t3MoVjWKAiF2gt6bCJFNvl6Mb4sLR44zVVJiXQfnCz9cO5oaPxgYEqdAwAuOoqnryXCsJXBjqBNAKkEXC+OJl/IL1oybUgegM+yii6KiO1Mi1YBAmtT421/DHkQ3yQnp1CuYJa5Yy6kjaFPn1nR0LUlq5vFCh51t/q/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6zRHu6Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E5C1F000E9;
	Sat, 27 Jun 2026 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578146;
	bh=HsktIm+QY4BsGrhFOxHHtIcLN/tKMMKOe2MQHQBTuec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k6zRHu6YCb/cISwdfLV8CNeNjWbhCFyl0r/FCG3vHpdmTsojWWh0UmSb+jKxMCdwj
	 DNVF05VpYC5axGq74m3Mn7r/s81QfhXD1CDihGBeQvGe3HyD1FoLzQ13E+voW7h/9/
	 t52yA97B6HNqVd117kbRvAaNsY9Dll7ooIsHYm4Wroa/bkJ00ugFP/lYY73/rK5+2p
	 M/KQ3cmvujU4SzKUQ10yNYR5KLqjbKxN6E9ybXIzzliMv5179hUwnPNLzyfH3qL+GL
	 z3vZIuWJ6IWvv+ZB32tt6F/LG12fHHJtM3zoxBPrb3iYjYSVJOQxqRtDBP6jY6IeEL
	 Tl610P3Id5slA==
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
Subject: Re: [PATCH v2 stable/linux-6.12.y 0/2] Backport Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Sat, 27 Jun 2026 12:35:32 -0400
Message-ID: <stable-reply-item017-overlayfs-lsm-612-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260627042835.1492435-1-caixinchen1@huawei.com>
References: <20260627042835.1492435-1-caixinchen1@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269406-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0D2C6D24A4

> [PATCH v2 stable/linux-6.12.y 0/2] Backport Fix incorrect overlayfs
> mmap() and mprotect() LSM access controls
>
> [PATCH 2/2] selinux: fix overlayfs mmap() and mprotect() access checks

Thanks for the backport. I think there's a small issue: the selinux patch calls
backing_file_user_path() with a 'const struct file *', but in 6.12 that
accessor still takes a non-const file pointer, so the build produces
const-discard warnings.

The cleanest fix is to also include the upstream prerequisite:

  4e301d858af17a ("fs: constify file ptr in backing_file accessor helpers")

--
Thanks,
Sasha

