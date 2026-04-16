Return-Path: <stable+bounces-238368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH7fITZT4Wl5rwAAu9opvQ
	(envelope-from <stable+bounces-238368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 23:23:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28738414E58
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 23:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 067AF3028343
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 21:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CE434B66F;
	Thu, 16 Apr 2026 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao1i69/e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A8E198A17;
	Thu, 16 Apr 2026 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776374510; cv=none; b=taAn8CA+xDLpsndcYY4ocpnYHQcRK+NyvBZU3+beID2c6C3Qsw8JQ4636X2O9bhqRwjDVPfZ2pTgUYhR/i+J0bJQw+eBGlRkWjojpD7AjmFHqT7h6O1SvSMs2MW/mtwVq3eog2luw/GXTwizoU9uemhwkWwDOEHKpPcoth5Oqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776374510; c=relaxed/simple;
	bh=0A66zo/Lfk4qleLToQJ1y9UBbagG08xg62HQhV2NSh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sW2MnF94XX/IvE2RhTvOXT6t2EHHa34lhG7pXsQbI21obacVrelCe3zDQ57l+lHQgC0zqG+XgKnnh2E1s7NZHeWTCV9Urs2J5AyYGjK1pd4ir9YqWhqiSrtwE0yFpExHLE6J+dIO5PN4RMzUhgnrABEXGDwuNoZaqWNXxrHatHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao1i69/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B78EC2BCAF;
	Thu, 16 Apr 2026 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776374510;
	bh=0A66zo/Lfk4qleLToQJ1y9UBbagG08xg62HQhV2NSh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ao1i69/eS+dMjRfpuMEDbs5RypkrgKgwNwXDU+bNO8B6w4O3pUs2lBVS3YosBcUBQ
	 Z/aIUnWkG0mrLOFmvoX088hXa4k4Ja2PHxEAtAns5pLIH0MzuuZ18xYZWbT1XwuxEW
	 kvTd28xoA2lNfMFy3kOFyVGMzFbsKFFVo6c6p9B9ngsSHsLk5vFrdPeJ8K9LVT7JbS
	 7cW44/ssidio+fdYUOSzdvP508Fy0fDMdCU5VPEGndM4IQildNTEbW9HUPvbT+aWf+
	 satzbKv2sBMCmOP4Jt4vEvV/uCocr++HMG7cIDNgn37ermIV2Se2R2IJTELLwiUbFl
	 gS5yELI6Hcxzg==
From: Nathan Chancellor <nathan@kernel.org>
To: David Howells <dhowells@redhat.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org
In-Reply-To: <20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org>
References: <20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org>
Subject: Re: [PATCH] extract-cert: Wrap key_pass with '#ifdef
 USE_PKCS11_ENGINE'
Message-Id: <177637450781.4150069.540537972769992997.b4-ty@b4>
Date: Thu, 16 Apr 2026 14:21:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238368-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28738414E58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 18:19:15 -0700, Nathan Chancellor wrote:
> A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
> in clang under a new subwarning, -Wunused-but-set-global, points out an
> unused static global variable in certs/extract-cert.c:
> 
>   certs/extract-cert.c:46:20: error: variable 'key_pass' set but not used [-Werror,-Wunused-but-set-global]
>      46 | static const char *key_pass;
>         |                    ^
> 
> [...]

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git clang-fixes

Thanks!

[1/1] extract-cert: Wrap key_pass with '#ifdef USE_PKCS11_ENGINE'
      https://git.kernel.org/nathan/c/4f96b7c68a990

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted.

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


