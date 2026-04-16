Return-Path: <stable+bounces-238314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ABzIZDm4GnhnAAAu9opvQ
	(envelope-from <stable+bounces-238314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:39:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1528D40EF2B
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D22183017F8A
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142713BF680;
	Thu, 16 Apr 2026 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtx1mXz4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A63BBA07
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776346765; cv=none; b=epXOWaSKd0cn8NINqaUfv21X21ezou955CqyvgKhWrHx2ePKu24CKwRNIQktX8u0XyT2t/EAVFiSPsl0UObhYSjtYKBvyQQw9Wx6rPhmxdTGRCFp/XXdlFSaN0KyADtAythGxLePRZETCSQ0LHk/+mbB+CXiiw75klksMlH9Sbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776346765; c=relaxed/simple;
	bh=6JKae31z6PeEQveaBJ7aXSp4F6wtSvF9G/GjJF3QNH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvSmsD1019h6Lw42oSEU72u0YnmxBOwzmGuhPMrAY8BC14+MrKHRelMHw9Uze5QXRZ1NTdmWvdBNqy/3iaFjg9w4Wtx6nXjra7qB5BbVzbAvz+9wXMAEpwhTtTjI4cAsBi2MwDkVFpyHUGQjNV7DcdMGsKDulf7bynluFPXL5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtx1mXz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC6AC2BCAF;
	Thu, 16 Apr 2026 13:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776346765;
	bh=6JKae31z6PeEQveaBJ7aXSp4F6wtSvF9G/GjJF3QNH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtx1mXz4SKZnwhFYytrKjGO1qsEw1jFHrSDudPTVnpu2D7hgY+TVfJWzDqyKykEKr
	 9I3puEIhCr8T5mlIAi2Uz5BKikEhR9wTQQvZ3bO/lB7ypbeO3RzQckw5lF37LUT/kT
	 0Pt38IGcLRyanF/rmbMAWfqINdeRpmx87jMU6UemWSOksUBaGgf1Aofc8nv6Wb6I49
	 AbFVvl81tqWvzx45Q9/rx+NRtv6oaiVgBERfvIhM7pcZdUKhdKG+mYf0crMsw06sFA
	 ITZ6FcyKOWRwa802uwKSxuLZR/76j3a06+LjAOP7hKI+BbnivIeDMkMXYjcfp/En3q
	 V21hSV3Osp+Ug==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ankit Garg <nktgrg@google.com>
Subject: Re: [PATCH 5.10 153/491] gve: defer interrupt enabling until NAPI registration
Date: Thu, 16 Apr 2026 09:39:19 -0400
Message-ID: <20260416133159.stable-rc-gve@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9c5431bb22e2c1470f608a60f872c441c21550ff.camel@decadent.org.uk>
References: <20260413155819.042779211@linuxfoundation.org> <20260413155824.759485387@linuxfoundation.org> <9c5431bb22e2c1470f608a60f872c441c21550ff.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238314-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1528D40EF2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 15, 2026 at 12:22:16PM +0200, Ben Hutchings wrote:
> The disable_irq() belongs before the netif_napi_del().  (The upstream
> version got this right.)

Dropped from the 5.10 and 5.15 queues, thanks.

