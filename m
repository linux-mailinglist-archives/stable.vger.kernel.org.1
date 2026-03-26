Return-Path: <stable+bounces-230418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDv7GGPKxGlP3wQAu9opvQ
	(envelope-from <stable+bounces-230418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 06:55:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 444D632F86C
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 06:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A84E3015B7D
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 05:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365E93ACEFE;
	Thu, 26 Mar 2026 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrOQV9yz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38BE3AD51D
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774504542; cv=none; b=o6qxZmmZAQjZ62t3xDFidayqNJKbHK9ir2Wr1+2DwIVRhgoUfpieUXleSceWOyvDQosUPY/TOkKaQAMbTwhCCTlhyFckvUzEiPOQwcdtQji0GKT1/WpeWnJWQdctEaSS5i1qswzZPJ/Lc8sspRf831maYjR0qHNHE4FiMk9aNj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774504542; c=relaxed/simple;
	bh=eGwkqUcQbKDZZG6/9F9PQQadBul6X9JhHH4znZQGFpE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=XaHXQW0vbkwdDJ8sF32Qe6+Oajt344cfDC2Ce0bQjagfoNLRGQ5263ekWzPGWw02DeWYUlR1QP71Rz7+/8haIO5oO3SASQKNAsMMVoekq2/qBiHBXAbiO+uvcL+5ErRoKACd1gKKzxtHbha5+9bmcsn+B/gtmZJNQBcw8NkLQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrOQV9yz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b0603ee486so3717675ad.0
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 22:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774504540; x=1775109340; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGwkqUcQbKDZZG6/9F9PQQadBul6X9JhHH4znZQGFpE=;
        b=DrOQV9yzIayoGHAsk2ySbSqXECWoWhPKkaaEPeaM9vEMFca8tK4I0NKcprS4I8yNig
         b8vSweX4CEhG1cklmDmli1+lfV2iah0BDigF2yZ756K0syPP3b2mCQ++pXiqtl4a4Yek
         1IdIzw/3W7Nkyi/CJVmmyPoeLmjyaYUgTwen5DZBnsFEaeYz8EHa1w7KM9cUVn3Gxpjq
         uMN874vs+P2h/WbTee8fBPICeiAZw4WbSIXovpYL0YTJVVmgMS4VsZfANFX4PBuNvIds
         4QcH31EDt85B67p7K+VuOHhm/bfk5sFMTzs4lkiH14kxwcXRHuSp+j1PBGZeRsUQosz6
         cl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774504540; x=1775109340;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGwkqUcQbKDZZG6/9F9PQQadBul6X9JhHH4znZQGFpE=;
        b=FfkK+LtlSRkoRePSR6RvyZIE0Mp4IywniBxrNzi5emYPDz+0jHLUw0kJ8nuxEsGQaj
         dboDn1CAgvMYcwC+rl7D4z8QHJKLppF9OT9vjjMvoQndtUqpPX6fPDNi29UsuYk9gizr
         EF/RRshnwdDjl3f/BJYsSVQoko7UsUWByUodASwhd+l7JJe4V4UdIJrU3jvlen4Rlyni
         vmClG42BUYFCH1p0iNmk/eGfbjC+NvxMxD/a+NSd6/iGGXHEbiRbFRHBq+wl0flWnxNO
         oYgd4Gts4AiXjdELJm++JCgpxRN9YfRX1rG07l3a3VkSYijvC7XWb9teKpONku9zCXga
         8m8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKkfRFH09CNN4XXwIgBOIqK3Gs7dOfneMgFOahztc7yezFdNH1DDaWiMvgBuMTbw6bCWzTwX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWfSvllqhcj71DfEW5iVtISpPAbV/9Lf995A0Lfi0VlBjX4Ilw
	z8Jsp+TkPvZ9ALgZTK1NABx/DYIxRhrZg4XzXAEBm/rb+YWKCzRW3y+W
X-Gm-Gg: ATEYQzzZ22EntTvfDsOWF18Fls33unyFk7QpobXZYuPMFJOsz1NEoF8Lfwt7ED2D+GJ
	JAL4pk6Al3m8wtcNMvQGq0F0b31QTk2f4T7Gi2DN0Y4PtF4OU0xL2LTHKnY9DBMs8au68L0fj2a
	2dUA21aQurU7wXEnC8xeCmZlpdV2qJv6HnNKlAXf2n7uzaFQlUQ1jjVggGo8iORLsW2I7HhepAc
	ImV4KC0E/Fr2X3t8YDaXyjG6ksDi6bZx0tWtM2Rb7r8XzhPHzmRpXnq9O2BhOXTrwIYMIWiu5em
	SIpEwca3M8j4N3eH+z0Xwv4vh6eSs+EJn9QX9NALk29YiQhul5MU8U9wRmfVDE2Gbf+p+U8WkoG
	DrorGFNevfNNnV1Tc/nsoU/wDOzzPvdrnxZBXWzUhzox+bko/rmRiZmyoNmPMOFrJIMfdCdn+KB
	8hllnd4bc+wSsCpfRIAU9fKI7zOO+mnqg=
X-Received: by 2002:a17:903:38c5:b0:2b0:615f:9c2b with SMTP id d9443c01a7336-2b0b0ab48c6mr71142445ad.24.1774504539911;
        Wed, 25 Mar 2026 22:55:39 -0700 (PDT)
Received: from [127.0.0.2] ([240b:10:ff26:df00:3001:9be6:4399:d681])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8837e6sm17606485ad.52.2026.03.25.22.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:55:39 -0700 (PDT)
Message-ID: <69c4ca5b.170a0220.279f84.8bac@mx.google.com>
Date: Wed, 25 Mar 2026 22:55:39 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] xfrm: clear trailing padding in build_polexpire()
In-Reply-To: <20260325171532.GI111839@horms.kernel.org>
References: <20260325171532.GI111839@horms.kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230418-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yasuakitorimaru@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mx.google.com:mid]
X-Rspamd-Queue-Id: 444D632F86C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 27 Mar 2026, Simon Horman wrote:
> I think the Fixes tag should cite the patch that introduced the bug. The
> commit cited above looks like a related fix, but no the cause of the bug.

You're right. build_polexpire() has existed since the initial
import (1da177e4c3f4), so the padding has been uninitialized from
the beginning. Sending v3 with the corrected Fixes tag.

