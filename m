Return-Path: <stable+bounces-214602-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K1XKdyBhWnpCgQAu9opvQ
	(envelope-from <stable+bounces-214602-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 06:53:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C6AFA793
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 06:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9CCA30276BA
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 05:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BC02E54DE;
	Fri,  6 Feb 2026 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BmuaO4Um"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78B2E424F
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 05:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357183; cv=none; b=nCV6bfykVVWErOQ7mU/VxeNUeacQPZzKJoUobJBsufY0dmDdjSJ1CaO1DKLJk5uaKlxDrpVbn2pBGdntJuHaMt76oPU4mCIvHIxuvGSK1oc4piJU82qGjM44bqaoASEcsns3z4z3HfCu3uAa3K/pfQUF+dsJ+197r82FMIHP9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357183; c=relaxed/simple;
	bh=zcxwfI4uRfYB10MzYgvsHuxkdgPklYPSGmqS8PjduFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eewDF3+Y+vhC7hHRHgv1m/rcyHXcBposkZ4BTAmJQyIp7d3nKcAN9eZz6AWHaWlusnWjCHlbSMW14uZrzTbtsBRI+B/73pzZD1gnBQ/f618U7lxCcUNl0XsYNDKMvmQTU00Pz/rR2tXXpexUSOCab2v+ZsURYyWbTs5pN20i4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BmuaO4Um; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43622089851so1253570f8f.3
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 21:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770357181; x=1770961981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=45KwLY90crDx3QHYZBsR7+lDC5BpcTTFrxqVy+EIT1E=;
        b=BmuaO4UmFrvgTVKlbjS7qB4AfodqdKbWzBuEF03mjOo1bOfnOV2PCl+g1jUSoZItCL
         spXxEQgGEePXBhZRTDC/EUK7DkcFdD9SLl7logoEmWpFRRCy5N1cziJFw6wuRmAX15Ic
         TYTMjfeYnl93mJoHCy9JP201z7IeLMd6r8RplwwbsFyB4NDhx3gqFy2nvmjKahdSVpA7
         Ry5wIwFg8invFgrLQ0uMbpkiVrcVTP9RNFVTncuTOv5vtgM2gkk6Z/F6gJPNnWuYnURz
         pXspFPWLtkmVcC1A6tZ2lNaO4Uyff/Mzb7+fZTDjgb0O4CLh2iC/i/l4EEQQNPggeatw
         JBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770357181; x=1770961981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45KwLY90crDx3QHYZBsR7+lDC5BpcTTFrxqVy+EIT1E=;
        b=qoVLTV3jLLbOWUYRxxDR5IoZzdi+0GMFzHWolhuwBk9YTngg9TYUvTFOJcwGAjVksv
         mMOieOZUiNoP6fNpcOivVLqrVyqlzhOjNPXBf9AOxn/JWdDPlks9zHdnRh7kjhDNifee
         ZkBgkE3jiqJ8kzrboVjj7ydRD2yBpn8NMO4qLjrNg99KNkJCTZHNrWU9NB+xcmPF180D
         8kjdocI41QgoupP7uQEYDs2JASOs6GprRb/h5YhbsSHQ3aKjqX9yf675iqHo6eUa+mwF
         ek3OwhO8fEe5uS+WAFAvtRSNHD2QpgsBl45GbvdrNky8wl521bwMyw305/tULxGxbZsX
         EMFQ==
X-Gm-Message-State: AOJu0YxJQYkFLXky2uM6RDMP68jXFRVEUnvOT3qxH6oa9yizqicQ6l/7
	Si+Pix01fS1+Nls+MzB3vaYZQYGbeepuqMomnFBysxvil1v9G8URKJvu4obdZVtIAJc=
X-Gm-Gg: AZuq6aL0Q48QmKHg/RkrwFATTShhq3p+zKTvs3dTH+/VMyVf92mYKnOQH2Vk1BVEFEv
	xwhJglo+NV8iKj7avW4yhZeP/VnSQJqIbowvWhyuIkEgtEgv51gQ4v2szEb2xLkGXQNKOmeAJD+
	tk/tr86bISazAn6JRMMeMamewoRlvmjGpGv5mVdiDHfzrUoUKc+sQDCsMxfxt9sHgBrTCELFLys
	dglzu8cjENkA7T/4kW3JMP0NmUn8viabcnDn3kHSZuXc6GGkMPHP7U4Ku8Q4sorjWJlPxVXi/CM
	wwGUMTDZr9haZMlKm9PgiJGOmTW++nR71BONmrsJb6ftvAn+c+rID92vwp9YVEfA/Eto06ueKui
	th8S7a9HUsvhjGTWTQCdWC+7uFN1iqOzf2iADmQZ9wXS7dd+m2Zrqy3x9BHRDuYrbVWbWQ8BcgK
	9MwFX3dv8HlJOGPcWV//Ue/wF7Dcz3Ny36xNFGnOY6lwyK
X-Received: by 2002:a05:6000:2209:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-4362938fbddmr2226746f8f.55.1770357181005;
        Thu, 05 Feb 2026 21:53:01 -0800 (PST)
Received: from u94a (110-28-26-119.adsl.fetnet.net. [110.28.26.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fa4csm2952428f8f.26.2026.02.05.21.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 21:53:00 -0800 (PST)
Date: Fri, 6 Feb 2026 13:52:46 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/122] 6.18.9-rc1 review
Message-ID: <a5ro6s4gnnys56hjl2ju5q6iyujgot7ztkpvxa3dwabektjori@2qctvmzar2u4>
References: <20260204143851.857060534@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214602-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: 06C6AFA793
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 03:39:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.9 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/21724288947/job/62662113823

