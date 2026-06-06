Return-Path: <stable+bounces-260858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SVdhDiHmI2o40AEAu9opvQ
	(envelope-from <stable+bounces-260858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 11:19:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C11CE64CFCE
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 11:19:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=VJ24xs9r;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260858-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260858-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB84F3025D36
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 09:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1A1317142;
	Sat,  6 Jun 2026 09:19:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806472EEE73
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 09:19:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780737560; cv=none; b=EKFuniwAlkzaS28c2Z9WwNkBsb88UcncYMIzcCIcgJvQ8uAGR7mwHJDmbaZuReAQDo02Xz7qTcfok3o1VU19Jrn35VNE0TH9ypXe/vyLmMJTmKQSaYhIbGO0swYFdwKEpg6Abnuq0el1p5cQiZT/vSNEzYgYfjR4GjBiCOrNVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780737560; c=relaxed/simple;
	bh=i0hUU1LR8FTs1GYt7XZtzOavAvG38zp6gVex4FUx7qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwZT/5mCG/xh1EY/h4nKl2Je3+ZPXPl18vrvyqPaB7/N/cNP4Rc/IDJLNtsWG5ecJ1UILRrV2IS0drq+CbHG59dgzHpYYiboVqLQyiaxepPIvG8725LWonbrzs7LGiJg2l6YTzj5klJP2GEn7X6Akd5w3QCezW704zLsmmG1j3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VJ24xs9r; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so22225785e9.0
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780737558; x=1781342358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ADsY3VhcNaw2SJvXvxwxYC+avdiz5am5e2nVPliaeIE=;
        b=VJ24xs9rxLS91qhd7trXJOBUe0mNxRp7q3lWfqtTtbq+U0CulKyFCiHutPpcDkqw5S
         8SUMM2zDn/DSz4QYF35mgl65506COQGGBOpC7w1WPWKBSR/hLN2uHap301iKNdGeaYst
         UEYQAuO8LgF0ka5cRfHie5DmGtC+acsRdRGWSKYAV/vyD3n9ID9n6IxzHECBqfvNLnaP
         awYLwkPgRfrN2gYSabVAgMTRRWKdMYs/UE4XVpFCBtLUrwuW76VLnkKPgGsWwuaM2DG/
         8cs0OeGqB/K7tE8+f/8jlOL00v6RKCuuZ1tMhVain8wOHhi3vnQLXdDnxuSvOvnUy+42
         f+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780737558; x=1781342358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADsY3VhcNaw2SJvXvxwxYC+avdiz5am5e2nVPliaeIE=;
        b=QtVMBO5C6KJO1MoBfdK+Og2YDXuAxDCZO9vwpsR9lXhY1L6mi2PvRn4axs8qF7BspF
         iwTanYj/J/exgemWBh1QNroH4MAfl28iDZrQaEbZVG98HmodDSgaB/fTNfNA0tuyGYgv
         yet4JCjor4cC2Wd8d1bIggoKXq6lwzXADbBoC9WVrNXtTT5gvFIDb7HnNaYoGGmH2rdK
         Vp4fcW2n/U7WGP0Vt3AeyjLNTk45bex6z2EEmY6pEfdRlJi459U76M6PNxv3ABShaDvu
         s2Xuu04MMJEnbgi0T/4fu5j5Zhn8MlAIsyuBQuOg0G/qxmR/sYmnWfZhIBYp/AFq28G9
         fVtg==
X-Gm-Message-State: AOJu0YzTeW8lGxoUtTUuVwH3vSXJt6fZqqzipSs6p/+bR5G8H34vhd6p
	HICdRXOxW6bYnktrT8814xbxbzzQZ+K4sREGE3DaLUnXBTvNbNeYobaRKJN+hLXe0JY=
X-Gm-Gg: Acq92OHKHdLKyLHA31Xj+0fqrPyjEDhEKBodJj7dHSQInm1FH6kq/MwAxKbE0N8HwV4
	KQYthM42DBggTa4lPWwUGNBur+pNss6ZE5VmoRUV3DOfpUtp6lmzif9FU/2mgAM+KBrrJDWYP7M
	MNX6d27UHhHbBYjhsTXZqW9sMSw+GnlFZ8xXbLUYqfgckcyxzVbfyt/xnSnic+SXC27IFdR094J
	70z2B9UyBEcSjLBuC+DxKzwm47M9g91QejWxSZME7d/d3VovTGTz3iLMWGVl/cs76yFAAMIW6JY
	N/7Mc2IgLwS+Oy1YyISHCMkI1AM1Grz5K5/Wj2Vl53wYyok1i/wpszesSIr143uruDympang4Fr
	x73yMr43Ae+cQKs8k5mAP/V3DQt9yX2DpxxV5i4SwK6OVmrRZhBZ12YQvLepWl0cMUnr7dy6tzZ
	/nTecDR25/Xi+FUwdRkyFgBl5Eo/CJ+rRxkxucVDQl+De8nD+VkP7HHLMEyJAowfQ=
X-Received: by 2002:a05:600c:6384:b0:490:acb8:1490 with SMTP id 5b1f17b1804b1-490c2591e5cmr115838775e9.4.1780737557839;
        Sat, 06 Jun 2026 02:19:17 -0700 (PDT)
Received: from u94a (218-164-53-75.dynamic-ip.hinet.net. [218.164.53.75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm124256335ad.1.2026.06.06.02.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 02:19:16 -0700 (PDT)
Date: Sat, 6 Jun 2026 17:19:04 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: stable@vger.kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	tamird@kernel.org, eddyz87@gmail.com
Subject: Re: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking
 fixes
Message-ID: <aiPlO4a8QnMFBqc2@u94a>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
 <ah5pf25fhVH9WuU-@u94a>
 <ah56iBM2P_9hF3_L@u94a>
 <ah6dLESn8tHAtxS9@u94a>
 <CALgi0X=qjiB756FnrYowor26sybA4z2jNCPrjieGcAA52KJS1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALgi0X=qjiB756FnrYowor26sybA4z2jNCPrjieGcAA52KJS1w@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260858-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:jt26wzz@gmail.com,m:stable@vger.kernel.org,m:paul.chaignon@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:tamird@kernel.org,m:eddyz87@gmail.com,m:paulchaignon@gmail.com,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,u94a:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C11CE64CFCE

Just want to send out a quick reply after looking at this.

On Wed, Jun 03, 2026 at 01:25:15AM +0800, Zhenzhong Wu wrote:
> Hi Shung-Hsi,
...
> I ran the suggested checks with the same reproducer, where BAD means the
> program ran and observed the unexpected error, and GOOD means no error was
> observed:
> 
> - latest 6.6.y, v6.6.142 (924b4a879cbb): BAD
> - bpf-next at b93c55b4932d: GOOD
> - bpf-next with the d028f87517d6 JNE refinement reverted: still GOOD
> 
> So the issue still reproduces on the latest 6.6.y, but d028f87517d6 alone
> does not explain why bpf-next passes. I'll do more narrowing and update the
> candidate backport set accordingly.
...

I think it possibly comes down to commit 4bf79f9be434e ("bpf: Track
equal scalars history on per-instruction level") added in v6.12. Without
that, the precise mark wasn't propogated (for scalars with the same ID),
and that likely made the state comparison (invalidly) go through.

Shung-Hsi

