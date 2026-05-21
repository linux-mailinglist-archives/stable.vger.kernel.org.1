Return-Path: <stable+bounces-253527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMmtNrcDD2oaEQYAu9opvQ
	(envelope-from <stable+bounces-253527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:08:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E265A5663
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DFD530FB702
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8894C3D9041;
	Thu, 21 May 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmwdsozH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0293D8117;
	Thu, 21 May 2026 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368167; cv=none; b=XF2GVZANbfG830wl8uGMwnzLeHpavG+6TCsGdfwcVbSxwiNLkzqJHfxnRBWuqL9ilqwJyWf88MZKkEzPYzo9H8GUkbnQ00Gqr7I0XnKUEsqsKtprqoHTFPdA6OnyEg90dpGJsuqY+dlJV7UTfBYpieaL8/dFZxJKETa7XE3XOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368167; c=relaxed/simple;
	bh=Rw3BZcniyE7DzTJJpH9sFVm6COcKYi/DQYIpWfRpjAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rw3Vo2D0DMPzPWkXncWkevl0xV4IzXgigFUcgnNcG6EXP4PdBl+2zuR9FzFtTYSMUmSZnNGYpnj331tOMjVpLNItKmqyGEGMI8roB/OiLVXrtT5aTjrUyUqWHJPvBWUlmMd69Bg6oev4hKOP84MQPSY3pcR8rnY+elWDPA0KcEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmwdsozH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109421F00A3B;
	Thu, 21 May 2026 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368165;
	bh=Rw3BZcniyE7DzTJJpH9sFVm6COcKYi/DQYIpWfRpjAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DmwdsozHRWEDnL/bKvgFhs0oqS4A3mLRjrwJSnvDsBi4IOcbZ21C9gm6scVBXHzT7
	 2WKB55I8zGlqBeUqk4cvDGuQlD+mrPhYPoLPRNrryY0C9ce1YYcsKdbfy3sqtRoGf7
	 4GuumC0MQDh6qXe8K9ackHDGIvZ2owtgiefaaHxaFTa+dzRW8/UAEBhVzwFzB49I9l
	 LObcNkQd5RNXsp/2tGEw9jMrmPcD2QnMxk0q3bo0dRFVJXyAa2iV0+sMh7nKduJklE
	 O8qjXkGWqpxT5BJqjfo+ScudmPTSzAsT3+QxhpZ0fifs+rN3aMq/Zp/4pV9dcIyoLL
	 EwT4uBrCl5NWA==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH 6.18 010/957] erofs: verify metadata accesses for file-backed mounts
Date: Thu, 21 May 2026 08:55:51 -0400
Message-ID: <20260521-erofs-6.18-drop-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ag3txj1lJNTGZQjp@debian>
References: <20260520162134.554764788@linuxfoundation.org> <20260520162134.785057461@linuxfoundation.org> <ag3txj1lJNTGZQjp@debian>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,gmail.com,vivo.com,linux.alibaba.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253527-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 59E265A5663
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:22:14AM +0800, Gao Xiang wrote:
> Could you please help drop this too, the same reason as:
> https://lore.kernel.org/r/ag3qlMOcTYM2FBUQ@debian
>
> I will address this backport manually later.

Dropped from the 6.18 queue (along with the 7.0 and 6.12 counterparts).
Thanks.

--
Thanks,
Sasha

