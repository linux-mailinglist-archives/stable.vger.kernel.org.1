Return-Path: <stable+bounces-211205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Oe9FOPUcWk+MgAAu9opvQ
	(envelope-from <stable+bounces-211205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 08:42:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FA5629B4
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 08:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74C8A503A4F
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 07:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E85392C28;
	Thu, 22 Jan 2026 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Aph/hQs3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146363EFD29
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067321; cv=none; b=XgRBsNfkmjKvhDunHHK8zpl73WMSfLj/j9yD2UAfbbo+DO2NA5WmXPpSY6jtlbYAIiPAfl3oe8kxjbDoNd2rEr5EEdIZtsD4PWgbjP/e3dB555pNf8rgHkoBoqSLGd+Q6B87l3lx7T9o1MBpqpPh2uZtOxzMFSSKQOL/L4PXcgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067321; c=relaxed/simple;
	bh=2iN5lbu+BXwCaoxQ1XK4zZjy0ei1HYYY7eZfwZy3NE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxug9UgBLZdf9P5Uj2FSLDuJH/2Cg6p7+XoDnvFtY3U5eI7h4T7Nl4oPEON9DU9R3jm6Fk8LOg9TKHjZVeYY27g6S8lqt/Qem+JoSAn0YNmQVTEdXyuWjZbCF1RKVFY58SrtMwNjit3g0goXKbE9MG9CN9BfNdWdpxMqUY2QoDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Aph/hQs3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so6447525e9.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 23:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769067314; x=1769672114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/c4iWuGgvMsbipzVLJDviIzSd9C+4jxSnU6toS/nSo=;
        b=Aph/hQs33rDRdwbWzCXqYAjEW40W9WvMMEtAd4/rv6aV8iVcHZYdlydrMIrZsYmBcu
         5HNzcjGfA3UjLaREr0GtUHICxYLDfNGN8/apRU9EohJhko+A/p2PgP34Lllk7a32XP9u
         MGltjicaG4y0lsT+MCFaVPhcN91awu5Mn/UaSf5K2C7Vkl6j42FJK7i4OR7l5ZUKqoOq
         DoBujzVorVWzNc4nMptDiCVBD3HJD2Czmbmbb3byE1nlW/k+7eFvk42o517TwQVev4Ba
         oqpWPA9iNLgnoCP55NbD513H8S90q/X+ONjZvSFg6SFhe10DYCeHPGsEiJL4WvjnAIU9
         TrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067314; x=1769672114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/c4iWuGgvMsbipzVLJDviIzSd9C+4jxSnU6toS/nSo=;
        b=A61eOAPcssOBFyqWWkMtKZRlym6fSC7/SICM0QjCaad4Q3rLm5ljLb2xXrJNBaJCME
         di28JcAumhia2qNkbVGcnWf4WcCMKE6LPWDBLFU5KpYawpDi7ibHCXosTltImYRbhq9B
         TAnhLBOHvHlOltfffxe1F/UHXr6V7DJFb1To5+fgFweLex9S9l5nI+JWu30vYGQJpfhi
         9S7lmLI6NB7fWX0Ts4FzbWpnqgjWZblZ4mzaXh+oyX0Y7geFPN8VUbStLl07Qxz1wIvm
         grJfu8vUSd/Zk/LVg3hrPLGJW8g02MBLv1jKnB1/gaWlKlzlU/K40N9teJCCysiB6rE7
         fPsA==
X-Gm-Message-State: AOJu0Yx0YFuMFlq8RB+F7CqjAxrsP1deD/sseRiO0paDe+E5g8dS3fSv
	BP+juobwGFIXPiJc5VYT4nxh4TyIvX6UJb2krv7vdtyMS8cojoU1HgssGjZ7sukaszk=
X-Gm-Gg: AZuq6aKnDFvZvINsggOwBJwnhXGD/6kTmtleVARPiaeoy6lLhRYrgHb2g0+/oUQrAnL
	KoHvAsPxcd1OZ7F9FP2N/3BJu18mPsOUo3PSYs1nD2BSeWafK9FjQCaiHaoIq5QoSAjN0+lxY2r
	cBZ1lxlk3EwxnBy29CHJOFVxRTYXkorZF0kffsIBOHeeY/SCJaD0dOhZ/4lMeeT+Y4CRi4diowM
	XOqmxZvkrNdf7BOhtISrP/d+FzkO5G6ehMAYs3G0zw4wNWf2VEvR9ry++jfNSBW4udThEJKyUnU
	wwiAu5IuQ2tqjhPp9ZjfcrFtUJaRFSXm7p4NeViiESQPRINuQnH4zW6pNe17sts5Zq3rPgEBweF
	9g/aYVpWbyfMqqx9Ny+x0xImey+aYXJmzCa5Vw9TR09l5OOy300bDkA4A9K8PekiiRSuqonqgu7
	DlB5CK2Kru1q++duml2w==
X-Received: by 2002:a05:600c:c16a:b0:47e:e20e:bbbe with SMTP id 5b1f17b1804b1-4801e33c332mr298525115e9.25.1769067314132;
        Wed, 21 Jan 2026 23:35:14 -0800 (PST)
Received: from u94a ([2401:e180:8d84:7ad4:271f:53a4:d001:6caf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ab96fsm175958745ad.13.2026.01.21.23.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 23:35:13 -0800 (PST)
Date: Thu, 22 Jan 2026 15:35:06 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/139] 6.12.67-rc1 review
Message-ID: <ricqscwhc52worlivstcvtmc5qnr3ezlbauhlpxjhp44wu6wrn@6j3nsrx4fs4h>
References: <20260121181411.452263583@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211205-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: B8FA5629B4
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:14:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.67 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes on x86_64.

Link: https://github.com/shunghsiyu/libbpf/actions/runs/21221602824/job/61107573550
Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

[...]

