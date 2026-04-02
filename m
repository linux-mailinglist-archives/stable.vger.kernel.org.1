Return-Path: <stable+bounces-233110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MwfLvfRzmnKqQYAu9opvQ
	(envelope-from <stable+bounces-233110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:30:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8533538DFF2
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66DFB301A325
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 20:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0123F26A08F;
	Thu,  2 Apr 2026 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gun54JpY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1A235C01
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161842; cv=none; b=IHbtvzziMgSGElaS2HofYKSSOAajjK0v8WA1ywvYAqRZDUSpUa0qHpcP3F+1OtE1lKB5V0ktOwrqby34O1LOpyAwHHsjfXUQ9YxU3frwenAqRJKCwJ477WEq7br7tbJNK2gp6Jqgp5ZalG6WE/JKSaGSxo/It26EbsXHIVeqx2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161842; c=relaxed/simple;
	bh=gdFmDy5c0jrATO0ZaV40UIMaul6zbEjW48AU2qrMLIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILRigiwcWctfmMgIL9mzjbu96543+JxQ1mY8/f0Sbhx+iQPHlFlSKRqEGjvvWZ/5cA72Y8hdWaeYWhO7ORGzyDJFcfFeUPazfRm7W/cQymFEd7fmMw2mkFFnycSpN64YM7kfkAOYdk31e43zOYIUwMXmmX9RkUX5QcMYA+Y9a9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gun54JpY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so801385f8f.3
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 13:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775161839; x=1775766639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZoZIuXbaOTq6CxvkGG5/h8HZq/8fo5h4kB+aDed2D4U=;
        b=Gun54JpYKF0b2nRJUOZNr6+40+G04rFghB8wKGbqxG+erbrDmwxNYrnFtqpn2hE2ZY
         n+y+NJwdU1kdgj6mjFk1oRAypeE0J5u//ItEhG/zApufdyQoHCZZ4qsmuMBKF6MqfFor
         GkybrLhznf9bx5f3TY5IQfLSjmoKH3JCU/fVGMxi8NlbZz4JoiCVSOOCiTQYC8ByXdrl
         y9bYxt9tGz6cxK0ujBInXj5sPkHZLCVTbtrw+O7uQH+nht5tZ2pIwvZqXXaU2MJsu6Ck
         hwnAES2uRHKeePXZPlFZWpCcmZlFkBKbGKOs+joDSrFu1qZiX+Z6CRDclvF5sst3B24t
         8nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161839; x=1775766639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoZIuXbaOTq6CxvkGG5/h8HZq/8fo5h4kB+aDed2D4U=;
        b=Ni1qTjlQ3T+q859fyiHy0qh8uvvR4v08vjgo4iu+Ax1gPMbiPFPYU9uqRXpRbzaPky
         YiKl0hMcovLw/teSfyKr+PsZAo10zA79cRtyum/WZ0thIaasUJyFINJLZeZ4ORyQDAMx
         bjAystjFUEtTYACy3z11y1v8vQyBMJFOZVxduma9Vk2d48dTAlIp+L1jEfugc/M6cLjr
         KHGkYKHLDr2Lp0yOXB8nB2QRNUCADf0+lzptmDO5dXTRFn2BMd1A3nO7dmaBTGN9AZJR
         7rtP7P8lUDv3slQk7oY6lwi/Li8JcbvZgBv/b6ZAFe23QyX5ONcbl+C4mugFoSJZHVtQ
         M2Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWJpjOYjHN0OG/d8v8fltJHfOmAj1MBDpGphxODsi8B5Cy/ZcakeE+X8ajFjlKUac5OXwb+kCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT1VwOHHAlvmK0GfKifKOaTQh+cl4qm1PmR61JNSNiRnOPeO+t
	5IHvgPUM8+rjqziJAXdHQXjEVa7+sxWNnnVrd60ft9xu+8VSZHIZF1Bt
X-Gm-Gg: AeBDies7JouqP+Fx5m/mFFoAOYc/x2fqvRIQ4+WAr+OjU49oYK4DhH1FhQ2him7+pjl
	UCGmzruu+B6WzZk+K+M4EQwjZM3S5X8JJQDxZKj9oU0vx8cHp7VySwfJ3avpwhHapC6TsTfU2AX
	NrOA04a/7+J5ET7G+bMfixQLGy9sHfRwqQJiqzutaErGScuwJd+r/McdxD4xgq9Jzi2km1TstKl
	ugUyed8IxH2Ed3x6o6uUHHt/8A6bRYexyKfukH+3tEQv1lz/f77vICVJZsJSrt7/5qjGJ+qn7c5
	PhAE8FjQgTYRDBC026L6ZKVX/gsxPLdaNS2GFTscRH4fO8wAk76U1ceJkQ3+vomZHIpQU9+WWRX
	HBHnhWiQn15TxIuPbOOu6tQLHGQV2PfsMLSxiQqHDw5/si7R9m96vHaNcGBdt9IQn3glW685JY9
	Jkjd1E0ECgNlLdhbvhZXSve+2Vk1pwlvO7bztwlq0++SW6ScP+
X-Received: by 2002:a05:6000:18a9:b0:43b:9227:bc6e with SMTP id ffacd0b85a97d-43d292e1935mr700218f8f.24.1775161838691;
        Thu, 02 Apr 2026 13:30:38 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f73sm11320543f8f.8.2026.04.02.13.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:30:38 -0700 (PDT)
Date: Thu, 2 Apr 2026 22:30:36 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/5] selftests/landlock: Fix snprintf truncation
 checks in audit helpers
Message-ID: <20260402.554667d35637@gnoack.org>
References: <20260402192608.1458252-1-mic@digikod.net>
 <20260402192608.1458252-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402192608.1458252-2-mic@digikod.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233110-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,gmail.com,maowtm.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[digikod.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gnoack.org:mid]
X-Rspamd-Queue-Id: 8533538DFF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 09:26:02PM +0200, Mickaël Salaün wrote:
> snprintf() returns the number of characters that would have been
> written, excluding the terminating NUL byte.  When the output is
> truncated, this return value equals or exceeds the buffer size.  Fix
> matches_log_domain_allocated() and matches_log_domain_deallocated() to
> detect truncation with ">=" instead of ">".
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Reviewed-by: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
> - New patch (split from the drain fix).
> ---
>  tools/testing/selftests/landlock/audit.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index 44eb433e9666..1049a0582af5 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -309,7 +309,7 @@ static int __maybe_unused matches_log_domain_allocated(int audit_fd, pid_t pid,
>  
>  	log_match_len =
>  		snprintf(log_match, sizeof(log_match), log_template, pid);
> -	if (log_match_len > sizeof(log_match))
> +	if (log_match_len >= sizeof(log_match))
>  		return -E2BIG;
>  
>  	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
> @@ -326,7 +326,7 @@ static int __maybe_unused matches_log_domain_deallocated(
>  
>  	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
>  				 num_denials);
> -	if (log_match_len > sizeof(log_match))
> +	if (log_match_len >= sizeof(log_match))
>  		return -E2BIG;
>  
>  	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

(I noticed the Reviewed-by tag was already there, re-sending to
confirm that this also applies to this subset of the original patch)

–Günther

