Return-Path: <stable+bounces-215674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D/aJEpJi2l1TwAAu9opvQ
	(envelope-from <stable+bounces-215674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 16:05:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7A111C3BD
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 16:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0777D3009399
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8BA37FF55;
	Tue, 10 Feb 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="Qn8M77/8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DFE367F25
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735933; cv=pass; b=swURVODmGZILorMpb5nlRBXPRczddPeyeDA+/xJFf0DSAbwDdDrjtExM1Xlk3zZ6iGH74ERpNIfSYDCgqu7S5GH6hcXr65HQ48ujCyuqjyz6vrYurnhIC+pxYH6mpRGPbewOPzXw58S6hTi3xOddFfwZY8caDMKvaHuvwMcwjI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735933; c=relaxed/simple;
	bh=lMPk2ACbC+BT7FsHdf5d3nLYVQFBs/ErPnNxK/94ca8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJmokgl3w/a/nOcmMrjGUMsXS+DZkhJfU8a35U4yNcutpQbJVgPpWLnKah4oIcZ9gH96ZTs4pa6ZF4s8Rl5bTh618FyxGE+imbXyrx5t+oYSGT0wxHuVnmba1/M5wFZ8rtOUjEyIcg0DuOWmKtvNWu19bfgxlLLi082p/1kBc+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=Qn8M77/8; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so770227766b.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 07:05:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770735931; cv=none;
        d=google.com; s=arc-20240605;
        b=LTWuqc8hXXmmUT/7mXnb4mqWrVjRh53FZuz7/QqlgWVtZEXcDw1foRbj03Y/7QMSgC
         EU1ihSXFHDyrteigjk1JwhMbm92fuAMH8vSiskQtLaQGrjXJ+s8vvf/dZsFggeCDS/dM
         Q/qEAw526W124CW+jBufxtlajcieoMNhvqsrMTJ50H9nODYjyRnMr1hUQZgyP5bLm7uY
         GJvcJToPYyWJKGsrAqmqidv8qJsWD24zOtv8aBRaNE58HNJgC7d9RNAr31Qttzdnar5F
         5sWU2pmRhwNQz8fallxaoLjqjd540CcC+6+7UKIj4FziGb7ymWay31EmbTzALUrvZEdy
         gcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rLtp+aeqK918GHQyzuQTcFqlRkjQRR6EBeZu1C1U4j0=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=MgHmPIVVjMiwxLOXhVzPpyg4lZ1BUgDEaW/QLZ/0zQZAJoveCy+jAQZQSIxTqw/t9Z
         mcrfJs5BIYaXM9P7dEPaBdTtmcQn1sRqIewn+Qg6dgoQGaryxBjqzslMo4/EaSBDkNzG
         IXgZf5oD0xZ9VgSZtzj+xf9fTHeAJHfGPThJUAmx764Gmy5Cz+nSV/wikApprv24B+eN
         vMjxZAJAQCozS9E8yC7E8W5xWYksBuWGe8Wy7A8aS09TiTtwTbY1Ijz7eR+c3eT0pC6q
         elfDuwDIgWYPKSThFA/fPCBCH2YKHVDhy3T0NGDuml7EpkhNLdGzqjT3DN7zB2SE5zib
         4b2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1770735931; x=1771340731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rLtp+aeqK918GHQyzuQTcFqlRkjQRR6EBeZu1C1U4j0=;
        b=Qn8M77/8zk3i9nVw/MvXeOelTFqlvCV4hU+uxAC9pJ6J/fjeMy/zR/I1DcSXaBglQS
         OfYNKPgqiAiANfe5GtJywz9ihSdsuw7OoEKLFhXXF6X71KhXpUuEMgrXK0Do12fRwM09
         RUUqlFLI/gPR9HoqFZCLqAKQXt9aoGEr3bAiyn+RBg7G+tJTSNaVci4sdBax0XBmK043
         gZuYtIA6Zqll7Z6AXYPMx2RrgMRW3VSLpwwyWYctcwd1uMMAES9oqalTVgs/xIefmYmd
         8rlv2ABpgeijqU/c0w5hoFmmnL0kBIb6ZxsrSTVJvPemzKx44Po1egR55B/cUuqxT8RO
         MVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770735931; x=1771340731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLtp+aeqK918GHQyzuQTcFqlRkjQRR6EBeZu1C1U4j0=;
        b=WqBe3cZ6suC1wEbHxwQXcrMRVR1zhpaii0Bwyc6aztdULnLhQGzNIs+q6Pj+Ig4VNi
         xIZiJKNofyWi73dZC4fe/KuabszF4+7a6u4qAHWSg6Z3LfD13tn2y8z+Xbn3svW5jchQ
         M9ASKgkMRdf02dWD4x7CWNe7P6rxkn+PEf8rBbnmgVzmorHm/zR5CCqJlIxaYqOYIvG7
         srliU62jaK4Tzz+8/s1J/XxTEseazKqwr+7Qq9aUL2iBFxctvvRIsWE7C3UsRdlQatoD
         leaCu1zzsNS+G0JbEDluRNH8pPJ3XKqW8QJiUtfYRe6mRgZ1sFRuDkExDxjcWl8FIzUZ
         /t7g==
X-Gm-Message-State: AOJu0YzfgdA2mGjfrWucAVQSUEDBLeLYR852iuJgtyhyp3g9qPZ8ub4m
	f79tPkwr80URXhvpgwK7iJ0jCgp97m4hcn4CMAtOp5S/2+QbroZ+IJ+IBtxmYbqPkmoJjZ29PyO
	Kzc75xqD7ua8VWK0O+ZBuH5xlcPdvxlvB3zmtP2k6VQ==
X-Gm-Gg: AZuq6aKcJoTjuRWoXbyYGDhb+mS2eZ4GgyseDWLgs/RUA2VKnnrzlhekOV5RL1Hz/49
	27le+PZjWnvYGMIf3uAA4lYnmB688y5BUVL0IvZNkd2T1TBsQm/25K7QXFbBQmgGIoZc/DC15Li
	1YHt7ejsYFsIBLBlxNwBOIIGG15GosW6VMbSo0khLh67yzSH39OYgSBPcXB8gWxR7S2FJ0/GH1d
	T6KShwya/mNS29J5GakXKEBkkvXzls9gS4gkh3UNmZd+2vv7iakVVGuOzEf8ri2zzBoMlqp9Mkd
	jwn8JNFNcuKE/AYh7SWDlaPAk+SbbUWrTzSwCq7cRgLKHvXyJuRHkTYXKjkYF2sufJ694w==
X-Received: by 2002:a17:907:2da2:b0:b87:711f:97b9 with SMTP id
 a640c23a62f3a-b8edf2fb575mr929138166b.31.1770735930534; Tue, 10 Feb 2026
 07:05:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209142320.474120190@linuxfoundation.org>
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Tue, 10 Feb 2026 20:34:53 +0530
X-Gm-Features: AZwV_Qj_gQ13wu0O2ImrZP1Y1_Vy7B8r-iGyvwPf5l9zCKza4knqIWsae5073_E
Message-ID: <CAG=yYwkhAAm76qUH_2dCHUp8+hGzvgT1Fm_288Z-=QRG+tAbfQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/175] 6.18.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	TAGGED_FROM(0.00)[bounces-215674-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,rajagiritech-edu-in.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 8D7A111C3BD
X-Rspamd-Action: no action

 hello

dmesg  stuff's ...
------------------------error----------------------------
[   21.307326] lp lp.0: really_probe: driver_sysfs_add failed
[   21.309030] kobject: kobject_add_internal failed for lp0 (error: -2
parent: printer)
------------------------error----------------------------
I DO NOT HAVE A PRINTER

--------------------------info----------------------------
[   64.066312] traps: wireplumber[1335] general protection fault
ip:7fa9701d14c2 sp:7ffec89aa4f0 error:0 in
libgobject-2.0.so.0.8600.3[174c2,7fa9701ca000+36000]
--------------------------info------------------------------

my gnome-terminal (VT)  stopped during compilation.
i forgot to get screenshot (sorry). i  started a fresh new terminal
and did sync and then   re-compilation continued typically normal.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology-

