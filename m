Return-Path: <stable+bounces-229983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDqfGzx7wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:41:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C29D2FA336
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EC53301A9E1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FD53C8701;
	Mon, 23 Mar 2026 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cTGo5fNU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D493C7DFA
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774286869; cv=none; b=FDQCxjvAlCPQ2x+Y+cQdhGGul21jsSEIx36NKX8doBH1infB7UGm44e2ijQ5kwlV/qnhHTsdsg7ywN78VJ+flI/Jpvs/LgNYaspRwQjQ4aI//FCcZlBQLl/HW1jgIFAxViRLcv8loXrPE/oGp/6QYu66DOFyapGtJtT2BataOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774286869; c=relaxed/simple;
	bh=2FNIH37roEjwP8dn0JRZR7mE1v4axVzwU7scBVjXiXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOLSaM47rVpXb6/q0d/o9+bKBiEZ938jmYaIaWe182jw3hSfXFu6kRaVyZLBv2RadKsPozqMdXFR4MpzKlAtU+cCv4oOduQMqXqdYWM/r+9ZqNXMOFBTS/ShlQEFrZsMEpdy6RkplHMzYcn8ohDju+L0OrvoxIVWg6912OlsaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cTGo5fNU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so3297384f8f.3
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1774286866; x=1774891666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+BBiFenQ7EEIN1irT/UYc2jb5/+zKTJdZZ71A2NrC3I=;
        b=cTGo5fNUqSJVV0o0/p3rVhDbBBxo5j8Ffz0N3wDVskzAouq8p+ZsctI2qGSrXi3Gxb
         JYxG4M7T2bOEqdaFrFKhcVJesWmlMGOF+OSVzC9QC6yevgcAY87frWjekYCmAfpNtGYP
         TV2P+No2e1M3jx2pOL5LkIPXoiseFpu38nPktJRIQjswensFnlVcWst1zVb4GX2Sk89u
         b/0dnReZXgG/tk2Wb+DyobBykg5is47TD8VuLUdfDOfavS5q14bU+Bc3xy1Bu+F/y9W9
         XbZadVmDEnCmaqmaL6jFJn3aCk/mmmX7ssboPod3rsKUqL8AbXPfpWydtrXnl6LXl9Jx
         Rxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774286866; x=1774891666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BBiFenQ7EEIN1irT/UYc2jb5/+zKTJdZZ71A2NrC3I=;
        b=ZfETRWWfSmDfuNIgZaEZzCT0t9V4zLcxdV1PQO5Q8KuUjnhwaeSS54J59P36phJBFZ
         20Qf6V5C8o2m+iAfy8tAsb5dafSyjrEKowbP6/PksMn0tuiL42F9xdAIRBwo1GVJKdlT
         gXJ2TxJq64YrMuprBeYOdc1/RaOBelKCjx6RY4P6cRrrs7rG8vmMrYOEtSu0TAiEnajj
         6BiIy8n1sCBJ87p5gL6rfdBQodepIaBvMCHOdSMaBhZq8HtYpAb8HQ5AETxnyfvso4cP
         oOxS5xdpc4FPDsDqwIQ/KrpgNSqgUwCueQZuS4nk8fZBGBFfO9AFbjqGOCNgASZAQv+a
         +IEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxkob4t7vnkjgfM9uILZ++6lxJTtUGTHCiO36KBDpprgzg7B4XaG5c45MZ+CT5Sgvk6m8k7SA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy86rtaq8KDi3lqRJViNcE2KRvipcbYxgyj0w7TkR4hqn7HXOIi
	d0jCMMwkfkJ/lg1KYusCwGN//2KXCnkditmMFUGWsd5SRDOlQT8geuA=
X-Gm-Gg: ATEYQzzm2v+GwDftDtLU0kUaqJCqPHP6uaU7sYwxYxt5gHj9p5qFz3P6SArkC8WQyp8
	tZYLz40iy/KcbOYXAC05xRNCdfMetU++fXFg08ypvzpXM58RWB1UNLshIQ+jOijPDbYVigDElSV
	cA+vh6uebUMRcHQw5hXBrq+qnGDiQNx4ZHqLMhTINTmkjac7KfF7PGOKtPd6e8HaVWvWl5BRzhg
	GuvFlIQDCiZULEzq4u3aW4XnKef2ZxS/UWVmSgi2w0+XjNH12YQE8X5eEhZR4r0+Lv7/4xm6PTh
	TTXXfoH9bdFoFMmsLsD0v3Z4P7o6rSggxbV74UOuzhcGzyiMdGM8jLapV9ESpNj2LPuWJZn0V5n
	OZGL3UZj19xOuHmqkcpnS5YtUJ2D6EVk0v+xtbu0j/wHfEunRGr45WiCwQ/1FjGnxfa7lfBvQJn
	wgxO8N2Q/Ifun0MP0b/+ccwikFTEsYzY0kl3aQFMh6/tJyyU6halEd0+mYsuzOODUaMw67Vfd+j
	I1oKMnR8Rs7
X-Received: by 2002:a5d:5f86:0:b0:439:936b:bff4 with SMTP id ffacd0b85a97d-43b642824c1mr21258835f8f.46.1774286865928;
        Mon, 23 Mar 2026 10:27:45 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b444d.dip0.t-ipconnect.de. [91.43.68.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b646b0d3dsm29358657f8f.16.2026.03.23.10.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 10:27:45 -0700 (PDT)
Message-ID: <900133d6-08f5-4272-b5a4-cfc69909ce55@googlemail.com>
Date: Mon, 23 Mar 2026 18:27:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/567] 6.6.130-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260323134533.749096647@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229983-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url,mailvelope.com:url]
X-Rspamd-Queue-Id: 0C29D2FA336
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 23.03.2026 um 14:38 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.130 release.
> There are 567 patches in this series, all will be posted as a response
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

