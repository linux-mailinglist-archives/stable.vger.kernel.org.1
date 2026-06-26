Return-Path: <stable+bounces-268777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hAXfHsk5PmoPBwkAu9opvQ
	(envelope-from <stable+bounces-268777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 10:35:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B196CB63C
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 10:35:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JJ+W9Ina;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268777-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268777-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B68B30A1205
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 08:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A38A3D6692;
	Fri, 26 Jun 2026 08:30:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11973E51F0
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 08:30:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462640; cv=none; b=li7qHIVhIdzrUEhymN9xadfN7FqZAyqfKFpJb/mXLmaT7sWBCcplV4K46nEA/ZJDH5vSKU4OH4BGfYsp3H/uIk7aqAS6+gKMEJC0eqWhwHdry48RQDoVZ3wq2WmV/dN47uKB9yjIN4DbfoslNGelBlzJbD8wirhE3SmG7SNebG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462640; c=relaxed/simple;
	bh=g7QugsTJVRYqI5KzYuo8WC1k67mQy/4ShxoER+MIinM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=iR+otmwXpmMFh/jvhrTGe5clMMtmpoxYJXW9PzspPpUbEEahHqoOvRTSIZuYUWniSA0NffnKqRSDrOVOVJovLIJhdWRjkhCVrnTPMRExivt88PL/AxIkW4MasvkH5G/6Uqiej+t5FO0R9ImXPJ5swKd3foy0wQClmWwuq01tSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJ+W9Ina; arc=none smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so316816b3a.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 01:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782462638; x=1783067438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7QugsTJVRYqI5KzYuo8WC1k67mQy/4ShxoER+MIinM=;
        b=JJ+W9InanyF4+ehE3ueZas5aO9xyFfQvAgzztfqRVigjl6pPexfVGCF+KWZIkOUzPS
         0Qj9yCi4Hannehfp1/lOv/t6AHZI2dny8ISi0NW/h+G7i6h4/8fgH3OBpr16e+TbdiPl
         I/h0Ya8r66xtugU8m48AemwBw0UhEpWSss5fft6hc2dZV3h2iZIOYJjFh0XGoiMJDf66
         rEHZM4ijSo92Az6PTQ67fmDVCtMpb55xi0BaJi4/Tc8OIv8SF2Ai9fdcCjOeGpFoRrKN
         KaEIndXvsOYSiQgI90tRMb5U4qFa9ANwg0Sed96U1zyJdjahqhTR3L+6RIKRM4Stjcro
         rtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782462638; x=1783067438;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7QugsTJVRYqI5KzYuo8WC1k67mQy/4ShxoER+MIinM=;
        b=WNVEqZ+fuKqF4J/FTYqRpLS5Bj+OjQInnrQPIBXY3TBhuIY5EyhDULutyJayGZ14bp
         ovpR9FdgFPLMPzM6quqJlDaFQd0Siod5oY6xk1s6/pNtDIOa2SPPKk9r2199WZp5+61k
         LhRVlsiCHp5k5l3diRT4nKSERloR08qly8I7Nrm3ZnqfNw2k9Dg9hQUWqNbWGod2TWF+
         EeiLY7gmG7py+kuWJN6O776ZIt5A2toLBa3m+R1Kl8KCwIv6YKtImnqneeJGc5Dm6IJ/
         mVGLXZI9H4KmPxdZblt+gt3cE+bt6tQD12WS/j8rDyXCBjxfNkpeWzNXxNSIQdZzcByX
         iM/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8E/2gzIi6uJio7K0KcS2UmPozn2h2mZ34Mm70dKgiZ3Q2pli9+cPYnyHsAfd0C/rhschJwIHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi+MloErVeTxmekpVYCvmQycGBZ7yvNdhCODlFFzbdg+QLdriZ
	dbtjom2I1nc7ibmTOlKOfH7RtgScbC+DZX0A3VGgRoVGBGD5WwgY/TCy
X-Gm-Gg: AfdE7clDeE75Z3zZYWvMDGtBPQzo3vEKk7RSPnyUTtW6bbOzzArhZPMmhi+MvFvN7Fo
	/ZZdKDrHWJYDTB2T/5u1MFtktQ/Gacg1wmfwqDgPGjnVsbyoWa8CptZTxma6SjBqS4W7ssbL7El
	ymdkPujyxhJN/i2wPYgLAwqM73hH3DqLopURPRajiTL0X6yHv8S3IduT4Ik+62mDDA90182yF/N
	7xJA1tu6f1tvQbS2EZKBf//08kOx/H6b4VzN0a59hF/vqBCjcUiMJ640hXhXIDnxqt9oulBy2bl
	UfHvGybv4D88LkdCr5EusAV7zF8Zzdcg+3DBTJG0PcR4yAZtNfesXZxBVlkD+fhQF3fFoh5xVQ2
	Ny2mVqOznuRkaJVR+GF+wPi9gQq/rH9nHXAcxwsAEMMCXmto+IcNDL2gC+xSgEJosnXo/Rmbk/U
	yQtYhm2Ev7/FXORw==
X-Received: by 2002:a05:6a00:804:b0:82f:72e6:ed4 with SMTP id d2e1a72fcca58-845b382ec89mr7443975b3a.0.1782462638151;
        Fri, 26 Jun 2026 01:30:38 -0700 (PDT)
Received: from [10.31.13.168] ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845c104113esm1660225b3a.57.2026.06.26.01.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 01:30:37 -0700 (PDT)
Message-ID: <c21cd9dc-9bbf-49dd-9812-4db0733b0636@gmail.com>
Date: Fri, 26 Jun 2026 16:30:26 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: carlos.song@oss.nxp.com
Cc: andi.shyti@kernel.org, biwen.li@nxp.com, festevam@gmail.com,
 frank.li@nxp.com, frank.li@oss.nxp.com, imx@lists.linux.dev,
 kernel@pengutronix.de, liem16213@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, o.rempel@pengutronix.de,
 s.hauer@pengutronix.de, stable@vger.kernel.org, wsa@kernel.org
References: <AM0PR04MB6802B863CD9B9AE1609C1785E8EB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Subject: RE: [PATCH v3 1/2] i2c: imx: Clear slave pointer on registration
 error
Content-Language: en-US
From: liem <liem16213@gmail.com>
In-Reply-To: <AM0PR04MB6802B863CD9B9AE1609C1785E8EB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,oss.nxp.com,lists.linux.dev,pengutronix.de,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268777-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:carlos.song@oss.nxp.com,m:andi.shyti@kernel.org,m:biwen.li@nxp.com,m:festevam@gmail.com,m:frank.li@nxp.com,m:frank.li@oss.nxp.com,m:imx@lists.linux.dev,m:kernel@pengutronix.de,m:liem16213@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:o.rempel@pengutronix.de,m:s.hauer@pengutronix.de,m:stable@vger.kernel.org,m:wsa@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[liem16213@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liem16213@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4B196CB63C

Hi, carlos!

Thanks for the review.
This is a good idea; this is a better way to fix it.
I'll fix Patch 1 as suggested and send a v4.

Regards,

Liem

