Return-Path: <stable+bounces-232641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KaxJ8V1zGn1SwYAu9opvQ
	(envelope-from <stable+bounces-232641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:32:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1611837380C
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93B03306129C
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 01:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B352777FD;
	Wed,  1 Apr 2026 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jS4WhiSa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC17E27FB35
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775007168; cv=none; b=B1REtrs4ZWFoINwb5fJQxH59183WpxlHYbRksckahxs2vvJLKbBgG2TqGj5QpC72UQkfma20BlTbGBDXGO/U7OhosCHhVtXOgNcK5vxJLZaFciI+vSp+qal8JqcwwGDX9Bv4U4hISkArDaN8JWunZXMQJ5hKpU1HxqjY3gfWZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775007168; c=relaxed/simple;
	bh=FvPnJOtchaOMZT4wCLNb0Hf3tgFeuUiZAfTnfIfz6Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/Ll+lOr4LyMY57Am7XYL1WCjKDvgta/AtpOH4X9dJlM6P4tMeO/4rgiC28HFzVdvF3cqv9CeWe+ZHHFuNL12n1GFKMiMZ5JT9lTtBFMkZmXPzN7vrNIrG4hYvY6YCvTvVsGe/rhIvHgqFfk5aXXDJcz/7BXmK0loAqxujpQvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jS4WhiSa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486b9675d36so52008775e9.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 18:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1775007165; x=1775611965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2T/XLQ7RKXHebgKd5i5a4vHwH0UE4XVg7tpmJKpdoaY=;
        b=jS4WhiSaGbaIPny5h7uPkjkNzUGa9wVb2wGWI6/UP7gyt2vao6DpqR6WKIsJlwXDmv
         MWY/MHUeJLDk2B1DvcWMmRW4Ipj/yVupbIeQqrj//cDCV9KgMLcGe/OXfkTMbg+TLofu
         RReZ1AP0gF7HP3lvqoPgrUFdt2MZEn0WYEeFeiPYA0eeHqY013QBeBwr/C8nGy+tdwvc
         FYlWAaGuyHf6ZVzDO+0zjXH/7Flw4YgjqpQXR2+wnu9GzdbtyLuVDDt0wcngk1Ka74Rm
         rEwZUenIYvXlzYSv8FDCHpAmKp78PxDwp0hbQgRnfqHkttSID+d/7ZYzRHGbMVwQ1O9W
         /Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775007165; x=1775611965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2T/XLQ7RKXHebgKd5i5a4vHwH0UE4XVg7tpmJKpdoaY=;
        b=Zn2oB3dX2BptjchhfgmLJPuOF5NLqtLs1o0DSwGi8Y/sC7paJUjzKpPiDgata8WwHu
         KuKS/qig2RHRkdaw/ppXGjJYmiT16y5GYbX/6ZYlRtnT2DQodWs4e2IFVex+HQupWpQd
         LthlSTYq8E548UjbTyNxbTDvbRw1pBtZ4QBvaaSbE3b2gY6slCQyWT8VfxPrher142mU
         Vtco7yirbL273Rr/XambW7rl+9btT2BpVGySAYzA357yVoiMBiClfWdDcoMwEuiLwkfk
         y4DlZtWoxaXkHH5NUxwyR0cdfpIliScvuuUdUrT+EevWLc6wd4504pBAsZ+8CcfBonqL
         5NiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsepUhTmKKGtZlgcS7EN87RgqeBsiXhKEMFYZzZ+IymfMEaUkpAo4g4xMeapCuMfUWIp2D/os=@vger.kernel.org
X-Gm-Message-State: AOJu0YznLSZZ+QdOu0LgBy93fEbDsUMcDcV9ancs0+abgVScd3Es5Onf
	O6/nF/47Ht3xUdF2rRdCQQHJTOXhzqaXx7bdlqus1RLeThIdL8A3DfE=
X-Gm-Gg: ATEYQzww/Byl1bTltrANOBvq8ZeZnGajFi/36GsYfuNXIplOqqxFV+s37ibJa6sui0g
	Bs8rZiHwbtORBTpFn0osri4EExcpbp6DIcgdjeO5ML1xO5f26CB+DfN+TBSijlrNwwoTgI8klS5
	QRANM4v2CVMhd66HoC4hldtq2Cy52XUtapbqO9AC3bR7t1i4uf2FdMdXONZg/n8wSL64AoBNNCW
	ueALU8NnDPzLbrd0Vq8O6+1gcbXvR12HhSL2U0kjGONGQUca57Nv1n2tWvRaivoNoogt49xWdk5
	V997y79NV+hOUNok3MUQ9RfLS+ReBnLhsOSU+h1+mtKHoWjER66djmMGi4I8GMjWLkzlkXf2BVV
	OZDJx0J4IZmuAmcVd3BOS76KPEbuSn/k1X38axR+ByXI+dXWM5PY1UTYBJM7EfUv0rKO/PnBjW9
	OkREhpRT/TFkWgJZ0yQ4vbPopTKyvLamK75HEYmOstpL9YL3Y+dhvYnhGg+KGlSYTQdfbGHhcen
	Q==
X-Received: by 2002:a05:600c:354a:b0:485:49c5:8eb7 with SMTP id 5b1f17b1804b1-4888359205dmr22716615e9.22.1775007164828;
        Tue, 31 Mar 2026 18:32:44 -0700 (PDT)
Received: from [192.168.1.3] (p5b057048.dip0.t-ipconnect.de. [91.5.112.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8a546esm42072455e9.5.2026.03.31.18.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 18:32:44 -0700 (PDT)
Message-ID: <1d66295f-e699-4dd2-9269-aa5ef08c4e03@googlemail.com>
Date: Wed, 1 Apr 2026 03:32:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/175] 6.6.131-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260331161729.779738837@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232641-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:dkim,googlemail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1611837380C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 31.03.2026 um 18:19 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.131 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

