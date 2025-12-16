Return-Path: <stable+bounces-202085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 578E6CC43EA
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 17:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C75A7306EF3B
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201335CB65;
	Tue, 16 Dec 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMRT+5xn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F035CB67
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886766; cv=none; b=dMilNQCU7ESJ2a7++e7rx/22oT55t6+Q6j2stHqc7zCVaNQd18+9sTChYAsxLWGcYxLSyHvG2IpJatu4iZTXLCZ5CN181+hCbiPD+YawtYgSSiIXQqBumPrREEhkr68r+WqW7B9tzqaQf3rv6tn3/H4ZyiPHCM6a3h8XbCkOQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886766; c=relaxed/simple;
	bh=jSUVI6f5tRAnwD2oMB+vqMvGqIO1TcYj3UtT2V+GETA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZnE2wUsyFjyaEFDhjt9GTEDpT3HtwXOtX4fqNIkaEHaFa44U10OTMGdQikyK7qSnQNly43HdA+3XfUbu//HMFNDFf0VXh364fIS/5qajBwnxzB+yGcfxaM/opWuULZzJ2AZhCXjELhkRh2napUxSEG49dVVKeROcXZYom3OU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMRT+5xn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a102494058so9859975ad.0
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 04:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765886762; x=1766491562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jSUVI6f5tRAnwD2oMB+vqMvGqIO1TcYj3UtT2V+GETA=;
        b=nMRT+5xnjFBHCFjTG6vZmKz3twox+gg1+mbgLHRBKQHp5BETTMjzATnjDvozMFiFc1
         bY/ewK7LIwmTFpgVCfvLMTq3iMXDP17O+gf71lC2bHabVfI9YKTqusXuSKkxA0/71PdG
         ZdUoZlIpZqARh4XOVCnv9gvqnQSPCuCPVx3MO8FWiUREOo2Hqfg3FSeMS6e+UarwEkak
         Vmjomg9ZyPae/kVsze6hl+gjJAE/Mr+W2yx0ukhPHVzysVwRUcg/9KZHuKPOLeipQeXv
         nM7hXshcMt+8bpvle5atKA7SzMYvo0xmJvRI2NhfE/eY3MSJH5yobfNuisNN2Wpvw9gK
         TRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765886762; x=1766491562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSUVI6f5tRAnwD2oMB+vqMvGqIO1TcYj3UtT2V+GETA=;
        b=QrU5IXc0Cw4rbbK5g5p4Gkd6LGwIfdMMpwnqlxhruasUZ6OxaRBGQKVJ0N2eB7bAZe
         5M0idAB59OhLmDlkThPs2oi8DcihXVCQx7eZDlJKLg6vAebdFvFQ6GldGS5G5vFdU19j
         qphblGaaEPqBFN+azLgS3v9+Z38kL/92R6qWPTVHXOIlPLeiRu1O7A8Lr8CsYSeEEPTQ
         dNS5MYMtXQVEWGRrrsgCxopxoEShb5hmie7fowGaab9XWKz7jmGy/L8GfsFGCyYNJPkl
         Os3dCbQtmAlcabKXJS6NXF7q7gJupMVqhLuCrCqWgl04TyzdaLrHhtUOBjEwFpAjk7Sl
         pPPw==
X-Gm-Message-State: AOJu0YxpMuOqI4ahx2XRJuvbrnSB3xTAxo7yxxFoeC+JtMRZf5Z7C7JA
	DDoiyquon9KdHxnFFTRieQUz4EiCPPJm6wMf+8c1yDALhLKQDUipsOWQ
X-Gm-Gg: AY/fxX7cQxRW0NW71XEKcxUwZqro+/vKJ9W+Au9t4UyZVQkvG39b1rSBf4MOWqfzafl
	dCsA8yrXL5bbOuOczUPswYhySdY7Qm+Ipsdyr8mhtSioQLNk0ICQE2RRnNbQjRdBuDBCZABPxTY
	0N753MSYK9hXTmp9tox6P0WQLyA9sY1VsWcp3Cmb25CKSLk+WR4hZrTjqQI3JZappdSWBYC4xTx
	gwVGjHUrlzUGCOtA0sqve7rEcGqfn1QhxsLoZ2oOQ2/lgxa0ZLyqDvokol8U0IUKXWNDgX3nPWw
	5QRe2jItWmiWPoCitTepit+eDfTEVKMM4dskm0gFbs3lxoVfi2sm2BUWJQlcAUa8XJvdOXq3174
	ehqIuzzK4oJW4JiNFzDGmLqLb3NY68hnV0oN+a8FsPXOeUlgdtShbGUzhUAuskHz7XUbGUzwPw4
	QQfPQ=
X-Google-Smtp-Source: AGHT+IFwRTdXM4O9+3kZRu/SEOLgPkojsUoOv0NGfNGUF4KDbp/3Uv7c8RnU7H44OL2LRyNHBTbaHA==
X-Received: by 2002:a17:902:ce89:b0:2a1:3769:1d02 with SMTP id d9443c01a7336-2a1376926d1mr26553875ad.12.1765886761892;
        Tue, 16 Dec 2025 04:06:01 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d394easm161312305ad.25.2025.12.16.04.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 04:06:01 -0800 (PST)
Date: Tue, 16 Dec 2025 20:05:58 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com,
	syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/readahead: read min folio constraints under
 invalidate lock
Message-ID: <aUFLJriRifOpmubw@ndev>
References: <20251215141936.1045907-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215141936.1045907-1-wangjinchao600@gmail.com>

#syz test

