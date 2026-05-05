Return-Path: <stable+bounces-244210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA5eIJcT+mlRJAMAu9opvQ
	(envelope-from <stable+bounces-244210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:58:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB034D0C03
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2823A3025145
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E48648A2D2;
	Tue,  5 May 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="FCkwxhuy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E4361DD0
	for <stable@vger.kernel.org>; Tue,  5 May 2026 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996329; cv=none; b=rtxPcd10LXitxO7nBoTKtvE9du5LZjnWmjo5cFeDXgqKcgVK9UM2hb+M39k+ThIf45mPcbhZ1HAaHAysTR3EGJhJyNgFlDI3cLdSv0JeW13AZzZP9PQkZBthadFt50G8jjJ1W5TaqlXow+4G4zcBONtcGQHumWrXQ5K0UwqA884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996329; c=relaxed/simple;
	bh=cOFYjOWZPOQi4PeWsU2WykKvgDAIhMD6gzzfUil46v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVsOYCHyAr5JXardKz0LfTvQKj6EXIfrmv2xsSBrBeZ+HTNsAG1VPmp4BjqrT2xVqhhKbkhAy4bq7+6Od7Qk97zo8fa60KLRqtL1n9iL86F1OXGddCee0Y/C3WHA57A3v5b1PNQBsEHqGc6zeDh25oNAtx3jVOOADb3YatOnFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=FCkwxhuy; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8eb5ad01402so581203585a.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777996327; x=1778601127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wLO+oFX+VEmAp0NkxBY3iUrTp6rCqh1ePNe0pTi1JJ0=;
        b=FCkwxhuyOTsyZB6EZjVzRU0BmvmoxUPAr5LwbgHicm0oMbEKdq9TPRTBsXxiZewx0N
         UbiLEAcGyNq1sM4VEKbEn2quj+RUoLcPZT43oLCo9VHTA6vpjo6f7TVdeN5b98CYmg8N
         tsXYuw7hsieKCRu9bLSHR7vaHD+vVUz0M96XcZdcxRlUEoABn1DOew8YXpYShvSbrdTo
         fTBtzmIpQ6MK+VL8aFBu3CVJRxxhrgQJDtQeeX/qGQiToxm5v/AJNFh/XANgEia8DFPI
         3UJnJhXqV7GMnRkdw5EYphSI5ioJYyfqUJZHiUZCN2+SrsctLLTszrlnPXqwFBI9cyvu
         paow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996327; x=1778601127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLO+oFX+VEmAp0NkxBY3iUrTp6rCqh1ePNe0pTi1JJ0=;
        b=i3ueREhwg+KfsnqdPODbLDFxUtCmIDSqVJUiEYiFl/ln0jfiM9rMPdvJ2fU2npEBkU
         1QDzhSNcs4oCSw9kVRIbAuNY3z8fI+1rJDLum1RK73Xi0ClmEZ3Xsse41VBuQEKTXMgY
         YeGEJmTGOttuSS73Di5gaCfxgXZ7PbIf7tKQ4Dcis96OJ8rAQ9TKy+YxNEXU6UuoZRWh
         NvIT3LJ4peE+EfqBsQAt2pDS/QxrUkVhbVfqbPGYzuSINO55rLIqIO/i/pbjmGjOJfyW
         JI9OaLrCdJ/Km1AunUYXE9oF3tmCcoQunSrUtmIsmupcW7bcFjQCE3CAG51uoOekJY1r
         qVGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Sq7cInQ2wV0qLYPzD2HIl/up0kz03mD93h5m9YNt8rp5PZHoqz83J2ww3Egdz0JzBQ8XXDnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6fLbQOl1JxGSnSjCMFKksDWlIp4cvhJvDHvcuVlclNSJ/ptWw
	wrddN/rnS53PJCvSx9QXZnlK21C5dtG8kWSrS7bVqjgs/8DvD7q6yex2MXEUIxMAYso=
X-Gm-Gg: AeBDievEfU44SLED0locMwKKVtsmU44VWTqQovxFWpE8N15UpWOLubSaj6bUCeWlmZJ
	U27GG12uvgGHUWLmXOpYQn8wF8WkkKz2+Zjr+8VpYkQuq4sfa+PF/p4EBeABGvbfXZlWSnWEqUu
	J+o6bSfwmp9ULxadRwN295qb5HMt3Lv5mQlmJWVfnavyRSNKR8+gc9RfHRAy8bQSrswoFDwvQfn
	Vt/NHRdQDn4It9eHl9d6GEReWn5yh4TjEHXuDqm9Ec1/uryMaYlu9QYV7M3AWbEAeiEXRaEN45n
	GRpcnc6zU4eV7RFnscZL/ezgdhkeDM6teJE8rWJjxOOuCSBgCsD7duGZSm4/PnROdDhb8yTfCj6
	RfdKmE/oi9fb4NV5r0bi2geIu0B3eKJKaeV3ueh4w+Z4NUA+d7dW9HghhT6XfDlTikdqJU4uc6R
	AOYlnfLdKgViKhrt1bPM56BGW1DnUq1Yp6R3GwZWMZSoicb8UJipdEMFKgyd5zb1loILtDkWwJ
X-Received: by 2002:a05:620a:1981:b0:8f8:5905:8291 with SMTP id af79cd13be357-902e4cbc8c7mr616480185a.47.1777996326739;
        Tue, 05 May 2026 08:52:06 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91fb3bsm1353612585a.41.2026.05.05.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:52:06 -0700 (PDT)
Date: Tue, 5 May 2026 15:52:05 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>, Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] memfd: deny writeable mappings when implying SEAL_WRITE
Message-ID: <afoSC5KUhNwfyWBT@plex>
References: <20260505133922.797635-1-pratyush@kernel.org>
 <177799542165.635180.17809433268620237886.b4-ty@soleen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177799542165.635180.17809433268620237886.b4-ty@soleen.com>
X-Rspamd-Queue-Id: 0DB034D0C03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[soleen.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[soleen.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[soleen.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244210-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pasha.tatashin@soleen.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,soleen.com:dkim,soleen.com:email]

On 05-05 15:37, Pasha Tatashin wrote:
> 
> On Tue, 05 May 2026 15:39:20 +0200, Pratyush Yadav wrote:
> > When SEAL_EXEC is added, SEAL_WRITE is implied to make W^X. But the
> > implied seal is set after the check that makes sure the memfd can not
> > have any writable mappings. This means one can use SEAL_EXEC to apply
> > SEAL_WRITE while having writeable mappings.
> > 
> > This breaks the contract that SEAL_WRITE provides and can be used by an
> > attacker to pass a memfd that appears to be write sealed but can still
> > be modified arbitrarily.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] memfd: deny writeable mappings when implying SEAL_WRITE
>       commit: 73f496662a9848021e75742a69a3239ea850c3ee

^^^
Please ignore, this should be Applied to MM tree.

Pasha

> 
> Best regards,
> -- 
> Pasha Tatashin <pasha.tatashin@soleen.com>
> 

