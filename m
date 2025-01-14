Return-Path: <stable+bounces-108636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D006A10F8E
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 19:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB35188BD61
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 18:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFA92040BD;
	Tue, 14 Jan 2025 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TtUt0xtu"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899B1FC7E3
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878207; cv=none; b=YGznrqqsqu2WD0HpDceZNbFQ0nCJ9C3cnJ6exgPKX7ECUxE2jJYkGzT9wLSo2UEGASZXnc7uJ/VKyyvKBGhxDv082lAcU2Vaip/6Oz77WkQ+SuaZsHvVtsY4nlyhqDNic6bJPILIH6oCISb5qAd0A8izenGqUgwtFu3ds9ZQtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878207; c=relaxed/simple;
	bh=xt2EUpR+Drgf9WZVcSI4e/bScCfCLpE0kwHYQgg2tlA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iAllNM/lemtpvzs/AOy24OH+okjqja4UPg0Jbr+0wo8C+QMAWxbuOI2wn5ChYBUg6MrYq7dG6zkcDkSQJSaNOhmDhGP6z2rZg5ZpRh8VSpD1j/k4rZZK55DSdjikBULK5eFti2FN+uEWu2mxA5MUc+PfFjrh0BQJBG4oXjoM+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TtUt0xtu; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ce6b289e43so22456295ab.3
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 10:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736878205; x=1737483005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaooOFOGtKSVaMzqMlIyw6V93Yl6VrFQA2qk2SuiUTE=;
        b=TtUt0xtuXiHuJP68t7ijiM7HYbc7asuyQ5pGEpIIs8tdrVYj2NmppEcTVP/bgitnZq
         xtD+WvLdP6yOkq+lDyhxUNAhhydjF+0L0LBnVTsBoGFYV4PUZc4Dg+GS4Uu7JPDAp+l6
         RjpQuXfnZdsfCR3a+4ph0FcnorA733EAqIi46Lid/UjYQhBer9Rs+IK9RpLHx0pA0mOV
         R9mO7Az7a4/z/WGTUtxs/ewr+VTMv1EjOEIvm7gB2qUbybbIpN6QPALVjwel5QX3csSH
         Ob54G3ptt2K3I6jHdrnR6Mw0boubc9ILcSjo/J2tCHnCSICMKMDFQypSZDSuoSwAZXCs
         bYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736878205; x=1737483005;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaooOFOGtKSVaMzqMlIyw6V93Yl6VrFQA2qk2SuiUTE=;
        b=eDL9dc8mk3IHzU/p6YB++KvM2PuvHCxsgIh2lAwoO9HA+oVarbVz3KhWqYHau/cyvt
         iAuXw0Sh0adpKOWbSwj5inOygpRIjbaUKMuHmMUAp3fTLr5m3CtgZsBueoCWlAXE12e9
         MDb6p4W12H8NUNmhfASZ5ErpSgVPCWVhVuY8SLXvdSaRHf1JFbYycakKZeV/eLF0YjND
         2TGqCJZhgdBDIzojReQ0A7DtjAkPZL8o7cteMJOAU1FwHvA5i80y7xmb1yUKqwvyOQEQ
         LEoKvoZp76L7udWeWCH7F3EGGaUyMDbLePjqmoyjLIMYyCxftzmYSkYWk81w7UkoHAlQ
         1qFA==
X-Forwarded-Encrypted: i=1; AJvYcCVc3St6sIUx0s5tB9etN1nnylDhCX3nRLuSbAj9FGMi3+brTFAh7FLlQ1BE65O/X7Pbr+FoawU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWSonyYyeJswTYln/ltpUkjlwEjWhM7pTE4evBuTR6TcDoMTDn
	2KS0QKRX5yn3E6fKLHMm/kZe4ZWCMkrevYm4nglwWdJ6jMtunlOsBHmdNV6ZmNQ=
X-Gm-Gg: ASbGncvBqUhi/BLOWder+ec/f/rmDBmEN/RdJD6B3m5cEFCXbWxPpfm5rnPzgdYhjLf
	YiMAmYG6fYQE29r41TGIejn5BtxcTm/MgupuSObz3Mp6vovrj2mghC5bOE4FnZT0dZ0+VMz48hG
	OcumWPy8EAXx2hTtDxBN42ZnthYBrVbk8YB2kVfsQ2XKIUiiALjq5LmXsHpAKwso963WixVZ10c
	vb9X4MzNySJcy6w+SBlzx8oCSAlygPJuhCXyzBnWA1THWc=
X-Google-Smtp-Source: AGHT+IESxb4ZBWnQjANqv633zPRNwgXlL5qp0koS0neZNYlYqJdfFfgNSI/Dd5CsOfd6P4zPzpKMpw==
X-Received: by 2002:a05:6e02:1f8a:b0:3cc:b7e4:6264 with SMTP id e9e14a558f8ab-3ce3a892c05mr203910065ab.0.1736878205032;
        Tue, 14 Jan 2025 10:10:05 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce6c1fc60dsm18220165ab.7.2025.01.14.10.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 10:10:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
 Jann Horn <jannh@google.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250114-uring-check-accounting-v1-1-42e4145aa743@google.com>
References: <20250114-uring-check-accounting-v1-1-42e4145aa743@google.com>
Subject: Re: [PATCH] io_uring/rsrc: require cloned buffers to share
 accounting contexts
Message-Id: <173687820427.1326090.9681462149230294879.b4-ty@kernel.dk>
Date: Tue, 14 Jan 2025 11:10:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Tue, 14 Jan 2025 18:49:00 +0100, Jann Horn wrote:
> When IORING_REGISTER_CLONE_BUFFERS is used to clone buffers from uring
> instance A to uring instance B, where A and B use different MMs for
> accounting, the accounting can go wrong:
> If uring instance A is closed before uring instance B, the pinned memory
> counters for uring instance B will be decremented, even though the pinned
> memory was originally accounted through uring instance A; so the MM of
> uring instance B can end up with negative locked memory.
> 
> [...]

Applied, thanks!

[1/1] io_uring/rsrc: require cloned buffers to share accounting contexts
      commit: 19d340a2988d4f3e673cded9dde405d727d7e248

Best regards,
-- 
Jens Axboe




