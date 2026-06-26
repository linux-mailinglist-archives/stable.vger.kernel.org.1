Return-Path: <stable+bounces-269265-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qiSFLv69PmowLAkAu9opvQ
	(envelope-from <stable+bounces-269265-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:59:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8646CF8E0
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:59:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PSTXcOuY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269265-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269265-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A482303D4FD
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8531B3ACA70;
	Fri, 26 Jun 2026 17:55:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536D52D0C62;
	Fri, 26 Jun 2026 17:55:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496504; cv=none; b=a7F0kmEakjm5FZ+A2bvX7/152sbkiCoyNM1BcFFICDvxquUNoTz3GKGCEhNVqKsLDF68KXy37IAPd5N3GReDtvUTVfTu/Afvzb01EVRcokg8n24hhpzJLuAfKxr132T2si2vcylKHy380aq+hm1zBbiM6kWzcoyZHT+oewWLUEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496504; c=relaxed/simple;
	bh=T2cdVwjSA/aEFAt9j7QFPSkS0pYq1ySBxxls6IxRF1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tmmz1i/u3u5onmMBUzJiLR33tuD2MkLvFSlVgdlXWegfsqoKB5vbdwgk4Uqbf/jGp7P/OHoBRv5oO3p97FWJx1gvdalNV4wSLhdFPqNsTtYxO3jC50EOVTJY76LUQ4eFaWirhb+9fQjORxke1zrYJif/tNcxowW0TeJGhy1QuZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSTXcOuY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A858E1F00A3E;
	Fri, 26 Jun 2026 17:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496500;
	bh=MzrOXfZCWqUkkLkuCYOMOg0Gw+ZB191BNbhP43mOt04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PSTXcOuYzH5YVSNn2YgtnQ0vo17ttcjpmJMNpZ/BLvCpQV93zcqCB/z7QmzZt614H
	 Mr2jtJkqFox/rkmq5q0zHWlfvTk+pC5fOVy6/3dyog5goA2OTZrRgpodt+HUtdKmk6
	 mCBqawAttlPtEyr8fYEQ2MN2+NMXAEY+cyr8oYAJU9np1O8Losm9MOz1JWv8d1gzDS
	 wSk8vN+DV9QZxu6xxln6zLjF5+uyLXBSO6p3ibbPyyXnOYUj9YgzVp7s7fMwPAFdnJ
	 Il6AbCsiDgbpTz/GNDdZb4grbGEPumqEvsSTuvjW/j8npH16gQcTqkBaEs+7+M1IF0
	 AVyvT3k8eKgZQ==
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
Subject: Re: [PATCH v2 stable/linux-6.18.y 0/2] Backport Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Fri, 26 Jun 2026 13:54:28 -0400
Message-ID: <stable-reply-item011-lsm-618-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626075035.143419-1-caixinchen1@huawei.com>
References: <20260626075035.143419-1-caixinchen1@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269265-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A8646CF8E0

> [PATCH v2 stable/linux-6.18.y 0/2] Backport Fix incorrect overlayfs
> mmap() and mprotect() LSM access controls

Both patches queued for 6.18, thanks.

-- 
Thanks,
Sasha

