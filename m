Return-Path: <stable+bounces-111983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FF7A252E4
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 08:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CF7163C99
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 07:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9073597F;
	Mon,  3 Feb 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U/NgaN4D"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5E25A623
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738566920; cv=none; b=Ygc4NXbxDEk5LRPz3N+msrG2ps+52gYm8IrJ/W7I/0b2WDTvu8yGGq9oi4d8yFh2g9mV8A1SJd191lZ3pgjI/8x7Uk6HKsxM8795qqSrli1L3+b0H9EwibXSaiJxqjnvHyLrYyDz4c/Mn54i27TYJXW9TT8NFxGcs5KJtF8AVu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738566920; c=relaxed/simple;
	bh=jw6+U8xlaNUjsd6UhP8mD8J3nq2hkDmfGrkHGo76Ops=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J3nV9kWDQSpkUj+JJBjxDY5cFye+iZruVAHzeI2kcxiKKYD4x+aZtgRnWv/VO+1eKYQCWGdZEL2XVkLIeiKeCP4JK+mHi0G4jN/WhZcUydynbFjvauaYiO/sa0ExpQA99T815+RAFsRNsnb0x+tNj9Rm+tghwnSyp3x6zdiNR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=U/NgaN4D; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jw6+U8xlaNUjsd6UhP8mD8J3nq2hkDmfGrkHGo76Ops=; b=U/NgaN4DEOjYsIEpgbnGiLAhlx
	TOwoLcgMcxALccqvidIh40Vb7GCQTpYM7tgBZAe9ksbTPK/1O+b4e2tP/DIOew83hn5Gg1Lw1lLKv
	Yo/adSR2L0ijp5UbG7rjjID+U0mcOtQxbk0/tvg1H3EJDkpBaauiZ7Ds43JZiYIyyDB3Gt9LLMaEP
	fGKToifJLOZyC3+j8q/pYQtZEIkerard1CoK/2ycHtxhQ+3nxLNyJJCs9kH/SbaG0sOe6PHEW12+e
	eJXj9Yg3j4C7KaXcraFv1FASDEOJs3DOwberbD0y1Gcrcv/oe00oTmPq6iCmAvJtmCt4a18fx+MAU
	BUOgFIYg==;
Received: from 253.red-79-144-234.dynamicip.rima-tde.net ([79.144.234.253] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1teqfU-002vbB-N6; Mon, 03 Feb 2025 08:14:58 +0100
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: riel@surriel.com, linux-mm@kvack.org, stable@vger.kernel.org,
 kernel-dev@igalia.com, revest@google.com
Subject: Re: [PATCH] mm,madvise,hugetlb: check for 0-length range after end
 address adjustment
In-Reply-To: <20250131142321.632a9468529d3267abe641af@linux-foundation.org>
References: <20250131143749.1435006-1-rcn@igalia.com>
 <20250131142321.632a9468529d3267abe641af@linux-foundation.org>
Date: Mon, 03 Feb 2025 08:14:57 +0100
Message-ID: <87ldunxzwu.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Andrew,

On Fri, Jan 31 2025 at 14:23:21, Andrew Morton <akpm@linux-foundation.org> wrote:

> Perhaps add a comment telling the user how this situation can come about?

Sure, I'll add the description to v2. Thanks for reviewing it!

Ricardo

