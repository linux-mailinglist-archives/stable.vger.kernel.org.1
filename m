Return-Path: <stable+bounces-151454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9B2ACE47B
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 20:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FE73A8A72
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 18:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1671C84CB;
	Wed,  4 Jun 2025 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRUIoWmL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A0320F;
	Wed,  4 Jun 2025 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749062733; cv=none; b=tqmbXYWEtphRfD24uO011h1mZY/dvdlSNOL3Dyxi3To7g1/60B+K4cTySheuxlO70biHgO/Y8Aer+kDExXomL+F+IMDgyxwcyGGuzc25MGdDAjCFwvHUQB2mGoCc3NNMaaoD4bKwxDJLt1mBH3YuKWkV7aZZ0xZEpPa93A85tws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749062733; c=relaxed/simple;
	bh=vxCVyWWhQlkzvPQbfl/7Cxf4eAEj7aB1soeKC3YjQ6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftT/+cYCNbaT29zL0AjqVtyGXs5SZR+zYvuPgRwVJxloDMiqpOTyDip6H4lzQqI1zvOGRKprTwsGxno01oqXZ0iOD2rbPpkxBlBFfJmQLMck+BJhGhUKVHt1m3pf+ty64BSJY3d6RvmdBWPUOXYtHn2TBhYgGyLkL1uN4vYrTro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRUIoWmL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so136197a12.2;
        Wed, 04 Jun 2025 11:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749062730; x=1749667530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgTiHxBzTKaFmWc4QPi+6PexSAWi0fDvC6bFJvZ/gkE=;
        b=TRUIoWmLjlfTqrk/vu8tYbSTQRQ45jG4gG3l5nIWV7tuYHuTsjF99C3KaUNxhOJn/f
         rDUlH5q4eDO6ocRL42Y6TcQ2QXAmPXRpts1azmLvZa42nCShXxg0MmlQjhVUR1iIdhEI
         bnUqGRwKv8xDzOW8+qluDhOX+WLZ5IC1lxe2bemk1Z3hm03dNo0eKxX2jmQ1tQMb2jpy
         3xNORwDjGq8SVfgG5pd/5Ge8aSOaTWGqJXM+Rk7KjXYiNVSoNskUJHcZzMs1hlw98TIH
         PCvvvDbQjRBn0ixK1UikE9sQkRNO4OD8ANMgCX2qkFROdqJQr3KxqSgqlQbHJspdMXLX
         vA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749062730; x=1749667530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgTiHxBzTKaFmWc4QPi+6PexSAWi0fDvC6bFJvZ/gkE=;
        b=bRIX+y4FvM63SOPhPbdrH/fwLWAaxKptyhXfRj6d0/fTc5ifGd1VWEDPeSRH5k2Mxf
         Y1K9NvWtXs8kEk7xEQ2IvEf9ytMjzjttmvi2IFnwjh8KnpB2xn9uGPY4XVztOjGmlbQX
         HFRWnLlUFj1EpZeCZy+0FWp8oUP0xSOMxZXQDJLJQ7nNosEHFJGiQFek3YUBAd+E1/mf
         7spOHtLuQm89gAZqSZ6srds51VLJrY0P3sz6XgTgyoF0vmfldzJ/OCCTMvGbc98fpqlQ
         YsIBKIbO7CPyHposnyKYehOxd0I/PCzg+nG8tqkIj8L8Gr+KTk69xgUwDJDcPBAhMY7T
         3lLA==
X-Forwarded-Encrypted: i=1; AJvYcCVbbTuE0MrYt/cfhp48aXEyU4//VENJKo9jeazM9Zzz4cRiZV84olF9lgENvX63clbujFArZKHS8gmD+u8=@vger.kernel.org, AJvYcCWErRZvFI+ftdQhwFQnl1dsZ+/mnWv60/1qa/o2Cnk4EGyyShG8JohilrxeC/oeM9wtGJI+xP6c@vger.kernel.org, AJvYcCXAaj2UhEDLJtITqvdlCdUpo0/vOBxDo2TDFkcOvBa5I4nugEtXyruXvkfqHgRsd07+Fu6V0r/J@vger.kernel.org
X-Gm-Message-State: AOJu0YxGZn5RfDm4fdntrnN5C2KMVj4hUlXnvtkAgkUsgdnQbHhzlLdl
	2FYZGWnmBCev7WdBB5rCMxZYJOBw5tEInLQUzguPrpUnl7E7aFjCJTs=
X-Gm-Gg: ASbGncv0bkwV7/m/zXzGYUfXv6lSuKbcTCsBlSAqKj2kCunfQz2Blbmw0QZ8eUZBDKi
	jGYNxpF914W79gTjK4QSUJiYMtdLEyvQIniE+ohlv2oXuhurV3bC9CH+oxLl/aYCUaWdIk75gll
	BLJd4/XpW5IgZ3tulgkkaeMe5sSeKnnpGKCsp7iBsnLW+RWPyKyQ/d/GKipujeOmnydQwsD+BFR
	tA1q0wq3LK8o4QinQ2eFt1bRsHvS+EEA5UBAQuirApiTnaL+gUrPkyDdRsiPwY+j3fgv3ryiHpL
	GUHAxlvQg/s6sHGbuE09v/afBm3EAhv/deDS0DQ=
X-Google-Smtp-Source: AGHT+IEUisit5NvJyIWDyoFVMr56tvNKJ81u0SkMEFZQ6bFWKE8yqlvVMO487udN6WK9dnBezoiavA==
X-Received: by 2002:a05:6a21:618b:b0:218:59b:b2f4 with SMTP id adf61e73a8af0-21d22c52999mr5642535637.42.1749062730312;
        Wed, 04 Jun 2025 11:45:30 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeab785sm11834510b3a.56.2025.06.04.11.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 11:45:29 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: lee@kernel.org
Cc: Rao.Shoaib@oracle.com,
	aleksandr.mikhalitsyn@canonical.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	davem@davemloft.net,
	david.laight.linux@gmail.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@amazon.com,
	linux-kernel@vger.kernel.org,
	mhal@rbox.co,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6.1 05/27] af_unix: Replace BUG_ON() with WARN_ON_ONCE().
Date: Wed,  4 Jun 2025 11:45:17 -0700
Message-ID: <20250604184528.141251-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604134347.GH7758@google.com>
References: <20250604134347.GH7758@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lee Jones <lee@kernel.org>
Date: Wed, 4 Jun 2025 14:43:47 +0100
> On Fri, 23 May 2025, David Laight wrote:
> 
> > On Wed, 21 May 2025 16:27:04 +0100
> > Lee Jones <lee@kernel.org> wrote:
> > 
> > > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > 
> > > [ Upstream commit d0f6dc26346863e1f4a23117f5468614e54df064 ]
> > > 
> > > This is a prep patch for the last patch in this series so that
> > > checkpatch will not warn about BUG_ON().
> > 
> > Does any of this actually make any sense?
> > Either the BUG_ON() should be just deleted because it can't happen
> > (or doesn't matter) or there should be an error path.
> > Blindly replacing with WARN_ON_ONCE() can't be right.
> > 
> > The last change (repeated here)
> > >  	if (u) {
> > > -		BUG_ON(!u->inflight);
> > > -		BUG_ON(list_empty(&u->link));
> > > +		WARN_ON_ONCE(!u->inflight);
> > > +		WARN_ON_ONCE(list_empty(&u->link));
> > >  
> > >  		u->inflight--;
> > >  		if (!u->inflight)
> > is clearly just plain wrong.
> > If 'inflight' is zero then 'decrementing' it to ~0 is just going
> > to 'crash and burn' very badly not much later on.
> 
> All of this gets removed in patch 20, so I fear the point is moot.

Right, and u->inflight never gets 0 before the decrementing in the
first place.

