Return-Path: <stable+bounces-240012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBKlMrmo5mm6zQEAu9opvQ
	(envelope-from <stable+bounces-240012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 00:29:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF39434AC7
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 00:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F12293017251
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C462E3CEBB0;
	Mon, 20 Apr 2026 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LFnh9HOs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7338C2AE
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776724099; cv=none; b=qNjlg399P8k6Of4ikRz/D9D+DnoKqqmj6mJmAu+txqMRW8QCXGehFpHxCW7e6LC/8dI5ms9GJgHYDPNIoXO2ao3+jFtWydIh6filuVGr4Cg/pqIcJUjqrKiNx/aqQpsMSNLScotg91eRKJJPog1m7OROII1LBiW2dN9onxnd0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776724099; c=relaxed/simple;
	bh=Y4YMuNNoa9Uygdftkc3JH9QZ7Ollj+02oDbV94H/Bm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pThMxasux7iZCyRMPmdXhMi1TnVwLFcuezVJprJMJ1jpgqXSyXMZijogpEkO7aFsT4BUtvRUDNVnug8tkpqw2yKQluiGLR3DAdYeaQXb36sVsbkN21yqt6cGZ1TQgP0eaYPGc1yS96B7SEqRDhOfKlt9DsToiGtnE5FfXOKRr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LFnh9HOs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ba840146so33896655e9.1
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1776724097; x=1777328897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZmV+HcxuyG4/pRdYh0mLaOwEFFthOCszYDR45QrDAc=;
        b=LFnh9HOsjTzWzIMlPtG7H7nf3bJ43dV+MtBHCYo5uCfQ4QGlmWgjxSFbVM0XEN4i1Q
         qzw5b+FwOHDZVYLAD/7//0IaWk7wX0DnUgXdjQHdqzt9iyHSyumaLPwhrvacf3l+QU8C
         pWeh/anXPbo+AAc//pvadtzD4AlQQ1HGwrl7b/f2Np9Wj3ECIpae/ZAL/ICcim/ryirs
         zbJoBpaxv0Si7VHuILGlcPZVFNVvVACt+N3N5r5uD7VtZ7SQWltili1nnrCZSgA57pSj
         VYIdswYbK4tTJHHC/TX3n7mZuJP0tyiWT+uvawv13+PnAnxQkwYNZ7+obJ8EJlLv8mZM
         mEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776724097; x=1777328897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZmV+HcxuyG4/pRdYh0mLaOwEFFthOCszYDR45QrDAc=;
        b=nf5mCN0BCv5OKtL3tMZf0FTPLk8cBEDU/WmUQXwipuZvJy3FkKdtP72+8hDOoIyhM1
         jNBelpIYDG40PqAko2IFu9gTnms9vTZad+x6htsTUsAafdhFX2bB0Y05XtnmOnf1fTHY
         bJHG3gbUGUpeMFGNpvxkOLazEV5vYq6Vv3oV518nT9J/EKa0NZgeWrohPnNI0G1RpYKc
         SEcYEd8D8bZzUgj/EmFlR2D2Kr1KUHmSEeBplSOcvAVbQY6ob/p92eX1ZGbgHIEobDlJ
         w1j/IGkbZOF8EVHYQ/Rer5KEBD/3Exqj2oR+7Iy9W8CKtMd/X4ACQYzPyLFfnGkFVnxS
         SWmg==
X-Forwarded-Encrypted: i=1; AFNElJ/Eqy0QsaxacBLZZVyzj93Kw3xJTaNce1rMY9CYmC/tdKKGzq4pPZGcqfa9cUgMwqrUWl/HSoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH2B9mTiof33LXAiFCd2gbscWSZtXqnpXdY7gDJdowX1GvMN8R
	4ogv4bl4TP9g9Dkw4tUUur6x0k6y8ifV74isKDQTwToY1pjtTirn2yKQVMSH
X-Gm-Gg: AeBDiesFHro8Ol2lUGLVo3pb+bU5eUvKQtnvj19NDeCFAd/EQu3BO0uoQWQcO52dCTM
	eH5vdcL5fx4PHH6/3d5V054WGIuckE3mXYpUlgKj/0QiBcJdwbiBYQXxNduFHx2ACJWPMwVDmTx
	E5lR5EaWys9A+q9dxjzUyAz0M1gCkvsfhEv3/vjKS/ZXFT2hvMhkvRkuLQHgb55o8GHuWYYg6Bp
	7/rec6XilQ0YQzZ1ikvdkJZoUOeXIbXi1lpQ6EZlkbd0NUjG/DDswERL/+nwc1LDuuMSmWO0uKn
	4P0vkNaQl0Iv1A4HLplYPV5n21V3BvKbYFRvl25dBizKgBIBtbra1BJ4TvP9ig/3+/7EAtxvH8c
	EfSycYy719JdGiLsi6hPvLdUfXfTUTcoglKURBu+p3UF3W1cfpkUNUPVbhGJ4ciELIJNrTOg3TL
	mOTNc041jGFcteLqsWc3i8HuJgsmU/uxs3khk9auNyMV0xCxLPR5Z5Iax3mABWXDgG0T+omYg1Q
	akh0eCp/O/O1bRhgJgPBqJW
X-Received: by 2002:a05:600c:3110:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-488fb739ce4mr221465225e9.4.1776724096512;
        Mon, 20 Apr 2026 15:28:16 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b42df.dip0.t-ipconnect.de. [91.43.66.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7ac6aasm100393485e9.25.2026.04.20.15.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 15:28:16 -0700 (PDT)
Message-ID: <a752c292-2662-45e4-a669-0c5bd46b5b53@googlemail.com>
Date: Tue, 21 Apr 2026 00:28:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.0 00/76] 7.0.1-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260420153910.810034134@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240012-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailvelope.com:url,peters-netzplatz.de:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BF39434AC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 20.04.2026 um 17:41 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.0.1 release.
> There are 76 patches in this series, all will be posted as a response
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

