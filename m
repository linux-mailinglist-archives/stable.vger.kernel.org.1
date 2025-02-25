Return-Path: <stable+bounces-119489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57440A43E33
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA707AC506
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF9E267720;
	Tue, 25 Feb 2025 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="VprRbqvo"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EFC14A4E9;
	Tue, 25 Feb 2025 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484198; cv=none; b=C8lk79KWp3VXvqIDC+144W5Qjny6EMDmXqYw/bSRqHds9zhYOmWOv41GsvCbPIG6T2H2qU0ZqpLnpWtV909KwagumCg9XM/9Pu6Pk2MSNg5YKPIuDhtYTtKsqzYqizL9KoHZ0Pgz1pdtwpdNYbGZqbcCJ8xTOgBu+4IR1ZI2N2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484198; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=byJniACOklMvik0xaqn8ILQTEwvzA7cnusiRkjsQAwoE/93W2oC0zwIKVd1rlSVyG1CzveIg7q4dgBdOfiG8CAhd4FHG8kB1LKxExDMIQwvZGSWBIlkM9H4yFSoeJB8YdT8vlDwfTUuYd2Gh+VSgYNiyT6GqjrV7UWDt8e9XQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=VprRbqvo; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740484194; x=1741088994; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VprRbqvoa2tuq4s0R27/ZxZzStATvxZNlpWCO80U9wu83NrpLwRcEISZg4C5kdot
	 z6lnIf3igo0pXvG0AkkEa5jd6cskjOmI1lMp/eSSqnnVdU6+M+l7dm0C7pdeJipDr
	 RBSazRXjNBFOq2/uzKUzg2GWDB0NvMsvhnThPrPi9GgSAEHVhRSWYQGOndQdd2xaf
	 jNEHvfPRZ7NMUKBs6HmxsgLpPQhnpfeFNVJiBBe0/iM16iu9CmcXM1EWt6ZUjOpWz
	 wtgmVOejCX2dVTgvjEpdL9dgc0/t1K1lTzXwmVPMYFS+fmUhRMZjfEjQeTHQefvzD
	 0BUm16IXeSkjl3/ggw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.52]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1timiP1Kmh-00C0dT; Tue, 25
 Feb 2025 12:49:54 +0100
Message-ID: <30ace3a6-f0e2-4dc6-b5ed-ef7af78adcfc@gmx.de>
Date: Tue, 25 Feb 2025 12:49:54 +0100
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
Subject: Re: [PATCH 6.13 000/137] 6.13.5-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:XzwzF56WR7hnlioLwEFgbZHw6IunB6xfiDGWfnzGIYyqxNkO5zD
 wQEoGBPjsO9gxfA+69w3lJpokQZzQlXL+dtwKhs/2+X/JuUaemmwbJ33PZmdtg9dxtpUlSe
 8MdrxELVBZryDUdxRq+IBnSyhAtDBQiaC9JrCuXWjRKghJEUFxUdpLXp3JN9o6PZQ5MZpVH
 7s+s+UIij3rTG9uUDSO8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ns34rmsCxhM=;Y3fm3R9DfWUksw+3Fkx9yxedwit
 ZO3X/r7/DsUqM0ewMwn4gDEOTh4YX2MdoGcbsNbTN8twu1fey+eLvmRQg+BRtwsz4eOcytjpV
 S0s6sENbxYB/jPTe3UnhT7RRqKqyvpA3jM1cslOn20BBhxPtR06YqTedh03KDEtATvrdW+aYS
 f31I8lsBY0Hl/IvgPbrFI01QzGpEJH3AQvISAcDhsNmMIRSurOkktKMTgA5RimUVBj0kZMdzh
 nXN38VU1Odlc2afn8etAYBQjEr+kA55izFJVvp9Xq1mVFZBpQR5KPSR0T4Zs6guKzQ/iaY688
 MQj7hAAie9+f5uWgzlluzCefE/edUUVHA/dQmvdj/Y7oDEeue7btxYtYvnAtlpz/pBIBzTvnj
 bV0gi5sZwoOz2IQnQgrolqRC6VobjKphRc2OJtLdPuR3x3Dbv0ESUK76MmcSzOey6OQo6+8pQ
 4U7C8lEzN+bIF4TjLxIH30nElrM6D+YorzNOQNBqJ0DhD0l2Zz5Au6jqG2trNJHLSFNt/TODP
 ucE6HnZfITn8bujoVfWIHy22Ug5BDdNPk12OMQGzfGXNizHXoeOn3PSdXdYvQFqGZ8m2Lbk8O
 5E4m+sObD+f2ycp7s19BQaOKDD7oVqiXJocDf7fydRVmUJcx63nmU6ZwE9y6xeoKKZJIUkQxB
 6J+VIK1H0deWvPnX3NrUtk5jkKmyGkcmbVRJbvDD8GH5iizaSgpz/BAs3lMmvfOTSZUnvz0g6
 a1JXOD/xcO2tAlZHFA2KKSuUGMieyLEC4aR2TxO04d/wppuF/VqdgTdtzVj8Nmia49O5YiJ66
 43RnU695tPoWmWCr235IfUZEkOf0MGtm8/ONJbRvSEBl2t+Sq3ULixYECFV+qDF3ACRBkBHsx
 BZexcBULTO9jsbqLuHjNMseXkFbWimJZNt51paiVyJbrfIYCM0aZk6VFfuOyIZMNq2SPbgRzb
 KPA+6mwPN9dS0OllEjUL16X3pB+zZ+8cFiRTzz7StZ/MU9TnlsBCfyHHwzp6M2dq7DRQcSsYB
 FUVhN6of/1BMXe9XJfudwsmxy4kgpuquU46J9YTFCUUr34Ruw7HakkUuclZD7c7SXPdMr7Qlh
 KMlh+27SloKBEyCUm4Y5bn0d0oGT38QfJ7J1L3Wx2HE3c+Ovoi96oP+tj7pS1IhxBwnU8pagd
 JDD5H/PiiTW+fnIeiBEHWWPujemo2DtedBJp5Lr4s7eh5LE9hvZqL4+zMPQGgWPUgDBHdyRK7
 vrwpYgeIfLIwofGAHumau9MfeO0bn9ernQywCjfYbReLpXLVO+cGQbXvJ5qHI7R20FjiPt+eB
 5Rc2Q7G59otCGp9hvsRiwCXBMPy6Bq9O867tWp39TGxy01PDzwWnzwNhbGLe09RO9CWCI6peR
 AWI1iXl/xCFcNNM/QhpErj5DpzCsMZ87j/ZL+c9nQsl6NkoH2nQ9eKYHj9

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

