Return-Path: <stable+bounces-240507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEoZKJMv6mlOwgIAu9opvQ
	(envelope-from <stable+bounces-240507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:41:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2A6453D0D
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B4F23014682
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF3B1C861D;
	Thu, 23 Apr 2026 14:41:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856230FF05
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955276; cv=none; b=H+AcFGCnGUFLNZt5tywZWoYR69y1ADB1P4LgJqcw+Bk8hGgBgWAHu3APvnWhVtvS2HG4Lk218IhoOFKV6YHrDRC0PH+Esj3BKJPrVs14517YuWI6qINkpWVDH93hTdryEZl2Hfb+YyNlD90evGBWYoUGPwyxDbR5AcC4IAge/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955276; c=relaxed/simple;
	bh=/8iQvCjp9pvtmRh3imXkW86qtNGBFX3fk/DvkqG37H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNQrykhZlTLWvJ1X0dl1awpJf0TsiC8YKorAFZN6Frl6NNiRAkCtqFjtWukZBMHLRK5lsSZHgTnOtp9Rz8QfA78Kb3aaDZTVSw1SefoqZ8YJfkfrQP6kRflrYZRIb1f5Ul3Gi0VGI00ed6R7RMNz75OuN42wYMmoLZ4AZl/1jKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from [10.88.129.61] (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 4B1B02336B;
	Thu, 23 Apr 2026 17:41:12 +0300 (MSK)
Message-ID: <83e432c2-8749-aca3-b5c8-ea89edc75ae9@basealt.ru>
Date: Thu, 23 Apr 2026 17:41:12 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5.10.y] cifs: Fix connections leak when tlink setup
 failed
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260423140245.195039-1-kovalev@altlinux.org>
From: Vasiliy Kovalev <kovalev@altlinux.org>
In-Reply-To: <20260423140245.195039-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[altlinux.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kovalev@altlinux.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240507-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Queue-Id: 8E2A6453D0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v1 of "cifs: Fix connections leak when tlink setup failed" 
(CVE-2022-49822) is currently in queue-5.10:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/5.10&id=685f89e4d2b45768ca796eb22ec1a553fecbdf05

Please drop it and apply v2 instead. v1 introduces a double-free for
mntdata on the new goto error path from mount_setup_tlink() failure:
after a successful dfs_cache_add_vol() the pointer is owned by vol_list
(vi->mntdata), but the error: label still calls kfree(mntdata). v2 NULLs
out mntdata after the ownership transfer.

v1: https://lore.kernel.org/all/20260421132612.38517-1-kovalev@altlinux.org/
v2: 
https://lore.kernel.org/all/20260423140245.195039-1-kovalev@altlinux.org/

Sorry for the churn.

On 4/23/26 17:02, Vasiliy Kovalev wrote:
> ---
> v2: address mntdata double-free flagged by sashiko-bot review [1].
>    - NULL out mntdata after dfs_cache_add_vol() in the DFS branch of
>      cifs_mount(); otherwise the new goto error from mount_setup_tlink()
>      failure hits kfree(mntdata) in the error: label while the pointer
>      is already owned by vol_list (vi->mntdata set in dfs_cache_add_vol).
> 
>    The second concern raised by sashiko-bot (UAF on
>    cifs_sb->origin_fullpath via cifs_kill_sb()) does not apply to 5.10.y:
>    cifs_smb3_do_mount() handles cifs_mount() failure via the out_free
>    label, which kfree()s cifs_sb directly without calling cifs_umount(),
>    so the kfree(cifs_sb->origin_fullpath) in the error: label is the
>    only release on this path and must stay.
> 
>    [1] https://sashiko.dev/#/patchset/20260421132612.38517-1-kovalev%40altlinux.org
-- 
Thanks,
Vasiliy

