Return-Path: <stable+bounces-191656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5841C1BE98
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 17:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8963C19C19AC
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CD2350D6B;
	Wed, 29 Oct 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkjEseJZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04934B1B6
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753632; cv=none; b=bXvg7se7te3E2EP1DiPLoCdVxv9joJC4YlQo0n2JwoyPb0tRyDuw7B6Oy2rWUZphcrf+TgpuIvbb8A7T3lJHzhFQ110BmhLLuBFE7flopMHUsQA9y+Dewpzg/CfovG1a792sIqQMDbeECqcMUKRs7mS3WiDlJ+e6qMQja23wBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753632; c=relaxed/simple;
	bh=QjbKfgzHn5tyeA0m3V5JJ3BLODA9JPFCp9Sk+QT8tK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hk1cMftz1DeRbguzONK6fZkjjUof/fEmEUxfBR6gsRMKjVUVKzhlSBEqJbYdeW03hnWpxqpAOdszBGxTyV7m5v8qKrTsOx3g8XlEyN487wiNSHuteQxp37dsd5rUGbnBZet0ppITTE3ZWwhZcqNYPka+GQ+198owmqsw2R1oz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkjEseJZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47721743fd0so5122185e9.2
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753629; x=1762358429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjbKfgzHn5tyeA0m3V5JJ3BLODA9JPFCp9Sk+QT8tK8=;
        b=JkjEseJZKoHhnNYyso0khj5Qx3qxvZe9I2U0THqGOb5T3Nj6EEGXln5MhmFuO93w2H
         VvLp1BC+Da7Oad+gyfH8kudsV3nizxestNRGjdvtuZHprDUlw2msgKiUg1MspMKwJ7SV
         KAQ9HbJkDgUIKbysEEWFF0YkBDfip4zbOeXnsZsG6EbJXCp+YRcC2IMtBWHMlS9O9ss5
         DmtGWznn8LkffHhvVvoaCRWfG28FBES3AL2XuUjqYDmJI3BtN9QfdSZ3EEETLq0d4pz1
         Hn2qnCp4s88IzwlayCDMav5FTvsaUTN+BohEYzOfuyvCPLF8d/KjvIB7koupNJvGp+Pb
         aCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753629; x=1762358429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjbKfgzHn5tyeA0m3V5JJ3BLODA9JPFCp9Sk+QT8tK8=;
        b=ijRo56DYmgUNSQAhKqa+lVgNUkOxroL+wL03Kkqw0cJac8IkLfKG1GYKwOPkgXUnj6
         JQFHXJKaoeqAi3njPyJy+ddn5ksIf/1RlqhQWtTfNCbpDv+B0Ew5pjVPyDnVMYOqlBdv
         PzdCFyujSgTlJR+dvahAwZE/Sn8g3GcoG4l23GVzEDqbpA/CwqBG6PrBOL+Bzlli+nti
         ENWAit7G4RvTVQJ1In3m4f8Oyy+dHdWsLV7lvl5RgXzc3+luqkYiIF456WCRIDAwb0aM
         lLV5SThP0sfeYO5ZWXxEXHNaphDnn+v1Ajj7oIxQekc1F7wR01pV4qeDsfQ8zcrAMsvD
         FCgw==
X-Forwarded-Encrypted: i=1; AJvYcCUXaiEEfLgYetrDiDpkg6dF/JhaRYvhgC69aFclKHqvX2WcuLCB2VNwBIDxnb7mfvkqnD/MrxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwwb0hVqfDpblmkT0nsY3CbK9qptUvMv/OrSr8NFFCPj/RUtWO
	6Hxb8q7amvRP007Useg0gH/kcf7oC11/t2GNxHPc3Nsea3xs9Sv4KAjceN9ttA==
X-Gm-Gg: ASbGncsxzXIrS44vlD0dVP+nVushXbcK+E1InRXeHVO8Zyau8l4GEyb+CysZ7LWFiDw
	z+Xsbj3UjsFd9DtLLoepx3uKYCZq2G1+Dp161Wq+H0iO14k/VRTjTWCVelDOuqErwTMv7zX6cec
	nKS98Aow52vFdEk+vd8QdFG8wV9h8YjYBvgCD2oRNBMtPs1JnXwJz6J5D8khpLJiS0wW90pYmK7
	g7ib+RwZNjdpM95jvS8BGaOXfmPfj/YJMThQm4GotU1JL+bL4pXbgKl6sU7hb/O5UJujd8A4ppZ
	4m1vOJp/g9AvgPUsgtnUroYYkvOY802PD2QnfnYkqYK9zI5PM9vVK5C49nbXZbFIcA2ywmgiqn5
	uNnTkeiHzZYSMUUjmttRRrhVTEueSNVPuadxLXtIjnJmQSxbNoPbl/qI3bCYJk3Q7ibWSxuSi3e
	4YdKvFgymtoZuPNkiPMGEna283DqVxOEdO43ylXPJv2avjCs4MvDL62yzWtGgzdeJ1MxFi
X-Google-Smtp-Source: AGHT+IELwKkyoHZcEXoDh+ODYAhJc1PkQChXNnF/56yRmyxyp0iQGf8PAy40wU0hq97LrnXaNPX15Q==
X-Received: by 2002:a05:600c:848a:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-4771e21c484mr25812165e9.21.1761753628706;
        Wed, 29 Oct 2025 09:00:28 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a8209sm54097015e9.11.2025.10.29.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:00:28 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Samuel Holland <samuel@sholland.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
Cc: linmq006@gmail.com, stable@vger.kernel.org
Subject:
 Re: [PATCH] drm/sun4i: Fix device node reference leak in
 sun4i_tcon_of_get_id_from_port
Date: Wed, 29 Oct 2025 17:00:26 +0100
Message-ID: <3848160.MHq7AAxBmi@jernej-laptop>
In-Reply-To: <20251029074911.19265-1-linmq006@gmail.com>
References: <20251029074911.19265-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 29. oktober 2025 ob 08:49:10 Srednjeevropski standardni =C4=8Das=
 je Miaoqian Lin napisal(a):
> Fix a device node reference leak where the remote endpoint node obtained
> by of_graph_get_remote_endpoint() was not being properly released.
>=20
> Add of_node_put() calls after of_property_read_u32() to fix this.
>=20
> Fixes: e8d5bbf7f4c4 ("drm/sun4i: tcon: get TCON ID and matching engine wi=
th remote endpoint ID")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



