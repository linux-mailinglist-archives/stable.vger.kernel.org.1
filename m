Return-Path: <stable+bounces-180601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D41ADB87FC3
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 08:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48B21BC7EA2
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 06:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471FD29B781;
	Fri, 19 Sep 2025 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joelselvaraj.com header.i=@joelselvaraj.com header.b="bi8hXDyK"
X-Original-To: stable@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0E29ACEE;
	Fri, 19 Sep 2025 06:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758263022; cv=none; b=Li0rMrBH5M6p6IT8ODhIuFtapXsMCz0Dw5tuk+XxVLUKy10dLCjNCnR/OO1NehtDGTw/qhEo/S798swKNM7nR4GQi/tzsWofmuKhoaCQjzvWD450FSpcdaBoPlYxfOhCe5JdHyTCXyhC3zkuNn7EZq0whLwHQDGjJCBtMYAxEqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758263022; c=relaxed/simple;
	bh=TwTAQuVXEVFkFYrWORbRUDwY2Q1yghMmulafj99jWqQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MwJRH4GdMItXRdLcWdAocf+V8vXfwAu4aJsrNndSoPsaJ3fjkgNHCDzSPvROPEu0d0tFzjKFNX2QA6jlJjndANDmcqWiErXJBE01iTyefDpPPdiVKHIH9cyxvSM1O8Yd1fplDo2vPM1ndxOwuntAg+wWP3/OJv5D9VHO/o48LHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=joelselvaraj.com; spf=pass smtp.mailfrom=joelselvaraj.com; dkim=pass (2048-bit key) header.d=joelselvaraj.com header.i=@joelselvaraj.com header.b=bi8hXDyK; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=joelselvaraj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelselvaraj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=joelselvaraj.com;
	s=protonmail3; t=1758263011; x=1758522211;
	bh=TwTAQuVXEVFkFYrWORbRUDwY2Q1yghMmulafj99jWqQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bi8hXDyK0GM08LRJkiq4f+GgcqIKFhIZ1zB3PB3srfy8Nu+sJ8twpHgby5eJ2ALEP
	 Hy3XhD7ffPuVQ1QCQPTKHNjSLA7TBNqaQnG90T1WtdPiZsjYj13X4d1Gc7z99sE7W6
	 WN/WxkJzBUAJWznffB/qlvKixN2GeyEKILz+l+uc38PZK7njorVIdCDG/xOjhStykz
	 t0vWNjOm5QVZjyLPp0K1JpSZGvCtMkDHfSL3bFfYr+RzmgMlKIcu8ierVAWZp4Bwqy
	 UsQ1/A0BWkgZKwRvWKL2WBM/fza1ZULvhrlzQdPFqwQOPChQjfri97F772vhc0JeyN
	 Q/gw1qodT8k3w==
Date: Fri, 19 Sep 2025 06:23:27 +0000
To: Luca Weiss <luca.weiss@fairphone.com>, Tamura Dai <kirinode0@gmail.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Selvaraj <joelselvaraj.oss@gmail.com>
From: Joel Selvaraj <foss@joelselvaraj.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-shift-axolotl: Fix typo of compatible
Message-ID: <4ae418ec-5b84-40b5-b47f-ee2e988d7e99@joelselvaraj.com>
Feedback-ID: 113812696:user:proton
X-Pm-Message-ID: a1f1f07e497b6e915e4c4d63abc28e3b412d0101
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luca Weiss and Tamura Dai,

On 9/12/25 02:24, Luca Weiss wrote:
> Hi Tamura,
>=20
> On Fri Sep 12, 2025 at 9:01 AM CEST, Tamura Dai wrote:
>> The bug is a typo in the compatible string for the touchscreen node.
>> According to Documentation/devicetree/bindings/input/touchscreen/edt-ft5=
x06.yaml,
>> the correct compatible is "focaltech,ft8719", but the device tree used
>> "focaltech,fts8719".
>=20
> +Joel
>=20
> I don't think this patch is really correct, in the sdm845-mainline fork
> there's a different commit which has some more changes to make the
> touchscreen work:
>=20
> https://gitlab.com/sdm845-mainline/linux/-/commit/2ca76ac2e046158814b043f=
d4e37949014930d70

Yes, this patch is not correct. My commit from the gitlab repo is the=20
correct one. But I personally don't have the shiftmq6 device to smoke=20
test before sending the patch. That's why I was hesitant to send it=20
upstream. I have now requested someone to confirm if the touchscreen=20
works with my gitlab commit. If if its all good, I will send the correct=20
patch later.

Regards,
Joel


