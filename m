Return-Path: <stable+bounces-195441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7E5C76E57
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 02:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 584A234EBC0
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 01:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDE222541B;
	Fri, 21 Nov 2025 01:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manadoceu-com.20230601.gappssmtp.com header.i=@manadoceu-com.20230601.gappssmtp.com header.b="2P56bLBl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2A13774D
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763689978; cv=none; b=nhiFJBkD3B2MwKCkIthNwaBqAv3oUQVAD0xMDLwGWAARX4Pz9bZFfobyAYgi9sjlkjVNslIqOAHfoL9udRxwk6fcE4k3unTm6QojR5O9GdUHUmrTn9Nuw8jPxi7aaOrIRD9rnnevGgZGbeBc0WNDLQTPYsda3iKHlJ6li4QigI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763689978; c=relaxed/simple;
	bh=ackV/WY9uSzn1gxVj4gIblq2Puou2cOPjxzCx5hJNIc=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Content-Type; b=XjLghek4s0hs+QXy+q9ZWFJswzYLMsO0XiQoMB8IWEpqZ+D6f4LepCJr8aBo+wENNyPwkysCFOA1/+B70k4MjT8PiZ6snvvOxCX4nX/h3QdTpuptAS5Mjv+y8AeIPctsbqWzuKZUT51IIUYac1zYXKXgZD7PLGquiD2c/Mtm6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manadoceu.com; spf=pass smtp.mailfrom=manadoceu.com; dkim=pass (2048-bit key) header.d=manadoceu-com.20230601.gappssmtp.com header.i=@manadoceu-com.20230601.gappssmtp.com header.b=2P56bLBl; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manadoceu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manadoceu.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-93917ebde8aso1653880241.1
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 17:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manadoceu-com.20230601.gappssmtp.com; s=20230601; t=1763689975; x=1764294775; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:mime-version
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ackV/WY9uSzn1gxVj4gIblq2Puou2cOPjxzCx5hJNIc=;
        b=2P56bLBlxob/Kn3xw7SAjUb18x+46nZADHM0DsX1fgV3ltUSa/IpZhj9aYtm8oKvnN
         2rlkPP46VkD6bmXstt/vIfzlMDkvvl9Y1JLhxBzWSYRv1ApBBpYNWswRE3MHbzZtHT7f
         tu/wtUMBA7pjpCEYIl01yVWDqHQ8Pmm/d0Kg0MWmLkIfoMH7mpfan+OzdCTV630dcvKV
         TKdDIpVaxBOf3RU9fZuByVNoAs+Sr7ws7mKOzNExSm9IKRCtJ/R7YLFieGOviDkdaDmo
         U/MD2ThRd+D+CYOEpc2pVnYE0GSI/1/OmAiqeCTwqFANW6cRP6fiQ7Kl2NkEGOnKrObw
         e7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763689975; x=1764294775;
        h=content-transfer-encoding:to:subject:message-id:date:mime-version
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ackV/WY9uSzn1gxVj4gIblq2Puou2cOPjxzCx5hJNIc=;
        b=MWnUAfaR43Os+o91XQMyQH7G5DILBb3vkSns3Haf1t6QqrPeXQVMDu7bCoQM7Qzjzd
         aHyB5zTiTCjqVAzYYjXdpyLwD5vNjx1v+DssmD0tsfJGXZSI9JL6C1ti/G7RIYI45iP8
         6PCK/028mWkfcU3WzdYLklp2M2Jks0fY915MaKr0ghzKeCuO8RA/JilQX91axj5NxuMk
         M+sYD5OIS6aKwxiSCBn+znOWdzV1fgtP9pBzJaYUqbZp3H3JTrPZKo8a1cG+ZtIuD7z5
         CV6jqK5lSXhRgY9ihpXqECcIQGxb+tRRjwMShDXrv96LdPRvv+/GMaksfqMPDObssihW
         Rq7g==
X-Gm-Message-State: AOJu0Yyn7edK2pLYRyXB5TWOnaFwkINS06rzEmJD0RiQfNtATmNqdaif
	VYwia/PDN7I7J9wliGSU93HvYcPRzAc4CB9zMmycWqigdeNP57jUiBfWIKXLRlykRZYsAkgIPeE
	b+CU1YF6+OSRnd2MdEISf1+BZRZn7UjoW1fipUmxU9bYH9IuNJewA0RkN
X-Gm-Gg: ASbGncvbTur82+tHSL6oYeqauw1fe90uZxiSlSvENaybVjqgJ6RZls7Vq6iIt8WbKma
	CvEg+Br6SWHwmJp47SEn8xR6Ewk2NYmQw6j0dIyxYglCNNYSdyxCQjSBI4paeo/Th3O0BcLVv53
	QF1ZRtbiPrY77wXRJPtev25jQu9lk5YwBMBDBnzbiPojjrx/0tloyu5E0q1glnZZtl1ROG9yI2F
	d4/UBqadM/hWyORGbL9rrBf+etzRVL+ONNe5tukx9trovGgx1lP0g8MAA8jvo1KcpVPfqF4b+Y6
	tuVdnptn26ALHPtMoK3k9zh6f10nKT3W3IV6Be8x4lE=
X-Google-Smtp-Source: AGHT+IG9Be+YJUClMq7tbfk9p00lXMkXZ35tBG3+zkktqfELw1dPSaEScaM9jdGuOIQrAIg9XpXKRYEOTI99+yHA55A=
X-Received: by 2002:a05:6102:41ab:b0:5a5:57f0:f426 with SMTP id
 ada2fe7eead31-5e1c3bba431mr1997004137.5.1763689974654; Thu, 20 Nov 2025
 17:52:54 -0800 (PST)
Received: from 1046093822762 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Nov 2025 02:52:54 +0100
Received: from 1046093822762 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Nov 2025 02:52:54 +0100
From: =?UTF-8?B?44K144Od44O844OI44K744Oz44K/44O8?= <junfan178@manadoceu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Nov 2025 02:52:54 +0100
X-Gm-Features: AWmQ_bn9H_VRtziOeNHlvUYknLItS3I0SOveS0sbfCIdUlb2q9s0CO4IjY52mGg
Message-ID: <CAGcpx2xyg=ZsTBodWhj=GaFgjDCVyjOPjtAMFmTn0MFG5GPeAg@mail.gmail.com>
Subject: =?UTF-8?B?44CQ6KaB56K66KqN44CR5pys5Lq656K66KqN44GM5b+F6KaB44Gq54q25rOB44GM55m6?=
	=?UTF-8?B?55Sf44GX44Gm44GE44G+44GZ?=
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB
4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSBDQpBbWF6b24uY28uanAg44Kr44K544K/44Oe44O8
44K144O844OT44K5DQrilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHi
lIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIENCg0K44CQ6YeN6KaB44CR
44Ki44Kr44Km44Oz44OI5Yip55So44Gr6Zai44GZ44KL56K66KqN44Gu44GK6aGY44GEDQoNCuW5
s+e0oOOCiOOCiiBBbWF6b24uY28uanAg44K144O844OT44K544KS44GU5Yip55So44GE44Gf44Gg
44GN44CB6Kqg44Gr44GC44KK44GM44Go44GG44GU44GW44GE44G+44GZ44CCDQrjgYrlrqLmp5jj
ga7jgqLjgqvjgqbjg7Pjg4jjgavjgYrjgYTjgabjgIHpgJrluLjjgajjga/nlbDjgarjgovmk43k
vZzjgYzmpJzlh7rjgZXjgozjgb7jgZfjgZ/jgIINCuWuieWFqOOBruOBn+OCgeOAgeacrOS6uuei
uuiqjeOBjOW/heimgeOBqueKtuazgeOBqOOBquOBo+OBpuOBiuOCiuOBvuOBmeOAgg0KDQrnorro
qo3jgYzlrozkuobjgZnjgovjgb7jgafjgIHkuIDpg6jjga7jgrXjg7zjg5PjgrnjgYzliLbpmZDj
gZXjgozjgovloLTlkIjjgYzjgYLjgorjgb7jgZnjgIINCg0K4peGIOeiuuiqjeOBjOW/heimgeOB
qOOBquOBo+OBn+eQhueUsQ0KDQrigLvmnIDov5Hjga7jgqLjgqvjgqbjg7Pjg4jjgqLjgq/jgrvj
grnjgavkuI3lr6njgarmk43kvZzjgYzmpJzlh7rjgZXjgozjgb7jgZfjgZ/jgIINCuKAu+S4jeat
o+WIqeeUqOmYsuatouOBiuOCiOOBs+WPluW8leS/neitt+OBruOBn+OCgeOAgeacrOS6uueiuuiq
jeOBjOW/heimgeOBp+OBmeOAgg0KDQril4Yg5omL57aa44GN44Gu5rWB44KMDQoNCuS4i+iomOOD
quODs+OCr+OCiOOCiuacrOS6uueiuuiqjeODmuODvOOCuOOCkumWi+OBhOOBpuOBj+OBoOOBleOB
hOOAgg0KDQrmjIfnpLrjgavlvpPjgYTjgIHlv4XopoHkuovpoIXjgpLjgZTlhaXlipvjgY/jgaDj
gZXjgYTjgIINCg0K5a6M5LqG5b6M44CB5Yi26ZmQ44GV44KM44Gm44GE44Gf5qmf6IO944GM6YCa
5bi46YCa44KK44GU5Yip55So44GE44Gf44Gg44GR44G+44GZ44CCDQoNCuKWvCDmnKzkurrnorro
qo3jga/jgZPjgaHjgokNCmh0dHBzOi8vem9tYmllLXBjLmNvbS93cGlhcWhrZjgNCg0K4peGIOOB
lOazqOaEj+S6i+mghQ0KDQrigLvnorroqo3jgYzooYzjgo/jgozjgarjgYTloLTlkIjjgIHjgqLj
gqvjgqbjg7Pjg4jjga7kuIDmmYLliLbpmZDjgYzntpnntprjgZXjgozjgb7jgZnjgIINCuKAu+OC
u+OCreODpeODquODhuOCo+WQkeS4iuOBruOBn+OCgeOAgeODkeOCueODr+ODvOODieWkieabtOOC
hOS6jOautemajuiqjeiovOOBruioreWumuOCkuaOqOWlqOOBl+OBvuOBmeOAgg0K4oC76Lqr44Gr
6Kaa44GI44Gu44Gq44GE5Y+W5byV44KE5LiN5a+p44Gq5pON5L2c44GM44GC44KL5aC05ZCI44Gv
44CB6YCf44KE44GL44Gr44Kr44K544K/44Oe44O844K144O844OT44K544G444GU6YCj57Wh44GP
44Gg44GV44GE44CCDQoNCuOBk+OBruODoeODvOODq+OBr+OCouOCq+OCpuODs+ODiOS/neitt+OC
kuebrueahOOBqOOBl+OBpuiHquWLlemAgeS/oeOBleOCjOOBpuOBhOOBvuOBmeOAgg0K44GU6L+U
5L+h44GE44Gf44Gg44GE44Gm44KC44GK562U44GI44Gn44GN44G+44Gb44KT44Gu44Gn44GU5LqG
5om/44GP44Gg44GV44GE44CCDQoNCuKAuyAyMDI1IEFtYXpvbiBKYXBhbiBHLksuIC8gQW1hem9u
LmNvLmpwDQrilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHi
lIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIHilIENCg==

