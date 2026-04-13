Return-Path: <stable+bounces-235998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBNcJNjV3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-235998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:39:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF033EB658
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04873300C935
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EDF3BBA17;
	Mon, 13 Apr 2026 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4P8Iu3t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCBE3603E0;
	Mon, 13 Apr 2026 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080297; cv=none; b=iRxsgerbbMix6xNZbPHfMd8hDZonW4y+FjOC4FHcUPcYdVPpyqVXy1coGaJvOda/Uvf53vfv5xrj7aU67ZZI82iMSv9x5d3Oz4uO++ne6yMYOdfTfvF2dmA9BdWF93BXC8MMUEUV+juSCufYCju0Z+mksEDNqPg5fmblhuFhGqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080297; c=relaxed/simple;
	bh=jB7FRDPHSkphE4Zs6YpqIM9woNsbFEbM9sj7YGjDevk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ijj4WPT9I+KGNsKN5FoxJhpabCpfVHWgQ4l6FZtgsGdGTccmtX++pgbmQv3PAnQ7PfLxbVXyHp8sjKeDMMhUQ8eSnw3a307soE0TeOkajcugzDeRC5y0X+7bpoFXcR/eiYnuoSO4HSeCFQIHiNBqNB05WnjXzSuTT54SgRaE7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4P8Iu3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4112AC116C6;
	Mon, 13 Apr 2026 11:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776080297;
	bh=jB7FRDPHSkphE4Zs6YpqIM9woNsbFEbM9sj7YGjDevk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=j4P8Iu3tDTmbC0HelTqYCVo7vFZJgkmd/M2wjCsjDDFjl8r3xpE60Hm+tTP130ZM3
	 +fnJzdGZJMw65akNtcurTUtBHOSAbDoERdPGx63GJQUmCzGrx/ghNex0TLEqS2qwXF
	 QRL+KQwC9uQjjHvmTQ/vyrNnsD44S8dzIz3ZkxAncTtADLz75Ky8blBufI3VZk8Emp
	 zImA7d1F58c7nRkSMGkXJ8yhKgaEOJgWssivTLSU8wXDJ5CJ+0VkbBB/gTZNcs8jrN
	 pM5ExA5V9Lxx4DXCcpyYa0Lcqmhztxvr4XPLdkhSd18LhB3zYXlX79q8Nv9V8xVp+w
	 znGa3PUU64vsw==
Message-ID: <ac3b7022-a81f-432f-b841-aa2afea414e5@kernel.org>
Date: Mon, 13 Apr 2026 19:38:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix uninitialized kobject put in f2fs_init_sysfs()
To: Guangshuo Li <lgs201920130244@gmail.com>, Jaegeuk Kim
 <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20260410124726.2035729-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260410124726.2035729-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lists.sourceforge.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235998-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: CFF033EB658
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/2026 8:47 PM, Guangshuo Li wrote:
> In f2fs_init_sysfs(), all failure paths after kset_register() jump to
> put_kobject, which unconditionally releases both f2fs_tune and
> f2fs_feat.
> 
> If kobject_init_and_add(&f2fs_feat, ...) fails, f2fs_tune has not been
> initialized yet, so calling kobject_put(&f2fs_tune) is invalid.
> 
> Fix this by splitting the unwind path so each error path only releases
> objects that were successfully initialized.
> 
> Fixes: a907f3a68ee26ba4 ("f2fs: add a sysfs entry to reclaim POSIX_FADV_NOREUSE pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

