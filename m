Return-Path: <stable+bounces-226972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGFIOkVSumkAUQIAu9opvQ
	(envelope-from <stable+bounces-226972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:20:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 698E32B6D59
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7437F304000D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289CF23183B;
	Wed, 18 Mar 2026 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cxSvbOIx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921BD17C220
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818174; cv=none; b=F+MbXYSDdAd0z3yB0gWvtJWWoSV0M6Akth7PwVnMuxwncC5ciQm/yV0MhnYqINcfoUy5WKO3IG5YEUKXQC9FXLQ0mrTTwS1HdubGgo1kW6rO+0EKWqYReblGxtMb63bYebvYyp/DYyONmwSsQiAtT6RFsNg4TP3wN+NEbG+5dwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818174; c=relaxed/simple;
	bh=DnxEnemkB2WH/Z/UoSAWJTNRzqVI9q6avWpfXrDlFw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH1cepv3gEldj1pqOOS4KsF/m7WWE09UtCBLitoeXrUJivsnJxPlvf1ooLqlPm3QgCH/18oLCE3M2G0nk6KsOaoSsbZh8t3cfVxyizIxYwbdQSB3Jp3BO6hBEG1XHPt3DinThxxPp/SedLMULw+AvGTodbffvSOletamNYkVwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cxSvbOIx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b41b545d9so3897085f8f.2
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773818172; x=1774422972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuswB05nXpaspdO6YZ0AYDzRRQbxug7MJJF7jh6gDCA=;
        b=cxSvbOIxdcVBkoblcHrIq7vtpT/gYV3EVblrq+CNhD9rW+1/IoZZJCNDFT3djKu7B4
         KOn8ULXHRAYC9cdx9H0T9OqBnzgm7ColOmzGjwrOur8zkYMOdAn7Zw6cm0e2md89v0uB
         gv7DfDtpEyVHZ0wNUoDeh3STezuLoPwib3/OMfPe54Rpt4vo0GN2IxZdCMNtPpSyp1LW
         R70rhX3ESV3qmeCj1Xo+Oc+/MEQK1tDT3FPZfnSAFcp/ZAkNJSJAoozAYs8agmdfpO0q
         LzNlGrOHiWRs57kqA8sPRZId9h8uHpoTYBi1w1uQy+1zD0sRwYmhkEiF60Hf4X9Ezw6q
         I0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773818172; x=1774422972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuswB05nXpaspdO6YZ0AYDzRRQbxug7MJJF7jh6gDCA=;
        b=aitgRXB/ejxTyJrZ38yP7JU879qb+El2she8nPjhxjgZcNYSx5FdsfsBi/Sa6BGwZ3
         NrZC9OM+0ad+nQiCCTZq5nBocO+lQXnPciEiy25xPuPG82waZIvjGi9rq9hHrGtNkIlu
         VwY6MlMe23bfBQN1gRRpHDHUPB2F+F2R0FQ5gTzWyxj0q4bMA7zj52nnsWzloI0j3kD6
         vV9ZpWdJp9fC4e6gBXtQ6Vf/3kMjhXT6aOS+XAnOpK9C6FQzf1iuqXgDvDSvBVf1RoqE
         4e2eejI7bOoSPz1aEPEK4vLLAhjBkhvofpCEjVy+FtSI9xt4QAwLKUfVmgS1stvX6VcD
         TV2Q==
X-Gm-Message-State: AOJu0YyjtC1fa+Z7M6V9j2g/ujJBSX/x6ayBpQSlE4P90BYcEpKfQvyS
	tJsJzG1Fs3gfIXIhH6IQpKitxdn0Ux8+yd3skqBCN4UnH3D/mOPUHSXUTyKZR0ceqe8=
X-Gm-Gg: ATEYQzxeV2rKBVppgd+a6ZsPvDC848sD7btuxV/UqaS3hL4kl4G+N8/k26RPjErUwX8
	5kpPG81nZOK8MRlNC0TZD06hzzEBnw+S6XhYRoSaQE1Nxw6W4rbu/1fL+crZ6sfyrX7NM+i8Cz2
	K+fk3ieznBh/J6EYLxhqv3tti/ZhmcTp8hAkx0t/IECHv5L76GmcZ1lwfV/By0Dyp/CUzjapld4
	Y1sCMaKJpacaoAhhU/gGFW0zOCQVLl5r3rWgu0ErBPID47gCQXBQyVqQjGiwDwgSBgrJZuaqmz/
	U3FBeC0ErVyR2f+Uy8mr5ws3AFhZmRS2O4mnr/osXmQ3sCok7ZG+zM/icxvKfmSR2lrcwYH5xGE
	tDXiyUDr8cxnV2nkuhLdire08I9Dke23tc2qJDZDYKJAH4Xc95KzzzyDS+xNvxKoKxRK8mvlRy7
	KfFK+xrUyPb2lEQ9IR/U0XrpVcCXVgyQ==
X-Received: by 2002:a05:600c:3b28:b0:485:3aa1:a7f1 with SMTP id 5b1f17b1804b1-486f441bc51mr38158405e9.7.1773818171752;
        Wed, 18 Mar 2026 00:16:11 -0700 (PDT)
Received: from u94a ([2401:e180:8d6d:4286:a96b:a815:7332:44e7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e54461csm1459482a12.15.2026.03.18.00.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 00:16:10 -0700 (PDT)
Date: Wed, 18 Mar 2026 15:16:02 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/378] 6.19.9-rc1 review
Message-ID: <2t4msypqkqfuclftuorojbwk2o2asi7qgudwwdwouljindynyk@bwza7tj64vws>
References: <20260317163006.959177102@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226972-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 698E32B6D59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:29:17PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.9 release.
> There are 378 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Mar 2026 16:28:59 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/23211625016/job/67531397718

[...]

