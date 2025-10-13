Return-Path: <stable+bounces-185497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1282BD5F0C
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 21:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46554069CF
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850222D9EF2;
	Mon, 13 Oct 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PtjU3oVT"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C62472BD;
	Mon, 13 Oct 2025 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760383678; cv=none; b=spzXje9QNVIJgGrpvjEXueKNCKMbLwctC2W6yrWj4lhBuCr5PAI2Hwe0Ql5tjJsENviHw2TqsfxxhCbaMPB1EcCft+TaD/8av+rap8UJZDbN+MBuL091aRm6D5IOwcVLJTLNIrJjRTO7NCG+EimZxy8wNTH0BHsV4RJY1TzDqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760383678; c=relaxed/simple;
	bh=cjM4rroTyA0Y98QpmyFJPTeJ9E+1tSQ+lxNOQ8eUGWY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SionWSF6CWucQsIuTLBkmvNyAbkoxNwPztEFM38EU/JVPxaF+AZBj/+YPXpRePxo/S5DoqM05d3k0Z6L8zOo8lRRe721XnUXN5J/zkq5AE1F1KwKKXpIjuUM/TDhonf9XUtI065rmf5XqPcE8eKVRR9zHv+W4eo9KSCuElfEXq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PtjU3oVT; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760383654; x=1760988454; i=markus.elfring@web.de;
	bh=3QnAgP08nLzueYfQi3GJhp59EsLXxNcSxa6wb4iaBaw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PtjU3oVTj9Jl7FhbNp17gAJwNoEmqv5CwaepEGLzD8CGlHJpw58H3IXcrdo/pAIm
	 9ghVXkxEtm35iLMQqnmYb86VNsMnv4Wf1PN7Qe5J4dJqe6PJd/YSJaDcaTRJbtzLW
	 euvr0LztwT0cWkm/U5XEHJphMTkJwSJH5EA5IURiKmYz+6VWV4oGqO2R3+Xbl+H94
	 EORTZKg6Lstnk/bVkOX4wGSpIQzHCK8Qqu0LHxf6i1f1tmRc3bpMthF33dUzlE0om
	 sMDz9CXBY/LBAEZRLqd2YOVDX1AS4fMF8syNELlNM7KZrjbqfoyzVuhN9tBB0O7ZL
	 Uc88zQ4xD5zsto/1xw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.175]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M604t-1vAr3F3KOJ-00C9B5; Mon, 13
 Oct 2025 21:27:34 +0200
Message-ID: <1e179db8-1c44-4bda-ba07-1be2195febae@web.de>
Date: Mon, 13 Oct 2025 21:27:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Cc: Dell.Client.Kernel@dell.com, stable@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Gal Hammer <galhammer@gmail.com>
References: <176036823039.2473.15648931584117338012.b4-ty@linux.intel.com>
Subject: Re: [v2] platform/x86: alienware-wmi-wmax: Fix null pointer derefence
 in sleep handlers
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <176036823039.2473.15648931584117338012.b4-ty@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:slXag5l1I8SFLPhkGzNXQlmohLNzYbsv06HdeQ0RmOEY0lKRau7
 w5Xs3Qsd2v7SkHIsWooXUaqitvxVkANgyZBwMgqx+j3TSYLQ/glfahFATRSrFb7zKXzAuSv
 bF5bm2lpPC4AHsHaqylOq/0Kmv6NhJRfrHAt/VdsoRyBnKldCDCuXlWiJWSSrtzBVmCj5N7
 d2aQm/g/9UxxjLPJilJgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EEo8Xnkso2U=;2lZz07CKUHFGA2t8EOqlal2ywOG
 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
 iNau7Wy7tY2LZE+2g=

=E2=80=A6
> The list of commits applied:
> [1/1] platform/x86: alienware-wmi-wmax: Fix null pointer derefence in sl=
eep handlers

                                                           dereference?


>       commit: 5ae9382ac3c56d044ed065d0ba6d8c42139a8f98

How do you think about to avoid a typo in the summary phrase?

Regards,
Markus

