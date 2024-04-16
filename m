Return-Path: <stable+bounces-40056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BC78A78DD
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 01:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2F81C21610
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 23:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9903513A896;
	Tue, 16 Apr 2024 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jFwK+6y6";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OenLps9z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ey0qVjHR"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D6913A885;
	Tue, 16 Apr 2024 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310911; cv=fail; b=kDn3hAmHZqNA/OKxdhIlDXl8IrTOC0v5uRSsskh5GsrDJd42nMDHPQGBje5nXuaYTCbmlmvQNx5rSqqZceX1q94t/4CG5olOuauim/e1UkIoKJGGBe6lF5mr0jKE4VnAc4QUv3bFsXHMq/RT8Oky+wTIumf0qSQe3aIgwsOTdG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310911; c=relaxed/simple;
	bh=JTuIR1EJmDxdGkm8GybfbEEi8QHhE8YFEaoqZRlhvIE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q4slChbi+xsOB/o89YhWZorOPNafH1OW4GWlFtVYzDIUPeDZbKWWG0okVPbM5RGMAvgAz3cqNrkNtr3ZeDzwsoZVu0zM92cjO6o5ZxH+sBlR4x1vb3ms0mDtwv4hu3SovzNRgeZgmudQV4tmgW/VA5rVg0hvxVItl1HPA7PM3nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jFwK+6y6; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OenLps9z; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ey0qVjHR reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GHbYrm013683;
	Tue, 16 Apr 2024 16:41:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pfptdkimsnps; bh=xEApJXelvG3O7OD5hkc/1hsFMjvZkuWuVbL9t0vfacc=; b=
	jFwK+6y6vr6wRbU7pNqy0qktvwik+iXfW673izXLIg70J/zsB4GpIf7Y2qVOih6B
	Ws7Rw/YZIGrywNhBxFH1ZNB2o+RtsVFcgTda20PD1noE3derWwbj3jbgf/Cz9kgh
	qMpw4TyVZCgNjNk102LLRrRPtJ3Ig7iTyYo3dG3fIQs+nuLf11wmfFXNHI4Lapab
	CVuoFZ5mgS77iX6C+vJubsrt/LwURC4ImN58u3tbny/EHTbWttGELW2rU26JylFG
	FHNtDPTmCgaiLDiBINqJBt/n+6z7HlGApj24yLHU7kUGONl1WegiH5eYAZMXKV2z
	hiUDIH5PBI6/2NSp0aN5qA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xhrretqhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 16:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713310907; bh=JTuIR1EJmDxdGkm8GybfbEEi8QHhE8YFEaoqZRlhvIE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=OenLps9zGEg3ZAg1T30oFeAO+FcWnm/JlP6gS6KGe2iomTTpXrawplaaG9gQnx3F8
	 gjfhJsfXYoSnoazA9LezMKqPtaZePMu6KHn5vi2fmiNQQHZVc7DtW/I8Mq9TWsCsUO
	 uJgiwxQ9YeIyidcGgha4tvvovdwLWCjgxc/qZdHycsm473mgonqa1lUy6Tq2t2JRzW
	 3ZyyffrRafM9ob7IujawGl1MzvEDnKBvzJAE3FRtSselVZbaXgIzNrb4zUoJFG+Kh9
	 otcFsBF8ygtvXC70O15xI/Hbp9Ik4uxe3v0YNBqyMAnx0PbJ86Z1qe3p7B4sopEX3r
	 oJXtui7YcGpVA==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 39F8740355;
	Tue, 16 Apr 2024 23:41:47 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id F06CAA005E;
	Tue, 16 Apr 2024 23:41:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ey0qVjHR;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5ECFF40363;
	Tue, 16 Apr 2024 23:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWaGWDT8+OoaSc/U4nC49GPjDcE3nl6KTRq+5sS8F+1WbadXpNlk929i+Tdd+YBDdSpnkHUOcx30Y3DLJ3kXbyg+LznEiezVC4W753WdPNCNmnfh22EG4olDy60dpWchiMKD2zedtUGnQw7jkB4PdJCCBOnxK0BwoQmAlLZU5PVoRMOsdXUXeu/LQvQDDRzh+dg91ubAW7fjgVwow6rHxbobBuETBfjLGV0C8IPFib70i96/7wUNpbJAIrdkwPTrrKKWPoa/v6qsT8hzc5JGIGulln9LtQZTN8Y9Mt2hZvjoHKubaUuO516YLB/fOz947qmsNBXaddTgHPciUEZ9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEApJXelvG3O7OD5hkc/1hsFMjvZkuWuVbL9t0vfacc=;
 b=M5NuCJz4lm2JHI1CPx1bz9cN6eamF9O+3IkMAT5hGIx35P5fdH69M+wf8ZEaem6WTVGo5pLzNFl+JQvCmS1Tou7rPaG2kuZK1lmw5Z14yzMYnW0RmccDUvnYVyGs5F9zZQnhLsKqKJsj56e8CWynrRS+8gRXYpVWs/ng+a4hWq6kWj+x5OjlaozAsKqu1qLWw6dvsFnMGSHKFFD2N6Y7osLr86wzhxncmaOO6/oQ/+DDHi9KzdDY9Hn1MiHUIXfYrkd2BlanWVMj5wDiDm3tmQzr+JQo1/7rqVsm/5LYXDq597RdZb/GwvTHM3ZOxB0GTBdzV6dAU+Af4NZXOYQrMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEApJXelvG3O7OD5hkc/1hsFMjvZkuWuVbL9t0vfacc=;
 b=ey0qVjHR7zsmQZFPJpM9RAa/tMWxBv5sWjti5NA6OASOVy1750DvaFHRbwHBZeq59M1EjnvG6LiYyekj83158Pvnx/M0oqpoou5dk0tCdCHTZlUfS0qEFGc18kc3CD9mqsSeippd/+WspgNz85ewy3zIxoA3hv3r2bpaw4AnQ0E=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 23:41:42 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 23:41:42 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 2/2] usb: dwc3: core: Prevent phy suspend during init
Thread-Topic: [PATCH 2/2] usb: dwc3: core: Prevent phy suspend during init
Thread-Index: AQHakFeioIjMhcyoIkClbCNPPNRvWA==
Date: Tue, 16 Apr 2024 23:41:42 +0000
Message-ID: 
 <e8f04e642889b4c865aaf06762cde9386e0ff830.1713310411.git.Thinh.Nguyen@synopsys.com>
References: <cover.1713310411.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1713310411.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB7818:EE_
x-ms-office365-filtering-correlation-id: ec6f430d-a393-4fbf-5c9f-08dc5e6ec513
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 u5TdLbSXk22a0+Gdw4+jOQSb0YrpSULwpzNmmU9yLi87vu/o5GmA6v7tkNJSsQb5FFV+XJ7kdDhAq0xDzADI84N0uMQ5rFG/zTRSSygHqmojqQz1zFGeEYS4LPrYdOVtWOxzPgM88deiy+BW/Xyt7pV5dD7k1jTgo/LexXkPnmQWLSBiRBxubGQktMPCPJA9Lzop4cXxUgNttbr+FeY9KHa/aHzC26sIQtAtUhsTM8/4mf8zIQ0lChAS14Kf02UvPhoOtgPPhSbVMiGV5kRxkyOpCzp0tJRS1qHLzX778Xrw5pwGuoym8ybJypOV4RNkNBsvK1A+85ajFWHGeeGJtCsiWtC43IFDEtpwYeJI7TUWk6bx9ibHKi678e1Ss+AVY+reme6K1cxpCU/yt010dq0oyFm4e/FMq4mRbDfH8Q8o0rAo0hJW+jxNqaYHsXKb2xAOnUEJmLfdaGE6sHRGKuhtKarMi5mAYovcr7+kgKE4tPKMy77bmzSzC3VC/Imdy3DE7RUGbi5uvmwNybSAF/fsiW0E1UJ1Cp0pYxY7P5232ofrtFXxe66oKjVow3SfqdZk9EvhHyC7/dV3dKz2b82c2qT9W9MB2jUWDS7ZkAcyg8rHKHGNYMpFpL5N8S9Xb91ffF7pLq1Vo8xf+xrdQj5aRsFjfietuDjqMDN3+bp/pjmpaZhMEVjdqRCHLKGTSkHqPNbj2DqDJ2unuk9TnlFKIM3WwQv5N0aCVduUqh8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?X8+/5mcPIrmY7hZF6et1/xA8UD3PC039rs2qR+05yvM+ZnxdwcL/xoCttI?=
 =?iso-8859-1?Q?3zbosCxwPLpA95rdAB/HgWgaPAdM9xSssvsQnQcSjsldkpv+jOsWD3uUFt?=
 =?iso-8859-1?Q?t5euB4EEjwnEnXQY6XgB/xrr7+dT4BUMSPfxkVZCutvlUFDfeGS33POAmG?=
 =?iso-8859-1?Q?o6an3BVaTN14PudAl/okzxWc3yRNbMeqwBZYQy0nYN1eAnzeVnXVF4Nf4L?=
 =?iso-8859-1?Q?6zWQypSJkv3NcymsdcKe+5N6vnXqIhyyGWIm5dwSpCi0HSuvzT+lvjCrBg?=
 =?iso-8859-1?Q?chEBm8Tv8f3BsCT9/l+sHcuUwnV6lBNQRt1Ce6h6KjOKOxLMJeLUok3loV?=
 =?iso-8859-1?Q?wJ8FIkggtVEbbFYnBq6sqYmKNBOCt2+n6in04DUH4X4Jc+jJ/0hiT07xzd?=
 =?iso-8859-1?Q?PWvgX/j0TGAuf+kGYGu6WvDC7pFI6st56gtYw8GRLW+qQMQes9Hs6czna5?=
 =?iso-8859-1?Q?HYuIFMgDAUHxpu03X775adqG58gZPHvZ5Aw0e/W9TMk4oQtBI4RehllugB?=
 =?iso-8859-1?Q?cgoYskUX5x4jCUKdQlrP7aoRrwLFgrvuBmcda4R2LawHX23zsZa2N3oZlP?=
 =?iso-8859-1?Q?P+MlIp8007PBSkOVRM2+DPMVow4PH5XAgbmZKnBGtVOc2MwOc0dxy3QOXU?=
 =?iso-8859-1?Q?62SaujCEtaKbKnJLwNq+Rd2/hg7dymTPpbYmK0Dx3ihmtxnEEl91KF9rmb?=
 =?iso-8859-1?Q?2pKnu8Fb4gD271MUBALRrMZ3jepwlRMLHf+JlFAPyc1x8CscMAcXhkkJ86?=
 =?iso-8859-1?Q?LlxKMd0CcII4g53CpvFarmPJy5Obx4eN7ERWDx7oF1ZoGn2KpwP4dxFSDn?=
 =?iso-8859-1?Q?PS9C8mdTwyJe5hpUFbZMZ0QmOT0c5hxXQqreVecj4sNuQpvHgjEm0j9AOk?=
 =?iso-8859-1?Q?0OdmH8INRQ7/Yc/Y6Z1fati0Lbq8ArwRgj28ypboMzWIIAZFSJJHGGA34t?=
 =?iso-8859-1?Q?h7fDYecfjnq5eIZbFqju6uGxGj7wNa3OpRHc+5/b7RRomrHP0R0UuymSDz?=
 =?iso-8859-1?Q?fb1S7qD48rW/yMiiSJN2n9IIFdliVkcEEWMasFqWijG9Hn+ScTA81dFJig?=
 =?iso-8859-1?Q?th2E9dm/At1OSjVKejJv2IDQlSa2hIISdeZI0I1H/ygrpge0EOiVads06k?=
 =?iso-8859-1?Q?LkLrxIEK7p46OAU4V2+2CmT6+IQ+/HOmAit0EFq9wlGlRk+nVPC3czoRaa?=
 =?iso-8859-1?Q?RH3roZNjUqN57RW0lxlYW42l2VzxaJTB2KXNiA/c09pXDxd0dGsn+bs9Bv?=
 =?iso-8859-1?Q?s6yF2HjsJV4YrAAyKdOBZudNxISslnA0PP5X345ijfZN34vRrUzHvnbxPm?=
 =?iso-8859-1?Q?3ve56WITibBL4uSgQuH0G3RGU3IfYx3efDfdioVr7f28TA6kA8H1nJVGY1?=
 =?iso-8859-1?Q?LGzIOmN20BnjBDwSK7B4x/1AU6u1PSBwDGmdxbClsHKIidePUYyzcuUWef?=
 =?iso-8859-1?Q?JzOUHRP73KixJm+EgJHbLX9mRV9Y11ZxQVLhwiNgq3g/8L1qRtetIK3jbW?=
 =?iso-8859-1?Q?OShNkuJDKh5dXN5TzC9QdW+GF1t8tigKwZUCzmHO1TmNyYLNltGNHZrd9O?=
 =?iso-8859-1?Q?aY3wsoCtDgTVvb511oVlfaPkognJhm3XawIYNwZj2NgY0lJrjacsEOct/6?=
 =?iso-8859-1?Q?agxuhBJ/uLQ4AARgiKBNA3irHSCOuTzxU2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8WdP3UPPcTr0wmnLD3CDWUXnUs9zXp491G1S5X1owkanZp7C7wp2oN5UeAplYDymsPldyNzOn3jLCShl6SpqeIbjTyWqZWDb+ONaTDhTo81ieNpCEKK7wGNT2piiiev1EuAyDryXtbg0Fnk5YuNWNkKH3kw8jN5ooKdTm4RTd5zFYOE2vnTflgZL5kwyCKAsHNPVyAzlcIr8s/cwiAL9BaulfSRQVxOGwusxAvGou3hyPpZ9hAjMyK3T843I63AOpuzQBTX24MNfVKzgF21+yHmhG/PVlORPQOoZcm3EcQU3JKBosVKnU8I0/trp5CsuKZrJw/tcJvg3aDOzr+Y9J5lIunHRFnKzyPgOuqfKgw2JRvRmGBpTN6JS3sdOpbiVnnULga9Djf9aZBk/u/OWvZ8eRKFbbTFRmFEhAE+coCLv2N1E33NIfqttFhbd6lybZfkuGnk4Ax4BmnFjYhPSicnpmL+5b6n8U4SHphuGz54u55CaF7fkjkR/36lF5LEyT2ZOZj+cK7YdvMnpOz2SyC5a5yOp1cafRTuGWa2oBFXk2XshTdy1gWnKS5ZVye+FAgNJ+wWnO0WJXZvpMTbLpd/1ll/NNmxN78Ctg1RIMGJWLiDENxfHhwrQd9bPv9TwJwCRbtMtquJkfL1KU357Cw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6f430d-a393-4fbf-5c9f-08dc5e6ec513
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 23:41:42.5332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHR1ll5RfNkbtt/t2Av+5SOh/IVmn4EMREoKkPSsTE6BbZ/mIKFaBZ17YfdVmKBJx94N4YLwwmU//blsSEwEnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818
X-Proofpoint-ORIG-GUID: VsGJpCYyMS77MBBLx_Mhz-XhB1i0SAT4
X-Proofpoint-GUID: VsGJpCYyMS77MBBLx_Mhz-XhB1i0SAT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_18,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404160155

GUSB3PIPECTL.SUSPENDENABLE and GUSB2PHYCFG.SUSPHY should be cleared
during initialization. Suspend during initialization can result in
undefined behavior due to clock synchronization failure, which often
seen as core soft reset timeout.

The programming guide recommended these bits to be cleared during
initialization for DWC_usb3.0 version 1.94 and above (along with
DWC_usb31 and DWC_usb32). The current check in the driver does not
account if it's set by default setting from coreConsultant.

This is especially the case for DRD when switching mode to ensure the
phy clocks are available to change mode. Depending on the
platforms/design, some may be affected more than others. This is noted
in the DWC_usb3x programming guide under the above registers.

Let's just disable them during driver load and mode switching. Restore
them when the controller initialization completes.

Note that some platforms workaround this issue by disabling phy suspend
through "snps,dis_u3_susphy_quirk" and "snps,dis_u2_susphy_quirk" when
they should not need to.

Cc: stable@vger.kernel.org
Fixes: 9ba3aca8fe82 ("usb: dwc3: Disable phy suspend after power-on reset")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/core.c   | 90 +++++++++++++++++----------------------
 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/gadget.c |  2 +
 drivers/usb/dwc3/host.c   | 27 ++++++++++++
 4 files changed, 68 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 31684cdaaae3..100041320e8d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -104,6 +104,27 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 	return 0;
 }
=20
+void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
+{
+	u32 reg;
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	if (enable && !dwc->dis_u3_susphy_quirk)
+		reg |=3D DWC3_GUSB3PIPECTL_SUSPHY;
+	else
+		reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
+
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+
+	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	if (enable && !dwc->dis_u2_susphy_quirk)
+		reg |=3D DWC3_GUSB2PHYCFG_SUSPHY;
+	else
+		reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
+
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+}
+
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
@@ -585,11 +606,8 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
  */
 static int dwc3_phy_setup(struct dwc3 *dwc)
 {
-	unsigned int hw_mode;
 	u32 reg;
=20
-	hw_mode =3D DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
-
 	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
=20
 	/*
@@ -599,21 +617,16 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	reg &=3D ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
=20
 	/*
-	 * Above 1.94a, it is recommended to set DWC3_GUSB3PIPECTL_SUSPHY
-	 * to '0' during coreConsultant configuration. So default value
-	 * will be '0' when the core is reset. Application needs to set it
-	 * to '1' after the core initialization is completed.
-	 */
-	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
-		reg |=3D DWC3_GUSB3PIPECTL_SUSPHY;
-
-	/*
-	 * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be cleared after
-	 * power-on reset, and it can be set after core initialization, which is
-	 * after device soft-reset during initialization.
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB3PIPECTL_SUSPHY to '0' during coreConsultant configuration.
+	 * So default value will be '0' when the core is reset. Application
+	 * needs to set it to '1' after the core initialization is completed.
+	 *
+	 * Similarly for DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be
+	 * cleared after power-on reset, and it can be set after core
+	 * initialization.
 	 */
-	if (hw_mode =3D=3D DWC3_GHWPARAMS0_MODE_DRD)
-		reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
+	reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
=20
 	if (dwc->u2ss_inp3_quirk)
 		reg |=3D DWC3_GUSB3PIPECTL_U2SSINP3OK;
@@ -639,9 +652,6 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->tx_de_emphasis_quirk)
 		reg |=3D DWC3_GUSB3PIPECTL_TX_DEEPH(dwc->tx_de_emphasis);
=20
-	if (dwc->dis_u3_susphy_quirk)
-		reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
-
 	if (dwc->dis_del_phy_power_chg_quirk)
 		reg &=3D ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
=20
@@ -689,24 +699,15 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	}
=20
 	/*
-	 * Above 1.94a, it is recommended to set DWC3_GUSB2PHYCFG_SUSPHY to
-	 * '0' during coreConsultant configuration. So default value will
-	 * be '0' when the core is reset. Application needs to set it to
-	 * '1' after the core initialization is completed.
-	 */
-	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
-		reg |=3D DWC3_GUSB2PHYCFG_SUSPHY;
-
-	/*
-	 * For DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared after
-	 * power-on reset, and it can be set after core initialization, which is
-	 * after device soft-reset during initialization.
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB2PHYCFG_SUSPHY to '0' during coreConsultant configuration.
+	 * So default value will be '0' when the core is reset. Application
+	 * needs to set it to '1' after the core initialization is completed.
+	 *
+	 * Similarly for DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared
+	 * after power-on reset, and it can be set after core initialization.
 	 */
-	if (hw_mode =3D=3D DWC3_GHWPARAMS0_MODE_DRD)
-		reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
-
-	if (dwc->dis_u2_susphy_quirk)
-		reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
+	reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
=20
 	if (dwc->dis_enblslpm_quirk)
 		reg &=3D ~DWC3_GUSB2PHYCFG_ENBLSLPM;
@@ -1227,21 +1228,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err_exit_phy;
=20
-	if (hw_mode =3D=3D DWC3_GHWPARAMS0_MODE_DRD &&
-	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
-		if (!dwc->dis_u3_susphy_quirk) {
-			reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-			reg |=3D DWC3_GUSB3PIPECTL_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
-		}
-
-		if (!dwc->dis_u2_susphy_quirk) {
-			reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-			reg |=3D DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-		}
-	}
-
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
=20
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 7e80dd3d466b..180dd8d29287 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1580,6 +1580,7 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc);
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc);
=20
 int dwc3_core_soft_reset(struct dwc3 *dwc);
+void dwc3_enable_susphy(struct dwc3 *dwc, bool enable);
=20
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_RO=
LE)
 int dwc3_host_init(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4df2661f6675..f94f68f1e7d2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2924,6 +2924,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	dwc3_ep0_out_start(dwc);
=20
 	dwc3_gadget_enable_irq(dwc);
+	dwc3_enable_susphy(dwc, true);
=20
 	return 0;
=20
@@ -4690,6 +4691,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
=20
+	dwc3_enable_susphy(dwc, false);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
 	usb_put_gadget(dwc->gadget);
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 0204787df81d..a171b27a7845 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -10,10 +10,13 @@
 #include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
=20
 #include "../host/xhci-port.h"
 #include "../host/xhci-ext-caps.h"
 #include "../host/xhci-caps.h"
+#include "../host/xhci-plat.h"
 #include "core.h"
=20
 #define XHCI_HCSPARAMS1		0x4
@@ -57,6 +60,24 @@ static void dwc3_power_off_all_roothub_ports(struct dwc3=
 *dwc)
 	}
 }
=20
+static void dwc3_xhci_plat_start(struct usb_hcd *hcd)
+{
+	struct platform_device *pdev;
+	struct dwc3 *dwc;
+
+	if (!usb_hcd_is_primary_hcd(hcd))
+		return;
+
+	pdev =3D to_platform_device(hcd->self.controller);
+	dwc =3D dev_get_drvdata(pdev->dev.parent);
+
+	dwc3_enable_susphy(dwc, true);
+}
+
+static const struct xhci_plat_priv dwc3_xhci_plat_quirk =3D {
+	.plat_start =3D dwc3_xhci_plat_start,
+};
+
 static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
 					int irq, char *name)
 {
@@ -167,6 +188,11 @@ int dwc3_host_init(struct dwc3 *dwc)
 		}
 	}
=20
+	ret =3D platform_device_add_data(xhci, &dwc3_xhci_plat_quirk,
+				       sizeof(struct xhci_plat_priv));
+	if (ret)
+		goto err;
+
 	ret =3D platform_device_add(xhci);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register xHCI device\n");
@@ -192,6 +218,7 @@ void dwc3_host_exit(struct dwc3 *dwc)
 	if (dwc->sys_wakeup)
 		device_init_wakeup(&dwc->xhci->dev, false);
=20
+	dwc3_enable_susphy(dwc, false);
 	platform_device_unregister(dwc->xhci);
 	dwc->xhci =3D NULL;
 }
--=20
2.28.0

