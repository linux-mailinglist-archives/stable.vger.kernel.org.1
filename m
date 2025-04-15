Return-Path: <stable+bounces-132777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA63CA8A91A
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 22:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498137A5159
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 20:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1FD2522AF;
	Tue, 15 Apr 2025 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLag4aO+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1A23F296;
	Tue, 15 Apr 2025 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748305; cv=none; b=G4ogX23xhWp7tAGXaONGUly8Z9LgNz3oJMANVCQtNurtQmEak4CnjwQ4xHhXISZE7DVUvP72qIGgl3XVjUO3T5onD2jV4T6DYE9wFxKgbG+GDzmDaZfBfD6XptUgVnYKTLWnFhikvshzBeaGhatkoMEOuc0rH4Vj1r6hJ1rVUto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748305; c=relaxed/simple;
	bh=HUCgCm5eBLHBStR2O91yMADuZKW/BMOxTb52gGuSDa0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V7ctYfixT37IZ4B3KMrtiIghHH3mEkwriklorC3hA2XrH1aqr/00enyUq0m1dBOorVRRxmDuaPNkFkydUpNR3VxUJofSt1cSXa26iNl4eYUIIAhGApDt8SNIgF7Ul/AtNtxv6fxoEGmgRkdI4xFImT9IDGt9TViLoA4JvnoiOoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLag4aO+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2264aefc45dso89559065ad.0;
        Tue, 15 Apr 2025 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744748303; x=1745353103; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HUCgCm5eBLHBStR2O91yMADuZKW/BMOxTb52gGuSDa0=;
        b=GLag4aO+oa2SaAmfyhtFFdHG//MwR4hGaDOemRYWlZu1fKKP9R4K5HvcbJD9e0mAlV
         sDGM78Wpm2dJAMzbm8jtXkuFPGIeZmgxo48JMKXg6NULiMPV3932xhDnEXelmPiFtrA9
         KoNGjS4U/s91wJIzFqU1Hhot69q7dBgXIm1WtkciCMRkEi3Bta5xzCPeyC17NhQXm4e3
         8IrJ0dMr8l/A4oLlrPJljx7DUbQ5j06droaOEPLlyhMGeCCQCDUUKiNX2Q4lH5hQMBOZ
         uMtP6Aht4336jg2Snbo+y/t8OAxdbd7ZzKx/ZcO+4UJ7YF0c2fHqfCRnBwMJ2d8b5P6D
         pCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744748303; x=1745353103;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUCgCm5eBLHBStR2O91yMADuZKW/BMOxTb52gGuSDa0=;
        b=QCSnurKDofQUMVE2yRjyFC7aPzfzvCnYaEl56gHJJFuYkj/jRGrB6KxLMo1Y3S/6qL
         phmZRIqV6aGL9So9DVPUQ9MsvJe4qdsVhZGl+UoabYB+1OtYW/+g8wX0DBIK7m9Kogft
         D3ByCtzcOcSkiBc0rffj0YjkCsG9yK5lkMcXOvC1+IDe2wVhu7lMT86Z03Mq0OLY8Vxw
         Jh0FCfheUCXrOhIL6ybv4BLt1N74XIpXZopu1fNMygIuSFaYafpo1/UgwY+sR2NOqA6c
         QhiqlpgXfTnV/Yxh0swLqd7/UotMuKTjIbFbk48+YxL0tSfUQ7rOmdG2tific/dtSVvM
         GY4g==
X-Forwarded-Encrypted: i=1; AJvYcCXRzk3yObeG+cvytsI9XZUY/CPnM0UzLiSpWN0DX9kS9Evrmy5cdZ2EC50GuBq8aKHeVvlGjWr/dLpJQIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwohbvBrOpLjqmYlT+/MMn3/hbX9jyc4ObQgTwsmpxpjIC+BvYG
	R8s62P+sld4ZpFsWg2WK9vTQE8inzWmU2inbm8P18Ry+dQfq8PHJ6eN1kzioB9A=
X-Gm-Gg: ASbGnctWNGyqPaXfWqVJbQ2yKZ8u565X7N/PA5ZrhYhcUGyz1k+iNicpUsY+Yt/nWEs
	FcezAO7a6wKoMP6YWu0ayQ4+tXqgaI8WmSUITzX1vuBuNmo2e1wtvkh2JQjYhX+I9+JhkquRXQq
	zxnZ93xsf2uLbUNH6mN4EVagAFx0MKDcJAS+AqbZIIXka/vf9D8OCojQ721k+OAqYALMMavy+dl
	shuQs2tmGYlF/VTLNDQbMtWdZEY8sCd51SWGiEOZKZeVQ3yvEnc2m58n9qwwdNxjGm98AYWc2QX
	4kAiZk4NNB2HCpFfyYxbYdb22F9nt4ydJjVJvH5mVE+ykAQ21e0=
X-Google-Smtp-Source: AGHT+IH/ytHBXGU5OM/n668fjd1qsrWG9AAAgNczpgx3aah4xfC2RHe6JCsWXKntuyYTDtniSeWVWA==
X-Received: by 2002:a17:903:bd0:b0:224:192a:9154 with SMTP id d9443c01a7336-22c319f6538mr5544235ad.26.1744748303103;
        Tue, 15 Apr 2025 13:18:23 -0700 (PDT)
Received: from [192.168.68.119] ([49.207.215.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c5e8dsm9219018b3a.59.2025.04.15.13.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 13:18:22 -0700 (PDT)
Message-ID: <672c16c5896fb2ce73c9fab62853230164b99629.camel@gmail.com>
Subject: Re: [PATCH 5.15.y] jfs: define xtree root and page independently
From: Aditya Dutt <duttaditya18@gmail.com>
To: stable@vger.kernel.org
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>, Dave Kleikamp
 <shaggy@kernel.org>,  linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, 
 jfs-discussion@lists.sourceforge.net, skhan@linuxfoundation.org, Manas
 Ghandat <ghandatmanas@gmail.com>
Date: Wed, 16 Apr 2025 01:48:18 +0530
In-Reply-To: <20250415180939.397586-1-duttaditya18@gmail.com>
References: <20250415180939.397586-1-duttaditya18@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

syzbot checked the patch against 5.15.y and confirmed that the
reproducer did not trigger any issues. check here:
https://lore.kernel.org/lkml/67fea0bf.050a0220.186b78.0006.GAE@google.com/

