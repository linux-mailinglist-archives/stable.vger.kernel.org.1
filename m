Return-Path: <stable+bounces-249382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO8OL0pnC2qnHAUAu9opvQ
	(envelope-from <stable+bounces-249382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:23:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4552D572D7B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD66E304EB9D
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C738A716;
	Mon, 18 May 2026 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkH6HMVN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D72F390981;
	Mon, 18 May 2026 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132070; cv=none; b=Bf851Onwlqr5AmF0wUYKWHZfJcUMjJ+ZPmoPn/cl11h2pZfM29EYi5t7JufkmAbygHG89K9fEplEThDM7q+0NhX0oWy+prX4sL9HsmNYhQvhuQSg9Jeejx6u0icYeGsNi5Ln1Dx8KUomnQ1fC+O+KtRaouA1Lk8p23XtIHClWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132070; c=relaxed/simple;
	bh=pNqPJ/RAnCf5cF3YAJOcO1eZFU78osS7PwdX2Ra/EGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtpuA+EASPufb3UPG5t72K8cD2ARao41n2m/u5CC5Oufm96z1PqJkExdZzMrYYAo23sgraDljJoofmXFLVDzkPeAiv+gQhIXpC+4EDDAk5o9Hie1vxMA6rZHt6OBxAewkd7yayssN/LvWSKSS4UGeorv+9/IBhuNthlw0HoaEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkH6HMVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1475C2BCC9;
	Mon, 18 May 2026 19:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132070;
	bh=pNqPJ/RAnCf5cF3YAJOcO1eZFU78osS7PwdX2Ra/EGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkH6HMVNCaT4GvP/iZdoR+F6sJfqgVVqwSMHTKgMjF15a7PRjBs5TkwRSt8jU4h6Z
	 /t0Ty/aETsn30fJobdA1HJ7XsZHW0d6SsTQyFkUvfqqj4N6+g+iPQKZjLgWHBmoMww
	 8bzPDxnHnoHiWKwuNfueWqa6h4Di+Rw7UqOzprFVU6dYPV+KXqO/uRQg4udfn7E7Zi
	 tt+A1M3b9OycjE3xTHwdaSJ63/X2Z5odptBJZD0ug3vj/BgEzKY3zxzSgXlHMzZkbX
	 EMJQakn2bIvPuLluewED+G5dDULe6pW+yM2OzFderZw82wMBb72MyryuPVrVeuQZh4
	 n94+xJqDv44zQ==
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
Subject: Re: [PATCH 6.12.y 2/2] smb: client: fix OOB reads parsing symlink error response
Date: Mon, 18 May 2026 15:20:55 -0400
Message-ID: <20260518155236.reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_012481AD8B713E60401A2269D96B463EBE09@qq.com>
References: <tencent_012481AD8B713E60401A2269D96B463EBE09@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-249382-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,microsoft.com,talpey.com,lists.samba.org,manguebit.org,foxmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 4552D572D7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026, Alva Lan wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> [ Upstream commit 3df690bba28edec865cf7190be10708ad0ddd67e ]

Queued for 6.12 along with the 1/2 prerequisite (215b7f9ecb8d), thanks.

--
Thanks,
Sasha

