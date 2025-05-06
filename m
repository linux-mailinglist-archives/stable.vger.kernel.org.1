Return-Path: <stable+bounces-141824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB041AAC7BE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 16:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB41A3B42C8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16D628003A;
	Tue,  6 May 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSPR8wSl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95722D790;
	Tue,  6 May 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541321; cv=none; b=B+2w/bF5i1XroP4Daog37HqGJ54IDWqIy6kiUjOSmZiFo3C7EAM9XcdOc1jgtm8cmN6ZBSAN97otiWAKfE3ZIoRi8Rg5HbShVRUoUbWnFqaYLgsaV26JIhAU1g546PGcAF0I4Oerc5laY4PfGM8CB3VA7jGXxUWEazT+WYL1Izs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541321; c=relaxed/simple;
	bh=Ie/sO3/eff9V0WMmH8p0giRXqNQeCItCAyv/TN8xzEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wx3OL2OVgs1ZgO0/fTg1P7cPcVc4fNZ2HeQF9Csk2KdUtiugL1rJaE6vcj9fidE5X3iZrTVYMtQtR83HTEqMB7xM4DjST8qCSuDP2oHdRziiRzHCR5n8SVoAsmF9KKEeq7J6bOwJRHCFEOiJ7qpUxCIoqfmi6TpImwGE2+r/yZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSPR8wSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE76FC4CEE4;
	Tue,  6 May 2025 14:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746541321;
	bh=Ie/sO3/eff9V0WMmH8p0giRXqNQeCItCAyv/TN8xzEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uSPR8wSlUKvmAukA7pNhCBERWwcJ7ejEEwPFsBCvfnwSKJRnqfg1ekgWgAMjG2tJC
	 Q/QnCaD9vCpq4HG4cispG0/ZL2gpxupdsM8PJg8ZN3p6agpMRdAVEk+b9qOvRSC8Gq
	 uXBxtA/FhuDrE3O5EK9f94OUzEIVrzY7UUSZJjAQE8f1h/mYQwzhz5lDbDDTWW+lhM
	 AJV/pijwqgoSQHvRN8P/mfV47p3Df6K3tWcw3p8xL/7h58Z9DNBhXfgY+fOeehDekR
	 Ar0+CpzSIJpvtYwwtPFmoyIaYpS8FkBBe/+DG17Fy9OSiSVgsbQuqqwB1eUPlmiTj2
	 pd/jMBpnpEHgA==
Date: Tue, 6 May 2025 07:21:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [ANNOUNCE] AUTOSEL: Modern AI-powered Linux Kernel Stable
 Backport Classifier
Message-ID: <20250506072159.520ff0d5@kernel.org>
In-Reply-To: <aBj_SEgFTXfrPVuj@lappy>
References: <aBj_SEgFTXfrPVuj@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 May 2025 14:11:20 -0400 Sasha Levin wrote:
> - Detailed explanations of backporting decisions

Are those available publicly or just to the person running the tool?
I was scratching my hard quite a bit on the latest batch.

> - Extensive test coverage and validation

Would be great to hear more. My very subjective feeling is that 
the last batch of AUTOSEL is much worse than the previous.
Easily 50% of false positives.

