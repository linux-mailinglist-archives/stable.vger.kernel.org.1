Return-Path: <stable+bounces-222820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBZGO/eZpmnfRgAAu9opvQ
	(envelope-from <stable+bounces-222820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:21:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4D01EAB28
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E28B9305246F
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 08:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA9F383C64;
	Tue,  3 Mar 2026 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T64tPcob"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F538837A
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526003; cv=none; b=L7+kmB4Yq6hjcbQKb7OueIeb5Hi/ektInXHUP4GWCs80H9Vyr2qxoLFYKodgewQJrt2Eh/e52+roraSz7gCE7Y3rYMCAOgb4gfZowcDR6P8Mrl5+Sf82CBsPMn1OTLBa33gv7+zEsgd5WJlIy2/BOmYgYX9apuKLKaJUCxRjzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526003; c=relaxed/simple;
	bh=hALkaxiYIh2vBjc1WfRvYOsWoAfPPqN7joCCcn1GVIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/vp+dLJm3ukzflniIniHoaJRY/mlKgoALzu4kyh6InBMiK49cMuCcpWnnMgYZ8rnksbQy5c3B2gDguElW3df06I/XZ1yrNsvzsyuoY2ZEcGlVKJaaGPbeabNHuxvajlWwX4XCh+Bcrxlu4E5jw1anNLvXMldnLi3Pwzf476Dbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T64tPcob; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483770e0b25so45565045e9.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 00:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772525995; x=1773130795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z1zEhnh5O0fdKnDLR3La7MYGA94AVwh+++t+1BpkTBc=;
        b=T64tPcob6+hcSFrhM9d3loi8bogmlhd9m01kPKWkx9cAZCzArJHuwbqwaXHC5Qxi3x
         cgx6tUbKl9h0Q+4cghnMCzTJR3vm9/MiHdrhPukfxyC888As+jO4JmD74Yx46zt68o0r
         hAsTvSWZQcFGS6Ie1QarrNFxZ4EyZfFjnkXlLY/xXf/Wc57hTDvdeEQEaKkhgW77EdIU
         MIeT74eIUJ/+/4fo+UIcUHsc2Ldfr5SqNYa+pMqqZu+FoogSVqymGLtRgcEC+biM+ls8
         EHGTBrwacU0FhAXmmoOPy5LfcFp8nAeMu64modEzWQXDTyNcn3trH2QlKlmfqs8TAPqP
         C5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772525995; x=1773130795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1zEhnh5O0fdKnDLR3La7MYGA94AVwh+++t+1BpkTBc=;
        b=unq3c6mnbZ/FB701RjRkrD6o+mIEywIQxpzRO+GHxvPaOH7plkekbsRF5aJkaYFljr
         PgXxxOFdAhIIQNk/IGPKYkhLnYq2Fo/T7lYZnbsZIgTRsMAVOt7dkexG+amQSo4f+WF2
         jX2P0s88OdMlskOyaB+h4SFxuGFxK77ST/OJDAO0gRrTBlxV5fSMtDwhHuHk+vySHPlG
         R43yqySMjCYMcjO4DPlL9HD40M7OLxhp9nL73TaBl761YdP0O1ZdnnpIm/HPI5TlkUDz
         OqOkpg9knI1dsVcUPKJDyernIE24N6w6N5qp2djigH/AXsVNDBwH5IlQVc2RvaxiDr00
         +7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9pP08UmArEFpBFZuRtZDZiNcplOnfpeBeyFuVE7wiH1qBQSPx0Va6ZFCsA3F/B+7BW7QcNrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzea1xORyV/UFfleseAYqbF/wvoZjAdp1w804jR+3521/5YjZKX
	r9bXfw/423k8ZiRWn0oQ6YAeyHK7P60e/3KlYiQ1S56Shkm0SV4R9shQejIBZgLJkhE=
X-Gm-Gg: ATEYQzzxZo0MtUO44fVLWPOYr7Bf8dvtQBk+rBdVp8mx40GZqk529RPXxoZhd0c9YTS
	ImwRoZnzjztTrMhImir0aGhzKOMqL+4LvUF8f/2YRMUGIxPVzpzsxargnuHD16/u9BY0qPWoMdJ
	mCZLCQMbzw81Y7bxDQkX+FICcEN/uL3VBXPQg2pSFRvShldLhYM42omKYTyz9bVmqdNGN1xyLXE
	5xmwLp5OSMi7zYLKElS3T7u7wYJBDetdVQFFmJMn9oBvUZ+olk06cChiluRhSpbsIJ6ZbSYxLR8
	+1fO+9Dyaotb1KPm8H2y7riKMNygsI86MjwZnuaHB00E+IgO64aVnyyeJkc44UbKeIVX4+BPlZ8
	1U+TSoEs0LArd0CpRiUUlVEne8A6ZFqRX6WNx9IK8sMNvlsnOJ9hPgFsgK+5K02HzST6hqr3EiX
	hL6tWpknSHenHfTbqL5Rw=
X-Received: by 2002:a05:600c:4e51:b0:483:a27e:6706 with SMTP id 5b1f17b1804b1-483c9bdb288mr269417795e9.9.1772525995125;
        Tue, 03 Mar 2026 00:19:55 -0800 (PST)
Received: from u94a ([2401:e180:88b0:32b4:4c71:af95:b813:9623])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm163587105ad.68.2026.03.03.00.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 00:19:54 -0800 (PST)
Date: Tue, 3 Mar 2026 16:19:47 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, patches@lists.linux.dev, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/850] 6.19.6-rc2 review
Message-ID: <gdusu3tzjaoxvprsm7t5x2eyu4tguch2b5lk2yxdyrfpxlxxe6@wprtec5tnsp5>
References: <20260302160834.2518716-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302160834.2518716-1-sashal@kernel.org>
X-Rspamd-Queue-Id: 6B4D01EAB28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-222820-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:08:34AM -0500, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.19.6 release.
> There are 850 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:07:42 PM UTC 2026.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/22590800040/job/65447954958

[...]

