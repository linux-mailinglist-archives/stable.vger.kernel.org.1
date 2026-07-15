Return-Path: <stable+bounces-274622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NtbSCYnQVmr+BQEAu9opvQ
	(envelope-from <stable+bounces-274622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:12:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7801D7599C2
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:12:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mdsdvmhM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274622-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274622-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 202653010F21
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206257082D;
	Wed, 15 Jul 2026 00:12:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB8014A4CC
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074369; cv=none; b=trtSZtLEvdFFZrkJwhRFQPJ+zWeW2wpVvMRq65P6lMyCJPmfmDd4h50T6tDZgbdOsCZUYkOx6Ry6lai7kSpfn1nfpJzR+L9P6Y5XLqnGJCHcm01VqgMDwpCaXl/+lHTYt70dDxqZpP9XXZdlJfgYfH5Q0t2K3sD/mmCQqd2TL94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074369; c=relaxed/simple;
	bh=xZAkoDpViNcMPjvHI9ufag8ldUDmYNfnibM86In6OEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fk7ZxU2a+yYeMz0RjXDwDXfQvJLd8tCoHE2ijptLgFsgt7vLt688WF4J78uXFDXC5p48r9BarU981oBGfjKyEeeMbzzaaAeradwW7D4Pk3iUaJiJ1TuWZ2jhnIgaoJ2+PcKP0dG3SVD1w0m545VFEThmoOx2Ezb5p3YqUhSW/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdsdvmhM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFD11F00A3E;
	Wed, 15 Jul 2026 00:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074368;
	bh=46hsRGXBgblkB9twTQH0MUxJhklrmtYq4tG1ajnEx+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mdsdvmhMJDEHIL6amHlSKjeKB3ej6XZeRRZV5OpoKNnnwpPsj71XhJ/CJnReksfza
	 aKAbQFAzL1jJbMRKVVfsZOHDZxo1Q2dEu4+8IbKcgENtLa78JtX8zZ8U/M0cBoZg7R
	 lBrM59RAaPpNtMUl3414Rum+FzzHFUb2/4QYs9Lo/uunnfEMSlAlRB8t25k+bGJ05n
	 onLQdvP4dOFDmoKrKDN8nMiIXLa1e0o3if6f71wEx0h0opozyr29P9pbSNTvGsfUVe
	 jX//ZCuCKCh8m6av8XKb/ws0YiL1wI44/eu45KcHEx6bb7YCz77VAvacmdb25LwZZl
	 +H3mCVUy2/pUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>,
	Vladimir Zapolskiy <vz@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH 5.10.y] iio: adc: spear: Initialize completion before requesting IRQ
Date: Tue, 14 Jul 2026 20:12:32 -0400
Message-ID: <20260714200600.stable0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713165833.500024-1-m32285159@gmail.com>
References: <20260713165833.500024-1-m32285159@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274622-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,snu.ac.kr,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sangyun.kim@snu.ac.kr,m:bookyungwook@gmail.com,m:jjy600901@snu.ac.kr,m:vz@kernel.org,m:jic23@kernel.org,m:m32285159@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7801D7599C2

> Fix the chance of a spurious IRQ causing an uninitialized pointer
> dereference by moving init_completion() above devm_request_irq().

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

