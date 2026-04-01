Return-Path: <stable+bounces-232672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGRWAeWSzGmbUAYAu9opvQ
	(envelope-from <stable+bounces-232672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:37:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5647D3746EB
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9BBB30D4419
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 03:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C0937E2FC;
	Wed,  1 Apr 2026 03:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WbqopmXS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C384F37CD4E
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 03:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014304; cv=none; b=WEqxRccpXjVTIoiz6NsrEnbpbTM+h8HWD8rkVJkhuPwQYfdq70xZ7XWNynl3h9fBpqNw3vxCe3uZXEAHw8rwHlaeNm6D2OyJx3jDiNBfl8OpAJJw4kDpRYgy5NYHG5BfsQ2scKDLT5AeAwC8kGNCYy1pNVvrlYQdR16XFIlSfWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014304; c=relaxed/simple;
	bh=nO14oiQt2F/NU607cPayKjljDeYFrCw3R76LgRqCxP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fycUwmaiVABXeVzYCxmMaI7zHI+9EIrbMBBhEL/OTzgZMwZPWyiikF3FbHLfCvOSNQWf61wPskJExAY/G6G7BEutxiqpll7zhMpmJ2VawieP5RC0PlEy4ttZwPGUX0fU5vAPUF3Nu4xBwNzRNcFddWs/qP5KZ5bXarZFvUjm6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WbqopmXS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486b9675d36so52443845e9.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 20:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1775014301; x=1775619101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omVmBIJbukSL85weewQTvjHzY8THepsy7QTLnDVM4Dg=;
        b=WbqopmXScPffiI/s9uyA2mulVWfEcxJFuJpnypvtevkgP4IjyQZPUJxMLUE0vrasO1
         uCacmHZWTdhJjtLXPJw6K9KQ2SkSjz5yFs8wcO0K7u0vcwdh4SiTW/xg7Nsz3IubTwCy
         enda+F5JTQhHwV3KavdTZXEe0fFGtXIFqpSh23Gk00ewq9VZAYcJT7qcwS7eHvgoixPv
         iwMukzuI/StfltFpnNqgfpoZKLxoODpDdIYqWRFcUn/EZxJn1hbiroqDjGj8Cd5KR2Ze
         ORyyOhkeR1Pf1LD0BDqTfx4Tg+XY9M1ZcC5d7TrBqiqNQ3jVkmOzeuSg129m/gjgoRcH
         W00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775014301; x=1775619101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omVmBIJbukSL85weewQTvjHzY8THepsy7QTLnDVM4Dg=;
        b=GlvlCPNQh2FWhlZWI5TdDwFaTv47gGxt47/BVfoRsgdMo+xYf7SwQr1XBYZA/Gnabl
         un+WiS0G/BUGZBiSw73uXUNhZD/kzZYgQttqzbTFHSKEsDmpBmo45r9Ml3FklVTJ8HxX
         bEcD7Xsd+ybQ07kGOH3CyFT+NPf1gTXs/tLToc4b8IKyaKx0bhD088TBGS9ggzQl1QR+
         ktkvunPArWk5eiI7k8DoMpuWbae89IRDZcepm2P8VgbgMQXqWnfzLCczIhR1Karl23oh
         m2XZo/38UHka4mzKCcKDz7Rc7eFaqHky8jkD6IhS5XV9VuzEGScr8ERRhWUjSrbPBMA8
         MpSg==
X-Forwarded-Encrypted: i=1; AJvYcCV4o/VtWjmmAwMlMeIG2TuLK+5LfXwBOboYpwb0YNcmtzx7njmaircqOFrYxpS9w/BSfyruopQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH0nMVqibBPZyNOYw3MzYNfUrfwoJN29h4yviyiwSFgtQhzi8a
	pnVKnUfOnBFdA013h1Oo0lKL19hXnI0A3hUJBC83YpCAK7T6rUVN7Hk=
X-Gm-Gg: ATEYQzxDVnOc3/CkTdnZ3LHWj7xVe6wG3WnCxi0vviGYtZ6vOFqG7OUdGvhF7RNjux7
	0zvDyqQcm5OK3m4rXpfRJxhhmeApTIA1affMQLgiZX4tARD2aJdeG0iUUAdooYH+Hx59VSUNaHk
	r2WtM547dd5kN+hExHAcHvlKFyky0NGOwCrVPaeirh+Ntj+8EsDR6SLuFMDuomizsoo548xn78e
	VLweEL0BzRo2PqgOOs03wC/8aO8tzOs8VpOPR1OCyFfEAuJS6dqIbENuX0RD6v7rEomkhgVZfp3
	hWnqElpbsHvRij1ejeurc6+F5tis7awunwidkHup00ctKR5VRdUW//X8eDJa1cRwbdHNPzrOhCe
	cCCWDHYsU34ipryUy+7W7fetqQ3t1iDKY0xWos4dzuqHrn7Glp/fhpD7VcEiTaE3ONb4sRraGfO
	sOkUyOkWUcsq7ss1vZhUfy0jGxC/UQWsqT/KvMLJSn5dLqKrVDQyt0Vii8cj2EcztefcPjIJGAg
	Q==
X-Received: by 2002:a05:600c:818f:b0:485:4bd1:4c64 with SMTP id 5b1f17b1804b1-48883596fa0mr28458315e9.31.1775014300712;
        Tue, 31 Mar 2026 20:31:40 -0700 (PDT)
Received: from [192.168.1.3] (p5b057048.dip0.t-ipconnect.de. [91.5.112.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a630922sm115480355e9.0.2026.03.31.20.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 20:31:40 -0700 (PDT)
Message-ID: <c71fbbc2-10ca-4865-b5c7-f17cbfe4044f@googlemail.com>
Date: Wed, 1 Apr 2026 05:31:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/244] 6.12.80-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260331161741.651718120@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232672-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url,mailvelope.com:url]
X-Rspamd-Queue-Id: 5647D3746EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 31.03.2026 um 18:19 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.80 release.
> There are 244 patches in this series, all will be posted as a response
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

