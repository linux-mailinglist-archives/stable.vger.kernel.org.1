Return-Path: <stable+bounces-222574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEAvJ9VqpWkaAQYAu9opvQ
	(envelope-from <stable+bounces-222574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:47:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F28961D6CBB
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1760E309B41A
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 10:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9230333D4FA;
	Mon,  2 Mar 2026 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="HRoncpi3"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB335337B8F;
	Mon,  2 Mar 2026 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448132; cv=none; b=mx1JeljS3BdHei+afco/ZCibyIUBJDyu5p23QTZ1bOP1O+IAolB68Gany093AgADqskJW1DJN/tqhX2E7bLNNYi/fMTGXZ2sRc7dqT91wZDc5/f6qU93AjeWStyp/lihkop4LYJFwnp6D98SXdz2xWx33ji1oOQbIUwpvwZNPzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448132; c=relaxed/simple;
	bh=bOrJ4Ju+8XEOJCR7kEWs3PuhJEx2x1iS5H7K9GVOLWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1ZT5Xk/lD+JGmXqb5tma3jT7L75svifbXuiCG1PIcjWuI3SSNNdon2DSwhvI61fGwWyGnQ76vIPJ+tMp1XJoWATDUKqSD6sJx8amVdXEyY+ktPpvCVjfIRsx0EdXCssoBSy3D72SlsTRFnvakEpGu9edYojuimrBGhQnoNjzt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=HRoncpi3; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 222361FB1F;
	Mon,  2 Mar 2026 11:42:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1772448129;
	bh=EHXWvkzks+R1ouW0lRjm9BUXydRiyos5Dz9+DZjQL2Q=; h=From:To:Subject;
	b=HRoncpi3/oDlFUOXwAgKz6HX1wPlLvNB0ccKciHZ759beF+iHDAL6GaN6HCb4dzx5
	 RNjj/P25ed+QUJO4rx4cqYWu2sWoDPlId0mhh+m3VWHQOrW76jpg2Tez6P121EeI/P
	 t/YRVrY3rwHCvoxdryw20wQue0YhwTo2+lOHx1GkluTBgQezjy/3DpW+J4WuB7gqnL
	 xU4Umgm2mpWckKayoWTLhfepmTF5IAWkamTKJyRs4ld4o8VcudLbktpBmeajU9wxMj
	 x1h+dk2jCpjyruvkwUgco62mmV21jmf57RKxryw7lVg/Jhf5tkKuC71PRiX2DTCt0a
	 iuU/aSsIwdgAg==
Date: Mon, 2 Mar 2026 11:42:05 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/385] 6.12.75-rc1 review
Message-ID: <20260302104205.GA43213@francesco-nb>
References: <20260228180001.1567994-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228180001.1567994-1-sashal@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222574-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dolcini.it:dkim,toradex.com:email]
X-Rspamd-Queue-Id: F28961D6CBB
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 01:00:01PM -0500, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.12.75 release.
> There are 385 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Compiled and tested on

 - Verdin AM62
 - Verdin iMX8MP
 - Toradex SMARC iMX8MP

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>


