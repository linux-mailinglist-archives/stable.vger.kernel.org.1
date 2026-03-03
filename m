Return-Path: <stable+bounces-222839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGBpJWimpmkTSQAAu9opvQ
	(envelope-from <stable+bounces-222839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:14:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C351EBB03
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6850C3033504
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 09:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35DF387570;
	Tue,  3 Mar 2026 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/Rs8yJu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2223164AA
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529253; cv=none; b=HIIYaTqemYuPqotKbV3U4JC9fijAzbNGe9FWasJt6nFGwo6idu7ZL7Awm7qYQjebxBWoM9FfN0XniB4q0KZoGUjlIqCH6qhwHDoBv4rOfK1TBGWtkQLeWT0NVSAQmFqBP8TASpjIgzlP9s4uV+IuORpAB4hAiHyNfp+g6egJGIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529253; c=relaxed/simple;
	bh=5l2Kz22xEk2Atptg+7LjAz1lULYa/VgXF4E1315Awb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNZ+KgGkwJ/Ug2mmhIPCCIdvvlBvcRNB+H4MzAdCr+c4cNVMAOHSaNfTvRoDpbNqDl49yqUD/aIShj9XFkjaY47jGm6O32Axh7DUWZC/WgqyxDMzIWBVanrLycD4VKIq6dpO9i/KcJlqlBGAc1R3mTiPYIrN8aGwRsEhcJ5Urg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/Rs8yJu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48378136adcso31861525e9.1
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 01:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772529251; x=1773134051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfdnRKMwt4rIrADe9QK97cFlPrIqJK1YbAhHvdHHa88=;
        b=F/Rs8yJuofb4sXHSHuzg05ArbJjFka4RwLh6G/bTVBcMgAGQ5G1ftRF3H03wCI5ji+
         kRAIH/lMyJ/Hv2rPxFLkKc0Kh2QGZtTLUq/kcjz4QYGSwJeLMEzaNZW7i6A32eVS0zMO
         kxm90cDq4qBxXQuLxrgpEkGayTjGRDDPlYhD8v9fEHAYy1w/B9IIykgXwrkq1yd8mHnF
         WRfzxKvhGOZD4+WdCi9dHAK05rPgdHYCUVwGfzKRNgoMXAHeBVuA3pviGIy+k6JFB0x/
         uEUINUaOxYXM68bqV6hGFPV2B0eT7RgX/UFTG4Fu0aVeF9hEqVHYwWQHbKDgXp95DXpn
         NSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772529251; x=1773134051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfdnRKMwt4rIrADe9QK97cFlPrIqJK1YbAhHvdHHa88=;
        b=fmiJDJ2GbvmT8PWmbfC64QdlpJ+61XC8CGWnA8sOy/+JPyjzWq6j/7fZYe19pTVNFu
         xnzkpYacWPn+wJPW4gExzAu7g8DfSTK0ktSi5sWBYzK5uMa8X3ZIZwCywF4joIwXSCeJ
         P69Ym4aq4acGw2V56BDXat+SgK6HpQAt1Ud+AWWlHei3V0yUFzyemPRguYa1yjkz39CS
         Sq5aY3xjJtTP6aRWPwjpUnJfzji+xy71tBwlFuP2qGZ1UVxshkwW2FvpNnPcLXhdu9fb
         ZkAH5YXcM0HXa/4WJbYqjENES2qpS/IY3EK1KVDYxWviyk3aAGUkgsFnED3iPsRuWloF
         HerQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKsHDrWaz2dhtLKWCciuhlOloopsXTV1ap9bPMB6BXpLFhgn5k8wOwBDjaAIoT696igOvmwOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcKxdGO8YPtcHfidNX/QYKpLwpPC7OvSPOU4boSC6D1+ukDlAY
	OfRX7sbYU1Rq+ybVUMs3FBJqm6tlr2OwbeIulykwKZoC4ShSFcY8uhWH
X-Gm-Gg: ATEYQzy4ezYcMNpOhJoSvhrL9BbX+IEx7re83g3lqSYYXShBTYyzFgd48nqh+uGRqwv
	UOdfcGbXKONiGd/SBjCDmHDhUTOWfTMh1AwHBnuQ5wfjl5lhGEZkJtcQquATM2H6fbk6FpLJ+vS
	SV22xMBeLXuNgUzeygMlbfVFQtcwVm0VKMFRNu2YhE7seq2AA59C/TQgt2nCpwVzDXrNAWR2fDh
	zEE9/Zw2pyezdzuu+olf2KG/Y+hF9kUdnMzTVs+eOzK0zNvguNhBTLSlTv9aeRAItAi0o/30Dry
	NiYgtZEZkPPcDwwE1/JnmN2j0T8HcvoPCP7qmsvgNSShfra+aZp/K81Rys1IA/OR8sVTM1CAUgE
	zwyDRIjAed3IJ0C2mNaKlezlz4Msf8Ez6ef5r32ptMbCUf8ozF8tlOy7G5NUmBX4zBwy/Yw5UJs
	I2z2TeXF87tCE0y1xdT+WrKwM=
X-Received: by 2002:a05:600c:a16:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-483c9bfb2f2mr273658985e9.19.1772529250689;
        Tue, 03 Mar 2026 01:14:10 -0800 (PST)
Received: from eichest-laptop ([77.109.188.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7030b9sm376259165e9.4.2026.03.03.01.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:14:10 -0800 (PST)
Date: Tue, 3 Mar 2026 10:14:08 +0100
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
Message-ID: <aaamYByn9dZEIBWb@eichest-laptop>
References: <20260218150940.131354-1-eichest@gmail.com>
 <20260218150940.131354-3-eichest@gmail.com>
 <aZXoTGK_v3L4pc-E@lizhi-Precision-Tower-5810>
 <aZXq4gn4xhInQQlq@eichest-laptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZXq4gn4xhInQQlq@eichest-laptop>
X-Rspamd-Queue-Id: E9C351EBB03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222839-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,gmail.com,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eichest@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Frank,

On Wed, Feb 18, 2026 at 05:37:54PM +0100, Stefan Eichenberger wrote:
> Hi Frank,
> 
> On Wed, Feb 18, 2026 at 11:26:52AM -0500, Frank Li wrote:
> > On Wed, Feb 18, 2026 at 04:08:50PM +0100, Stefan Eichenberger wrote:
> > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > >
> > > When reading from the I2DR register, right after releasing the bus by
> > > clearing MSTA and MTX, the I2C controller might still generate an
> > > additional clock cycle which can cause devices to misbehave. Ensure to
> > 
> > Do you means SCL have additional toggle? You capture waveform?
> > 
> 
> Yes exactly. We were able to capture the waveform when the issue
> happens. It doesn't always happen though, it depends on how much time
> passes between clearing MSTA and MTX and reading from I2DR.
> 
> If you want to see the waveform, I uploaded it to our server:
> https://share.toradex.com/dwnhcrl6b9toib6
> You can see the additional clock at the right end, after "0x17 + NAK".

Have you had a chance to look at the waveform? Do you have any concerns
about the proposed solution?

Best regards,
Stefan

