Return-Path: <stable+bounces-211236-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JpHBtQpcmmadwAAu9opvQ
	(envelope-from <stable+bounces-211236-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:44:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CC76774B
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 701EC907AA2
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6369F2C3244;
	Thu, 22 Jan 2026 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="zYis99hx"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466D822A4FC;
	Thu, 22 Jan 2026 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086701; cv=none; b=PLVIyq9d48EUk7UDZoQQZ5XgC5umuojSLkMOfQ/EPXJgMIdpXOZVIlYillCETDfrCE2m3xXzLDpjoPOmKhwWFGQHfF3kuvh6H6q3+KK4fJAwM/Mt0272Pe+aiPEpDvKn+vC6eSWBhaYJ5TPFvjTsaj/V8awaCH+G3ZoUOGhr9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086701; c=relaxed/simple;
	bh=aU+YlFTJpfAjbIPFXxwvw3vej51pgQtic97OXHxiW3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg3XXt1inkJHbgOmF+RUJ9g7U0rkp7iQUf+On4EJe9zMhiVF21bhT9/pg2TRsuB+LSzyqQjGbIdmQ41jGPXs3qy2+1YOcHca/MGuQuRjiIeS1O46gm3UzCALKMeptu7lU/w042Y98+uDVpBniznXhXt+3sQhy1SnjXbzuPReTe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=zYis99hx; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 2F3F01FAFC;
	Thu, 22 Jan 2026 13:58:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1769086688;
	bh=cLtm+fknhPP1OrspAUg5Zc31jIa7VV4SGAIlugNaLJw=; h=From:To:Subject;
	b=zYis99hxYZiHLp8U4ytMu3WgB7UA/bsMWtsI1hfrne7EwDqGSlTnSspiMXOzRtOe1
	 K1YTyM/WMp4UPgeXfqA5K7gCOrckmWDvf5dtkoGcdRt2XZ1FCkVGcHfAI7J+wDJJhY
	 FzbR/HxycQI7Aj8k5jU2f8FwsBN7IvQURAKjj63RzLKYo3WMxhwjCgTAfqZhlu+724
	 oucoaBbBJYxEKN/aly/E2P1sqtn5EPm0hRNWcQK0fBOFQvWK+9rm8FNTz5ft/VOC1o
	 WXTV3SHF7EIZ01h+4977gDbCcVnmHNtJhPxBldZtG5zSEg2DOsCkJKYl8VnsEOMVXl
	 f3VY0aiLAtEiQ==
Date: Thu, 22 Jan 2026 13:58:02 +0100
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
Subject: Re: [PATCH 6.12 000/139] 6.12.67-rc1 review
Message-ID: <20260122125802.GA54064@francesco-nb>
References: <20260121181411.452263583@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211236-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[dolcini.it,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 79CC76774B
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:14:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.67 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Compiled and tested on

 - Verdin AM62
 - Verdin iMX8MP

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco


