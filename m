Return-Path: <stable+bounces-249605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBJaAORxDGpKhgUAu9opvQ
	(envelope-from <stable+bounces-249605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:21:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEAF5806E5
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B10430E60BB
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D134028E6;
	Tue, 19 May 2026 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CppU7T38"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA24028C8
	for <stable@vger.kernel.org>; Tue, 19 May 2026 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199989; cv=none; b=bsYCx2eiZL7jvaFMiVSi0Mf8a76Po2vvWrAs4ogZTknGwKkw8c0wMR5siPbiwohCIQ5FSv7RZNqh7ZW2BUbnsByvVCW/j6SDlLTRNIpH+uCZrz9OpdsOGmd/N32yxgT2QBCGGH4pqYFOBQe2NUzS3Zn6EMdz8vjoY4Y05sfQbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199989; c=relaxed/simple;
	bh=OCcqg1BGOlEZ4cGMnfxKFeTqP9wIJtR2x1vwkwbYYcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XClpSEpxO9jauqIvsGvICTrdQCSse9MQV9Ta/9hj0de7yFmzxn96gphSVpacefeGA/2v6dF1OX7ZfW3hLunuoDC26ik3waM4W6mpkn7S4KQV4wPaPDPQsq2oSS2zsX8KXN1ffbYFmAiob8LezpoUUpfYQdwiKu+ocUzHYyWbFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=CppU7T38; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b6ea7716bfso46217286d6.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779199987; x=1779804787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0sGtfsMt+NWWfWgP1GuryhPZenTz+43P15Viqh/cz5I=;
        b=CppU7T38mmEoWp84ksK0BtMrb274d8HsLH1m5dbqycunnZcChcQxhuB4/PqteH/s0W
         bAs8FTT3DSw8AEEUTcmykUV1iXd/MoQIwV2m7SblaswCJZETFsHg7PnwF0zMdrrv8dzU
         dcyRBdGfCKVl/YyxHSZBZ/oYRN2d5EQfv51wBFbiTAsmCdZWgJLo7ZnzH6tbl/PYXPRZ
         xpagnbRWo0rPcxQfzAqK13Z8JIDvQueWzzyyls1RZXn8NZA1q4jdCFW6mcCkLjKJruXD
         qxK+Y94GyJTG4eYoQfuL191zXCvdrq4I6xq3VNTyvz4lT5KwSRzL1Yc3b4BmTdgAoArk
         Q5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199987; x=1779804787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sGtfsMt+NWWfWgP1GuryhPZenTz+43P15Viqh/cz5I=;
        b=OLSeLRPEA43UbDvyGQTynAnmyy9XB+MWKmb1Qr3tjwqidcpnf7Wz77I3CxAKpLjOS8
         57UL+ch+HzRqY2DaaaF+yLR+g3EW6bW2MIGewF9GvaNVgI60pka6BOQBl42h8YZzHNel
         KNM3oADopKbAJoFkQz4x9kfV1AR9c6Fh+uFmjHhz8CNuFZoL6T5joUs8c2RBmPGJYhLz
         QeeILrirU1IUA6csHPZGjeEhUfSQQ1moG5lhzkJkgJlclTWsdAuqp+glwCP2PVcohaSA
         /cNxLPG+6G97b917DL8Wwq9c0aJE3EB0O8O1V+a8g89vkJW0HnaYu2JckoKjyd+UWH4Z
         ccJw==
X-Forwarded-Encrypted: i=1; AFNElJ8+SUfprgHPGaKcOcg+y0R2I5bujbRdMrPZBZyFXG6LaNVuzgKQkaubN6TEnf/FAnbPjW1v35g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmaojLWQtixnYP1wRWJr3J3WqMekupM9CUflANiGRsSK0kiL2
	VMJUjfsgC8AzKm3W1jTOdyyoujnyXvCly6b4Mx7z4QPxuigvDUdL5m6//LAY4BSGVAc=
X-Gm-Gg: Acq92OH0q5GrNKrQqA1/cbxyUqxtlJLBq+2tq/Iw1+kx2uBRtSSLFxRRzS/gmRVc1OI
	FPvqbKo05r33s0bqxcgac0flQPcw2Gj3PZEi/7kInKg/sy84O5kEqtDSfF9dm2rceESnQOqono1
	B5SKAAo5FMWBDSRMOzQSj4vXs9JqQkVSvNuZiNth3fWzA0nfsBorxUUkmZBF6o7o+fS/4boqlcc
	2EEqZFR82X+Vqph906ar76AhfEFpiuJNzKiMaBao+BwnMWeGh/10dkuDsnh4VJqhQd0OmbmJD+C
	5kGRxDSZBCsE9J5xPXL0N3ECZGpqI5wzvSCbDlInoeZP3fBsBbkYLCvfaWQFpcSlsrhHSsTrjVl
	pwMmjj7u1tg/zZuSzQbsRuuzQXZnCU+AzBxzfOXMKy6APuyDMBfcYCLOM9rj2vPNIGVaianbhKD
	owjWoEjlWOG/epuNVrQEymZ2myw0B06DcZe7oLhy4nfViRQtS/mQU=
X-Received: by 2002:a05:6214:590a:b0:8ae:5fcc:8069 with SMTP id 6a1803df08f44-8ca0f62bc61mr376033696d6.22.1779199986811;
        Tue, 19 May 2026 07:13:06 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3608c424sm92013666d6.3.2026.05.19.07.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:13:06 -0700 (PDT)
Date: Tue, 19 May 2026 14:13:05 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] kho: fix order calculation for kho_unpreserve_pages()
Message-ID: <agxv3w--GPrc85De@plex>
References: <20260519133332.2498092-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519133332.2498092-1-pratyush@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[soleen.com,reject];
	R_DKIM_ALLOW(-0.20)[soleen.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249605-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[soleen.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pasha.tatashin@soleen.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[soleen.com:email,soleen.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6CEAF5806E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05-19 15:33, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Commit 91e74fa8b1bc ("kho: make sure preservations do not span multiple
> NUMA nodes") made sure preservations from kho_preserve_pages() do not
> span multiple NUMA nodes. If they do, the order is reduced and tried
> again.
> 
> The same logic was not implemented for kho_unpreserve_pages(). This can
> result in unpreserve calculating a different order than preserve, and
> thus not actually unpreserving the pages.
> 
> Fix this by moving the order calculation logic to
> __kho_preserve_pages_order() and use it from both preserve and
> unpreserve paths.
> 
> Move __kho_unpreserve() down to avoid having a forward declaration. Its
> users are further down in the file anyway. Also, it results in grouping
> for all the page-level preservation and unpreservation functions. This
> unfortunately makes the diff hard to read, but the main change in
> __kho_unpreserve() is to call __kho_preserve_pages_order() instead of
> open-coding the order calculation.
> 
> Fixes: 91e74fa8b1bc ("kho: make sure preservations do not span multiple NUMA nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

Pasha

