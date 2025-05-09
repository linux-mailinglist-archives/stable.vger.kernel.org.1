Return-Path: <stable+bounces-143066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C25BAB1CAD
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 20:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3DA0507A01
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9DA239E9E;
	Fri,  9 May 2025 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastemail60.com header.i=@fastemail60.com header.b="ik2tvGqC"
X-Original-To: stable@vger.kernel.org
Received: from mail.fastemail60.com (mail.fastemail60.com [102.222.20.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EEB23C8DB
	for <stable@vger.kernel.org>; Fri,  9 May 2025 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=102.222.20.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816641; cv=none; b=E0xv6M1UI3fpIzWcSmsr7w252Lj+3DXxks2GKxX7kKwdPI9ld8UUijq2NuXerkiEFEbOgMppkObQ2qVFUztA0/iT7ie0/hvPyG+KwN3BxzI0EMGJ4EpCNo2DeMdhknJ3KJZh7YBWHag1xThD9kOC+goYEUiD7bVOKZAFaZa8QdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816641; c=relaxed/simple;
	bh=0kM12Ki2v7eI61I1WvQrX7nQw+DKE1uiGUA45uahRZc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CuVD+68HzIQsu+E3hxMrT0LsUhyqIyMW7cgc21Nin9Y3CdJ6OS4DzyvaBfdMwnwMvbMmBR5cym9eGHvPiYTzlgHW0f7yC4eiMdCmS6v1WU6/pq08aYTFR1QdasdEIMieaywxPE0fc5MTqfcCuzGJnfdvc11JCM5nwdqwXLr39lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fastemail60.com; spf=none smtp.mailfrom=fastemail60.com; dkim=pass (2048-bit key) header.d=fastemail60.com header.i=@fastemail60.com header.b=ik2tvGqC; arc=none smtp.client-ip=102.222.20.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fastemail60.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fastemail60.com
Received: from fastemail60.com (unknown [194.156.79.202])
	by mail.fastemail60.com (Postfix) with ESMTPA id 4E9DE87BDE4
	for <stable@vger.kernel.org>; Fri,  9 May 2025 15:54:58 +0200 (SAST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.fastemail60.com 4E9DE87BDE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastemail60.com;
	s=202501; t=1746798900;
	bh=0kM12Ki2v7eI61I1WvQrX7nQw+DKE1uiGUA45uahRZc=;
	h=Reply-To:From:To:Subject:Date:From;
	b=ik2tvGqCwPwZ953LcO9Bri297wpgr2aJqAyVcyAKhFsYp1T2TKCOaFoF3x8nrcW/u
	 zpyrkCiLPf798PmkErZPA5TgEXKV4pwaqP4jZJNY3e1mOtXeeuCQRmqDrAt9oxy/3P
	 TiEeGSfzqtQTscz6aNWlYYYWfpG7ZKnVCYvlWx8SOkSphldtUkDxR0Jpz85ipupm/M
	 IHczrJRmCKrRVoOC0ssJbRvuWfGbDfLOCLlJZNcmaBE3aEa3JlRmp36BWJbkj5bkCr
	 ZYwzC5rOPpWFraskrUD0Dq9sid3MJ4bNHR0uK1fKBfbmb7bBaVQQ8Pn9Iolpb5v6IF
	 gPLBYYdVm5tJQ==
Reply-To: import@herragontradegroup.cz
From: Philip Burchett<info@fastemail60.com>
To: stable@vger.kernel.org
Subject: Inquiry
Date: 09 May 2025 09:54:57 -0400
Message-ID: <20250509095457.DF0CDA06313D7C32@fastemail60.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (mail.fastemail60.com [0.0.0.0]); Fri, 09 May 2025 15:55:00 +0200 (SAST)

Greetings, Supplier.

Please give us your most recent catalog; we would want to order=20
from you.

I look forward to your feedback.


Philip Burchett

