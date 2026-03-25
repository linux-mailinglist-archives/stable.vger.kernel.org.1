Return-Path: <stable+bounces-230314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBxfFjXCw2n6twQAu9opvQ
	(envelope-from <stable+bounces-230314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:08:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAC53238FC
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6955C30360CC
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5723C3453;
	Wed, 25 Mar 2026 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KKZF9oCy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969B53C3C1F
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436243; cv=none; b=KjgUIyYwytelnysJzOkiR+y+S4PQ7b6J8W98uXmxfu17+iI4vWfnolFby4C22cwNW8RD8wtXG0bKZUpS6SvzKLK4hxpAcjFUVAjYIkQjmnLKcSbpvrnXBBVBYY1jhfUfoTVxh6UbrgY3PyEzl5rfC5lF8EL0YfFBe7GN9jrQBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436243; c=relaxed/simple;
	bh=WqTe4lccCcLi5B+w2q8nEzCKnDOVZKdWNH1IipMU0Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvSpYiys2lIy8FYvXJyYKHUffQ8WwFSMbzRecpxiVU5m4nUsbRRulczX+lMNarA9jgGyg1zyWKERlRhk0JqlyCptHrlLnhkH1IbH4TsewVhQivb5M0dnltYFul0KFCJjB96Bns0EjdorLFWxk15U2xL3156SW9zbxpfe/DW5m9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KKZF9oCy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486ff201041so43775655e9.1
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774436240; x=1775041040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IRhla8lcSgdbSyl1JTSSpCu8etB3E5ui7Z8G0hg0f20=;
        b=KKZF9oCy40XjN8j4oxZvQywZjMoe3oc6nLhPQeod/Qt1SP4So5sGwMH/s3Gvzkr5KI
         komfP45hpjeQ/tU8C+qemzLya/+Qf7UIpJopo5ISVUjF4RGaplL9xu8vtjb2sjZQ5dT4
         mBh/WwFSfGfT0roh8bd8oNo9S1cmeYo+PUOZa1dcHT34OF805l+76CDJNCmJYoYfthl/
         Mh7vYYzduY/dx+HrmL4aNmVRKFDJCYQsJunVxiOKrd0dpLOLmfQkn7V+rMFxQmxuCHHq
         2o1gQ0uAvZm2CJZ4Cfg1/sLSwePqaA03O5GwNtCpsbMD1WpKTj6A6CC2hR/RWk2nXY5i
         BKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774436240; x=1775041040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRhla8lcSgdbSyl1JTSSpCu8etB3E5ui7Z8G0hg0f20=;
        b=hhvX3n+gEldfKU+9DwF9SloOJ1ardb9XPJH6V6Zcg1NTc0FxqS/PIUA7T6oxYsa7NF
         yegz++jm47B3/XL1YjK3d3LnCBB+d7o2sypjg86I2tj2EklG7yIe9nPuKbaRaJjcUfTe
         syex0/8lHx8W+pguiJXNnEBGzAFFtmJtSYjVLNr7Sf3MF/cdcTbFPEjlarSa9tVAxzQF
         wZxloZoWDTCB+BGiwVLpmAW5icMHjAGXr9nSxjte1ziL7L0601iYWrURmdn9Dt6t3bO4
         wHBNDbalxtsRdJb5NCBiIDw0qPP6LD9z+c2RCUvfSXCIomqM1hS+5DbJgIJdYvTyp6Z6
         ym1Q==
X-Gm-Message-State: AOJu0YwkxvRQ1lxK191UCfzxvMbZD01zapW/ZVb5fclPVEHx9dsknYql
	yJX4JVXQtaT9Y0x6EtPQjZZYD0Aq0dIUw3/RfWPbPqKr6/uRYhDQLq5CaXe1q9kOPWM=
X-Gm-Gg: ATEYQzyK76g+mQ52JqzMm8tushdXlpvfm2Yo2l1isfgxIWe35gVL7/Z1hgmDiFXcF7F
	+JWcpM7EE8JuhpLgeSi00t8dt0UYjcc7+ca78JGbE4ZFtmYgUp7kiSai75ECNm3AejZkR+qgWr9
	9xMzBJJaiPTf5VaLQ9gAcMj9IaWnPHy/N5ZvAgtoKAWa63bRxwl2EGQg+nkV7HVW7g6UI91PyeN
	WyFB1p2F8hdntNr17R6D/hpxWrtUjmVnq53tCVjQTmjaGrlYyR1IKitbkYEQxmNmqeRBR+xt5F6
	EMTIhLKzBAXodvaQdz4QZDsOBLNAkf2E/5V/zpqTxvie03peagoS9229slq/47YjbPNd9G0tz8y
	5DBZjxGPDA9QHRBVLJZkFmhXDWLGwFk355wbl5PlXTMj/jAVG3UxwiWS0PUeU7uEaiH4+61fKiL
	oGzC3nBtaB3HIeaEaetg==
X-Received: by 2002:a05:600c:c4ab:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-48716039ce7mr46065165e9.21.1774436239828;
        Wed, 25 Mar 2026 03:57:19 -0700 (PDT)
Received: from u94a ([2401:e180:8d68:92ee:b67c:a5bb:13e0:f6f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836955dbsm243644255ad.72.2026.03.25.03.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 03:57:17 -0700 (PDT)
Date: Wed, 25 Mar 2026 18:57:09 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/460] 6.12.78-rc1 review
Message-ID: <6xq6jvbzvpcvp5nnecbaos7xtqv7msz3hqcimcciwciodhxzvk@ylzfje57tloc>
References: <20260323134526.647552166@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230314-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DAC53238FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 02:39:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.78 release.
> There are 460 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/23507388452/job/68418868812

[...]


