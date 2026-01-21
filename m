Return-Path: <stable+bounces-210760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDbBH5nfcGnCaQAAu9opvQ
	(envelope-from <stable+bounces-210760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:15:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E73583D7
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3861C7032C2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147D33C00AA;
	Wed, 21 Jan 2026 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1tMCEeK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012C2FC874
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002849; cv=none; b=MhK+X3jliMEWONeV2cRMKf1afC3vHbaK3KyaesylAYUAEtzMJ3RhLmD1/L8/sYmZWKhiOXAhj8MinbwvXdg8XISVTNrqEEFMssuIjK96CRn18V0hQ15EcCkEKBp4BTLiXUKb0lr3imtIVw4p/aNJCNEU+TEcLJM+WRNf6g7XinA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002849; c=relaxed/simple;
	bh=Zj98ZO/ts5b/MYgZaQn1CeOkJWBxcPQsjM8uYXM3aaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecOpJCnmuxh+wDWcURwZcGYIBAP9pQ9Gdk92m1YZys1JIhOepBROLrcT4S8UDIZPdUPT7cb86HypaMvL7BCml6TnDn+oAwGFQnm7tpQSxcmkaxhYdi9N50Hg5C0p1CjN47wzgFVGrXQdEWl4jev8dAxv3IFAmcg6lZTg4rPEh14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1tMCEeK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso3917623a91.3
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 05:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769002847; x=1769607647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pPaaLejyMj+/qnEy2gN+yRCN0UmH2KujytP4NRWmWr8=;
        b=F1tMCEeKELRa0nVdKgeXsW8TRYImYt3BKVrYRDHTahS2rVVOcf8mJ+GAy1C+fELbWg
         PW4LIcjathuH7f6y1DNK5rt6VLeFzlrz2ZIYhEojVBO38z51OZEJhMNFaWOzR7gjI6U8
         7wO6gx/M7bZ3PCMx80W/P4jZTzFUs3zFukyku+nSRk4ogSigIVVbnW1RDHF10botbyyW
         SRHPXGxHkAdfNbJS/nPUiL4MvxbcTbIOUAGz/exnZriGx/ZD+CTDytP6+3LcHjEWs0rv
         XVeqwJTufUcMDHkxXhrS5v53nYFNbpVYrwKCGsuyhQQ26AGtQQqYTMmW3uYWv1t9Egkp
         2mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769002847; x=1769607647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPaaLejyMj+/qnEy2gN+yRCN0UmH2KujytP4NRWmWr8=;
        b=qfyABwIX1MO48GrSuppUflL+e4xRpeS0xAkpmAA1ObXF4LA5pzZ3rUT5D4jktB342Z
         SsaHgyKNdkgYjmns0HOZr3dQRby7ivdB1GluNdruPH2H8Lh2TGLRV3Bc45en+FgUE5bG
         g3qyx680d6JF3RouILla3jdbTRSQq8G19uxPitTLDARfEXQATeXAeLi9OXzf5tjGNo61
         hEKbxcWc66MHiqcyvIWJVGCcsWpiWdpxL3IbkkOOXO7+m2SrFLlFLs/dyW3OSsjG14Fm
         xfUvxW0roEkxSUwehwggmrDzYPM0Mlag+Oxe61L20A+b6tg/X1ys41r9jb06tIIimhVZ
         mrVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw6Y4QXe/PG/vZxj4LHWsD3D84t02hGGFC+6nhEZT6LLTTErY0YLXkXB+bJxn9BBpBDKJ76wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQ7/moUldHV1jWltxvPqYFIqpX6WO0Fu8ONji/ZFg0oZLMhR1
	uuOwauiaZ9Osy8aWZqYXA6n+1FIR2xWvEu83/8qNZznmARELmnWEftr9
X-Gm-Gg: AZuq6aLLDY6IHrBg80c5rcQRfGNeHVhFLs6gTgWZlME1OoiYe1F+/fst+Unzknm4iYM
	OzMwcqvBiuGekJkPzORuZfeKV5Ee04PA6hyo5Bvbnr2luWHKogYpYuzbUkAVsniGiMsTSnuYtQu
	5hyXr3EzHC+ZlTiRCnHbRSuKlX04mOdaKToBCBo1Tj5dHHrTG9WrbrO6hxICPjUW14zWBDKt1UD
	s3WFkobcjLCBFDBzDUeFgLpEUa9H/iojn8ucklcif84HaVtj3Bx7gmCx/Dsk49sCHpFA4ltYTmm
	T4Q/A/kvdgbqrJvomV3fG2j6J0n/65KeiIro0dDjlIro6eqWhFUmokMJRFzjX+IYfPt6qSnuA3G
	drHnPoAi5zy+12T5w+LmbCHOjBrZQeLGI6jEzhT+CAj1Y4QF/NZYvOSdLUOd615aJ7SgocsDvov
	x22U+RkHc5bH4=
X-Received: by 2002:a17:90b:4fc2:b0:34e:630c:616c with SMTP id 98e67ed59e1d1-352c4055083mr3706750a91.31.1769002847164;
        Wed, 21 Jan 2026 05:40:47 -0800 (PST)
Received: from inspiron ([111.125.231.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352c114c2absm5238039a91.13.2026.01.21.05.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:40:46 -0800 (PST)
Date: Wed, 21 Jan 2026 19:10:37 +0530
From: Prithvi <activprithvi@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@lst.de, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] scsi: target: Fix recursive locking in
 __configfs_open_file()
Message-ID: <20260121134037.kh3rfrgmwsylcl5r@inspiron>
References: <20260108191523.303114-1-activprithvi@gmail.com>
 <2f88aa9b-b1c2-4b02-81e8-1c43b982db1b@acm.org>
 <20260119185049.mvcjjntdkmtdk4je@inspiron>
 <ac604919-1620-4fea-9401-869fd15f3533@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac604919-1620-4fea-9401-869fd15f3533@acm.org>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210760-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lst.de,evilplan.org,lists.linux.dev,linuxfoundation.org,gmail.com,kernel.org,syzkaller.appspotmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[activprithvi@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f6e8174215573a84b797];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 65E73583D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 05:48:16AM -0800, Bart Van Assche wrote:
> On 1/19/26 10:50 AM, Prithvi wrote:
> >   Possible unsafe locking scenario:
> > 
> >         CPU0
> >         ----
> >    lock(&p->frag_sem);
> >    lock(&p->frag_sem);
> The least intrusive way to suppress this type of lockdep complaints is
> by using lockdep_register_key() and lockdep_unregister_key().
> 
> Thanks,
> 
> Bart.

Sure. I will make v2 patch for the same.

Thanks,
Prithvi

