Return-Path: <stable+bounces-267308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A4DaNfHANGr/gAYAu9opvQ
	(envelope-from <stable+bounces-267308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:09:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C6F6A3BF5
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:09:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QxZe2P+P;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267308-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267308-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCD59304707C
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 04:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3836832ED32;
	Fri, 19 Jun 2026 04:07:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C901327BFC
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:07:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842034; cv=none; b=K0kVtkJoB9967hi6bAE+rDTtTcnBfzZPNDgVtQcqJ9M+ftfrb3UmECuLL9DAYAcsoly/PjcSOEqrTUklJspL5Dp+VDtaIr1GUhwGocXCZAQx5jV0he3ca4loj7VQk/H5QLVdnMiamBgBDMy9cMhEmR743h0HH6B6i+06sdTvJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842034; c=relaxed/simple;
	bh=zyvuN1/e8I+TUgUXpXNH4mlpo1mVKPyY5BapPwrGXpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnueDez5duBFaAb+MIQgpGtczAiUspuzZAn3KcFKOFx/5P10RDNZHjQBs2rjiR8scE6FF12Hge7jcNE9crep3zqn71xIesVAUuBNZcSo9J73rQ0/APjl/1TkxVJu1mK424PjRnDiyqHv+0ufIQIrt4dBiXEp/agrKGMUr4Df+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxZe2P+P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525741F00A3A;
	Fri, 19 Jun 2026 04:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781842032;
	bh=zyvuN1/e8I+TUgUXpXNH4mlpo1mVKPyY5BapPwrGXpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QxZe2P+Pxi8jlwvqtJSgncgPVV2RWoHEZoLgc8E5fXcHXoM5MdgJnE2RGhlpJIg2d
	 3VCq5uyppRskZLB/ckISqsgSeAA51WahFXbtbRhQ0t2mEVIff29Vd9OzHtdj2xkrnG
	 2G04HcAosWgkuJAGjj8iy/euUhaUL2bPK/Ymz/2F0ka+GxlJrmhjjss6Hw9c0/+DAH
	 8ttLpkb+VJvwZCdzRJtBF5jA+2anImzXQAkIgGGxDZzLmLYlH+HXoYmTymLhHr18+4
	 O0qDvaLUFaVDAIMHosRG/vkyJhsEa8yvpBfrR414r3L8uPDhB3s48ZBLF0xMTGmk4t
	 rMc6ZcIChi+lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	mszeredi@redhat.com,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 5.10.y-6.12.y] fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios
Date: Fri, 19 Jun 2026 00:06:57 -0400
Message-ID: <20260618-reply-item011-fuse@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616190023.956982-1-jannh@google.com>
References: <20260616190023.956982-1-jannh@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:brauner@kernel.org,m:mszeredi@redhat.com,m:jannh@google.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267308-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69C6F6A3BF5

> This is a backport of 4e3d1b2c48ca ("fuse: limit FUSE_NOTIFY_RETRIEVE
> to uptodate folios") for 5.10.y through 6.12.y.

Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

--
Thanks,
Sasha

