Return-Path: <stable+bounces-242589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIh/OLLH9Wm8OwIAu9opvQ
	(envelope-from <stable+bounces-242589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 11:45:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E0A4B18D5
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 11:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC52D3011799
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 09:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69E531064E;
	Sat,  2 May 2026 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3RIta4S"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AADB1D95A3
	for <stable@vger.kernel.org>; Sat,  2 May 2026 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777715115; cv=none; b=VopmRIormgj/i0hv5Yo2QkjPug4e/s2RO5CxwDGbZu/Fu2Mtu0JXodsl6+t2V47xU5LtX6H+Z+T4X27e+3hCnInF3pqboSnPW9Wb/bexAghw2Dx+H8IMjBQ7atEwlMmb4rPN9SXr+rlA3T1FMLkV/qVrwuES1FLwWnF3sGALmCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777715115; c=relaxed/simple;
	bh=tQaOSTmRG8h+Q60TQrv4Ps1DXYna/JcS4+Wi1K4sznA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO9rS+PJUNU8e8i6KJgXnBA13OPUtds38zblu3amEWW5Wf021NqApdC63XF6dUDRrubAeKIloWKS0VJZkMAV8usGEes+IMSD1WDjncwIt/s6BuqS8IdpzlueU65+NfciF55l5Uv2qNrv9Eg3oW1z/iK/km0YH6wWPZ/5/w+bS30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3RIta4S; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ef45a6d9dfso295022585a.0
        for <stable@vger.kernel.org>; Sat, 02 May 2026 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777715111; x=1778319911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQaOSTmRG8h+Q60TQrv4Ps1DXYna/JcS4+Wi1K4sznA=;
        b=G3RIta4SbEe728iWpoGF26UeJ4CJffYNebybl7tV4EcJGxvlXG2CU0ykufo1lv4RHS
         xqZdNXiMMYrATW/wfKUkM7dG5YJNeizCgssMicfmz4VKBxO/Nna0c0LWRHhSzNA36G2A
         a8KvKAO4ezzGiymHhiK+0bEzQlZqqHv+WdsX6wzLhdGM0rSAKBMjcewupv/C/6aCwT/A
         YzASZcMxQ9B3KAfzvzh49Q7Ar1iDbpZGAhGlVJYNSQ32i2WTNjv97/D7nIn355VDUrs1
         wuudXFa54UkyDHQz9pvagFbvkWLvCxMPeOBSJRBZCb7BIKGu712rhENsmz6EAX8M14m0
         W58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777715111; x=1778319911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQaOSTmRG8h+Q60TQrv4Ps1DXYna/JcS4+Wi1K4sznA=;
        b=ks3N4UTZXl8+3Exy94QrPwt2grleRvCIJLRKSghGJvcbyXm5Ka4ESQ1+csct1eBlS5
         7wHYE81rYMPkI4weE1l+E8Zw0ePO65ptAz6HXo06J+Qq6nfgBtasGRJfsy5kOg9lQ6ln
         Bj63PkLqabMQQQz4boQZboHYw8Nqr8WBjaRtLGRhkXYJbV3Yns3ANAk56+3pYzUQILbt
         rXSuwQ0JSLvHIMpxziLHw5lytcx51wM+HKl9i0VDpULuxbkdBZRoUwNu7iC0vbqUwSHG
         RMA8YbQl+su938o0HeRiEk8GV078/w0naj6TaBEGYdEPlyfMwkkYdOAN4k9qL4vVKfDG
         xtjg==
X-Forwarded-Encrypted: i=1; AFNElJ9eRO3aQdKzOOzAgPechKAJlybAyLMD59VJYljMEGIgroDDXcrzT56KS2D/IatnC9apGcjwv14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyimMcpC0uieh8hNYhUBvQPDFLJpx+s+4F6waXNDagOO9sqqAOI
	G/fp8j3HJLIUdw1hoAazOv5K0Vzl4zQo/nYVdtYHmKK00xIAYnqFO0WD
X-Gm-Gg: AeBDietqc2nauR6hyG5+Fw5lBp20Y8IbIJKrYmtORmZVpzD24zgZt4qhvTHzlIbh42E
	V4KZ0Q/Fxr2Z54cg8dPZ9CBeyybH3GNO9egcULCYyUuD7Lo76Yfm29y98DzKkQFPrLpUKSzfhnc
	rlbkzchbH3drGxTWfgkCgvocbfGk2oC6vO2qL1noKj7OG2wp1Ly9FhzMx0NbzvVWjpeWcK+GKHH
	dyoAFyrQu3pTeujfwBLMVCBotJaMDAglkwwkNQPTJMDE72TgGOPCAx6i+B0qH1lzRfpg1STfWvq
	9HFJxV8kgSSOeCn/tfxIi+b3vsA28rHwF/JNQYs283Y11rtO30vLhWxiqHkGTh70YxXILgfdeAX
	btEoD+BGQIa+JPZjT5+Z2SsSud4Vii16mBbtldg370ZpOlGTYd+MxBGbWJbXa66oHUdj2yp6RYd
	5nR9wG7oOWeQJr7Zz2BhPZpN2RLN0JeLFJStv2eRLUA8OJ6I+0CeFgkJ4AHQCp59GqBLA=
X-Received: by 2002:a05:620a:371a:b0:8ee:7dcf:ac75 with SMTP id af79cd13be357-8fd15dd0b63mr450795785a.18.1777715110658;
        Sat, 02 May 2026 02:45:10 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm475713985a.36.2026.05.02.02.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 02:45:10 -0700 (PDT)
Date: Sat, 2 May 2026 05:45:08 -0400
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: eth: fbnic: Fix addr validation in pcs write
Message-ID: <afXHpPPKhayawr9x@PF5YBGDS.localdomain>
References: <20260429150049.1643-1-mike.marciniszyn@gmail.com>
 <20260501134636.GE15617@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501134636.GE15617@horms.kernel.org>
X-Rspamd-Queue-Id: A6E0A4B18D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242589-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PF5YBGDS.localdomain:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, May 01, 2026 at 02:46:36PM +0100, Simon Horman wrote:
> On Wed, Apr 29, 2026 at 11:00:49AM -0400, mike.marciniszyn@gmail.com wrote:
> > From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> >
> > This patch contains a fix for addr validation in fbnic_mdio_write_pcs().
>
> Hi Mike,
>
> I think this warrants a bit more explanation: Why should addr 2 be
> accepted? What happens from a user-perspective when it is not?
>

The DW IP part has two distinct PCS address ranges cooresponding
to the C45 PCS registers.

The shim translates the PCS mmd/addr/regno into specific CSR writes
to one of two zero-relative addr values into one of those two
ranges.

This patch fixes a one off in the test that could allow an invalid
CSR write if an addr == 2 was called.

I can update the commit message to reflect the above?

Mike

