Return-Path: <stable+bounces-226919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJoLOsDTuWkqOQIAu9opvQ
	(envelope-from <stable+bounces-226919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:20:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B04012B30F1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 247B630484DD
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E4A39934D;
	Tue, 17 Mar 2026 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnCIIiz6"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A8039B94F
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773786044; cv=none; b=u92zLhrpHL+23gigkOqGGpIb9Ka1+VmfhlkBMVk6v/TCpJeAr4KHruecqg/CuIv/e4NZ61Z+QQ8ft/yF9HYQjfr6kGDMQuzh2M1kTnDDUs5pHvOgMEB09barj/bh1RRIzJX3ywoTstQ75wFJmOXR0ZpSQr1YCGspfR6BN0tBwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773786044; c=relaxed/simple;
	bh=2AezpX9nMJN7fXejlohfhk6Hee7s312vEjqngOxROR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2RtkpMoZcnxM1G/F7Q0VBUitl1H/TOHlKj6idbx1N6eqLI4633LOoOV1hLCGXRzaQbRKAA1TNVpOBu+JvUyXtCXQdSHRdDbTesPLq8fkPCR0FCCfXHcdRCnIgO0zYmCP/BytSbcANOmJBVt0Yiw/ts3spTPeKVkpMBlQM/T9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnCIIiz6; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1271257ae53so8753342c88.1
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773786041; x=1774390841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFphyAt9r7cEETWzy9hJGoIRqUIBOhHfjBLEm5UlK6c=;
        b=XnCIIiz6/vMy7IIog1KOuzecaaDMFEkjM74OCevsO2fVh0E6vtN0YqisiLXARWCfal
         sXgLXxkxnzCPeNvwQYl5ubaTwaTVIKBv4/KSNESpd+Em3wE9Ya4Xm9p5zOCChUjJ6A8r
         8rur20n2TL95795ZH1Bq+Ycz86Jb3x7hc6pQhQjR2DMKwttkGGJmZCy1xuCf7hhrsQqQ
         JmvAuqkkbr+DCFrrI7QJAgBFfcEzjK+t0GL9fvIuDXE7yOtMP5qUqtQoSy7ZIvYxEXV2
         LXcmJGiiYMtfXLowCBVyDtA1rw+mw6RTSWXcllG58yRPl9pcN+Z6UUzff1tjBtUTwl7c
         823A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773786041; x=1774390841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PFphyAt9r7cEETWzy9hJGoIRqUIBOhHfjBLEm5UlK6c=;
        b=X4lPJ8hlyF1mNkS+gklNAVhL7kAJMSzoMPoxFOq0AcujshJy+QEgW0NSOZItjs2elD
         3dkiL1uX43zGFQAjbWcA+qwYbADyjIXHO74JmUBtahfcgnWlpJ90eG9E/W7gxBsQZhrM
         6ThCvCjgFTfL4b2yp82/Sf76QOsdvQpxJuH008wsTBfePWxI3NCZSJYGmI6HroxX+63h
         Yhw0YpaaYppUjkX9U8dE3BZaT/Ry3KBBiEbWriOO2+tfxf+lsSIk5rZVx12dIiiLglFE
         mc0pGiynbTKpWfgvXR7uLMmWZG1iMzKv4GqFj0ahtz1Bz8nrkwd2MrpAmdqyObnsLKav
         B5oQ==
X-Forwarded-Encrypted: i=1; AJvYcCURCW3VTHLwh3w9FofLnlK8qoCHR7tOVI4hhWahSqQXTyf1elGVbgPubpS996VFHlgkGbu9ISk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AS8xCm1ox2cl23BNHuLWsskZwlo9vTlYAmM5MCgeZcrqQlvE
	Pmb6bqCJcv85YIA7V7D2WaRBNoNArvCbknTghqauRvmf5P+exv/8is9779bJAw==
X-Gm-Gg: ATEYQzw8qICKT0lCTIXbXinUQtq9jqx8TgFEhQwQgG9YqvqaNlfCyVvjEgbqS5n4Ios
	MI/4VczwOegOpSFx5VE33ZxYlKKSBzupTY9OwnOWj5rsS+j98K+0BdjiKO1yOZ/PeX7siBhc9qq
	Yr9A6IzZHBmGh26BzQIh7/K7D47HSOYMt6llzOz0AY6nDYkwRzeQlDWFXo1oPPVxHVB3uwlpfwl
	AAQjFULjOyRpiYjngwLQ8zNUz/iAcwKT8IE0VDtHoJq1sapwMakXg+mkLxR0cuP05pwGeDGGtHO
	SDoPdkCuJkcPQlRhrBfng6ST85S0V3e3t5/VEli8PXF6CxA9Nr/vZd9e0BjcuZfHhZlCJ5GiLVs
	UbwFyaTuWFugB0ltJ/zQtP8LV3wS1gF/TmcyrmvCUBetXMMjkVqPWI0nLX1KxzXZtsqwvaybJEy
	bO33l/gisE81X4SPsM0zCudX6tVkwwKsdaKCUE+tUu6GWZwnU=
X-Received: by 2002:a05:7022:160c:b0:122:8d:3688 with SMTP id a92af1059eb24-129a712f3d2mr645312c88.22.1773786040671;
        Tue, 17 Mar 2026 15:20:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b3e8d34dsm1230176c88.7.2026.03.17.15.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 15:20:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 17 Mar 2026 15:20:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"vasileios.amoiridis@cern.ch" <vasileios.amoiridis@cern.ch>,
	"leo.yang.sy0@gmail.com" <leo.yang.sy0@gmail.com>,
	"wensheng@yeah.net" <wensheng@yeah.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/5] hwmon: (pmbus/mp2975) Add error check for
 pmbus_read_word_data() return value
Message-ID: <d8edd124-66df-4261-ac64-f2fa0c77382f@roeck-us.net>
References: <20260317173308.382545-1-sanman.pradhan@hpe.com>
 <20260317173308.382545-3-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317173308.382545-3-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,cern.ch,gmail.com,yeah.net,juniper.net];
	TAGGED_FROM(0.00)[bounces-226919-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,juniper.net:email]
X-Rspamd-Queue-Id: B04012B30F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:37:17PM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> mp2973_read_word_data() XORs the return value of pmbus_read_word_data()
> with PB_STATUS_POWER_GOOD_N without first checking for errors. If the I2C
> transaction fails, a negative error code is XORed with the constant,
> producing a corrupted value that is returned as valid status data instead
> of propagating the error.
> 
> Add the missing error check before modifying the return value.
> 
> Fixes: acda945afb465 ("hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

