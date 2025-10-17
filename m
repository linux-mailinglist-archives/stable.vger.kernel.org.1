Return-Path: <stable+bounces-187084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754AFBEA511
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F7A7C5A55
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C0632E13C;
	Fri, 17 Oct 2025 15:31:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4632C951
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715075; cv=none; b=oEAxzrdh9zxoukIL9VRbS9Zaa8hZ++zp4EbLJX+jUU6wSXXR981nVw5PbTvjJAw77JCMKUtn1wg5tHoIlNgMtEnnjr/R3eGUhztCEWFym7EGsq2eLaKhRK5HDuB46gCVY6uK5v7TvCb2tQGaxMfOCGeWr7zQ8mKqx5KXnitOHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715075; c=relaxed/simple;
	bh=ffS6PXUnt6EfTkl2I6ZLZYrP5Zn03A0FDnFwL61InM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViVpvDiit7YrYcSk7AR8o85tKWuMJahZrILIspatmm8dX/h+e0TbF3kR3X0RWUb0WDi47JYLheFkyQzZT79d8fPPPLIzh8ZAy0I1RGqlXW+N2A9FsTYIhXW8kQBtTjb624GGDdi2ShX5r4BcvvPht+LzXNwZmq6VYMiXEp7BV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAB3C4CEFE;
	Fri, 17 Oct 2025 15:31:14 +0000 (UTC)
Date: Fri, 17 Oct 2025 16:31:11 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Gergely Kovacs <Gergely.Kovacs2@arm.com>,
	Will Deacon <will@kernel.org>, David Hildenbrand <david@redhat.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 5.15.y] arm64: mte: Do not flag the zero page as
 PG_mte_tagged
Message-ID: <aPJhP0LrBwSHeJy0@arm.com>
References: <2025101647-segment-boney-64c3@gregkh>
 <20251017124020.3888332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017124020.3888332-1-sashal@kernel.org>

On Fri, Oct 17, 2025 at 08:40:20AM -0400, Sasha Levin wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> [ Upstream commit f620d66af3165838bfa845dcf9f5f9b4089bf508 ]

Thanks Sasha for the backports. It saved me some time.

-- 
Catalin

