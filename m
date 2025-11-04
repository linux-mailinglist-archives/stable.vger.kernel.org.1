Return-Path: <stable+bounces-192416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0575EC31D60
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 16:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3972A42536B
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 15:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19D7257836;
	Tue,  4 Nov 2025 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nWtY8GJ/"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDEB24DCE2;
	Tue,  4 Nov 2025 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269928; cv=none; b=pjY3qKYBuGeE2FW5iPXWNz0TWPnuxwAMoW/kanXIKqaw3W7AR9LSHzu+ejxj29576thxuzE5Oeve3wFtZGZ1VEhd5THVRYyBrwCEDCF+EKoQALgi9wposKJALdW/LdOGSkoXCjZSmk3PrlMT8QnUkI4/NHMj6bW5fRiy85MwvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269928; c=relaxed/simple;
	bh=BoVWNY8ZFxQcKe99Bt+iVa9rsj9rkeyoFh/pyqtdAM4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=I+nHF+8pakFK3/vIVej+/aAqv70rF+gH9f9QijU0ACaxX8oekY2E4tk/YOP7mGNZTe3qubGroBm5LBCFOuLjUhDcUHiACp+JX1NAbUlC4BvtJQWnDyaHD/bRGGrdCVizthzF8UjdXNf9Ux5I0e2WtOT7OgaFI0NV5AJ83dHSyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nWtY8GJ/; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762269911; x=1762874711; i=markus.elfring@web.de;
	bh=BoVWNY8ZFxQcKe99Bt+iVa9rsj9rkeyoFh/pyqtdAM4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nWtY8GJ/6bhsHgUzB0CPjmC1H6JMPeW/4F7T3PIg0Gk38tefMN5dR0rWeBECBTVE
	 qFlWTdrs0n7RSlxOAbcEaoedD/lkOZPhm2RLr57Wx/nv72ZCdGBpAP/pU2dauS8/6
	 dPWjZQFGNuMyVR5CqRk/vSPEvRAgBBLdte/HdpOnk22dXzRz45q+WswFK5r5gROza
	 wURphDAWMWgySwK38n8Ci6l63jR7CgL9+cU2ijKp/YVU/TFZk3+nuAEVlGmYLByMq
	 AMaoJ+A0wsj+t3fayJBnxmVeyTc6zwhscoci0TdTsqapsFRZGLJ55nQLAbJZtFh7g
	 lP0zVSoRqi4QwuN5aA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MF2gM-1vRJOx2Tqy-00HWP6; Tue, 04
 Nov 2025 16:25:11 +0100
Message-ID: <250a6e90-a82a-490b-a900-56cc9c5ef05d@web.de>
Date: Tue, 4 Nov 2025 16:25:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn
Cc: akpm@linux-foundation.org, alexander.usyskin@intel.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251104020133.5017-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] mei: Fix error handling in mei_register
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251104020133.5017-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8QSbA8Q+k12ewhQpisQZzFAqJvL8vdEznoUFbMDSR0TvffWxQDY
 YbuA8/kK1zGkZ6puL2HA0DSCMF7umRc0JlWK2zq98kJTPCohMGMhNlig7FttKycZkKHfmnn
 cHFYbFg90Sod9Jz3mrWnFHOgxAcYTr1QmU+JOqPdIjQ4SKBwk7PmJj9Q5hb7mXNeoE//Dcx
 YwWWg5ExikL6sm9nYZRYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tqy0VTVywOQ=;fES5XgHHB/OuLhvtfG2FnS3sO12
 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
 hzFio7Xoo8ht6CJdACFFDYoUTQ=

> mei_register() fails to release the device reference in error paths
=E2=80=A6

