Return-Path: <stable+bounces-62723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4789B940DF4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0252A281F5B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6127B194C85;
	Tue, 30 Jul 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="dPtaesp5"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749B18EFE0;
	Tue, 30 Jul 2024 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332426; cv=none; b=isfIPnI0zbKYFX73OHH7OASCxsUK4ozwnnVGYEvBqT2Uyv5ZKzp9svgml6FtaO5q70sehAMdj2+BMbzH2iS0kW5Xzw5FXShTm2prN71az5Q56saRmUoJHAbP1Yl8ZthFjAfT7P1cP/btk20hWzhwk/GcRR5XDMXY4ptnGNzshtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332426; c=relaxed/simple;
	bh=oVNeHZDvzBbCvsVn671kV8YJr1yVUslmJ7XFxgv/sNo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OQe16pk9NGjd89rW2UTa6IMy/bKtfBdgEbIx5/0vZuNeTJ4wNIYKhfnEs1Cfmzd5qrIPVVRtN8GEg5Zulox2M9KxFjHtCxEanJIky3u4XtZBtLe/n9NB9RCoFYl4TeZtUuktDdljonEP7hEpOOSwBAexKDlFOZvqPaaDnsRLp2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=dPtaesp5; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722332421; bh=oVNeHZDvzBbCvsVn671kV8YJr1yVUslmJ7XFxgv/sNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dPtaesp5T6wMRTemmmSmugd/pjCYoyeyA3uStaGxygfgfXUwkSvF0mitcm/zsd3mF
	 q5enJdedB/wMpCGbhigJMvPRrvXJWvvyvAkgQkcvjY2AlFwPzCmFjcU0Q/BF2nQaKv
	 9Zz8Pi1qCOAGYpILPfZYw8BCfzCnVvo1ozQVGdwM=
Received: from localhost.localdomain ([36.111.64.84])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id A11BDC01; Tue, 30 Jul 2024 17:40:17 +0800
X-QQ-mid: xmsmtpt1722332417t59l2guzw
Message-ID: <tencent_02C238CCB4CAA1D0C58AF9A89E8263AE740A@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtJSFYZFoLP8d12IVuQYRBXmnqwBMDgmsQhmNz7yCeIf1iwGzIWN
	 Rnkxa83z486R2x7FB4+mBfOkldInFjNCO4zX1EBxKJM8yEDmmcs7NNAQtL3ffz5BFuyozc3XlD00
	 WvT/SLb2FEzMSId/hDQ5M4n971lch9gYGT1cTLQ3MVpEj8aLcCtH91VAdjhzzswiMs+bllw2gpvq
	 yeUC8GwbWrrfgYUnR2XBoROU4raewO8UeSmtCY7nTNekoXuLt9B5VSuSNS4FeHuvxaf/nG1r4Owj
	 rNq0p5dt82r9U23qsgrxUaXaLs2T2ozCMlHy8bo3H/clQfHtKwQDn58MZjuF3BD8P7w+9BiQhi70
	 OPnjwYw5FCIA+rNZH9dmC3Uiu2rV37vztxUIdranUAuj0gG5HddkuURMNy2Z8qeHKiMiUrR0S+Dw
	 9imUhS2EdjhshDoisgIADA6s5A3lp9CzFCMVtIgNIOUD/gRFzbg9sxQthcqj36rRulHfL7sQfH2h
	 av4YPbA7qI+DsU6MFm7BPuXARQ5RLqVqQqjbbzuEm/Y20QZGsXeOsqZQPRoZLe3zV7iFGaQMfiIY
	 /AvSuHQ0fRmRtts7RuH9J4Jw8DQci4PFRJkVCy0TrjKp+IxFZWonOLC/hR8Ve3PWxCgaHkWaTCzD
	 UQUQxRKmq3rbexUuuKo1fV81LgYPqYwNU+3w+1VysXw6wfvTflR7Fpc+JgiRA3J5Q8pDGDUzrjha
	 00yyBTKoqqyqxxsZcHbb9s0womJnjWS0uavTsRA/6tQ7MAMnout+geoQG3dt+cET0bIUUEQR85DE
	 Bz70VbpYFwdfJslopVKd81SJKddEwOcsuRtJx0HT0MYHCXnXJZkplviAWWFsmkuILtGpsTb+Wpng
	 ACZPQaEMved2yUorXowsm4JvksDmTY1h1cCiO5dcCQ2/XjhQf/w1IoIN40eQIM6IXjcZy1ipwtFm
	 dKepoUcz/qfoJgu6LFFkBJeFlEOO7MZTKhZIhaNFw4Yobec/jj3A==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: wujing <realwujing@qq.com>
To: gregkh@linuxfoundation.org
Cc: dongml2@chinatelecom.cn,
	linux-kernel@vger.kernel.org,
	menglong8.dong@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	realwujing@qq.com,
	stable@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: Re: [PATCH] sched/fair: Correct CPU selection from isolated domain
Date: Tue, 30 Jul 2024 17:40:17 +0800
X-OQ-MSGID: <20240730094017.44676-1-realwujing@qq.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024073032-ferret-obtrusive-3ce4@gregkh>
References: <2024073032-ferret-obtrusive-3ce4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> What "current patch"?
>
> confused,
>
> greg k-h

The current patch is in my first email. Please ignore the previous two emails.
The "current patch" mentioned in the earlier emails refers to the upstream
status, but the latest upstream patch can no longer be applied to linux-4.19.y.


