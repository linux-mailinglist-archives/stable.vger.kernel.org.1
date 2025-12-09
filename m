Return-Path: <stable+bounces-200427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D345ACAE93D
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 02:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 135EF301FA53
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 01:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA7F25CC79;
	Tue,  9 Dec 2025 01:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPBLqesM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C724EAB1
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765242395; cv=none; b=lvo+mZ0DBmthQr/smpx5xx70Pb8yDicAS+2qAgJY0h+SbgniZYDJFSTqJ81i40B/d5FFDR/4RPWia7Zp+XupwjrOrM6H6Hw5nTb29IqaEpIt/8PTMUIqG7E6A0I5UdAPEFbFAxvBI6zeMGYwLlsXIq3Va2VqtJR0WbgVM8Q/ORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765242395; c=relaxed/simple;
	bh=+snQBG7CbmrfNDlhb75QHY3hvT5yBZoez4IFQwYK420=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDBznKR21ar/05aolrdZIJ4ZTHHNj0C/YUnLEXFlShiRC+lB+WP5lzGzyLBllj1HB9PTDDCvJYXjG2x772K63zN+nLXDEbvVZMTt4Jfc/vBR91SHO6uCPwTzopjnFdKfcAl18tHYhm8ItdMAsxFmt++SflmzOFwqSpn0MZ2SjRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPBLqesM; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-34372216275so5123932a91.2
        for <stable@vger.kernel.org>; Mon, 08 Dec 2025 17:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765242393; x=1765847193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ozqCtn6sHiDj5BY/ISqjH/nU8F0CWU/yCHS8wMGPQU=;
        b=jPBLqesMYS2jw6ibnqs3HxAVazYQAN/zGda4WN1EnDziFkhup2KlmHWPOw5mxII65j
         MWx8iXXwmO3EYfwZ/slNG7b2/Ec8E1LQ+WzAKTMXDXASp0ZSk8Pj7O/xD+CHn9Xwl74W
         pcCpUC46Gr9TTfh975PpzW9oQEg8ebBtBlRbK+7qSjk0j74BiJ2IHb+jsst+heK17CBd
         cep61gz5iX8dSg5bwhpLrISaBl8H6n3m9zgVxcvsfoRSJnuvx0kGGiri1ADohYO8rm4i
         iOfC4ewbzipISlb4msC88DK5cEY+SPxMaKY0DKE2pjbgKHJUAQ4jVTRO5PPhIWxVFhcK
         nSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765242393; x=1765847193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ozqCtn6sHiDj5BY/ISqjH/nU8F0CWU/yCHS8wMGPQU=;
        b=p3WdR4tR6huAuXkjGMxvbkKghmF62QZNBh3MA6uzf5OR63xiAIWapLthUkW0VTfYph
         UewJW02/i9+ciqxZfJFWII2o+om4K4Hjpva8LZI21Zwp+eHrlCfP08NyCszN7RaVpM7l
         l36xf6RmlUUio8LwEOJ7637udl9Eig6PD7J4ceVbSOfnIyOxsmLW+kvLq8zKGhg0Avj+
         mm2Y9Yw9859O/4PbU62fVFCspCg9sPZSoM8USPGMeKiBCTuM0PihZV1Rh3zkPgsK1hxY
         /FCGPuPaNSWHnN7DUIrfyPMXJQkr9f2xThYgmIwji+sbb43R3hsdQQT3fRHfwT34dgL1
         Hjpg==
X-Gm-Message-State: AOJu0YwvcxC85LwN//8xpDBqrN6ASP1q/0i1bMA96XRMTA7ncjSzvD9u
	n1KUmJ51Yyi65ZjlxztCKlAga1igZ1pFKdSfHBSiudAeI0ZyWEXMUDSZ
X-Gm-Gg: ASbGncuSJC5WDitU6sS+uuFsQHJAcCWRlhNFpoYdCKIfRcu08rG1/wLl1w5fxCJvmK4
	RjO20hV+er0DuIIQdRn8XCtFJw55INxr6ijcHr/aFumiL1EvrNlqkfnBTuFaO9JjRDzxnYnvMvr
	l4YO1CmbMPvFrXOc4cU9iT4SkX+SVxOWmhdq/jWCk7fwkITC2JY9qNgD62GCXzKbRok85GvK0hZ
	AhvEvCTTPGlH4AMHIJY5aRknaxXpR7dNdvH3wqGe2wmEWcDJuF3ep7eyd5bO+Hxjij+Yg/pRJjt
	2jkb4CjtxKxpj4o1FvQWzq0lJMU1MA1s035gWynvX+ztgt8xoW6LjJhle6M37sNxYp+fYiSLGwo
	VKv/GZlqOm4w2qHfBv/hvXf3KXKGWSGDhVkbuc6UNWsC3sluQOogCSJuxQOLKLuDFVvaqqPaK0g
	CYfuKC8PIAOQjYm+V1yxW/fvVvUGRvMCU=
X-Google-Smtp-Source: AGHT+IEZZ3GvrJg5xqvHNrqBFG7XdQNQXgOkKotztjE06kjRiztG71gYUs0kxY3kgvlFfpicRcW6vA==
X-Received: by 2002:a17:90b:562d:b0:340:c4dc:4b8b with SMTP id 98e67ed59e1d1-349a24f21f1mr7533005a91.10.1765242393269;
        Mon, 08 Dec 2025 17:06:33 -0800 (PST)
Received: from LAPTOP-PN4ROLEJ.localdomain ([223.160.153.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a47aa570fsm339440a91.0.2025.12.08.17.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 17:06:32 -0800 (PST)
From: Slavin Liu <slavin452@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: stable@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [BUG] Missing backport for commit b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x")
Date: Tue,  9 Dec 2025 09:06:26 +0800
Message-Id: <20251209010626.1080-1-slavin452@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aS14lT5jZKpwAg4N@secunet.com>
References: <aS14lT5jZKpwAg4N@secunet.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the clarification.

In that case, I would like to request backporting both of the following 
commits to the LTS kernels to resolve the UAF issue:

Commit b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x")
Commit 10deb6986484 ("xfrm: also call xfrm_state_delete_tunnel at destroy 
time for states that were never added")

Please consider queuing them up together.

Thanks, 
Slavin

