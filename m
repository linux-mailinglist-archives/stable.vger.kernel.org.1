Return-Path: <stable+bounces-223382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJbsExksq2n6aQEAu9opvQ
	(envelope-from <stable+bounces-223382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 20:33:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2421227126
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 20:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2F993053B11
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4009369214;
	Fri,  6 Mar 2026 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KA7pV4SS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C0366838
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825602; cv=none; b=ChCzuJjvN/DLE/5K/+hBPhAibc6eqjTKsOIfY13mxeyMEYTDK0+rnJr/DOfBX9PYVaDa9ZBsEy8xKGjvEBI7vs2tDXGPxByrDYfsGLH4yaQv06zWa05Z6urxjIk0P4XpR8eatA10sKhUa2KYTGOF2QLH7Q0BupFQGtR3NHvMVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825602; c=relaxed/simple;
	bh=IROdmGyEAzVr2yFiikSwntP9m21zsnQy/XxqTLusAzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jon2f0W8pbdiphgXO1EcnY5rxxF7rYZeQvlNq5MLtkBfVPH8SCDImiNf4j/Pj5hB6x8I99F+IPGkvnQj4MZ1Z3r/f6MX/Nsk1rVn9t2+aEWHdJjBi2OYou9P5qLbqLjp8dpn8H9r1w1nvv2CWzt926VtQX6OpzWhnZ5WhLPW5LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KA7pV4SS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so4164585e9.0
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772825598; x=1773430398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MAHLJKAJtyM24CDiIlJtLVqFqt8qV70IncQ0oyS87N0=;
        b=KA7pV4SS9DcWAFvGE59qAW/QNxeXo2ulD+xocap5/0Rh7gqVgyeJ34Asloou9iJV2G
         pw1UcWNiTSKdaNKnS5j4hhLuBnBgjVZ4u0ZFu98IhB5rsp8xb84V7MpjEVSfBtFtgqVh
         wfYHwLsaKVwKpxIDFLO0B5nMURHK2Vi+cVFLH3TzqlCUf0HMiGtazwsyxp+N5sDVr9Qa
         pitk+5MC+QWQXv4ADqSaSdT7/LWh5N06DkzvtQvdWOEZR1PaBnC77d97qSU9/tdTxNyl
         nDp1/blIcenZpxH6MTJivoGeMm5hb9kcZzNF+fYNog4wvLuwFf+26+pURdQGIcIH2otC
         qVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772825598; x=1773430398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAHLJKAJtyM24CDiIlJtLVqFqt8qV70IncQ0oyS87N0=;
        b=ZDjIHgmGJY1DWL/i7LreU8x5N76HS0fiUPwrk0tuwAOqJ314sZHdiC5CpRbsApJyMR
         kDA+8XPPMN0DAqtdJaNipq99dGV54aadvkPSp05KsJvB50xBKK9ovHyjAQuFdaKH1A2x
         NsPt6KXEkwsE4m/McdMZYdUEBXU5WwPdYXqZWKlygfg97nmrBBz1ce/YU6L0u1ZcotjQ
         r1L4BYGPxQG4yXkULfY27pmTnRTak/7ma69E1PSK/z8hRw7hl5zKdJPtGagZS43fEHX8
         CxkholFOGK1xlVQ1SsQvmBUB5YT1JJyievl3D+N7B2sR/kWbjafo42tgsSb51yzC7hIY
         GlFg==
X-Forwarded-Encrypted: i=1; AJvYcCWEGkd+nXEsMWxyKyZnJvdvqQN9cozpLGbJXJcIzrydPV9SHBZZovqnPsHIU3pVjDFzLDbtwm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdqCn4OI/v07J6GJmHDxuiFNbsYhqjiWN1QlQbKqnSiyFI2OdI
	JDm/RKm5U1Y2McJvjqkxvdTfYNqUsoN+bpgo4EptZHRTjBrTKaLQo75Po4sReYhUzOE=
X-Gm-Gg: ATEYQzyygYxq/IOZMvLqJ5CU2l1uPpkzvfSv0rQs6/ADNOvUwV15R2q59uQcO/8ks8N
	oi+rwbXBsPiVxnr2UY6DlO3tUeZZyWmH2q1Y37c7pT7QPmg2fYSV1WgepRLcZdH5LztYN7fZiQo
	//cF59EQQS6PeXsX0UcqLfRl8PeEc/pXISMxKFNkJfy9eQ+wQYSbDNwqKfRwrKAq1glvpIa9L5a
	NZ5iJ9vLw+DEYmlZpbVMbgdEKqCAgnZo/AGDYL9DMQKYx0DO/QUSOPq1N1QaRuAlEGWOes/Rimi
	42v0pFRvodrxa4V8JZjlCUfWr18SsDOZy3VOm9cpxeTYQ/8DwZQ3G3nh8nTWxaCAmY7Jeh5X1sq
	8JEP3wgBvsQskMnyZ4Es5/6Rgv99EbWCHu9iVt4CQ4Rr2DCvoUU434aadXMadye5Z1fCLl8qGog
	5YN5cL/pu6wODDD0H/58WTHxjlv8uf+Eodw4ur6x4YfwaO+8ktne4binKCjhiQg6wHhg==
X-Received: by 2002:a05:600c:3d90:b0:480:4d38:7abc with SMTP id 5b1f17b1804b1-485269304aamr51419315e9.11.1772825598302;
        Fri, 06 Mar 2026 11:33:18 -0800 (PST)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6401:b8d7:ea6d:8ea1:ec5a:953d])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94e7b5581e5sm2512719241.12.2026.03.06.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:33:17 -0800 (PST)
Date: Fri, 6 Mar 2026 16:33:13 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: Paulo Alcantara <pc@manguebit.org>
Cc: smfrench@gmail.com, Thiago Becker <tbecker@redhat.com>, 
	David Howells <dhowells@redhat.com>, linux-cifs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] smb: client: fix oops due to uninitialised var in
 smb2_unlink()
Message-ID: <r7ojhnxu3jkr42oczp2o5w3hp5bs24ft5yav6nnlcohsybqeuv@zjvwndvvxayc>
References: <20260306005706.830672-1-pc@manguebit.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306005706.830672-1-pc@manguebit.org>
X-Rspamd-Queue-Id: D2421227126
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223382-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,manguebit.org:email]
X-Rspamd-Action: no action

Reviewed-by: Henrique Carvalho <henrique.carvalho@suse.com>

We got a lot of those replay uninitialised bugs. Maybe we should prevent
them by having a replay(func, cond) so we can take advantage of a clean
stack. Opinions?

On Thu, Mar 05, 2026 at 09:57:06PM -0300, Paulo Alcantara wrote:
> If SMB2_open_init() or SMB2_close_init() fails (e.g. reconnect), the
> iovs set @rqst will be left uninitialised, hence calling
> SMB2_open_free(), SMB2_close_free() or smb2_set_related() on them will
> oops.
> 
> Fix this by initialising @close_iov and @open_iov before setting them
> in @rqst.
> 
> Reported-by: Thiago Becker <tbecker@redhat.com>
> Fixes: 1cf9f2a6a544 ("smb: client: handle unlink(2) of files open by different clients")
> Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  fs/smb/client/smb2inode.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 1c4663ed7e69..5280c5c869ad 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -1216,6 +1216,7 @@ smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
>  	memset(resp_buftype, 0, sizeof(resp_buftype));
>  	memset(rsp_iov, 0, sizeof(rsp_iov));
>  
> +	memset(open_iov, 0, sizeof(open_iov));
>  	rqst[0].rq_iov = open_iov;
>  	rqst[0].rq_nvec = ARRAY_SIZE(open_iov);
>  
> @@ -1240,14 +1241,15 @@ smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
>  	creq = rqst[0].rq_iov[0].iov_base;
>  	creq->ShareAccess = FILE_SHARE_DELETE_LE;
>  
> +	memset(&close_iov, 0, sizeof(close_iov));
>  	rqst[1].rq_iov = &close_iov;
>  	rqst[1].rq_nvec = 1;
>  
>  	rc = SMB2_close_init(tcon, server, &rqst[1],
>  			     COMPOUND_FID, COMPOUND_FID, false);
> +	if (rc)
> +		goto err_free;
>  	smb2_set_related(&rqst[1]);
> -	if (rc)
> -		goto err_free;
>  
>  	if (retries) {
>  		/* Back-off before retry */
> -- 
> 2.53.0
> 
> 

