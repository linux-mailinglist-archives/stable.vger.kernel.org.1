Return-Path: <stable+bounces-217309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKMdDOvqlWkXWgIAu9opvQ
	(envelope-from <stable+bounces-217309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 17:38:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E034157C9F
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 17:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 561673013861
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A76C33D6E2;
	Wed, 18 Feb 2026 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCcnEjBI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B2301472
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432679; cv=none; b=KzfZF59XyiEXtj7B8dicGl4XCSxqsiW6JZzjoGBo05lj3ezogJ9RY6O+dCV/dYMEE83qbDSAzsJt9mRRer8nj2iZX+N13UdEyWEVDyN2y8Ss/mAmehwZ+ttd/W2db62FyLFvoEfhnz8uEgJCG+LavTdaL2cw3vdIc9lYujpkRHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432679; c=relaxed/simple;
	bh=UFp07q0ioASXzFZZUzkNI/LzekItwem0tA37Xcrofyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2Pz6mj/nB8ms9B9u3IKi2WMWMgu6DX8M1bBrpXckKB8apM2f20edNfK4txj46KTtxAZQGzyTS2MQ+lnpRO3fOlwE4UcUSvy2G7B3KeO7PfWBZBDCOjrXzWmO1I3uOCu3x/MvG1twbkVXjqyJP/lyTtip06PDmfeF3vIbt9APM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCcnEjBI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-436234ef0f0so20251f8f.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 08:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771432677; x=1772037477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=syJvSBYWmoc2bQ+suPVmqNX1ElaxT5/1N2KtMvR5unw=;
        b=ZCcnEjBIXx8RLgvc+gE3FzSuPp5WxtlBGNaDVUkS/RWtU99D80lno5t9gFkCpbKo1n
         V2+Dp+7aTVUJuHH2H358RkXl2dgBw9YjFcji4piLy1tWbiRmRNm75YyGj2PHldm4QOMa
         1H+W+EzHDkZZBWXr7HYQw9tIMj3ILS4XxZSCDuC1bEsHSykowCQu2+Ofm9x4sat5vfGb
         Mp2NUTTyG6+TptV9RfL2bGBxQnVvjPXNLf13YV7Kqc7AGFV8Kp0K1u4WgUSxb1bjA0IQ
         5U8zDczTeQuA6cyJqjbAXaHzZS1n5fdPg4DHr0yPhCoXO0Ghf+H9D+6BqPbxgy1b8hcN
         QcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771432677; x=1772037477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syJvSBYWmoc2bQ+suPVmqNX1ElaxT5/1N2KtMvR5unw=;
        b=CBj+uBHm8wkhhgTNPvcq4qRClavjaJhu8JlJBoNBZj7MdtGoMudsmT8CgAvyYDugK9
         lAtrhNaemYYvXg/00qSGER/Xf+ne2yVun/lbSozg53D5KglZCAwLUw0IfhoOm4/oYdoP
         KU5djGYQD+oBrAGkIaOjIpsTmxa+cYi+b9Q1ru36jK2j3JywVWIsKh5jp5mf4c8awigx
         Hi1jt9nX3a6DxGyjErxGUVmiL9z74Dw2XPyOqTzci3X86MGiGmZpQEZRYsPiCF/c4OJR
         3PKlb8/eIcV3XedJmXGdMyzaViVVjMvtUfGGq9HFVje5zuOnJZE21ttozIM8AoA8TkwG
         Z4yw==
X-Forwarded-Encrypted: i=1; AJvYcCUVhMWXt7eA6wsIDLUEEkkEXAj/bZ3pjHSaSYJ2Fd+mLHlhGzvEw/w8eQj5UR88I7dyLeV2C7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH7ckZm0lx9WkG2S1u/iQnVaQHW/IUOPb/B8fVL7GDPmR8iL9k
	EtW5m615+POYnDUQiCmpQR+J7Ucff+mD/aiOAJ9VpcnQXVjcr3Mx1fsz
X-Gm-Gg: AZuq6aI0iQYF+NUm6dLm3nmbyClSTFtvIfH/L2ERg7VaEvpEVPJf2EPkhqaqq42OggA
	1ILNxBNonm40i20n3J/8ClfI/Xmz4QNneSfQi9BF5uqOPW9LSLcMaWhZH8fFuGZhhVUB6ESL2fI
	KQpqjg1F6sY02p+ORXXa0nSyre5svszbuAc0n2sSU6gm6hUcltAmM58xZeVyCcLiAft9vX/QEXq
	/AXpaSW4DFu4ixQgmAWo5Tc+Yqw5TEbfx/s4sosA0HLOL7sy5kzDtcy3NU4WHuHiQw/QVxGipwO
	LxAPPXUOApmm2X9MVLmz/Nscf6P3Es+/uLIS/5kWhzG4HDxEjrXRWMOxDCV5ovaj5wToxTYtYRh
	NX+zYSWaokt1hucwAIL7ObS3hSv132R0sJ8ODNEen9GGYNdessk4cvZLIqMj//Yw27zf4ea+Dzq
	4VwdtdWmnlfYySxOb/Fo5ckRafYH8gNvdSEUdO
X-Received: by 2002:a05:6000:26cf:b0:435:95dc:b8ca with SMTP id ffacd0b85a97d-43958e4c9a0mr4169076f8f.40.1771432676926;
        Wed, 18 Feb 2026 08:37:56 -0800 (PST)
Received: from eichest-laptop ([178.197.206.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8d46sm43928122f8f.32.2026.02.18.08.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 08:37:56 -0800 (PST)
Date: Wed, 18 Feb 2026 17:37:54 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, andi.shyti@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com,
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] i2c: imx: ensure no clock is generated after last
 read
Message-ID: <aZXq4gn4xhInQQlq@eichest-laptop>
References: <20260218150940.131354-1-eichest@gmail.com>
 <20260218150940.131354-3-eichest@gmail.com>
 <aZXoTGK_v3L4pc-E@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZXoTGK_v3L4pc-E@lizhi-Precision-Tower-5810>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217309-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,gmail.com,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eichest@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,toradex.com:url,toradex.com:email]
X-Rspamd-Queue-Id: 9E034157C9F
X-Rspamd-Action: no action

Hi Frank,

On Wed, Feb 18, 2026 at 11:26:52AM -0500, Frank Li wrote:
> On Wed, Feb 18, 2026 at 04:08:50PM +0100, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >
> > When reading from the I2DR register, right after releasing the bus by
> > clearing MSTA and MTX, the I2C controller might still generate an
> > additional clock cycle which can cause devices to misbehave. Ensure to
> 
> Do you means SCL have additional toggle? You capture waveform?
> 

Yes exactly. We were able to capture the waveform when the issue
happens. It doesn't always happen though, it depends on how much time
passes between clearing MSTA and MTX and reading from I2DR.

If you want to see the waveform, I uploaded it to our server:
https://share.toradex.com/dwnhcrl6b9toib6
You can see the additional clock at the right end, after "0x17 + NAK".

Regards,
Stefan

