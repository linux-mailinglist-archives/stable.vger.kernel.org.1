Return-Path: <stable+bounces-223158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLjiGubSqGmlxgAAu9opvQ
	(envelope-from <stable+bounces-223158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 01:48:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE8E20997B
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 01:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50A9330451E0
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 00:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174A2046BA;
	Thu,  5 Mar 2026 00:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEJu/oJb"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A441A256E
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 00:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671713; cv=none; b=lOUCqyNBsRLZWF+A6E27wbQvyPeq3NbbwlM/Pf7F471wgrPLG7qMDFK3b0xuaUVIKac0npfO9AIEsMmiy0d9+VSiZ+Uji7RZjboW1PXhBhldP+GR8YiRZkUvxnmlrYkkznWNKMh0V5z1KPcpWXKhqBixssLsPzxuurlH1lUFeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671713; c=relaxed/simple;
	bh=+cHUrKIwKCcOSYxTMhBRUiIJ3LdoSqdpW6FQuJv5v5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbzGbEXYayF2reXYFFxh9h/0nd2MIBmT4sCbJ7LPAmdcQZgQ38bwmSEPjFoR78phFvyC0LGzZkfwAdyNPgNbQKS9MRI+3catbZkOMK2tOAj1TZ8o39QuiVnzTWz2aJedjwnXYhGDffnJG18P+HAmwqO1SIxkhhvX7IPp6Wg8bH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEJu/oJb; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2be27fa54feso3223742eec.0
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 16:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671711; x=1773276511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FoznNke4cEg/GrmSp3xe7LTz3Fq6pjHbpyo75xgOYas=;
        b=GEJu/oJb0ONNoAwjuKWn+E3RQwSHUrOpu+sCNh9bMIChnj3yDqxgHixIyJwq3xPPr2
         7+iztxlIQP/ub7qyhmsfV6X4dGsYkTwfDwZeHlAkDmCHPsWpHT3Aq/MKNqkQ6jbVl3IS
         dlB5cWVDijL47ognaMWLPOc4+8mRVfUPoISAWuoQ0Op1jPt3RfcEnbWis7/wN0J7A6OB
         +8SaR2IAIb/BKwV5VyP45+GV7S/2KhJKZBlluymKSrZscpp3fmmRjJQrJekXxYGaqyE2
         S1mfUdFzSIgBWLeGcWrOtzi42GeBzDwN0hHjmdO1wK1ZYC3LfCC20dm68XKSuIGJGx9h
         6sEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671711; x=1773276511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FoznNke4cEg/GrmSp3xe7LTz3Fq6pjHbpyo75xgOYas=;
        b=pedRE9GhgjVy6ETB9sARj4Gd2E+4rZgrQMeiwd66vxrjOnzp+jhqNlIf42+g1AflDx
         LCfh3KsWymYQHrpFFH94N9hffCGcP3IIY2hydcv1cux1XYX2O4mMSxZB8zZ8A8/Hvgq5
         TXkEg/yFmnuQNesu+2IV/AxRWmJu6PVxu+3JKdK87EI7Ry4pc/w1Yx+ReY3R1/ohVTbD
         5ClMVZjda/V/Y0rZS83fdf2aNBKf2pIQr4AZbhOdOnMS4cgAr+VeAtgnBO7xefqr1vBd
         eIz1NGRv9jbFXippnNW4YEIyBJZhwbMI+pdp3Dog9Vcr/5VIGecNZaBR0zxudnG9pNiD
         QlKA==
X-Forwarded-Encrypted: i=1; AJvYcCVb9ZHg8D2W9DyWTjRZjOThZXszQhwMdYGbmyd8YoWb6+qVwAdVpQsFJcaCmhdVbrKoCq4qJbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyREljJjP+rvQXCBU3WyGBvdXjNH1tn2w8GQyXFt/QuAZLan58n
	hOaZymt8L1yhVml30bWQoyY3LTXtLCmtZiSzaO5dG8PCYOFj/DUnjo6m
X-Gm-Gg: ATEYQzzX3Op0lzBwfUTxf6bCLVShq3xLzjLd/nLd8tVQaQLm4TloSS0YwVtiGl6pdLO
	o743op9ibgIsu/SbAIraP31zSCfOqERFo0wnvqTQpYbwQxujcDyth9HVS/LwpMNC9Kcv+v0PMYm
	AiV66EbHA5p+j0+yo74wsxrp6dMaE4PRhc/lKla9eu+2AlHxL9AqC4jjASXECP4WzRikt+DT0O8
	ZfebqMBZc8vNMY6xWdsAptgqIz9mRXJgyFYGgcoJQlertxvc4i5MKa2Cg6w/IHbBrbFRKdfBDuP
	uRpDowr9alLb752miD6E6ofOXQQ/cIN0pEuWlNR7CHLPtNkNjDOvZ2Ein4MHo+99XFpQFcAmMny
	90M3AJTrM3XgiLrXCv88k5SFnfM3U4LNrRXS8vNw1MN85s5z9CBWyrFSQa+KjPLj2QUFM97DzEp
	F/i0pxxRIPbYazGmJOOIEK+McNLLH6QYd86ukV
X-Received: by 2002:a05:7300:ef97:b0:2ba:6c38:c79e with SMTP id 5a478bee46e88-2be311bce57mr1388943eec.28.1772671710895;
        Wed, 04 Mar 2026 16:48:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdfba0df2fsm12447029eec.7.2026.03.04.16.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:48:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 4 Mar 2026 16:48:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: psanman@juniper.net, andriy.shevchenko@intel.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (pmbus/q54sj108a2) fix stack overflow in
 debugfs read
Message-ID: <cc805b7e-e6db-475f-8311-1f0fbe752662@roeck-us.net>
References: <e7191c1c-ecd4-40f8-9e47-9357bd82984f@roeck-us.net>
 <20260304235116.1045-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304235116.1045-1-sanman.p211993@gmail.com>
X-Rspamd-Queue-Id: ABE8E20997B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223158-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,roeck-us.net:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 03:51:17PM -0800, Sanman Pradhan wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> The q54sj108a2_debugfs_read function suffers from a stack buffer overflow
> due to incorrect arguments passed to bin2hex(). The function currently
> passes 'data' as the destination and 'data_char' as the source.
> 
> Because bin2hex() converts each input byte into two hex characters, a
> 32-byte block read results in 64 bytes of output. Since 'data' is only
> 34 bytes (I2C_SMBUS_BLOCK_MAX + 2), this writes 30 bytes past the end
> of the buffer onto the stack.
> 
> Additionally, the arguments were swapped: it was reading from the
> zero-initialized 'data_char' and writing to 'data', resulting in
> all-zero output regardless of the actual I2C read.
> 
> Fix this by:
> 1. Expanding 'data_char' to 66 bytes to safely hold the hex output.
> 2. Correcting the bin2hex() argument order and using the actual read count.
> 3. Using a pointer to select the correct output buffer for the final
>    simple_read_from_buffer call.
> 
> Fixes: d014538aa385 ("hwmon: (pmbus) Driver for Delta power supplies Q54SJ108A2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

