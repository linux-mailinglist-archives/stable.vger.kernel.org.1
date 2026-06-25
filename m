Return-Path: <stable+bounces-268235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 83BuM696PGoYoggAu9opvQ
	(envelope-from <stable+bounces-268235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 02:47:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4656C2080
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 02:47:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=kb2jk8vN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268235-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268235-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2944E3045EE1
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 00:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19E33655F4;
	Thu, 25 Jun 2026 00:47:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB7363C7C
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 00:47:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782348452; cv=none; b=QqHwqUHAYrccQhDFDrWsHJ09BDWnDA7V4rsaKM/bw7jZr5LQdE+rkvAGebXDUq2wdDquxXuBsiRII4fDlP2/xNCIXzALUFqSJoClUDWW37oEt69riH9iD7nRoUSu+QXjNe8cphPw+DO2GQOjccPHEi23YHPhr4wQA8HYdKYph/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782348452; c=relaxed/simple;
	bh=6ButBLdA+1V8pgs3btifBXMmHkfjeyMpBeJ0zUqDwVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c++Xpp2nzJR+FZqg4OIhfls0BEm7aYPSpdyIuek8eIwWUm5wTmmK422/rcqps7s6Ek1soSCHLe4jNdagfK4FN0mXYp2z/u/ZCwUpywWio8kB/h3X9JPtzTPJMCORQljw8kNIdfoZHoOX4axx7MuO6z3kQi3Nvb06HReZpnGUEOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kb2jk8vN; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c6a4eccab1so12195ad.1
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 17:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782348450; x=1782953250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yufoDQhIisHVA9FgmK9gfcD3owed3DX6TgCMh49B200=;
        b=kb2jk8vNS6xi0SKaVc7vlf9N3v8ULKbHVDM0OSo1B4Zyykx0eUJv+hM1XCsvbagwqa
         pzjWMs5slfZ/pEGvH7G8m6fOrUjOKJh0nSoG94GuOqR+EUvvPRRs9cf/XassZxqMHliF
         Zgrc82kuOtFxBahTQo4Mney5sCkq6GVglMhXALvAKeaoNeivoPbvQycvlNKAymgqorK6
         pS2CUQrEnX5cnuaq2X1NEP+95J3PIJiGzWWd/lnF5Pk315y1DzHeMjHwM+tVeSPbkM1i
         FdGrB50IBF4VnCCQPkeGmgdZJomWg9ZZRkpzE1JeWXp+K0yI+VDa1J4/5MtX+zWQNpyL
         dpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782348450; x=1782953250;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yufoDQhIisHVA9FgmK9gfcD3owed3DX6TgCMh49B200=;
        b=XdOUAh89i2IkXbwiET6xFnZ1w5sV8rILPH9hSaWgxvKMQ4b2v/MpynGRfXIzFuHFOu
         5TDFFbK7zJAufH/W+2aRxRCtbw+C6bgHyTSmMj/lSsoIfVxTmCgSd1/lrjyIrvgDLQbi
         JgiLbnC5v1tUMl4xoNfdJayX+dvgFtzjblzfyUfynPVCaXjy9EcJDE+wer5LzpJQAr6i
         GdwL0rLortTvVNbzuBb8c2VgZdcdT7FLkFQT7jr0HmwFZDgYqQ0+1UqvLsmZfBNsJKSD
         7KRG0ovfcHIzFbyJzZixeU1kFnzbVvyRJ/d4sstLFWzBfOJxTsKnx9XMlrnfqf0lKCZl
         Ekbw==
X-Forwarded-Encrypted: i=1; AHgh+RqPjXQiJHl+EY64BnK72op/pFeGbYLp4sOmhZU3zSQNGBS/2GRK1wF5koDp1v3gJCziIwOxn4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLN5tXtU6d8ujQwAleR0aipQDEhQ8Id+YHEWDFgszQC/mPOubN
	lsflc2OISWzjno0IlL6BsSJEachCdNGy/2SJmLrY2yV/Fr6aLa4odDjQy8VS/iN9Aw==
X-Gm-Gg: AfdE7cm397Dt+hQLJEoQ8uKFdPzmkv/+c6WVzdorkIbM7GfeLLe3XZFZBR6iJFFxwDr
	bORnPq3xYuX1RoE3ulIjIg8n2H9z4puFoUju8ezIiINVU18vOemHbqos791uzL5YYnP6BDn1lx+
	Z5M9VLvHYuqeywGAh7LMBDQ2dIIj5+Fv6P9p8g+9GQc8i5KgrsJrmI+BPj2S0kZVONFoWSkdVin
	MrJo2CS27a2sawfDpXCgh8lku8ilUnqMG8SzVNthWEDSGOUbBo883z90kMSOd23oy6FAnB1pq6v
	WjzAB19Andst+6XtlpMDzcXCy9zxQfcGPln6XrbZK3iwxSojQXCjG23Lu4+blJBMuFm096fO7/Y
	5q+q6yLW531mFFMQ2X+l8FWLY7VLVO6zDSMpTnUnX83g1cfI0GMh0DFdYOod54kXDgVkGKefejZ
	sIANxpDKQN+0QOpKpVVp+yyoONXQJP46yiSg6ZHvmLYYMCbDzeHxKwNxTu5MTIMuOBkd/FAAiK2
	CJZ9jdnYdi7XNKaHFvMSprlktyqLw86RBQ=
X-Received: by 2002:a17:903:1a08:b0:2ba:73c3:49b0 with SMTP id d9443c01a7336-2c7f7312516mr1278445ad.14.1782348449420;
        Wed, 24 Jun 2026 17:47:29 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df3af8563sm752195a91.5.2026.06.24.17.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 17:47:28 -0700 (PDT)
Date: Thu, 25 Jun 2026 00:47:24 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Todd Kjos <tkjos@android.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, Li Li <dualli@google.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] binder: free fd fixups on superseded transaction teardown
Message-ID: <ajx6nMBX0nrkf4qw@google.com>
References: <20260619220141.3193697-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619220141.3193697-1-tristmd@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268235-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:gregkh@linuxfoundation.org,m:tkjos@android.com,m:arve@android.com,m:maco@android.com,m:joel@joelfernandes.org,m:brauner@kernel.org,m:surenb@google.com,m:dualli@google.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,talencesecurity.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D4656C2080

On Fri, Jun 19, 2026 at 10:01:41PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> When a TF_UPDATE_TXN oneway transaction supersedes an outdated pending
> transaction, the outdated transaction is freed with kfree() but its
> fd_fixups list is not cleaned up first.  Each binder_txn_fd_fixup on
> the list holds a reference to a struct file (from fget in the sender
> path) that is never released.
> 
> All other transaction teardown paths (binder_free_transaction and the
> error paths in binder_transaction) correctly call
> binder_free_txn_fixups() before freeing.  Apply the same cleanup to
> the t_outdated teardown path.
> 
> Fixes: 9864bb480133 ("Binder: add TF_UPDATE_TXN to replace outdated txn")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/android/binder.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 5fc2c8ee61b1..955bdfb4d907 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2920,6 +2920,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
>  		trace_binder_transaction_update_buffer_release(buffer);
>  		binder_release_entire_buffer(proc, NULL, buffer, false);
>  		binder_alloc_free_buf(&proc->alloc, buffer);
> +		binder_free_txn_fixups(t_outdated);
>  		kfree(t_outdated);
>  		binder_stats_deleted(BINDER_STAT_TRANSACTION);
>  	}
> -- 
> 2.47.3
> 

Thanks Tristan,

Acked-by: Carlos Llamas <cmllamas@google.com>

