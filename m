Return-Path: <stable+bounces-241802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCo/K+Jp8WmhggEAu9opvQ
	(envelope-from <stable+bounces-241802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:16:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2771248E44A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64B9F305F15F
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 02:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991C437D125;
	Wed, 29 Apr 2026 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgDK40ym"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755622301
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777428894; cv=none; b=oZPBJ57D6+Lkzqgmyxz7RZ45es2gmUKp3FaSCao6iWYZhdcSkkC+Qb6m5chohGVEkkFp5kkrSM93J6x5xNWjIfbeoUwLzEYnd55bPo4Zp7kEs6JrM+ZUyoqWRyTZeSvll+tRsSBIzeq6KYUiOKmJ4aZKe0wSl0GgDrjvV5jncHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777428894; c=relaxed/simple;
	bh=p54sB/AUYJK/XSKJbtpUI/rdZbOSQjmVqUdZNAW1ctk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dcVQqMOjwtmKvEzvjsDvS4TD/0e5falT7QvP2hBJOfcXmw4bHHd3VDBICyuFP7xmiy0asWX/Gb+imU8kfg/7puczVTldZGE54wcTm8WaMmdHGxjvtRvj92pMjxxVHZ0KD942tkbJ5xFT7iDLgOA8tf/jOJllUICXJN8/iWe2jE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgDK40ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B7EC2BCB7;
	Wed, 29 Apr 2026 02:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777428893;
	bh=p54sB/AUYJK/XSKJbtpUI/rdZbOSQjmVqUdZNAW1ctk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=lgDK40ym4JvlG15PLvTw/2n+hPSj8KOyZIhs+BoPUow1mXW7S10Dbuy7tpQzAOgdO
	 vLGcBGSR+ilSYMbdpTzu+vQdx/XFTMf20pIqHRP6M0kojIdz2RJ7qBg3hXMxYMWSaL
	 ygxBkwEU1v7br/EjNm287WGr/qpMI03CM1zPYO2ADPJiT3S4uCPFautrPX0qC33x2J
	 x+UY93EZ4CYdLNtCiEvLVjUbJ6hjtfTgfct3Yeisggsyw8F1fD6jOSuLE3Dzdk4iWd
	 XEkj5aduwedR1UN+3DKjz4V36nbBQPyOA3SrpXvXmxu8/LYK6G4Whmuy2kn7wefD5h
	 EfohuvmQIYOhQ==
Message-ID: <a8a918ec-d5c5-46da-9226-ff1245fa55f1@kernel.org>
Date: Wed, 29 Apr 2026 10:14:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Yongpeng Yang <yangyongpeng@xiaomi.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: fix incorrect FI_NO_EXTENT handling in
 __destroy_extent_node()
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260427131050.1526593-2-monty_pavel@sina.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260427131050.1526593-2-monty_pavel@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2771248E44A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sina.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241802-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/27/26 21:10, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> When __destroy_extent_node() sets the inode flag FI_NO_EXTENT, it does
> not reset the length of the largest extent to 0 and update the inode
> folio. Since modifications to the extent tree are disallowed afterward,
> the cached largest extent may become stale. This can trigger the
> following error in xfstests generic/388:
> 
> F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=1761) extent info [220057, 57, 6] is incorrect, run fsck to fix
> 
> In the f2fs_drop_inode path, __destroy_extent_node() does not need to
> guarantee that et->node_cnt is 0, because concurrency with writeback
> is expected in this path, and writeback may update the extent cache.
> 
> This patch reverts commit ed78aeebef05 ("f2fs: fix node_cnt race between
> extent node destroy and writeback"), and remove the unnecessary zero
> check of et->node_cnt.
> 
> Fixes: ed78aeebef05 ("f2fs: fix node_cnt race between extent node destroy and writeback")
> Cc: stable@vger.kernel.org
> Reported-by: Chao Yu <chao@kernel.org>
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

