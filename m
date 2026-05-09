Return-Path: <stable+bounces-244949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE82KMot/2mT3AAAu9opvQ
	(envelope-from <stable+bounces-244949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F7E4FFADE
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86D58306884F
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B9C389DE6;
	Sat,  9 May 2026 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/J+tYz2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55D35CBCB
	for <stable@vger.kernel.org>; Sat,  9 May 2026 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330855; cv=none; b=cU8vEdaDumUPlAKcNx5lAO10okBhLJqL3VGCCkCa/sZ2KAchcPXK1kFtkba/2WRx0ZPXpUKmYGhzKasaSat7GY7j8JArU7FNlYawCYAyDjsNRBlFZvcJdSQXZhacHq4pshwNR9cOZH8u5u22PhwkBLuQ2+Gorjk2+nJ0fJKrWXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330855; c=relaxed/simple;
	bh=8ZmCyyM7xI8gWZFtATLrBu9Biq8CFSfeq3IuVJi4NAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kj8y5ztTFJhhAsHHiE93A+9gGeWaJ063rWHZwcrPyOQS8UYfm/LdA5VFLYXa0BfkTa3GyhN0mXBd6hOgF8VrPxaMtwvMcr8aWyuHuPyQBSI+6sXj4TEq4CdWI3mycG2yoqLYYlmiDe5y2UVAnOZNlGmYac9HRBCO0G7Y4Hiu4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/J+tYz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6AEC2BCB2;
	Sat,  9 May 2026 12:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330854;
	bh=8ZmCyyM7xI8gWZFtATLrBu9Biq8CFSfeq3IuVJi4NAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/J+tYz2U72kJoLpJRWQLCI38NYR5gR75zzBXCraslg/2mEhsTOApf5KcAyeXPng6
	 gttTNvPb4tEWYak9pdQ5rCll61KGaPiWkLYR+Nq6T3lSVCAcLlMPDJb5atOlo/CY02
	 Ygn7aNrMuUN+U2GgMeA8Tud5T27aSIYjWON58ESOMJ6qpvz03DSbDJHVRRdz683PIa
	 xn+VI2DA4bmmH69mDjAQcPG17S1WkpTXCuReM5BLQLMK/WDWe3X91Up7yJsRXCT96X
	 hNOjHVMdASJXAMqv8Y5ZZ1Tu244V1rqtGnVKb3+cS3ZG7Ss3/6/RLbVC5jh7A4IlYF
	 2mmTrJ6Px6ilw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y] net: txgbe: fix RTNL assertion warning when remove module
Date: Sat,  9 May 2026 08:46:57 -0400
Message-ID: <20260509122858.7c46160cafc5.re-txgbe-rtnl-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3C8522BDA3D054D8+20260506062926.658721-1-jiawenwu@trustnetic.com>
References: <2026050104-careless-extended-8765@gregkh> <3C8522BDA3D054D8+20260506062926.658721-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25F7E4FFADE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244949-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> [PATCH 6.12.y] net: txgbe: fix RTNL assertion warning when remove module

Queued for 6.12.y, thanks.

--
Sasha

