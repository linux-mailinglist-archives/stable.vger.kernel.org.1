Return-Path: <stable+bounces-249664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKCVCl+wDGrdkwUAu9opvQ
	(envelope-from <stable+bounces-249664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:47:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B680583DBD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AED76301FFA4
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7C936D517;
	Tue, 19 May 2026 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lyXaXwql"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A872936C59A
	for <stable@vger.kernel.org>; Tue, 19 May 2026 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216458; cv=none; b=XhZy/AQcfffAB5p/krSQGjdQmwCMGEW63auGEzyj3pmXpLGfrtv2ZjT6nIMObyq7ugFFxKzvNJoyhwB86mEJxHcR0BD2rZw8S7ZVfcWHTYnpz6P0iLWUGBUIYEhOqIobkk7Y1Yx8nNCIc/czY8WsHHiPfujUS64vZageSA2ataU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216458; c=relaxed/simple;
	bh=6bDFKloV9wCzA7ym/ab7C+z4oYqNZXRFYLSn9rPO1gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5Lupah6PlvAg/+xPen6vykTlRbX2lvbe9Wgx8SFiHs4bNKkJxLbkbw7qe/A4nShCSzTb7OoYai07/rRMZee99LTx0dkKQO/gW5fhdqq8ngBgKF2ogjCGvpqHgqpPzT+oJ6+C8Bx4E0ds+kjps2jKJ4b8cnurCGpYrghUyfgBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lyXaXwql; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1325ad.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779216457; x=1779821257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bDFKloV9wCzA7ym/ab7C+z4oYqNZXRFYLSn9rPO1gY=;
        b=lyXaXwqlAXVwABemtO8UbZ2EgtQYxwzyakp/pPvdcoRcM20qjfF7Jp5KKSvvSPUJQo
         u9RlEsZcYmQ9u6GjND4O78w0xZtPxkgUrTXQ1HkUE4mP/UswAzNFiL2bIMAi8UnUGXws
         WI0HDVux20yK+rSEyI5/YVuaa9+R5xfG/HcOxHV5jqr57nxZvGnY8m/1YznWfe2EnuI+
         7LFNgb2k1R01A1k1jwFNxbbHDZ2phld8gYcGZeFCKFuvXY/dazZaOMA+uaBM33U9CD/4
         pkdEdpx+8Ir50wRPcmjj4wh4nVi0hclnUN12aQoXylvuB7j1vpXoR4x5e+bsk202gRqU
         RFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216457; x=1779821257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bDFKloV9wCzA7ym/ab7C+z4oYqNZXRFYLSn9rPO1gY=;
        b=InRonuB0nf4zQS25FwvAvFcNt4am7wcu4RZxy5I+oLlbtk8hoeP5634V/QxfdabKuw
         aAI9R5i4bDA10q/rIpTTU3N6GYFZgjH1jBpf0M/jlKwvdDWKi596JdUd8yIhmwdF8/vz
         KB39bXxEmvIbcfH8d7lEOvIXAw7b8BbT7+vsEhHU+qreZN9CvZueesKZE7tMWUFW7oCP
         LO1v2X8opnYDKduBHLHR0n9dbr3E3eh9sNIiiDkN4L1oey5C7XxTMtSP9YC0yAGoMU3K
         ppiy+1oBDl57hpc5K02JHG5G3cEeYKvtRdrooRPnAuzpWYcPYOSwZ1tLgnQ0ECoEvJaU
         XuQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UHubosuSHIvAJOzpUchAfWAGQzA7Wiip2w62fjCcjhaQYBCwcMfGFZFqs86SWmreCQLw0n20=@vger.kernel.org
X-Gm-Message-State: AOJu0YylIxeSA0SgpuZZ2E00ymGC+U13XwYBBAhoTFc3T/7V5vkeW37t
	pu4X6SmBtz/oQ8hifKoXWDJU6z1TuKYKk06MpQEWotXcUcx+1oensxLRlRi/ymPNbMG3KRaVBDr
	KNf5+Xw==
X-Gm-Gg: Acq92OGYvxlfvOwEcNp21MFOEcDMFqM9ukB9PDR2TbgFw3ScGNFB+LusJSqaJrxFS3w
	wULjV+6wFl0h54MsA4XeVrh+c4foXNcAyjNZKzE2wmqiGkhIfOyNT5kT4OaC0FG6AX78fHiXOLX
	0tAMznnTmali1vAoma9alpkuuWnx61gDOmsf3Em5xMyzArxqTCdRxxPQvd7DkC8UVN+MMD6o9AG
	aLr2ISJU4CNIJLIPr6jjduo7aI1+twgWQnCVKJRk+6sJVWHhAsYLX3AXt+oQCsKD3fRqH5vOMfM
	+9WeG5b41YqF0u7OWKyhmeJDGuWCWZlf8FRturBnM86ulSN81Bwy6uv8jDjDVTXBeyMpckTsDeE
	Cm0/2oKrdPBrJy2Q2jKNVgm6CeSnAaNEASmVJlS1GDNxYH8cs0tal2qchcaJwbCf8uPhJYAWD8E
	AakIwiAVzKUf3tUQQ+1/EiWQBbcxeuh/TN2VGFnKZC5elYJbIosP0vWRmqveL0T6OPO9Ekng==
X-Received: by 2002:a17:903:1983:b0:2bd:6dad:3dfc with SMTP id d9443c01a7336-2bdb041156emr6226085ad.26.1779216456323;
        Tue, 19 May 2026 11:47:36 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11ce67sm198205895ad.74.2026.05.19.11.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:47:35 -0700 (PDT)
Date: Tue, 19 May 2026 18:47:32 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kho: fix order calculation for kho_unpreserve_pages()
Message-ID: <agyvXfrf6aX8LE19@google.com>
References: <20260519133332.2498092-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260519133332.2498092-1-pratyush@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249664-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhawaja@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 7B680583DBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 03:33:30PM +0200, Pratyush Yadav wrote:
>From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
>Commit 91e74fa8b1bc ("kho: make sure preservations do not span multiple
>NUMA nodes") made sure preservations from kho_preserve_pages() do not
>span multiple NUMA nodes. If they do, the order is reduced and tried
>again.
>
>The same logic was not implemented for kho_unpreserve_pages(). This can
>result in unpreserve calculating a different order than preserve, and
>thus not actually unpreserving the pages.
>
>Fix this by moving the order calculation logic to
>__kho_preserve_pages_order() and use it from both preserve and
>unpreserve paths.
>
>Move __kho_unpreserve() down to avoid having a forward declaration. Its
>users are further down in the file anyway. Also, it results in grouping
>for all the page-level preservation and unpreservation functions. This
>unfortunately makes the diff hard to read, but the main change in
>__kho_unpreserve() is to call __kho_preserve_pages_order() instead of
>open-coding the order calculation.
>
>Fixes: 91e74fa8b1bc ("kho: make sure preservations do not span multiple NUMA nodes")
>Cc: stable@vger.kernel.org
>Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Nice find, sashiko was also complaining about same on my kunit series:
https://sashiko.dev/#/patchset/20260512195135.804833-1-skhawaja%40google.com

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

