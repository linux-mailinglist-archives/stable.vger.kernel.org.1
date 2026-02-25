Return-Path: <stable+bounces-219202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHDzN/6anmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:47:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 597AE19280E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3446303609F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD28A2C0263;
	Wed, 25 Feb 2026 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mu2bHQ9h"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB32BE62E
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002009; cv=none; b=qoFuTqMDQgJZRV7IGj+XVrGt6jLOHwdrPv4WmKH4Z8iDA5+lvY/AhS6wehtKCT3Gl0nBVxfpATZP+Y7/KucfHzscgNVsLRxJo6VjiZTft+k0MTx0NSDRf+SMsv9MJaB6PVli8BjtilYeo2THcJUmXGEPX183cJ7Y3un8/TnJmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002009; c=relaxed/simple;
	bh=OsnoBlqsPRRMXQFggZjPmq6tctmLvwEZvl5IlaqGnas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbiyh8mu61gcDMlkj2eVtJc1KpRo3JFk9wYIVK1LEfPfVSBY4fbqSgXON86PTUJcPqE+9qZ2iAGQYNpGvFboIFxQzJVi+1z/pSpA0yo/lp4LWkc47LX1CkqOjC1LrQixx1rKYX3u9oktco7TmdLmiOkammCbTuLBvBpHPDcYVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mu2bHQ9h; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48375f1defeso43993125e9.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 22:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772002006; x=1772606806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4NMqbshYRxO5mZM7OEYhfcX1DI7UCXh3U+W732gQjU=;
        b=mu2bHQ9h17nqcWKQe3BW/OaFtyaFmcmfr2jIJXxDal+M9njpkGhjF29dGudPNXhgGc
         6QGD0ZVesnljsnOgoTUhh9vigXRrTfWgB0yCznANNBYXITD/5Fvc6kETAJBRDMepvSmw
         viO0ITerjZvKIY1sHQs/aVeX+q+51C6AjqvgOL1i7ZyAEQFUAj80pv33F8KdxQz50U95
         hLuKYiTw1wzFNM6s5Y2HngJxAHYBu3xVbxqFQn7OddbaEq17WBzaS+XUnwhjpSUDkxNH
         jdUORLesxlNj6nO7zS6R7sTQ+ku1KeR4h8NLsH9Mj/UnIvEqQq1G/X5FBCF65kUiotDD
         bsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772002006; x=1772606806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4NMqbshYRxO5mZM7OEYhfcX1DI7UCXh3U+W732gQjU=;
        b=Qx2nX2/s5wBKpjR0nsaEH+wQuAMHUjHK72YFNWAhGUVEA4VkMOHJRnKbgkF9HPOqec
         //G2Meb7mR6CS5HGmOkQp6U/H8OxaWofUfsjGpj+tMBwvQUoJ79UFjXSnFDlHmVzXMDw
         Hff4Crom/Lsk3oIytR87aqIQt3xJNJT4vkHjau8c5Q5fudEAySb5N8LMoGCwJ3Ftkrel
         GPYysPx1isClXvf2CViNz+wc8d/3QinZwqWq+f/K89+grH8leik/73AbRnUCEtxXBusr
         qspYutKMHkuRa6Ddy+DcxZtzME+MHGvHLHLY+r0ltRK77yVl9CM7iGF87yXXYGbP/KkV
         WZPg==
X-Forwarded-Encrypted: i=1; AJvYcCUgPKtvjWOw6mCTizEt643TOlohQUaigrKGSA3IYOlruKucZj/IE+KqsuhjLpw6JrL5AKm78g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgCxrV4soQNezOveND0s+Rp0kpYfMLFVqyIJ4Gg9Ckx4tqUW+x
	VZlpLTvqHmY3l7dFgln4PzP6w0DRSRuAhsQ+TsLYKsea+NvwAVlxB7E602PGmr9FCtA=
X-Gm-Gg: ATEYQzwMV+gIyci6nyrUeXTXeEY4y8eTn/fuo8T0x9TXAghAA5BYNVYvG0yPpH0u21Q
	QXlRna69BubjccAicl+nvwxi97aBRo87iJp27AYu6+HE9EdNcewHFFXVoU08YXnxiYH3QmvkmB5
	jwd5/l3eStgOdLk69XNUu6YwZb7bgNs3pb/tV3rw1Zk/T66hnhdgLF8Qud+QmdV6PrGz/vplwWz
	ARcYWGZqOni3OoOCtgBkEneKkLyah1KApLHsB68tenyr1yWLUq74s5RlGnVKG36fOD38Nzbyqz8
	icX4hj/lNc9lRSNsk7y52crdWASSN+x8yKxf6JZ/KDeBQg6pvW5t8JgxYXXfznlIuHAn1fpKLgT
	+k3Zp/3gHB/B8lPLFsuKEGOBXDtuB3uCaPDjJ8+zJrMKjzipC+u28qkB15z/m5F6J5l/uEmhDJK
	IwZjqJ1Rb+G+F8Mmmf9lJg4Lc3ciVv
X-Received: by 2002:a05:600c:3553:b0:47e:e87b:af8 with SMTP id 5b1f17b1804b1-483a962e491mr243587295e9.21.1772002006146;
        Tue, 24 Feb 2026 22:46:46 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70b3f3sm51906145e9.6.2026.02.24.22.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 22:46:45 -0800 (PST)
Date: Wed, 25 Feb 2026 09:46:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: luka.gejak@linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] staging: rtl8723bs: fix potential out-of-bounds read
 in rtw_restruct_wmm_ie
Message-ID: <aZ6a0lyyeUcOIo8s@stanley.mountain>
References: <20260224132647.11642-1-luka.gejak@linux.dev>
 <20260224132647.11642-2-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224132647.11642-2-luka.gejak@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219202-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,stanley.mountain:mid]
X-Rspamd-Queue-Id: 597AE19280E
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 02:26:47PM +0100, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> The current code checks 'i + 5 < in_len' at the end of the if statement.
> However, it accesses 'in_ie[i + 5]' before that check, which can lead
> to an out-of-bounds read. Move the length check to the beginning of the
> conditional to ensure the index is within bounds before accessing the
> array.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---

This really should have a note here which says:

v4: Sent this patch previously as part of a patchset, but pulled it
    out by itself because it's a bugfix and the rest of the patchset
    was cleanups.

Otherwise, it's like I remember that I have seen something like this
before but I don't know why I'm seeing this now.  I thought maybe it
was the same bug in a different driver or something so I had to look
it up on lore.

Anyway, looks good otherwise.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>


regards,
dan carpenter


