Return-Path: <stable+bounces-119971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB251A4A00D
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 18:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB553BD76C
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 17:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B960C1D88DB;
	Fri, 28 Feb 2025 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Neb2MXZO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF41F4CB8;
	Fri, 28 Feb 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762908; cv=none; b=EB4OnXdw0hQQbYJbiKmxKFUCCKOzaA0DAY1S5ojOcN8Vdw5dTVMwgfd86891m4SKSHuNr819xQNSbRWsUU7/tT/Pz6vvBa/e0us7O65uSOc9GPS+D8YEPG1t4a9SCR2M24dNJS3fDlFZ99NM7NvfM7EHVG6wqkJSUVpjyAeIeBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762908; c=relaxed/simple;
	bh=yw56OOcc4mOBuuj6ITPf/bufZr7+wEV6mWmgXwpcuAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A56NWSrX6w9/NikfWXyGo8RgRn2b9uQ1EIhJITfy/r8JdY/vEpp/cNXXkCQwZ/oahLZtTTJCHlAzzX0ICZ3gTrPpQnwfjbtxAHLgG3yR2/wqdNJbosP1p1JSKxz61pRsJz0j4mHL4Inw9Wn3S+nraIa98nYiZe2oR4zMnerR3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Neb2MXZO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso334597266b.1;
        Fri, 28 Feb 2025 09:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740762904; x=1741367704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afeonSAlFod4Wwm3A9Q0iIl/boL2tdt0YRRgmGv2+Wc=;
        b=Neb2MXZOBiQOHw2W4MtkDC712Qs1vTzhK9tgByQLumV+FiPiEYlioMsW59rtBwAk1Q
         NqGaV1TypMnXVSu+XAbNMK7AX/NyWJO48oCEaOlU4cDhg6LIsdH1O+CNZ1fjB/lMGNln
         sOtCyhlg7Ctiq+J30Vz9cXI640mKtNb1YXAAKih1y8zmB/p122n6wc0mUblNlWu9zLSp
         HUAFDYyDGvmYh2RL2H2d7MOsA3/5oTwOWuMYFWL1fSQPlnkMuuXEz5Gs6FSQIIVASNv0
         ZxqahzUZi1oOT3P7ANS9S4HVUXeNEa2Szf9JHgqM/NoLnil+Ni0Csxhuj/DZbUwcMfXG
         rf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762904; x=1741367704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afeonSAlFod4Wwm3A9Q0iIl/boL2tdt0YRRgmGv2+Wc=;
        b=Xr9h9BcAIA/IpdBGCLyxUdvBL5b5mG5Qe6UPHtvg85F1K8KWeEisUs1iX89771468c
         5Q5LIJ2H0PeZ+9KKhO575Wrb6+B/iqdfxy56qQTmdEy58QAwBdZ3+KONzpNrmxxg0fd4
         pMTssKbD9bTL3+FQxg0takAmVKlc0VTcPpL5x9Ib5cpWweVPUgl18nMCpcrR6Cpp11LX
         G2zkhBcZunc8WObA4AS2kbpDu+HZXvh+WuK1jVHtaZm1RMB6thWZllxvx1HNZAHCHrEw
         kMqA8446MH6nXLoaEPkcsDzpIUhg7Zu/7in9zqMJ07S62wpYlCQGR/n0ywwd4TOqHifd
         tT0g==
X-Forwarded-Encrypted: i=1; AJvYcCW2vIHAYHkco+aON0PmKqurOrI1jlrZBqHx5LHwnJk4d5RWLlnqgy/cvs8lXU5JJH6R+rBFNagF@vger.kernel.org, AJvYcCXWDRnomg6u+UTtIJlm4gu4k6g3ogUJ9pZGlXMxClrKmlxBNAIKJnuZAeF3pFyrVx5R5oxk+cZQ5OZBRxM=@vger.kernel.org, AJvYcCXcDnn5XqzoI806pd2wQu80mR5SrsQ5bt9uCQ8TMCUkRbq7y0bDuz8w82Kye9tzlLQGqURlhjCNLCac@vger.kernel.org
X-Gm-Message-State: AOJu0YyYR+nvaftkojlQDIqhoyoD2NrTYaEoWtG0FhShZ/FfgSIqzwkB
	by4EXxCtW8F6u5UPm2Vr00qSrg3ok6yf/JHflV2D+VmKHALrUg2O
X-Gm-Gg: ASbGncsQxSLdV1SznRtCcuQR54C3+z1ldjhJb1s2rK6YRL9EPJp7sK1Hlx4tBfwx0hm
	pWHFwbNzt5u27a8dlY03plDLy/yvf8rXmE+abOoinVU3hqwHN/vd9eslcJvjcc3w2tku7YLmNBn
	ZY7v6+6h6LhWhFv7D3tNdC//N4LR+ebOFqsQSEHSiPedp5vzWZRU+FYJUVHrwUUZnORDaxtGVNb
	RLqZ/QeB/MhStArVtRyxeTGxH5uQnw+PmkuLSbG/sKVULZ1dv3+36MoB+cfcR8ceFl/ngctYAyR
	ag+bypVhhPmC2NLaPhsVmj8ecQ3T/b12vt5zsCSm
X-Google-Smtp-Source: AGHT+IFcwu5SgE7uaz6+ha2R6PQoBv6tsHMNfhGt4zl4vNELvAtuToKwfhdiqEMFcNgr+0yERYGfAA==
X-Received: by 2002:a17:907:96a5:b0:ab7:eaf7:2bd6 with SMTP id a640c23a62f3a-abf269b8941mr492833766b.49.1740762903970;
        Fri, 28 Feb 2025 09:15:03 -0800 (PST)
Received: from foxbook (adqi59.neoplus.adsl.tpnet.pl. [79.185.142.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75d31csm316464266b.157.2025.02.28.09.15.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Feb 2025 09:15:03 -0800 (PST)
Date: Fri, 28 Feb 2025 18:14:59 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Kuangyi Chiang <ki.chiang65@gmail.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Handle quirky SuperSpeed isoc error
 reporting by Etron HCs
Message-ID: <20250228181459.2ec1d29c@foxbook>
In-Reply-To: <20250228181146.5188fcdb@foxbook>
References: <20250205234205.73ca4ff8@foxbook>
	<b19218ab-5248-47ba-8111-157818415247@linux.intel.com>
	<20250210095736.6607f098@foxbook>
	<20250211133614.5d64301f@foxbook>
	<CAHN5xi05h+4Fz2SwD=4xjU=Yq7=QuQfnnS01C=Ur3SqwTGxy9A@mail.gmail.com>
	<20250212091254.50653eee@foxbook>
	<41847336-9111-4aaa-b3dc-f3c18bb03508@linux.intel.com>
	<20250228181146.5188fcdb@foxbook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Feb 2025 18:11:46 +0100, Micha=C5=82 Pecio wrote:
> What are your thoughts about killing error_mid_td completely and using
> a similar mechanism to deal with those final events?
>=20
> 1. The events would be taken care of.
>=20
> 2. It should be OK wrt DMA, because the HC has no reason to touch data
> buffers after an error. Short Packet is done this way and it works.
>=20
> 3. A remaining problem is that dequeue is advanced to end_trb too soon
> and "tail" of the TD could be overwritten. Already a problem with
> Short Packet and I think it can be solved by replacing most
> xhci_dequeue_td() calls with xhci_td_cleanup() and adding to
> handle_tx_event():
>=20
>     ep_ring->dequeue =3D ep_trb;
>     ep_ring->deq_seg =3D ep_seg;

Forgot to add:

4. Guaranteed low latency of error reporting.

5. Some annoying code for giving back 'error_mid_td' URBs under weird
corner cases that I recently spent a few hours writing could be thrown
out and handle_tx_event() would become a little simpler.

