Return-Path: <stable+bounces-214663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HELCSXzhWk+IgQAu9opvQ
	(envelope-from <stable+bounces-214663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 14:56:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F220FE832
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 14:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB04230886E7
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E93EDACF;
	Fri,  6 Feb 2026 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="GUMnhvsR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965643ECBC2
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385991; cv=pass; b=G6OrKPEJAaoFMz30YKpusSJz4ICpDCvU8ycSojFad+7MmD2oE8GfcxSo3nBtPnox6MDcbp/6avTKHABuWgX4buFV8aziTYtD8PR9+4bplWstpbY8PKT/4bp1J/O5IwrVnkHyvg5+c2GuMktNSKPNC98gXm8wCFH4m0DO2L42dSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385991; c=relaxed/simple;
	bh=xPmqZXtDaeZy1l7nPx4Li+ZJLcAZgcgfRCXJGOO8cs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQ/HWJ5DV2XNHgRuWupjZJjZK3awckWs0IsPECJqnewFvTIIoecxGwoSeZXFDsmannuPag0vltEfrj7PkVD/N8azVcqjdp4+OH7L5AQnFSEWq8UO2AYoGNW4Q7QfjUM8mdutd4rV96VchRz9P30EGFrIX5W1wYHpq89XaYot8so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=GUMnhvsR; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8870ac4c4eso112603466b.2
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 05:53:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770385989; cv=none;
        d=google.com; s=arc-20240605;
        b=CDk/2Cnsm3A2UERaITaI0YPlJZxXjKpcEebjAZPV0HwZF7aILAX4O7gXyifPXoFjkU
         E9V8LS03enk7MZY1SWOzQXC9FQxYxvsjhYKx+MgTpnfeHh5PmyVqIXfLy+JriQexV3lI
         y2h77tE/V9urhKTJcNbAQvJFNqdzX+jS+TK0AVKgce7dgKE9isUdAjjXNfQsemSlDYRu
         xzmEfLIwrciJNw+9JTZg0crO5Y8d1kZermyOEXI07NsAOrohRl8FwSOrZ5DPvgjZFUiR
         I8Ha+4KpEBZSQYV5Byil9nUmstekNApZmTdnW8UKEU4O2HbAPhiKBVb5qe6AagohDpQx
         S8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SA4i154NvMRBgrttmSXsePypeEvh1Nz55QBHELzuvgg=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=GZ6WICuGn+07Y3Xk6e5KnkW91OLZLaNzpGBFyHYA5SbdlrRdEY8UOg0MjMbBH2LPqF
         Xu8/WMRczsRrEMVXchj5wjBgE/Pao9ux3FM85jibooCEvKsr7qJo0K0AIYozrrYdOyP9
         fHDdCFUBO3fgJ8b56nRBXLb/Syu/JRRLPPApsbd/EhmNNKPzugaQqRFVVjvsmx0ymMVD
         vXjG77zpIh9A1PyG4TxwBr1vSir7/X4SG7Fd4W960+o2rNXG1nMKzOxOkxWrk385tVB8
         S1H+4uyGUoQ+SsO6PHNueoydcotJMeloOeffPQM++OnBV8hO8arHZQ2Glirn4B+Bz6qQ
         UhxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1770385989; x=1770990789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SA4i154NvMRBgrttmSXsePypeEvh1Nz55QBHELzuvgg=;
        b=GUMnhvsRpQdc2P6UGsDnRgdMNy9ukv4ltQQpF8mJ+vETfz/qRt7NEfMezUeQQytsGY
         L1J8CMB+vthekbNgFHd5hDFHLGXHJ/LcnACYF9VlyUHKt8Eqgt6rOc9WACVp/xS6aN9P
         jaqMnQV9R+RxAQKjvy6oqpNNDY4RsC39f9jbzj1f0vppWHCqNxTcu4SyKaLq3oq5KRnf
         pk0yRKaIQYIZ9YvlurRdGPxk3zDyfl2t4v8oFXy6vJI6UjXTt8+d/lXUGYuORwva/fGd
         0NyFgFOjC5w2wrTilUuRJ+e/tbl6jIjEJvcQK+cLmjGWHNSX+1iE4Jz/UKDBYny6Q6Kc
         ip+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385989; x=1770990789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA4i154NvMRBgrttmSXsePypeEvh1Nz55QBHELzuvgg=;
        b=gh4NU3Sqg/4MntKY+hv/B/nsEYA7GzRt6GlYgBcczGv/NOBc1Nx1KSU9v/SFMmKU9i
         v0Ir2LyGBIGX1hn+NKdi3OGRzB8xybYaqaEe3WawTDacKRE50SGkTAttN9BoLnbhqHiu
         U8j05UCQc8lex8dYv9KV+mBBwkxzw+4951Wn0wLipo5k4u9WvIjMCFxOO5iZkvJsEko1
         VWVFzPwq6oeFUKTYzA3vp5YXj++tS5ZPd59Rmd2EfL8uG9lLqRkVg2s7Dg+4IepoKPq+
         IMlV9heVj0oTgA/HaiLNB6D1bGqZ95MYByDlL7BM72oUkRoR+toIXxlrYFBUg2Oi1Z3Y
         2Pww==
X-Gm-Message-State: AOJu0Yw/Rb5u6TpO284sQt4dkmMHYBL2utqBv3axb7eQqlQl5+bAlyZz
	f8eb6ez+4PxLFcivtzfFrhEomdXMZAuFDMRuRJvUaKU3pmBs8lA2SUQ7KFl3PxyAviPihgE3d4r
	OzQVNB5shkN+p4NATGfPOmkUMr4ZPK6/dy4fUCWSYNw==
X-Gm-Gg: AZuq6aKoonIrLuo+p3QXG9jRl5lghclCt/RDZxUSZH8jy4eMTuYjkbEwcaN0pteDL43
	JzfYnglosXnUHKDDG8Ak87MmeT8I2IvuApZrUc1njcdsZXPBhE0rvrCM9ryoZjpb6UAa/9qcj6w
	k9MNrtgdI2pZ33wTgJLsS5UpYBcCQbIwfLy+wkfS820S2GcynIF3+NP/qAmFjDsSK82RJo+zI8W
	2EsHCHM6vjv8ou3eFT/+SCnJgx39K6s40rU1Sk/QAKalJDeXN1wJpl+bbD0oW9yi9HpyMNJ
X-Received: by 2002:a17:906:fe02:b0:b8e:3d49:25db with SMTP id
 a640c23a62f3a-b8edf3ef349mr161838766b.54.1770385988903; Fri, 06 Feb 2026
 05:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204143851.857060534@linuxfoundation.org> <CAG=yYwnSJCp6W6+0MGG_aaj+Ao7Qhiza0FKvrP-4wf6f9x1SQQ@mail.gmail.com>
 <2026020601-persecute-avenging-f539@gregkh> <CAG=yYwmqwb-v-31bk5sXcBGtTQ3JGgH4Kse0nWAtbX5f01764A@mail.gmail.com>
 <2026020652-quarry-clench-2fd8@gregkh>
In-Reply-To: <2026020652-quarry-clench-2fd8@gregkh>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 6 Feb 2026 19:22:32 +0530
X-Gm-Features: AZwV_QjQQIAZjkHETPzdJnQsi4ToG4FQet8_ZVQlHhpyUdg-4_JuTjRFeG1QdFw
Message-ID: <CAG=yYwmHBDLuUzGODNFjWmgRi7hOkc3-JLRwf0ayf0+7TcagTg@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/122] 6.18.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214663-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,rajagiritech-edu-in.20230601.gappssmtp.com:dkim,rajagiritech.edu.in:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F220FE832
X-Rspamd-Action: no action

>
> So it works now?
>
> I'm confused,
anyway the build works well
thanks related


Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology


-- 
software engineer
rajagiri school of engineering and technology

