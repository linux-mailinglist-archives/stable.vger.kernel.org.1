Return-Path: <stable+bounces-50159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DAC903E4A
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 16:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2A128890C
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 14:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBFB17D37A;
	Tue, 11 Jun 2024 14:01:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from eclipse.jkvinge.net (eclipse.jkvinge.net [217.170.205.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF11176ABA;
	Tue, 11 Jun 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.170.205.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114462; cv=none; b=TJCUvuq5M03ea7MkJee2RUwzH55yDp/vGZPK9I2Xi0LUlK/h5zT1NUPb40tv59aQWcjyhL3NBrziVc5S+t8SnUkozqAUBBTlvEx/lBopUbEv+u91HwubVoVty3AEM6X+IbdPhQwZTppfpnUMeQGKRhBUR2rubOd1Ttx0YO/CM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114462; c=relaxed/simple;
	bh=wgaLxLAu79/k2NGnok/SFrsl/QurFMzL7wbVHVDVk/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hW9EhdgLmdSnIdu9G2mReDjnOQMq7TsbTx69yvftDeyoZj+T4jl98RqImomj8Ql8dsYS41tVGfAy7zndopGrCy3gnJP3rws/JwV2EdGxTeMwX4kdzshr7BwsHSV/GGlCEkRLBYF6RwPDbkpiMDRAzSCIAi4R+OWltqY6K8JR9Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=opensuse.org; spf=fail smtp.mailfrom=opensuse.org; arc=none smtp.client-ip=217.170.205.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=opensuse.org
Received: from ni227.in.jkvinge.net (ti0116a430-0342.bb.online.no [85.165.32.90])
	(authenticated bits=0)
	by eclipse.jkvinge.net (8.15.2/8.15.2/SuSE Linux 0.8) with ESMTPSA id 45BE0tUh016223
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 11 Jun 2024 16:00:55 +0200
Message-ID: <54279623656afdc903fd9655cce1915ddf1a34fc.camel@opensuse.org>
Subject: Re: Plymouth not showing during boot on a rpi cm4 since kernel 5.15
From: Jonas Kvinge <jonaski@opensuse.org>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Date: Tue, 11 Jun 2024 16:00:55 +0200
In-Reply-To: <a3c17f5bf8bab1141ea9126277fb912d7d6efb18.camel@opensuse.org>
References: <a3c17f5bf8bab1141ea9126277fb912d7d6efb18.camel@opensuse.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received-SPF: pass (eclipse.jkvinge.net: authenticated connection) receiver=eclipse.jkvinge.net; client-ip=85.165.32.90; helo=ni227.in.jkvinge.net; envelope-from=jonaski@opensuse.org; x-software=spfmilter 2.001 http://www.acme.com/software/spfmilter/ with libspf2-1.2.10;

On Tue, 2024-06-11 at 13:51 +0200, Jonas Kvinge wrote:
> Hi,
>=20
> A blank black screen is shown during boot instead of showing
> Plymouth.

Just ignore this. I've solved this, it seems to be a timing thing,
which changed after kernel 5.14. I'm guessing plymouth gets interrupted
while the kernel is switching framebuffer driver, so the solution is
just to add ShowDelay=3D3 to /etc/plymouth/plymouthd.conf, re-run dracut
-f so plymouth gets started a little later.

Jonas


