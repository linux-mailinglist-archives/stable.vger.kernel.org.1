Return-Path: <stable+bounces-227114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDpjCbTeumk3cwIAu9opvQ
	(envelope-from <stable+bounces-227114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:19:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D742C0202
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 18:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80D1D321A8B0
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037703ED126;
	Wed, 18 Mar 2026 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DoWh41do"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C233D47AF
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850147; cv=none; b=nclPX7xE4Dvg9/sXH8dpYFxgU2GC6kGwQuJtyFjV5+3AO1kJDAHgE89WJdBlmEazEroUz3kdK3LQog1TGcjFaJCnL4uEM4kIKCv7t42Y9M0leLRf3h81zNmQ9akHEd+mjUEHkJQOexnn6L6Bekqsq93sTh2JnhB9Xu92PGgNCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850147; c=relaxed/simple;
	bh=/N+HEmmGQ9Y8SRoaz/nCRv885xmedvQjf6E1V2h0t5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpxasZAzm2huuMXl+mp4035tpyKNGNq/sIflmflRbcAh8/eWmcCBL8UwaPsX5UFnh5yNMRCVxlmh4DSWEyCRY70Gc+dVDPBZkMj+FrkOwqg0rzSKF9BvpVx8RA4s4OvIbhSvwIOD7GECzQCITmQ6z9ro2G0e77eglar8KH1qO20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DoWh41do; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486507134e4so297085e9.0
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773850140; x=1774454940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbR2ZzJNU+JH65EVsLNt09FXk29aaNppPBnJd/tU8sM=;
        b=DoWh41do0I1dsijuAVgpnan/JftFTq+wlY7Vqcow9U8E1NYT0JwS1jOn5gBQnin8oh
         lcebMgurPEXnDPYckyE+rP5pFk9+0zWVLaHb91faHP/yqutjFBB5NE83kd0BpAPn9GZ7
         2OulFfFxLdWg0lEFZuSGBsTdlCb2GHSG++Upwqze04M+v+HeAXF+u4tHGL1i1eTRozuH
         68h8oFCjBN/27AHo7jOlkz4xT9HW9Ugte748yv26MfpwMy2rxs34Xc00KJ/JGcw7fyc7
         ZuacD878kOwZuN86cqfLqlsQW40FWGkc561vpImK1vPrd+q16j4seZof0DfoZYTh9Ds1
         vWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773850140; x=1774454940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbR2ZzJNU+JH65EVsLNt09FXk29aaNppPBnJd/tU8sM=;
        b=j1o0nGwqs3pU6xUiFHTVcCuijQtpANeaxKdlNGkYF0IYQQbe3K3RgclX9Q1CHATZnj
         s9Gd74DOJniMLXred6RstdUSdUwpV8TM/0/84VXnatHeYpDzxUDWrUVr24oELagF+NL6
         1YxtGpf/xNN1TtFDODcvRwL7ghy8yiErZY8jgqoi64SSYqI8Aqv60boS9RYuuX7457FM
         HnzGWwrmraQAaN38RwBlv91oW2OFdu1SXI2F11KWwjCZxh1zAdvCREqh4x7gHvFSp2Ki
         743d1fQ8Ptnk6hZXXstkQyn+JKBBSZegFpwz79THBPfBxwKRuwM4g7Z7hS6KR/J0W3vk
         76/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzGRfi0su4NXkkUt6s5k9DWTfhnnMG9PEOS8RoXY4xfHaLDzTPA5cWKoWzmp1tDIin+hJoyr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ11kkf3E7X31aQzZspFKeLmd8gJWEyu9/n++56bVDy/PGRuou
	yuvZVTLK3hRrbDwrQ/5iNRVO9tznLItaArjxL6Jsqcp1OfqVgRYq/Qk=
X-Gm-Gg: ATEYQzzQV+M6q60/6qpoXKue6ARkJzsLMGG33CUtlcq6XHRtUzdangY/sf9f7rIuzg+
	S3p7AeFKqUoU0s0XPdfwSrHq9pSQzP3kwJvRrPDbGHhefk/6yItF2XejEyUI3CqaC2q03ecIlJT
	BB5AXM0btfo6z3d5b7TPsShFgc/mSuDstmGuXX9sFkGqBlm9ycl5/l3DmO8u3vVhB8kdr13dJC/
	NL/7tvb09NMa/3ijJUZUo428bN9JFIVL9Ur1HS6Z/K4/RCe9W3wajHe5MTHz2jfMaGAi41FbZJq
	329XVwp8FMeIjZ1LBfX0QjM2DzQ7r/yARDvr7ce8BCjZyNVjs2QQ38PvA3TD7LZ7urdS2Sbd+Ft
	72SHE+c4SYsbSI9IjhLMJB3bqjgA8pw2knr+9Jy5Tf0z4NpDBiebfHHic25rAPmLLn2Xz85XaXR
	mLt42ZBU9hMQgkp4RkXu7WaZoDYu5/D45QEqyjTEmAt0D1W+CN0anLPg2IooIH5iCDROstoxnkA
	W0=
X-Received: by 2002:a05:600c:4ed4:b0:485:3c2d:d02b with SMTP id 5b1f17b1804b1-486f4444050mr68947905e9.22.1773850139665;
        Wed, 18 Mar 2026 09:08:59 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ace2a.dip0.t-ipconnect.de. [91.42.206.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c53153sm514625e9.13.2026.03.18.09.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 09:08:59 -0700 (PDT)
Message-ID: <525a66a6-2dd9-4092-8ac0-c6d569ae4e83@googlemail.com>
Date: Wed, 18 Mar 2026 17:08:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/335] 6.18.19-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260318122621.714862892@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260318122621.714862892@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227114-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_SPAM(0.00)[0.201];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: 84D742C0202
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 18.03.2026 um 13:27 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.19 release.
> There are 335 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

RC2 now builds without error, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities 
or regressions found.

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

