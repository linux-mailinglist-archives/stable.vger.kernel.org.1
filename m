Return-Path: <stable+bounces-65279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD729456EA
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 06:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A19DB22C16
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 04:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072671B813;
	Fri,  2 Aug 2024 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=main.intartek.com header.i=@main.intartek.com header.b="duyc++/F"
X-Original-To: stable@vger.kernel.org
Received: from intartek.com (intartek.com [185.20.185.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2D079E5
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 04:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.20.185.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722572474; cv=none; b=dDEW3+0rNQQ91MgpZKQZcWdqXCIs1slsI3RIcj4ut7KDT28XojJnnRe3IIPS+qfEA7D75/eQZFP7GzlyQ7Axp4I9BqU0rLbyK87CNEHB5lKrJCJT+KY//ilceJMf8XzjTBKVeIB/tc9wDiCyRVrbJpl6qO3pYzilw0fibjX17/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722572474; c=relaxed/simple;
	bh=Kiwvf2KW8rCAPOIP4QWJM2jan3rHv+jqKTzoXipejxs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g++LwFUrc/JZD3wSQTZukrg/zWtrgaVfNDKZbAK0tHUvpk+uhz3XpNZaw+VqOhaZEqHQv8dA4rZwgddwBkSITVjOBsl3jNiJWE57D7U7DzqstR/o4KYGxu6Dx6+YdpKAYWNlEoRzkrxdRApFbiEaeAqURo0CDpmARyWmpeoV9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=main.intartek.com; spf=pass smtp.mailfrom=main.intartek.com; dkim=pass (2048-bit key) header.d=main.intartek.com header.i=@main.intartek.com header.b=duyc++/F; arc=none smtp.client-ip=185.20.185.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=main.intartek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=main.intartek.com
Received: from 239.32.165.34.bc.googleusercontent.com (239.32.165.34.bc.googleusercontent.com [34.165.32.239])
	by intartek.com (Postfix) with ESMTPA id A006282375
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 04:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=main.intartek.com;
	s=202406; t=1722572399;
	bh=Kiwvf2KW8rCAPOIP4QWJM2jan3rHv+jqKTzoXipejxs=;
	h=Reply-To:From:To:Subject:Date:From;
	b=duyc++/FrhttCNFYKY0my7SL6JyQwH7QxxhDMWJ+RxFYrzUNM0HwCt4yix4uAO+O6
	 OFQAUZyM0voGxAAJ3kGuNA3Jybfo5FMt94ZBqcbCPTVCTmIbQaJCKLgqOSJ+ZFaXKX
	 vuY5zuz6TAPnA9G3Umm1YBYXP5CeMoEdQn/J9+Jd0AI5Qj2LhhVKmNMVdd+MBN1m9V
	 evh4vu41k36QyzV1Ii7EUleB0phtEHQlzmjvJCUWe7eWGkNZSmuWvGT+VxfVl5s3JE
	 v4jxVvNq4zUHVEm8eA8eMBx1Xem4QhqaAWe4GxI7UglSTCDBYXzrJpxWQANXLtiT9T
	 Qd94hjAduFE5A==
Reply-To: "Antonov|DPR" <antonov@neftelensk.su>
From: "Antonov|DPR" <privateservices@main.intartek.com>
To: stable@vger.kernel.org
Subject: Kazakhstan Crude Oil Product Offer REF:fqgzib01
Date: 2 Aug 2024 04:19:59 +0000
Message-ID: <20240802041959.C2B04711A75BCE2D@main.intartek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dear stable,

I hope this message finds you well. My name is Antonov, and I am=20
a sales representative authorized by leading refineries in=20
Kazakhstan to negotiate the sale of crude oil products worldwide.

If you are interested in purchasing crude oil products, we can=20
facilitate the process. The refinery has sufficient product=20
allocation to supply to serious buyers.

We currently offer a range of products including Petcoke, Ultra-
Low Sulphur Diesel, East Siberia-Pacific Ocean (ESPO) Blend,=20
Russian Light Cycle Oil (LCO), LNG, LPG, Jet Fuel, and more. All=20
our products meet SGS and GOST-R standards, and we guarantee=20
timely delivery.

Thank you for your attention. I look forward to your response and=20
to discussing further details.

Best regards,=20=20
Antonov

Message REF1: ieztudr02Q
Message Timestamp: 8/2/2024 4:19:59 a.m.

