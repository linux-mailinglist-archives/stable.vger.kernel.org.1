Return-Path: <stable+bounces-119907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17607A4932E
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E793B538D
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2416242904;
	Fri, 28 Feb 2025 08:18:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D291D61B7;
	Fri, 28 Feb 2025 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730697; cv=none; b=gT6hmojwBucWZTn6wlRU4lRLeHpIWdZQQxLDatGMzzt+s2iwcMmgTf/bKvfdn1j+eGrds7Q8LBi/nt260QVLISzpXMHsrTQNLG/5cUtm+fR1N1VxkfI8e6K/Gn7dwsUz6nrWjNBoh7x1fU+BprF0XftfRJlqI+qZBP8CUA4UtYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730697; c=relaxed/simple;
	bh=NbrOI5a1zFvjdM3c/6cGZjAhdPgX7Csw/c93i9R3O7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIPNFI9XCTm/agQBnWB09y9p4/D9ta/JWb4DXRiYeNF23Rh1AFgBsieg8MsYH0w8M56/e62MzM2A1dUJDrISmxv+CLMI48GXG60Ah30ahLScDKiwJLeiEBy3aXfnDLfWTvCuJ4C3aJpLrSuPc1OhDRJEmOXBcocg20wOEdeL1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so1130932f8f.2;
        Fri, 28 Feb 2025 00:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730693; x=1741335493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0CfN1BG5I4XDVH6ThKnPCM1yx0oVk1S+DOYxNrVovw=;
        b=JiIS6vtbQckpRsPWgKti4XsnLzLGpbRkewyZFsuvEkPakI10rZ1wzUXQ1jWxtPjgrO
         0IFK+7xfeka6a3owYTZnXzS4rXkC5FbOI5Kzm3gkwlHMjHWONhmLtVStCpKw5FB3qjwQ
         ON+dAVJZakHdpTVg15EcO+MQOoGMjimJQU26Nhwm8JZnNuPtnFkX3mLupyAR0fR9UUD3
         A0dkQCs3bRGKgeD0DyC2U4N16WdmnozCc5XT7EUqfcYhwwokX1t5Zo+ukCKflzz4lgF/
         TPB6Dl5Erl18imyx/LMrCaNS6AZ6IgLt3awcmaApDv6iaa0xB2nNy36Y4EW0MDOPait3
         aPYA==
X-Forwarded-Encrypted: i=1; AJvYcCUgyPg0ct5Agr9mU1M+6T2+TugTkO5ekQ9D/B9fJMTMPtJ+iQ6GxhEFZWs4px2JlKvoVF/3EXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZyZtC123fYcVIfq9DiXGFp9cdZ9sBp9HndxQjxzlY+vsM9yO
	W6p+tr9xHiHfrV0z6qAGpbqx4QPHKzV+eHARs3r6PbGGLfOGiS/G
X-Gm-Gg: ASbGncsjVH2pUDxCv3IFtZrRuV5uy0TcdY4vD5Exm8Oma7P/K4Og7GEgzpCkUR81sAE
	o34JULO9amW1+x0wS8LvS4tAY6r6xiW+zNGZKyVuNT+jk8n2xhEPgg6CCviSlPnbxBgxKxXosCy
	LhWKgaZKAB/q/DHXkmnao4K4Muhxozq247dvX6hlq0S1UhefGSzb09DhrE5GnUBXPKZyc/vnehJ
	wQ+DoL7QOwEauRlIvHiMPbPPq0nCGv/q/zgmMxHB08GFlR8EjYZllE//S67qh8s9+rwIaAFFnNX
	N692xu+tBL2oZmELN1WDEaV37MaVoDmHu0IdO2zNEvVC1gCGeqd/Gu2YB2+fSmRNYS2dkFlkUVr
	mUtlDnOtx
X-Google-Smtp-Source: AGHT+IE9P4yRKwS5hkUFbtTuDWOSJoiTH3flRo32Wp8fhJSQhPUyTExIHdPaVmoUrf+zgey+/UtTtQ==
X-Received: by 2002:a5d:6d04:0:b0:390:de80:ce92 with SMTP id ffacd0b85a97d-390ec7cdd46mr1760103f8f.17.1740730693158;
        Fri, 28 Feb 2025 00:18:13 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f73eea00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f73e:ea00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba53943asm79108775e9.19.2025.02.28.00.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:18:12 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: jth@kernel.org,
	gregkh@linuxfoundation.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mcb: fix a double free bug in chameleon_parse_gdd()
Date: Fri, 28 Feb 2025 09:17:47 +0100
Message-ID: <174073054898.13073.3196394951281177875.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228032720.3745459-1-haoxiang_li2024@163.com>
References: <20250228032720.3745459-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Feb 2025 11:27:20 +0800, Haoxiang Li wrote:
> In chameleon_parse_gdd(), if mcb_device_register() fails, 'mdev'
> would be released in mcb_device_register() via put_device().
> Thus, goto 'err' label and free 'mdev' again causes a double free.
> Just return if mcb_device_register() fails.
> 
> 

Applied, thanks!

[1/1] mcb: fix a double free bug in chameleon_parse_gdd()
      commit: 6201d09e2975ae5789879f79a6de4c38de9edd4a

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>

