Return-Path: <stable+bounces-214420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEUzINxThGkx2gMAu9opvQ
	(envelope-from <stable+bounces-214420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:25:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C063EFDDD
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF7363011C47
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 08:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BA6360756;
	Thu,  5 Feb 2026 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="UH2CMC/s"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D19D35CB76;
	Thu,  5 Feb 2026 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279871; cv=none; b=Z5ew5Y4q00Y6CtaPNJND2ig44N5DKaGaaMuyn9GLVPqkf8XB5ZHFZOvjlvxeRYL0ULyQkjYMq5bzEGxKn2JRii08XEwkfsSpoZM+5HLZ4+gaD0KKtTAHBnpexTJQnqI/ohyJfs+L/aROoBXlWp7t7pNEHvk4kzK5JdYvPKyn+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279871; c=relaxed/simple;
	bh=ZslEfIVsJ2ZMf1tlwVpt40qbcFCGyYYz+5CIZD1cohU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHya9UB2WqFCfX9vSV7DuaSXwhEA2c6C5IGHv6ox1NtjFDWao1tKYidDEcMkhdnLxwHLHCdBjdYdwhoUS4IqaVWErCg6/b2qTUL1PaUJY0ksmA8/mYaxb6dXO4jJByvbPAOtdFHtGcwSuofBmKEzfT8qHaX8muC700ISEqS0nIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=UH2CMC/s; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 4B8E21FAC3;
	Thu,  5 Feb 2026 09:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1770279868;
	bh=yFvZXiBB5Rv3lI6jZ4whGbgflDkRRD5RhDYA+POoZ4w=; h=From:To:Subject;
	b=UH2CMC/sCnmiVM2i8rLL9BKtbazFzbSb8V2pKjXE6ZvuwzqOyjD+HMQoUH5I18F0V
	 Aevx9FGxNJe7sBtcx/Ld+uXLv0v6ngxqW5mDybiV6T4d1S6YBgxlR4AJvG4DMed/TF
	 8jhMskD7LPjWBjcNF1ipAu1XEm23LbF6zIZ/QrwtRJ60Av7KEMYhVFZmDmm/nqRqZm
	 cS4upqD+NKHhXS5ikd1/4difXJsHhLYKFkO74AHeAuYxQbaNXi7rxi7fe4sadCj5qD
	 Bj0zKbRsDP/X/JqtqRDTnyw83yWd7CV0MNTOvB5OaMM7PhIZZ7FzvkkcK9fEPbfVTB
	 gqbW0Kc62sNVg==
Date: Thu, 5 Feb 2026 09:24:24 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/280] 6.1.162-rc1 review
Message-ID: <20260205082424.GA15548@francesco-nb>
References: <20260204143909.614719725@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214420-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dolcini.it:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,toradex.com:email]
X-Rspamd-Queue-Id: 0C063EFDDD
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 03:36:14PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.162 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Compiled and tested on

 - Verdin iMX8MM
 - Verdin iMX8MP
 - Colibri iMX6
 - Colibri iMX6ULL
 - Colibri iMX7
 - Apalis iMX6

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>


