Return-Path: <stable+bounces-119624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4DCA456C6
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 08:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4211176EFC
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A90326A0A6;
	Wed, 26 Feb 2025 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="sHkZr6Gu";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="qzo5Dqqe"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693B17F7;
	Wed, 26 Feb 2025 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555428; cv=fail; b=dO0wm+3ZqXOnTDT5EkPT5Wi0CA6U/Y1u47nNNdPTc6exa7JIcPqG3HKF75DDhWk6B+2i40i7YP2PaGvFKmaAeeM7S89Y9zr10Z7/eUFjeoBxGoc3wXj0Eq4TR6zs39vKk3ca7Duz1snJbf9YLiNtEAC3JW5Wt+BmN6Edu3MlkTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555428; c=relaxed/simple;
	bh=ySXvUdmBxQtnUwWVFfGDzaEjneJ85OlMj4qTvEPXUeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YgE3sGitpctacAIO3dC1BPJY/XdjGz+IjznTahsui3LiHRfYe7v1uwkYbjEwtcwh1Drc/jehjsmp/AvRwzBVvNIpx+IoHTPZTFYDWYuQk29fcLH1GcDjA+j0r8qtmXhFVjlOruVMBJ1SSW+MrchLc17+KcIA9ZZmUasoKQ4H8Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=sHkZr6Gu; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=qzo5Dqqe; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMaPuB026070;
	Tue, 25 Feb 2025 23:23:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=47jMKvR8HipXl5NHGPOJmBB8zM07WqqZFNER8e4HeUg=; b=sHkZr6GuwcCq
	5RwehOcyQhsW92NTBpufAooQxbDAh1MDp5Bftcu16nQ8nGN16xA3p9U16DO+3N2U
	PAY3vR/Ue0+f8OVU9bKX9KunmxkirA7n/C2+H5PEr5sGjOZqtRk5xeA//XuQdzAB
	+IxxNAzPurDkC/dhp2VjODOoCibU8/kvp0zCSbFhQnh6gXa90QMvq8NP2qQ86Wxb
	vNqP5doNHXt+M9TEaFF/FzsI2OATG8kCWJh37n/sHC+MeuhHyxcZdH862ikx/l+N
	ZPPoAP4On309jus2xztE5AjqU8XgbTjG1jjZzAwwbq3YL+uIFMvgxmIxclMXHvsN
	eyC6TEdRvw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012032.outbound.protection.outlook.com [40.93.1.32])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 451pt7hka8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 23:23:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QD0/hDw6/hMauupB8VZYUrMLmK2v7gHPS4eU8uR8x1JN1F+n4MQv82Qw+Zr7jrByfhvh3ZU9bbeIwujaO8C20w78rBqeqni1dYpqDUUbsjCicnytFgdLPL0wNMEkjl5XIZby04GLBAie4Lw2ZIu/T7brOZJuAu+AKoAn3Nk54ZWVk1CTRhaf34jlepewUL34dsfJj8lR5gghud0Ntm0+qw495D5IOb8a6pxVvFWLmfBjOfj0zZMioI/DpmTnt437ubsIPIM2JOVflSmiAFPVHOKZFnhgXcUWAw4eGazDue1BgVIESNx1m9aBo17PozLHFqaYiYGPyZOKXBCOTeRA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47jMKvR8HipXl5NHGPOJmBB8zM07WqqZFNER8e4HeUg=;
 b=U8QNnFp5LQo4JkkESpARzmBLL+xorAZC+Bk9IkJb3LIO8fJ/xhCGzP/10B9qILzmQyUPrGHSw6f9y/6+GNc2oPswqGkZktNOXr0iMd84CzKxqj9nZmhKHwasmm0PDDE0z2XS6VAZsfuQJz8Uxp2i9xnK5ye0hRbfOzyrhZ+uf3mwPIAp0zKk9sK2X4n/WQiTREcCol4SsGcjXyf397+NLUxoyx4OPDAOm+PhmCdnFXM4O172+k0gE5U8u5/KDWYsVQc33Hl88LY+R8YIiPVaFL5hJiyWBnrfX1d/sr0gRYiHhsrxBJ9NWjgnrn3+HHDulEYlqkiX5ExC4kjs2zR/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47jMKvR8HipXl5NHGPOJmBB8zM07WqqZFNER8e4HeUg=;
 b=qzo5DqqeM4d/EFAM71+3ZM5na5GyhB1xSAuSsAS6nI8kuFGO8LyoXmu/YlaRdui7TSIOjvyDrx65F5qqfWwt4If6/a+OtNuX5eQA5P119RzHxBvkYAufXA93TW1pGcZMlIyKzhdOo64wl92zBQim6zjozi+BO59ByPlyVze2JtM=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by DM6PR07MB7209.namprd07.prod.outlook.com (2603:10b6:5:214::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 07:23:17 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%7]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 07:23:16 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
        "make_ruc2021@163.com" <make_ruc2021@163.com>,
        "peter.chen@nxp.com"
	<peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Pawel Eichler <peichler@cadence.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2] usb: xhci: lack of clearing xHC resources
Thread-Topic: [PATCH v2] usb: xhci: lack of clearing xHC resources
Thread-Index: AQHbiB5tjmnPswcsHkKXQ8kMhVwcYrNZLX9w
Date: Wed, 26 Feb 2025 07:23:16 +0000
Message-ID:
 <PH7PR07MB95385E2766D01F3741D418ABDDC22@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250226071646.4034220-1-pawell@cadence.com>
In-Reply-To: <20250226071646.4034220-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBh?=
 =?us-ascii?Q?d2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLTg5Y2JjMDUyLWY0MTItMTFlZi1hOGNi?=
 =?us-ascii?Q?LTAwYmU0MzE0MTUxZVxhbWUtdGVzdFw4OWNiYzA1NC1mNDEyLTExZWYtYThj?=
 =?us-ascii?Q?Yi0wMGJlNDMxNDE1MWVib2R5LnR4dCIgc3o9IjY3OTIiIHQ9IjEzMzg1MDI4?=
 =?us-ascii?Q?MTk0MDE5NTAyNiIgaD0ieFZwV2dHL0YyeHFOWkIzd2pnWDhaVnVBMWxBPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?R0FJQUFEU2xpRk1INGpiQWNzTWFuQ0VQTmtueXd4cWNJUTgyU2NLQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBQXNCZ0FBbkFZQUFNUUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQVFBQkFBQUFoRlY4eVFBQUFBQUFBQUFBQUFBQUFKNEFBQUJq?=
 =?us-ascii?Q?QUdFQVpBQmxBRzRBWXdCbEFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFh?=
 =?us-ascii?Q?UUJoQUd3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFaQUJ1QUY4QWRnQm9B?=
 =?us-ascii?Q?R1FBYkFCZkFHc0FaUUI1QUhjQWJ3QnlBR1FBY3dBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBWXdCdkFHNEFkQUJsQUc0QWRBQmZBRzBBWVFCMEFH?=
 =?us-ascii?Q?TUFhQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBTkFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWVFCekFHMEFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refone:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFu?=
 =?us-ascii?Q?Z0FBQUhNQWJ3QjFBSElBWXdCbEFHTUFid0JrQUdVQVh3QmpBSEFBY0FBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFjd0J2QUhVQWNn?=
 =?us-ascii?Q?QmpBR1VBWXdCdkFHUUFaUUJmQUdNQWN3QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFB?=
 =?us-ascii?Q?QUFBQUFBQUFJQUFBQUFBSjRBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFC?=
 =?us-ascii?Q?bEFGOEFaZ0J2QUhJQWRBQnlBR0VBYmdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFB?=
 =?us-ascii?Q?QW5nQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCcUFHRUFkZ0Jo?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWN3QnZBSFVB?=
 =?us-ascii?Q?Y2dCakFHVUFZd0J2QUdRQVpRQmZBSEFBZVFCMEFHZ0Fid0J1QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUc4?=
 =?us-ascii?Q?QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWNnQjFBR0lBZVFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBeEFFQUFBQUFBQUFJQUFBQUFBQUFBQWdB?=
 =?us-ascii?Q?QUFBQUFBQUFDQUFBQUFBQUFBQ2tBUUFBQ2dBQUFESUFBQUFBQUFBQVl3QmhB?=
 =?us-ascii?Q?R1FBWlFCdUFHTUFaUUJmQUdNQWJ3QnVBR1lBYVFCa0FHVUFiZ0IwQUdrQVlR?=
 =?us-ascii?Q?QnNBQUFBTEFBQUFBQUFBQUJqQUdRQWJnQmZBSFlBYUFCa0FHd0FYd0JyQUdV?=
 =?us-ascii?Q?QWVRQjNBRzhBY2dCa0FITUFBQUFrQUFBQURRQUFBR01BYndCdUFIUUFaUUJ1?=
 =?us-ascii?Q?QUhRQVh3QnRBR0VBZEFCakFHZ0FBQUFtQUFBQUFBQUFBSE1BYndCMUFISUFZ?=
 =?us-ascii?Q?d0JsQUdNQWJ3QmtBR1VBWHdCaEFITUFiUUFBQUNZQUFBQUFBQUFBY3dCdkFI?=
 =?us-ascii?Q?VUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFHTUFjQUJ3QUFBQUpBQUFBQUFBQUFC?=
 =?us-ascii?Q?ekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZd0J6QUFBQUxnQUFBQUFB?=
 =?us-ascii?Q?QUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFaZ0J2QUhJQWRBQnlB?=
 =?us-ascii?Q?R0VBYmdBQUFDZ0FBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpR?=
 =?us-ascii?Q?QmZBR29BWVFCMkFHRUFBQUFzQUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdN?=
 =?us-ascii?Q?QWJ3QmtBR1VBWHdCd0FIa0FkQUJvQUc4QWJnQUFBQ2dBQUFBQUFBQUFjd0J2?=
 =?us-ascii?Q?QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJmQUhJQWRRQmlBSGtBQUFBPSIvPjwv?=
 =?us-ascii?Q?bWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|DM6PR07MB7209:EE_
x-ms-office365-filtering-correlation-id: 3ac8168b-eb5b-4581-62b2-08dd5636702b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kwIev2ytvB8HfiNmj6kKMJOoqvVawTDwZKorBf8Bqch4LGOezLJipKiYAcF4?=
 =?us-ascii?Q?1hpCtfB+psqvK1/fQKedHcHEhc2QICif2hi+1wWiFwzGKMHRXhMJYQU57OQJ?=
 =?us-ascii?Q?Zy+cZsUl61LLs717bupwpJLTnhOmQkccl5lEaRu36a2ph7pYKxn/u/I/R7j+?=
 =?us-ascii?Q?Mazd4qAYIP1IWn8hTyCfmPBS+TqSmmsIXfEpgh7PISope0QbAcdFLUpRPqAV?=
 =?us-ascii?Q?qzYuAMoBYe8P7rFioVP5bnTteiiKDJ4OyCoiZHgrqLe6Ew9Z8sn/BKd8GjW1?=
 =?us-ascii?Q?rMVvAHGMXwKRby2g+r7jVtWbq7IlyVu83u/NkqqX1t529/6IsKxBbBvBr9eZ?=
 =?us-ascii?Q?9V6CO3FQcsPXz15QxZ9ymh4tk20kS7/g8yIcmRB2o+YMu3+w4HSe9zyWipiy?=
 =?us-ascii?Q?JONKkKEupxhCnEAMEqgH/PWc4NXK0ChCeFnq8NpEZezV+eQ/XHDbUlaKJ5TN?=
 =?us-ascii?Q?q8YwgOXg5Ii7Hif8mbeZwbmofN8VAhj1OthaDJLm0m+3Ew8F7pWZVIBfXQpm?=
 =?us-ascii?Q?tc+8n8gPEVpGNKNHnnzLAf4t+I1WBbKBeWcs9ITJ4I3ojNwQ1Uxid/N/8HMZ?=
 =?us-ascii?Q?Ht9cMKZrK9nCcVS9ZL077hWaaOMHKCL845o4IeOSfT11/LN1Y+OvxULSOdJB?=
 =?us-ascii?Q?I0X8vyqD4eNVd0Cdj1fyuYkjlcNX9JZzCztOA/suA7Olf16c5zydPO04BbH9?=
 =?us-ascii?Q?LgyanVo1ICPJpTCFxju004yZaLadUPWq88+gNtWdu4iOG2o/CBIYMo3sUMjd?=
 =?us-ascii?Q?unR87QmAi+X16G6Pawyzd/WrzqpIHxySxf5sPAeNcXSTQcOcuWMws+0jycjv?=
 =?us-ascii?Q?mUoOaQYo03lUPL6+ukNrpMRXI/pfkTlwm1xwH4dWUiMTkkeT/ZBgieln31fS?=
 =?us-ascii?Q?TRLOsMLt7QDFzwNR1423v3kPaUyyysPi93fe3mjbK2f96VhLU3LvZxI74RP1?=
 =?us-ascii?Q?T1O7SVzmJ/6xYWrLON0Z6b7IXDASDM5YBe01ijGg7eXAazbFTDvXC4o+nbNR?=
 =?us-ascii?Q?kHinHLt6HwMmu46NN9CSc/x3L7CAAcaBwdK6gFt9FqvpMd09okwv2fKtnPl9?=
 =?us-ascii?Q?8DVlX84cskxX8ew66vd1nZzeQr1i4hmOMDKK8uTy0sUqVMpkhoDQtuxeH8+H?=
 =?us-ascii?Q?GPqBEWwPq1G766eE5R2LN6df3Gi/4TkHUqUr132V3DGE83xY0JX2ht9QOFbK?=
 =?us-ascii?Q?TjpyuE5JlIJuMxz6sMMFBbIr5IOImUwPEiyRotxG1liKsttKK80rGZ6+Kzi5?=
 =?us-ascii?Q?BPE+hQYK+pjB9P1FWLK3HoHteo83zn24M5xyUBS0h3I3UnqSSOuVhHj1JjB7?=
 =?us-ascii?Q?f2yFEeMST5jmJJW0y2ZFpb5Vwt9Sn6ZGouZU7wm6eaIw8S+YBXmeCzHM84Je?=
 =?us-ascii?Q?KRekWayEJqOM9GUxzoywNztYoLSB08vfGLiSbVIhXsefIV0QIeExugsqUNAH?=
 =?us-ascii?Q?hjSD+xERDmmExb/eAJ3wIixn+nLLvZNu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+BvgWJqWPYxsYYaHmslpyORWX/8UOr/6BRiEzkRSGszcZ5kTjoEPpXRsZwbS?=
 =?us-ascii?Q?yec0ePE3DekBF2UlCnT3dJfh9/85nU5oVgVP1RoZtT/h0tx4HDS+X0AZGQQ2?=
 =?us-ascii?Q?z8CK5D9RbtK5/VobekYMNiO+kypDJhdYdol3UbGfqWUqkfe4ghxyWB/EZ58m?=
 =?us-ascii?Q?IT2NfFVggvdy33VNYNK7a9BB0VZBImxp2QtDzCNGZc0Xd7srXNn12UNTZDFx?=
 =?us-ascii?Q?I7s4dD3CsAxsvpgOvEdjY55yxMAUIu9Yss8HayWEQGZDJ3+B7ceu3RxLmg/Q?=
 =?us-ascii?Q?7kGwJg8obkNJLhtv5vvPMWOP62xERa71HnXseKFPNhJZFamx62OQmMDrPAd1?=
 =?us-ascii?Q?1vstD4MBa54OGtWU2y8B3n0twliLNwt2uZWdsMLsIddqj6mO+1++N/NLRXHz?=
 =?us-ascii?Q?wKrTCIRXOyqA9zicCDmU6l0bY7P1BeUf72Qn7wFs/28MBDQtvUSlr3FXMU65?=
 =?us-ascii?Q?I2xXxVlfArFWJPOsjWQPnflKOKK0Ckyu/3kO1rwaIdxgkfV1TT4gTraqkjwM?=
 =?us-ascii?Q?173G0Z2wUm+liA2WlupktK57LHMGq57ISkzXdYO5tkeB7BmV3ib/R70o8kp7?=
 =?us-ascii?Q?TOtSt7QFh/rw4lLlO0tOMN5Ludj6xVhmHEDqlc+zpOYf2+ZJ/Ib0+cmpwqSD?=
 =?us-ascii?Q?lWS+aG2G0qEDJsbD2WWXTt5Bx9XHQ/MFQkbEAwLSuAnBH5lavgl/pFNFStPy?=
 =?us-ascii?Q?4Xh7gawec2qpMUzMjSyQyttszc1uuRdKzihVr2wP4y+AKwndxItypBIxodyc?=
 =?us-ascii?Q?ixN2avfy+jjzoMdd3y+SH3PMrh67IN3hxYLCH57ook9iQGYrYpJGO9aqf/nm?=
 =?us-ascii?Q?U4/47DvjLXa/ilNFL5fiSwOgo5LU1DrsC/Gv5GQMuO9yfkddYk0p8W5JGDCq?=
 =?us-ascii?Q?AGSYO1g6m5xw2tKyIJgpvwAPM5B9gL+YhwW2XdsDtqqoW/l/+oP3mKRkNbFl?=
 =?us-ascii?Q?y1c1xKedp1SQFPBsm5JXPu+QCLuQWgTPiMPNiNGwPSgdyXbik9PkPTU8WjoB?=
 =?us-ascii?Q?5WVhorOczN35qhdxMp9Zd0+ZFzvXOKenBvesP5qIc+xbh6CqeH1PaOQi7nDn?=
 =?us-ascii?Q?5ncuiiVE320dKiSHFKRc3f8Sky1iieGqt0BQM9uDVBc/zoQ34W00sfXneGlp?=
 =?us-ascii?Q?YT6aCTsunolQy8J7HVMZcpjMpgXAx8y7dxy4ATwNXNV4OCZkWVzx4R4RjIWV?=
 =?us-ascii?Q?E/uXEE72e+z+gSkoJA8OgaD0T1mrO2rPJAC1dHVomnvMtI+LH0PI+5RVi05b?=
 =?us-ascii?Q?Q+E7Gcb5mRz81VZSmeXF/6L12PCnMR34YFzg4D2DIt86padam45Cl7WaIyrc?=
 =?us-ascii?Q?hCvbLqPCXQBAbXxfiMYsgPPc3D8+/YVMXEL60SXx3d9BdL4wXyEIIMHOQ9WN?=
 =?us-ascii?Q?zrWB3FbYYdIa6wrBfAumimNLokyx18fD9dNGcgaPT8Mx3yYVaC9M8I5djqcj?=
 =?us-ascii?Q?0Cx9C6ZBfsB4CCmdtq+5vWDfWPDNn186jzwFGZxqCwMP02EiNTlPLwcd9F4X?=
 =?us-ascii?Q?hY2CqPKZrW8qgovDBaLtAIG2w5xEVic+NB+K8GIag/Xk8qho2rjCx4yl1vk5?=
 =?us-ascii?Q?Y1uqkqguhL7gqUe8D5WGO70eRCDOGYl0R1OSu4BV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac8168b-eb5b-4581-62b2-08dd5636702b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 07:23:16.6061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZ9tyVUcCjvQh/ue91xLMbmVjDMa99+9/YYOmIuK+zgVCYbvPGWM1S50B1rgt6RFvBPDuAGtqWpjU7h+rUEhVhSKPPz/uG5oco1FfNhSRm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7209
X-Proofpoint-ORIG-GUID: Pi22OaxRAKm5tdp-UaYo2mgBX6XPeD5u
X-Authority-Analysis: v=2.4 cv=B8xD0PtM c=1 sm=1 tr=0 ts=67bec168 cx=c_pps a=fM4bIjZpJamw6RFag0UgWw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=Zpq2whiEiuAA:10
 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=fAtflJM7RsOH10yn2owA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: Pi22OaxRAKm5tdp-UaYo2mgBX6XPeD5u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=709
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260057

The xHC resources allocated for USB devices are not released in correct
order after resuming in case when while suspend device was reconnected.

This issue has been detected during the fallowing scenario:
- connect hub HS to root port
- connect LS/FS device to hub port
- wait for enumeration to finish
- force host to suspend
- reconnect hub attached to root port
- wake host

For this scenario during enumeration of USB LS/FS device the Cadence xHC
reports completion error code for xHC commands because the xHC resources
used for devices has not been property released.
XHCI specification doesn't mention that device can be reset in any order
so, we should not treat this issue as Cadence xHC controller bug.
Similar as during disconnecting in this case the device resources should
be cleared starting form the last usb device in tree toward the root hub.
To fix this issue usbcore driver should call hcd->driver->reset_device
for all USB devices connected to hub which was reconnected while
suspending.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: <stable@vger.kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>

---
Changelog:
v2:
- Replaced disconnection procedure with releasing only the xHC resources

 drivers/usb/core/hub.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index a76bb50b6202..d3f89528a414 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6065,6 +6065,36 @@ void usb_hub_cleanup(void)
 	usb_deregister(&hub_driver);
 } /* usb_hub_cleanup() */
=20
+/**
+ * hub_hc_release_resources - clear resources used by host controller
+ * @pdev: pointer to device being released
+ *
+ * Context: task context, might sleep
+ *
+ * Function releases the host controller resources in correct order before
+ * making any operation on resuming usb device. The host controller resour=
ces
+ * allocated for devices in tree should be released starting from the last
+ * usb device in tree toward the root hub. This function is used only duri=
ng
+ * resuming device when usb device require reinitialization - that is, whe=
n
+ * flag udev->reset_resume is set.
+ *
+ * This call is synchronous, and may not be used in an interrupt context.
+ */
+static void hub_hc_release_resources(struct usb_device *udev)
+{
+	struct usb_hub *hub =3D usb_hub_to_struct_hub(udev);
+	struct usb_hcd *hcd =3D bus_to_hcd(udev->bus);
+	int i;
+
+	/* Release up resources for all children before this device */
+	for (i =3D 0; i < udev->maxchild; i++)
+		if (hub->ports[i]->child)
+			hub_hc_release_resources(hub->ports[i]->child);
+
+	if (hcd->driver->reset_device)
+		hcd->driver->reset_device(hcd, udev);
+}
+
 /**
  * usb_reset_and_verify_device - perform a USB port reset to reinitialize =
a device
  * @udev: device to reset (not in SUSPENDED or NOTATTACHED state)
@@ -6131,6 +6161,9 @@ static int usb_reset_and_verify_device(struct usb_dev=
ice *udev)
=20
 	mutex_lock(hcd->address0_mutex);
=20
+	if (udev->reset_resume)
+		hub_hc_release_resources(udev);
+
 	for (i =3D 0; i < PORT_INIT_TRIES; ++i) {
 		if (hub_port_stop_enumerate(parent_hub, port1, i)) {
 			ret =3D -ENODEV;
--=20
2.43.0


