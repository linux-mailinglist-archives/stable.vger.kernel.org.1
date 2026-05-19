Return-Path: <stable+bounces-249603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0H6OJ6dxDGpKhgUAu9opvQ
	(envelope-from <stable+bounces-249603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:20:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 022185806AF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5586730B2677
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C457348C65;
	Tue, 19 May 2026 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CTWSAIA6"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF41D5170
	for <stable@vger.kernel.org>; Tue, 19 May 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199890; cv=none; b=RPg8Cu2pv9WLNfZTC4y1/2fn/5sB0kAnVc+BhEd7yZvec7PPIUQnBCDQ1qPO95+Ro7gitjCZfCrCdhc8EoH4UsRhTDDi9oaA5cZMalxHF2zBNH1xeqcVzv3+Ib+8Cyo8mjg1YMDxEm81CIVIq182MZUL7hr1csULVrzSs0daYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199890; c=relaxed/simple;
	bh=bdsUFO9kZ1k4aaN5bTjRDtTJSDsls6AitnmCnu9c8+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8rQEqw7Czu6cJ7SQxiroDuUN3UhXDY3A7b69KI5PlviS1JNrVil+bvmvvfQbrHwXalYsVxvn59tL1qgiKtYZPffkNc/l30/ATs5uhvEMbgmmkioEz8GBioJS2xaCavrJezmy6B7moME/siUMfN57ZnfeFhhEUaz2Wdv4sEFylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=CTWSAIA6; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d6b9bca48so58666741cf.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779199887; x=1779804687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LyJqfMx5Ks1exoptQvYh/tS2q82SfLe8ov3UKKxLEwc=;
        b=CTWSAIA6Yr3uFWc812rWvDxwFobHPediN3fPwC24tgo2NGohva/SuW+L+0IAZm2A96
         2up4U3EKDATP8753N8e1YFNOh4PTonHxkjG5wBYBZwVW406F1c1MUeOoLRpbO70XDDm0
         pplyy3doZJgDyRJX3eu5z+xZ32SDJ7gFDQjhlNZIRabc/BPr74bhFm9eYaw5U4LkxSky
         Q1oaTb0OCkAl6d+sL/YpRPaz6xBfjUJLp2p+zPqtDDZbWJwepEPVgXo3lQ9Bz2yQb7CW
         tyVK05+nyRUCcQOPM40emgLnp6dgG4Vf2mmFi2M48E5w14r+bVV//93pKi9TzH+Tv7si
         R6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199887; x=1779804687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyJqfMx5Ks1exoptQvYh/tS2q82SfLe8ov3UKKxLEwc=;
        b=fDEUgYhInv+EGsx5izdVuZq2SLQ2QwcdClYyLVpmIWfWwVwp7cKNcAkqFcrQsOgTHp
         H73AxErFQ7sqNPYlvxfJDd+Khvf3sj3NisXwJnq5T4ETXGcWGntYFULUsTsdSqQPQF7N
         7NI02Nu+iPtsQ92LU6tCvRLrKSrvmYAhUCLHIOQ7xW2FUkS5o4CMGSRDEnipsP1GKitN
         4+SHkljRsfujslr/GN67yoTCgUw8v7JYtYZK6UNIk8GEni0WMQp6QAVSaR0fzIjkhjZn
         y0lb1zog+cn37RdLrGPEp8bS7Fypgbn5fiGIHSmZoibaWx3ezYZ3XIlxS8XTaBzmBc10
         dgWw==
X-Forwarded-Encrypted: i=1; AFNElJ8VQhVIWdKiPh58iMYtPIOPldGnRQgAjvXN1oAidie4H2mlw9K3H4riLp8+Ayk3AP2D/2x0wTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLDa563so/w42UVh0GS9H8KxSn8ijWNpwR7mpXg/kLdDsowUkU
	tRuUjhRGMlc1U8Dp0gTO/GJqx8b0iouMXuNFUfx1L69W1Eegu8EPO02K8/S6MTkzeLE=
X-Gm-Gg: Acq92OGuzXXNvy4qxjWm+/m4EqsJUmnF8zbArFVnFgNBkyKQ0urIyZbLz8Q9mc0jaIP
	QfcwbTWBLZnBDfQyBbAYHhp10m3wdWEIXNuO4bXOOkvZrtZHTKqnPupiFg/M8SplpWeU3tDKAdT
	HCFz3lQ7mJB8BYkMgCmVEe2hEyQ+lcrjjYSTnoRbOjKw9Atmn/qnd2si4KI+1o9xMiLfQC1totJ
	zxj6PoWa+owDN3nMy4xuPGP2Ok6Ofi3BphGRfs/rl+hK1rEPA/rV4eKMAvJvoi4yiKh0M2fT0G/
	Zg8xvmiD2C+scEM8uXXNHTHz0dCMTFToAR8mNf4u33MSxqvD/0zKsbnWtsg8C8CRQg265Lb8b/j
	HDZr+iW667L9LZqScT54uKEa7yDO+a3zAWR2BiGySHmVzoljXNVE5lR3LeAvfiVg/BGt0I4TjQR
	kYjbgeMLI9ArHs9hcB1dk5/Ze/7bB+WfUWeaDnua7hjKH9AcGAF2g=
X-Received: by 2002:a05:622a:90e:b0:50e:635b:5579 with SMTP id d75a77b69052e-5165a00702cmr265768101cf.19.1779199887300;
        Tue, 19 May 2026 07:11:27 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164585fa0asm177729321cf.31.2026.05.19.07.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:11:26 -0700 (PDT)
Date: Tue, 19 May 2026 14:11:26 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: validate session type before performing
 operation
Message-ID: <agxuNavjtB8T_xRO@plex>
References: <20260519122428.2378446-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519122428.2378446-1-pratyush@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[soleen.com,reject];
	R_DKIM_ALLOW(-0.20)[soleen.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249603-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[soleen.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pasha.tatashin@soleen.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[soleen.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 022185806AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05-19 14:24, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> The sessions ioctls are not applicable to all session types. PRESERVE_FD
> is only applicable to outgoing sessions. RETRIEVE_FD and FINISH are only
> valid for incoming session. Calling a incoming ioctl on an outgoing
> session is invalid and can cause file handlers to run into unexpected
> errors.
> 
> For example, a user can create a (outgoing) session, preserve a memfd,
> and then immediately do a retrieve without doing a kexec in between.

Please add a self-test tools/testing/selftests/liveupdate/liveupdate.c
to verify that outgoing sessions do not accept retrieve_fd ioctl.
Option, you could also add to luo_multi_session.c a test to verifying 
that incoming does not accept preserve_fd

> This would result in memfd's retrieve handler to run. The handlers
> expects to be called from a post-kexec context, and will try to do a
> kho_restore_vmalloc() or kho_restore_folio() to try and restore memory.
> 
> KHO catches this (thanks to KHO_PAGE_MAGIC) and returns an error, but
> since this is considered an internal error and KHO throws out a bunch of
> WARN()s.
> 
> Associate a type with each ioctl op and validate the type in
> luo_session_ioctl() before dispatching the ioctl handler to make sure
> the op is being called for the right session type.
> 
> Fixes: 16cec0d26521 ("liveupdate: luo_session: add ioctls for file preservation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
> 
> Notes:
>     I added LUO_IOCTL_ALL but there is no user in this patch. The type is
>     for LIVEUPDATE_SESSION_GET_NAME which is supported for both session
>     types. The support for GET_NAME is in next and this patch should go
>     through fixes.
>     
>     Alternatively, we can remove LUO_IOCTL_ALL from this patch and add it to
>     the LIVEUPDATE_SESSION_GET_NAME patch in next. But that would need us to
>     rebase to an rc that contains this fix.

Let's keep LUO_IOCTL_ALL change in this patch.

Please add tests, otherwise LGTM.

Pasha

> 
>  kernel/liveupdate/luo_session.c | 36 +++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index a3327a28fc1f..e84218e3cacb 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -295,32 +295,58 @@ union ucmd_buffer {
>  	struct liveupdate_session_retrieve_fd retrieve;
>  };
>  
> +/* Type of sessions the ioctl applies to. */
> +enum luo_ioctl_type {
> +	LUO_IOCTL_INCOMING,
> +	LUO_IOCTL_OUTGOING,
> +	LUO_IOCTL_ALL,
> +};
> +
>  struct luo_ioctl_op {
>  	unsigned int size;
>  	unsigned int min_size;
>  	unsigned int ioctl_num;
> +	enum luo_ioctl_type type;
>  	int (*execute)(struct luo_session *session, struct luo_ucmd *ucmd);
>  };
>  
> -#define IOCTL_OP(_ioctl, _fn, _struct, _last)                                  \
> +#define IOCTL_OP(_ioctl, _fn, _struct, _last, _type)                           \
>  	[_IOC_NR(_ioctl) - LIVEUPDATE_CMD_SESSION_BASE] = {                    \
>  		.size = sizeof(_struct) +                                      \
>  			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
>  					  sizeof(_struct)),                    \
>  		.min_size = offsetofend(_struct, _last),                       \
>  		.ioctl_num = _ioctl,                                           \
> +		.type = _type,                                                 \
>  		.execute = _fn,                                                \
>  	}
>  
>  static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
>  	IOCTL_OP(LIVEUPDATE_SESSION_FINISH, luo_session_finish,
> -		 struct liveupdate_session_finish, reserved),
> +		 struct liveupdate_session_finish, reserved, LUO_IOCTL_INCOMING),
>  	IOCTL_OP(LIVEUPDATE_SESSION_PRESERVE_FD, luo_session_preserve_fd,
> -		 struct liveupdate_session_preserve_fd, token),
> +		 struct liveupdate_session_preserve_fd, token, LUO_IOCTL_OUTGOING),
>  	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
> -		 struct liveupdate_session_retrieve_fd, token),
> +		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_INCOMING),
>  };
>  
> +static bool luo_ioctl_type_valid(struct luo_session *session,
> +				 const struct luo_ioctl_op *op)
> +{
> +	switch (op->type) {
> +	case LUO_IOCTL_INCOMING:
> +		/* Retrieved is only set on incoming sessions */
> +		return session->retrieved;
> +	case LUO_IOCTL_OUTGOING:
> +		return !session->retrieved;
> +	case LUO_IOCTL_ALL:
> +		return true;
> +	}
> +
> +	/* Catch-all. */
> +	return false;
> +}
> +
>  static long luo_session_ioctl(struct file *filep, unsigned int cmd,
>  			      unsigned long arg)
>  {
> @@ -345,6 +371,8 @@ static long luo_session_ioctl(struct file *filep, unsigned int cmd,
>  	op = &luo_session_ioctl_ops[nr - LIVEUPDATE_CMD_SESSION_BASE];
>  	if (op->ioctl_num != cmd)
>  		return -ENOIOCTLCMD;
> +	if (!luo_ioctl_type_valid(session, op))
> +		return -EINVAL;
>  	if (ucmd.user_size < op->min_size)
>  		return -EINVAL;
>  
> 
> base-commit: b1378127003b61930ce30064328640503ad3ef6d
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 

