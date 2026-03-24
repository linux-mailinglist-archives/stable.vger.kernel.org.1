Return-Path: <stable+bounces-230203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGeWHMjLwmkBmQQAu9opvQ
	(envelope-from <stable+bounces-230203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:37:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BF131A21B
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 18:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1912A314132A
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8A3DBD5D;
	Tue, 24 Mar 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7o23xDF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186040822A
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373546; cv=none; b=GCejflmdSKqPNDDax7Y6vWdxEnj8kmLttOd4ohTN0Z0OBMnCutzf6SXrAo1w4RKUlGgdvR0RQ8EYk/Y6ZMNLHJE8oYEeOiETD1hRR77kHHEzAXiyYle61w0FIAWisNjvHDWp2Y72jKRbJRWrwv2Spj/PaaTX/+invHB/vrTVukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373546; c=relaxed/simple;
	bh=nVE/fCIGf5wa4kduz8KQXpOSEKCj++KXJVgr1sn/yCc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OPz0zMUOP3qMkeCWCmPbsAFVd7l4qJr593TeIXppWuy5zIZqXZgwxOKVs+A8Jd5GqjKJHo1+wuevhI3PovUwHIW3qHEQztMwuTfOYKEFFcRnrWUejn8Eq0+fkC4g6nJNMMRQ2Y5r94oQAf1osITFIsrTg6eRP3SaTDrtEm5RmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7o23xDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D5BC2BC87;
	Tue, 24 Mar 2026 17:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774373546;
	bh=nVE/fCIGf5wa4kduz8KQXpOSEKCj++KXJVgr1sn/yCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U7o23xDFZgF7aqC8zhRde1X0daJzsPBfEtikPt8R8BNTQryux3b/u0yPozBawaRcA
	 RVtKBACR/7Uu00aVbxFxuuF5EYe2WP1sPh6iS6oU1MsdOmbzFZIJRD8IohgSkXJK+N
	 iLEwjWlWzmELJz2OeucoLnqPZ+PfaqE5B/MtplFiLj5RFJRMAvZWXM+IWgyq9rfQST
	 elajWlMSN8iGRmM0M+g/9q3q2hoi8PrjCR2BxCFu2OLwlvx1cEDMzzWV1tn7PgIlYQ
	 od8ZvOsCxcrkfLGyK6YwivRBVv1CFlHstzuOipAcH3yB8gkh//YtqlllbTbk095+al
	 jBePXzDEgbKjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDE73808203;
	Tue, 24 Mar 2026 17:32:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: fix use-after-free of sbi in
 f2fs_compress_write_end_io()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <177437353403.1223048.17520829968628791815.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 17:32:14 +0000
References: <20260323112123.786090-1-geoo115@gmail.com>
In-Reply-To: <20260323112123.786090-1-geoo115@gmail.com>
To: George Saad <geoo115@gmail.com>
Cc: gregkh@linuxfoundation.org, jaegeuk@kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230203-lists,stable=lfdr.de,f2fs];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5BF131A21B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 23 Mar 2026 11:21:23 +0000 you wrote:
> In f2fs_compress_write_end_io(), dec_page_count(sbi, type) can bring
> the F2FS_WB_CP_DATA counter to zero, unblocking
> f2fs_wait_on_all_pages() in f2fs_put_super() on a concurrent unmount
> CPU. The unmount path then proceeds to call
> f2fs_destroy_page_array_cache(sbi), which destroys
> sbi->page_array_slab via kmem_cache_destroy(), and eventually
> kfree(sbi). Meanwhile, the bio completion callback is still executing:
> when it reaches page_array_free(sbi, ...), it dereferences
> sbi->page_array_slab — a destroyed slab cache — to call
> kmem_cache_free(), causing a use-after-free.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: fix use-after-free of sbi in f2fs_compress_write_end_io()
    https://git.kernel.org/jaegeuk/f2fs/c/39d4ee19c1e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



