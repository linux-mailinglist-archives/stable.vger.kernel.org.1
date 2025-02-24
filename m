Return-Path: <stable+bounces-119382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20187A42626
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE4A1753F7
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FA3192D8F;
	Mon, 24 Feb 2025 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="cNcBPN1R"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE792A1BA;
	Mon, 24 Feb 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410217; cv=none; b=iFum4WPDYMRF393AOGDZ7qzkaBjSr3o7uxXHr7PoDhwkxbno11jlw1uuOMdaV9I9PNC8zeaxe/4c/chQ87PkrsP1ocemxTt/QNSb/Cvf0wZRzPRLlx5Qw6SjZeDa0Ib32CkSVbTUtuslKrf+bRbaE1imnyYwJ68c8+NHu0GRW5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410217; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=t++pUdpuGLQBWorTg5IftnIQMkAWsdluy0qxRxa41WK6dHr9cKar0zwwFO6wD8r4WB7/EVhBegE/549Vyq/7mnZLqS1zae+97M9Z5OV3b/ll3K2C70nVKtg7Q0nGvUJ3Xsi2A1oyrqRzetnQAt9j3KwjNRokKNm+0V59CmdjbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=cNcBPN1R; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740410212; x=1741015012; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cNcBPN1RnKHGPWUWwpze7TtqhcSKEB+8VIEMcnTmZFPHmZ8g+mg0pEFGpCXjANHG
	 L9rAsjPtSvCPc1cTFMFC0myYUjdeoOuCQrwxyDfFHYBu7FcEwa/eUxIyunwWZeFwQ
	 pIXN5rmVnbm6Kj22pGcu/lS9zH096lGmU1T5Gj4vtK/z1TQWzvKN5LI3fLrO0kcO0
	 Eb+bG7jQotDip+xHHNhzQJfgaM8ZDXXauN1yYBalPYgcsU/Nyrt+4r0KYx5AuQmNe
	 UoZCemf0VcloOls5bkry9f0MLl2aP1NNIIlSg3KEzYfvgMEOW3UoI++Utw+WGuCcF
	 06VS8T4ojiNV3HCsog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.52]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0XD2-1tPQeG1CRY-010obm; Mon, 24
 Feb 2025 16:16:52 +0100
Message-ID: <b253bc36-e350-4e5f-bab6-e1e62d37edfd@gmx.de>
Date: Mon, 24 Feb 2025 16:16:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.13 000/138] 6.13.5-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6RztO2AodvDOZMhplC3xZqVtgl2eYePouzjDoE64LMg83g+3yGy
 1jF9J0OiXtySp2HGRzr8fSe8FQQOufiEQQIFiCHazjVk8lbXRJWzthXcCW74SaEu1YzI5cq
 TCGNfysgeEcJJg9w8rcqt1Cayi8zd93/0qyhwIT1rJjGmftg9kr8rb4TEyoT9UbBZCQLGMW
 HWYJIV3OHm3njpvuvAQhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Erb33eZcZFM=;T5ve6Bm8nh2bdODwOmLVE4/0KaE
 6KaGv+JAA1xJqlJIJBUGcLAallqlWivJyCa+wC4hK9Rq5FXLvuy5+NkkFYFXTX4CgYP6RUHuG
 dEDDsuOVrXFEE4mNVU10JFXVH2bSbluNK0J42wYH6dbyG6Bdl7cVol9ChYPl+giH9CLdv22Pw
 QZKu3/G8q8v4Ll+W6XBo65IbkE4Ha3JHg89IJwZ+2C0qfJZ0uiqx/TBKZZirhmMblRVPK70Dd
 0nCCfb5vBmtg9d865oCViQt7y8UgyYLCZfQ12GUupTnTY4UuNJ0kdeyVVKKVq7LoEQTMdA625
 ZHpLg0LXHR9DsWB8QF6UHtNrYIMLOPlmMb3ZODaCUlVuIiyjLaqF9ccjjk/1jNjucJRy6iSz7
 4u5c4w+q+RaMYOcqqPRA+0Kqtmnq7qtxNN3AAighZzjt5epTiqVBqA/QX9oUp7QfSsCDjSQG4
 pBlZ6QX9siroGetZb12Wv4shcGIi0AdozG1Tpl5fYuOJ1ntIEV4NDvogbxMv3VWBADBcWjXSi
 5kQbU+NQDWWr+DW8nMjj5rDPWbiKMncDKcRi34iqM1mQkIdWMQwoyri2EIz7izhRV1mPXa6ff
 jPU9NB6hqRjVE7OF027ehWzUyFA2uIG8D/PoiJ38yRVWHpPqOfObfQTZFHvfqoil1F0ww02nx
 vDKVjyLgEJNy2r0zAH7V0VSML2FCv6VAg4SgfsQTszlp6rj+TRs/1dNcPK7S/3ObHZndVoKaB
 8zPGAsgn45EzS+JthXpKL+vWnF17EWtukCisvPNTVQux+woizEnG9F7bKdcVZZnlg9kL8hVbT
 DFjKwAOsjtDhhcqfcwGxmVu3o21XOz/eFw+GtRfg3HM8rrXN3/lGSX+3Zsxp86gvv/MfP3jUp
 Az8geh2NfheExSlp595k/7hr2F9ZBFPV9f53mt4axLumQTCHcipoqZSKK5I6n1uzTFTOQh/2p
 xDzHlw9bO9yVfwxQEUeYQkogvOgTmJz8OE39Po4ikhxRXMYcN+n61/l+gVjpGgHcP9JaSdFwA
 eQh1CIVBI0AsDrH2uABDWhzXHTURB83jizcEhmnpMXYjZghFJ+t9bTONZ2haGhNWtQ/B//rXv
 EJwt8hkrpcKMnSUes87C75QNN+f7bubVqxOUtYn0Zm+G7V94mqzd9yHn+j9RlFZs+Ytfb3i4i
 ae/C/o+kRYRBSead3U9CXrtsdvFTbkrIrj4Hsu2y3p4e2qLbBwlkQGpwlNWRU/4Lvloj6mRcE
 BW/KetGP00WZLLts0wmmZXVce+2SL8AmCizT1p23Gc3ffjHvWOFEJc4XoObJzTSIsSVc4B1Ib
 7VX8aN7br1Hx61z2cSw9oM3crVy3BRkGN4M2LdqhGoECjjwjUCZREROlvz1Ymrvmnmfm2UahC
 ldcZtHt+ZTCcamiIQZ5Iz86wbW4IJwyEBVPx9hiVKxTGfi+HL9L5DLuTJN

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

