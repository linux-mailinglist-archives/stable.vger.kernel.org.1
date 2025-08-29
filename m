Return-Path: <stable+bounces-176711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC8B3BD2F
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 16:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F9DB4E0EDD
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697B31DDAB;
	Fri, 29 Aug 2025 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=editrage.com header.i=@editrage.com header.b="fUyjX/NO"
X-Original-To: stable@vger.kernel.org
Received: from eastern.ash.relay.mailchannels.net (eastern.ash.relay.mailchannels.net [23.83.222.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64976313529
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476665; cv=pass; b=SOzqbyHlmbz9kmzwKB5IsoWbGqdsK1evll+l3k12C5Ta7N446iSiUjDOKsMl07vjGdFGjDcwt+xc2i5qQkHnoY5cTKWZpiTRl+KcAtoaZJhri7MiWJ5povmJBnnSUekR3bTMoxQxCEJnsvqkySHYj2W4+TyvOyyEtnfWD346h6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476665; c=relaxed/simple;
	bh=9IxsGYRAMPg5x98/nWpbPT7asTyIzBRl54tEQ1Rvibw=;
	h=Message-ID:From:To:Subject:MIME-Version:Content-Type:Date; b=MXHXjJH1uKenGh6w82JKcbxDLbgG6a4b1Hhg2aL+9HkhR9YrhXUl4sxxs+NI7kwmXDyi5Uq273mAnwmXAohEDZvcMXLNsBRGAjlcS0ZKU1s4F4nQxt6Smd5y257zHTjwEYS8PFNVvlZDOet8JWliaXqER6ExPzChkMv9S4S2Zes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=editrage.com; spf=pass smtp.mailfrom=editrage.com; dkim=pass (2048-bit key) header.d=editrage.com header.i=@editrage.com header.b=fUyjX/NO; arc=pass smtp.client-ip=23.83.222.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=editrage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=editrage.com
X-Sender-Id: hostingeremail|x-authuser|care@editrage.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0FF251622C5
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 13:55:29 +0000 (UTC)
Received: from uk-fast-smtpout4.hostinger.io (100-99-47-133.trex-nlb.outbound.svc.cluster.local [100.99.47.133])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 734541640E1
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 13:55:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1756475728; a=rsa-sha256;
	cv=none;
	b=T9j68neogeIhpF//i87BLLfoesOTcalvs6r/Jc+j/fso+1O7mnzkT7cA/QaBerXW2xyuGC
	mFO4mozpAXd2RXUNs96oxQziokP+/tqPbD00KfsrBXGASFAcAoHJPqE7zu1odPKlZEBPDu
	cYHQ/rbdtcw7UrVAiBOBVBSB74JjiL8htN8degI2IaTqJutxPGiFKp0jyWuc7FGvA95nwR
	/VJ/rxMwHfY+Xq2NfMuX/fwpa05UMiSGnbxIXuEXr2BVJx7YZunXOp4BZDDBLsEBnWR2Ej
	0XUX99tnA+Domrz9gPlTOJuhQrjwqG0UUoykTo4v8jnSB+R4089PXz3o/aNPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1756475728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=9IxsGYRAMPg5x98/nWpbPT7asTyIzBRl54tEQ1Rvibw=;
	b=i25oi0BZANTdtTzzlWlpiu3dJhXIMCS7SmfBS4ppt7GwlYoHoXWDLUUOY/jwY5PGx/DKfC
	BbRoD7Zmy48oaO/Pk831s05CvsrAiAEDhGwhzvB1M0fR8Tob7JrfMBiDlhN1CfzbxbYcIV
	tsJx24hqwRV10eVjixFQl5eaN4m9+LM8SrNBCjRTlIlTA2LuyFVuFpCreC8nYQs9295Gwp
	81iRbV2Mc6QHeHET+5xCN41mx6f9yFs6iKKIPkbfXhL445vHjxDvq/5xmXsadmqvDZS0ss
	2xRlrcaiYczFXE6AU2TozlTnoXoSboPurQ11K1GV59DvHtCeX8vYnLbtdEnkIQ==
ARC-Authentication-Results: i=1;
	rspamd-7758cf9758-6nvtc;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=care@editrage.com
X-Sender-Id: hostingeremail|x-authuser|care@editrage.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|care@editrage.com
X-MailChannels-Auth-Id: hostingeremail
X-Bitter-Occur: 31dd31074938b2a2_1756475728951_269717907
X-MC-Loop-Signature: 1756475728951:2657733381
X-MC-Ingress-Time: 1756475728951
Received: from uk-fast-smtpout4.hostinger.io (uk-fast-smtpout4.hostinger.io
 [31.220.23.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.47.133 (trex/7.1.3);
	Fri, 29 Aug 2025 13:55:28 +0000
Received: from 796fa35a-500a-4f68-a2e9-35da0dd9f2e9.local (ec2-54-88-99-166.compute-1.amazonaws.com [54.88.99.166])
	(Authenticated sender: care@editrage.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cD0CL2xCBz6BKYP
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 13:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=editrage.com;
	s=hostingermail-a; t=1756475726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9IxsGYRAMPg5x98/nWpbPT7asTyIzBRl54tEQ1Rvibw=;
	b=fUyjX/NO/5eUpVIzWsxlfjZLJph4gRehqCx2Cqh2aHhxzu32XA70ScP1ry/akgGQqbugr9
	JYhKcz5Hkt3ArcUXniKyGLLnwohbYdwZGXk78v1lEHUpGT4FJ6wf6kODorQw3jcRpcaE1o
	AhJ3OYzeeZAJNoZZA0RfNBkJcJVXySwB4rK21YeFL7/tMN+t4KMnTl01Q6xedmcSlWeQsy
	Mezjh2FahU7zMa4WMIsBxjOTPo8XpmJ/WhxVT+eQdeR+Gssr6R3v9P4aQL3CMaoYM7GeFp
	trHOMYLOE+0seBOC+5ZQBVpq8Y5Ynuu8Iw/0uY898+IqJsOrpAIgQA+fbNuK3A==
Message-ID: <796fa35a-500a-4f68-a2e9-35da0dd9f2e9@editrage.com>
From: Mohanish Ved <care@editrage.com>
To: stable@vger.kernel.org
Subject: After Hours? Dr. Sam Lavi Cosmetic And Implant Dentistry
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Date: Fri, 29 Aug 2025 13:55:26 +0000 (UTC)
X-CM-Envelope: MS4xfL/2izJFrbQAix6A7Shyj6azdNLNL0XSFI7V0BEymlIbEDnIRFVfaPXmiYqL6Etf+BX1uYVSWjwWiKSddXP1xjoXwjOnHbJOiBf3SIzlziwBer9j1Pjv sKecLz+qLXMvu5Hq+imKwrF4iUBW7c0SeNCtx/qJ9LFQnqKYRPVG3/z8lSf0Xii1fszKls9Es2c4dyU+uYeLLKs8HPjQiLIf0+jnTcRHcABkIpp3Y5AWWIzz
X-CM-Analysis: v=2.4 cv=LvvAyWdc c=1 sm=1 tr=0 ts=68b1b14e a=t64KhGH9s0UiD4gIuDJg+Q==:117 a=t64KhGH9s0UiD4gIuDJg+Q==:17 a=IkcTkHD0fZMA:10 a=CGy6BIFyVvJXCxJuAb0A:9 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10
X-AuthUser: care@editrage.com

Hi Dr. Sam Lavi Cosmetic And Implant Dentistry=C2=A0,

Quick question: what happens when a patient calls after hours about =
implants?
Studies show 35=E2=80=9340% of dental calls go unanswered.

Every unanswered call =3D one implant patient choosing another practice.
We built an AI voice agent that answers every call, educates patients, and =
books consultations
24/7.

Want me to send you a 30-sec demo recording so =
you can hear it in action?
Just reply 'Yes' and I=E2=80=99ll send it right =
away.

=E2=80=94
Best regards, =C2=A0
Mohanish Ved =C2=A0
AI Growth Specialist =C2=A0
EditRage Solutions
=C2=A0

