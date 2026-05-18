Return-Path: <stable+bounces-249380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIggCQRnC2qnHAUAu9opvQ
	(envelope-from <stable+bounces-249380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:22:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B81B6572D3F
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5606A3038C45
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BCF39023A;
	Mon, 18 May 2026 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pa1FQxSK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D738F95A;
	Mon, 18 May 2026 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132067; cv=none; b=aarTA/4kVQLvf0/ZFbyfwelEe+ktA1B+Vx7fz3UP1SsKy/JfaffiOewGAZJ6132T16NbM9QN6K1TmXVMX+OZiPY6Db47faMmkDnhlYyZaJC0ljMrAmHMHtk6MYi/nx19Hd+BNr94t/xE70mc/bQP6HsYp1cb8R9s0QpF3by8rjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132067; c=relaxed/simple;
	bh=iy1bJhtqGxs1sc56pQs4gLVlTxTVqaWH08oRDCjO4Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVFw0iGrkw9kUzqv3ieV74I1ayry0i7Vco6ax3q4d6rUHpwJTtL1f1k2fyJQuaTBLWCQ42Ia65mCrUsOWMJN+kjLhwKsR1PexLCeSLdiLl4OY9BnV8MK+B+/nXVStL1PxfLjR1FdKGgAkncLccyUVzAtCF4UcRjLqHUydcnJcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pa1FQxSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA39C2BCB7;
	Mon, 18 May 2026 19:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132067;
	bh=iy1bJhtqGxs1sc56pQs4gLVlTxTVqaWH08oRDCjO4Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pa1FQxSKRcL52u39IFL9wkRKKo/v1ak/tbrWaqWAJ3JVOj4s6Nhvg9VrtqTiOMQS0
	 RakPlhjwf03RdJxecACuCtpxbLzSzOrVP+EdUbyCNIvqw3sNm9VBZOj/2oNhCJjbuV
	 rBvt8rt8ibp4BxoGu1Pl7bscTqbxbJHwWxTK9iO90z5GzPtRksc9wObp/jMy3kD+zX
	 nwU0tlTcyNFGW9TCuUPgT6BapMBurcCSwGoGBEl0KzLOoe2EZf2Yze8LKR6dOkYvBS
	 Zn9A/YZqOh6YPu89unAkur9EM/ac8WkRnL2aGVf5FAVZ+ZkqghMx4oUHaTFJmAa7ME
	 2lEnsCnwJscFg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	Liang Jie <liangjie@lixiang.com>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: Re: [PATCH 6.6.y 1/2] smb: client: correctly handle ErrorContextData as a flexible array
Date: Mon, 18 May 2026 15:20:53 -0400
Message-ID: <20260518155236.reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_F47050611C1AC8694B6B203F9C249FADAB09@qq.com>
References: <tencent_F47050611C1AC8694B6B203F9C249FADAB09@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249380-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lixiang.com,talpey.com,microsoft.com,foxmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lixiang.com:email]
X-Rspamd-Queue-Id: B81B6572D3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026, Alva Lan wrote:
> From: Liang Jie <liangjie@lixiang.com>
>
> [ Upstream commit 215b7f9ecb8d7c14d56febdcdd246f3579c32aba ]

Queued for 6.6, thanks.

--
Thanks,
Sasha

