Return-Path: <stable+bounces-169581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7EAB26A75
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 17:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EC356118A
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD04212573;
	Thu, 14 Aug 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1XenmWT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A5D32142D;
	Thu, 14 Aug 2025 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183576; cv=none; b=T497ZIl0JTKPzTaUjpObCTVvERYba76UPjbt8/jXqNS3goHx95aHKljnm6rYf/yKgRm9/4QFovxRyrKVJzTrlQZ1izWxASUTOTEs8oLYQC0GlvLVkmAfBWeIzfdXNdyNAZFqktrLGq3ibtSdMTJ/Bcq+JkR6+IlnW5lwXfKsUOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183576; c=relaxed/simple;
	bh=xik06j9J7NbriowQ9Jg7OPweDnDxx1OwDQ3G6EGce/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojqtFwXrehVxTzcwf6w230Fnl79WaJT45cArQz4qf6N1Yn7bC84/ChWm7RQdInCvOT/LvOQ3PMIdrIG83Way8jrQxr5FePMKMfCOMnD0ILAvMi3BM+kTBvhhJEKSB10svWUKJhegDwHJmmcmBoej7vjR28R2ZOhQn/Px4Q5tKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1XenmWT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso660656b3a.3;
        Thu, 14 Aug 2025 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755183574; x=1755788374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQt5BqMjb9nx7BmE6KGMd9a47fQxp1m276b+AFq/m20=;
        b=O1XenmWT8GpuAnpAu+cPiE1Tyf0ApgNNxZS7xMw+2ra61GJ0A25nSSIXOCHTZg6v9q
         Gh1jHX/Nn6KP/R8H1eN3/gYB1YmvzQ+K09r/06rh6j9ieFWg3kMmkOrE0vgtFqrfaG1l
         OkxnzyQuAJ7PfZyPknlm8513R9akFatfF1yQ5vRSbXll3Pj87NiY/QumhGH6ohBlr05s
         a2O3zh1CqW4KXqPzuFkspPKyoMSFexHqjBEdscv7OGdjyk679ny9XFSc7HpmTEXBHa2e
         sO2IU+YhlhnwoBLSAk3VJc6RktqSRBHHgJZaol/DQksRaeIZ3vD4KPsby3TphMn4Gj0q
         8/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183574; x=1755788374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQt5BqMjb9nx7BmE6KGMd9a47fQxp1m276b+AFq/m20=;
        b=YLjFk61efnABH43aT6nbY8bK/FSaBibXK1HI0SyYaTsqbESKvC+65lPOBKd/G2x94g
         6zi/VqhHLvG7SXtTkD/AfcWvwH+T8weQYScwCZiWSPg69ba2ierP8/rdvph/6iMUqZoM
         VN/4pKDbGU+I1Q1mb9FULcWeTzUjCrWnkU0BOc0fxluvlj+F9FMDLYpD95c8LUGeFx1K
         sKZ4qPmClQHYDgLD61/drKQ22DVuX9/qtJThdP9ON/wKz1IQcRg5qY/ByP6DLoIXMS+j
         hXeDMa/0VZTLTxxzYXRJ3aKZiIWTtD+XHkK6sdjYPbHk2z5DngIxU1HXeI9hVnjwoPcM
         tSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAsKjfF78XXodcUXGaSLqmmOov/XkVy6NMtq4FM/I+4R4MU+bY7sr5Fbv64oUqoOftoxCTi739d2FmjeM=@vger.kernel.org, AJvYcCUyDnimxImy0zg6f1EwSHPM+dWaKPxSsKO57gVzDyBuHP6fbl5OtMf2iOD8g342EEQfiYoUGrpj@vger.kernel.org, AJvYcCXDC7jjyrdO3M7iioHPJ2Tm/V1IYtKkhjfVN3ruOvZRnYyIZv5U/sMBJIaxByzgpjJVGgJiuMMncTPa@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv1qKK3bO5hTiqkfh3+PM83DLr/dV+w4sejMqkVT/KaqDlHvcn
	TvVVVyddgpNEyDJ+fpjLquOyaQ9HcXXiYqat28wScCbtvdsi+M2rUTt3
X-Gm-Gg: ASbGnct5l4DKMcp6jfabZ14rJoF12P3VcJO4wPzG15R8LXTI8UrPEkK+bPZIXiab5C3
	PF+zbL9lFlw0fMRVQ1N4RD1c1iKk8GwEx4j9OB3OZZhZriHzchJVRSQW8rn4HDetKFQjLlAHzbf
	L2+U1w9Zbr3NczpTNmIAjnb4CVQWgr0LLsVBVPlvS93SNQAPzHuNQ3/phn1XYkzpaFMk1UdKgMN
	cRcjmblwHbGGOC21h8oryTjzDdfCk2MuX12vwByI0iqkRJaw2xJTx80hSHQCvDjdF4gaG9uU1Wl
	6fjFutXWwwg/ccbU77Fs7AuBjlr4n0+IdBuql2Oj5x7IjrPMMnyhPjGJy6W3N8cskNFP1wQtnLa
	GK1x0uYkpTbFMtieHSucm1xV/QMIWJyjBiXzf26COGJZKyeKONrG0
X-Google-Smtp-Source: AGHT+IGRMPcf4GCPT1hT8R0Sqa5lVHS0BKPn1vKIJX5n1+A/XkyAqp+HbZf0i+LSOPW8MgiygRk/vw==
X-Received: by 2002:a05:6a00:2d8f:b0:75f:8239:5c2b with SMTP id d2e1a72fcca58-76e2fdb134dmr4953990b3a.23.1755183574170;
        Thu, 14 Aug 2025 07:59:34 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-76bcce8e854sm34960878b3a.46.2025.08.14.07.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:59:33 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: larsm17@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	stable@vger.kernel.org,
	stern@rowland.harvard.edu,
	usb-storage@lists.one-eyed-alien.net,
	usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: Re: [PATCH] USB: storage: Ignore driver CD mode for Realtek multi-mode Wi-Fi dongles
Date: Thu, 14 Aug 2025 22:59:26 +0800
Message-ID: <20250814145926.3067-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <8e9066d4-1b04-4423-869d-2bac0a3385a2@gmail.com>
References: <8e9066d4-1b04-4423-869d-2bac0a3385a2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hi Lars,
> 
> If I apply this patch to my kernel, usb_modeswitch can switch both to
> Wi-Fi mode smoothly and fastly, but I don't know why. @@

I forgot to say that I've added one more entry into /lib/udev/rules.d/40-usb_modeswitch.rules
to let usb_modeswitch support the ID 0bda:a192.

$ grep -E "1a2b|a192" -i /lib/udev/rules.d/40-usb_modeswitch.rules 
ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", RUN+="usb_modeswitch '/%k'"
ATTR{idVendor}=="0bda", ATTR{idProduct}=="a192", RUN+="usb_modeswitch '/%k'"

A config file in /usr/share/usb_modeswitch for the ID 0bda:a192 was also created.

$ cat /usr/share/usb_modeswitch/0bda\:a192
# RTL8192FU
TargetVendor=0x0bda
TargetProduct=0xf192
StandardEject=1

