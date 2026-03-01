Return-Path: <stable+bounces-222462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBRECx47pGlnawUAu9opvQ
	(envelope-from <stable+bounces-222462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 14:11:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A2B1CFC7F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 14:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F264A3014C4B
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 13:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD932470F;
	Sun,  1 Mar 2026 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yKgm3ITo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C9317171
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370711; cv=none; b=u922dlMiHnYWAZC+8FJ4jwxvSmmyXhDKJzeXF58MRbJJRBgYToosD7AADA4pmqF9U1PgoEtBoe3m1opxuBExFgO8W2/VO9KPmzjzEJpihUcflEXX+L32K6b+pvKE9NyROTdlqtCPbKCu8cGweqiQZv+O4h6SVPKVn5e8IkBQC3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370711; c=relaxed/simple;
	bh=gNPl+CytbDfcTGcrtIVKvy+8SaLX+/Viq3b8/m4t5Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjgs2pAwgo1q7AhyygVeI/RaT6lITbL8F5B/M8FSMf3i18//oww6UFpZRF1gCkYJ3W67GnscApHseBrAzm+SmUvxafyFpiEhTb01G5s4GTfkp66uMzKmjOAV3oDqU4xTCHnIJeniVvab2UEPNeFJTdfwnLbAB0OWqTx5twcpPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yKgm3ITo; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4be94eeacso3742861a34.2
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 05:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772370708; x=1772975508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBnlKavVO/IBWG8rXXLbV/3NfGhe2CzEeysb+jALimo=;
        b=yKgm3IToDM+O1nI+RKSeOoSGtmSGbUAcypvd33HCLKKSdcIAs7ozLeCi+m/WXNQGX4
         vynyYFkJPp+LhbA8gkfRFQghdwwQiTnsf6pOEIyhLEtfxSb4J307mF00/2GgO4DOlbY2
         3Ah1y3aznvHf6oDKv1qzT7+SY0FtqO/1e5QuHgO47u5oEk/oQrYuKJz4FclR3u/kFsQJ
         tKBz0GrIb2cv/rcgdff3waQ7UBVvbTX0wQ558RvEVsBKUYm1HSS4n9sFSUJYS0tPuZdU
         m4ekmzN5PvLvf5Ja1ku9G9T51tnBmDPDeBPZ6hdxwsEQoOuUpsy45mmNw5KBieBSSC3c
         RAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772370708; x=1772975508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBnlKavVO/IBWG8rXXLbV/3NfGhe2CzEeysb+jALimo=;
        b=V1Ogdq6Kw7MZiy7Jm8Y1kyRiAdyenhi2rSjngHWDwinK5Hwun7QkWZsihomFQPWAz9
         mS8/A/+X5Amzk7QAlPswwTc5/IWBTH3OL/5Qz84s1nMeWLFxd0ATZq39mdgy/+wgQNj8
         xUGj5aRZVjLj9R5LU/kXJEOR2fuq33cRLIAuCU9GwUvV3eVAWmnmrftmvGQibX308Vd1
         XUvxKWk11Zmh2U6R9j4nEvQ/27r9DrSr4VnlnVPoDfcvTFESZCb+jpaD/A6G3sRHxYSR
         5uAFIxMfDq6zyPn6KAUZ7nRfonjA4oxvPAsfPuU0/XszQJx8l1+aOd34io5BI7hVCgFB
         g9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnRi3rXe4rFAKa+x7A7ujb7/EYJNUQmmdMT6djo8dHw5ZcwNar6ou+BLNSOCjXME2gVtQOXD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQvJpEzzy1zq2KVovt3widxz902Idg2YucGgJ2kJ9s7maQkdjg
	8M427tmigSAB/0hoWoOD/3ph5VzuL5wxDbrtHL+TDMd+41/4MN3NhFDZXoKbkRmYVBQ=
X-Gm-Gg: ATEYQzw/CqWOYiaxjiTtUlrslzJDsJ1IkMYZAskhJ5zzH32HO0pXNUJntwNONEvtKpF
	ZnNDq6xkr6L1ROIk66RB/jlwTFXTglZbr1TgKmRpuImDrQGYJh0JFsgaAgFWvo/P5VSV3fox9zl
	yHT9ymJaxVJy3JDJhrmoXUi+WG6ghtYWJ6f5AQekYT/YM3xsdsayTb1HEdYOZuKtFdwWdwrzdEG
	LEr+U4ZRrCnyNA0UUlvg0vp+dGmGA2M8Q3UK85CXHoERaqs+yE/+Gzu7dCz3RkvTEwRe5zf4QUT
	FvnbVPijTywJju4v20N9aaz1E9jKi82Hmyy8pT4DUE01UDOt4xzOYqNaKguaS+iGBFB5edIyact
	9O7qVDK31rhZhCgwI5G5b+TTRolYf3C4/0yY9XW35H3nP0nsOYzBbVAhx7W9N9II/iGzbjdI+Kp
	hHIM67K7Dn4e0jEZL1RwYMfCQ7VS8n4X0A2lJp9/rU4KlcKtZTdZRvu67jgerd3niynCQSv7fDk
	zioh8s3xg==
X-Received: by 2002:a05:6830:828b:b0:7d5:1101:91b9 with SMTP id 46e09a7af769-7d591b1b8b5mr4875661a34.2.1772370707983;
        Sun, 01 Mar 2026 05:11:47 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5998bc31asm4541150a34.23.2026.03.01.05.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 05:11:47 -0800 (PST)
Message-ID: <39cb425d-f456-4278-b868-591a76fc87c9@kernel.dk>
Date: Sun, 1 Mar 2026 06:11:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "io_uring/net: don't continue send bundle if poll
 was required for retry" failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: io-uring@vger.kernel.org
References: <20260301012409.1680931-1-sashal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260301012409.1680931-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-222462-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7A2B1CFC7F
X-Rspamd-Action: no action

On 2/28/26 6:24 PM, Sasha Levin wrote:
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This picks cleanly... I think there's something wrong on your end.

-- 
Jens Axboe


