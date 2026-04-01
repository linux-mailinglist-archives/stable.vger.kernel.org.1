Return-Path: <stable+bounces-232807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FqLNP1CzWkkbAYAu9opvQ
	(envelope-from <stable+bounces-232807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:08:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AB737DB5C
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03CD830360B5
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582193F7E9D;
	Wed,  1 Apr 2026 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="DShwVEvK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD1F36922D
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059137; cv=pass; b=RlTr5A0o6i4NEb2/jrue8SogSUubvSfD4eNCY3XRDpt7SfoeXvhpPK9qZy3m4Q1yHk4nfybBRMeBTqCbpGFhF94jLUq6yc0mm5CZKK1tGduMg9VMIVulcHFpFS/nPwzFlfpE/nu7xmNTD206YpxbQ5vr0u2vBKOzsy5gHneFQqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059137; c=relaxed/simple;
	bh=+SNyJtqnsHkXb/MqyOkimza1yNnqGZoQb7403XYFCqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQcumkC7OSmk3qSpdBG61jeMMPfK2Q4rSBEN/hlCm9TT605sF9UxT+1eJMS+tIAi+W247YmjQBIfzOgFQkkSdWB/sEqRRx0vUXyhei3A1RVTlxIy85to2Dvt326vGKhVcSKkW6zTH/50OndnXu1bri7pYApycCFq0NV/sSmJSlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=DShwVEvK; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9961e4f71bso1048854466b.3
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 08:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775059134; cv=none;
        d=google.com; s=arc-20240605;
        b=JLBqqa+vilFg32Iqc9XewfwC0tsleJ/hSs0Yu3uleDYvZF2GnpXkJrHZIpiy7cKPjR
         pwdbTLwvdwkk6Fi49N5/xEcCi745NqUM/gYJpmMPJhwgwnuLNCYTZUdBBBZp9FotFzi9
         fXxVgAWbX/AODH6WS6UosWpiHx3UzJ+nIisUXmKT0sAI8e/8d3qWN9geREHYTFKIoXnq
         DAS12juhiBHTEtXGt6kSw4XCzgtCcVH7lrM4C0Ubl/6M9aKExZ6fgTigYpRtFRo03JyC
         rbNV56vKTyARs9RLT8+69+XQz78w0NY4cGvS6MxzHfr1xvGJl1rrNdMz5dzTxT9Yat7B
         9XdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ofZWgwy6iDaHBYYItk0VakheI0zjgXnoCfAl8Suh6U8=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=aO65XLaIYt3+FbBrkIJihVYHSTao//z3fGypRa+duLpibO5zbxUxnp38VVW+DoH3O/
         DpLCkEe3G+GV4ofQc06eoLeHF7G1R/vOXqKCLooQzaO9a60M+GSfeaeMUjgLpMHQAQIS
         qm7m9COHEuMzZQf7jIfTf+ODaCaqDrESJjehsA0qQSs3mu+GjOiOyNfYu11RvooDSXO8
         Q83EYOwDbez6nkR4TL4N2CmS3jYHXfjxmOl9qVpJ3bkN30UF5asBVgTmTpTxeysIn5qa
         V0qngvXGGp+9MdQCs+ud3+AMp6S84UfO8lsQnd/KYuGYungXZFjd/5rGJFAzZc/x/Lji
         1C1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1775059134; x=1775663934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ofZWgwy6iDaHBYYItk0VakheI0zjgXnoCfAl8Suh6U8=;
        b=DShwVEvKa5t1VZ6xJNKNxMuLeUMXTqjm5uKdieP35eBrasux4dm29ayzVIjU5yWS17
         agHk7C42+CacYetAMaaFD7Rb6Arcra0kvhPaAIoEJpp7NU9Al18zMly8++3sEJvhe2r7
         54CRpBaLvTyXC2b3Z+LR68RTn+zTs+Qh86B284d7VKfjIhVkJPS7nTiqS61vF8NyO5a4
         0nGuWVNb4sB8ICzgNBm7Hp6SKD7T1Au6dUwUZtJdySVt5sR8Lcf5mDq9yOrBGyYlolQC
         CZKyq/ELDqYUeVIeXTKJQMIuDj2v9IfrLEhtOdbkq33OVPqabhrR3JWqR8JejZVC+3Hu
         zGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059134; x=1775663934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofZWgwy6iDaHBYYItk0VakheI0zjgXnoCfAl8Suh6U8=;
        b=GCUulAHqWMh+n2puedsQsnxW65AetBczVSTEkbHQdjUW1euUuIv2NjeyKsaudv8Ick
         Rhckt4++Dquo83qgIhqAnGeMkUVWoly3QQEYOJbld/HnGK78i8FGejjfki+sK2pDu6us
         pSRH8KbUbQEyZoJ/WKKWQE43+tYLPILIiRlyNoJjw/6OqrLGM6HWspY7gDT+bTy4yOLz
         G87rNBWJfgxsryfACnUuUtgYAFUen/IudHwf1iwHXa7Vq0Zs+xUYOLHhfurrCu+m2nj9
         jdaQ7aH/GU1PWR2ioU65DWK3SqKAb5b0hvkdbw3n2xmaXrHsS2xwf7i8EZtUujt65DqA
         90Yg==
X-Gm-Message-State: AOJu0Yx7nVr1ebosiOaH1JVDkCwa8kdQBPL/Qzi0PlskjRQmSrrI8hDL
	51MJKDMelIp/KbdxqYvARYedD5iHX00y6DLS81Ttj5SWj0XmtsvEP2PQ5SjLX4UdWSO8zK6cp7h
	ibznCkPTV6t7CrTBQ4Ie2vWI7T19S+OG0zh13bZf/hw==
X-Gm-Gg: ATEYQzy71BBHooSDOw8F6XebeVMMr87gU4ylTPP06cA2P16yaOPDFlWeXWiCwS3aJzy
	MAD5zO35NdDqwDPjKRzKCjUxZs+tLs2y+owa3JTdwIoGBw1U7sxeWb9SXgLzi0z1JbDX2JSoYps
	JTi220RLSa+u5eINw3pp1ZftYys8bTfvDQIgtoepubqs+J/CmCj3aZKNRCxbVSZyx/L2SPb+2PN
	Dnt8j5KGWaDeqsoYYrMwHIVb1rOkjxuRidlPHPKxALty4tqbcCIghZF96OL1mpheNOvdAnEDI1e
	uKU69PmBgKYx99p4ES4aGrv9f5pynXrTlJMIaVBrB2DKv4YxqjCY6r10QVGvOQTxt9AV
X-Received: by 2002:a17:907:a688:b0:b96:e593:fd32 with SMTP id
 a640c23a62f3a-b9c138e1fd1mr315996366b.12.1775059133943; Wed, 01 Apr 2026
 08:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331161758.909578033@linuxfoundation.org>
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 1 Apr 2026 21:28:14 +0530
X-Gm-Features: AQROBzDKW8-Anb0EFwwtUyt6qA-W2aGf7GbHuxZGpnDMV6eYneZuJAyMWTsQiKw
Message-ID: <CAG=yYwm3YQ_yUFd_u5sQLYqMNnPP4uxcfuQT3vHJZVVZHjj+GQ@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
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
	TAGGED_FROM(0.00)[bounces-232807-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,rajagiritech-edu-in.20230601.gappssmtp.com:dkim,rajagiritech.edu.in:email]
X-Rspamd-Queue-Id: 42AB737DB5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 hello,

$sudo dmesg -l err
[sudo] password for jeffrin:
[   11.985734] nouveau 0000:01:00.0: drm: failed to create ce channel, -22
[   33.336996] nouveau 0000:01:00.0: msvld: unable to load firmware data
[   33.337001] nouveau 0000:01:00.0: msvld: init failed, -19
[   33.366460] nouveau 0000:01:00.0: gr: TRAP ch 3 [007fb90000
gst-plugin-scan[1242]]
[   33.366485] nouveau 0000:01:00.0: gr: GPC0/PROP trap: 00000020
[RT_HEIGHT_OVERRUN] x = 48, y = 16, format = 37, storage type = 0
[   43.524931] nouveau 0000:01:00.0: msvld: unable to load firmware data
[   43.524937] nouveau 0000:01:00.0: msvld: init failed, -19
$



Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology

