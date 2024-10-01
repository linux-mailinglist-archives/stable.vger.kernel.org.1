Return-Path: <stable+bounces-78312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32C498B2DF
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 05:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9B21C22513
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 03:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5091B07A1;
	Tue,  1 Oct 2024 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OzbFSgOL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D264CEC;
	Tue,  1 Oct 2024 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727755031; cv=none; b=Pyil0EQjKqwEfhavfJ/x8MYk8OReTw81AkpWZOmVhXdbRzPfYqM4DfRtO62rNTP4oWO/f9zxqzrhKundb6mVAk8ubMC5PE2nvJCNfNJpxSBUD8+JSgEL8mzdQDMjC8oUyQZPNvZWH2hGKBaD5FKh8XkeWqhWtOBKLWXdt1a4xZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727755031; c=relaxed/simple;
	bh=MqTIcPv2wreLQE3sRuPmqeOCVAS2j8QpUl+LEEm4tcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGpHvzLpRCxduecP9F+JQYD2qWeh1GLi913HU2l5C1Iu/8hp3FWjt0MAZJWY8+mfbkXgK3DC/I0a/+j6uxcop4rLSPYGpfn4lQjNTl0ON84z9IjktmnAA4kJqfsyjHog9nqJxAD7ms7pR1QQWJTNBPU0R83r0zqRrm+9UaBfAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=OzbFSgOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDA4C4CEC7;
	Tue,  1 Oct 2024 03:57:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OzbFSgOL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727755029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqTIcPv2wreLQE3sRuPmqeOCVAS2j8QpUl+LEEm4tcg=;
	b=OzbFSgOLBQG/1rVzVT361MKLIZgtBnawtYvfs8zdocl9n1f+ZfXvPX1nw7QMX+/3sxphol
	Nj/1nvU0Br2Izjfmohl0F/ZLnNZ6OfjFGNqPYzXS79ExYAOZye+3cZvnlKiS3K+UrN0Vcw
	5HhYLhdgYBANYQQLqqUloFYjylMMa2Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7d8022cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 03:57:09 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5dc93fa5639so2520597eaf.1;
        Mon, 30 Sep 2024 20:57:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YyTWKnWU+jzEJTRLKT+1bsvsC8avQe92vIrfYmhUqj7/qN969fe
	UZ13l5n9us4QpZ62AGHzINxr+QD0FPwyXgJ/9KBUaghlFS+Lw4excLQ68QC5G+fpDFmaXugwg+T
	B5ayr9vc2nWVRA3ERD2pbOFmlh30=
X-Google-Smtp-Source: AGHT+IEaS+D9MtAmHCx54MVIe95t1H3pS3k/aa5RGmX37sdnpCAfVWxL3PuWetW6tBb1GbsrjvVJJPKmlCJOP10UpYA=
X-Received: by 2002:a05:6870:7251:b0:25e:eab:6d32 with SMTP id
 586e51a60fabf-287109f5e1fmr9949467fac.5.1727755028572; Mon, 30 Sep 2024
 20:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930231443.2560728-1-sashal@kernel.org>
In-Reply-To: <20240930231443.2560728-1-sashal@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 1 Oct 2024 05:56:55 +0200
X-Gmail-Original-Message-ID: <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
Message-ID: <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

This is not stable material and I didn't mark it as such. Do not backport.

