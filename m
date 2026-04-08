Return-Path: <stable+bounces-235279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Pg2Iia61mnLHggAu9opvQ
	(envelope-from <stable+bounces-235279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 22:27:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB33A3C3C70
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 22:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6C3A309B035
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 20:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3464E3914F0;
	Wed,  8 Apr 2026 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+4CDHXV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D096339183D
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679920; cv=none; b=CIgMNJHEXQKzA55tOxmtGl/9ah7d7xGP9HAxCc4fh4LX46tzfcqFHNolDaNYX3CKBfcOMXtIaIULHXwhxDWQOW9OeT5MrxBog9SQEIGHfTqzFfZxxxkp5TCwNI6BPCYkj51K3Ea5UPKxFqLE5yPPmnQZRZn8SD26IG9BkR6oGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679920; c=relaxed/simple;
	bh=YK2ErFGtqJmjNXRFUKyoD+PTGXRuF4JLe0eoAfWTn3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EANSSR8xAIgJ8+94Qe/zam+yRWcufw8cAVtdVgTRZTgO+C0TJjWm24Jf62t+Uyejkk1PwHLL+Njw4lW9YWm28oneQXeIOzFF0ybPOjVUYxIld8GLgy/hwQdGpMcFRpQ0u1Ck1o5PACrrVT3xN7oqV8Itnlx8tOWIG08PN7CBOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h+4CDHXV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82cef263bedso113471b3a.0
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775679918; x=1776284718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtez7uO2X5FjsGHqGis7qBChcDlylFjTSAlBvJbABwk=;
        b=h+4CDHXVKB5TtWWN1DQ4w19egGCrJEuQ7L2O729FNN6ypKu8RYyLM31dYGeETYo73t
         9kUT/25ZSaplj+XAKaDnwuRMSaH11T+IrISdl4sCB/Rc29bS8EMC5uq230Y6jyErv4nZ
         5EpYLz9phFMW6iXjY49RUCn6Fr++JRhzC0LeoBiZVY5LcvN+wQ8pE6I76QpP06vzYn/A
         /AxcW213j6RVOpULzBq9OaZNSK+NFtP3OBZoYz0XLnpYq1QfhZaHbAWHtPSfGL6Z5tvN
         qZYtwbk3D3dDQDDuakz7IwSijDpLnTTDhA0N4oDKUJ9ylmnDaeyH5V9yu2GQ8iZPimPY
         S7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679918; x=1776284718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtez7uO2X5FjsGHqGis7qBChcDlylFjTSAlBvJbABwk=;
        b=KK4J7Ja3QNHILsuEw4XGI07BHDRNZxZMYWnslBaYfwEqyWatMGXEFtTq+NyLVKltFc
         1pa8GuStgumHWBHmCOdQ0Ws3+7Vs6VYa8eayJ+Wmn6kWxuTKUx3WsVuqvYkeq4u0D+Rw
         A7xVND8j/4mmmxykbhcVtnSJlyil9lM9KEYWNrBF8ci5nysHYijX5fCW5XmOOlgMmXth
         dpNgGPZEsex1SmJ8+hyIMW56J+jikPioJD7PAFlz2HVLF2hhb9aCVo3frsM0sDUhQYyq
         PGzcP3Xhao3fgelnjPhM9DCDdYh/wXXgtiUjK0cXv+OytOIITc6QkEA8hRX4zrSImDeX
         Ofvw==
X-Forwarded-Encrypted: i=1; AJvYcCW7ScGiJ4CKmGkMHSm7yyqYQzWCGO6ca/OK79mXxly3Qh+MdWF4hPRWWSgkw69+6VIr7k3OfS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkrMf9Y72os4Y0k4GCB9tyb/6ltT16/+y0KL8MOHT+0pX8017q
	phtvWslG8V72zoz/l4ISiv11mpfLtPlcllZRy7RAQkzs3KBCfGd0A2pc/gIsLdLjNg==
X-Gm-Gg: AeBDiesna/aRqhlCC71EkXvlGW705DJaJJaziHBCDLV24NMUKe54MV3yx9FNmzdC4st
	KU4tu6sgwCPhu2aSts+BnKClVwqer947N/lO4isvyb6gVyzLBwOhlmD9FLCVscFa8nyolU6ii/u
	Tb3ynZVrvgTVszhWP12gR1VkEL6e9XPxp17dAEWtHXWVW9xPcOjOuY0unZxRw9mFwLrsWpAloep
	CPNQJFA0rHR99qAEYhzi5Rye6zj94viypLiiaf17Y/s5UqwEQZFEpowAoMAPRx7JYhmx7hpgee8
	DA+8K9z9yTOS2AOCFLyZthKWoMpCaVKQxfrY+4NsLILLVv+2ouV8dK71k7WAotP6oW/RbDoZO73
	Vy4c6/ecKzpCRHPx5biSlzLVSgHVczk0XYa/JyrMiCbK1koqdus8AevFs1gCCxRE/BCS+UNYNB0
	MGidVDEuuDfR27LFc6RdtVp7DyBzbHwewgG7zY6FyErGA8lfvQ5vEaoqf3X7ppwDVn
X-Received: by 2002:a05:7022:40b:b0:12a:8ea4:252 with SMTP id a92af1059eb24-12c28b7f511mr541759c88.4.1775679917525;
        Wed, 08 Apr 2026 13:25:17 -0700 (PDT)
Received: from google.com (78.93.125.34.bc.googleusercontent.com. [34.125.93.78])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bfea5f860sm21165384c88.2.2026.04.08.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:25:16 -0700 (PDT)
Date: Wed, 8 Apr 2026 20:25:12 +0000
From: Nick Desaulniers <ndesaulniers@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: David Howells <dhowells@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] extract-cert: Wrap key_pass with '#ifdef
 USE_PKCS11_ENGINE'
Message-ID: <ada5jlwkMYrtfRHv@google.com>
References: <20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235279-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ndesaulniers@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB33A3C3C70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 06:19:15PM -0700, Nathan Chancellor wrote:
> A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
> in clang under a new subwarning, -Wunused-but-set-global, points out an
> unused static global variable in certs/extract-cert.c:
> 
>   certs/extract-cert.c:46:20: error: variable 'key_pass' set but not used [-Werror,-Wunused-but-set-global]
>      46 | static const char *key_pass;
>         |                    ^
> 
> After commit 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider
> for OPENSSL MAJOR >= 3"), key_pass is only used with the OpenSSL engine
> API, not the new provider API. Wrap key_pass's declaration and
> assignment with '#ifdef USE_PKCS11_ENGINE' so that it is only included
> with its use to clear up the warning. While this is a little uglier than
> just marking key_pass with the unused attribute, this will make it
> easier to clean up all code associated with the use of the engine API if
> it were ever removed in the future. While in the area, use a tab for
> the key_pass assignment line to match the rest of the file.
> 
> Cc: stable@vger.kernel.org
> Fixes: 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> I am taking a fix for a similar warning in modpost through the kbuild
> tree so I don't mind picking this up with an appropriate Ack or it can
> just go through the keyring tree, does not matter to me.
> ---
>  certs/extract-cert.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/certs/extract-cert.c b/certs/extract-cert.c
> index 7d6d468ed612..54ecd1024274 100644
> --- a/certs/extract-cert.c
> +++ b/certs/extract-cert.c
> @@ -43,7 +43,9 @@ void format(void)
>  	exit(2);
>  }
>  
> +#ifdef USE_PKCS11_ENGINE
>  static const char *key_pass;
> +#endif
>  static BIO *wb;
>  static char *cert_dst;
>  static bool verbose;
> @@ -135,7 +137,9 @@ int main(int argc, char **argv)
>  	if (verbose_env && strchr(verbose_env, '1'))
>  		verbose = true;
>  
> -        key_pass = getenv("KBUILD_SIGN_PIN");
> +#ifdef USE_PKCS11_ENGINE
> +	key_pass = getenv("KBUILD_SIGN_PIN");
> +#endif
>  
>  	if (argc != 3)
>  		format();
> 
> ---
> base-commit: d2a43e7f89da55d6f0f96aaadaa243f35557291e
> change-id: 20260325-certs-extract-cert-key_pass-unused-but-set-global-23007ecfadf9
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 

