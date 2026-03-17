Return-Path: <stable+bounces-225771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIPWESMZuWmOpgEAu9opvQ
	(envelope-from <stable+bounces-225771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:04:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C18B2A6384
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC946300F111
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7AB3161AD;
	Tue, 17 Mar 2026 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="MZsZKApG"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1646319CC0C
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738149; cv=none; b=cm1XGfIgYOEYtgTL+oyObsgt/fQitZPLnsHj6qlFulPZN5agz8eCDoPmTdZX6DQ9m5LkcgMij7ELzJmcRHr+cTTT06j+gk97iC95OXWAJqnIKtR2vv5wzP8it9PAzB4ywZuSPP39gW3bhYq6KNskmywSpcLTah5bjqfsWsCBQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738149; c=relaxed/simple;
	bh=yqTJ23dKSy6Nh/uIVMWFKumxKskfHqIYpyxcji9osxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWlRfwHq/nfsSAquiXHaK+NzCWs0eQ+E+0+rf+2h3MrwbzcG0XRJwjpOsHf8Ju00sgYJu/jY5iZrCAzhfdomTOyGdEgkQl2UNPTX2IwVy8BHpWxxHXp2meGZJzSeMtVQKCa795onR74YZ12tosJU8ceVyynicA9yuQ0GKzHkzSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=MZsZKApG; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Message-ID: <308acd9f-58d9-4519-aaa6-be96f140177d@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1773738142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqUY9RnKKpOusO8pFUS3/6tqJB0ZpbCTtFL2PSpto4E=;
	b=MZsZKApG/PvzuJAetbjZnAC3redAkZl/JYEl/TdCxjpmQrnTBZPp0pgHP0Ztz4RGblAWmT
	uV1dWL1mfrt4wZ/vA+XdOHQZ4kldYGwkIvQGpha77Ao29EsesFI97LvG2W/K/dxmS+3E2r
	U2Nh2wik3oDg+leXdzi5iY9oMgZ0iQN/rzrDrvoVlBb9G1UYDSDURzlkzhiOp8hV+kMGlN
	WHAOlzsV6WeI/0jZ6crOVvFZj1FgAawrP74YeuqtKOt4NDcKsZXH4O/+69XJj06D5Ki2L/
	p/JOoXagOAAeB9VwrLQnZlqcBQAwhn3iR2BJn1mI9Ev5mHM0ePuf5quWLv7wvg==
Date: Tue, 17 Mar 2026 17:01:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ksmbd: fix memory leaks and NULL deref in smb2_lock()
To: Werner Kasselman <werner@verivus.ai>, Namjae Jeon
 <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey
 <tom@talpey.com>, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260317080835.1947664-1-werner@verivus.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20260317080835.1947664-1-werner@verivus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chenxiaosong.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225771-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[verivus.ai,kernel.org,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chenxiaosong.com:dkim,chenxiaosong.com:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 6C18B2A6384
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Werner,

It might be better to move `locks_free_lock()` and `kfree()` to before 
`if (!rc)` statement.

```
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7579,14 +7579,15 @@ int smb2_lock(struct ksmbd_work *work)
                 rc = vfs_lock_file(filp, smb_lock->cmd, flock, NULL);
  skip:
                 if (smb_lock->flags & SMB2_LOCKFLAG_UNLOCK) {
+                       locks_free_lock(flock);
+                       kfree(smb_lock);
                         if (!rc) {
                                 ksmbd_debug(SMB, "File unlocked\n");
                         } else if (rc == -ENOENT) {
                                 rsp->hdr.Status = STATUS_NOT_LOCKED;
+                               err = rc;
                                 goto out;
                         }
-                       locks_free_lock(flock);
-                       kfree(smb_lock);
                 } else {
                         if (rc == FILE_LOCK_DEFERRED) {
                                 void **argv;
```

Thanks,
ChenXiaoSong <chenxiaosong@kylinos.cn>

On 3/17/26 16:08, Werner Kasselman wrote:
> --- a/fs/smb/server/smb2pdu.c
> +++ b/fs/smb/server/smb2pdu.c
> @@ -7583,6 +7583,9 @@ int smb2_lock(struct ksmbd_work *work)
>   				ksmbd_debug(SMB, "File unlocked\n");
>   			} else if (rc == -ENOENT) {
>   				rsp->hdr.Status = STATUS_NOT_LOCKED;
> +				locks_free_lock(flock);
> +				kfree(smb_lock);
> +				err = -ENOENT;
>   				goto out;
>   			}
>   			locks_free_lock(flock);


