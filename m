Return-Path: <stable+bounces-225792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM78HMsfuWmergEAu9opvQ
	(envelope-from <stable+bounces-225792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:32:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9648E2A6D29
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27D5A304199E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EE33630B4;
	Tue, 17 Mar 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="L5/zEI3n"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C11B808
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739860; cv=none; b=Zci01V/4jtKwCAKgGIIfXarnmO1aiNqJpyC9S8s8fnDMNaxnMYdBSNaeNGAeryLc/AlzNJ1+DKLv835mNE8PcZZkL4nq+ZGLG1c4kT9YJs3XCZUCieX1ofnIULJhYyHHxATKIiEQvx1vr6VH3+WPW99Pwrb68b3SpFNe8EvZ+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739860; c=relaxed/simple;
	bh=O5DSdIqTHk7OX5HsHlZambbQZOQmknmjon0UeAAbfjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otTOaK+QoVCUgcNkepZaHq994VfEbKjl8aRoMMKmwsm0C9aW12JtniR1nwrA5E7K0uftreNot81vHKvYJSxsT9zQi9w+VBz1gnROvcvcHSbAjFdoiekrY7Dt90DW3yKjgzAA9MJL5VsUYCb1nbCnou8dX+7QFAM1Fs1XO69hWCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=L5/zEI3n; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Message-ID: <9192ff4b-770a-411b-af5d-ab06d20248f8@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1773739846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqbZ7WkERoPH0cKH1jw4JhyO0brCaIl0BBggy4u3jAM=;
	b=L5/zEI3nfky2rX7HL3+HTFfZ+1xiEATNZB+hSmA3CSTXzN5C3+Z8aK6uqzSYDQE7GAL1wA
	jpKRavGLchHHi7q2NHqNRZ5lv0a4YUEzilNt7BEGWn18TFGflZGEcjcnwOG8Rnkeu8gOha
	55fNO3lMBG0UR9+l2x2fFE2KKWmemRdSLDtDpanphzKeBWxZvhNsiRqg06mPee37TvEUsB
	TyNnQltYSTbqQdqrKfD84T2Oh8sT/i+aIiRS/qNmw9VYVq8WWFewsj2nsIVrw5Fl2G/IiS
	nfPMIndJ0Po2foEg/DIUnxwB4gmSegV37T51e0yPGmS7kHC793MK5VfbKgNwzA==
Date: Tue, 17 Mar 2026 17:29:49 +0800
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
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225792-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chenxiaosong.com:dkim,chenxiaosong.com:mid]
X-Rspamd-Queue-Id: 9648E2A6D29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

And it might be better to change it as follows.

```
@@ -7685,13 +7686,17 @@ int smb2_lock(struct ksmbd_work *work)
                 struct file_lock *rlock = NULL;

                 rlock = smb_flock_init(filp);
-               rlock->c.flc_type = F_UNLCK;
-               rlock->fl_start = smb_lock->start;
-               rlock->fl_end = smb_lock->end;
+               if (rlock) {
+                       rlock->c.flc_type = F_UNLCK;
+                       rlock->fl_start = smb_lock->start;
+                       rlock->fl_end = smb_lock->end;

-               rc = vfs_lock_file(filp, F_SETLK, rlock, NULL);
-               if (rc)
-                       pr_err("rollback unlock fail : %d\n", rc);
+                       rc = vfs_lock_file(filp, F_SETLK, rlock, NULL);
+                       if (rc)
+                               pr_err("rollback unlock fail : %d\n", rc);
+               } else {
+                       pr_err("rollback unlock alloc failed\n");
+               }

                 list_del(&smb_lock->llist);
                 spin_lock(&work->conn->llist_lock);
@@ -7701,7 +7706,8 @@ int smb2_lock(struct ksmbd_work *work)
                 spin_unlock(&work->conn->llist_lock);

                 locks_free_lock(smb_lock->fl);
-               locks_free_lock(rlock);
+               if (rlock)
+                       locks_free_lock(rlock);
                 kfree(smb_lock);
         }
  out2:
```

Thanks,
ChenXiaoSong <chenxiaosong@kylinos.cn>

On 3/17/26 16:08, Werner Kasselman wrote:
> @@ -7685,6 +7691,19 @@ int smb2_lock(struct ksmbd_work *work)
>   		struct file_lock *rlock = NULL;
>   
>   		rlock = smb_flock_init(filp);
> +		if (!rlock) {
> +			pr_err("rollback unlock alloc failed\n");
> +			list_del(&smb_lock->llist);
> +			spin_lock(&work->conn->llist_lock);
> +			if (!list_empty(&smb_lock->flist))
> +				list_del(&smb_lock->flist);
> +			list_del(&smb_lock->clist);
> +			spin_unlock(&work->conn->llist_lock);
> +
> +			locks_free_lock(smb_lock->fl);
> +			kfree(smb_lock);
> +			continue;
> +		}
>   		rlock->c.flc_type = F_UNLCK;
>   		rlock->fl_start = smb_lock->start;
>   		rlock->fl_end = smb_lock->end;


