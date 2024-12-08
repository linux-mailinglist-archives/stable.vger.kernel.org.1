Return-Path: <stable+bounces-100077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AE09E861C
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 17:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A431882759
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F57155CBA;
	Sun,  8 Dec 2024 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Blj8lxaz"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE202145B26
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673660; cv=none; b=JvOJg+OcsmPuAvPkbxMNKMCjsBKJrGF+R/vinYEBlzT5N/ulmPuP9P9VDHuo3iT8gVY5ByPyI8yv4ckItRPkw3VVMmhHTfOYML4x8JNwv3Ln9bFRc3ckj5OxKJJy/WhNX4XG2IcHsQkM+aeohKzSixlvcbxhv8vEKp3GJ97Yk3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673660; c=relaxed/simple;
	bh=tc1mgW5PK5ygm6MHNIYT+f+xz3FXBUJynWj95Qcz6B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=dNdRkMavFdayLrll+TYVtvTvfLSX49+d2Wfb7aYOCT+7RLeknoAdJWejZtW7dIkX0C3A3Jr/rpbeoxqWAJaj0ueD2HRkEwW/FPO13hqz+dPxZbirQcEeXXnnMtSnxvJIRK3Lygf8hm2I5ZwfJKf5mqAHde58kMLpstebH44Bu8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Blj8lxaz; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241208160055epoutp01a366ff8c4249db7c7238cc3b86a075a8~PPwEkrndO0451804518epoutp01F
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 16:00:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241208160055epoutp01a366ff8c4249db7c7238cc3b86a075a8~PPwEkrndO0451804518epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733673655;
	bh=tc1mgW5PK5ygm6MHNIYT+f+xz3FXBUJynWj95Qcz6B8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Blj8lxazXZ+SzLivOM6g97/+ygtB4MVLGAJPghnrZ4OasDUhX/BTIa+FWNHv65FNO
	 eyyY5cMZmqQdcgSAUMy18zHquyI8jfAVWgiEL276Yw3CE80rxDJjSygz/LdvIhxm/M
	 5UlWg+gkFbXTilRWJ+E7ZxiFuDFddCgieN9YBmS0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241208160054epcas5p309433a674397ddd7349591b8527ffd45~PPwD6V0b71913419134epcas5p3E;
	Sun,  8 Dec 2024 16:00:54 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y5qTx5v2nz4x9Pt; Sun,  8 Dec
	2024 16:00:53 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E0.66.19956.5B2C5576; Mon,  9 Dec 2024 01:00:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241208160052epcas5p3eeba799ad78f0269ba04fabb28fa6a4c~PPwB3slq41913419134epcas5p3C;
	Sun,  8 Dec 2024 16:00:52 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241208160052epsmtrp29e8ed21f8f687b3989c0cd6a5a2e4b52~PPwB2iZBc2725827258epsmtrp2i;
	Sun,  8 Dec 2024 16:00:52 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-be-6755c2b50d88
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.2D.18949.4B2C5576; Mon,  9 Dec 2024 01:00:52 +0900 (KST)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241208160050epsmtip20eb6acf7e18c6f35546a61be5e06621b~PPv-S7fZx0093200932epsmtip2Y;
	Sun,  8 Dec 2024 16:00:49 +0000 (GMT)
Message-ID: <78fd3960-6c7f-48a1-a12a-04190640c001@samsung.com>
Date: Sun, 8 Dec 2024 21:30:48 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Faraz Ata <faraz.ata@samsung.com>, quic_jjohnson@quicinc.com,
	kees@kernel.org, abdul.rahim@myyahoo.com, m.grzeschik@pengutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	alim.akhtar@samsung.com, stable@vger.kernel.org
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <2024120809-frostlike-dingy-1113@gregkh>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmuu7WQ6HpBp1N2hbTp21ktXhzdRWr
	xYN529gs7iyYxmRxavlCJotrNxayWzQvXs9mMWnPVhaLuw9/sFise3ue1eLyrjlsFouWtTJb
	bGm7wmTx6eh/VovGLXdZLVZ1zmGxuPx9J7PFgo2PGC0mHRR1EPbYtKqTzWP/3DXsHsdeHGf3
	6P9r4DFxT51H35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgr
	KeQl5qbaKrn4BOi6ZeYAfaKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtO
	zC0uzUvXy0stsTI0MDAyBSpMyM5YPL2VseAjc8Wy3vesDYxzmLsYOTkkBEwkps3YzdbFyMUh
	JLCbUWL1h3PMEM4nRonGte3sEM43Roll81eww7Sc/boTqmUvo0Tf349QLW8ZJXb/28wEUsUr
	YCdx5tRKsCUsAioS1y/tZ4aIC0qcnPmEBcQWFZCXuH9rBthUYYFMia/TuxhBbBEBDYmXR2+x
	gAxlFjjPLPHh/XNWkASzgLjErSfzgRZwcLAJGEo8O2EDEuYUMJU4//oME0SJvMT2tzDPfeGQ
	eDy/CMJ2kWg69Q3qA2GJV8e3QNlSEp/f7WWDsJMl9kz6AhXPkDi06hDUHHuJ1QvOsIKsZRbQ
	lFi/Sx9iFZ9E7+8nYNdICPBKdLQJQVSrSpxqvAw1UVri3pJrrBC2h8SbD4dZ4EE1b+cPlgmM
	CrOQQmUWkidnIflmFsLmBYwsqxglUwuKc9NTi00LjPNSy+ERnpyfu4kRnNC1vHcwPnrwQe8Q
	IxMH4yFGCQ5mJRFeDu/QdCHelMTKqtSi/Pii0pzU4kOMpsDomcgsJZqcD8wpeSXxhiaWBiZm
	ZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB9DFxcEo1MPk9+vFmNVfRlM6dL+J+S/C+ZXfZ
	51lwf8l5f4+ueZOvvpj7TnrStFu+D6badE9I4/GeKvA9vVBl4UITbq+dZ87uuWVTZ5M2OVmo
	N+3PnEVT9nhPlrbnnrdGa4WW6+wcjZCfX/fHud97eUsuSeX0dc7jAaKfnPRZk/uD+8OOnXP0
	OeN87Vb+mzSf3aXqhV3c9hXcruaVaqbWEovO3eyV2RyxPjTmz0blTpfV/nuN1t45m/jlsuw9
	Rt/TDQe7dDZc2cl8/OUSk7A7cum9bc6z768/lKB1dvJVtudaypd++c9+JGcntHbjIXvOJXpO
	+0tUz3fKs4QuK5h6/4K6V9+cnSd1OWL/cbmU2FWvmrfq9mUlluKMREMt5qLiRACfewzdcQQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSvO6WQ6HpBj0TNSymT9vIavHm6ipW
	iwfztrFZ3Fkwjcni1PKFTBbXbixkt2hevJ7NYtKerSwWdx/+YLFY9/Y8q8XlXXPYLBYta2W2
	2NJ2hcni09H/rBaNW+6yWqzqnMNicfn7TmaLBRsfMVpMOijqIOyxaVUnm8f+uWvYPY69OM7u
	0f/XwGPinjqPvi2rGD0+b5ILYI/isklJzcksSy3St0vgylg8vZWx4CNzxbLe96wNjHOYuxg5
	OSQETCTOft3J1sXIxSEksJtRYv7MKewQCWmJ17O6GCFsYYmV/56zQxS9ZpSYsP0LK0iCV8BO
	4syplWCTWARUJK5f2s8MEReUODnzCQuILSogL3H/1gywocICmRL3Ts1kA7FFBDQkXh69xQIy
	lFngPLPE7cuPWSA2vGWU+HL8FVg3s4C4xK0n85m6GDk42AQMJZ6dsAEJcwqYSpx/fYYJosRM
	omsrxKXMQMu2v53DPIFRaBaSO2YhmTQLScssJC0LGFlWMUqmFhTnpucWGxYY5aWW6xUn5haX
	5qXrJefnbmIEx6+W1g7GPas+6B1iZOJgPMQowcGsJMLL4R2aLsSbklhZlVqUH19UmpNafIhR
	moNFSZz32+veFCGB9MSS1OzU1ILUIpgsEwenVANT8GdO1QeVy41lXi84pvRR0aCOO3Tilofr
	vHX4XSIr7X4lGP1SMCrnXnCJ9QmD3a78gGSpreblUvVTc4Nle+dLCKzaGN7Y+zTw8rKMmR+q
	0mS2hQQYOjP1XfasNfY6NUfeYtb1mLlLNs+QvRelJ8XLZdnAWaqSqR2SkXjR4NWU51t9Lju4
	+zbVPfl/PvrRJqHetzOzXb5s0s/LtlisLPRi1uvvm6eaNMc8u3rnyc05lWzGpQWvOu6UFb7J
	UZFpqk9c21Owdp+aYOCD0kWswTrH94ltPn0tZ9Pah8EPotnu/ujd+Grv0WUPhetfCoVe87V8
	NydY+7l3e4P3JZG1M3dXnXKrmXTEk686Ou3omVtKLMUZiYZazEXFiQBbSs/vTgMAAA==
X-CMS-MailID: 20241208160052epcas5p3eeba799ad78f0269ba04fabb28fa6a4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241208151349epcas5p1a94ca45020318f54885072d4987160b3
References: <CGME20241208151349epcas5p1a94ca45020318f54885072d4987160b3@epcas5p1.samsung.com>
	<20241208151314.1625-1-faraz.ata@samsung.com>
	<5d4e59f0-76a7-43bf-8a96-9aa4f9e2a9ac@samsung.com>
	<2024120809-frostlike-dingy-1113@gregkh>


On 12/8/2024 9:18 PM, Greg KH wrote:
> On Sun, Dec 08, 2024 at 08:58:32PM +0530, Selvarasu Ganesan wrote:
>> Hello Maintainers,
>>
>> Please ignore this commit as this duplicate copy of
>> https://lore.kernel.org/linux-usb/20241208152322.1653-1-selvarasu.g@samsung.com/
> So which is correct?
>
> confused,
Sorry for the confusion. The below is the correct one.

https://lore.kernel.org/linux-usb/20241208152322.1653-1-selvarasu.g@samsung.com/


Thanks,
Selva
>
> greg k-h
>
>

