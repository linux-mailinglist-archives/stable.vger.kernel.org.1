Return-Path: <stable+bounces-272696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bIbiA4l4Tmq5NQIAu9opvQ
	(envelope-from <stable+bounces-272696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:19:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB687289C4
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:19:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P+LU6yiJ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272696-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272696-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B53153046F77
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCAE42DA41;
	Wed,  8 Jul 2026 16:18:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8142DA43;
	Wed,  8 Jul 2026 16:18:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527497; cv=none; b=cBE3Y6U2QE8YyOwrpuu5q/HAgwKOQOuL8xZ29NuxT2S3r4EsClczXoBAax0VGnuAqZFaPfpmLq8QsywtDMp97DQ1TXCgwtDpouAkajtO2ch0PcWyNM9S+B3GJilTYhVfGQV7cRSOBpTWa5er3UTau/ZWe3NrjoW9kGsd1cKsCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527497; c=relaxed/simple;
	bh=emeqFPYJhsU54P4D5pKnIVo2bLb1/yDskAr0lHzp7o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBYTyhTf+3PkcXWmnKKkDTzOl0+NuwuYwnkaChHcBc9SzJBeRSlWjv4vwtmq6L7ZKcfL17k5HNduf3wujaqVmRts6hbDCmjw+iGdOyciG6LV71dyAd616mtmOcwSzXR2MQ4Cy0SAK7SHfPh3jphdCjA0U7OEVkGCMZRgQFrINHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+LU6yiJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF1C1F00A3D;
	Wed,  8 Jul 2026 16:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783527496;
	bh=JiC5/914qoX/pLC23xYMfmaM5nvG9RDJDy++UnOezLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P+LU6yiJCrkAx1zLq9qFp3mjvSNsmF1Ik1xPmJNmb/SD+Ox4RCmHRhlZJmaIOfFGl
	 e5L5WbJok5h5KvYloSY8cauaFg6D40uLnX8Ahgv4X6xPZT0akCmMJ8okiBkMzNwxlc
	 9TC12QsYiUJ4QXcAAJfq+qRBvRiyUNKUVTFxe3QZSbkKv0+ONzqsPPyyX4jBuDrZho
	 g95UOTIJ8HEokiLssLxr2/qUitCFNtSxJl0IhmM89z8VbmezPfVwtPkYkg4q3fPKpj
	 hGUZ1oPJM5FW8QYhPefAQeUokFh8tXGjyQoXewPMtEeUOSfW3zszr8MmIhxmBTaJx7
	 BWV7GvOv8ooew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	John Garry <john.g.garry@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Konstantin Andreev <andreev@swemel.ru>
Subject: Re: [PATCH 6.12.y 1/2] block: add a store_limit operations for sysfs entries
Date: Wed,  8 Jul 2026 12:18:03 -0400
Message-ID: <20260708120505.agent5-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707153729.1834723-1-andreev@swemel.ru>
References: <20260707153729.1834723-1-andreev@swemel.ru>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hch@lst.de,m:ming.lei@redhat.com,m:dlemoal@kernel.org,m:martin.petersen@oracle.com,m:nilay@linux.ibm.com,m:johannes.thumshirn@wdc.com,m:john.g.garry@oracle.com,m:axboe@kernel.dk,m:andreev@swemel.ru,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272696-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AB687289C4

On Tue, Jul 07, 2026 at 06:37:27PM +0300, Konstantin Andreev wrote:
> The prerequisite patch to backport of the CVE-2025-21807 fix to 6.12.y LTS
> (see Stable-dep-of)

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha

