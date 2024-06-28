Return-Path: <stable+bounces-56090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B68391C5FB
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 20:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176E41F215D7
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 18:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9B1CD5BE;
	Fri, 28 Jun 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gOE6ZzD8"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA23925634;
	Fri, 28 Jun 2024 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600208; cv=none; b=mqE6Dj4fLUp6KaqNbnVuZyHdseyfELW9gr21dO7ijJpO+6oxjTl7+q0Aszj6qcgqcKtW2TI1wk0tblBO2Ha/opyMB4/p26PN+xctYhB0OzRMSAHaMMvK1vvXGZ/W1nqJ+ZHmqcnvBXAxTWh+dljN7FMTUvf154s72hHhh/4VEGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600208; c=relaxed/simple;
	bh=KJMUkM1jYGKiAPCeNxgdd6t4iQyHYgr8dmZgt67P+VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOda0EvdkLhOtcOFTqa4OCnCuOdeXflvtASHuDTaeljSMQIull+mn+Rp01hcs8ZmUVOqeovUduK/ACloJrt00a2bZEshaCos5jJvHR4tQxR1bjkOnZ+wmZfNerrtWhej9YVE82UDxqGTC0FKgSa8SW094T4pDPgqd+HA7wFKob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gOE6ZzD8; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719600173; x=1720204973; i=markus.elfring@web.de;
	bh=8kLvuMEKGAQyx6cCtZ+QA/+5maKkTMNiGRPBdMABdqU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gOE6ZzD8J+wqX9HjXsnxngvxbfKfQDJSMN1B5vqGqN8glDHH5e613E8jTqeSpqyI
	 zhAjOn78zJCZlKCBIortA+tT29V46BeqHZ167JJ4CcCb+kr+kEpKPnCHhSZWw/WHJ
	 W6Eg/GMjch8C5yUbAk7J5pZlyUMOR8GuAxU4lRfVMk5+K4C0rbW9QaDoHoypf/UDU
	 elRxkfnKZCbYvHI9z6ZgKKgjSAEdgeEeFBPdAgFkP+DmnJML4R4+xlHgM8oY2W/9B
	 kbeFKt59ND/RGhE9B4d/r7KmR9AuM/ZnmTRNJqD3mGBzeBMmY2WlJSt48uF4AoWsp
	 hwt05fS7wFgy3zUluw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2BHw-1sSSnL1o0k-00wyOJ; Fri, 28
 Jun 2024 20:42:53 +0200
Message-ID: <a91bbb5f-8980-420b-b465-97691203347e@web.de>
Date: Fri, 28 Jun 2024 20:42:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] drm/nouveau: fix null pointer dereference in
 nouveau_connector_get_modes
To: Lyude Paul <lyude@redhat.com>, Ma Ke <make24@iscas.ac.cn>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich <dakr@redhat.com>,
 Dave Airlie <airlied@redhat.com>, Karol Herbst <kherbst@redhat.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 David Airlie <airlied@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Julia Lawall <julia.lawall@inria.fr>
References: <20240627074204.3023776-1-make24@iscas.ac.cn>
 <d0bef439-5e1d-4ce0-9a24-da74ddc29755@web.de>
 <790dbe8aee621b58ec0ef8d029106cb1c1830a31.camel@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <790dbe8aee621b58ec0ef8d029106cb1c1830a31.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PIL72wbX7r9QZ/mWZLwKF7K8YC1+hNv2EH5ZjPvIhLoaNH3QPtb
 L0VAS7M7j07sfJZ/F2MWvpWAIYJTVzjB2x9tAU2pio8nGAcnftuaTTEErc0GHDci0TO1ChN
 w3ov5KWvo/DVz3Bi36FPjwsBvfxfbTcMYBVx2h52SSNf2UIj9lDszwyw/AxB2i0YQzaZdQm
 fRKP3/stIlvW1CE7tGTiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pweuqzOFyZE=;Tgc+8iwH3HQUokQiNbFoAlSoTjM
 TPqxWWxXB9kukXsacDcZZQRwO6QLIf63UpfXR9PhK3NVUkI8UUpl42ABm+AfcX1qi8D7jeKNK
 hVR6ESGiYP6oL9MlAy4IeRCLQ5Fjuk/44pO5mmjNy3GqhRz/hJybqXd/eEnAMwRENsJ8swmTb
 AudSqXJtUManOQZD/eCqQEHy6Fv8od0Q8MPoBW9FENgahpZLAsxTM01TNIrZ9JTmW96Xe5JGt
 1W5KsbX7HAOZO278O+qjq9CIVo+p7tqiVoBPiYyCbNg0geKnu10yHJFZQM5m/Z5Z73ulekfhH
 qyEz4iYi15gxBAEy0Rr+g2e8DsmaXiU8SHDy7scZB0w4j0kdAXO5lD1n6Z6zX2U9Gku8hKWSQ
 LtglatLo2GJb6fZhOXNfx5aFtFYzGREe00oEEWeE2T8m5gAGlstVbPbQRD5dTAarCLaQrTL6c
 Q0oMHEzovXXnkEuoj5a8j6qnSu1Qn6RQRa/DLARNk0wn/37Fi2mxBp/zsYImhCQf+2xxcRTT+
 ohVvx2vb4JV0PiHdIOeIJmW7+YsZbRsmhqAxg/K3OqE62TVXGWreLuKIpA5V4GYWKYpwJVEsg
 RlsAGIzNM0BT84HQwDf+ArLo34CL5TOkxRzXg0d+Zbrbpwou18p5OpDDXe145/Tz1qDfmWPd5
 bUnLLOGt9RtDtHOInG1sZKrrLYrRV5xKkyTGXsJVNC3ZsmSjPgQAEJ6AHxGfWmo0pV3zx/hct
 60bQ3TPjeKghL8yKkL4FO1TrCMiE7Jf80xr7Jtrw62Uif5PqvysTUnRyDRk0bC0BrRZDelI1L
 EoJ0Q8uvOPxCha6jnUR0jjS/CH7OFCe1KHPrCaUrOJ9JY=

> (...I doubt I'll get a response from Markus,

Why?


>                                              but I certainly want to
> make sure they are a bot

Can I ever adjust your views into more desirable directions
(as it occasionally happened with other contributors)?


>                          and not an actual person before removing them

I hope still that affected development discussions can become
more constructive again.

Regards,
Markus

