Return-Path: <stable+bounces-98187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD25C9E2F57
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 23:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FA9282794
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 22:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7203820A5D8;
	Tue,  3 Dec 2024 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KA3rpXIt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115B13AD1C
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733266591; cv=none; b=MYHiYWFPmUk1aWET43iIROloahO80eCoPPi2T+pKhanwWQNCvbC7VmevboEYPyPZXOeZgeGHb9mS5qPBQVqHfgmf/bFB2m7uGSMyoy33ovltOyApTIjQnJQ6ZRf7q2PopDitdu4B/cVgTWW6toucCZfc7gff1k7C+s25AF8xDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733266591; c=relaxed/simple;
	bh=9J3YtjJVaIzs2sqlqTmw9Ioc2v4jB8siZkMzuKRLfIE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qYEXK6XVgqVUQ/cto6Bp8A/OVozm6SPLRicBWk7khR6tleZliapVDLdAm4/mXPGUIQisRS8fSI1olqoWdgJl9SZalcmic/9b54HZNI/2Oy6aikM56UMnoeDZ4YJX3lZP3A9n5vTjDVQaljqsISq/MfF+3RbZatKT0WMMWPqPwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KA3rpXIt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724ffe64923so6421190b3a.2
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 14:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733266589; x=1733871389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNuRSE0qt5OotBDZPQRc+y7yttPjFAS0Rpx1zXr0078=;
        b=KA3rpXItETAFyjPwew5p1REjVcnq8+5bDecMBk3+CYYzviVr/D9nYIn92Z0ph6XvGg
         Ir9G5OXm+yT4kHkLIl4QBtv81V1F0z9M3ZFywQEsb2Iu87QkljSExfVAvj+/KVIOoAfR
         Ey0CgrHQQXA6g1phWixmwgRU1grS9dLN6MWiurHfFPxJhmqFJXD//VrqrlgHfP9eFBvx
         b1TBY5eXB+VhlkPh1m2AwQhDKQGuWyWc0PTWUaqpdO4mlamOAbQ9hJWqkNINygxqeBgi
         /nIwn6iUUjq9OzbNqJHxXILXT6aEJ7RD6lXkl4wigSgEGGH26bFoO3ynazxf11cAWLtc
         JuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733266589; x=1733871389;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNuRSE0qt5OotBDZPQRc+y7yttPjFAS0Rpx1zXr0078=;
        b=uu/5OnQsYDwYYpp6AxOte/ivPktdwdyrHFwWKtDin78Fhb6F51s2NaxhG3SQc6L86t
         +Zl5RwOE3nFlv5xlB2O4fML5EQbKwHjXWeWFhNHRn5fbB5E/0NjxlPUf+9/imIGDeZJO
         vLniEDg/pThcvqBtMiN20Qu6sXdnk3ScO8fmH0HAd6jKqKiFpfCKLCuBZG8So4RgwSrN
         uHAEQvXF9pksTqATPmRH9xaLw9IonjGyYJ4RKY22fOPt8muN7VKZRb/kEhVFLXP0BArt
         OSzz8X1bwGgKjmO1Tb0JTt2RXxP0cwefnLuETNyRcFbkQgzx8xoOVKChmDVwdG4Pxb8G
         4vcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2CukrrZysleZNpfLwBqa//LQnubTIxHYhNYncFTOnwb3VK7HoEJ/EkMaLH+/rIPNXd8St6uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0QiIjhePgIepxDkOLYwBHdbE2tppd4aHZq/dBJxJc5PZpIDGW
	FGRUJ8nVBl6+0z2goiHT7B/SkD6M602mhMAVqNKqPp3a7L7L90ZVNg9yZ9tau/I=
X-Gm-Gg: ASbGncvQMXNSGhe/mII0DC3Td+H9rY7+NO1Ac4fPL8tk3TWpBqPy5o/OMr2YDoVlkjO
	db379QQovXXX0jK0vnS1dCiJXAQjowDZzwlxn1efWDAeFUuGXaMoj9mpoNFCNKXBR8Dq/cP7c40
	UYyzlcpK6ik4O4RofgiQbdtlRe9W3h5Jwl1SNrLT2eD1w/vN2FMzZtwjFNTN8bYmRsT6wkfGSXn
	Otl/H3qpDETz7MOpl1hJVqas9fgttTtRrHZA/MvsCvxVUg=
X-Google-Smtp-Source: AGHT+IFwbu5Mn9fY8ujvfbEmhblgpduelrIHva3SSxokjUMLrmvWEB884oPumQCB8f8AE8L3tnBedA==
X-Received: by 2002:a05:6a00:14d5:b0:71e:60fc:ad11 with SMTP id d2e1a72fcca58-7257fcb04ddmr5761701b3a.16.1733266589105;
        Tue, 03 Dec 2024 14:56:29 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:c150:9b72:bfcd:78a4:798a:3876])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541845526sm11049954b3a.171.2024.12.03.14.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:56:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 Liequan Che <cheliequan@inspur.com>, stable@vger.kernel.org, 
 Zheng Wang <zyytlz.wz@163.com>, Mingzhe Zou <mingzhe.zou@easystack.cn>
In-Reply-To: <20241202115638.28957-1-colyli@suse.de>
References: <20241202115638.28957-1-colyli@suse.de>
Subject: Re: [PATCH] bcache: revert replacing IS_ERR_OR_NULL with IS_ERR
 again
Message-Id: <173326658691.273410.3875499792580275735.b4-ty@kernel.dk>
Date: Tue, 03 Dec 2024 15:56:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Mon, 02 Dec 2024 19:56:38 +0800, Coly Li wrote:
> Commit 028ddcac477b ("bcache: Remove unnecessary NULL point check in
> node allocations") leads a NULL pointer deference in cache_set_flush().
> 
> 1721         if (!IS_ERR_OR_NULL(c->root))
> 1722                 list_add(&c->root->list, &c->btree_cache);
> 
> >From the above code in cache_set_flush(), if previous registration code
> fails before allocating c->root, it is possible c->root is NULL as what
> it is initialized. __bch_btree_node_alloc() never returns NULL but
> c->root is possible to be NULL at above line 1721.
> 
> [...]

Applied, thanks!

[1/1] bcache: revert replacing IS_ERR_OR_NULL with IS_ERR again
      commit: b2e382ae12a63560fca35050498e19e760adf8c0

Best regards,
-- 
Jens Axboe




