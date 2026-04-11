Return-Path: <stable+bounces-235680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOOWMNGj2Wm9rggAu9opvQ
	(envelope-from <stable+bounces-235680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 03:28:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BDF3DDDC7
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 03:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D42DC3033F8F
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 01:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC221ADCB;
	Sat, 11 Apr 2026 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbFyfsAp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC81F419A
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 01:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775870910; cv=none; b=eBBPJ0iRUMqeOnO1EZlIwTfm2Yi1MUrLTIcVE3Yh6SDSirYjz2Ol+hT+0yaHqwZmFMTRqi7DZgqfEg4LEcRKtZvbqOSGu5rw71vZY1ixKU0VM5hRFkRWqFzSpp8ka4koYrQnjx9Y6qd6Rw+48HfvWf8ZLy2jaHoceT3dWCW47XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775870910; c=relaxed/simple;
	bh=QBESViLoUMaOvRo3YjwM21rRh/6OI+lAc8gz6A9NrgY=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Wp7mGHtgRSMM4GbxzxJJk85W3/0kwnFhb2FuM/m5Rvf6ltpZlYCjU5GJgd+gqJ1sieE5ChB06yvuNW+vhRxS1neF+QyUBXVk6jUfEp9zxaCmq4/sUd0rWEc5H0EG5BG77siivyUC1PU+Ulf6OKsX59tYmmHisas0gPWXM4pwEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbFyfsAp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfd96354aso1598042f8f.1
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 18:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775870907; x=1776475707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBESViLoUMaOvRo3YjwM21rRh/6OI+lAc8gz6A9NrgY=;
        b=VbFyfsApJchq1m12IqaBm8K9hcSFia3h+2cVTOnJ/DLNy/b1wUXMrYSgznclGFgolp
         WN0Bz7Epb+G8ZzwcLf/0yDumN4ssPU2kvzq5kRIePOeD0QyYAX2kcPrD27kNuq8n92zO
         iCakwvsa1uH3yCb6w1k7JZ53/1+85ABr32dHH88NdeBQeHfAuD1EzNvVU8xtIzd34PiF
         KMl6bVcFjpndKXcCXFOJ/KQzDvWaGAMsRun/1G6BYhunhcDgG095CyH1KayRgkS1fdVR
         V2Cy0Eo0umhiMOQS09MDSwdcBueawSYeGAu8P3cVQ/VZ5TOVWLkW72vyDiOCP1Hy2Exc
         xJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775870907; x=1776475707;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBESViLoUMaOvRo3YjwM21rRh/6OI+lAc8gz6A9NrgY=;
        b=qg+l4VSvel6Jnhb78G8ajisn7CKOaHml9BgGznrmG3CBj56EpnfB8ybNnPpek9kv3U
         BpNcJKMxU6RWbCJuINWO3bHs5KoKRZ0I9oN9yMp/cHRhv3TVWdwRHNiZFByjTDpv60q2
         QHNStsUDxOG/LQXOaWzv8neC1sGz/lU2FjfsyFJvEuzjhAryk5bVIqyluQeNVhKM6TIf
         VSPmMbwMj1uKRDdKNxCxQDC3j08pbfr/DsLzcLZX82Xhwfc9jS1gwZcJFTX0/rkj71kF
         zq1PWqAgrcx516UEQFn3zm0JgkbrWYUKkstL4E4kVksKYxRmO5a7ROnEC8CHvRsj4GON
         xIcw==
X-Forwarded-Encrypted: i=1; AJvYcCVb0tUS0Akl8a0yIEJUlEhGiq9V5V5gs46YUaE4IlTZCuV+F0OOEc3P3dTEQkIh0LKpvFf1CzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFnsnb6PKmrjf7hPDq8yHRZSjdO56IWs0HKTbQ+18/pXYWosx
	2JLdcCKuJOMx9YqHEeSeFDRYzKoiTpHIPu1KN4KmkkkGt4M8gHD92hYK
X-Gm-Gg: AeBDiesiTYrJBOmOM0w0fKRh+3Qr5Ei4pXzZibRDhiPUfIltF+/DE0u07Ixlll2eGPY
	JqEh79ex9Ysoq7qsQ27NoYv8nztyjqu1O1iFHWHchiAJdx1i1bqPuA4g0vypoD7iXmycmHPzb5c
	npkN8epD65mKM2hi7loxHrnDMXO+2TvSvcODbCjTr5HGuuNEqaygJ511x+ifBVgMp2YWbrek4X9
	DQECHGhKoG3c5L1UB87fHxiR6AR1MDXcFR0qiUwZNlT13K+Qy5jV08ubQqKEWP+nBLV712pxZbH
	Q9sIlsu68qcuyOPyPZ/WHunWm5C+54qnTTx09oMKX66pgDfXhnuQuKIOqLzdKQuV2XPULXTL59P
	GzvWt9TfoXZbUo7EDT62bakWJf7vQkBGh4AcdTpKP5Ie+v1SqBVsPfd/AvkqqQLOQEMuM55E2g2
	3CRBmP+/4Ec8Mw5uVm5Pf9ENZ5mQDSP2dvJhGQTreO7Rxc7NbdPGM=
X-Received: by 2002:a05:6000:2211:b0:43d:2fc7:4816 with SMTP id ffacd0b85a97d-43d641e7d3cmr7775174f8f.0.1775870907203;
        Fri, 10 Apr 2026 18:28:27 -0700 (PDT)
Received: from ehlo.thunderbird.net ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e468c5sm12268373f8f.20.2026.04.10.18.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 18:28:26 -0700 (PDT)
Date: Sat, 11 Apr 2026 02:28:26 +0100
From: Josh Law <joshlaw48@gmail.com>
To: barryn@pobox.com
CC: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, gregkh@linuxfoundation.org,
 hargar@microsoft.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org,
 patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de,
 shuah@kernel.org, sr@sladewatkins.com, stable@vger.kernel.org,
 sudipm.mukherjee@gmail.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 6.1 000/312] 6.1.168-rc1 review
In-Reply-To: <be550d5f-a5bc-4cab-aa75-1c7481ba39c8@pobox.com>
Message-ID: <6F70FC25-AE09-4A97-9798-D1CE49239B00@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,linuxfoundation.org,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-235680-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshlaw48@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45BDF3DDDC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

(Compiled and booted on Geobook 1E without any dmesg oddities)

Tested-by: Josh Law <joshlaw48@gmail.com>

