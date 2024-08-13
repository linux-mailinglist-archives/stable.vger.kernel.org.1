Return-Path: <stable+bounces-67537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4BC950C6B
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 20:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F6AB24D04
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B61C1A3BA3;
	Tue, 13 Aug 2024 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DEamUC5Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5131A38F3;
	Tue, 13 Aug 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574433; cv=none; b=I15+OkWX1TVj1M/+JNft5qSKJkSq8ktzzEBFp11LTE9VFll5kZl9RGhQlGqM9f21rqVHlYSTsXA9+6Twcc01+Ev4Qt/sq9E32G9fZ/8J7YUaaj/l8T1gdY9zfEJtrcX02JP6YC9iPM0XvpIK3yDDjBjwG+jjYneLcfuUmM+8giw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574433; c=relaxed/simple;
	bh=v4D2oFCn1kEwDv4cV+j+R1PCEkjteSaxolOXeMt2Hvg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BVDB9b334hZ+HgbBO7c+9pQKtUWncwWgQZ/dpuG+HLEuTaIewEueH+rl+Rws+uttOo7mHXXl50BoQv0dlwWQrwBFyIMER1Pm8p7ovR3YIWzYAju1uV3SFgeTJ5oSUaOciv95OYvRlxFD15K2eOKw+6CJHCxh7NN3YSFZsnmHZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DEamUC5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF66C4AF0C;
	Tue, 13 Aug 2024 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723574430;
	bh=v4D2oFCn1kEwDv4cV+j+R1PCEkjteSaxolOXeMt2Hvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DEamUC5Q5DSXHIJRPkeZAutDzcEnWZ/0fbRoKy33Lm0VCLXd6SqHT90dOEONs9dm3
	 aQlGmEVtJTbAflViU4zd7BOv3pdKr6KS7ehsNtSlKf335qCDKt24+tpBWu0GbiYZvC
	 d529DQ9q4E6U2WwO8C3Mcpf4NZecf2uUd3b7w4WY=
Date: Tue, 13 Aug 2024 11:40:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, david@redhat.com, vbabka@suse.cz,
 pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] alloc_tag: mark pages reserved during CMA
 activation as not tagged
Message-Id: <20240813114029.4bc61d6fe731a533eb88ba64@linux-foundation.org>
In-Reply-To: <20240813150758.855881-2-surenb@google.com>
References: <20240813150758.855881-1-surenb@google.com>
	<20240813150758.855881-2-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 08:07:57 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved pages as empty")

I copied this into [1/2] so everything lands nicely.

