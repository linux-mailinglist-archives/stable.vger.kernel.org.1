Return-Path: <stable+bounces-215655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IhXFCgqi2kbQgAAu9opvQ
	(envelope-from <stable+bounces-215655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 13:52:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B936511B07C
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 13:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78558303D661
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 12:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29231A542;
	Tue, 10 Feb 2026 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZc1f1JZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE991DF261
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770727971; cv=none; b=POpg90VFz23lbrvSJucfPO4GycxmIZWjU/ZD5QDc3sQeN9bRJ0tZ/Vuq0SOD2Lwn4EEUJI5nCp0JFfveMkUO0mL92dqN1xs2oCJr0ZdYK28Z/cJUMQHBf5IIfJVJTv2DWndItoc5EWpJacfQcobQpofvplvA0c4LZhd8fEIWvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770727971; c=relaxed/simple;
	bh=1DyKn3UycXsFxgMaLuLclJ04D3Ikzr1+OHEY7VyXY8Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZMjYb4znnQpEw6dUlSv1Cj5P5R9T/GFgbt1INMx6ZLe8MdsFgDOy5p5K8Odrn7YYwONZJphuxZydbTJp+Jwd6N0PCBXGMg1qyBuelCykzxXUiY6TT5dlpa8IwkJAGz3J2VIDZkq8ClswyYueFq77zJ2mZHUrHZNRR3QVXdjXdNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZc1f1JZ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-896fa834290so30067026d6.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 04:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770727969; x=1771332769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJMMhftj/EXVrtTr21H/s198w+Mn/XzAcQ30g3m1lVY=;
        b=AZc1f1JZOAD43kFNF/zzCI65MGsd90/1Ss7HablCQd9EJmA+G5dZJWeYAWQ1JL3lBQ
         ny9oSReM6rkY3EeVM9+xpHfD5oyx78UTrCKhtb8V6YwMAXzGaGVlj5PAVXR0rP2sP8Xo
         bJ+C2R3Loh4OrVvU0UbxplWjMadjagVu+lEpgbQU07eKlFIyLIrHGVZ+s74vPqDIaCec
         CSqSYVzXnvvRkDF5K5OPLmV71V0Hqp9Nk76P63e0Jei/5cmtCaMoPuVfkaudWA3x0EFT
         GYVesUnZrDrt9nUWqJTM//2aPYkZWZuDQTTUoubXHKr/P+T0T5jZXbNPj2j1bvfti0XV
         eQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770727969; x=1771332769;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJMMhftj/EXVrtTr21H/s198w+Mn/XzAcQ30g3m1lVY=;
        b=viSSw5X4XbZtVjyPkenui91EDy4koKMJMRHpyubh2+lLj/F5tQLD57AmiZj7+NetH8
         x82XMVZX4iwoEgpn9nVd4S5uQVzHXRA98L+z6d4w5LHFIA3/a35DKz7JMTOOBtZxcXRm
         /Hd3S+SfO2k+OphG1R7dJ+lJzXYY+ofOkA4Pcrc09PzXnO7Hu7naeBRom64wuCrwsH7n
         +3N7yaO3sXm2z/rO7ycd50EJHu/ESHd/GspGzzXwIZbUwUk3LpqjJPMhPC+Mv34VDdYf
         OAtc7eW+U0UpEbtyDIElDiajVerSIdr0tl0sD1Wgfnoj5+wW0u0nBIV4bRKwM0nPjwqx
         fSFA==
X-Forwarded-Encrypted: i=1; AJvYcCXe2gHJZ4Dtxg+QvPldD5PEsQ7gc+E5ZJUNNFywA6TNa5zBqIgfaskTX2O+pJjsHoUsc91U2uM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lacTH7FnClbfTN34t4EcqyOj4n7mvGIl24UdUipxA+HjNInT
	x49JSJ9fB8yMntGIWogjs3geiAJ2QIbtyp3aTDa9G8eMcOTSlfsqOK0=
X-Gm-Gg: AZuq6aJmdEOl5pHDrQEktHs/Ic304jzvcLhnGG3ZBg43bq3BI8/xOZ6ljfQ8FM6hfyk
	kfJ4bQwE0VweGc5Y6iMvY7EO3Qqrj1zMNsP9OSD+lTRosRwJLU31njMVLCMpYj4MoHmqtYMi37l
	t5wbN4NF1vZwsRCevxQ5WTJNsAkRw1sA4yfSEpjTUp5ECK1AsKe/CHtv6ASzeBwo5XpYhozZxAO
	T9KV8LokTgterYW7Kzrz23bbfAQ+ogbzb4dw3uGImd+9vmKVHYW0jZlJJWhy9TRS92ttuNO3Osi
	2xGbQXqrvjztQOlTdTjGEU/e9Z82h8TD7guw0EsdOsItBFFhluk5+qpptMSbOB8nj/CWkgsFN58
	tAV3JNo0CKlXn+v1sfVD/tCYsvfzSMAFCvPb4IR7T7MKmJuzJlIe3KRr8u4/Vkq+ra8i8gIC+0c
	1imG+fhgvsZe/9FAcF69uJUxIyxiMaA+WpZUqzVyHfmVDfYTY+I8rh8kLNQSOhDw==
X-Received: by 2002:a05:6214:2429:b0:896:af37:9594 with SMTP id 6a1803df08f44-8970d3b4735mr31026316d6.9.1770727969533;
        Tue, 10 Feb 2026 04:52:49 -0800 (PST)
Received: from [120.7.1.23] (135-23-93-252.cpe.pppoe.ca. [135.23.93.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89549659cdbsm79024856d6.13.2026.02.10.04.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 04:52:49 -0800 (PST)
Subject: Re: [PATCH 5.10 00/41] 5.10.250-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260209142256.797267956@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <25384e0c-f593-4083-d1ec-5340fe330adb@gmail.com>
Date: Tue, 10 Feb 2026 07:52:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260209142256.797267956@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215655-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[terraluna977@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B936511B07C
X-Rspamd-Action: no action

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.250 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
On i386:  builts OK, boots OK, no new dmesg issues.

Tested-by: Woody Suwalski <terraluna977@gmail.com>

