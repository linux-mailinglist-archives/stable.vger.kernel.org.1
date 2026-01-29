Return-Path: <stable+bounces-212770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDC3AohPe2n9DgIAu9opvQ
	(envelope-from <stable+bounces-212770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 13:16:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF475AFFD5
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 13:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9618C300B3DE
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 12:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A723876D9;
	Thu, 29 Jan 2026 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="BhH3P1uE"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B83876CC;
	Thu, 29 Jan 2026 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769688878; cv=none; b=ZV1Atq0qv+hMqJHd+eBf5Z1gNQzIC/Vx+KrNowdCcHGu4olWZkjNsmr7CrixbKqaneHHCHOUx8svdsjDXNMCqOMesDaOVPT2nhpaVMQmgNc+BMTFUPnSgkTsX3D2f2sjVJXZE2qEzgDqYGj5ajA93FCzvx0tlg41L6IBnicK01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769688878; c=relaxed/simple;
	bh=gzV+eprp4opxNtIjgCSC3QCQKTk2X/SC3XMREsRvzIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/hY8xu61OurIK7QI3HLGLShUjzk0ZS1v2Y7HGtUmtD9SJbD6iw91+rPQ/ipZSWBcCQDyWZ5DlWqciFfgfYqGIftpGTe/Iy1xUbU7VGpw+/dSO6SSK9HcK+7X88zqft7ENQqAgSJ87r2B0Usijx+z30j6fF65PngV9GQvoR+wjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=BhH3P1uE; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 3E79D1FAE4;
	Thu, 29 Jan 2026 13:14:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1769688873;
	bh=0ruMiEbmatRyLdSDU9GVneVebQsohFEEnNshrzJh1VY=; h=From:To:Subject;
	b=BhH3P1uENX1AHobeYn21cwlej1jQLIsuatEdT5bQZUR+fyoaAqWKraICisiVuVLYd
	 7E7EPHtiHF0SJO0nsobENn5ARO0YuwkOtdcPwgwR6E/q3qMXkiUXbzN28eFUuUCweb
	 ovcjzThPnDCuj+GLnDn80uK77br0MybuL5a5uGi7XgMv+JEyGQEvu4OccH2HKCXSWm
	 7H9Fl2LSp9wgTDdL5+/CHwESdcT+mZaKbIvt7v0Q4L2hkClvsnB83460tMVoGlbnrW
	 E1cJqmgCsundDNxd82UVUwAGh5y9IP2FTDJvm1EsI1VfvqK81L172ocgnrQ1LPtw/F
	 Kh037EDHemXPg==
Date: Thu, 29 Jan 2026 13:14:29 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: freescale: imx95-toradex-smarc: fix
 PMIC_SD2_VSEL label position
Message-ID: <20260129121414.GA57679@francesco-nb>
References: <20260129104741.888670-1-ghidoliemanuele@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129104741.888670-1-ghidoliemanuele@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-212770-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,toradex.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BF475AFFD5
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:47:35AM +0100, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Fix the PMIC_SD2_VSEL gpio-line-name position. It should be on line 19
> of gpio3, not line 20.
> 
> Fixes: 90bbe88e0ea6 ("arm64: dts: freescale: add Toradex SMARC iMX95")
> Cc: stable@vger.kernel.org
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>



