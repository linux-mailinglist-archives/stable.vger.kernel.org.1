Return-Path: <stable+bounces-10942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B77682E278
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 23:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243DB1C21C3B
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E721B59F;
	Mon, 15 Jan 2024 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Km1l1GJK"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A017BDC
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Jan 2024 17:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705356740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=/wboYnHVPJ/8LAI20y6i7i1ldPq2MOfVQ9+Mpi2tCqA=;
	b=Km1l1GJKulz9+ak6SHAawecT/BykeaSdRiBZBfUyULN/2s8rBBspgNvyCn/UNRuwKMhK6g
	2JRrrRQsIq9iCQ/6VjySQUIvnjicuJdpOmFJzoejNlqmo5/8mjFeRlw39GsxZub3Ndm+c7
	IXkKQh2M+hJrMiCm6EIjf03ni4pEdc0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: stable@vger.kernel.org
Subject: fs/bcachefs/
Message-ID: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi stable team - please don't take patches for fs/bcachefs/ except from
myself; I'll be doing backports and sending pull requests after stuff
has been tested by my CI.

Thanks, and let me know if there's any other workflow things I should
know about
-Kent

