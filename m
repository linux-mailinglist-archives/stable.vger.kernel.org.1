Return-Path: <stable+bounces-142098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7E0AAE5A0
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1C53AC602
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AE628B7F1;
	Wed,  7 May 2025 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwWhw9JT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D74B1E7D;
	Wed,  7 May 2025 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633262; cv=none; b=Xy+4sRlNbmb02rYx4VBcWsAbmr6CNMajdEDHBZ2EYm9HL1a88aBs4/2InIdsU+Hoj6BaKRcKtkx7vs5OjLyuVSSngUG1dacqDDWn0bvVyRcXfl8DE6ibha8nHgcrQj+QeoYzH6wuR+3i1tcEQGKuf4cN995zyEFrePE1eeA7RZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633262; c=relaxed/simple;
	bh=K9OE8OEXlPZXEmg5GbdWwtqBCZ3vcedpENFO1w3sECw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F812K8R/3U8QD50HE83QjET/XcPuR14QvCskwj+lAUrCbcLqOduLCghxmKtHpO7nS3R3tBsJ1japzkxwA44Tx559cTd8LwbFN90Pnv0oYfO7wQqWxNMKQMYFGAQKSM4nV9KOtc0tL2AmYfaxi9Lrhs/GHQ97mUmFE4No1UMXWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwWhw9JT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125B4C4CEE2;
	Wed,  7 May 2025 15:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746633262;
	bh=K9OE8OEXlPZXEmg5GbdWwtqBCZ3vcedpENFO1w3sECw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MwWhw9JTrTj2vgbBrayonYFNjGfMteHJJqAQYW3Olv/HRt7w2l/5eGx8mRuM7rVjt
	 VhBfbvmdVZ+eFJgpa2C3d9q6Dbh+BmFCuJJnJfSScYziL8aAsGQevi7yiKB3ChwGyX
	 Wl0wGXIwlLjWgqPJ+k52Cpaa/40ZjQUGg0JKstrXQixUXkOgXTPbX1n1r5necT6pk8
	 cb6FDXxUkVZjno+62sOpo9UmEkx2t45HO2I5HS19C00zSWIMw6QNRtJW5UXZC9dbWy
	 TmIM2EBPcfanNgOOe9/xe2J47tqgRpevUrVKr/Enz/YThD6AlTlOAjPnHlQKSDICs5
	 kzI769rrvdbQA==
Date: Wed, 7 May 2025 08:54:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [ANNOUNCE] AUTOSEL: Modern AI-powered Linux Kernel Stable
 Backport Classifier
Message-ID: <20250507085421.7fefd093@kernel.org>
In-Reply-To: <aBt3D3z0Ayn6R_YO@lappy>
References: <aBj_SEgFTXfrPVuj@lappy>
	<20250506072159.520ff0d5@kernel.org>
	<aBt3D3z0Ayn6R_YO@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 May 2025 11:06:55 -0400 Sasha Levin wrote:
> On Tue, May 06, 2025 at 07:21:59AM -0700, Jakub Kicinski wrote:
> >On Mon, 5 May 2025 14:11:20 -0400 Sasha Levin wrote:  
> >> - Detailed explanations of backporting decisions  
> >
> >Are those available publicly or just to the person running the tool?
> >I was scratching my hard quite a bit on the latest batch.  
> 
> Yup, it presents it to the person running the tool. In theory you can
> always go back and re-run whatever commit you'd like with the same query
> and get a very similar explanation, so I didn't consider storing the
> results.

Injecting the explanation under the --- separator in the AUTOSEL email
would be ideal, but not sure how hard that is to arrange.

> >> - Extensive test coverage and validation  
> >
> >Would be great to hear more. My very subjective feeling is that
> >the last batch of AUTOSEL is much worse than the previous.
> >Easily 50% of false positives.  
> 
> "last batch" as in the big one I've sent out on Monday, or the small one
> I sent on Tuesday?

The big one on Monday.

