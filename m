Return-Path: <stable+bounces-225812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPAuEqw2uWmcvAEAu9opvQ
	(envelope-from <stable+bounces-225812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:10:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE5A2A8818
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 014323010821
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B653A6402;
	Tue, 17 Mar 2026 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="THKEQr+l"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04135DA6B
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745817; cv=none; b=Sc2ntvRyaHuWB20DNXCLMVD6VA7AMYOVsM9dkHGPx9vSltluW4gGUBMDEejkjmv4PVBim0ey9QN2hyXK6k7dijfhgGaZQNyDqM6V+kqYIvfayiUw5iqk597gmNxqqWt3nyPtEEpMyolvExxfZw9i8ko4goXhKDF4J14y4bvoM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745817; c=relaxed/simple;
	bh=n0rmntyrdN5+cCsf4nHYzeLADKb7JLlCaFkVQ14Qo6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMT3WnpVE5yM0LznVYmA3D7LAgINvPfkN+v6rt9s4T3CUBjuHJofuLRZOR1pEZmADFec7a1hvNnseuVBlIemifdSbm6ueCUTHlnuM8yctyx7LWBMjHG7dshF2sHCUpnh4VWD4Fxyo0y4wnf/Ny8NMSrxUH3ggyFMcPg/V1dp4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=THKEQr+l; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Message-ID: <02e11b2c-a472-46ac-95a4-ffe7013c3133@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1773745802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3I7cawaNN9Gtl9s0jCUJ0VGTRcnfw/Z3Jx9y+HKfO0I=;
	b=THKEQr+lKeHX+XZd9D8JTR0pU0JJX2aOOS9PNNdb3jfQ44Z/Dj8Zqbr4yT6UTUwh9GHcJd
	s4kQte1wnX0qQi7TIy2OYfDKqL1+NnhEu4Zt9zJ7WbgnU7Uvea3y2tgnP+RUrUDDHyYI9t
	UCFAABE10TYkU7LzMeQuJWprHF8ttSYit2Efw3Dsm02ivteDRVaI8ivQ3pbfQ/72FFe+5f
	04c7vGadqGzjpTJMulbduK4J78KK/2Tg9MdKxNUXpRzQ91ojr8rCgWEcCSrGLDa3Ql65M9
	cUPJ4abtYcUB57Yo19V+3hNH8u3FrRYAEW2jZ04qpZFINXkkwLeMkT+zpxVLZw==
Date: Tue, 17 Mar 2026 19:09:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] ksmbd: fix memory leaks and NULL deref in smb2_lock()
To: Werner Kasselman <werner@verivus.ai>, Namjae Jeon
 <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey
 <tom@talpey.com>, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260317094653.2236624-1-werner@verivus.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20260317094653.2236624-1-werner@verivus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chenxiaosong.com,quarantine];
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225812-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[verivus.ai,kernel.org,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chenxiaosong.com:dkim,chenxiaosong.com:mid]
X-Rspamd-Queue-Id: 4CE5A2A8818
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Looks good. Feel free to add:
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>

On 3/17/26 17:46, Werner Kasselman wrote:
> smb2_lock() has three error handling issues after list_del() detaches
> smb_lock from lock_list at no_check_cl:
> 
> 1) If vfs_lock_file() returns an unexpected error in the non-UNLOCK
>     path, goto out leaks smb_lock and its flock because the out:
>     handler only iterates lock_list and rollback_list, neither of
>     which contains the detached smb_lock.
> 
> 2) If vfs_lock_file() returns -ENOENT in the UNLOCK path, goto out
>     leaks smb_lock and flock for the same reason.  The error code
>     returned to the dispatcher is also stale.
> 
> 3) In the rollback path, smb_flock_init() can return NULL on
>     allocation failure.  The result is dereferenced unconditionally,
>     causing a kernel NULL pointer dereference.  Add a NULL check to
>     prevent the crash and clean up the bookkeeping; the VFS lock
>     itself cannot be rolled back without the allocation and will be
>     released at file or connection teardown.
> 
> Fix cases 1 and 2 by hoisting the locks_free_lock()/kfree() to before
> the if(!rc) check in the UNLOCK branch so all exit paths share one
> free site, and by freeing smb_lock and flock before goto out in the
> non-UNLOCK branch.  Propagate the correct error code in both cases.
> Fix case 3 by wrapping the VFS unlock in an if(rlock) guard and adding
> a NULL check for locks_free_lock(rlock) in the shared cleanup.
> 
> Found via call-graph analysis using sqry.
> 
> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
> Cc:stable@vger.kernel.org
> Suggested-by: ChenXiaoSong<chenxiaosong@kylinos.cn>
> Signed-off-by: Werner Kasselman<werner@verivus.com>
> ---
>   fs/smb/server/smb2pdu.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)


