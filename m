Return-Path: <stable+bounces-262587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uEbVDy8FKmpThQMAu9opvQ
	(envelope-from <stable+bounces-262587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 02:45:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB44566D875
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 02:45:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OjIeccS8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262587-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262587-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8647630AD727
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 00:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145BA26ACC;
	Thu, 11 Jun 2026 00:45:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF75136358
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 00:45:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138731; cv=none; b=Kuootl7jzMWsnwVEKqZY6bi1Nx4V/phDbhECfJb3T6f/KV1u1nJuKpeWN4g05LzYllnCOxb2XwjfwxfYvwHjq3PeC8Z/qKczEHJ61BFWYaR4QFAlbLNMuCmJVVM9bECqVFB5ol904ZlH4uAHPAJl9SvtDJ6q++ssXsoT082IDuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138731; c=relaxed/simple;
	bh=MNnhgKsXKLSb7pVL6r24xoJkPgTOKCxRDS5m2/vCuBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djheUYAa+C+xJn7dqsZXztMpzRGiOlOmp0vxc59uIzUGjhqREMr+y53RSygEWf/wRbLXhiQb47X9enIE/pjZw3YBarLTj3ypBWfWJq720+umxzKNnI9oATgQXYQcJ1S7QmzYVksVPK111hkBGQODy9vfPDg4/ViA8JqZaTsuYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjIeccS8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DFB1F00893;
	Thu, 11 Jun 2026 00:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138730;
	bh=GAsM6h3VlB/JQ83dYEgWUs9hN4roS8bdo56fOT7FoCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OjIeccS8z/AHdB5famHCkjRO5hNcQ3Y90gFAqGUxrzM2CGWUteCtNZ8by1s1ACvZO
	 EKT6S4kmHvocwbKr2U/wFV1hqe71kOMbLdAtYGFCvBMcMaPUnIgkX0nlvzCA3L9L0u
	 Mq6CPP3gB7LNc5zjTC/TXoDM07V8jRv1HDgxD7Tl92bgmk0pi+YFvFRlbVCIfWCr6o
	 KhE58YN6yIY7gArag1n+QlKZkx6EDlmMy+UyJyKLj6xd8COlA6pUfR4RlK/ZyhDOoy
	 oblZpmTag+bR7+zXDaRhhLmngI9FbX+P7ccjESRhA9hB7sEwy5nzaPfpJWhBFtG5Fm
	 77bR4oIfRwtoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	chenste@linux.microsoft.com,
	sherry.yang@oracle.com,
	ebiederm@xmission.com,
	tusharsu@linux.microsoft.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com
Subject: Re: [PATCH 6.12.y 0/2] ima: kexec: fix kexec_file_load panic with IMA_KEXEC
Date: Wed, 10 Jun 2026 20:45:17 -0400
Message-ID: <20260610-stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609215844.1835378-1-sherry.yang@oracle.com>
References: <20260609215844.1835378-1-sherry.yang@oracle.com>
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
	TAGGED_FROM(0.00)[bounces-262587-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.microsoft.com,oracle.com,xmission.com,linux.ibm.com,huawei.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:chenste@linux.microsoft.com,m:sherry.yang@oracle.com,m:ebiederm@xmission.com,m:tusharsu@linux.microsoft.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB44566D875

On Mon, Jun 09, 2026 at 02:58:42PM -0700, Sherry Yang wrote:
> This series backports two upstream IMA/kexec commits to 6.12.y to fix
> a kexec_file_load panic with IMA_KEXEC:
>  [PATCH 1/2] ima: kexec: skip IMA segment validation after kexec soft reboot
>  [PATCH 2/2] ima: kexec: move IMA log copy from kexec load to execute

Both queued for 6.12, thanks.

--
Thanks,
Sasha

