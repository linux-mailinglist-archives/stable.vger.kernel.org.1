Return-Path: <stable+bounces-65489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1239491F5
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 15:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC982823F3
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4E41D47AA;
	Tue,  6 Aug 2024 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mptp3n8N"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CDA1D54C1
	for <stable@vger.kernel.org>; Tue,  6 Aug 2024 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951989; cv=none; b=BOLjF54NFWVn5tYQt3/ZMQ7Hazb4ONn6CuCFvXVYHVDLZE4H27Sppm1zvpcxZjP0If8iGThkCp5oTlxjpEYG43nIObcVCv13MYBjGWMdChiegSpQxEmCfYZJ13PC9KFrrF+k0qRgD/I/Cm8ZJPIl8XNJTQivUiLTH7axCcsGss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951989; c=relaxed/simple;
	bh=n2B5+WTR5fHsn5YvtfTT61S48+OsOawPtKzrF6Q/zeA=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=nXWagM7Y2SyGv+E9mR6mKOk9pn/VFhkf0kSJ1U2jtcGmZOQIOT4Z8q40CEoSN+jx2tmPaiTj3b95wlZlkf05ogubmJDSutumVTrFdZ7meBLrPGEd7dNdR4owNdgO4tDZoLSingBDG1lrpbE8a/Ne3pVMEY8xA0NrRFZfzp5MBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mptp3n8N; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-369f68f63b1so374837f8f.2
        for <stable@vger.kernel.org>; Tue, 06 Aug 2024 06:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722951986; x=1723556786; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n2B5+WTR5fHsn5YvtfTT61S48+OsOawPtKzrF6Q/zeA=;
        b=mptp3n8NZswL1FQDNJamYZ9RV2o1kGKkydYLQFBd70iSnUYJ2vrWSFOkRSHwBOOjTv
         3IDOq7/jR4fUiW1OEcn4vMj+Acn4WsEhB24/EE7+7xz0V02SfbWEoBGRr70RUIE9lZme
         4Inm6lUEKV71pFADQ8pjM8G9Nkt69H2DEmT83kkt10vLAY2jS3H9BmvuKKfT+dY3wHIR
         XnmaWm32VJD8ZZUGNyVclj2NzNFu6FI2H+mHiBre9lgPJQEoCFdy5ENSI5dLAa5uF4zs
         6F61gfg52+B07ZJnmgeXiLAuqIPr3RnlGsCCzU2sWhBQ7PPUT58PVpJrEUrsPlpGy6Dl
         K/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722951986; x=1723556786;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2B5+WTR5fHsn5YvtfTT61S48+OsOawPtKzrF6Q/zeA=;
        b=KsR590d+ozg6N24t75EnMp4CDgUy+eE2lD3Tj/1+NdFhwsGxW0qfPL+NjZP5pVESUA
         bu/4FgDuKVZE6Cu3byMxSoNCCXW3tupRuGFWKwiwWkRfwjAqFScAeaBks82NAd75LemP
         RvoJFibZDkjUG1yRkyxskizpxyH9SAigHtdCnxQHQ4P2s3CVLlo3mshhC3FYzt2Vtolt
         +aGpguUuYsEqxdu6Z4/PUOVNgHk7E3h4tU8Sm17o2sM2+yL/YZmuHG8+46krKAGvG1OD
         1HXWlnEUteLi7JtV3YpfL80iqE3jO09M7XI8Ybm75FSez/5ktimx/OC9aCmXAw7rg/4O
         DOOQ==
X-Gm-Message-State: AOJu0YyggnwZwmXx4kLiW/vwaEAaExTeNPn6s3/zumLZOW60W/RGKnb4
	8ec5Z4nQYMLJvvSYDziv9UOnctX+RaVGj/FNAgnzGDKe/2twobUCSU1QeT21
X-Google-Smtp-Source: AGHT+IHLOXf5zpKi1lF8AlCFg+8nyoGSFqHomRggPyripO/6zKTtZrO29gukL8JtIuN41I/l+2BB9w==
X-Received: by 2002:a5d:490c:0:b0:368:6596:c60c with SMTP id ffacd0b85a97d-36bbc0fc73cmr7632353f8f.30.1722951985727;
        Tue, 06 Aug 2024 06:46:25 -0700 (PDT)
Received: from DESKTOP-KPV6ART ([39.45.132.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cc9csm13133075f8f.17.2024.08.06.06.46.24
        for <stable@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2024 06:46:25 -0700 (PDT)
Message-ID: <66b22931.5d0a0220.200175.53d6@mx.google.com>
Date: Tue, 06 Aug 2024 06:46:25 -0700 (PDT)
X-Google-Original-Date: 6 Aug 2024 18:46:26 +0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: elvislehmann891@gmail.com
To: stable@vger.kernel.org
Subject: Bidding Services
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGksDQoNCkNhbm5vbiBFc3RpbWF0aW9uLExMQyBicmluZ3MgeW91IGEgbWFqb3IgZGlz
Y291bnQgb24gQ29zdCBFc3RpbWF0aW5nICYgUXVhbnRpdGllcyBUYWtlLU9mZiBTZXJ2
aWNlcy4gV2UgY2xhaW0gYSA5OCUgYWNjdXJhY3kgZ3VhcmFudGVlIHdpdGggYSByZWZ1
bmQgcG9saWN5IGluIGNhc2Ugb2YgYW55IGVycm9yIGluIHF1YW50aXRpZXMuIFdlIGFy
ZSB1c2luZyBjZXJ0aWZpZWQgc29mdHdhcmXigJlzIGxpa2UgUGxhblN3aWZ0LCBCbHVl
QmVhbXMsIEFjY3UtQmlkLCBBdXRvLUJpZCAmIFJTbWVhbnMgZXRjDQoNClNlbmQgdXMg
eW91ciBwbGFucyBmb3IgYSBxdW90ZSBvbiBvdXIgc2VydmljZSBjaGFyZ2VzIGJlZm9y
ZSBnZXR0aW5nIHN0YXJ0ZWQuIFBsZWFzZSByZXBseSB0byB0aGF0IGVtYWlsLCBzbyBJ
IGNhbiBzaGFyZSBzb21lIHNhbXBsZSBlc3RpbWF0ZXMuDQoNClRoYW5rcyAmIEhhdmUg
YSBHcmVhdCBEYXkuDQoNClJlZ2FyZHMsDQpFbHZpcyBMZWhtYW5uDQpCdXNpbmVzcyBE
ZXZlbG9wbWVudCBNYW5hZ2VyIA0KQ2Fubm9uIEVzdGltYXRpb24sIExMQw==


