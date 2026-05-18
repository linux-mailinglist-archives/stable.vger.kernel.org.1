Return-Path: <stable+bounces-249383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHxuHV9nC2rmHAUAu9opvQ
	(envelope-from <stable+bounces-249383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:24:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D53B572D90
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9BC93055425
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5489E390C94;
	Mon, 18 May 2026 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqDRwOAU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE034D3BE;
	Mon, 18 May 2026 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132072; cv=none; b=X94YOrpHncZE+KyIwvjMwtZF4BrQS0MLhFJLRIsm5laHXP+0x94mL+rHhtjRpW1nvyPyaWoDREXfLgo8NJjhlxQQKPlxJ2ovdZ4eKiKmRF22TYQwuAi4vsbJ+Q9Z5bvs+xU5xCOv/FnX9YKFPrmSpbChF+MAeXrJD+ifG6hYuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132072; c=relaxed/simple;
	bh=V9wpXf9lGdy4NRGyEFku7+n1mr3+d383rsdgPcXQe50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4xHLVfcZvkiP6maC1GMreawzvwhaqsYSf/C9Yd7ju4LnTDdDCCUW5a4F3G8AYXQp7LvsSTgAx0dVlhH80qxpFAyrLMZwUQuCmutYEYG4mAILaWxAm9om2Xq6yjmG9knUHiSzjeUy7fbBhkCSFT/wjeWPXkYLxx4bfhxYVYKf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqDRwOAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEFCC2BCF6;
	Mon, 18 May 2026 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132071;
	bh=V9wpXf9lGdy4NRGyEFku7+n1mr3+d383rsdgPcXQe50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqDRwOAUIT/JapCcsGI0WlCLTdeYaroD38bF9oWnhcNt2U0OzVHdmgHCJzfhW7nFO
	 eF6l0GyoPvhEuEaQyyksHiIyf4E9AIs/5AoESFY04WbRIkVbhGnHeZTT61z+U6M8iz
	 Rvvfh9PNeGP09fse2ppLtUlTboNPqfde+QVrJspMWBWWuRy37pJJb4dtjqb6beF+Uu
	 WDyXRFapwcQkmMAkmYjPBBOkKovrO7kw/LobyjARUWkwNDYKkj/0l4eDgO8KdwiCRZ
	 TbH160sU04lJL4BNEi8dR1fe1yJbDBnXZTeQO4D2Sv54d8aevX1H/N1y0mhwFmeFp5
	 s4uKBiY6lEfKg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	samba-technical@lists.samba.org,
	stable <stable@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: Re: [PATCH 6.6.y 2/2] smb: client: fix OOB reads parsing symlink error response
Date: Mon, 18 May 2026 15:20:56 -0400
Message-ID: <20260518155236.reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_7A69076B1A3E822455AD85719260081AEE09@qq.com>
References: <tencent_7A69076B1A3E822455AD85719260081AEE09@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-249383-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,microsoft.com,talpey.com,lists.samba.org,manguebit.org,foxmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0D53B572D90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026, Alva Lan wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> [ Upstream commit 3df690bba28edec865cf7190be10708ad0ddd67e ]

Queued for 6.6 along with the 1/2 prerequisite (215b7f9ecb8d), thanks.

--
Thanks,
Sasha

