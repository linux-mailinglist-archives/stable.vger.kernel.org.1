Return-Path: <stable+bounces-200199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91181CA9099
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 20:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D54DB30287FE
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 19:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3FE3570B1;
	Fri,  5 Dec 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVVLwHnL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D43570A4
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764961738; cv=none; b=mE6Ji25NQeocw981gQs1GbLMAqbuF6dORvaN0yg38EXv554DZHGQ6qGdjI+YE8xrzM3REiNQr/bRb7c8ss9lG0e16h32RwsJe5qK8aGiLskGHO66UuLtAlotOj6s544qQ6woVSatxhYZCxWUyV1/XvvVKFMzrV7lk2J1DJMzQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764961738; c=relaxed/simple;
	bh=/grqmQu1VT4OJGmtEwd0eouKcRmgcIoQ7v05Ao7XrHk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gDr8RhUPBUMAGJVm97p+IqxHkNnp2yvQOtrOCAtPTUZ4GCkElrO8xjbHsuxPm6QRJU5PwOCsCv1Zzt7LWlTwS3+IWIPAibvhIJbt0wHhk1epwXr9pvUhqzaDDBJiCtty1SE6yq0YGtuqgDNPbSzBDzJ6HPUlPpdfBaHCNCdVUGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVVLwHnL; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63fc72db706so2265192d50.2
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 11:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764961734; x=1765566534; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/grqmQu1VT4OJGmtEwd0eouKcRmgcIoQ7v05Ao7XrHk=;
        b=bVVLwHnLTYKJQZNIlx+t6t90LNRc+tTZtPCvj2mhOStKwEgBsrlcZi56AdWSnGQ/Gy
         B9J0irioHnS34HSM31wASI5pBc60IEHF83Shr88sNBhqPxo5WIcWh/fxZyA/QvQEQw6U
         rCsert9vOxVDxcq71jRzqi8w8xtPzNvVBNB5hLfd6voYbp4jDcKzIniHJrEsbGFWhE4T
         8u/MgHZc5iWU2t2+yenKvEDdRoiKFxbXZr+BXiy5MSkIEl0l1oybsW7MNXOfKUDB/ilt
         dIf9/xEiUj7zjj+Jr2CsVI2uW2wPXlIxUui9VLbnzJqbK7xNkkAlAghMiD+eQXOZIexm
         mIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764961734; x=1765566534;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/grqmQu1VT4OJGmtEwd0eouKcRmgcIoQ7v05Ao7XrHk=;
        b=lFKJFxW8wnPlpwA5UX7RA/7cNvywJ+z35s9cLTkp2WXIFyJ84Z8/mu5m/Zu39yNfqD
         cLLPzMyXIm9gkcB9hjy4+GYa34GPIl6UzficoXsCr0RW6L8DaWITvvX1HgY15+lA24Qh
         FtAnuj2vP2s+LgyUHMwkEqRDYNpj5YqB33YDEp0lGzQzEoYKlyv9cpli0/BBcJxuLtvP
         BWkGJuaW0WGSTfbp0U0lW06HKsLpq5YdClnnz9xvP0oNWEj60C9w2MqjA8tQzA4aByDO
         SaolAhXyGoe8LjxuwUsrI/5ZHhWJSpkAunPVG3lUn/+R1QhC15N0wgYFmNnJ0SerVWuS
         LL+A==
X-Forwarded-Encrypted: i=1; AJvYcCV+Oog/ox2qn9qr8WjJO9bwvGG/+mAjMdYckzI/mAeVViof5FThgmrHFfzp+BdtytgRylZED+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB0YGquPSM7Ix1HB2GiXcjYz9fuFwIiCJ+x1Doq8/loAl3lFdX
	EhTI6eYpZN7FO0XsTNa/EqoC7AyvRE9cHgVvKQ6r3ReZj2m7bAhHWGxw
X-Gm-Gg: ASbGncsNiTT3AIdGHa9nyQ0F35LUSDavbjnCQ522UfXH2BMj/oufOM2h5b1w25UdcMY
	WqIErku0n3OdlRL/6EFkHgk6WJqivx1KKd4AKiaB0tW5C0mPo8kLGawIc3b/ydxmCYzkTNNNE1D
	SyVU8pcFCwAsCi9GIUQC/Nvq2nBpFTaFkRLTX50y8Zdi/FvCn2GuHqG7qCS/7q3gaUm4KPOQzsH
	/3/izB6pZi6tOQaQxa3nhCOeYChYnSIQzB9W3xPx2tQmfThXwPb+LFb47nHIJeZKBy0/w04ZFQF
	Yk7MWNSQOnXHlvYL67YyfN2Am+/M3jmVKa50zpUUspKk6YN/dXrN6b26qc/6KCthuxg2LWZOcY1
	2p17MMq9Mr4pziWqEo76c6ID0rsYxpsglEf0V9+n+7kgYsiGWGLdwUXKOD253+Dnt34hMla0lgE
	gmy+Y=
X-Google-Smtp-Source: AGHT+IEX7oWGtpUVsXXjxR9P+Xx3Cp/SwqG6uIJhXg9cHA93n4Hs0R07hsL3LJEP/Kf8W8TPpPaznA==
X-Received: by 2002:a05:690e:2506:20b0:63f:9937:6cce with SMTP id 956f58d0204a3-6444e7ce92bmr6669d50.61.1764961734438;
        Fri, 05 Dec 2025 11:08:54 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f5a3e81sm2114261d50.16.2025.12.05.11.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 11:08:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Dec 2025 14:08:52 -0500
Message-Id: <DEQIPUKHDQYB.2LLGMK25N40VN@gmail.com>
Cc: "Hans de Goede" <hansg@kernel.org>,
 <platform-driver-x86@vger.kernel.org>, <Dell.Client.Kernel@dell.com>,
 "LKML" <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 0/3] platform/x86: alienware-wmi-wmax: Add support for
 some newly released models
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Kurt
 Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
 <49c9bab4-520f-42ca-5041-8a008b55f188@linux.intel.com>
In-Reply-To: <49c9bab4-520f-42ca-5041-8a008b55f188@linux.intel.com>

On Fri Dec 5, 2025 at 2:04 PM -05, Ilpo J=C3=A4rvinen wrote:
> On Fri, 5 Dec 2025, Kurt Borja wrote:
>
>> I managed to get my hands on acpidumps for these models so this is
>> verified against those.
>>=20
>> Thanks for all your latest reviews!
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>
> You don't need to signoff the coverletter. :-) (Hopefully it won't=20
> confuse any tools but I guess they should handle duplicate tags sensibly=
=20
> so likely no problem in this case).

Actually, unless I messed up something, this is b4's default settings
:-). I'll take a look.

>
> For the series,
>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Thanks!


--=20
 ~ Kurt


