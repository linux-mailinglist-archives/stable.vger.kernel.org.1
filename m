Return-Path: <stable+bounces-253811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPSmB/B1EGoZXgYAu9opvQ
	(envelope-from <stable+bounces-253811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 17:27:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EACE5B6DFF
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 17:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B51A3005EB3
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD893806AD;
	Fri, 22 May 2026 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ZzBwm/yv"
X-Original-To: stable@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D703090D9;
	Fri, 22 May 2026 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463452; cv=none; b=qJtVEeAoc0uXdqaYjZdXuPPpKKoQ14G5dLKo8FOjFlrhOBNaNGwO7n5qKdnCwbZqsWnF/nopTqLN+5L4xtCT9nK+7/CfxLBdcsQOzfRhZ19UYb/B0zaftxWjSZZqiCF7vkBBB5mNghMuwfjQMAC7Nfs+eRAtA3xiVnG940t6c+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463452; c=relaxed/simple;
	bh=OGBerUyssPv8BkRZuJVjRSrvwhZWyX5ZJKi7CpcBXfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RkbKDnI3BXARpJwAa4laY5C2jhBmh02vuWRZ25ACgMgwePfiyDPH+As1C71TOXqPr8+d6Jpk1U9tvNiYEbtmeYcS893Lqewxpd9MH7uIvcFzZkKQQ+WFSj8xjrc7TOtf0vC71k+rN5X5BiiRtCz9fw9bBMMCMm58jy/pUn2l/1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ZzBwm/yv; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 000A81D3E;
	Fri, 22 May 2026 15:24:09 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=ZzBwm/yv;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 7930D35D;
	Fri, 22 May 2026 15:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1779463446;
	bh=a8BSDzUZ9kKGp1h4hv/QY/jt8ltHoDO+IGWT0ZC/xEw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ZzBwm/yvU1foKrgp1VTdeDBGD00ImNpkb1pJVHk0FkktjYN9ETr2FI6fMsjRYatfs
	 XWXpF+iyjnRnF8IJmh5SRSMcNAOaB8c78qeUPqVMxDXGwLTsf9e3RrBGgL92KrfxlK
	 OkdU0jZjZqqz9dIJ/Wn4l4YcqT9lMZAjBSLaSn5M=
Received: from [192.168.95.128] (172.30.20.156) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 22 May 2026 18:24:05 +0300
Message-ID: <98d4d18b-542a-49ca-b27d-211f123e3ba9@paragon-software.com>
Date: Fri, 22 May 2026 17:24:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: fix syncing wrong inode on DIRSYNC
 cross-directory rename
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <20260422152010.205694-1-zhanxusheng@xiaomi.com>
 <20260506075554.7469-1-zhanxusheng@xiaomi.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260506075554.7469-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paragon-software.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[paragon-software.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253811-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[paragon-software.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almaz.alexandrovich@paragon-software.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,paragon-software.com:mid,paragon-software.com:dkim,xiaomi.com:email]
X-Rspamd-Queue-Id: 8EACE5B6DFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/6/26 09:55, Zhan Xusheng wrote:

> In ntfs3_rename(), when IS_DIRSYNC(new_dir) is true, the code syncs
> the renamed file inode instead of the target directory new_dir:
>      if (IS_DIRSYNC(new_dir))
>          ntfs_sync_inode(inode);      /* should be new_dir */
>
> DIRSYNC requires that directory metadata changes are written to disk
> synchronously.  Since new_dir was modified (a new directory entry was
> added), it is new_dir that must be synced to satisfy the guarantee,
> not the renamed file itself.
>
> This bug has existed since the initial ntfs3 implementation and was
> carried through the refactoring in commit 78ab59fee07f
> ("fs/ntfs3: Rework file operations").
>
> Fix by syncing new_dir instead of inode.
>
> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> v2:
>   - Cc ntfs3@lists.linux.dev (was missing in v1, see
>     https://lore.kernel.org/all/20260422152010.205694-1-zhanxusheng@xiaomi.com/).
>   - Add Cc: stable@vger.kernel.org; this is a data-persistence bug under
>     DIRSYNC and affects all ntfs3 since 4342306f0f0d.
> v1: https://lore.kernel.org/all/20260422152010.205694-1-zhanxusheng@xiaomi.com/
> ---
>   fs/ntfs3/namei.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> index b2af8f695e60..64cde1a856f4 100644
> --- a/fs/ntfs3/namei.c
> +++ b/fs/ntfs3/namei.c
> @@ -340,7 +340,7 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
>   			ntfs_sync_inode(dir);
>   
>   		if (IS_DIRSYNC(new_dir))
> -			ntfs_sync_inode(inode);
> +			ntfs_sync_inode(new_dir);
>   	}
>   
>   	if (dir_ni != new_dir_ni)

Hello,

Sorry for the delay.
Applied, thank you.

Regards,
Konstantin


