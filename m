Return-Path: <stable+bounces-114201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6DDA2BAC5
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 06:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7277B3A7C97
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 05:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0770C23315C;
	Fri,  7 Feb 2025 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTz+oIII"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B8213CFA6;
	Fri,  7 Feb 2025 05:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738907021; cv=none; b=ujYYOq3w54kL2GIaH8RxtdIFBvh/doUs+s+/P1JyMDFmg+fjS+ghOzjHqeVvQsLolecDm0GsbOWGTWoZBKuMDJ9VlpW6ZgJnN67cDjKWmkYTJIcJU1+83LCh8tjw1DRvh7H/LZ1s8wpp9un1MUNJxk59+x21FpEJTluKOq41zSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738907021; c=relaxed/simple;
	bh=QZ+/ABzqoT4spBJY25jeXthY0X87myu/uIIk+g7BFFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTTwtRSiZxskkeDRE9W3JJCnym53czPddSjTXhWBdHxKrBVeEU+jZkYQh7Tsw0lXIzN1v+/eQal5mqb5tyzpa5P0g6QL0Go1drh1SuyNbeyW+/yPw9HWSVzFikmXsA8LfQ3Qeg9sSxKFrlZEdW2ZEXq9trIDSTdke+KAyWymKUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTz+oIII; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f573ff39bso1969775ad.1;
        Thu, 06 Feb 2025 21:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738907020; x=1739511820; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4oaIvYvQBu4niJTPgoiSKYP3MHzIjlH/YJlINX4NRXQ=;
        b=gTz+oIIIbs0ldfOeuJLjSqi1vgBp7YP08QEHONqoAS6Ab3t6e0nvreuw+SAGGpbe2x
         QSaIilSYcj9DOzeSZNVLpGrtlvOcm6r7tZH9GefgP1807GQGIgHqwEctmeMitnvAlEe2
         lbk4ZzjM9EjCq5Mqic2EoO2KuoMLzrWZWwP+svOdzxKlMmwFdHSVKF1cyL3FIVozJK0K
         NY9kxM9aAKHDUmi7Li+mWj76zuOPEtmdmOtNSSfiqbkgB6Z8Fkiq786AwMYAMjqjdzrw
         70ERafbfciwYZ0acxXEclCmSP7IRT59uj6M3F0A/HqyufnGKd2OsLJLdtSr6mOw1fDwi
         Dytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738907020; x=1739511820;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4oaIvYvQBu4niJTPgoiSKYP3MHzIjlH/YJlINX4NRXQ=;
        b=lgFSD0CI0k/Li2TANyt7UwcqCoUBMgiEodqyhaeTqyM/5k2zHj9H6XYLQxssGf/yCP
         mpd7hyhk9ORbbOc/Aszo4cjavuOVtmIoJReRpGOL/kq/KcIgMcHvthiydVzAf9hESYev
         3/Tpc9681rd2F2z2vsHRB2YLdBtSPr40vnuZEudoPQEyUHI6ZJfJV5nFgHpmk7Ma6vOI
         D2XLLeYULYfwzECept9Q7e2MvR7sbqfe90biMg+19clVOYyUpJBGnDxP7ZW3UohUewPd
         Bo9qBGwVzv9vqjDiatcc7SRn448/2NjrbET3S1pjcOoutNoJ3HBZXk4I19G10diAIiz0
         x+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUj+fnryWTYW4Mg1Pxv/GYz+o5CKDKdXd6bXM3QilXTacUganxt1WcJDcAUc/aGpAupULYdvDqwUgftGQo=@vger.kernel.org, AJvYcCV6KSqNySv+kPQFskdnUsF6jzNlvH3XoKF8OB3GF3QLsex1Odp1e74bXcqpcE67ZSXRFKwwc4w6@vger.kernel.org, AJvYcCXDbhkbUWW1MIrEHxw1V6Ltu4vrfikICUvTHwBOPWOB90cZ84FlTqieT5L/KymwyA0ypGuhxPEL@vger.kernel.org
X-Gm-Message-State: AOJu0YwUob3pzVOz79l/IDF6ylQ17YJdFydprK70H55RuV1qCPTuLBJE
	IGjQTJSYrgilF2Bq6Qd8Sb8EgU4CHE42FV0N6IrxNOUCRZadwhTDDBe4TA==
X-Gm-Gg: ASbGncu2u76mBZ9T+HqsLgFr6li2kz9mtfm202dTcEu3crh1d/fMFbvUJ0lPnjKFSnf
	+jpWIYzq8YC4Xmp86kJiFWjwWfJwFkZ42BT8MV2Z090N/lbsqvNXsquSZlxkrWgfxUt9uVoBt86
	Vb4q7yHK/iiAE/liZk9mHENAnYOfqZDSLMZKnrbmS4zxOupWrQ7HdPTbMoNWL5ChwUPH19f5MZ9
	1buALMV5GTV+xHFykOzXcEppH2P5oRyvWsubZdJm0jY3TFyTJZZwmyRheH8FyY3hT6c/zIQqdH3
	ASIrLBVwQMvKbcjS0QLHPSAdYBW4v2HxovPcJYtbXqrHQWtXiQcc8fGGMh6cOnkVk6yTQBASHbV
	Jqlq4ug==
X-Google-Smtp-Source: AGHT+IHcBYS7+hJxgdBY/wIHUqMNCV5DmWfWyMOx0rt8+aM1hXIn1PnKkugiHfCHdnQk5sllDXmxKw==
X-Received: by 2002:a17:903:234e:b0:21f:1549:a55a with SMTP id d9443c01a7336-21f4e1c8b5dmr37802505ad.1.1738907019700;
        Thu, 06 Feb 2025 21:43:39 -0800 (PST)
Received: from hoboy.vegasvil.org (108-78-253-96.lightspeed.sntcca.sbcglobal.net. [108.78.253.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dde1sm22043165ad.149.2025.02.06.21.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 21:43:38 -0800 (PST)
Date: Thu, 6 Feb 2025 21:43:35 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] ptp: vmclock: bugfixes and cleanups for
 error handling
Message-ID: <Z6Wdhz7ysFYWSoGi@hoboy.vegasvil.org>
References: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>

On Thu, Feb 06, 2025 at 06:45:00PM +0100, Thomas Weiﬂschuh wrote:
> Some error handling issues I noticed while looking at the code.
> 
> Only compile-tested.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

For the series:

Acked-by: Richard Cochran <richardcochran@gmail.com>

