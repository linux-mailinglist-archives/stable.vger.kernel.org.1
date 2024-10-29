Return-Path: <stable+bounces-89243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EF89B529E
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 20:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967601C21BB9
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 19:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C3B1F9406;
	Tue, 29 Oct 2024 19:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b="j6bLhyUr"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7662040BB
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229573; cv=pass; b=grr9Hk3Dz6BqDehXFA624PocMjvrWLBe94PtqFRZ6up6epQmuerv/odX+ROBVRK6MWPdh0SR94KmNgprEwk58x6NLqjrFEPB74qaT7PYJo/mWhRWYUVgr6p4Js2eh5p+CgIbA7nL6vHnMfwr355VkhnXM5y00vwfLQBDVFPSTTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229573; c=relaxed/simple;
	bh=22hXqj0ZI3O+at6VY92qBwIZV0R6+NogspMaTQnDS4A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mUBP4aSW8zoOSJiW/572Q4IdO1lzWUWsM5f3ddwuK7YnyJafOScmcdiqiowBJyWybsM4fCqSAs+s8hJ3rIlZQMXXrmj9Pr7FWbCEfFP/KXBHKFtanm3riDIuxDRLTfLKFFx4tBnESGsChf6Ijt5b18Y0T0y93pHC3pX2aPQjLh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b=j6bLhyUr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730229558; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Auyo/uWi6s4GZdbeNnj1xTZ9Ffhlcw2sk410Cj5sFcCylTRI0EG998I/wfbqhIpKQJ9luWmcg8Xr+0A73ZsqH2Sf8ep/F31kzmdd8uxuxVY4PfDKpv4y/mqiQd6Hv5yfEJrHfz34MzztbM0r4/pyf/ibPvuDh9zpIaziSzs8ouw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730229558; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YwdkWAcBJwlxAKbA05SRlwv/dPGr3OtaiRfzTM29qRg=; 
	b=hsNLFgIuccHNowJ06klDQRnqhlQzW3c1XMiQO3ikTdEVrHhuJlKxMExVMA8U9xL1iVtOWJXvSRo6OLnbWi5ZD71wsvIZXtBCaZtB3qhlO72LHIMifRhe7CQnSduelsMYFfWiIgxxTgl7wOBZlaWmECcMFXtXdLK+iEmKdF3dyFM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730229558;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YwdkWAcBJwlxAKbA05SRlwv/dPGr3OtaiRfzTM29qRg=;
	b=j6bLhyUroDPlVVtn5HHg5SI6rBQ4qjyZwDhZk/FUP1AW4pC+B8Zc/Lk9GAjg6QWB
	dleegWV3kFMsGL8+oMGrpx1Lcn63bIFAtZNKTbyp33AkUGkNPhpXOtgk9raFVIWtMYZ
	kBrpMobnbYCVVzZteRbS525kSRetyWcpSc7+wrgw=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1730229526423594.4339206078162; Tue, 29 Oct 2024 12:18:46 -0700 (PDT)
Date: Tue, 29 Oct 2024 19:18:46 +0000
From: Robert Beckett <bob.beckett@collabora.com>
To: "Gwendal Grignou" <gwendal@chromium.org>
Cc: "Christoph Hellwig" <hch@lst.de>, "kbusch" <kbusch@kernel.org>,
	"kbusch" <kbusch@meta.com>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"sagi" <sagi@grimberg.me>, "stable" <stable@vger.kernel.org>
Message-ID: <192d9b75f76.106d874861279652.1491635971113271140@collabora.com>
In-Reply-To: <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com>
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
 <20241029024236.2702721-1-gwendal@chromium.org> <20241029074117.GB22316@lst.de> <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail






 ---- On Tue, 29 Oct 2024 18:58:40 +0000  Gwendal Grignou  wrote ---=20
 > On Tue, Oct 29, 2024 at 12:41=E2=80=AFAM Christoph Hellwig hch@lst.de> w=
rote:
 > >
 > > On Mon, Oct 28, 2024 at 07:42:36PM -0700, Gwendal Grignou wrote:
 > > > PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
 > > > is a NMVe to eMMC bridge, that can be used with different eMMC
 > > > memory devices.
 > >
 > > Holy f**k, what an awful idea..
 > >
 > > > The NVMe device name contains the eMMC device name, for instance:
 > > > `BAYHUB SanDisk-DA4128-91904055-128GB`
 > > >
 > > > The bridge is known to work with many eMMC devices, we need to limit
 > > > the queue depth once we know which eMMC device is behind the bridge.
 > >
 > > Please work with Tobert to quirk based on the identify data for "his"
 > > device to keep it quirked instead of regressing it.
 >=20
 > The issue is we would need to base the quirk on the model name
 > (subsys->model) that is not available in `nvme_id_table`. Beside,
 > `q_depth` is set in `nvme_pci_enable`, called at probe time before
 > calling `nvme_init_ctrl_finish` that will indirectly populate
 > `subsys`.
 >=20
 > Bob, to address the data corruption problem from user space, adding a
 > udev rule to set `queue/nr_requests` to 1 when `device/model` matches
 > the device used in the Steam Deck would most likely be too late in the
 > boot process, wouldn't it?

I've never seen the corruption outside of severe stress testing.
In the field, people reported it during and after os image updates (more st=
ress testing).
However, as this concerns data integrity, it seems risky to me to rely on a=
 fix
after bootup.

 >=20
 > Gwendal.
 >=20


