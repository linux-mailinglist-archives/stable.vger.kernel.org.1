Return-Path: <stable+bounces-159146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C87AEFB0A
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 15:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A773B7304
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 13:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61E7274FC6;
	Tue,  1 Jul 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="fGGNZbcq";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b="EjZzBSgO"
X-Original-To: stable@vger.kernel.org
Received: from mail186-10.suw21.mandrillapp.com (mail186-10.suw21.mandrillapp.com [198.2.186.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9889D1F2361
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.186.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377465; cv=none; b=cKwUDaG830zOTmzFrmHkOr2xjuCMIbvlgUfCcfegTaH/qqStDPrH5/PxUMQnWYkbD3hyYVP2TfJKn4jGdBDgtT5rTT0HZMsUYnupOEQmhz6r82IGUGQK668zv8PedXGd/LpsVnVudaIzQ80I4lPfXsw32+qQ9jhvKQz02DGMEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377465; c=relaxed/simple;
	bh=Fu2AR7N95kwkk6uGhlud+mmHn0op8m1cxkX9nYU0p/c=;
	h=From:Subject:Message-Id:To:Date:MIME-Version:Content-Type; b=tJAteb1doorcV7STYYJmPNQLguanV5vTGkSmWcmpaXT95tm8pi6U6XpHIFKOv6xcPMvxIKhYbAk7X2itxDy+HPfJnnKbMm2uUeJsQbJ8Bnhb5ONOU+lNeeBVU2bSViUgWSAQa/EZp/cVGQJYqX4RYoLfN3ld3peQjA4JZHVO0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=fGGNZbcq; dkim=pass (2048-bit key) header.d=vates.tech header.i=yann.sionneau@vates.tech header.b=EjZzBSgO; arc=none smtp.client-ip=198.2.186.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1751377462; x=1751647462;
	bh=r/YgAJTgEX+qwmEdlPxMF/lVbC76mSiexRAdgTnwdA8=;
	h=From:Subject:Message-Id:To:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=fGGNZbcqFacnbmogiAfzmFOWzTY3jRdv7EbsUc6SV4hxRfLITMJCUgyiNwofsCPWS
	 qpgJUr71NwuKiiq3J0vD024ns3dJlHhMGHIHz+MiSwtq0/CJicemm5ct8Lj2rETJig
	 Jib7CaBVc5EP22CULQF0czjSdmWbv5fptXzuyeS+bqQlbNF1Fhc90PchhEPm550kAK
	 Ka7NsD+ddmsniw1QUhWvqIHMGSUGWk+p075CQ9LExbZt/doD+NMmIgSHopk5UakUUx
	 okNIKHsKB7h0KZ6AgFTd59Ldmi7mpc6LIxsF3br669PMeBBLRRI9zJFBdUtRs/VLc0
	 oX9RDfQNCoEfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1751377462; x=1751637962; i=yann.sionneau@vates.tech;
	bh=r/YgAJTgEX+qwmEdlPxMF/lVbC76mSiexRAdgTnwdA8=;
	h=From:Subject:Message-Id:To:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=EjZzBSgOpvJsPIIDY62jAlSMsOWW3kd+8vGSIVw7rKUE26Njlwc+KKCgKPPH+/whe
	 dui5pBfwduI2T9I/EI0V5uR+5G1GWoIyP11ELCEnCGMiGv0l9Cw23KYpXPdTTX+iCT
	 zqVRxobL/dloEeOdAfe1gvncbodWaHEUUiMClvgKzSQY9J8vCganYNDV2TwhrsLcOU
	 FHfcElzahH3yDNgSuZvY9nxEFJ1ZnLbUSRi1+VF4hkj/vG5qeksieYTu6qB/lz3N1+
	 xiHDP1MS53evTWCPN5FC+kSd9kt+s20BUSH2ByIsjH1Ubal/5UDhbdwxCMeHGUs4pQ
	 ebJR6KYstGubQ==
Received: from pmta10.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail186-10.suw21.mandrillapp.com (Mailchimp) with ESMTP id 4bWklp2Pz0z5QkLpC
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 13:44:22 +0000 (GMT)
From: "Yann Sionneau" <yann.sionneau@vates.tech>
Subject: =?utf-8?Q?Fix=20forgotten=20in=20stable=20backports=3F?=
Received: from [37.26.189.201] by mandrillapp.com id f0dd40862b344ecb8f38c103b5e74b7a; Tue, 01 Jul 2025 13:44:22 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1751377459041
Message-Id: <fb7b2cd7-02bf-439a-8310-f507a4598c28@vates.tech>
To: gregkh@linuxfoundation.org, "Li Zhong" <floridsleeves@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, stable@vger.kernel.org
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.f0dd40862b344ecb8f38c103b5e74b7a?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250701:md
Date: Tue, 01 Jul 2025 13:44:22 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello Greg, all,

I am wondering if by accident this fix would have been forgotten while 
backporting to stable branches: 2437513a814b3e93bd02879740a8a06e52e2cf7d ?

It has been backported in 6.0 and 6.1:

* https://lore.kernel.org/all/20221228144352.366979745@linuxfoundation.org/

* https://lore.kernel.org/all/20221228144356.096159479@linuxfoundation.org/

But not in 5.4, 5.10, 5.15

Even though, indeed, the patch would not apply as such, but it seems 
trivial to adapt.

Downstream XCP-ng (Xen based distribution for virtualization solution) 
is about to package it 
https://github.com/xcp-ng-rpms/kernel/pull/20/files (that's how I 
noticed the lack of backport).

Or maybe it was intentional?

Thanks for your lights :)

Regards,

PS: please CC me in answer since I'm not subscribed to stable@ mailing list.

-- 

Yann Sionneau



Yann Sionneau | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


