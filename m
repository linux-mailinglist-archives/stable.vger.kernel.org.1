Return-Path: <stable+bounces-235325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDeeIVtT12lHMggAu9opvQ
	(envelope-from <stable+bounces-235325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:20:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F38E43C6EDB
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C4073023A5B
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 07:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5783E3101B8;
	Thu,  9 Apr 2026 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX2pJFWo"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689BC33CEB0
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719241; cv=pass; b=Yb2hsrNtgeCLeqy5Fjuo+Yed8xhJo/m/QDRK0H5v23jKlMzIAaY14fQRM+m8JuJansQSYYfYNYqrr7yJOXueOTAbnt2wJWFxkKM/kQV4xBpHS+ilA/XcPEiJYdX2/6Y07Cf50W/c+oavIry+iVP2ODNWpCYVFZEkuvZC8SMDXxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719241; c=relaxed/simple;
	bh=+Hicyg5v15Su7GwMFOU52nCKmlDelvMgyCZh31GLXIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKKwTjf7T0+ndylBQnL6QA5OvdPwv/vZvYGrhhCAotOKtR1nQdVHGPwpm1Ok51HxJluBjI0MnPS7xwzwR05bjHmbPzTlkpxkQKBD0Y2CaZNi8vJ7X6VI0dkdT2XofJGZWZiDdaSz30Hy5rL7g+0T+BP1cEwXZMVaWdshWl+N7xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX2pJFWo; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso454935eec.1
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 00:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775719237; cv=none;
        d=google.com; s=arc-20240605;
        b=PpFVOd8D+Wlxnbk4SJ3q9OV9sCpT+T+d+AuOeKixkuM20VLgU7MtpkND+w4uZnfUJL
         xMLJg0fkF0c1SteLCdqU+qjLCxPTzTBK8MKWiLju+kn/E5O0UYxaEKgXopkxVWhKVuMx
         SNqj/bk17dmTHbNaPRqFfhbbXxBquhsfwIQt+DEumvTjEf2r7sIWCGI21QEhrKJ4p2hB
         lYCRyjHAzqYuOqH90HYaK/Uw8wK3/qXFeynfmWIyqC6WXk7PP1MKU763qL0w9OrWYZa0
         QSKktCnsG4aq17d1GQ7NNTYvjGQ2OtLlV1sVgQOckBmawuatimhd8CsTJ2Ml0E1/j6NS
         xbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/Wi6/GuqpYSjyJG33BMyiqTpw0EbstROAqNs1xZ42YQ=;
        fh=FkDEjxsQCto5G16bXW53yWSuROpeVkhkW4YCq6XCAkA=;
        b=QYXtxu0K8TYglkYpLrVO8E5iaDhIs5PpWWicp5CMwpghGlxPjgES/j5NqpJMWVS7cG
         NHfob1ZM0r0KY3q5A2gn09641LGakmnJ7OpFwCP6xjmBNHz3JHxuskATamo63cgoj3Uk
         FKWq9FWbtVnlD9Mu/iwMjd1k8SPd+m7UwNcEnbZ/ciBLrtRJ2rCyQbxfv/R0FxpLd55t
         3B08R5JE+DXZW2BjO0sBeWITx5aDJQsZqh7KmAolIg6VIvfSbxupcn95jU85vJ8eU4US
         Nqoib55ifKxBsuNmo+Xqu8NIivOLRbmKq3dJmQgOpTzyyRZ4QcNgLSqebJNyhq+6/bV+
         xMLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775719237; x=1776324037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Wi6/GuqpYSjyJG33BMyiqTpw0EbstROAqNs1xZ42YQ=;
        b=PX2pJFWofbz9pinJ+9Z22tOI2WorrE1jNhnaLDoidMAzXpEmRDerUxA0/Ity+jLWK2
         tuz2BTwDS+qfqg1GVBx20Hphbp31DaBh9VGWOPbRToZhAiMwwwVXYkzXTj0kDW55VDr9
         b/TC/NMgcoVdJ1eYdDPaa4pZPfGG41ImpfGDykvK86U0DZOhFdIG/0BSLiS28ZXJ4aR+
         nRKWm6CUq+IwNV/gFLELEEol34lCOP27qr8kFM1Orlb8lsrYakoM3K4RgR9RfbMZSqCp
         gGGWvCZm1FOuza5rpQ6YRxKB6TS2m1irz4chlaDNSTGa5OCZn1wV3MLaT5ycqHax8wfk
         doFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775719237; x=1776324037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Wi6/GuqpYSjyJG33BMyiqTpw0EbstROAqNs1xZ42YQ=;
        b=SnlrlKXUPr01JuSgZ6kMuigLCGuZBhFGlAS4CGsiTmJaKn7rKA01jj2CgvIhE0kFYB
         +q9WNa6RLtgGHPhv++NnLz2x9qstouiPYCMphfNMDgcq78q9TiP2UUbWJpjdGaUBrYKT
         iiJuREbHoWxQvuvBWFcYaiEKzGrOPj6Qfzner6e0jZw27iTdWWUPUDOw44YrgkZCWEVa
         gsLJGSdbVkRc6sDfd7F9MjCbatJT553VrBe9u1a7pmTEk6xVfx7Nth39mCQpAunSZiwq
         X548k/h3oaheSzCUnZFMSKj/LS6GKKu/SJBML9GYzc2xzYaxWVFjY/csSpzm3JCgdgj0
         JhgA==
X-Forwarded-Encrypted: i=1; AJvYcCUOB2cQ64RN+krwLtY/kRTGe3m5BKGc1aHXkepeOSgFkbeGmAWtskQltd0zr/jYM7YsiGfKzu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoWGuNv+wXJ+BqlJuRwpjwh4SM7I0wqxduoxvyjKGXPJytw3A
	Uw7EDiWPzb6+Rcr5fE7bz8QddvP52sw/OyMDlKz0ZxoWgsDNgi2FW3TUWrtEU5/x01kjyU+wNqP
	3Yz0+MYEc+bCvaOelMQdwEieuKGVjt0Q=
X-Gm-Gg: AeBDies/r/kRNZej5WbEyYoeIKhw0tUBkF8FXHAuZvz4Ey8dhwDLsQmy41YW1Kkr0lb
	BIM+XRie2CVEVkqvZ7/2fFo6aOvxpQrPS/cn1ur/WSWbcGN9h+J0mIVAkoa7RhaG8SbV/EgnLCj
	neluWakEB6zcPfpMR0LdUjic8dgIb8oDl0uDyxvDpdJX/GZDwr1lfWY4h81AFCMjAuDZyOVIFAQ
	0MhFXqXupX8BrhMb4zm8Hi0V8bVZPZmUvctthJGHl5wZSQF0BPHQQNApniLZ5505YKEo5YMV1Dy
	qF7LK4uh6u5Po1dC5srvBAbSzyKHOsTJ4V/9wUqL7qAlOkZqctPauOA7RPfD91MPI2JGDccR/w/
	ZFS6q0ZOAzsmbasLwSZb2EgL6RYlL+CAArU8Ea2NE0m5CAurA1oadD+lEjBfJJO0xGnCr73TU1W
	HWTSjgfLjewdV8S6kpTCs=
X-Received: by 2002:a05:7301:6743:b0:2be:2f62:8bb6 with SMTP id
 5a478bee46e88-2d40f0ed9d2mr1303235eec.30.1775719237398; Thu, 09 Apr 2026
 00:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408175939.393281918@linuxfoundation.org> <7we3hoy35kjuwbrzarr4266ylu4x4zcurpuhuhkuzhijbhq2fx@o3zp2r6kgvoh>
In-Reply-To: <7we3hoy35kjuwbrzarr4266ylu4x4zcurpuhuhkuzhijbhq2fx@o3zp2r6kgvoh>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 9 Apr 2026 09:20:24 +0200
X-Gm-Features: AQROBzA1UGLLpF8P0JYFCm58OfHykChiAozB7mmP-BBUUlEFhoIgyrA19mOH8R8
Message-ID: <CADo9pHgtqbPt4Ji39unrZYz-yg3jj3TB+xM+L9LmJceoSpC6Ng@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc1 review
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Sasha Levin <sashal@kernel.org>, 
	Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235325-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[suse.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,archboot.com:url,youtu.be:url,gigabyte.com:url,inet.se:url]
X-Rspamd-Queue-Id: F38E43C6EDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

while listening to Sasha: https://youtu.be/V4p-BlBd8pU

Den tors 9 apr. 2026 kl 08:15 skrev Shung-Hsi Yu <shung-hsi.yu@suse.com>:
>
> On Wed, Apr 08, 2026 at 08:00:00PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.19.12 release.
> > There are 311 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> > Anything received after that time might be too late.
>
> test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
> test_verifier in BPF selftests all passes[1] on x86_64.
>
> Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
>
> 1: https://github.com/shunghsiyu/libbpf/actions/runs/24153838933/job/70487760072
>
> [...]
>

